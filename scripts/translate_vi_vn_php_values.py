# -*- coding: utf-8 -*-
"""
仅翻译 crmeb/app/lang/vi_vn.php 中每行 `=>` 之后单引号包裹的字符串内容（中文 -> 越南语），
其余字符（键、空白、逗号、行尾注释等）保持不变。

增强：每完成 10 条翻译任务写回文件一次；每条任务打印一行日志（含源文与译文）。
已译成越南语（值中无 CJK）的行会自动跳过，可反复执行脚本续跑。
"""
from __future__ import annotations

import re
import sys
import time
from pathlib import Path

try:
    from deep_translator import GoogleTranslator
except ImportError:
    print("请先安装: pip install deep-translator", file=sys.stderr)
    sys.exit(1)

ROOT = Path(__file__).resolve().parents[1]
TARGET = ROOT / "crmeb" / "app" / "lang" / "vi_vn.php"

SAVE_EVERY = 10

# 含中日韩统一表意文字则视为需翻译的中文文案（越南文本身不含这些）
_CJK_RE = re.compile(r"[\u4e00-\u9fff]")


def _ensure_utf8_stdout() -> None:
    if hasattr(sys.stdout, "reconfigure"):
        try:
            sys.stdout.reconfigure(encoding="utf-8", errors="replace")
        except Exception:
            pass
    if hasattr(sys.stderr, "reconfigure"):
        try:
            sys.stderr.reconfigure(encoding="utf-8", errors="replace")
        except Exception:
            pass


def has_cjk(s: str) -> bool:
    return _CJK_RE.search(s) is not None


def php_single_unescape(src: str) -> str:
    """PHP 单引号字符串体内的转义还原为 Python 字符串。"""
    out: list[str] = []
    i = 0
    n = len(src)
    while i < n:
        if src[i] == "\\" and i + 1 < n:
            out.append(src[i + 1])
            i += 2
        else:
            out.append(src[i])
            i += 1
    return "".join(out)


def php_single_escape(s: str) -> str:
    """写入 PHP 单引号字符串所需的转义。"""
    return s.replace("\\", "\\\\").replace("'", "\\'")


def split_arrow_single_quoted_value(line: str) -> tuple[str, str, str] | None:
    """
    若本行为 `... => '...' , ...` 形式，返回 (head, inner_raw, tail)。
    head 不含值的开引号；tail 为闭引号之后的全部内容（含逗号、注释等）。
    """
    if "=>" not in line:
        return None
    idx = line.index("=>")
    pos = idx + 2
    while pos < len(line) and line[pos] in " \t":
        pos += 1
    if pos >= len(line) or line[pos] != "'":
        return None
    head = line[:pos]
    i = pos + 1
    inner_chars: list[str] = []
    while i < len(line):
        c = line[i]
        if c == "\\" and i + 1 < len(line):
            inner_chars.append(c)
            inner_chars.append(line[i + 1])
            i += 2
            continue
        if c == "'":
            inner_raw = "".join(inner_chars)
            tail = line[i + 1 :]
            return head, inner_raw, tail
        inner_chars.append(c)
        i += 1
    return None


def translate_unique(texts: list[str], batch_size: int = 60) -> dict[str, str]:
    translator = GoogleTranslator(source="zh-CN", target="vi")
    mapping: dict[str, str] = {}
    unique = list(dict.fromkeys(texts))
    total = len(unique)
    for start in range(0, len(unique), batch_size):
        chunk = unique[start : start + batch_size]
        end = min(start + len(chunk), total)
        print(f"[API] 批量翻译进度 {end}/{total} …", flush=True)
        try:
            out = translator.translate_batch(chunk)
        except Exception:
            out = []
            for t in chunk:
                try:
                    out.append(translator.translate(t))
                except Exception as e:
                    print(f"翻译失败，保留原文: {t[:40]}... 错误: {e}", file=sys.stderr)
                    out.append(t)
                time.sleep(0.15)
        if len(out) != len(chunk):
            out = []
            for t in chunk:
                try:
                    out.append(translator.translate(t))
                except Exception:
                    out.append(t)
                time.sleep(0.1)
        for a, b in zip(chunk, out):
            mapping[a] = b
        time.sleep(0.25)
    return mapping


def write_target(lines: list[str]) -> None:
    TARGET.write_text("".join(lines), encoding="utf-8")


def main() -> int:
    _ensure_utf8_stdout()

    if not TARGET.is_file():
        print(f"找不到文件: {TARGET}", file=sys.stderr)
        return 1
    raw = TARGET.read_text(encoding="utf-8")
    lines = raw.splitlines(keepends=True)

    jobs: list[tuple[int, str, str, str]] = []
    to_translate: list[str] = []

    for li, line in enumerate(lines):
        sp = split_arrow_single_quoted_value(line)
        if sp is None:
            continue
        head, inner_raw, tail = sp
        inner_text = php_single_unescape(inner_raw)
        if not has_cjk(inner_text):
            continue
        jobs.append((li, head, inner_raw, tail))
        to_translate.append(inner_text)

    if not jobs:
        print("没有需要翻译的中文值（或已全部为越南语）。")
        return 0

    uniq_count = len(dict.fromkeys(to_translate))
    print(f"待翻译不重复文案 {uniq_count} 条，共 {len(jobs)} 行；每 {SAVE_EVERY} 行写回文件。")

    mapping = translate_unique(to_translate)

    for n_done, (li, head, inner_raw, tail) in enumerate(jobs, start=1):
        inner_text = php_single_unescape(inner_raw)
        vi = mapping.get(inner_text, inner_text)
        new_inner_raw = php_single_escape(vi)
        lines[li] = head + "'" + new_inner_raw + "'" + tail

        print(
            f"[{n_done}/{len(jobs)}] 文件行 {li + 1}: {inner_text} => {vi}",
            flush=True,
        )

        if n_done % SAVE_EVERY == 0:
            write_target(lines)
            print(f"--- 已保存（已完成 {n_done} 条）---", flush=True)

    if len(jobs) % SAVE_EVERY != 0:
        write_target(lines)
        print(f"--- 最终保存（共 {len(jobs)} 条）---", flush=True)

    print(f"已写回: {TARGET}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
