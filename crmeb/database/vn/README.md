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
