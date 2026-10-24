#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
从 template/uni-app 抽取 $t / this.$t / i18n.t 的中文 key，并可选与 MySQL eb_lang_code 对齐，
输出缺失词条、TSV 草稿、幂等 SQL（走 vn_lang_codes_to_sql 同族三语 INSERT）。

示例：
  python scripts/i18n_extract_uni_t_keys.py --emit-keys scripts/_uni_t_keys.txt
  python scripts/i18n_extract_uni_t_keys.py --mysql "mysql://root:root@127.0.0.1:33060/crmeb" --emit-missing scripts/_missing_keys.txt
  python scripts/i18n_extract_uni_t_keys.py --mysql "..." --emit-tsv-append crmeb/database/vn/lang_codes.tsv --translate-gtx
"""
from __future__ import annotations

import argparse
import json
import re
import sys
import time
import urllib.error
import urllib.parse
import urllib.request
from pathlib import Path

CHINESE_RE = re.compile(r"[\u4e00-\u9fff]")
# $t('x') / $t("x") / $t(`x`) / this.$t(...) / i18n.t(...)
T_CALL_RE = re.compile(
    r"(?:(?:this\.)?\$t|i18n\.t)\s*\(\s*(['\"`])(.+?)\1\s*[,)]",
    re.DOTALL,
)

DEFAULT_SKIP_DIRS = frozenset(
    {"unpackage", "node_modules", "uni_modules", "static", ".git"}
)


def should_skip(path: Path, root: Path) -> bool:
    try:
        parts = path.relative_to(root).parts
    except ValueError:
        return True
    return any(p in DEFAULT_SKIP_DIRS for p in parts)


def extract_keys_from_text(text: str) -> set[str]:
    keys: set[str] = set()
    for m in T_CALL_RE.finditer(text):
        inner = m.group(2)
        if "${" in inner:
            continue
        if not CHINESE_RE.search(inner):
            continue
        # 去掉过长/明显非文案
        if len(inner) > 200:
            continue
        keys.add(inner.strip())
    return keys


def scan_uni_app(root: Path) -> set[str]:
    all_keys: set[str] = set()
    for path in sorted(root.rglob("*")):
        if not path.is_file():
            continue
        if path.suffix.lower() not in (".vue", ".js", ".ts"):
            continue
        if should_skip(path, root):
            continue
        try:
            text = path.read_text(encoding="utf-8")
        except (UnicodeDecodeError, OSError):
            continue
        all_keys |= extract_keys_from_text(text)
    return all_keys


def parse_mysql_url(url: str) -> dict:
    """mysql://user:pass@host:port/db"""
    if not url.startswith("mysql://"):
        raise ValueError("仅支持 mysql://user:pass@host:port/db")
    u = urllib.parse.urlparse(url)
    return {
        "user": urllib.parse.unquote(u.username or "root"),
        "password": urllib.parse.unquote(u.password or ""),
        "host": u.hostname or "127.0.0.1",
        "port": u.port or 3306,
        "database": (u.path or "/crmeb").lstrip("/") or "crmeb",
    }


def fetch_db_codes(mysql_url: str, table: str = "eb_lang_code") -> dict[str, dict]:
    """
    返回 {code: {zh, vi, en, has_zh, has_vi, has_en, vi_is_zh}}
    通过 docker/mysql CLI 不便，这里用 PyMySQL 或 mysql 子进程。
    """
    cfg = parse_mysql_url(mysql_url)
    try:
        import pymysql  # type: ignore
    except ImportError:
        # 回退：用 docker exec 导出
        return fetch_db_codes_via_docker(cfg, table)

    conn = pymysql.connect(
        host=cfg["host"],
        port=cfg["port"],
        user=cfg["user"],
        password=cfg["password"],
        database=cfg["database"],
        charset="utf8mb4",
        cursorclass=pymysql.cursors.DictCursor,
    )
    try:
        with conn.cursor() as cur:
            cur.execute(
                f"""
                SELECT c.code, t.file_name, c.lang_explain, c.is_admin
                FROM `{table}` c
                JOIN eb_lang_type t ON t.id = c.type_id AND t.is_del = 0
                WHERE c.is_admin = 0
                  AND t.file_name IN ('zh-CN', 'vi-VN', 'en-US')
                """
            )
            rows = cur.fetchall()
    finally:
        conn.close()
    return aggregate_rows(rows)


def fetch_db_codes_via_docker(cfg: dict, table: str) -> dict[str, dict]:
    import subprocess

    sql = (
        "SELECT c.code, t.file_name, c.lang_explain "
        f"FROM `{table}` c "
        "JOIN eb_lang_type t ON t.id=c.type_id AND t.is_del=0 "
        "WHERE c.is_admin=0 AND t.file_name IN ('zh-CN','vi-VN','en-US');"
    )
    # 优先本机 mysql 客户端；否则 docker exec cjx-mysql
    cmd = [
        "docker",
        "exec",
        "cjx-mysql",
        "mysql",
        f"-u{cfg['user']}",
        f"-p{cfg['password']}",
        "--default-character-set=utf8mb4",
        "-N",
        "-B",
        cfg["database"],
        "-e",
        sql,
    ]
    p = subprocess.run(cmd, capture_output=True)
    out = p.stdout.decode("utf-8", errors="replace")
    err = p.stderr.decode("utf-8", errors="replace")
    if p.returncode != 0:
        raise RuntimeError(f"mysql 查询失败: {err or out}")
    rows = []
    for line in out.splitlines():
        if not line.strip() or line.startswith("mysql:"):
            continue
        parts = line.split("\t")
        if len(parts) < 3:
            continue
        rows.append(
            {"code": parts[0], "file_name": parts[1], "lang_explain": parts[2]}
        )
    return aggregate_rows(rows)


def aggregate_rows(rows) -> dict[str, dict]:
    data: dict[str, dict] = {}
    for r in rows:
        code = r["code"]
        fn = r["file_name"]
        expl = r["lang_explain"] or ""
        slot = data.setdefault(
            code,
            {
                "zh": "",
                "vi": "",
                "en": "",
                "has_zh": False,
                "has_vi": False,
                "has_en": False,
            },
        )
        if fn == "zh-CN":
            slot["zh"] = expl
            slot["has_zh"] = True
        elif fn == "vi-VN":
            slot["vi"] = expl
            slot["has_vi"] = True
        elif fn == "en-US":
            slot["en"] = expl
            slot["has_en"] = True
    for code, slot in data.items():
        # 越语等于中文 code 或等于 zh 文案 → 视为未翻
        slot["vi_is_zh"] = bool(
            slot["has_vi"]
            and slot["vi"]
            and (slot["vi"] == code or (slot["zh"] and slot["vi"] == slot["zh"]))
        )
    return data


def gtx_translate(text: str, target: str, source: str = "zh-CN") -> str:
    """Google translate_a/single client=gtx（与后端 GoogleGtxTranslate 同族）。"""
    q = urllib.parse.urlencode(
        {"client": "gtx", "sl": source, "tl": target, "dt": "t", "q": text}
    )
    url = "https://translate.googleapis.com/translate_a/single?" + q
    req = urllib.request.Request(url, headers={"User-Agent": "Mozilla/5.0"})
    with urllib.request.urlopen(req, timeout=20) as resp:
        raw = resp.read().decode("utf-8")
    data = json.loads(raw)
    parts = []
    if isinstance(data, list) and data and isinstance(data[0], list):
        for seg in data[0]:
            if isinstance(seg, list) and seg and isinstance(seg[0], str):
                parts.append(seg[0])
    return "".join(parts).strip() or text


def load_existing_tsv_zh(tsv_path: Path) -> set[str]:
    seen: set[str] = set()
    if not tsv_path.is_file():
        return seen
    for line in tsv_path.read_text(encoding="utf-8").splitlines():
        if not line.strip() or line.lstrip().startswith("#"):
            continue
        p = line.split("\t")
        if len(p) >= 2 and p[0] == "front":
            seen.add(p[1])
    return seen


def sql_escape(s: str) -> str:
    return s.replace("\\", "\\\\").replace("'", "''")


def emit_idempotent_sql(rows: list[tuple[str, str, str]], out: Path) -> None:
    """rows: (zh, vi, en) — 三语 front 词条，与 900_lang_codes 风格一致。"""
    lines = [
        "-- 由 scripts/i18n_extract_uni_t_keys.py 生成；幂等。",
        "SET NAMES utf8mb4;",
        "SET @t_zh := (SELECT id FROM eb_lang_type WHERE file_name='zh-CN' AND is_del=0 LIMIT 1);",
        "SET @t_vi := (SELECT id FROM eb_lang_type WHERE file_name='vi-VN' AND is_del=0 LIMIT 1);",
        "SET @t_en := (SELECT id FROM eb_lang_type WHERE file_name='en-US' AND is_del=0 LIMIT 1);",
        "",
        "INSERT INTO eb_lang_code (type_id, code, remarks, lang_explain, is_admin)",
        "SELECT v.tid, v.code, v.remarks, v.explain_, v.is_admin FROM (",
    ]
    parts = []
    for zh, vi, en in rows:
        for tid, rem, txt in (
            ("@t_zh", zh, zh),
            ("@t_vi", "[待审]" + zh, vi),
            ("@t_en", zh, en),
        ):
            parts.append(
                "  SELECT %s AS tid, '%s' AS code, '%s' AS remarks, '%s' AS explain_, 0 AS is_admin, '%s' AS zh_"
                % (tid, sql_escape(zh), sql_escape(rem), sql_escape(txt), sql_escape(zh))
            )
    if not parts:
        out.write_text("-- 无词条\n", encoding="utf-8")
        return
    lines.append("\n  UNION ALL\n".join(parts))
    lines.append(") v")
    lines.append(
        "WHERE v.tid IS NOT NULL AND NOT EXISTS ("
        "SELECT 1 FROM eb_lang_code e WHERE e.type_id = v.tid AND e.code = v.code);"
    )
    # 若 vi 已存在但文案仍是中文，则更新为新译
    lines.append("")
    lines.append("-- 补翻：已有越语/英语占位（等于中文）时更新 lang_explain")
    for zh, vi, en in rows:
        lines.append(
            "UPDATE eb_lang_code c "
            "JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 "
            f"SET c.lang_explain='{sql_escape(vi)}', c.remarks='{sql_escape('[待审]' + zh)}' "
            f"WHERE c.code='{sql_escape(zh)}' AND c.is_admin=0 "
            f"AND (c.lang_explain=c.code OR c.lang_explain='{sql_escape(zh)}');"
        )
        lines.append(
            "UPDATE eb_lang_code c "
            "JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 "
            f"SET c.lang_explain='{sql_escape(en)}' "
            f"WHERE c.code='{sql_escape(zh)}' AND c.is_admin=0 "
            f"AND (c.lang_explain=c.code OR c.lang_explain='{sql_escape(zh)}');"
        )
    lines.append("")
    out.parent.mkdir(parents=True, exist_ok=True)
    out.write_text("\n".join(lines) + "\n", encoding="utf-8")


# 高频 UI 词人工优先（避免机翻生硬）；其余走 gtx
MANUAL_VI_EN: dict[str, tuple[str, str]] = {
    "到手价": ("Giá thực trả", "Final price"),
    "原价": ("Giá gốc", "Original price"),
    "开通SVIP会员预计省": ("Mở SVIP dự kiến tiết kiệm", "Open SVIP to save about"),
    "立即开通": ("Mở ngay", "Activate now"),
    "款": ("mẫu", "options"),
    "可选": ("có thể chọn", "available"),
    "元": ("₫", "₫"),
    "规格": ("Quy cách", "Spec"),
    "种规格可选": ("loại quy cách", "specs available"),
    "共": ("Tổng", "Total"),
    "会员专享": ("Độc quyền hội viên", "Member exclusive"),
    "SVIP": ("SVIP", "SVIP"),
}


def translate_pair(zh: str, use_gtx: bool, interval_ms: int) -> tuple[str, str]:
    if zh in MANUAL_VI_EN:
        return MANUAL_VI_EN[zh]
    if not use_gtx:
        return zh, zh  # 占位，仍写入便于后续审
    try:
        vi = gtx_translate(zh, "vi")
        time.sleep(interval_ms / 1000.0)
        en = gtx_translate(zh, "en")
        time.sleep(interval_ms / 1000.0)
        return vi or zh, en or zh
    except (urllib.error.URLError, urllib.error.HTTPError, TimeoutError, json.JSONDecodeError) as e:
        print(f"[gtx失败] {zh!r}: {e}", file=sys.stderr)
        return zh, zh


def main() -> int:
    ap = argparse.ArgumentParser(description="抽取 uni-app $t 中文 key 并对齐 lang_code")
    ap.add_argument(
        "--root",
        type=Path,
        default=Path(__file__).resolve().parents[1] / "template" / "uni-app",
    )
    ap.add_argument("--emit-keys", type=Path, help="写出全部抽取到的中文 key")
    ap.add_argument(
        "--mysql",
        default="",
        help='如 mysql://root:root@127.0.0.1:33060/crmeb；不填则只抽取不比对',
    )
    ap.add_argument("--emit-missing", type=Path, help="写出库中缺失或越语未翻的 key")
    ap.add_argument(
        "--emit-sql",
        type=Path,
        help="生成幂等 INSERT+UPDATE SQL",
    )
    ap.add_argument(
        "--emit-tsv-append",
        type=Path,
        help="把缺失词条追加到 lang_codes.tsv（跳过已有 front 行）",
    )
    ap.add_argument(
        "--translate-gtx",
        action="store_true",
        help="对无人工词条用 Google gtx 机翻 vi/en",
    )
    ap.add_argument("--gtx-interval-ms", type=int, default=150)
    ap.add_argument(
        "--also-untranslated",
        action="store_true",
        default=True,
        help="把越语仍为中文的已有词条也纳入补齐（默认开）",
    )
    args = ap.parse_args()
    root: Path = args.root.resolve()
    if not root.is_dir():
        print("根目录不存在:", root, file=sys.stderr)
        return 1

    keys = scan_uni_app(root)
    print(f"抽取 $t 中文 key：{len(keys)} 条")

    if args.emit_keys:
        sorted_keys = sorted(keys)
        args.emit_keys.parent.mkdir(parents=True, exist_ok=True)
        args.emit_keys.write_text("\n".join(sorted_keys) + "\n", encoding="utf-8")
        print(f"[keys] {args.emit_keys}")

    need: list[str] = sorted(keys)
    db: dict[str, dict] = {}
    if args.mysql:
        db = fetch_db_codes(args.mysql)
        print(f"库中 front 词条：{len(db)} 条")
        missing = []
        for k in sorted(keys):
            slot = db.get(k)
            if not slot:
                missing.append(k)
                continue
            if not slot["has_vi"] or not slot["has_zh"] or not slot["has_en"]:
                missing.append(k)
                continue
            if args.also_untranslated and slot.get("vi_is_zh"):
                missing.append(k)
        need = missing
        print(f"需补齐（缺语种或越语=中文）：{len(need)} 条")
        if args.emit_missing:
            args.emit_missing.parent.mkdir(parents=True, exist_ok=True)
            args.emit_missing.write_text("\n".join(need) + ("\n" if need else ""), encoding="utf-8")
            print(f"[missing] {args.emit_missing}")

    if not need:
        print("无需补齐。")
        return 0

    if not (args.emit_sql or args.emit_tsv_append):
        # 只报告前 30 条
        for k in need[:30]:
            print(" -", k)
        if len(need) > 30:
            print(f" ... 另有 {len(need) - 30} 条")
        return 0

    rows: list[tuple[str, str, str]] = []
    for i, zh in enumerate(need, 1):
        vi, en = translate_pair(zh, args.translate_gtx, args.gtx_interval_ms)
        # 若库里已有合格译文则保留
        slot = db.get(zh) or {}
        if slot.get("has_vi") and slot.get("vi") and not slot.get("vi_is_zh"):
            vi = slot["vi"]
        if slot.get("has_en") and slot.get("en") and slot["en"] != zh and slot["en"] != zh:
            en = slot["en"]
        rows.append((zh, vi, en))
        if i % 20 == 0 or i == len(need):
            print(f"  翻译进度 {i}/{len(need)}")

    if args.emit_sql:
        emit_idempotent_sql(rows, args.emit_sql)
        print(f"[sql] {args.emit_sql}（{len(rows)} 组）")

    if args.emit_tsv_append:
        existing = load_existing_tsv_zh(args.emit_tsv_append)
        prev = (
            args.emit_tsv_append.read_text(encoding="utf-8")
            if args.emit_tsv_append.is_file()
            else ""
        )
        append_lines = []
        for zh, vi, en in rows:
            if zh in existing:
                continue
            append_lines.append(f"front\t{zh}\t{vi}\t{en}")
        if append_lines:
            with args.emit_tsv_append.open("a", encoding="utf-8", newline="\n") as f:
                if prev and not prev.endswith("\n"):
                    f.write("\n")
                f.write("\n".join(append_lines) + "\n")
            print(f"[tsv] 追加 {len(append_lines)} 行 -> {args.emit_tsv_append}")
        else:
            print("[tsv] 无新行可追加（均已在 tsv 中）")

    return 0


if __name__ == "__main__":
    sys.exit(main())
