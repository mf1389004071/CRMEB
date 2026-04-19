#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
从 template/uni-app/pages.json 生成 utils/navigationBarI18nMap.js
主包：第一个 "pages": [ ... ]（在 "subPackages" 之前）
分包：每个 "root" + 其下 "pages": [ ... ] 内条目 path 与 root 拼接
"""
from __future__ import annotations

import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
PAGES_JSON = ROOT / "template" / "uni-app" / "pages.json"
OUT_FILE = ROOT / "template" / "uni-app" / "utils" / "navigationBarI18nMap.js"


def extract_bracket_array(text: str, open_pos: int) -> tuple[str, int] | None:
    """text[open_pos] == '['，返回 (数组内部文本, 闭合 ] 后一字符下标)。"""
    if open_pos >= len(text) or text[open_pos] != "[":
        return None
    depth = 0
    for j in range(open_pos, len(text)):
        c = text[j]
        if c == "[":
            depth += 1
        elif c == "]":
            depth -= 1
            if depth == 0:
                return text[open_pos + 1 : j], j + 1
    return None


def scan_pages_array_body(body: str, route_prefix: str) -> tuple[dict[str, str], set[str]]:
    """
    body 为 pages 数组内部（不含外层 []）。
    route_prefix 如 '' 主包 path 已是全路径；分包为 'pages/goods'（无尾斜杠）。
    """
    titles: dict[str, str] = {}
    skip: set[str] = set()
    idx = 0
    n = len(body)
    while idx < n:
        pm = re.search(r'"path"\s*:\s*"([^"]+)"', body[idx:])
        if not pm:
            break
        rel = pm.group(1)
        seg_start = idx + pm.end()
        pn = re.search(r'"path"\s*:\s*"', body[seg_start:])
        if pn:
            segment = body[seg_start : seg_start + pn.start()]
            next_idx = seg_start + pn.start()
        else:
            segment = body[seg_start:]
            next_idx = n
        full = rel if rel.startswith("pages/") else f"{route_prefix}/{rel}".replace("//", "/")
        if re.search(r'"navigationStyle"\s*:\s*"custom"', segment):
            skip.add(full)
            idx = next_idx
            continue
        tm = re.search(r'"navigationBarTitleText"\s*:\s*"([^"]*)"', segment)
        if tm:
            title = tm.group(1)
            if title.strip():
                titles[full] = title
        idx = next_idx
    return titles, skip


def main() -> int:
    if not PAGES_JSON.is_file():
        print("找不到", PAGES_JSON, file=sys.stderr)
        return 1
    text = PAGES_JSON.read_text(encoding="utf-8")
    titles: dict[str, str] = {}
    skip: set[str] = set()

    # 主包：subPackages 之前的第一个 "pages":[
    head, sep, tail = text.partition('"subPackages"')
    m = re.search(r'"pages"\s*:\s*\[', head)
    if not m:
        print("未找到主包 pages 数组", file=sys.stderr)
        return 1
    arr_open = m.end() - 1  # position of [
    inner = extract_bracket_array(head, arr_open)
    if not inner:
        print("主包 pages 数组未闭合", file=sys.stderr)
        return 1
    body, _ = inner
    t, s = scan_pages_array_body(body, "")
    titles.update(t)
    skip.update(s)

    # 分包：每个 root 后紧跟的 "pages": [ ... ]
    for rm in re.finditer(r'"root"\s*:\s*"([^"]+)"', tail):
        root = rm.group(1).rstrip("/")
        sub = tail[rm.end() :]
        pm = re.search(r'"pages"\s*:\s*\[', sub)
        if not pm:
            continue
        abs_open = rm.end() + pm.end() - 1
        inner2 = extract_bracket_array(tail, abs_open)
        if not inner2:
            continue
        body2, _ = inner2
        t2, s2 = scan_pages_array_body(body2, root)
        titles.update(t2)
        skip.update(s2)

    esc = lambda s: s.replace("\\", "\\\\").replace("'", "\\'")

    lines_out = [
        "/**",
        " * 由 scripts/gen_navigation_bar_i18n_map.py 从 pages.json 生成，勿手改。",
        " * 键：getCurrentPages 最后一页的 route（无 leading /）。",
        " * 值：pages.json 中 navigationBarTitleText，用作 this.$t(值)。",
        " * 重新生成：python scripts/gen_navigation_bar_i18n_map.py",
        " */",
        "",
        "export const NAVIGATION_BAR_CUSTOM_ROUTES = new Set([",
    ]
    for r in sorted(skip):
        lines_out.append(f"  '{esc(r)}',")
    lines_out.extend(["]);", "", "export const NAVIGATION_BAR_TITLE_MAP = {"])
    for route in sorted(titles.keys()):
        lines_out.append(f"  '{esc(route)}': '{esc(titles[route])}',")
    lines_out.extend(["};", ""])

    OUT_FILE.parent.mkdir(parents=True, exist_ok=True)
    OUT_FILE.write_text("\n".join(lines_out), encoding="utf-8")
    print(f"写入 {OUT_FILE}，标题 {len(titles)} 条，custom 跳过 {len(skip)} 条。")
    return 0


if __name__ == "__main__":
    sys.exit(main())
