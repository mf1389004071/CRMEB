# -*- coding: utf-8 -*-
"""读 UTF-8/BOM CSV；列头取「中文|越文」左侧。"""
from __future__ import annotations

import csv
import re
import unicodedata
from pathlib import Path
from typing import Dict, List, Tuple


def header_key(raw: str) -> str:
    s = (raw or "").strip().lstrip("\ufeff")
    if "|" in s:
        s = s.split("|", 1)[0].strip()
    # 兼容「郡(可空)」
    if "(" in s:
        s = s.split("(", 1)[0].strip()
    return s


def read_csv(path: Path) -> Tuple[List[str], List[Dict[str, str]]]:
    text = path.read_bytes()
    raw = text.decode("utf-8-sig") if text.startswith(b"\xef\xbb\xbf") else text.decode("utf-8")
    rows_list = list(csv.reader(raw.splitlines()))
    if not rows_list:
        return [], []
    keys = [header_key(h) for h in rows_list[0]]
    out: List[Dict[str, str]] = []
    for cells in rows_list[1:]:
        if not any((c or "").strip() for c in cells):
            continue
        d: Dict[str, str] = {}
        for i, k in enumerate(keys):
            if not k:
                continue
            d[k] = ((cells[i] if i < len(cells) else "") or "").strip()
        out.append(d)
    return keys, out


def is_blank(v: str) -> bool:
    return v is None or str(v).strip() == ""


def as_positive_number(v: str) -> Tuple[bool, str]:
    if is_blank(v):
        return True, ""
    try:
        f = float(str(v).replace(",", ""))
    except ValueError:
        return False, ""
    if f <= 0:
        return False, ""
    if abs(f - int(f)) < 1e-9:
        return True, str(int(f))
    return True, f"{f:.2f}"


def sql_str(v: str) -> str:
    return "'" + (v or "").replace("\\", "\\\\").replace("'", "\\'") + "'"


def slug_ascii(text: str, max_len: int = 24) -> str:
    """越南文等 → 近似 ASCII slug，用于稳定编码。"""
    s = unicodedata.normalize("NFD", text or "")
    s = "".join(ch for ch in s if unicodedata.category(ch) != "Mn")
    s = re.sub(r"[^A-Za-z0-9]+", "-", s).strip("-").upper()
    if not s:
        s = "X"
    return s[:max_len]


def parse_price_columns(headers: List[str]) -> Dict[str, str]:
    """价_POTATO → {POTATO: 列名}"""
    out: Dict[str, str] = {}
    for h in headers:
        if h.startswith("价_"):
            out[h[len("价_") :]] = h
    return out
