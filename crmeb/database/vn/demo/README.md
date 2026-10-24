# 菜集鲜演示数据

| 文件 | 说明 |
|------|------|
| `001_demo_data.sql` | 联系方式、开放/热门城市、4 个生鲜演示商品、区域价、多语 |

**执行时机**：先按 `../README.md` 跑完 `000～100` 迁移，再执行本目录脚本。

```bash
# Docker 示例
docker exec -i cjx-mysql mysql -uroot -proot --default-character-set=utf8mb4 crmeb < crmeb/database/vn/demo/001_demo_data.sql
```

演示价目场景（商品 1～4）：
- 商品1：河内 / Ba Đình / Hoàn Kiếm 分层价（兄弟不串）
- 商品2：仅挂国家层 VN 价（向上回落）
- 商品3：河内与 Ba Đình
- 商品4：河内与 Ba Đình + 商品允许全国价
