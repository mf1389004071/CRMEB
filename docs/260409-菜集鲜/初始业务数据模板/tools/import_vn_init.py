# -*- coding: utf-8 -*-
"""
客户极简 CSV → 直连 MySQL 导入，并备份已执行 SQL。

流程：
  1) 导 01_商品.csv → 写商品/规格，备份 SQL
  2) 从库查询 商品编码→product_id/unique
  3) 导 02_城市仓价格.csv → 区划/仓/区域价，备份 SQL

依赖：pip install pymysql
示例：
  python import_vn_init.py --mysql mysql://root:root@127.0.0.1:33060/crmeb --all
"""
from __future__ import annotations

import argparse
import hashlib
import json
import sys
import time
from datetime import datetime
from pathlib import Path
from typing import Dict, List, Optional, Tuple
from urllib.parse import unquote, urlparse

TOOLS = Path(__file__).resolve().parent
ROOT = TOOLS.parent
if str(TOOLS) not in sys.path:
    sys.path.insert(0, str(TOOLS))

from csv_io import (  # noqa: E402
    as_positive_number,
    is_blank,
    parse_price_columns,
    read_csv,
    slug_ascii,
    sql_str,
)

VN_ROOT = 900002
SKU_PREFIX = "VNSKU:"
DEFAULT_IMAGE = "/uploads/attach/2023/02/20230213/3b570808fc3593aa51b2a94ceaba3e6f.png"


def safe_print(msg: str) -> None:
    try:
        print(msg)
    except UnicodeEncodeError:
        print(msg.encode("utf-8", errors="replace").decode("ascii", errors="replace"))


def parse_mysql(url: str) -> dict:
    """mysql://user:pass@host:port/db"""
    u = urlparse(url)
    if u.scheme not in ("mysql", "mysql2"):
        raise SystemExit(" --mysql 格式: mysql://user:pass@host:33060/crmeb")
    return {
        "host": u.hostname or "127.0.0.1",
        "port": u.port or 3306,
        "user": unquote(u.username or "root"),
        "password": unquote(u.password or ""),
        "database": (u.path or "/crmeb").lstrip("/") or "crmeb",
        "charset": "utf8mb4",
    }


def connect(cfg: dict):
    try:
        import pymysql
    except ImportError:
        raise SystemExit("请先安装: pip install pymysql")
    return pymysql.connect(
        host=cfg["host"],
        port=int(cfg["port"]),
        user=cfg["user"],
        password=cfg["password"],
        database=cfg["database"],
        charset=cfg.get("charset", "utf8mb4"),
        autocommit=False,
        cursorclass=pymysql.cursors.DictCursor,
    )


class SqlBackup:
    def __init__(self, out_dir: Path, dry_run: bool = False):
        self.out_dir = out_dir
        self.dry_run = dry_run
        self.files: Dict[str, List[str]] = {}
        self.out_dir.mkdir(parents=True, exist_ok=True)

    def add(self, name: str, sql: str):
        self.files.setdefault(name, ["SET NAMES utf8mb4;", f"-- {datetime.now().isoformat(timespec='seconds')}", ""])
        self.files[name].append(sql.rstrip() + ("" if sql.rstrip().endswith(";") else ";"))
        self.files[name].append("")

    def flush(self):
        for name, lines in self.files.items():
            path = self.out_dir / name
            path.write_text("\n".join(lines) + "\n", encoding="utf-8")
            safe_print(f"  backup -> {path}")


def exec_sql(conn, backup: SqlBackup, file_name: str, sql: str, args: Optional[tuple] = None):
    """执行并将最终 SQL 文本写入备份（已展开参数）。"""
    cur = conn.cursor()
    if args:
        # 用字面量展开便于备份可重复执行
        rendered = sql
        for a in args:
            if a is None:
                lit = "NULL"
            elif isinstance(a, (int, float)):
                lit = str(a)
            else:
                lit = sql_str(str(a))
            rendered = rendered.replace("%s", lit, 1)
        backup.add(file_name, rendered)
        if not backup.dry_run:
            cur.execute(sql, args)
    else:
        backup.add(file_name, sql)
        if not backup.dry_run:
            cur.execute(sql)
    return cur


def ensure_category(conn, backup: SqlBackup, cate_name: str = "Rau củ") -> int:
    cur = conn.cursor()
    cur.execute(
        "SELECT id FROM eb_store_category WHERE cate_name=%s LIMIT 1",
        (cate_name,),
    )
    row = cur.fetchone()
    if row:
        return int(row["id"])
    sql = (
        "INSERT INTO eb_store_category (pid, cate_name, sort, pic, is_show, add_time, big_pic) "
        "VALUES (0, %s, 0, '', 1, %s, '')"
    )
    exec_sql(conn, backup, "01_products.sql", sql, (cate_name, int(time.time())))
    if backup.dry_run:
        return 0
    return int(conn.insert_id())


def make_unique(code: str) -> str:
    return hashlib.md5(f"{code}:DEFAULT".encode("utf-8")).hexdigest()[:8]


def find_product_by_code(conn, code: str) -> Optional[dict]:
    cur = conn.cursor()
    cur.execute(
        "SELECT p.id AS product_id, a.`unique` AS uniq, a.bar_code "
        "FROM eb_store_product p "
        "JOIN eb_store_product_attr_value a ON a.product_id=p.id AND a.type=0 "
        "WHERE p.is_del=0 AND (a.bar_code=%s OR p.bar_code=%s OR p.keyword LIKE %s) "
        "ORDER BY a.id ASC LIMIT 1",
        (code, code[:15], f"%{SKU_PREFIX}{code}%"),
    )
    return cur.fetchone()


def import_products(conn, backup: SqlBackup, path: Path, image: str) -> Dict[str, Tuple[int, str]]:
    headers, rows = read_csv(path)
    for col in ("商品编码", "商品名", "单位", "参考价"):
        if col not in headers:
            raise SystemExit(f"01 缺列: {col}")
    cate_id = ensure_category(conn, backup)
    mapping: Dict[str, Tuple[int, str]] = {}
    now = int(time.time())

    for i, row in enumerate(rows, start=2):
        code = row.get("商品编码", "").strip().upper()
        name = row.get("商品名", "").strip()
        unit = row.get("单位", "kg").strip() or "kg"
        ok, price = as_positive_number(row.get("参考价", ""))
        if is_blank(code) or is_blank(name) or not ok:
            raise SystemExit(f"01 第{i}行：商品编码/商品名/参考价 无效")
        stock_ok, stock_s = as_positive_number(row.get("库存", "999") or "999")
        stock = int(float(stock_s)) if stock_ok and stock_s else 999
        uniq = make_unique(code)
        keyword = f"{SKU_PREFIX}{code}"
        bar15 = code[:15]
        slider = json.dumps([image], ensure_ascii=False)

        existed = None if backup.dry_run else find_product_by_code(conn, code)
        if existed:
            pid = int(existed["product_id"])
            uniq = existed["uniq"] or uniq
            exec_sql(
                conn,
                backup,
                "01_products.sql",
                "UPDATE eb_store_product SET store_name=%s, unit_name=%s, price=%s, ot_price=%s, "
                "stock=%s, keyword=%s, bar_code=%s, is_show=1, is_del=0, is_fresh=1 WHERE id=%s",
                (name, unit, price, price, stock, keyword, bar15, pid),
            )
            exec_sql(
                conn,
                backup,
                "01_products.sql",
                "UPDATE eb_store_product_attr_value SET price=%s, ot_price=%s, stock=%s, bar_code=%s, "
                "suk=%s, image=%s WHERE product_id=%s AND type=0 AND `unique`=%s",
                (price, price, stock, code, "默认", image, pid, uniq),
            )
        else:
            exec_sql(
                conn,
                backup,
                "01_products.sql",
                "INSERT INTO eb_store_product ("
                "image, slider_image, store_name, store_info, keyword, bar_code, cate_id, "
                "price, ot_price, unit_name, stock, is_show, is_postage, is_del, temp_id, "
                "spec_type, activity, spu, add_time, is_fresh"
                ") VALUES ("
                "%s, %s, %s, %s, %s, %s, %s, "
                "%s, %s, %s, %s, 1, 1, 0, 1, "
                "0, '0,0,0,0', %s, %s, 1"
                ")",
                (
                    image,
                    slider,
                    name,
                    name,
                    keyword,
                    bar15,
                    str(cate_id) if cate_id else "0",
                    price,
                    price,
                    unit,
                    stock,
                    f"CJX{code}"[:13],
                    now,
                ),
            )
            if backup.dry_run:
                pid = 0
            else:
                pid = int(conn.insert_id())
            # 单规格 attr
            exec_sql(
                conn,
                backup,
                "01_products.sql",
                "INSERT INTO eb_store_product_attr (product_id, attr_name, attr_values, type) "
                "VALUES (%s, '规格', '默认', 0)",
                (pid,),
            )
            exec_sql(
                conn,
                backup,
                "01_products.sql",
                "INSERT INTO eb_store_product_attr_result (product_id, result, change_time, type) "
                "VALUES (%s, %s, %s, 0)",
                (
                    pid,
                    json.dumps(
                        {
                            "attr": [{"value": "规格", "detail": ["默认"]}],
                            "value": [
                                {
                                    "attr_arr": ["默认"],
                                    "detail": {"规格": "默认"},
                                    "price": price,
                                    "ot_price": price,
                                    "stock": stock,
                                    "bar_code": code,
                                    "unique": uniq,
                                }
                            ],
                        },
                        ensure_ascii=False,
                    ),
                    now,
                ),
            )
            exec_sql(
                conn,
                backup,
                "01_products.sql",
                "INSERT INTO eb_store_product_attr_value ("
                "product_id, suk, stock, sales, price, image, `unique`, cost, bar_code, "
                "ot_price, weight, volume, type, is_show, is_default_select"
                ") VALUES (%s, '默认', %s, 0, %s, %s, %s, 0, %s, %s, 0, 0, 0, 1, 1)",
                (pid, stock, price, image, uniq, code, price),
            )
            exec_sql(
                conn,
                backup,
                "01_products.sql",
                "INSERT INTO eb_store_product_description (product_id, description, type) "
                "SELECT %s, %s, 0 FROM DUAL WHERE NOT EXISTS ("
                "SELECT 1 FROM eb_store_product_description WHERE product_id=%s AND type=0)",
                (pid, f"<p>{name}</p>", pid),
            )
            if cate_id:
                exec_sql(
                    conn,
                    backup,
                    "01_products.sql",
                    "INSERT INTO eb_store_product_cate (product_id, cate_id, cate_pid, status, add_time) "
                    "SELECT %s, %s, 0, 1, %s FROM DUAL WHERE NOT EXISTS ("
                    "SELECT 1 FROM eb_store_product_cate WHERE product_id=%s AND cate_id=%s)",
                    (pid, cate_id, now, pid, cate_id),
                )
        mapping[code] = (pid, uniq)
        safe_print(f"  product {code} -> id={pid} unique={uniq}")

    if not backup.dry_run:
        conn.commit()
    return mapping


def load_sku_map_from_db(conn, codes: List[str]) -> Dict[str, Tuple[int, str]]:
    out: Dict[str, Tuple[int, str]] = {}
    for code in codes:
        row = find_product_by_code(conn, code)
        if not row:
            raise SystemExit(f"库中找不到商品编码 {code}，请先成功导入 01_商品.csv")
        out[code] = (int(row["product_id"]), row["uniq"])
    return out


def next_city_id(conn, base: int) -> int:
    cur = conn.cursor()
    cur.execute("SELECT IFNULL(MAX(city_id), 0) AS m FROM eb_system_city WHERE city_id>=%s", (base,))
    m = int(cur.fetchone()["m"] or 0)
    return max(base, m + 1) if m >= base else base


def find_city_by_area(conn, area_code: str) -> Optional[int]:
    cur = conn.cursor()
    cur.execute(
        "SELECT city_id FROM eb_system_city WHERE country_code='VN' AND area_code=%s LIMIT 1",
        (area_code,),
    )
    row = cur.fetchone()
    return int(row["city_id"]) if row else None


def upsert_city(
    conn,
    backup: SqlBackup,
    city_id: int,
    level: int,
    parent_id: int,
    name: str,
    merger: str,
    area_code: str,
    is_open: int,
    is_hot: int,
    path: str,
):
    sql_ins = (
        "INSERT INTO eb_system_city "
        "(city_id, level, parent_id, area_code, name, merger_name, lng, lat, is_show, "
        "country_code, path, is_open, is_hot, sort) "
        "SELECT %s,%s,%s,%s,%s,%s,'','',1,'VN',%s,%s,%s,0 FROM DUAL "
        "WHERE NOT EXISTS (SELECT 1 FROM eb_system_city WHERE city_id=%s)"
    )
    exec_sql(
        conn,
        backup,
        "02_regions.sql",
        sql_ins,
        (city_id, level, parent_id, area_code, name, merger, path, is_open, is_hot, city_id),
    )
    exec_sql(
        conn,
        backup,
        "02_regions.sql",
        "UPDATE eb_system_city SET level=%s, parent_id=%s, area_code=%s, name=%s, merger_name=%s, "
        "path=%s, is_open=%s, is_hot=%s, country_code='VN', is_show=1 WHERE city_id=%s",
        (level, parent_id, area_code, name, merger, path, is_open, is_hot, city_id),
    )


def is_hot_province(name: str) -> int:
    n = name.lower()
    if "hà nội" in n or "ha noi" in n or "hồ chí minh" in n or "ho chi minh" in n:
        return 1
    return 0


def import_regions(
    conn,
    backup: SqlBackup,
    path: Path,
    sku_map: Dict[str, Tuple[int, str]],
    city_id_base: int,
):
    headers, rows = read_csv(path)
    for col in ("省", "仓名", "仓地址"):
        if col not in headers:
            raise SystemExit(f"02 缺列: {col}")
    price_cols = parse_price_columns(headers)
    for code in price_cols:
        if code not in sku_map:
            raise SystemExit(f"02 价列 {code} 在商品映射中不存在（先导 01 或检查列名 价_编码）")

    # 省节点缓存 name -> city_id
    province_ids: Dict[str, int] = {}
    next_id = next_city_id(conn, city_id_base) if not backup.dry_run else city_id_base

    def alloc_id(area_code: str) -> int:
        nonlocal next_id
        existed = None if backup.dry_run else find_city_by_area(conn, area_code)
        if existed:
            return existed
        cid = next_id
        next_id += 1
        return cid

    for i, row in enumerate(rows, start=2):
        province = row.get("省", "").strip()
        district = row.get("郡", "").strip()
        wh_name = row.get("仓名", "").strip()
        wh_addr = row.get("仓地址", "").strip()
        if is_blank(province) or is_blank(wh_name) or is_blank(wh_addr):
            raise SystemExit(f"02 第{i}行：省/仓名/仓地址 必填")

        p_area = f"VNINIT:{slug_ascii(province)}"
        if province not in province_ids:
            pid = alloc_id(p_area)
            province_ids[province] = pid
            path_p = f",{VN_ROOT},{pid},"
            upsert_city(
                conn,
                backup,
                pid,
                0,
                VN_ROOT,
                province,
                province,
                p_area,
                1,
                is_hot_province(province),
                path_p,
            )
        else:
            pid = province_ids[province]

        if district:
            d_area = f"VNINIT:{slug_ascii(province)}-{slug_ascii(district)}"
            did = alloc_id(d_area)
            path_d = f",{VN_ROOT},{pid},{did},"
            upsert_city(conn, backup, did, 1, pid, district, f"{province},{district}", d_area, 1, 0, path_d)
            attach_city = did
        else:
            attach_city = pid

        wh_code = f"WHINIT:{slug_ascii(wh_name)}"
        exec_sql(
            conn,
            backup,
            "02_warehouse.sql",
            "INSERT INTO eb_vn_warehouse "
            "(code, name, address, detailed_address, introduction, phone, lng, lat, "
            "is_enable, auto_match, exact_match_only, sort, is_del, add_time, update_time) "
            "SELECT %s,%s,%s,%s,'','','','',1,1,0,100,0,UNIX_TIMESTAMP(),UNIX_TIMESTAMP() FROM DUAL "
            "WHERE NOT EXISTS (SELECT 1 FROM eb_vn_warehouse WHERE code=%s AND is_del=0)",
            (wh_code, wh_name, wh_addr, wh_addr, wh_code),
        )
        exec_sql(
            conn,
            backup,
            "02_warehouse.sql",
            "UPDATE eb_vn_warehouse SET name=%s, address=%s, detailed_address=%s, "
            "is_enable=1, auto_match=1, update_time=UNIX_TIMESTAMP() WHERE code=%s AND is_del=0",
            (wh_name, wh_addr, wh_addr, wh_code),
        )
        exec_sql(
            conn,
            backup,
            "02_warehouse.sql",
            "INSERT INTO eb_vn_warehouse_region (warehouse_id, city_id, sort, is_default, add_time) "
            "SELECT w.id, %s, 100, 1, UNIX_TIMESTAMP() FROM eb_vn_warehouse w "
            "WHERE w.code=%s AND w.is_del=0 AND NOT EXISTS ("
            "  SELECT 1 FROM eb_vn_warehouse_region wr WHERE wr.warehouse_id=w.id AND wr.city_id=%s)",
            (attach_city, wh_code, attach_city),
        )

        for code, col in price_cols.items():
            raw = row.get(col, "")
            ok, price = as_positive_number(raw)
            if is_blank(raw):
                continue
            if not ok:
                raise SystemExit(f"02 第{i}行 {col} 价格非法")
            prod_id, uniq = sku_map[code]
            exec_sql(
                conn,
                backup,
                "03_region_price.sql",
                "INSERT INTO eb_store_product_region_price "
                "(product_id, `unique`, city_id, price, ot_price, stock, status, add_time, update_time) "
                "VALUES (%s,%s,%s,%s,%s,NULL,1,UNIX_TIMESTAMP(),UNIX_TIMESTAMP()) "
                "ON DUPLICATE KEY UPDATE price=VALUES(price), ot_price=VALUES(ot_price), "
                "status=1, update_time=UNIX_TIMESTAMP()",
                (prod_id, uniq, attach_city, price, price),
            )
        safe_print(f"  region {province}/{district or '-'} city={attach_city} wh={wh_code}")

    if not backup.dry_run:
        conn.commit()


def write_sku_snapshot(out_dir: Path, sku_map: Dict[str, Tuple[int, str]]):
    lines = ["商品编码,product_id,unique"]
    for code, (pid, uniq) in sorted(sku_map.items()):
        lines.append(f"{code},{pid},{uniq}")
    p = out_dir / "_sku_map_from_db.csv"
    p.write_text("\n".join(lines) + "\n", encoding="utf-8-sig")
    safe_print(f"  snapshot -> {p}")


def main() -> int:
    ap = argparse.ArgumentParser(description="极简 CSV 直连导入 VN 业务数据")
    ap.add_argument("--mysql", required=True, help="mysql://user:pass@host:port/db")
    ap.add_argument("--products", type=Path, default=ROOT / "01_商品.csv")
    ap.add_argument("--regions", type=Path, default=ROOT / "02_城市仓价格.csv")
    ap.add_argument("--out-dir", type=Path, default=None, help="SQL 备份目录，默认 out/时间戳")
    ap.add_argument("--step", choices=["products", "regions", "all"], default="all")
    ap.add_argument("--city-id-base", type=int, default=920001)
    ap.add_argument("--image", default=DEFAULT_IMAGE, help="商品占位图")
    ap.add_argument("--dry-run", action="store_true", help="只生成备份 SQL，不写库")
    args = ap.parse_args()

    stamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    out_dir = args.out_dir or (ROOT / "out" / stamp)
    backup = SqlBackup(out_dir, dry_run=args.dry_run)
    cfg = parse_mysql(args.mysql)
    conn = connect(cfg)
    print(f"DB {cfg['user']}@{cfg['host']}:{cfg['port']}/{cfg['database']} dry_run={args.dry_run}")

    try:
        cur = conn.cursor()
        cur.execute("SELECT city_id FROM eb_system_city WHERE city_id=%s LIMIT 1", (VN_ROOT,))
        if not cur.fetchone() and not args.dry_run:
            raise SystemExit("缺少 VN 国家根 city_id=900002，请先执行 crmeb/database/vn 迁移")

        sku_map: Dict[str, Tuple[int, str]] = {}
        if args.step in ("products", "all"):
            print("== step products ==")
            sku_map = import_products(conn, backup, args.products, args.image)
            write_sku_snapshot(out_dir, sku_map)

        if args.step in ("regions", "all"):
            print("== step regions ==")
            _, prow = read_csv(args.products)
            codes = [r["商品编码"].strip().upper() for r in prow if r.get("商品编码")]
            if args.step == "regions" or args.dry_run:
                # regions-only 或 dry-run 时：优先用刚导入结果，否则查库
                if not sku_map:
                    if args.dry_run:
                        sku_map = {c: (0, make_unique(c)) for c in codes}
                        safe_print("  dry-run: placeholder product_id=0")
                    else:
                        sku_map = load_sku_map_from_db(conn, codes)
                        write_sku_snapshot(out_dir, sku_map)
            else:
                # all 且已导入：再查库确认
                if not args.dry_run:
                    sku_map = load_sku_map_from_db(conn, codes)
                    write_sku_snapshot(out_dir, sku_map)
            import_regions(conn, backup, args.regions, sku_map, args.city_id_base)

        backup.flush()
        (out_dir / "00_report.md").write_text(
            "\n".join(
                [
                    "# 导入报告",
                    "",
                    f"- 时间：{datetime.now().isoformat(timespec='seconds')}",
                    f"- dry_run：{args.dry_run}",
                    f"- step：{args.step}",
                    f"- 商品映射：{sku_map}",
                    "",
                    "执行后请：重建 path、清缓存；确认 offline_pay_status / vn_mode_enable。",
                    "",
                ]
            ),
            encoding="utf-8",
        )
        print("DONE")
        return 0
    except Exception:
        if not args.dry_run:
            conn.rollback()
        raise
    finally:
        conn.close()


if __name__ == "__main__":
    raise SystemExit(main())
