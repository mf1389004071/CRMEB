# 本地 Docker（cjx-mysql + cjx-php + cjx-nginx）

完整步骤见 [`../deploy/本地开发环境搭建教程.md`](../deploy/本地开发环境搭建教程.md)。

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

# 已有旧 php -S 环境：拉代码后执行 up -d 即可切到 Nginx+FPM（详见教程 §10）
docker compose -f docs/docker/docker-compose.yml up -d
```

| 服务 | 容器名 | 端口 | 说明 |
|------|--------|------|------|
| mysql | cjx-mysql | 33060→3306 | root/root，库 crmeb；同网络主机名 `mysql` |
| php | cjx-php | 9000（仅容器网） | PHP-FPM + OPcache，挂载 `crmeb` → `/app` |
| nginx | cjx-nginx | 8089→80 | 反代 FPM；勿再用旧的 `php -S` |

**后台登录：** http://localhost:8089/admin/  
**账号：** `admin`  
**密码：** `crmeb.com`（基线默认；若安装/后台改过则以实际为准）

登录后若提示消息队列 / 定时任务 / 长连接未开启：见 [`../deploy/消息队列定时任务与长连接说明.md`](../deploy/消息队列定时任务与长连接说明.md)。

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