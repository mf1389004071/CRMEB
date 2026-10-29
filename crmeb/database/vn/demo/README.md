# 菜集鲜演示数据

| 文件 | 说明 |
|------|------|
| `001_demo_data.sql` | 联系方式、开放/热门城市、4 个生鲜演示商品、区域价、多语 |
| `002_warehouse_demo.sql` | 提货仓库多场景（依赖 `031/032` 迁移 + 021 区划） |

**执行时机**：先按 `../README.md` 跑完迁移（含 `031_warehouse.sql`、`032_warehouse_menu.sql`），再执行本目录脚本。

```bash
# Docker 示例
docker exec -i cjx-mysql mysql -uroot -proot --default-character-set=utf8mb4 crmeb < crmeb/database/vn/demo/001_demo_data.sql
docker exec -i cjx-mysql mysql -uroot -proot --default-character-set=utf8mb4 crmeb < crmeb/database/vn/demo/002_warehouse_demo.sql
```

演示价目场景（商品 1～4）：
- 商品1：河内 / Ba Đình / Hoàn Kiếm 分层价（兄弟不串）
- 商品2：仅挂国家层 VN 价（向上回落）
- 商品3：河内与 Ba Đình
- 商品4：河内与 Ba Đình + 商品允许全国价

提货仓场景（`002`）：
- `WH-HN-MAIN` / `WH-HN-SUB`：河内同城双仓（默认+可改选）
- `WH-HN-WARD`：仅 Phúc Xá 精确匹配
- `WH-HCM` / `WH-DN`：胡志明、岘港默认仓
- `WH-HP-MANUAL`：海防仓但不参与自动匹配
