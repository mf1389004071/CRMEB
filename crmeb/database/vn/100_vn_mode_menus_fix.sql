-- 菜集鲜：默认越南模式菜单/路径修缮。幂等。
-- 1) 配送区域菜单 path 与前端路由对齐（/setting/region/index）
-- 2) 隐藏官方「城市数据」入口（销售区划请用配送区域；运费模板仍可用旧树接口）
-- 3) 隐藏非必要顶级菜单（分销/营销/财务/内容/应用/客服）——功能代码保留，vn_mode 关闭后可再打开
-- 4) 确保越南站点配置为开启默认值
-- 回滚：UPDATE eb_system_menus SET is_show=1,is_show_path=1 WHERE unique_auth='setting-system-city' OR id IN (26,27,35,43,135,165);
--       UPDATE eb_system_menus SET menu_path='/setting/region' WHERE unique_auth='admin-setting-region';
SET NAMES utf8mb4;

UPDATE eb_system_menus
SET menu_path = '/setting/region/index'
WHERE unique_auth = 'admin-setting-region' AND menu_path <> '/setting/region/index';

UPDATE eb_system_menus
SET is_show = 0, is_show_path = 0
WHERE unique_auth = 'setting-system-city';

UPDATE eb_system_menus
SET is_show = 0, is_show_path = 0
WHERE id IN (26, 27, 35, 43, 135, 165) AND pid = 0;

-- 越南站点配置保持开启（已存在则强制写回默认开发态）
UPDATE eb_system_config SET value = '"1"', status = 1 WHERE menu_name = 'vn_mode_enable';
UPDATE eb_system_config SET value = '"1"', status = 1 WHERE menu_name = 'region_pricing_enable';
UPDATE eb_system_config SET value = '"1"', status = 1 WHERE menu_name = 'cod_auto_stock_up';
UPDATE eb_system_config SET value = '"VND"', status = 1 WHERE menu_name = 'base_currency';
UPDATE eb_system_config SET value = '"vi-VN"', status = 1 WHERE menu_name IN ('default_lang', 'i18n_fallback_lang');

UPDATE eb_system_config_tab SET status = 1 WHERE eng_title = 'vn_site';
