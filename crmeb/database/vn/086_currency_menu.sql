-- M6-3 后台菜单：设置 → 币种与汇率及接口权限。幂等。
-- 回滚：DELETE FROM eb_system_menus WHERE unique_auth = 'admin-setting-currency' OR unique_auth LIKE 'currency-api-%';
SET NAMES utf8mb4;

INSERT INTO eb_system_menus (pid, icon, menu_name, module, controller, action, api_url, methods, params, sort, is_show, is_show_path, access, menu_path, path, auth_type, header, is_header, unique_auth, is_del, mark)
SELECT 12, '', '币种与汇率', 'admin', '', '', '', '', '[]', 1, 1, 1, 1, '/setting/currency/index', '12', 1, 'setting', 0, 'admin-setting-currency', 0, '菜集鲜币种与汇率'
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM eb_system_menus WHERE unique_auth = 'admin-setting-currency');

SET @mid := (SELECT id FROM eb_system_menus WHERE unique_auth = 'admin-setting-currency' LIMIT 1);

DROP TEMPORARY TABLE IF EXISTS tmp_cur_api;
CREATE TEMPORARY TABLE tmp_cur_api (name varchar(32), api_url varchar(100), methods varchar(10), ua varchar(150));
INSERT INTO tmp_cur_api VALUES
('币种列表', 'setting/currency', 'GET', 'currency-api-list'),
('币种保存', 'setting/currency', 'POST', 'currency-api-save'),
('币种删除', 'setting/currency/<id>', 'DELETE', 'currency-api-del'),
('汇率修改日志', 'setting/currency/logs', 'GET', 'currency-api-logs');

INSERT INTO eb_system_menus (pid, icon, menu_name, module, controller, action, api_url, methods, params, sort, is_show, is_show_path, access, menu_path, path, auth_type, header, is_header, unique_auth, is_del, mark)
SELECT @mid, '', t.name, 'admin', '', '', t.api_url, t.methods, '[]', 0, 1, 0, 1, '', '', 2, '', 0, t.ua, 0, ''
FROM tmp_cur_api t
WHERE @mid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM eb_system_menus m WHERE m.unique_auth = t.ua);

DROP TEMPORARY TABLE IF EXISTS tmp_cur_api;
