# -*- coding: utf-8 -*-
"""从 Cursor mcp.json 读取 mysql-crmeb-cjx-prod 并执行 apply_khonguon_init.py。"""
import json
import subprocess
import sys
from pathlib import Path
from urllib.parse import quote

HERE = Path(__file__).resolve().parent
APPLY = HERE / "apply_khonguon_init.py"
MCP = Path.home() / ".cursor" / "mcp.json"


def main():
    target = sys.argv[1] if len(sys.argv) > 1 else "mysql-crmeb-cjx-prod"
    mcp = json.loads(MCP.read_text(encoding="utf-8"))
    env = mcp["mcpServers"][target]["env"]
    user = quote(env["MYSQL_USER"], safe="")
    password = quote(env["MYSQL_PASSWORD"], safe="")
    host = env["MYSQL_HOST"]
    port = env.get("MYSQL_PORT", "3306")
    db = env["MYSQL_DATABASE"]
    url = f"mysql://{user}:{password}@{host}:{port}/{db}"
    cmd = [sys.executable, str(APPLY), "--mysql", url, "--prod-keep-check"]
    raise SystemExit(subprocess.call(cmd))


if __name__ == "__main__":
    main()
