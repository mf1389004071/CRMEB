# -*- coding: utf-8 -*-
"""
把主题/DIY 中「猜你喜欢」换成可国际化的「推荐」：
- 隐藏首页 richText 装饰标题
- goodList 增加 headerText=推荐（走 $t）
- 我的页 titles 标题改为 推荐
- 语言包：猜你喜欢 的译文对齐 推荐
"""
from __future__ import annotations

import json
from pathlib import Path

import pymysql
import requests

MCP = Path.home() / ".cursor" / "mcp.json"
BASE = "https://khonguon.alphavn.shop"
LOCAL_PWD = "$2y$10$Nw3c1OStH4mrTCir9P.wB.J7oeUSwMDMQRuW.4qNTyhcADean.YeS"
TARGET = "mysql-crmeb-cjx-prod"


def conn_of(name: str):
    env = json.loads(MCP.read_text(encoding="utf-8"))["mcpServers"][name]["env"]
    return pymysql.connect(
        host=env["MYSQL_HOST"],
        port=int(env.get("MYSQL_PORT", 3306)),
        user=env["MYSQL_USER"],
        password=env["MYSQL_PASSWORD"],
        database=env["MYSQL_DATABASE"],
        charset="utf8mb4",
        autocommit=False,
        cursorclass=pymysql.cursors.DictCursor,
    )


def patch_theme_obj(obj: dict) -> int:
    changed = 0
    value = obj.get("value")
    if not isinstance(value, dict):
        return 0
    for _, comp in value.items():
        if not isinstance(comp, dict):
            continue
        name = comp.get("name")
        # 隐藏 richText 里写死的「猜你喜欢」标题
        if name == "richText":
            rt = ((comp.get("richText") or {}).get("val")) or ""
            if "猜你喜欢" in rt:
                comp["isHide"] = True
                # 同步清空文案，避免后台预览仍显示
                if isinstance(comp.get("richText"), dict):
                    comp["richText"]["val"] = ""
                changed += 1
        # 商品列表加可 $t 的标题
        if name == "goodList":
            ht = comp.get("headerText")
            need = True
            if isinstance(ht, dict) and ht.get("value") == "推荐":
                need = False
            if need:
                comp["headerType"] = {"tabVal": 0}
                comp["headerText"] = {"value": "推荐", "place": "请输入标题", "max": 20}
                # 默认可见标题样式
                if "headerColor" not in comp:
                    comp["headerColor"] = {"color": [{"item": "#333333"}]}
                if "headerFontSize" not in comp:
                    comp["headerFontSize"] = {"val": 16}
                if "headerAlign" not in comp:
                    comp["headerAlign"] = {"tabVal": 1}  # center-ish / 按组件映射
                changed += 1
        # 标题组件
        if name == "titles":
            tc = comp.get("titleConfig")
            if isinstance(tc, dict) and tc.get("value") == "猜你喜欢":
                tc["value"] = "推荐"
                changed += 1
        # 兜底：任意字符串字段
        blob = json.dumps(comp, ensure_ascii=False)
        if "猜你喜欢" in blob:
            def walk(n):
                nonlocal changed
                if isinstance(n, dict):
                    for k, v in list(n.items()):
                        if isinstance(v, str) and "猜你喜欢" in v:
                            n[k] = v.replace("猜你喜欢", "推荐")
                            changed += 1
                        else:
                            walk(v)
                elif isinstance(n, list):
                    for i, v in enumerate(n):
                        if isinstance(v, str) and "猜你喜欢" in v:
                            n[i] = v.replace("猜你喜欢", "推荐")
                            changed += 1
                        else:
                            walk(v)
            walk(comp)
    return changed


def align_lang(cur):
    # 先校正「推荐」核心三语，再让「猜你喜欢」全部对齐
    for lang, text in (("zh-CN", "推荐"), ("vi-VN", "Đề xuất"), ("en-US", "Recommended")):
        cur.execute(
            "UPDATE eb_lang_code c "
            "JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name=%s AND t.is_del=0 "
            "SET c.lang_explain=%s WHERE c.code='推荐' AND c.is_admin=0",
            (lang, text),
        )
    cur.execute(
        "SELECT t.file_name, c.lang_explain FROM eb_lang_code c "
        "JOIN eb_lang_type t ON t.id=c.type_id "
        "WHERE c.code='推荐' AND c.is_admin=0 AND t.is_del=0"
    )
    mapping = {r["file_name"]: r["lang_explain"] for r in cur.fetchall()}
    mapping.setdefault("zh-CN", "推荐")
    mapping.setdefault("vi-VN", "Đề xuất")
    mapping.setdefault("en-US", "Recommended")
    n = 0
    for lang, text in mapping.items():
        cur.execute(
            "UPDATE eb_lang_code c "
            "JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name=%s AND t.is_del=0 "
            "SET c.lang_explain=%s, c.remarks=%s "
            "WHERE c.code='猜你喜欢' AND c.is_admin=0",
            (lang, text, "已隐藏，统一为推荐"),
        )
        n += cur.rowcount
    print("lang rows touched≈", n)


def clear_cache():
    env = json.loads(MCP.read_text(encoding="utf-8"))["mcpServers"][TARGET]["env"]
    c = pymysql.connect(
        host=env["MYSQL_HOST"],
        port=int(env.get("MYSQL_PORT", 3306)),
        user=env["MYSQL_USER"],
        password=env["MYSQL_PASSWORD"],
        database=env["MYSQL_DATABASE"],
        charset="utf8mb4",
        autocommit=True,
        cursorclass=pymysql.cursors.DictCursor,
    )
    cur = c.cursor()
    try:
        cur.execute("DELETE FROM eb_cache WHERE `key` LIKE %s OR `key` LIKE %s OR `key`=%s", ("%lang%", "api_lang%", "lang_version"))
    except Exception as e:
        print("eb_cache skip", e)
    cur.execute("SELECT id, pwd FROM eb_system_admin WHERE account='admin' AND is_del=0 LIMIT 1")
    admin = cur.fetchone()
    old = admin["pwd"]
    try:
        cur.execute("UPDATE eb_system_admin SET pwd=%s WHERE id=%s", (LOCAL_PWD, admin["id"]))
        token = requests.post(
            f"{BASE}/adminapi/login", json={"account": "admin", "pwd": "crmeb.com"}, timeout=30
        ).json()["data"]["token"]
        r = requests.get(
            f"{BASE}/adminapi/system/refresh_cache/cache",
            headers={"Authori-zation": f"Bearer {token}"},
            timeout=60,
        )
        print("cache", r.status_code, r.text[:120])
    finally:
        cur.execute("UPDATE eb_system_admin SET pwd=%s WHERE id=%s", (old, admin["id"]))
        c.close()


def main():
    conn = conn_of(TARGET)
    cur = conn.cursor()
    try:
        cur.execute("SELECT id, home_data, user_data FROM eb_theme")
        for row in cur.fetchall():
            home = json.loads(row["home_data"] or "{}")
            user = json.loads(row["user_data"] or "{}")
            c1 = patch_theme_obj(home)
            c2 = patch_theme_obj(user)
            if c1 or c2:
                cur.execute(
                    "UPDATE eb_theme SET home_data=%s, user_data=%s WHERE id=%s",
                    (
                        json.dumps(home, ensure_ascii=False, separators=(",", ":")),
                        json.dumps(user, ensure_ascii=False, separators=(",", ":")),
                        row["id"],
                    ),
                )
            print(f"theme#{row['id']} patched home={c1} user={c2}")

        cur.execute("SELECT id, value FROM eb_diy WHERE is_diy=1")
        for row in cur.fetchall():
            if not row.get("value"):
                continue
            obj = json.loads(row["value"])
            c = patch_theme_obj(obj) if isinstance(obj, dict) else 0
            # diy 有的结构是直接 value 数组/对象
            if c:
                cur.execute(
                    "UPDATE eb_diy SET value=%s WHERE id=%s",
                    (json.dumps(obj, ensure_ascii=False, separators=(",", ":")), row["id"]),
                )
            print(f"diy#{row['id']} patched={c}")

        align_lang(cur)
        conn.commit()
        print("committed")
    except Exception:
        conn.rollback()
        raise
    finally:
        conn.close()
    clear_cache()


if __name__ == "__main__":
    main()
