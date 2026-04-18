-- 可选：为商城/接口 getLang 增加数据库语言 vi_vn（文案从 type_id=1 复制，与中文相同，占位用）
-- 1. 将下方 `eb_` 全部替换为你的数据表前缀（与 .env 中 DB_PREFIX 一致）
-- 2. 若后台已存在 file_name=vi_vn 的语言类型，请勿重复执行
-- 3. 执行后建议在后台「多语言」清缓存或等待缓存过期；亦可使用后台界面新增语言类型（会自动复制词条）

START TRANSACTION;

INSERT INTO `eb_lang_type` (`language_name`, `file_name`, `is_default`, `status`, `is_del`, `add_time`)
SELECT '越南语(vi_vn)', 'vi_vn', 0, 1, 0, UNIX_TIMESTAMP()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_type` WHERE `file_name` = 'vi_vn' AND `is_del` = 0);

SET @vn_tid := (SELECT `id` FROM `eb_lang_type` WHERE `file_name` = 'vi_vn' AND `is_del` = 0 ORDER BY `id` DESC LIMIT 1);

INSERT INTO `eb_lang_country` (`name`, `code`, `type_id`)
SELECT '越南', 'vi_vn', @vn_tid
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_country` WHERE `code` = 'vi_vn');

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT @vn_tid, `code`, `remarks`, `lang_explain`, `is_admin`
FROM `eb_lang_code` AS `src`
WHERE `src`.`type_id` = 1
  AND @vn_tid IS NOT NULL
  AND NOT EXISTS (
    SELECT 1 FROM `eb_lang_code` AS `ex` WHERE `ex`.`type_id` = @vn_tid AND `ex`.`code` = `src`.`code`
  );

COMMIT;
