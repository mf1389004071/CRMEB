-- M10-1 越南站点配置项（eb_system_config）+ 配置 Tab“越南站点”。幂等。
-- 回滚：DELETE FROM eb_system_config WHERE config_tab_id=(SELECT id FROM eb_system_config_tab WHERE eng_title='vn_site');
--       DELETE FROM eb_system_config_tab WHERE eng_title='vn_site';
SET NAMES utf8mb4;

INSERT INTO eb_system_config_tab (pid, title, eng_title, status, info, icon, type, sort, menus_id)
SELECT 129, '越南站点', 'vn_site', 1, 0, '', 0, 0, 23 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM eb_system_config_tab WHERE eng_title = 'vn_site');

SET @tab := (SELECT id FROM eb_system_config_tab WHERE eng_title = 'vn_site' LIMIT 1);

-- 一次性建临时表，逐项插入（menu_name 不存在才插入）
DROP TEMPORARY TABLE IF EXISTS tmp_vn_cfg;
CREATE TEMPORARY TABLE tmp_vn_cfg (
  menu_name varchar(255), type varchar(255), input_type varchar(20), parameter varchar(255),
  required varchar(255), width int, val varchar(5000), info varchar(255), descr varchar(255), sort int
);
INSERT INTO tmp_vn_cfg VALUES
('vn_mode_enable',   'radio', 'input', '1=>开启\n0=>关闭', '', 0, '"1"', '越南模式总开关', '开启后前端隐藏用不上的入口、启用区域选择等；关闭则恢复原版行为', 100),
('region_pricing_enable', 'radio', 'input', '1=>开启\n0=>关闭', '', 0, '"1"', '启用区域选择与区域价', '需同时开启越南模式', 99),
('allow_national_price', 'radio', 'input', '1=>允许\n0=>不允许', '', 0, '"0"', '允许全国价(系统总闸)', '开启后商品方可单独设置允许回落全国价', 98),
('locate_max_km', 'text', 'number', '', '', 100, '"60"', '自动定位最大距离(km)', '自动定位匹配城市的最大距离', 97),
('cod_auto_stock_up', 'radio', 'input', '1=>是\n0=>否', '', 0, '"1"', '下单直接进入备货中', '否则下单后为“待确认”，需后台确认接单', 96),
('cod_user_cancel_before_confirm', 'radio', 'input', '1=>允许\n0=>不允许', '', 0, '"1"', '待确认时允许用户取消', '到付订单待确认状态下用户是否可取消', 95),
('order_notify_poll_seconds', 'text', 'number', '', '', 100, '"20"', '新订单轮询间隔(秒)', '后台新订单提醒轮询间隔', 94),
('order_rate_limit_per_hour', 'text', 'number', '', '', 100, '"5"', '每小时最大下单数', '同手机号/同IP每小时最大下单数', 93),
('base_currency', 'text', 'input', '', '', 100, '"VND"', '本位币', '价格/订单金额的计价币种', 92),
('default_lang', 'text', 'input', '', '', 100, '"vi-VN"', '站点默认语言', '与多语言“默认语言”保持一致', 91),
('i18n_fallback_lang', 'text', 'input', '', '', 100, '"vi-VN"', '内容多语回落语种', '缺少译文时回落的语种', 90),
('i18n_show_pending_machine', 'radio', 'input', '1=>展示\n0=>不展示', '', 0, '"1"', '展示机翻待审内容', '机器翻译未审核的内容是否对前台展示', 89),
('default_phone_country', 'text', 'input', '', '', 100, '"+84"', '默认手机区号', '历史用户无区号时按此补全', 88);

INSERT INTO eb_system_config (menu_name, type, input_type, config_tab_id, parameter, upload_type, required, width, high, value, info, `desc`, sort, status, level, link_id, link_value)
SELECT t.menu_name, t.type, t.input_type, @tab, REPLACE(t.parameter, '\n', CHAR(10)), 1, t.required, t.width, 0, t.val, t.info, t.descr, t.sort, 1, 0, 0, 0
FROM tmp_vn_cfg t
WHERE @tab IS NOT NULL AND NOT EXISTS (SELECT 1 FROM eb_system_config c WHERE c.menu_name = t.menu_name);

DROP TEMPORARY TABLE IF EXISTS tmp_vn_cfg;
-- 执行后需清缓存（后台“清除缓存”），sys_config 才能读到新配置。
