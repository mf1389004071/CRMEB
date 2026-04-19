#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
将「缺失 i18n key」列表（一行一条，或 JSON 数组）转为 eb_lang_code 的 INSERT SQL。

示例：
  python scripts/i18n_missing_keys_to_sql.py --input keys.txt --emit-sql out.sql
  python scripts/i18n_missing_keys_to_sql.py --input C:\data\code\crmeb\crmeb_cjx\scripts\keys.txt --emit-sql out.sql
  type keys.txt | python scripts/i18n_missing_keys_to_sql.py --input - --emit-sql out.sql
"""
from __future__ import annotations

import argparse
import sys
from pathlib import Path

from i18n_lang_code_sql import emit_lang_code_sql, load_keys_from_text


def main() -> int:
    ap = argparse.ArgumentParser(description="缺失 i18n key 列表 → lang_code SQL")
    ap.add_argument(
        "--input",
        "-i",
        required=True,
        help="输入文件路径，或 - 表示从 stdin 读取",
    )
    ap.add_argument(
        "--emit-sql",
        "-o",
        type=Path,
        required=True,
        help="输出 SQL 文件路径",
    )
    ap.add_argument("--sql-table", default="eb_lang_code", help="表全名（含前缀）")
    ap.add_argument("--sql-type-id", type=int, default=1, help="简体中文 type_id")
    args = ap.parse_args()

    if args.input == "-":
        text = sys.stdin.read()
    else:
        p = Path(args.input)
        if not p.is_file():
            print("找不到输入文件:", p, file=sys.stderr)
            return 1
        text = p.read_text(encoding="utf-8")

    keys = load_keys_from_text(text)
    if not keys:
        print("未解析到任何 key", file=sys.stderr)
        return 1

    n = emit_lang_code_sql(
        keys,
        args.emit_sql,
        table=args.sql_table,
        type_id=args.sql_type_id,
        source_comment="scripts/i18n_missing_keys_to_sql.py",
    )
    print(f"已写入 {args.emit_sql}，共 {n} 条 INSERT。")
    return 0


if __name__ == "__main__":
    sys.exit(main())
