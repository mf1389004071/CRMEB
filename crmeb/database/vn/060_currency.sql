-- M6-1 币种：eb_system_currency、汇率修改日志 eb_system_exchange_rate_log。幂等。
-- rate：1 本位币 = rate 该币种（本位币 rate=1）。预置 VND(本位) / CNY / USD，汇率为示例，上线前请在后台“币种与汇率”校准。
-- 回滚：DROP TABLE eb_system_currency; DROP TABLE eb_system_exchange_rate_log;
SET NAMES utf8mb4;

CREATE TABLE IF NOT EXISTS `eb_system_currency` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(8) NOT NULL DEFAULT '' COMMENT '币种码 VND/CNY/USD',
  `symbol` varchar(8) NOT NULL DEFAULT '' COMMENT '符号',
  `name_zh` varchar(32) NOT NULL DEFAULT '',
  `name_vi` varchar(32) NOT NULL DEFAULT '',
  `name_en` varchar(32) NOT NULL DEFAULT '',
  `decimal_places` tinyint(1) NOT NULL DEFAULT 2 COMMENT '小数位',
  `thousand_sep` varchar(2) NOT NULL DEFAULT ',' COMMENT '千分位符',
  `decimal_sep` varchar(2) NOT NULL DEFAULT '.' COMMENT '小数点符',
  `rate` decimal(18,6) NOT NULL DEFAULT 1.000000 COMMENT '1本位币=rate该币种',
  `is_base` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否本位币(仅一个)',
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `sort` int(11) NOT NULL DEFAULT 0,
  `update_time` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='币种';

CREATE TABLE IF NOT EXISTS `eb_system_exchange_rate_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(8) NOT NULL DEFAULT '',
  `old_rate` decimal(18,6) NOT NULL DEFAULT 0,
  `new_rate` decimal(18,6) NOT NULL DEFAULT 0,
  `operator_id` int(11) NOT NULL DEFAULT 0,
  `add_time` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `idx_code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='汇率修改日志';

INSERT INTO eb_system_currency (code, symbol, name_zh, name_vi, name_en, decimal_places, thousand_sep, decimal_sep, rate, is_base, status, sort, update_time)
SELECT 'VND', '₫', '越南盾', 'Đồng Việt Nam', 'Vietnamese Dong', 0, '.', ',', 1.000000, 1, 1, 100, UNIX_TIMESTAMP() FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM eb_system_currency WHERE code = 'VND');
INSERT INTO eb_system_currency (code, symbol, name_zh, name_vi, name_en, decimal_places, thousand_sep, decimal_sep, rate, is_base, status, sort, update_time)
SELECT 'CNY', '¥', '人民币', 'Nhân dân tệ', 'Chinese Yuan', 2, ',', '.', 0.000280, 0, 1, 90, UNIX_TIMESTAMP() FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM eb_system_currency WHERE code = 'CNY');
INSERT INTO eb_system_currency (code, symbol, name_zh, name_vi, name_en, decimal_places, thousand_sep, decimal_sep, rate, is_base, status, sort, update_time)
SELECT 'USD', '$', '美元', 'Đô la Mỹ', 'US Dollar', 2, ',', '.', 0.000040, 0, 1, 80, UNIX_TIMESTAMP() FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM eb_system_currency WHERE code = 'USD');
