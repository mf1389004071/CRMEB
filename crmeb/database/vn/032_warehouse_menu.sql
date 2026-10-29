-- 提货仓库菜单与权限；vn_mode 下隐藏官方提货点入口。幂等。
-- 回滚：DELETE FROM eb_system_menus WHERE unique_auth='admin-setting-warehouse' OR unique_auth LIKE 'warehouse-api-%';
--       UPDATE eb_system_menus SET is_show=1,is_show_path=1 WHERE unique_auth IN ('setting-merchant-system-store','setting-system-config-merchant');
SET NAMES utf8mb4;

INSERT INTO eb_system_menus (pid, icon, menu_name, module, controller, action, api_url, methods, params, sort, is_show, is_show_path, access, menu_path, path, auth_type, header, is_header, unique_auth, is_del, mark)
SELECT 12, '', '提货仓库', 'admin', '', '', '', '', '[]', 2, 1, 1, 1, '/setting/warehouse/index', '12', 1, 'setting', 0, 'admin-setting-warehouse', 0, '菜集鲜提货仓库'
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM eb_system_menus WHERE unique_auth = 'admin-setting-warehouse');

SET @mid := (SELECT id FROM eb_system_menus WHERE unique_auth = 'admin-setting-warehouse' LIMIT 1);

DROP TEMPORARY TABLE IF EXISTS tmp_wh_api;
CREATE TEMPORARY TABLE tmp_wh_api (name varchar(40), api_url varchar(120), methods varchar(10), ua varchar(150));
INSERT INTO tmp_wh_api VALUES
('仓库列表', 'warehouse/list', 'GET', 'warehouse-api-list'),
('仓库详情', 'warehouse/read', 'GET', 'warehouse-api-read'),
('仓库保存', 'warehouse/save', 'POST', 'warehouse-api-save'),
('仓库删除', 'warehouse/delete', 'POST', 'warehouse-api-delete'),
('仓库快速开仓', 'warehouse/quick_create', 'POST', 'warehouse-api-quick'),
('仓库关联区划', 'warehouse/regions', 'POST', 'warehouse-api-regions'),
('区划设默认仓', 'warehouse/set_region_default', 'POST', 'warehouse-api-set-default'),
('区划已关联仓', 'warehouse/for_region', 'GET', 'warehouse-api-for-region'),
('仓库健康检查', 'warehouse/health', 'GET', 'warehouse-api-health'),
('仓库下拉', 'warehouse/options', 'GET', 'warehouse-api-options');

INSERT INTO eb_system_menus (pid, icon, menu_name, module, controller, action, api_url, methods, params, sort, is_show, is_show_path, access, menu_path, path, auth_type, header, is_header, unique_auth, is_del, mark)
SELECT @mid, '', t.name, 'admin', '', '', t.api_url, t.methods, '[]', 0, 1, 0, 1, '', '', 2, '', 0, t.ua, 0, ''
FROM tmp_wh_api t
WHERE @mid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM eb_system_menus m WHERE m.unique_auth = t.ua);

DROP TEMPORARY TABLE IF EXISTS tmp_wh_api;

-- 隐藏官方提货点/门店入口，避免与提货仓库混淆（代码保留）
UPDATE eb_system_menus SET is_show = 0, is_show_path = 0
WHERE unique_auth IN ('setting-merchant-system-store', 'setting-system-config-merchant');
