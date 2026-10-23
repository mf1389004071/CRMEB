-- M1-5 后台菜单：设置 → 配送区域（区划开放/热门/导入）及接口权限。幂等。
-- 回滚：DELETE FROM eb_system_menus WHERE unique_auth = 'admin-setting-region' OR unique_auth LIKE 'region-api-%';
SET NAMES utf8mb4;

INSERT INTO eb_system_menus (pid, icon, menu_name, module, controller, action, api_url, methods, params, sort, is_show, is_show_path, access, menu_path, path, auth_type, header, is_header, unique_auth, is_del, mark)
SELECT 12, '', '配送区域', 'admin', '', '', '', '', '[]', 3, 1, 1, 1, '/setting/region', '12', 1, 'setting', 0, 'admin-setting-region', 0, '菜集鲜配送区域/区划管理'
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM eb_system_menus WHERE unique_auth = 'admin-setting-region');

SET @mid := (SELECT id FROM eb_system_menus WHERE unique_auth = 'admin-setting-region' LIMIT 1);

DROP TEMPORARY TABLE IF EXISTS tmp_region_api;
CREATE TEMPORARY TABLE tmp_region_api (name varchar(32), api_url varchar(100), methods varchar(10), ua varchar(150));
INSERT INTO tmp_region_api VALUES
('区划列表', 'region/list', 'GET', 'region-api-list'),
('区划批量开放', 'region/open', 'POST', 'region-api-open'),
('区划批量热门', 'region/hot', 'POST', 'region-api-hot'),
('区划排序', 'region/sort', 'POST', 'region-api-sort'),
('区划新增编辑', 'region/save', 'POST', 'region-api-save'),
('区划Excel导入', 'region/import', 'POST', 'region-api-import'),
('区划重建path', 'region/rebuild_path', 'POST', 'region-api-rebuild'),
('区划导入模板列', 'region/template', 'GET', 'region-api-template');

INSERT INTO eb_system_menus (pid, icon, menu_name, module, controller, action, api_url, methods, params, sort, is_show, is_show_path, access, menu_path, path, auth_type, header, is_header, unique_auth, is_del, mark)
SELECT @mid, '', t.name, 'admin', '', '', t.api_url, t.methods, '[]', 0, 1, 0, 1, '', '', 2, '', 0, t.ua, 0, ''
FROM tmp_region_api t
WHERE @mid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM eb_system_menus m WHERE m.unique_auth = t.ua);

DROP TEMPORARY TABLE IF EXISTS tmp_region_api;
