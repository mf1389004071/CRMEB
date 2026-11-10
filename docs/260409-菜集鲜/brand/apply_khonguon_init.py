# -*- coding: utf-8 -*-
"""
应用 Kho Nguon 合同后初始调整到指定 MySQL。
示例：
  python apply_khonguon_init.py --mysql mysql://root:root@127.0.0.1:33060/crmeb
  python apply_khonguon_init.py --mysql mysql://USER:PASS@HOST:3306/cjx_crmeb --prod-keep-check
"""
from __future__ import annotations

import argparse
import json
import sys
from pathlib import Path
from urllib.parse import unquote, urlparse

ROOT = Path(__file__).resolve().parents[3]
SQL_DIR = ROOT / "crmeb" / "database" / "vn" / "brand"
SQL_FILES = [
    "khonguon_brand_seed.sql",
    "khonguon_cities_warehouses.sql",
    "khonguon_products_categories.sql",
]

HIDE_HOME = {
    "seckill",
    "bargain",
    "combination",
    "homeComb",
    "coupon",
    "promotionList",
    "presale",
    "scoreList",
    "pointsMall",
    "live",
    "hotspot",
}
KEEP_MY_URL_KEYWORDS = (
    "/pages/users/user_address_list",
    "/pages/users/order_list",
    "/pages/goods/order_list",
    "/pages/users/user_info",
    "/pages/users/contact",
    "/pages/extension/customer_list",
    "/pages/users/privacy",
    "/pages/users/user_about",
    "about",
    "contact",
)


def parse_mysql(url: str) -> dict:
    u = urlparse(url)
    if u.scheme not in ("mysql", "mysql2"):
        raise SystemExit("--mysql 格式: mysql://user:pass@host:port/db")
    return {
        "host": u.hostname or "127.0.0.1",
        "port": u.port or 3306,
        "user": unquote(u.username or "root"),
        "password": unquote(u.password or ""),
        "database": (u.path or "/crmeb").lstrip("/") or "crmeb",
        "charset": "utf8mb4",
    }


def connect(cfg: dict):
    import pymysql

    return pymysql.connect(
        host=cfg["host"],
        port=int(cfg["port"]),
        user=cfg["user"],
        password=cfg["password"],
        database=cfg["database"],
        charset="utf8mb4",
        autocommit=False,
        cursorclass=pymysql.cursors.DictCursor,
    )


def split_sql(text: str):
    buf = []
    for line in text.splitlines():
        s = line.strip()
        if s.startswith("--"):
            continue
        buf.append(line)
    blob = "\n".join(buf)
    parts = []
    cur = []
    for ch in blob:
        cur.append(ch)
        if ch == ";":
            stmt = "".join(cur).strip()
            if stmt and stmt != ";":
                parts.append(stmt)
            cur = []
    tail = "".join(cur).strip()
    if tail:
        parts.append(tail)
    return parts


def run_sql_file(conn, path: Path):
    text = path.read_text(encoding="utf-8")
    cur = conn.cursor()
    for stmt in split_sql(text):
        cur.execute(stmt)
    print(f"  ok sql: {path.name}")


def filter_theme_home(data):
    if data is None or data == "":
        return data, 0
    if isinstance(data, (bytes, bytearray)):
        data = data.decode("utf-8", errors="ignore")
    obj = json.loads(data) if isinstance(data, str) else data
    removed = 0

    def should_hide(it: dict) -> bool:
        if not isinstance(it, dict):
            return False
        name = it.get("name") or ""
        return name in HIDE_HOME

    def clean_list(items):
        nonlocal removed
        out = []
        for it in items or []:
            if should_hide(it):
                removed += 1
                continue
            out.append(it)
        return out

    def clean_map(mp: dict):
        nonlocal removed
        out = {}
        for k, it in (mp or {}).items():
            if should_hide(it):
                removed += 1
                continue
            # 兼容组件自身带 isHide 标记
            if isinstance(it, dict) and should_hide(it):
                removed += 1
                continue
            out[k] = it
        return out

    if isinstance(obj, dict):
        val = obj.get("value")
        if isinstance(val, dict):
            obj["value"] = clean_map(val)
        elif isinstance(val, list):
            obj["value"] = clean_list(val)
        elif isinstance(obj.get("list"), list):
            obj["list"] = clean_list(obj["list"])
    elif isinstance(obj, list):
        obj = clean_list(obj)
    return json.dumps(obj, ensure_ascii=False, separators=(",", ":")), removed


def trim_my_menus(conn):
    cur = conn.cursor()
    cur.execute("SELECT id FROM eb_system_group WHERE config_name='routine_my_menus' LIMIT 1")
    row = cur.fetchone()
    if not row:
        print("  skip my_menus: group missing")
        return
    gid = row["id"]
    cur.execute("SELECT id, value FROM eb_system_group_data WHERE gid=%s", (gid,))
    hidden = 0
    for item in cur.fetchall():
        try:
            val = json.loads(item["value"])
        except Exception:
            continue
        url = ""
        if isinstance(val, dict):
            u = val.get("url") or {}
            url = u.get("value") if isinstance(u, dict) else str(u or "")
            show = val.get("is_show") or {}
        else:
            continue
        keep = any(k in url for k in KEEP_MY_URL_KEYWORDS)
        # 默认隐藏营销入口；命中 keep 则保持显示
        new_show = "1" if keep else "0"
        if isinstance(show, dict):
            if str(show.get("value")) == new_show:
                continue
            show["value"] = new_show
            val["is_show"] = show
        else:
            val["is_show"] = {"type": "radio", "value": new_show}
        cur.execute(
            "UPDATE eb_system_group_data SET value=%s WHERE id=%s",
            (json.dumps(val, ensure_ascii=False, separators=(",", ":")), item["id"]),
        )
        if new_show == "0":
            hidden += 1
    print(f"  my_menus hidden≈{hidden}")


def trim_themes(conn):
    cur = conn.cursor()
    cur.execute("SELECT id, title, is_use, home_data FROM eb_theme")
    rows = cur.fetchall()
    if not rows:
        print("  skip theme: empty")
        return
    for row in rows:
        new_home, removed = filter_theme_home(row.get("home_data"))
        if removed:
            cur.execute("UPDATE eb_theme SET home_data=%s WHERE id=%s", (new_home, row["id"]))
        print(f"  theme#{row['id']} {row['title']} is_use={row['is_use']} removed={removed}")


def keep_check(conn):
    cur = conn.cursor()
    cur.execute(
        "SELECT id, store_name, is_fresh, is_show, is_del FROM eb_store_product "
        "WHERE (id IN (5,6,7,8) OR id BETWEEN 886002 AND 886099) AND is_del=0 ORDER BY id"
    )
    rows = cur.fetchall()
    print("  keep products:")
    for r in rows:
        print(f"    {r}")
    cur.execute(
        "SELECT city_id, name, is_open FROM eb_system_city WHERE country_code='VN' AND level=0 ORDER BY city_id"
    )
    cities = cur.fetchall()
    print(f"  open VN provinces: {len(cities)}")
    for c in cities:
        print(f"    {c['city_id']} {c['name']} open={c['is_open']}")
    cur.execute(
        "SELECT w.id, w.code, w.name, w.address, wr.city_id FROM eb_vn_warehouse w "
        "LEFT JOIN eb_vn_warehouse_region wr ON wr.warehouse_id=w.id "
        "WHERE w.is_del=0 ORDER BY w.id"
    )
    for w in cur.fetchall():
        print(f"    wh {w['id']} {w['code']} city={w['city_id']} addr={w['address']}")


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--mysql", required=True)
    ap.add_argument("--skip-sql", action="store_true")
    ap.add_argument("--prod-keep-check", action="store_true")
    args = ap.parse_args()
    cfg = parse_mysql(args.mysql)
    conn = connect(cfg)
    try:
        if not args.skip_sql:
            for name in SQL_FILES:
                run_sql_file(conn, SQL_DIR / name)
        trim_themes(conn)
        trim_my_menus(conn)
        if args.prod_keep_check:
            keep_check(conn)
        conn.commit()
        print("DONE")
    except Exception:
        conn.rollback()
        raise
    finally:
        conn.close()


if __name__ == "__main__":
    try:
        main()
    except Exception as e:
        print("FAILED:", e, file=sys.stderr)
        sys.exit(1)
