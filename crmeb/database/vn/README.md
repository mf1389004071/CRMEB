# 菜集鲜（越南站）数据库迁移

## 执行顺序
1. 先安装基线：`public/install/crmeb.sql`（**不要修改**该文件）。
2. 按文件名序号依次执行本目录 `NNN_*.sql`（表前缀默认 `eb_`，如不同请整体替换）：
   `000 → 001 → 010 → 020 → 021 → 030 → … → 100 → 900`
3. （可选开发演示）再执行 `demo/001_demo_data.sql`
4. 执行后清理缓存（后台“清除缓存”或删 `runtime/cache`）。

**编码（必读）**：所有 SQL 必须用 **utf8mb4** 客户端导入（`--default-character-set=utf8mb4`，脚本内 `SET NAMES utf8mb4`）。  
PowerShell 管道导入时还需 `Get-Content -Encoding UTF8`（`run_all.ps1` 已处理）。若用默认 ANSI/latin1 导入，中文与越文声调会在入库时被替换成字面量 `?`（不可逆），表现就是「切中文商品名全是问号」——多语配置行还在，只是 `value` 已坏。  
推荐一律走下面一键脚本，避免手工 `source` 漏 charset。

Windows / Docker 一键：

```powershell
powershell -File crmeb/database/vn/run_all.ps1
```

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
新增词条或配置后需清缓存：`rm -rf crmeb/runtime/cache`，并删 `eb_cache` 中 `lang_version` / `api_lang_*`（或后台「清除缓存」），以便 `lang_version` 变新、H5 重新拉语言包。

词条维护：
- 业务新增：编辑 `lang_codes.tsv` 后运行 `python scripts/vn_lang_codes_to_sql.py` 生成 `900_lang_codes.sql`。
- 对齐 uni-app `$t` 缺口：`python scripts/i18n_extract_uni_t_keys.py --mysql "mysql://root:root@127.0.0.1:33060/crmeb" --emit-sql crmeb/database/vn/101_uni_t_keys_fill.sql --emit-tsv-append crmeb/database/vn/lang_codes.tsv --translate-gtx`（再执行 `101_*.sql` / `102_*.sql`）。
- 说明：DIY 装修标题、分类名、商品名等业务内容：分类走 `eb_i18n_content`（见 `103_vn_ui_i18n_fix.sql`）；DIY 文案在前端用 `$t(配置中文)` 对齐语言包。
- 空态图文案：`105_empty_state_ui_keys.sql`（地址/收藏空态；`noAddress.png` / `noCollection.png` 已裁掉内嵌中文）。
- 版权：`nncnL_crmeb_copyright` 默认 `Copyright © Alpha Fangding. All rights reserved.`（`103_*.sql`）。
- 未登录切语言：设置页 `/pages/users/user_info/index` 已放开登录门禁；「我的」页顶部也有语言入口。

## 前端金额展示约定（M6-4）
- 页面一律使用 `$money(本位币金额)` 或 `<BaseMoney :money="本位币金额">`，**不得手写 ￥/千分位**；
- 已用脚本把模板内 “`$t(\`￥\`)` + 金额” / “￥{{金额}}” 模式批量替换为 `$money(...)`；
- 仍保留的少量纯符号位置（后台改价弹窗的单位标签、充值/线下收款页等已被越南模式关闭的页面）不影响主流程。
