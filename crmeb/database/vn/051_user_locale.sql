-- M5-1 用户语种/展示币种持久化：eb_user.locale、eb_user.display_currency。幂等（依赖 000_helpers.sql）。
-- 回滚：ALTER TABLE eb_user DROP COLUMN locale, DROP COLUMN display_currency;
SET NAMES utf8mb4;
CALL eb_vn_add_column('eb_user', 'locale', "varchar(10) NOT NULL DEFAULT '' COMMENT '用户语种 zh-CN/vi-VN/en-US'");
CALL eb_vn_add_column('eb_user', 'display_currency', "varchar(8) NOT NULL DEFAULT '' COMMENT '展示币种 VND/CNY/USD'");
