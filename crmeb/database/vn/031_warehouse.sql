-- 提货仓库：主表 + 区划关联 + 订单仓快照。幂等（依赖 000_helpers.sql）。
-- 回滚：DROP TABLE eb_vn_warehouse_region; DROP TABLE eb_vn_warehouse;
--       ALTER TABLE eb_store_order DROP COLUMN warehouse_id, warehouse_name, warehouse_address;
SET NAMES utf8mb4;

CREATE TABLE IF NOT EXISTS `eb_vn_warehouse` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(32) NOT NULL DEFAULT '' COMMENT '业务编码(可空唯一)',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '仓名(默认语)',
  `address` varchar(255) NOT NULL DEFAULT '' COMMENT '地址摘要',
  `detailed_address` varchar(255) NOT NULL DEFAULT '' COMMENT '详细地址',
  `introduction` varchar(1000) NOT NULL DEFAULT '' COMMENT '说明',
  `phone` varchar(32) NOT NULL DEFAULT '' COMMENT '电话',
  `lng` varchar(32) NOT NULL DEFAULT '' COMMENT '经度',
  `lat` varchar(32) NOT NULL DEFAULT '' COMMENT '纬度',
  `is_enable` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否可用',
  `effective_start` int(11) NOT NULL DEFAULT 0 COMMENT '生效开始时间戳,0不限',
  `effective_end` int(11) NOT NULL DEFAULT 0 COMMENT '失效时间戳,0不限',
  `pickup_slots` text COMMENT '可提货时段JSON [{weekday,start,end}]',
  `auto_match` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1参与自动匹配',
  `exact_match_only` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1仅精确匹配关联节点',
  `sort` int(11) NOT NULL DEFAULT 0 COMMENT '全局排序大者靠前',
  `is_del` tinyint(1) NOT NULL DEFAULT 0,
  `add_time` int(11) NOT NULL DEFAULT 0,
  `update_time` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `idx_code` (`code`),
  KEY `idx_enable` (`is_enable`, `auto_match`, `is_del`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='提货仓库';

CREATE TABLE IF NOT EXISTS `eb_vn_warehouse_region` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `warehouse_id` int(11) NOT NULL DEFAULT 0,
  `city_id` int(11) NOT NULL DEFAULT 0 COMMENT '任意颗粒度区划city_id',
  `sort` int(11) NOT NULL DEFAULT 0 COMMENT '该节点下排序大者靠前',
  `is_default` tinyint(1) NOT NULL DEFAULT 0 COMMENT '该节点默认仓',
  `add_time` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_wh_city` (`warehouse_id`, `city_id`),
  KEY `idx_city` (`city_id`, `is_default`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='仓库-区划关联';

CALL eb_vn_add_column('eb_store_order', 'warehouse_id', "int(11) NOT NULL DEFAULT 0 COMMENT '提货仓id'");
CALL eb_vn_add_column('eb_store_order', 'warehouse_name', "varchar(100) NOT NULL DEFAULT '' COMMENT '提货仓名快照'");
CALL eb_vn_add_column('eb_store_order', 'warehouse_address', "varchar(500) NOT NULL DEFAULT '' COMMENT '提货仓地址快照'");
CALL eb_vn_add_index('eb_store_order', 'idx_warehouse', 'KEY `idx_warehouse` (`warehouse_id`)');
