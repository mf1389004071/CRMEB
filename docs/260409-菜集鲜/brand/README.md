# Kho Nguon 品牌与合同后初始化

## 文件

| 文件 | 说明 |
|------|------|
| `gen_logo_assets.py` | 从 `../logo.jpg` 生成各端 logo/favicon/PWA |
| `apply_khonguon_init.py` | 对指定库执行品牌/城仓/商品清理 + 主题/我的菜单收敛 |
| [`crmeb/database/vn/brand/khonguon_brand_seed.sql`](../../../crmeb/database/vn/brand/khonguon_brand_seed.sql) | 站点名/域名/联系/版权/vn_contact/关于我们 |
| [`khonguon_cities_warehouses.sql`](../../../crmeb/database/vn/brand/khonguon_cities_warehouses.sql) | 15 城 + 缺仓占位 + 清化真实地址 |
| [`khonguon_products_categories.sql`](../../../crmeb/database/vn/brand/khonguon_products_categories.sql) | 保留生鲜商品，隐藏数码分类 |
| `261110-生产保留数据清单.md` | 生产库应保留数据快照 |

## 用法

```powershell
# 1) 生成 logo 资源
python docs/260409-菜集鲜/brand/gen_logo_assets.py

# 2) 本地 Docker 库
python docs/260409-菜集鲜/brand/apply_khonguon_init.py --mysql "mysql://root:root@127.0.0.1:33060/crmeb" --prod-keep-check

# 3) 生产库（从 mcp.json 读库配置）
python docs/260409-菜集鲜/brand/run_apply_from_mcp.py mysql-crmeb-cjx-prod

# 4) 生产清缓存 + 上传 logo（临时借用本地 admin 密码哈希，结束后自动恢复）
python docs/260409-菜集鲜/brand/prod_clear_cache_upload_logo.py

# 5) 清 demo 商品，并把猜你喜欢/主题 goodList 换成商品 5-8
python docs/260409-菜集鲜/brand/purge_demo_replace_recommend.py

# 6) 隐藏「猜你喜欢」文案，统一为可国际化「推荐」
python docs/260409-菜集鲜/brand/replace_like_with_recommend.py
```

同分支其他项目：复制 `crmeb/database/vn/brand/` 下 SQL，改站点名/域名/联系方式后执行即可。

前端硬编码（需重新编译管理端/H5 后才全量生效）：`VUE_APP_TITLE`、`manifest.json`、PWA manifest、协议 HTML、favicon。
