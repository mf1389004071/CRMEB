# -*- coding: utf-8 -*-
"""临时用本地 admin 密码哈希登录生产后台：清缓存 + 上传 logo 并写入配置，最后恢复原密码哈希。"""
from __future__ import annotations

import json
import sys
from pathlib import Path
from urllib.parse import quote, urlparse

import pymysql
import requests

ROOT = Path(__file__).resolve().parents[3]
LOGO = ROOT / "docs" / "260409-菜集鲜" / "logo.jpg"
MCP = Path.home() / ".cursor" / "mcp.json"
BASE = "https://khonguon.alphavn.shop"
LOCAL_PWD_HASH = "$2y$10$Nw3c1OStH4mrTCir9P.wB.J7oeUSwMDMQRuW.4qNTyhcADean.YeS"  # crmeb.com @ local


def prod_cfg():
    env = json.loads(MCP.read_text(encoding="utf-8"))["mcpServers"]["mysql-crmeb-cjx-prod"]["env"]
    return {
        "host": env["MYSQL_HOST"],
        "port": int(env.get("MYSQL_PORT", 3306)),
        "user": env["MYSQL_USER"],
        "password": env["MYSQL_PASSWORD"],
        "database": env["MYSQL_DATABASE"],
        "charset": "utf8mb4",
        "cursorclass": pymysql.cursors.DictCursor,
        "autocommit": True,
    }


def main():
    if not LOGO.exists():
        raise SystemExit(f"missing logo: {LOGO}")
    conn = pymysql.connect(**prod_cfg())
    cur = conn.cursor()
    cur.execute("SELECT id, pwd FROM eb_system_admin WHERE account='admin' AND is_del=0 LIMIT 1")
    admin = cur.fetchone()
    if not admin:
        raise SystemExit("admin not found")
    old_pwd = admin["pwd"]
    print("backup admin pwd hash ok")
    try:
        cur.execute("UPDATE eb_system_admin SET pwd=%s WHERE id=%s", (LOCAL_PWD_HASH, admin["id"]))
        login = requests.post(
            f"{BASE}/adminapi/login",
            json={"account": "admin", "pwd": "crmeb.com"},
            timeout=30,
        ).json()
        if login.get("status") != 200:
            raise SystemExit(f"login failed: {login}")
        token = login["data"]["token"]
        headers = {"Authori-zation": f"Bearer {token}"}

        # 先上传/改配置，最后再清缓存（清缓存会干掉 token 会话）
        with LOGO.open("rb") as f:
            up = requests.post(
                f"{BASE}/adminapi/file/upload/1",
                headers=headers,
                files={"file": ("khonguon-logo.jpg", f, "image/jpeg")},
                timeout=60,
            ).json()
        print("upload:", up.get("status"), str(up)[:300])
        if up.get("status") != 200:
            raise SystemExit("upload failed")
        path = up["data"]["src"] if isinstance(up.get("data"), dict) else up.get("data")
        if isinstance(path, dict):
            path = path.get("src") or path.get("url") or ""
        if isinstance(path, str) and path.startswith("http"):
            path = urlparse(path).path
        if not path:
            raise SystemExit(f"unexpected upload payload: {up}")
        print("logo path:", path)

        for key in ("site_logo", "site_logo_square", "login_logo", "wap_login_logo", "pc_logo", "wechat_share_img"):
            val = json.dumps(path, ensure_ascii=False)
            cur.execute("UPDATE eb_system_config SET value=%s WHERE menu_name=%s", (val, key))

        clear = requests.get(f"{BASE}/adminapi/system/refresh_cache/cache", headers=headers, timeout=60)
        print("clear cache:", clear.status_code, clear.text[:200])

        basic = requests.get(f"{BASE}/api/basic_config", timeout=30).json()
        copyright = requests.get(f"{BASE}/api/copyright", timeout=30).json()
        contacts = requests.get(f"{BASE}/api/vn/contacts", timeout=30).json()
        print("site_name=", basic.get("data", {}).get("site_name"))
        print("copyright=", copyright.get("data", {}).get("copyrightContext"))
        print("contacts=", contacts.get("data"))
        print("wap_logo=", basic.get("data", {}).get("wap_login_logo"))
    finally:
        cur.execute("UPDATE eb_system_admin SET pwd=%s WHERE id=%s", (old_pwd, admin["id"]))
        print("restored admin pwd hash")
        conn.close()


if __name__ == "__main__":
    try:
        main()
    except Exception as e:
        print("FAILED:", e, file=sys.stderr)
        sys.exit(1)
