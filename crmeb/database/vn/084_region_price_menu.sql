-- M2-6 后台菜单：商品区域价页面（隐藏菜单，从商品列表“区域价”进入）及接口权限。幂等。
-- 回滚：DELETE FROM eb_system_menus WHERE unique_auth = 'admin-product-regionPrice' OR unique_auth LIKE 'regionprice-api-%';
SET NAMES utf8mb4;

INSERT INTO eb_system_menus (pid, icon, menu_name, module, controller, action, api_url, methods, params, sort, is_show, is_show_path, access, menu_path, path, auth_type, header, is_header, unique_auth, is_del, mark)
SELECT 1, '', '商品区域价', 'admin', '', '', '', '', '[]', 0, 0, 1, 1, '/product/region_price/:id', '1', 1, 'product', 0, 'admin-product-regionPrice', 0, '菜集鲜商品区域价(隐藏菜单)'
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM eb_system_menus WHERE unique_auth = 'admin-product-regionPrice');

SET @mid := (SELECT id FROM eb_system_menus WHERE unique_auth = 'admin-product-regionPrice' LIMIT 1);

DROP TEMPORARY TABLE IF EXISTS tmp_rp_api;
CREATE TEMPORARY TABLE tmp_rp_api (name varchar(32), api_url varchar(100), methods varchar(10), ua varchar(150));
INSERT INTO tmp_rp_api VALUES
('商品区域价读取', 'product/region_price/<product_id>', 'GET', 'regionprice-api-read'),
('商品区域价保存', 'product/region_price/<product_id>', 'POST', 'regionprice-api-save'),
('区域价导入模板', 'product/region_price/template', 'GET', 'regionprice-api-template'),
('区域价Excel导入', 'product/region_price/import', 'POST', 'regionprice-api-import'),
('区域价Excel导出', 'product/region_price/export', 'GET', 'regionprice-api-export');

INSERT INTO eb_system_menus (pid, icon, menu_name, module, controller, action, api_url, methods, params, sort, is_show, is_show_path, access, menu_path, path, auth_type, header, is_header, unique_auth, is_del, mark)
SELECT @mid, '', t.name, 'admin', '', '', t.api_url, t.methods, '[]', 0, 1, 0, 1, '', '', 2, '', 0, t.ua, 0, ''
FROM tmp_rp_api t
WHERE @mid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM eb_system_menus m WHERE m.unique_auth = t.ua);

DROP TEMPORARY TABLE IF EXISTS tmp_rp_api;
