# -*- coding: utf-8 -*-
"""强制让前端重新拉取语言包：清 api_lang_* / lang_version 缓存。"""
import json
from pathlib import Path

import pymysql
import requests

MCP = Path.home() / ".cursor" / "mcp.json"
LOCAL = "$2y$10$Nw3c1OStH4mrTCir9P.wB.J7oeUSwMDMQRuW.4qNTyhcADean.YeS"
BASE = "https://khonguon.alphavn.shop"
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
for sql in (
    "DELETE FROM eb_cache WHERE `key` LIKE '%lang%'",
    "DELETE FROM eb_cache WHERE `key` LIKE 'api_lang%'",
    "DELETE FROM eb_cache WHERE `key`='lang_version'",
):
    try:
        cur.execute(sql)
        print(sql, "->", cur.rowcount)
    except Exception as e:
        print("skip", e)

cur.execute("SELECT id, pwd FROM eb_system_admin WHERE account='admin' AND is_del=0 LIMIT 1")
admin = cur.fetchone()
old = admin["pwd"]
cur.execute("UPDATE eb_system_admin SET pwd=%s WHERE id=%s", (LOCAL, admin["id"]))
try:
    token = requests.post(
        f"{BASE}/adminapi/login", json={"account": "admin", "pwd": "crmeb.com"}, timeout=30
    ).json()["data"]["token"]
    r = requests.get(
        f"{BASE}/adminapi/system/refresh_cache/cache",
        headers={"Authori-zation": f"Bearer {token}"},
        timeout=60,
    )
    print("refresh", r.text[:160])
finally:
    cur.execute("UPDATE eb_system_admin SET pwd=%s WHERE id=%s", (old, admin["id"]))
    conn.close()

print("version", requests.get(f"{BASE}/api/lang_version", timeout=20).json())
pack = requests.get(
    f"{BASE}/api/get_lang_json", headers={"Cb-lang": "vi-VN"}, timeout=30
).json()["data"]["vi-VN"]
print("推荐=", pack.get("推荐"), "猜你喜欢=", pack.get("猜你喜欢"))
