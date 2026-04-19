#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
递归扫描 template/uni-app 下 .vue / .js，将「引号内的中文」且未被 $t / this.$t / i18n.t 包裹的字符串
替换为国际化调用。

默认 dry-run，仅打印将修改的文件；加 --apply 才写盘。

词条需写入后台「多语言 / lang_code」（is_admin=0），由 get_lang_json 下发给前端；与 ThinkPHP
vendor 下 zh-cn.php 无直接关系。可用 --emit-keys PATH 导出本次扫描到的中文 key（一行一条），便于录入数据库。

注意：
- 不处理 pages.json / manifest.json（非脚本，需单独策略）。
- 保守跳过：含 ${ 的模板字符串、import 行、console. 行、部分第三方目录。
- 自动替换无法覆盖所有场景，apply 后请 git diff 人工复核。
"""
from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path

CHINESE_RE = re.compile(r"[\u4e00-\u9fff]")


def sql_string_literal(s: str) -> str:
    """MySQL 字符串内单引号转义为两个单引号。"""
    return s.replace("\\", "\\\\").replace("'", "''")


def emit_lang_code_sql(
    keys: set[str],
    out_path: Path,
    *,
    table: str,
    type_id: int,
) -> int:
    """生成写入 eb_lang_code 的幂等 INSERT（仅 is_admin=0 商城文案）。"""
    keys_sorted = [k for k in sorted(keys) if k and CHINESE_RE.search(k)]
    lines = [
        "-- 由 scripts/i18n_scan_uni_app.py 生成",
        "-- 执行前请确认：1) 表名与 .env 中 DB_PREFIX 一致；2) type_id 对应简体中文（一般为 1，以 eb_lang_type 为准）",
        f"-- 目标表: `{table}`  type_id={type_id}  is_admin=0",
        "START TRANSACTION;",
        "",
    ]
    for k in keys_sorted:
        esc = sql_string_literal(k)
        lines.append(
            f"INSERT INTO `{table}` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)\n"
            f"SELECT {type_id}, '{esc}', '{esc}', '{esc}', 0\n"
            f"FROM DUAL\n"
            f"WHERE NOT EXISTS (SELECT 1 FROM `{table}` WHERE `type_id` = {type_id} AND `code` = '{esc}' AND `is_admin` = 0);\n"
        )
    lines.extend(["", "COMMIT;", ""])
    out_path.parent.mkdir(parents=True, exist_ok=True)
    out_path.write_text("\n".join(lines), encoding="utf-8")
    return len(keys_sorted)

# 默认不扫描的目录名（相对 uni-app 根）
DEFAULT_SKIP_DIRS = frozenset(
    {
        "unpackage",
        "node_modules",
        "uni_modules",
        "static",
        ".git",
    }
)

# 不处理的文件（避免破坏自身或构建产物）
DEFAULT_SKIP_FILES = frozenset(
    {
        "lang.js",
        "main.js",  # 启动入口，误替换风险高，如需可去掉
        "App.vue",  # 全局启动、版权提示等，建议手工处理；需扫描时从列表移除
    }
)

SKIP_SUBPATH_MARKERS = (
    "/unpackage/",
    "/node_modules/",
    "/uni_modules/",
    "/static/",
)


def should_skip_path(path: Path, uni_root: Path) -> bool:
    rel = path.relative_to(uni_root)
    parts = rel.parts
    if any(p in DEFAULT_SKIP_DIRS for p in parts):
        return True
    s = str(path).replace("\\", "/")
    if any(m in s for m in SKIP_SUBPATH_MARKERS):
        return True
    if path.name in DEFAULT_SKIP_FILES:
        return True
    # 体积很大的解析组件，误替换风险高
    if path.name == "jyf-parser.vue":
        return True
    return False


def strip_line_comment(line: str) -> str:
    """去掉行尾 // 注释（粗略，不处理字符串内的 //）。"""
    in_s = in_d = in_bt = False
    escape = False
    i = 0
    n = len(line)
    while i < n:
        c = line[i]
        if escape:
            escape = False
            i += 1
            continue
        if c == "\\" and (in_s or in_d or in_bt):
            escape = True
            i += 1
            continue
        if not in_s and not in_d and not in_bt:
            if c == "'":
                in_s = True
            elif c == '"':
                in_d = True
            elif c == "`":
                in_bt = True
            elif c == "/" and i + 1 < n and line[i + 1] == "/":
                return line[:i].rstrip()
        else:
            if in_s and c == "'":
                in_s = False
            elif in_d and c == '"':
                in_d = False
            elif in_bt and c == "`":
                in_bt = False
        i += 1
    return line


def is_wrapped_by_t_call(prefix_before_quote: str) -> bool:
    s = prefix_before_quote.rstrip()
    if not s or s[-1] != "(":
        return False
    s = s[:-1].rstrip()
    if re.search(r"this\.\$t\s*$", s):
        return True
    if re.search(r"(?:^|[^\w$])\$t\s*$", s):
        return True
    if re.search(r"i18n\.t\s*$", s):
        return True
    return False


def iter_quoted_spans(line: str):
    """
    产出 (start, end_exclusive, quote, inner) 单/双引号字符串；
    以及不含 ${ 的简单反引号字符串（含中文时）。
    """
    i = 0
    n = len(line)
    while i < n:
        c = line[i]
        if c in "'\"":
            q = c
            start = i
            i += 1
            buf: list[str] = []
            while i < n:
                if line[i] == "\\" and i + 1 < n:
                    buf.append(line[i : i + 2])
                    i += 2
                    continue
                if line[i] == q:
                    inner = "".join(buf)
                    yield start, i + 1, q, inner
                    i += 1
                    break
                buf.append(line[i])
                i += 1
                continue
            continue
        if c == "`":
            start = i
            i += 1
            buf = []
            while i < n:
                if line[i] == "\\" and i + 1 < n:
                    buf.append(line[i : i + 2])
                    i += 2
                    continue
                if line[i] == "`":
                    inner = "".join(buf)
                    if "${" not in inner and CHINESE_RE.search(inner):
                        yield start, i + 1, "`", inner
                    i += 1
                    break
                buf.append(line[i])
                i += 1
                continue
            continue
        i += 1


def choose_t_quote(inner: str) -> str:
    """为 $t 参数选择包裹引号，避免与内容冲突。"""
    if "`" not in inner and "\n" not in inner:
        if "'" not in inner:
            return "'"
        if '"' not in inner:
            return '"'
    return "`"


def escape_for_single(inner: str) -> str:
    return inner.replace("\\", "\\\\").replace("'", "\\'")


def escape_for_double(inner: str) -> str:
    return inner.replace("\\", "\\\\").replace('"', '\\"')


def build_t_call(inner: str, *, template_mode: bool) -> str:
    q = choose_t_quote(inner)
    if q == "'":
        body = escape_for_single(inner)
        inner_js = f"'{body}'"
    elif q == '"':
        body = escape_for_double(inner)
        inner_js = f'"{body}"'
    else:
        body = inner.replace("\\", "\\\\").replace("`", "\\`")
        inner_js = f"`{body}`"
    if template_mode:
        return f"$t({inner_js})"
    return f"this.$t({inner_js})"


def build_i18n_t_call(inner: str) -> str:
    q = choose_t_quote(inner)
    if q == "'":
        body = escape_for_single(inner)
        inner_js = f"'{body}'"
    elif q == '"':
        body = escape_for_double(inner)
        inner_js = f'"{body}"'
    else:
        body = inner.replace("\\", "\\\\").replace("`", "\\`")
        inner_js = f"`{body}`"
    return f"i18n.t({inner_js})"


def process_script_line(line: str, *, vue: bool) -> tuple[str, set[str]]:
    """处理 .vue 的 script 或独立 .js 的一行。返回 (新行, 新增中文 key 集合)。"""
    keys: set[str] = set()
    raw = line
    code_only = strip_line_comment(raw)
    suffix = raw[len(code_only) :]
    stripped = code_only.lstrip()
    if not stripped:
        return raw, keys
    if stripped.startswith("import ") or stripped.startswith("export import"):
        return raw, keys
    if "console." in stripped[:20]:
        return raw, keys

    spans = list(iter_quoted_spans(code_only))
    if not spans:
        return raw, keys

    replacements: list[tuple[int, int, str]] = []
    for start, end, quote, inner in spans:
        if not CHINESE_RE.search(inner):
            continue
        prefix = code_only[:start]
        if is_wrapped_by_t_call(prefix):
            continue
        if inner.startswith("http://") or inner.startswith("https://"):
            continue
        if inner.startswith("@/") or inner.startswith("/pages/"):
            continue
        if re.fullmatch(r"[\d\s\-:]+", inner):
            continue

        keys.add(inner)
        if vue:
            new_text = build_t_call(inner, template_mode=False)
        else:
            new_text = build_i18n_t_call(inner)
        replacements.append((start, end, new_text))

    if not replacements:
        return raw, keys

    replacements.sort(key=lambda x: x[0], reverse=True)
    out = code_only
    for start, end, new_text in replacements:
        out = out[:start] + new_text + out[end:]
    return out + suffix, keys


def process_template_line(line: str) -> tuple[str, set[str]]:
    """处理 <template> 内单行：引号内中文 + 静态属性 =\"中文\" -> :attr=$t(...)。"""
    keys: set[str] = set()
    # 1) 静态属性 placeholder="xxx" / placeholder='xxx'（属性名不以 : @ v- 开头）
    def repl_attr(m: re.Match) -> str:
        nonlocal keys
        pre, attr, q, val = m.group(1), m.group(2), m.group(3), m.group(4)
        al = attr.lower()
        if (
            attr.startswith(":")
            or attr.startswith("@")
            or al.startswith("v-")
            or al.startswith("v-bind:")
            or al.startswith("v-slot")
        ):
            return m.group(0)
        if not CHINESE_RE.search(val):
            return m.group(0)
        if "${" in val:
            return m.group(0)
        keys.add(val)
        inner_call = build_t_call(val, template_mode=True)
        return f"{pre}:{attr}={inner_call}"

    line2 = re.sub(
        r"(<[^>]*?\s)([^\s=/>]+)\s*=\s*(['\"])([^'\"]*?[\u4e00-\u9fff][^'\"]*?)\3",
        repl_attr,
        line,
    )

    # 2) 引号字符串中的中文（已在属性处理过的可能重复 — 二次扫描 spans）
    spans = list(iter_quoted_spans(line2))
    replacements = []
    for start, end, quote, inner in spans:
        if not CHINESE_RE.search(inner):
            continue
        prefix = line2[:start]
        if is_wrapped_by_t_call(prefix):
            continue
        if inner.startswith("http") or inner.startswith("@/"):
            continue
        keys.add(inner)
        replacements.append((start, end, build_t_call(inner, template_mode=True)))

    if not replacements and line2 == line:
        return line, keys

    replacements.sort(key=lambda x: x[0], reverse=True)
    out = line2
    for start, end, new_text in replacements:
        out = out[:start] + new_text + out[end:]
    return out, keys


def process_vue_file(path: Path, apply: bool) -> tuple[bool, set[str]]:
    text = path.read_text(encoding="utf-8")
    all_keys: set[str] = set()
    changed_flag = [False]

    def repl_block(m: re.Match) -> str:
        tag = m.group(1).lower()
        attrs = m.group(2)
        inner = m.group(3)
        if tag == "style":
            return m.group(0)
        lines = inner.splitlines(keepends=True)
        new_lines: list[str] = []
        for line in lines:
            if tag == "template":
                nl, ks = process_template_line(line)
            else:
                nl, ks = process_script_line(line, vue=True)
            new_lines.append(nl)
            all_keys.update(ks)
            if nl != line:
                changed_flag[0] = True
        new_inner = "".join(new_lines)
        return f"<{m.group(1)}{attrs}>{new_inner}</{m.group(1)}>"

    new_text = re.sub(
        r"<(template|script|style)([^>]*)>([\s\S]*?)</\1>",
        repl_block,
        text,
        flags=re.IGNORECASE,
    )
    if not changed_flag[0]:
        return False, all_keys
    if apply:
        path.write_text(new_text, encoding="utf-8")
    return True, all_keys


def ensure_i18n_import_js(content: str, path: Path) -> str:
    if "i18n.t(" not in content:
        return content
    if re.search(r'import\s+i18n\s+from\s+["\']@/utils/lang\.js["\']', content):
        return content
    if re.search(r'import\s+i18n\s+from\s+["\']\./lang\.js["\']', content):
        return content
    if re.search(r"import\s+i18n\s+from\s+[\"']\.\./utils/lang\.js[\"']", content):
        return content
    # 在首个 import 前插入
    insert = 'import i18n from "@/utils/lang.js";\n'
    m = re.search(r"^\s*import\s+", content, re.MULTILINE)
    if m:
        pos = m.start()
        return content[:pos] + insert + content[pos:]
    return insert + content


def process_js_file(path: Path, apply: bool) -> tuple[bool, set[str]]:
    text = path.read_text(encoding="utf-8")
    lines = text.splitlines(keepends=True)
    new_lines = []
    all_keys: set[str] = set()
    changed = False
    for line in lines:
        nl, ks = process_script_line(line, vue=False)
        new_lines.append(nl)
        all_keys |= ks
        if nl != line:
            changed = True
    out = "".join(new_lines)
    if "i18n.t(" in out:
        out2 = ensure_i18n_import_js(out, path)
        if out2 != out:
            out = out2
            changed = True
    if changed and apply:
        path.write_text(out, encoding="utf-8")
    return changed, all_keys


def main() -> int:
    ap = argparse.ArgumentParser(description="CRMEB uni-app 中文引号扫描与 i18n 替换")
    ap.add_argument(
        "--root",
        type=Path,
        default=Path(__file__).resolve().parents[1] / "template" / "uni-app",
        help="uni-app 根目录",
    )
    ap.add_argument(
        "--apply",
        action="store_true",
        help="写回 .vue/.js（默认仅 dry-run）",
    )
    ap.add_argument(
        "--emit-keys",
        type=Path,
        default=None,
        metavar="PATH",
        help="将本次扫描到的中文 key 去重排序后写入文本文件（一行一条）",
    )
    ap.add_argument(
        "--emit-sql",
        type=Path,
        default=None,
        metavar="PATH",
        help="生成导入 eb_lang_code 的 SQL（幂等 INSERT，is_admin=0）",
    )
    ap.add_argument(
        "--sql-table",
        default="eb_lang_code",
        help="lang_code 表全名（含前缀），默认 eb_lang_code",
    )
    ap.add_argument(
        "--sql-type-id",
        type=int,
        default=1,
        help="简体中文在 eb_lang_type 中对应的 type_id，默认 1（请与库内实际一致）",
    )
    args = ap.parse_args()
    uni_root: Path = args.root.resolve()
    if not uni_root.is_dir():
        print("根目录不存在:", uni_root, file=sys.stderr)
        return 1

    touched: list[Path] = []
    all_keys: set[str] = set()

    for path in sorted(uni_root.rglob("*")):
        if not path.is_file():
            continue
        if should_skip_path(path, uni_root):
            continue
        if path.suffix.lower() not in (".vue", ".js"):
            continue
        rel = path.relative_to(uni_root)
        try:
            if path.suffix.lower() == ".vue":
                ch, ks = process_vue_file(path, apply=args.apply)
            else:
                ch, ks = process_js_file(path, apply=args.apply)
        except Exception as e:
            print(f"[错误] {rel}: {e}", file=sys.stderr)
            continue
        all_keys |= ks
        if ch:
            touched.append(path)
            print(f"{'[写入] ' if args.apply else '[将修改] '}{rel}")

    if args.emit_keys and all_keys:
        keys_sorted = sorted(k for k in all_keys if k and CHINESE_RE.search(k))
        args.emit_keys.parent.mkdir(parents=True, exist_ok=True)
        args.emit_keys.write_text("\n".join(keys_sorted) + ("\n" if keys_sorted else ""), encoding="utf-8")
        print(f"[keys] 已写入 {args.emit_keys}（共 {len(keys_sorted)} 条）")

    if args.emit_sql is not None:
        n = emit_lang_code_sql(
            all_keys,
            args.emit_sql,
            table=args.sql_table,
            type_id=args.sql_type_id,
        )
        print(f"[sql] 已写入 {args.emit_sql}（共 {n} 条 INSERT 片段）")

    print(f"完成：涉及文件 {len(touched)} 个；累计中文 key {len(all_keys)} 条。")
    if not args.apply and touched:
        print("提示：确认无误后追加参数 --apply 写盘。")
    return 0


if __name__ == "__main__":
    sys.exit(main())
