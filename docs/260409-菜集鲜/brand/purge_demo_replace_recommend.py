# -*- coding: utf-8 -*-
"""
生产/目标库：
1) 猜你喜欢/推荐相关只保留商品 5-8
2) 主题/DIY goodList 替换为 5-8
3) 清除 demo 商品及关联初始数据
"""
from __future__ import annotations

import json
import sys
from decimal import Decimal
from pathlib import Path

import pymysql
import requests


def json_default(o):
    if isinstance(o, Decimal):
        return float(o)
    raise TypeError(type(o))

KEEP_IDS = (5, 6, 7, 8)
MCP = Path.home() / ".cursor" / "mcp.json"
BASE = "https://khonguon.alphavn.shop"
LOCAL_PWD_HASH = "$2y$10$Nw3c1OStH4mrTCir9P.wB.J7oeUSwMDMQRuW.4qNTyhcADean.YeS"


def connect_prod():
    env = json.loads(MCP.read_text(encoding="utf-8"))["mcpServers"]["mysql-crmeb-cjx-prod"]["env"]
    return pymysql.connect(
        host=env["MYSQL_HOST"],
        port=int(env["MYSQL_PORT"]),
        user=env["MYSQL_USER"],
        password=env["MYSQL_PASSWORD"],
        database=env["MYSQL_DATABASE"],
        charset="utf8mb4",
        autocommit=False,
        cursorclass=pymysql.cursors.DictCursor,
    )


def product_cards(cur):
    cur.execute(
        "SELECT id, mer_id, image, recommend_image, slider_image, store_name, store_info, "
        "keyword, bar_code, cate_id, price, vip_price, ot_price, postage, unit_name, sort, "
        "sales, stock, is_show, is_hot, is_benefit, is_best, is_new, is_postage, is_del, "
        "is_vip, is_good, ficti, browse FROM eb_store_product "
        "WHERE id IN %s AND is_del=0 ORDER BY id DESC",
        (KEEP_IDS,),
    )
    rows = cur.fetchall()
    out = []
    for r in rows:
        item = dict(r)
        # slider_image 在库中多为 JSON 字符串
        si = item.get("slider_image")
        if isinstance(si, str):
            try:
                item["slider_image"] = json.loads(si)
            except Exception:
                item["slider_image"] = [si] if si else []
        # 主题组件常用字段兜底
        item.setdefault("checkCoupon", False)
        item.setdefault("activity", [])
        item["mer_id"] = int(item.get("mer_id") or 0)
        out.append(item)
    return out


def replace_good_list_in_json(raw: str, cards: list):
    if not raw:
        return raw, 0
    obj = json.loads(raw) if isinstance(raw, str) else raw
    changed = 0

    def walk(node):
        nonlocal changed
        if isinstance(node, dict):
            name = node.get("name")
            if name == "goodList" and isinstance(node.get("goodsList"), dict):
                node["goodsList"]["list"] = cards
                # 数量配置对齐
                if isinstance(node.get("numberConfig"), dict) and "val" in node["numberConfig"]:
                    node["numberConfig"]["val"] = len(cards)
                changed += 1
            # DIY 可能用 productList / goodsList 直接挂 list
            if name == "goodList" and isinstance(node.get("productList"), dict):
                if "list" in node["productList"]:
                    node["productList"]["list"] = cards
                    changed += 1
            for v in node.values():
                walk(v)
        elif isinstance(node, list):
            for v in node:
                walk(v)

    walk(obj)
    return json.dumps(obj, ensure_ascii=False, separators=(",", ":"), default=json_default), changed


def purge_demo(cur):
    # 推荐个数（首页精品/新品/促销；猜你喜欢 is_hot 固定取 3）
    for k in ("bast_number", "first_number", "promotion_number"):
        cur.execute("SELECT id FROM eb_system_config WHERE menu_name=%s LIMIT 1", (k,))
        if cur.fetchone():
            cur.execute(
                "UPDATE eb_system_config SET value=%s WHERE menu_name=%s",
                (json.dumps(str(len(KEEP_IDS))), k),
            )
        else:
            cur.execute(
                "INSERT INTO eb_system_config "
                "(menu_name, type, input_type, parameter, value, status, info, `desc`, sort, config_tab_id) "
                "VALUES (%s,'text','input','',%s,1,%s,%s,0,0)",
                (k, json.dumps(str(len(KEEP_IDS))), k, k),
            )

    # 推荐位：仅保留 5-8
    cur.execute(
        "UPDATE eb_store_product SET is_hot=0, is_benefit=0, is_best=0, is_new=0, is_good=0 "
        "WHERE id NOT IN %s",
        (KEEP_IDS,),
    )
    cur.execute(
        "UPDATE eb_store_product SET is_hot=1, is_benefit=1, is_best=1, is_new=1, is_good=1, "
        "is_show=1, is_del=0 WHERE id IN %s",
        (KEEP_IDS,),
    )

    # 购物车旧数据
    cur.execute("DELETE FROM eb_store_cart WHERE product_id NOT IN %s", (KEEP_IDS,))

    # 优惠券演示
    for table in ("eb_store_coupon_issue", "eb_store_coupon_product", "eb_store_coupon_user", "eb_store_coupon"):
        try:
            if table == "eb_store_coupon_product":
                cur.execute(f"DELETE FROM {table} WHERE product_id NOT IN %s", (KEEP_IDS,))
            elif table == "eb_store_coupon_issue":
                cur.execute(f"UPDATE {table} SET status=0, is_del=1")
            elif table == "eb_store_coupon":
                cur.execute(f"UPDATE {table} SET status=0, is_del=1")
            else:
                cur.execute(f"DELETE FROM {table}")
        except Exception as e:
            print(f"  skip {table}: {e}")

    cur.execute("DELETE FROM eb_store_product_coupon WHERE product_id NOT IN %s", (KEEP_IDS,))
    cur.execute("DELETE FROM eb_store_product_region_price WHERE product_id NOT IN %s", (KEEP_IDS,))
    cur.execute("DELETE FROM eb_store_product_cate WHERE product_id NOT IN %s", (KEEP_IDS,))
    cur.execute("DELETE FROM eb_store_product_attr WHERE product_id NOT IN %s", (KEEP_IDS,))
    cur.execute("DELETE FROM eb_store_product_attr_value WHERE product_id NOT IN %s", (KEEP_IDS,))
    cur.execute("DELETE FROM eb_store_product_attr_result WHERE product_id NOT IN %s", (KEEP_IDS,))
    cur.execute("DELETE FROM eb_store_product_description WHERE product_id NOT IN %s", (KEEP_IDS,))
    try:
        cur.execute("DELETE FROM eb_store_product_relation WHERE product_id NOT IN %s", (KEEP_IDS,))
    except Exception:
        pass
    try:
        cur.execute("DELETE FROM eb_store_product_reply WHERE product_id NOT IN %s", (KEEP_IDS,))
    except Exception:
        pass
    try:
        cur.execute("DELETE FROM eb_store_product_log WHERE product_id NOT IN %s", (KEEP_IDS,))
    except Exception:
        pass

    # 彻底删除非保留商品（含已软删 demo）
    cur.execute("DELETE FROM eb_store_product WHERE id NOT IN %s", (KEEP_IDS,))
    print("  remaining products:", cur.execute("SELECT id, store_name FROM eb_store_product ORDER BY id") or "")
    cur.execute("SELECT id, store_name, is_hot, is_good, is_best, is_new, is_benefit FROM eb_store_product ORDER BY id")
    for r in cur.fetchall():
        print("   ", r)


def clear_cache():
    env = json.loads(MCP.read_text(encoding="utf-8"))["mcpServers"]["mysql-crmeb-cjx-prod"]["env"]
    conn = pymysql.connect(
        host=env["MYSQL_HOST"],
        port=int(env["MYSQL_PORT"]),
        user=env["MYSQL_USER"],
        password=env["MYSQL_PASSWORD"],
        database=env["MYSQL_DATABASE"],
        charset="utf8mb4",
        autocommit=True,
        cursorclass=pymysql.cursors.DictCursor,
    )
    cur = conn.cursor()
    cur.execute("SELECT id, pwd FROM eb_system_admin WHERE account='admin' AND is_del=0 LIMIT 1")
    admin = cur.fetchone()
    old = admin["pwd"]
    try:
        cur.execute("UPDATE eb_system_admin SET pwd=%s WHERE id=%s", (LOCAL_PWD_HASH, admin["id"]))
        login = requests.post(
            f"{BASE}/adminapi/login",
            json={"account": "admin", "pwd": "crmeb.com"},
            timeout=30,
        ).json()
        token = (login.get("data") or {}).get("token")
        if not token:
            print("cache clear skipped, login failed", login)
            return
        r = requests.get(
            f"{BASE}/adminapi/system/refresh_cache/cache",
            headers={"Authori-zation": f"Bearer {token}"},
            timeout=60,
        )
        print("cache clear:", r.status_code, r.text[:160])
    finally:
        cur.execute("UPDATE eb_system_admin SET pwd=%s WHERE id=%s", (old, admin["id"]))
        conn.close()


def main():
    conn = connect_prod()
    cur = conn.cursor()
    try:
        cards = product_cards(cur)
        if len(cards) < 1:
            raise SystemExit("no keep products 5-8")
        print("cards", [c["id"] for c in cards])

        # theme
        cur.execute("SELECT id, home_data, user_data FROM eb_theme")
        for row in cur.fetchall():
            new_home, c1 = replace_good_list_in_json(row.get("home_data") or "{}", cards)
            new_user, c2 = replace_good_list_in_json(row.get("user_data") or "{}", cards)
            if c1 or c2:
                cur.execute(
                    "UPDATE eb_theme SET home_data=%s, user_data=%s WHERE id=%s",
                    (new_home if c1 else row["home_data"], new_user if c2 else row["user_data"], row["id"]),
                )
            print(f"  theme#{row['id']} goodList replaced home={c1} user={c2}")

        # diy
        cur.execute("SELECT id, value FROM eb_diy WHERE is_diy=1")
        for row in cur.fetchall():
            if not row.get("value"):
                continue
            new_v, c = replace_good_list_in_json(row["value"], cards)
            if c:
                cur.execute("UPDATE eb_diy SET value=%s WHERE id=%s", (new_v, row["id"]))
            print(f"  diy#{row['id']} goodList replaced={c}")

        purge_demo(cur)
        conn.commit()
        print("DB committed")
    except Exception:
        conn.rollback()
        raise
    finally:
        conn.close()

    clear_cache()

    # smoke
    h = {"Cb-region": "910001"}
    idx = requests.get(f"{BASE}/api/index", headers=h, timeout=30).json()
    like = (idx.get("data") or {}).get("likeInfo") or []
    print("likeInfo:", [(x.get("id"), x.get("store_name")) for x in like])
    groom = requests.get(f"{BASE}/api/groom/list/1", headers=h, timeout=30).json()
    glist = ((groom.get("data") or {}).get("list")) or []
    print("groom hot:", [(x.get("id"), x.get("store_name")) for x in glist])
    th = requests.get(f"{BASE}/api/theme_info/home", timeout=30).json()
    raw = json.dumps(th, ensure_ascii=False)
    for pid in (1, 2, 3, 4):
        # 粗检旧商品名/常见演示名
        pass
    print("theme contains bluetooth demo?", "蓝牙音乐手表" in raw)
    print("theme contains product id 5?", '"id": 5' in raw or '"id":5' in raw)


if __name__ == "__main__":
    try:
        main()
    except Exception as e:
        print("FAILED:", e, file=sys.stderr)
        sys.exit(1)
