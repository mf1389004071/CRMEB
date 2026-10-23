-- M1-1 配送区域与区划：eb_system_city 加列 + 国家根节点。幂等（依赖 000_helpers.sql）。
-- 基线核对结论：eb_system_city.level：0=省(34) 1=市(369) 2=区(3536)；parent_id=0 为省级，parent_id 引用 city_id（非 id）；city_id 最大 752177。
-- 国家根节点：level=-1，parent_id=-1（避开既有 parent_id=0 的省级树查询，旧版城市选择器/运费模板不受影响），CN=900001、VN=900002（city_id 段 900001~909999 预留国家根，VN 业务数据用 910000+，均大于 CN 存量最大值）。
-- 不改动 CN 存量节点的 city_id/level/parent_id；CN 省节点的 path 前缀补国家根（见 path 重建服务）。
-- VN 层级约定：0=省/直辖市，1=郡/县，2=坊/社；“城市级”（定位匹配、区域价常用挂载）：VN=level 0，CN=level 1。
-- 回滚：DELETE FROM eb_system_city WHERE city_id IN (900001,900002) OR country_code='VN';
--       ALTER TABLE eb_system_city DROP COLUMN country_code, DROP COLUMN path, DROP COLUMN is_open, DROP COLUMN is_hot, DROP COLUMN sort;
SET NAMES utf8mb4;

CALL eb_vn_add_column('eb_system_city', 'country_code', "varchar(8) NOT NULL DEFAULT '' COMMENT '国家码 CN/VN'");
CALL eb_vn_add_column('eb_system_city', 'path', "varchar(255) NOT NULL DEFAULT '' COMMENT '祖先链 ,国家根,省,市,区, 含自身city_id'");
CALL eb_vn_add_column('eb_system_city', 'is_open', "tinyint(1) NOT NULL DEFAULT 0 COMMENT '销售区白名单(开放可选)'");
CALL eb_vn_add_column('eb_system_city', 'is_hot', "tinyint(1) NOT NULL DEFAULT 0 COMMENT '热门城市'");
CALL eb_vn_add_column('eb_system_city', 'sort', "int(11) NOT NULL DEFAULT 0 COMMENT '排序(大者靠前)'");
CALL eb_vn_add_index('eb_system_city', 'idx_parent', 'KEY `idx_parent` (`parent_id`)');
CALL eb_vn_add_index('eb_system_city', 'idx_open', 'KEY `idx_open` (`is_open`, `is_hot`)');
CALL eb_vn_add_index('eb_system_city', 'idx_city_id', 'KEY `idx_city_id` (`city_id`)');

-- 存量中国数据
UPDATE eb_system_city SET country_code = 'CN' WHERE country_code = '' AND city_id < 900001;

-- 国家根节点
INSERT INTO eb_system_city (city_id, level, parent_id, area_code, name, merger_name, lng, lat, is_show, country_code, path, is_open, is_hot, sort)
SELECT 900001, -1, -1, '86', '中国', '中国', '104.195397', '35.86166', 1, 'CN', ',900001,', 0, 0, 0 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM eb_system_city WHERE city_id = 900001);
INSERT INTO eb_system_city (city_id, level, parent_id, area_code, name, merger_name, lng, lat, is_show, country_code, path, is_open, is_hot, sort)
SELECT 900002, -1, -1, '84', 'Việt Nam', 'Việt Nam', '108.277199', '14.058324', 1, 'VN', ',900002,', 1, 0, 100 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM eb_system_city WHERE city_id = 900002);

-- 兼容：若根节点已按 parent_id=0 建立则修正
UPDATE eb_system_city SET parent_id = -1 WHERE city_id IN (900001, 900002) AND parent_id <> -1;
