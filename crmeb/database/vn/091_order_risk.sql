-- M9-3 下单防刷：eb_store_order.client_ip（用于后台“加入黑名单(IP)”）。幂等（依赖 000_helpers.sql）。
-- 回滚：ALTER TABLE eb_store_order DROP COLUMN client_ip;
SET NAMES utf8mb4;
CALL eb_vn_add_column('eb_store_order', 'client_ip', "varchar(45) NOT NULL DEFAULT '' COMMENT '下单客户端IP'");
