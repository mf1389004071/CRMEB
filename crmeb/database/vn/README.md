# 菜集鲜（越南站）数据库迁移

## 执行顺序
1. 先安装基线：`public/install/crmeb.sql`（**不要修改**该文件）。
2. 按文件名序号依次执行本目录 `NNN_*.sql`（表前缀默认 `eb_`，如不同请整体替换）：
   `001 → 010 → 020 → 030 → 040 → 050 → 060 → 070 → 080 → 9xx`
3. 执行后清理缓存（后台“清除缓存”）。

```bash
mysql -uroot -p --default-character-set=utf8mb4 your_db < crmeb/database/vn/001_lang_vi_vn.sql
```

## 约定
- 所有脚本**幂等**：`CREATE TABLE IF NOT EXISTS`；加列通过存储过程 `eb_vn_add_column` 先查 `information_schema`
  （该过程由 `000_helpers.sql` 创建，**必须先执行**；脚本内用完即删或保留均可）。
- 每个脚本头部注释写明回滚方式。
- 新增的 `msg`/前端词条统一放 `9xx_lang_codes.sql`，三语齐全，越南语初稿 `remarks` 前缀 `[待审]`。

## 测试
`crmeb/tests/vn/*.php` 为可直接 `php` 运行的脚本（无 PHPUnit 依赖），例如：
```bash
php crmeb/tests/vn/lang_code_test.php
```

## 基线核对结论（M0/M1）
- 基线 `eb_lang_type` 已含 `vi-VN`（id=10）且词条完整（2521 条）；本迁移主要负责设默认语言与启用范围。
- `eb_system_city.level`：0=省(34) 1=市(369) 2=区(3536)，`parent_id=0` 为省级（M1 迁移时补充国家根的结论见 `020_region.sql`）。

## 本地测试环境（docker）
测试均直接操作测试库，**勿对生产库运行**。

**从零完整教程（推荐）：** `docs/deploy/本地开发环境搭建教程.md`  
**一键编排：** `docker compose -f docs/docker/docker-compose.yml up -d --build`（见 `docs/docker/README.md`）。

```bash
# 推荐：compose（PHP 连 mysql:3306；宿主机连 127.0.0.1:33060）
docker compose -f docs/docker/docker-compose.yml up -d --build
# 若客户端 1045：docker exec cjx-mysql mysql -uroot -proot -e "source /路径/grant-any-host.sql"
# 导基线 + vn 迁移后：
bash tests/vn/run.sh tests/vn/cod_order_test.php
```

旧版分别 `docker run`（不推荐，仅备用）：

```bash
# 1) 测试库：mysql:8.0，导入基线并按序执行 vn 迁移（000 → 001 → 010 …）
docker run -d --name cjx-mysql -e MYSQL_ROOT_PASSWORD=root -e MYSQL_DATABASE=crmeb -p 33060:3306 mysql:8.0 --character-set-server=utf8mb4 --default-authentication-plugin=mysql_native_password --sql-mode=""
# 2) HTTP 服务（供 *_api_test / e2e 使用）：需 crmeb/public/install.lock（已 gitignore）
echo 1 > crmeb/public/install.lock
docker run -d --name cjx-php --add-host=host.docker.internal:host-gateway -p 8089:8089 -v <repo>/crmeb:/app -w /app/public   -e DATABASE_HOSTNAME=host.docker.internal -e DATABASE_HOSTPORT=33060 -e DATABASE_DATABASE=crmeb -e DATABASE_USERNAME=root -e DATABASE_PASSWORD=root -e DATABASE_CHARSET=utf8mb4   dev-php74 php -S 0.0.0.0:8089 router.php
# 3) 运行测试（在 crmeb 目录）：
bash tests/vn/run.sh tests/vn/cod_order_test.php
```
新增词条或配置后需清缓存：`rm -rf crmeb/runtime/cache`。词条维护：编辑 `lang_codes.tsv` 后运行 `python scripts/vn_lang_codes_to_sql.py` 生成 `900_lang_codes.sql`。

## 前端金额展示约定（M6-4）
- 页面一律使用 `$money(本位币金额)` 或 `<BaseMoney :money="本位币金额">`，**不得手写 ￥/千分位**；
- 已用脚本把模板内 “`$t(\`￥\`)` + 金额” / “￥{{金额}}” 模式批量替换为 `$money(...)`；
- 仍保留的少量纯符号位置（后台改价弹窗的单位标签、充值/线下收款页等已被越南模式关闭的页面）不影响主流程。
