-- 修复 vn_contact.fields：种子里 \n 被 MySQL 写成真实换行导致 JSON 非法，
-- 后台 GET setting/group/{id} 出现 Invalid argument supplied for foreach()。
-- 幂等：仅当 JSON_VALID=0 时把字符串内真实换行替换为 JSON 转义 \n。
SET NAMES utf8mb4;
UPDATE eb_system_group
SET fields = REPLACE(REPLACE(fields, CHAR(13), ''), CHAR(10), '\\n')
WHERE config_name = 'vn_contact'
  AND fields IS NOT NULL
  AND fields <> ''
  AND JSON_VALID(fields) = 0;
