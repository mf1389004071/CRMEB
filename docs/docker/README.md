# 本地 Docker（cjx-mysql + cjx-php）

完整步骤见 [`../本地开发环境搭建教程.md`](../本地开发环境搭建教程.md)。

## 一键启停

在**仓库根目录**：

```powershell
# 首次：构建 PHP 镜像并启动
docker compose -f docs/docker/docker-compose.yml up -d --build

# 日常
docker compose -f docs/docker/docker-compose.yml start
docker compose -f docs/docker/docker-compose.yml stop
docker compose -f docs/docker/docker-compose.yml down          # 不删数据卷
docker compose -f docs/docker/docker-compose.yml down -v      # 删库数据，慎用
```

| 服务 | 容器名 | 端口 | 说明 |
|------|--------|------|------|
| mysql | cjx-mysql | 33060→3306 | root/root，库 crmeb；同网络主机名 `mysql` |
| php | cjx-php | 8089 | 挂载 `crmeb` → `/app` |

## 数据库账号（任意来源可连）

| 用户 | 密码 | 主机 | 插件 |
|------|------|------|------|
| root | root | `%` / `localhost` | `mysql_native_password` |
| crmeb | root | `%` / `localhost` | `mysql_native_password` |

- 宿主机客户端：`127.0.0.1:33060`
- PHP（compose 内）：主机 `mysql`，端口 `3306`
- 已有数据卷权限修复：`docs/docker/mysql/grant-any-host.sql`

## 目录

```text
docs/docker/
  docker-compose.yml
  dev-php74.Dockerfile
  mysql/conf.d/cjx.cnf          # utf8mb4 + native_password + 空 sql_mode
  mysql/init/01-grant-any-host.sql   # 仅首次初始化执行
  mysql/grant-any-host.sql      # 已有库手动补授权
```

说明：Docker Desktop（Windows）可能忽略 compose `configs` 的 `mode`；关键参数已在 `command:` 中写死（`default-authentication-plugin`、`sql-mode`、`bind-address`），不影响连通。