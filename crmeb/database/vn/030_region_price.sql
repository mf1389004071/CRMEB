-- M2-1 区域价：eb_store_product_region_price + eb_store_product.allow_national_price。幂等（依赖 000_helpers.sql）。
-- 回滚：DROP TABLE eb_store_product_region_price; ALTER TABLE eb_store_product DROP COLUMN allow_national_price;
-- 取价规则：按“规格 unique + 区域祖先链”取最近祖先价；不跨兄弟；链上无价则视为不可售，除非系统与商品均开启“允许全国价”。
SET NAMES utf8mb4;

CREATE TABLE IF NOT EXISTS `eb_store_product_region_price` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL DEFAULT 0 COMMENT '商品ID',
  `unique` varchar(32) NOT NULL DEFAULT '' COMMENT '规格唯一标识(store_product_attr_value.unique)',
  `city_id` int(11) NOT NULL DEFAULT 0 COMMENT '价目挂载区域节点(国/省/市/区/坊 city_id)',
  `price` decimal(12,2) NOT NULL DEFAULT 0.00 COMMENT '售价(本位币)',
  `ot_price` decimal(12,2) NOT NULL DEFAULT 0.00 COMMENT '划线价',
  `stock` int(11) DEFAULT NULL COMMENT '区域库存，NULL=沿用规格主表库存',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1启用',
  `add_time` int(11) NOT NULL DEFAULT 0,
  `update_time` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk` (`product_id`, `unique`, `city_id`),
  KEY `idx_pc` (`product_id`, `city_id`),
  KEY `idx_city` (`city_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品区域价';

CALL eb_vn_add_column('eb_store_product', 'allow_national_price', "tinyint(1) NOT NULL DEFAULT 0 COMMENT '允许无区域价时回落全国价(需系统总闸开启)'");
