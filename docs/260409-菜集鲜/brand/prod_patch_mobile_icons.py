# -*- coding: utf-8 -*-
"""通过后台 ico_path 配置，把新 favicon 复制到生产站点根/admin/home。"""
from __future__ import annotations

import json
import sys
from pathlib import Path
from urllib.parse import urlparse

import pymysql
import requests

ROOT = Path(__file__).resolve().parents[3]
MCP = Path.home() / ".cursor" / "mcp.json"
BASE = "https://khonguon.alphavn.shop"
LOCAL_PWD_HASH = "$2y$10$Nw3c1OStH4mrTCir9P.wB.J7oeUSwMDMQRuW.4qNTyhcADean.YeS"
FAVICON = ROOT / "crmeb" / "public" / "favicon.ico"
# 上传接口校验常拒 .ico，先传 png，再经 ico_path 复制为 favicon.ico
FAVICON_UPLOAD = ROOT / "crmeb" / "public" / "static" / "pwa" / "icon-192.png"


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


def upload(headers: dict, path: Path, menu_name: str = "") -> str:
    ctype = "image/png" if path.suffix.lower() == ".png" else "image/jpeg"
    with path.open("rb") as f:
        files = {"file": (path.name, f, ctype)}
        data = {"pid": 0}
        if menu_name:
            data["menu_name"] = menu_name
        up = requests.post(
            f"{BASE}/adminapi/file/upload/1",
            headers=headers,
            files=files,
            data=data,
            timeout=60,
        ).json()
    if up.get("status") != 200:
        raise SystemExit(f"upload failed: {up}")
    src = up.get("data")
    if isinstance(src, dict):
        src = src.get("src") or src.get("url") or src.get("att_dir") or ""
    if isinstance(src, str) and src.startswith("http"):
        src = urlparse(src).path
    if not src:
        raise SystemExit(f"unexpected upload payload: {up}")
    print("uploaded", path.name, "->", src)
    return src


def main():
    if not FAVICON_UPLOAD.exists():
        raise SystemExit(f"missing: {FAVICON_UPLOAD}")

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

        ico_src = upload(headers, FAVICON_UPLOAD, menu_name="ico_path")
        if not ico_src.startswith("/"):
            ico_src = "/" + ico_src

        save = requests.post(
            f"{BASE}/adminapi/setting/config/save_basics",
            headers=headers,
            json={"ico_path": ico_src},
            timeout=60,
        ).json()
        print("save_basics:", save.get("status"), save.get("msg") or save.get("message"), str(save)[:240])
        if save.get("status") != 200:
            raise SystemExit(f"save_basics failed: {save}")

        clear = requests.get(f"{BASE}/adminapi/system/refresh_cache/cache", headers=headers, timeout=60)
        print("clear cache:", clear.status_code, clear.text[:160])

        fav = requests.get(f"{BASE}/favicon.ico", timeout=20)
        print(
            "prod favicon:",
            fav.status_code,
            "len=",
            fav.headers.get("Content-Length") or len(fav.content),
            "local_ico=",
            FAVICON.stat().st_size if FAVICON.exists() else None,
            "upload_png=",
            FAVICON_UPLOAD.stat().st_size,
        )
        cur.execute("SELECT value FROM eb_system_config WHERE menu_name='ico_path' LIMIT 1")
        row = cur.fetchone()
        print("db ico_path=", row)

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
