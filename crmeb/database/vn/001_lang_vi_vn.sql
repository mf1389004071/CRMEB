-- M0-1 语言码规范化：统一 zh-CN / vi-VN / en-US，默认越南语，仅启用三种语言。幂等，可重复执行。
-- 回滚：UPDATE eb_lang_type SET is_default=(file_name='zh-CN'); 再按需恢复 status。
SET NAMES utf8mb4;

-- 1. 保证存在 vi-VN 语言类型（基线通常已含）
INSERT INTO `eb_lang_type` (`language_name`, `file_name`, `is_default`, `status`, `is_del`)
SELECT 'Tiếng Việt', 'vi-VN', 0, 1, 0 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_type` WHERE `file_name` = 'vi-VN' AND `is_del` = 0);

SET @vn_tid := (SELECT `id` FROM `eb_lang_type` WHERE `file_name` = 'vi-VN' AND `is_del` = 0 ORDER BY `id` LIMIT 1);

INSERT INTO `eb_lang_country` (`name`, `code`, `type_id`)
SELECT 'Tiếng Việt(vi-VN)', 'vi-VN', @vn_tid FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_country` WHERE `code` = 'vi-VN');

-- 2. 旧别名 vi_vn：若存在旧类型，把其国家码也指向规范类型；词条复制到规范类型（按 code 去重）
UPDATE `eb_lang_country` SET `type_id` = @vn_tid WHERE `code` = 'vi_vn' AND @vn_tid IS NOT NULL;

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT @vn_tid, o.`code`, o.`remarks`, o.`lang_explain`, o.`is_admin`
FROM `eb_lang_code` o
JOIN `eb_lang_type` ot ON ot.`id` = o.`type_id` AND ot.`file_name` = 'vi_vn'
WHERE @vn_tid IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM `eb_lang_code` ex WHERE ex.`type_id` = @vn_tid AND ex.`code` = o.`code`);

-- 3. 无词条时以中文(type_id=1)作为待翻译占位
INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT @vn_tid, s.`code`, s.`remarks`, s.`lang_explain`, s.`is_admin`
FROM `eb_lang_code` s
WHERE s.`type_id` = 1 AND @vn_tid IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM `eb_lang_code` ex WHERE ex.`type_id` = @vn_tid AND ex.`code` = s.`code`);

-- 4. 默认语言 vi-VN；仅启用三种语言（不删数据）
UPDATE `eb_lang_type` SET `is_default` = IF(`file_name` = 'vi-VN', 1, 0);
UPDATE `eb_lang_type` SET `status` = IF(`file_name` IN ('zh-CN', 'en-US', 'vi-VN'), 1, 0) WHERE `is_del` = 0;

-- 5. 缓存：执行后需清除缓存键 range_name、type_id_*、lang_type_data、sys_lang_source_map、
--    lang_*、api_lang_*，并删除 lang_version 使其重新生成（后台“清除缓存”即可，或 php think 清缓存）。
