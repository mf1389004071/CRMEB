-- 机器翻译驱动：默认 Google gtx，火山密钥改为可选。挂到「翻译配置」tab（eng_title=online_translation）。幂等。
-- 回滚：DELETE FROM eb_system_config WHERE menu_name IN ('translate_driver','translate_proxy_host','translate_proxy_port','translate_gtx_interval_ms');
--       UPDATE eb_system_config SET `desc`='机器翻译仅支持火山翻译，注册地址https://console.volcengine.com，在访问控制里面新建api密钥' WHERE menu_name IN ('hs_accesskey','hs_secretkey');
SET NAMES utf8mb4;

SET @tab := (SELECT id FROM eb_system_config_tab WHERE eng_title = 'online_translation' LIMIT 1);

DROP TEMPORARY TABLE IF EXISTS tmp_translate_cfg;
CREATE TEMPORARY TABLE tmp_translate_cfg (
  menu_name varchar(255), type varchar(255), input_type varchar(20), parameter varchar(255),
  required varchar(255), width int, val varchar(5000), info varchar(255), descr varchar(255), sort int
);
INSERT INTO tmp_translate_cfg VALUES
('translate_driver', 'radio', 'input', 'google_gtx=>Google gtx(无Key)\nvolcano=>火山引擎', '', 0, '"google_gtx"', '机器翻译驱动', '默认 Google gtx（与 kizERP 同族接口，非 Cloud Translation）；volcano 需填写下方 AccessKey/SecretKey', 10),
('translate_proxy_host', 'text', 'input', '', '', 100, '""', '翻译代理主机', '可选。Google gtx 直连失败时使用，如 127.0.0.1；空则仅直连', 9),
('translate_proxy_port', 'text', 'input', '', '', 100, '"7890"', '翻译代理端口', '配合代理主机；仅 host 非空时生效', 8),
('translate_gtx_interval_ms', 'text', 'number', '', '', 100, '"150"', 'gtx 请求间隔(ms)', '批量机翻时每条之间的间隔，降低限流风险', 7);

INSERT INTO eb_system_config (menu_name, type, input_type, config_tab_id, parameter, upload_type, required, width, high, value, info, `desc`, sort, status, level, link_id, link_value)
SELECT t.menu_name, t.type, t.input_type, @tab, REPLACE(t.parameter, '\n', CHAR(10)), 1, t.required, t.width, 0, t.val, t.info, t.descr, t.sort, 1, 0, 0, 0
FROM tmp_translate_cfg t
WHERE @tab IS NOT NULL AND NOT EXISTS (SELECT 1 FROM eb_system_config c WHERE c.menu_name = t.menu_name);

DROP TEMPORARY TABLE IF EXISTS tmp_translate_cfg;

UPDATE eb_system_config
SET `desc` = '仅当机器翻译驱动为「火山引擎」时必填。注册地址 https://console.volcengine.com ，在访问控制中新建 API 密钥'
WHERE menu_name IN ('hs_accesskey', 'hs_secretkey');

-- 执行后需清缓存（后台“清除缓存”），sys_config 才能读到新配置。
