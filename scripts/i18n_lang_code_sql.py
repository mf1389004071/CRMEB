#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
与 eb_lang_code 表相关的 SQL 生成（供 i18n_scan_uni_app.py、i18n_missing_keys_to_sql.py 复用）。
"""
from __future__ import annotations

import json
import re
from pathlib import Path

CHINESE_RE = re.compile(r"[\u4e00-\u9fff]")


def sql_string_literal(s: str) -> str:
    return s.replace("\\", "\\\\").replace("'", "''")


def emit_lang_code_sql(
    keys: set[str] | list[str],
    out_path: Path,
    *,
    table: str,
    type_id: int,
    source_comment: str = "scripts",
) -> int:
    """幂等 INSERT，is_admin=0。返回写入的 key 条数。"""
    if isinstance(keys, list):
        key_iter = keys
    else:
        key_iter = list(keys)
    keys_sorted = [k for k in sorted(set(key_iter)) if k and CHINESE_RE.search(k)]
    lines = [
        f"-- 由 {source_comment} 生成",
        "-- 执行前请确认：1) 表名与 .env 中 DB_PREFIX 一致；2) type_id 与 eb_lang_type 中文类型一致",
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


def load_keys_from_text(text: str) -> list[str]:
    """支持一行一条，或 JSON 数组 [\"a\",\"b\"]。"""
    text = text.strip()
    if not text:
        return []
    if text.startswith("["):
        data = json.loads(text)
        if isinstance(data, list):
            return [str(x).strip() for x in data if str(x).strip()]
        return []
    return [ln.strip() for ln in text.splitlines() if ln.strip()]
