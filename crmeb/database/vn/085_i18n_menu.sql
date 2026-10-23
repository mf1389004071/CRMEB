-- M5-4 后台菜单：设置 → 译文管理（缺译文/导入导出），商品/分类/区划多语编辑页（隐藏菜单）及接口权限。幂等。
-- 回滚：DELETE FROM eb_system_menus WHERE unique_auth IN ('admin-setting-i18n','admin-product-i18n') OR unique_auth LIKE 'i18n-api-%';
SET NAMES utf8mb4;

INSERT INTO eb_system_menus (pid, icon, menu_name, module, controller, action, api_url, methods, params, sort, is_show, is_show_path, access, menu_path, path, auth_type, header, is_header, unique_auth, is_del, mark)
SELECT 12, '', '译文管理', 'admin', '', '', '', '', '[]', 2, 1, 1, 1, '/setting/i18n_manage/index', '12', 1, 'setting', 0, 'admin-setting-i18n', 0, '菜集鲜内容多语管理'
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM eb_system_menus WHERE unique_auth = 'admin-setting-i18n');
INSERT INTO eb_system_menus (pid, icon, menu_name, module, controller, action, api_url, methods, params, sort, is_show, is_show_path, access, menu_path, path, auth_type, header, is_header, unique_auth, is_del, mark)
SELECT 1, '', '多语内容', 'admin', '', '', '', '', '[]', 0, 0, 1, 1, '/product/i18n/:type/:id', '1', 1, 'product', 0, 'admin-product-i18n', 0, '商品/分类/区划多语编辑(隐藏菜单)'
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM eb_system_menus WHERE unique_auth = 'admin-product-i18n');

SET @mid := (SELECT id FROM eb_system_menus WHERE unique_auth = 'admin-setting-i18n' LIMIT 1);

DROP TEMPORARY TABLE IF EXISTS tmp_i18n_api;
CREATE TEMPORARY TABLE tmp_i18n_api (name varchar(32), api_url varchar(100), methods varchar(10), ua varchar(150));
INSERT INTO tmp_i18n_api VALUES
('译文读取', 'i18n/<type>/<id>', 'GET', 'i18n-api-read'),
('译文保存', 'i18n/<type>/<id>', 'POST', 'i18n-api-write'),
('译文机翻', 'i18n/<type>/<id>/machine', 'POST', 'i18n-api-machine'),
('缺译文清单', 'i18n/missing', 'GET', 'i18n-api-missing'),
('译文导出', 'i18n/export', 'GET', 'i18n-api-export'),
('译文导入', 'i18n/import', 'POST', 'i18n-api-import'),
('商品译文读取', 'product/i18n/<id>', 'GET', 'i18n-api-product-read'),
('商品译文保存', 'product/i18n/<id>', 'POST', 'i18n-api-product-write');

INSERT INTO eb_system_menus (pid, icon, menu_name, module, controller, action, api_url, methods, params, sort, is_show, is_show_path, access, menu_path, path, auth_type, header, is_header, unique_auth, is_del, mark)
SELECT @mid, '', t.name, 'admin', '', '', t.api_url, t.methods, '[]', 0, 1, 0, 1, '', '', 2, '', 0, t.ua, 0, ''
FROM tmp_i18n_api t
WHERE @mid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM eb_system_menus m WHERE m.unique_auth = t.ua);

DROP TEMPORARY TABLE IF EXISTS tmp_i18n_api;
