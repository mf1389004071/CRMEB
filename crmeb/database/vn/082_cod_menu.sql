-- M3-7 / M10-3 后台菜单：新增“到付订单”菜单及接口权限；隐藏越南站不用的营销类顶部菜单。幂等。
-- 回滚：UPDATE eb_system_menus SET is_show=1 WHERE id IN (26,27);
--       DELETE FROM eb_system_menus WHERE unique_auth LIKE 'admin-order-cod%' OR unique_auth LIKE 'order-cod-%';
SET NAMES utf8mb4;

-- 1) 菜单页：订单 → 到付订单（路由 /admin/order/cod/list，前端 router meta.auth = admin-order-cod）
INSERT INTO eb_system_menus (pid, icon, menu_name, module, controller, action, api_url, methods, params, sort, is_show, is_show_path, access, menu_path, path, auth_type, header, is_header, unique_auth, is_del, mark)
SELECT 4, '', '到付订单', 'admin', '', '', '', '', '[]', 11, 1, 1, 1, '/order/cod/list', '4', 1, 'order', 0, 'admin-order-cod', 0, '菜集鲜到付订单'
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM eb_system_menus WHERE unique_auth = 'admin-order-cod');

SET @mid := (SELECT id FROM eb_system_menus WHERE unique_auth = 'admin-order-cod' LIMIT 1);

-- 2) 接口权限（auth_type=2），供非超级管理员角色勾选
DROP TEMPORARY TABLE IF EXISTS tmp_cod_api;
CREATE TEMPORARY TABLE tmp_cod_api (name varchar(32), api_url varchar(100), methods varchar(10), ua varchar(150));
INSERT INTO tmp_cod_api VALUES
('到付订单列表', 'order/cod/list', 'GET', 'order-cod-list'),
('到付订单确认接单', 'order/cod/confirm/<id>', 'POST', 'order-cod-confirm'),
('到付订单开始配送', 'order/cod/delivering/<id>', 'POST', 'order-cod-delivering'),
('到付订单标记已送达', 'order/cod/delivered/<id>', 'POST', 'order-cod-delivered'),
('到付订单送达核销', 'order/cod/verify', 'POST', 'order-cod-verify'),
('到付订单确认收款', 'order/cod/collect/<id>', 'POST', 'order-cod-collect'),
('到付订单取消', 'order/cod/cancel/<id>', 'POST', 'order-cod-cancel'),
('到付订单电话确认标记', 'order/cod/call_mark/<id>', 'POST', 'order-cod-call_mark'),
('到付订单操作记录', 'order/cod/audit/<id>', 'GET', 'order-cod-audit'),
('到付新订单轮询', 'order/cod/new', 'GET', 'order-cod-new'),
('到付配送单数据', 'order/cod/print_data', 'GET', 'order-cod-print_data'),
('到付拣货汇总', 'order/cod/pick_summary', 'GET', 'order-cod-pick_summary'),
('到付订单导出', 'order/cod/export', 'GET', 'order-cod-export'),
('下单黑名单列表', 'order/blacklist', 'GET', 'order-cod-blacklist-list'),
('下单黑名单新增', 'order/blacklist', 'POST', 'order-cod-blacklist-add'),
('下单黑名单删除', 'order/blacklist/<id>', 'DELETE', 'order-cod-blacklist-del');

INSERT INTO eb_system_menus (pid, icon, menu_name, module, controller, action, api_url, methods, params, sort, is_show, is_show_path, access, menu_path, path, auth_type, header, is_header, unique_auth, is_del, mark)
SELECT @mid, '', t.name, 'admin', '', '', t.api_url, t.methods, '[]', 0, 1, 0, 1, '', '', 2, '', 0, t.ua, 0, ''
FROM tmp_cod_api t
WHERE @mid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM eb_system_menus m WHERE m.unique_auth = t.ua);

DROP TEMPORARY TABLE IF EXISTS tmp_cod_api;

-- 3) 隐藏越南站用不上的顶部菜单：分销(26)、营销(27)；功能代码保留，回滚见文件头
UPDATE eb_system_menus SET is_show = 0 WHERE id IN (26, 27) AND pid = 0;
