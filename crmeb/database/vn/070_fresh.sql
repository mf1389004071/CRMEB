-- M7-1 生鲜属性：eb_store_product 加列。幂等（依赖 000_helpers.sql）。多语文本类字段(origin/冷链备注/保质期文案)的译文走 eb_i18n_content。
-- 回滚：ALTER TABLE eb_store_product DROP COLUMN is_fresh, DROP COLUMN net_weight, DROP COLUMN shelf_life_days, DROP COLUMN shelf_life_text,
--       DROP COLUMN origin, DROP COLUMN need_cold_chain, DROP COLUMN cold_chain_note, DROP COLUMN tax_rate;
SET NAMES utf8mb4;
CALL eb_vn_add_column('eb_store_product', 'is_fresh', "tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否生鲜商品'");
CALL eb_vn_add_column('eb_store_product', 'net_weight', "decimal(10,2) NOT NULL DEFAULT 0.00 COMMENT '净含量(按unit_name计，如kg)'");
CALL eb_vn_add_column('eb_store_product', 'shelf_life_days', "int(11) NOT NULL DEFAULT 0 COMMENT '保质期天数'");
CALL eb_vn_add_column('eb_store_product', 'shelf_life_text', "varchar(64) NOT NULL DEFAULT '' COMMENT '保质期文案(默认语言)'");
CALL eb_vn_add_column('eb_store_product', 'origin', "varchar(64) NOT NULL DEFAULT '' COMMENT '产地(默认语言)'");
CALL eb_vn_add_column('eb_store_product', 'need_cold_chain', "tinyint(1) NOT NULL DEFAULT 0 COMMENT '需冷链'");
CALL eb_vn_add_column('eb_store_product', 'cold_chain_note', "varchar(128) NOT NULL DEFAULT '' COMMENT '冷链备注(默认语言)'");
CALL eb_vn_add_column('eb_store_product', 'tax_rate', "decimal(5,2) NOT NULL DEFAULT 0.00 COMMENT '税率%(仅展示，不做价税分离)'");
