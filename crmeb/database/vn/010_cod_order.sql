-- M3-1 到付订单：eb_store_order / eb_store_order_status 加列，黑名单表。幂等（依赖 000_helpers.sql）。
-- 偏差：设计稿的 delivery_code 与基线已有列(快递公司编码 varchar(50))冲突，送达核销码改名 cod_delivery_code。
-- 回滚：ALTER TABLE eb_store_order DROP COLUMN ...（各 cod_*/is_cod/fulfil_status/region_id/lang/currency_code/exchange_rate/pay_amount_display/need_call_confirm/delivered_time）；
--       ALTER TABLE eb_store_order_status DROP COLUMN operator_id, operator_type, operator_name; DROP TABLE eb_order_blacklist;
SET NAMES utf8mb4;

CALL eb_vn_add_column('eb_store_order', 'is_cod',            "tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否到付单'");
CALL eb_vn_add_column('eb_store_order', 'fulfil_status',     "tinyint(1) NOT NULL DEFAULT 0 COMMENT '到付履约状态 0待确认 1备货中 2发货中 3已送达'");
CALL eb_vn_add_column('eb_store_order', 'cod_delivery_code', "char(6) NOT NULL DEFAULT '' COMMENT '送达核销码(不打印在配送单)'");
CALL eb_vn_add_column('eb_store_order', 'delivered_time',    "int(11) NOT NULL DEFAULT 0 COMMENT '送达时间'");
CALL eb_vn_add_column('eb_store_order', 'cod_receivable',    "decimal(12,2) NOT NULL DEFAULT 0.00 COMMENT '应收(=pay_price快照)'");
CALL eb_vn_add_column('eb_store_order', 'cod_received',      "decimal(12,2) NOT NULL DEFAULT 0.00 COMMENT '实收'");
CALL eb_vn_add_column('eb_store_order', 'cod_collector_id',  "int(11) NOT NULL DEFAULT 0 COMMENT '收款人(管理员id)'");
CALL eb_vn_add_column('eb_store_order', 'cod_collect_time',  "int(11) NOT NULL DEFAULT 0 COMMENT '收款时间'");
CALL eb_vn_add_column('eb_store_order', 'need_call_confirm', "tinyint(1) NOT NULL DEFAULT 0 COMMENT '需电话确认'");
CALL eb_vn_add_column('eb_store_order', 'region_id',         "int(11) NOT NULL DEFAULT 0 COMMENT '下单区域city_id'");
CALL eb_vn_add_column('eb_store_order', 'lang',              "varchar(10) NOT NULL DEFAULT '' COMMENT '下单语言'");
CALL eb_vn_add_column('eb_store_order', 'currency_code',     "varchar(8) NOT NULL DEFAULT '' COMMENT '展示币种快照'");
CALL eb_vn_add_column('eb_store_order', 'exchange_rate',     "decimal(18,6) NOT NULL DEFAULT 0 COMMENT '汇率快照(1本位币=rate展示币)'");
CALL eb_vn_add_column('eb_store_order', 'pay_amount_display',"decimal(18,2) NOT NULL DEFAULT 0 COMMENT '展示币种应付快照'");
CALL eb_vn_add_index('eb_store_order', 'idx_cod',    'KEY `idx_cod` (`is_cod`, `fulfil_status`, `add_time`)');
CALL eb_vn_add_index('eb_store_order', 'idx_region', 'KEY `idx_region` (`region_id`)');

CALL eb_vn_add_column('eb_store_order_status', 'operator_id',   "int(11) NOT NULL DEFAULT 0 COMMENT '操作人id'");
CALL eb_vn_add_column('eb_store_order_status', 'operator_type', "varchar(16) NOT NULL DEFAULT '' COMMENT '操作人类型 admin/user/system'");
CALL eb_vn_add_column('eb_store_order_status', 'operator_name', "varchar(64) NOT NULL DEFAULT '' COMMENT '操作人名称'");

CREATE TABLE IF NOT EXISTS `eb_order_blacklist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(8) NOT NULL DEFAULT '' COMMENT 'phone|ip|uid',
  `value` varchar(64) NOT NULL DEFAULT '' COMMENT '值',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  `add_time` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_type_value` (`type`, `value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='下单黑名单';
