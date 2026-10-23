-- M7-4 后台菜单：商品生鲜属性页（隐藏菜单，从商品列表“生鲜”进入）及接口权限。幂等。
-- 回滚：DELETE FROM eb_system_menus WHERE unique_auth = 'admin-product-fresh' OR unique_auth LIKE 'fresh-api-%';
SET NAMES utf8mb4;
INSERT INTO eb_system_menus (pid, icon, menu_name, module, controller, action, api_url, methods, params, sort, is_show, is_show_path, access, menu_path, path, auth_type, header, is_header, unique_auth, is_del, mark)
SELECT 1, '', '商品生鲜属性', 'admin', '', '', '', '', '[]', 0, 0, 1, 1, '/product/fresh/:id', '1', 1, 'product', 0, 'admin-product-fresh', 0, '商品生鲜属性(隐藏菜单)'
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM eb_system_menus WHERE unique_auth = 'admin-product-fresh');
SET @mid := (SELECT id FROM eb_system_menus WHERE unique_auth = 'admin-product-fresh' LIMIT 1);
INSERT INTO eb_system_menus (pid, icon, menu_name, module, controller, action, api_url, methods, params, sort, is_show, is_show_path, access, menu_path, path, auth_type, header, is_header, unique_auth, is_del, mark)
SELECT @mid, '', '生鲜属性读取', 'admin', '', '', 'product/fresh/<id>', 'GET', '[]', 0, 1, 0, 1, '', '', 2, '', 0, 'fresh-api-read', 0, ''
FROM DUAL WHERE @mid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM eb_system_menus WHERE unique_auth = 'fresh-api-read');
INSERT INTO eb_system_menus (pid, icon, menu_name, module, controller, action, api_url, methods, params, sort, is_show, is_show_path, access, menu_path, path, auth_type, header, is_header, unique_auth, is_del, mark)
SELECT @mid, '', '生鲜属性保存', 'admin', '', '', 'product/fresh/<id>', 'POST', '[]', 0, 1, 0, 1, '', '', 2, '', 0, 'fresh-api-save', 0, ''
FROM DUAL WHERE @mid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM eb_system_menus WHERE unique_auth = 'fresh-api-save');
