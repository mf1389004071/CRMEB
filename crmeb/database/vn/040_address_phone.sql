-- M8-1 地址/国别/手机号：eb_user_address 加列并放宽 post_code；手机区号字典 eb_phone_country。幂等（依赖 000_helpers.sql）。
-- eb_user.phone_country_code 已由 090_vn_login.sql 创建（此处再次调用助手保证单独执行也成立）。
-- 回滚：ALTER TABLE eb_user_address DROP COLUMN country_code, DROP COLUMN phone_country_code, DROP COLUMN ward;
--       ALTER TABLE eb_user_address MODIFY post_code int unsigned NOT NULL DEFAULT 0; DROP TABLE eb_phone_country;
SET NAMES utf8mb4;

CALL eb_vn_add_column('eb_user_address', 'country_code', "varchar(8) NOT NULL DEFAULT '' COMMENT '收货地址国家码 CN/VN'");
CALL eb_vn_add_column('eb_user_address', 'phone_country_code', "varchar(8) NOT NULL DEFAULT '+84' COMMENT '收货人手机区号'");
CALL eb_vn_add_column('eb_user_address', 'ward', "varchar(64) NOT NULL DEFAULT '' COMMENT '坊/社'");
CALL eb_vn_add_column('eb_user', 'phone_country_code', "varchar(8) NOT NULL DEFAULT '' COMMENT '登录账号手机区号，如+84'");

-- 邮编放宽为字符串（旧值保留）
ALTER TABLE `eb_user_address` MODIFY COLUMN `post_code` varchar(16) NOT NULL DEFAULT '' COMMENT '邮编';

CREATE TABLE IF NOT EXISTS `eb_phone_country` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL DEFAULT '' COMMENT '中文名',
  `name_vi` varchar(64) NOT NULL DEFAULT '' COMMENT '越南语名',
  `name_en` varchar(64) NOT NULL DEFAULT '' COMMENT '英文名',
  `code` varchar(8) NOT NULL DEFAULT '' COMMENT '区号 +84',
  `country_code` varchar(8) NOT NULL DEFAULT '' COMMENT '国家码 VN/CN',
  `min_len` int(11) NOT NULL DEFAULT 6 COMMENT '本地号最小长度(去干线前缀0后)',
  `max_len` int(11) NOT NULL DEFAULT 15 COMMENT '本地号最大长度',
  `pattern` varchar(64) NOT NULL DEFAULT '' COMMENT '本地号正则(可空)',
  `trunk_prefix` varchar(2) NOT NULL DEFAULT '' COMMENT '国内长途前缀(VN为0)，规范化时去除',
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `sort` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='手机区号字典';

INSERT INTO eb_phone_country (name, name_vi, name_en, code, country_code, min_len, max_len, pattern, trunk_prefix, status, sort)
SELECT '越南', 'Việt Nam', 'Vietnam', '+84', 'VN', 9, 10, '', '0', 1, 100 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM eb_phone_country WHERE code = '+84');
INSERT INTO eb_phone_country (name, name_vi, name_en, code, country_code, min_len, max_len, pattern, trunk_prefix, status, sort)
SELECT '中国', 'Trung Quốc', 'China', '+86', 'CN', 11, 11, '^1[0-9]{10}$', '', 1, 90 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM eb_phone_country WHERE code = '+86');
