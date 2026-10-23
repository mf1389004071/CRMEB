-- 由 scripts/vn_lang_codes_to_sql.py 自动生成，请勿手改；幂等。
-- 回滚：DELETE FROM eb_lang_code WHERE code LIKE vn_%（api 词条）；front 词条按中文 code 删除。
SET NAMES utf8mb4;
SET @t_zh := (SELECT id FROM eb_lang_type WHERE file_name='zh-CN' AND is_del=0 LIMIT 1);
SET @t_vi := (SELECT id FROM eb_lang_type WHERE file_name='vi-VN' AND is_del=0 LIMIT 1);
SET @t_en := (SELECT id FROM eb_lang_type WHERE file_name='en-US' AND is_del=0 LIMIT 1);

INSERT INTO eb_lang_code (type_id, code, remarks, lang_explain, is_admin)
SELECT v.tid, v.code, v.remarks, v.explain_, v.is_admin FROM (
  SELECT @t_zh AS tid, '如需帮助，请通过以下方式联系我们' AS code, '如需帮助，请通过以下方式联系我们' AS remarks, '如需帮助，请通过以下方式联系我们' AS explain_, 0 AS is_admin
  UNION ALL
  SELECT @t_vi AS tid, '如需帮助，请通过以下方式联系我们' AS code, '[待审]如需帮助，请通过以下方式联系我们' AS remarks, 'Nếu cần trợ giúp, vui lòng liên hệ chúng tôi qua các cách sau' AS explain_, 0 AS is_admin
  UNION ALL
  SELECT @t_en AS tid, '如需帮助，请通过以下方式联系我们' AS code, '如需帮助，请通过以下方式联系我们' AS remarks, 'For help, please contact us via the following channels' AS explain_, 0 AS is_admin
  UNION ALL
  SELECT @t_zh AS tid, '复制' AS code, '复制' AS remarks, '复制' AS explain_, 0 AS is_admin
  UNION ALL
  SELECT @t_vi AS tid, '复制' AS code, '[待审]复制' AS remarks, 'Sao chép' AS explain_, 0 AS is_admin
  UNION ALL
  SELECT @t_en AS tid, '复制' AS code, '复制' AS remarks, 'Copy' AS explain_, 0 AS is_admin
  UNION ALL
  SELECT @t_zh AS tid, '拨打电话' AS code, '拨打电话' AS remarks, '拨打电话' AS explain_, 0 AS is_admin
  UNION ALL
  SELECT @t_vi AS tid, '拨打电话' AS code, '[待审]拨打电话' AS remarks, 'Gọi điện thoại' AS explain_, 0 AS is_admin
  UNION ALL
  SELECT @t_en AS tid, '拨打电话' AS code, '拨打电话' AS remarks, 'Call' AS explain_, 0 AS is_admin
  UNION ALL
  SELECT @t_zh AS tid, '暂未配置联系方式' AS code, '暂未配置联系方式' AS remarks, '暂未配置联系方式' AS explain_, 0 AS is_admin
  UNION ALL
  SELECT @t_vi AS tid, '暂未配置联系方式' AS code, '[待审]暂未配置联系方式' AS remarks, 'Chưa cấu hình thông tin liên hệ' AS explain_, 0 AS is_admin
  UNION ALL
  SELECT @t_en AS tid, '暂未配置联系方式' AS code, '暂未配置联系方式' AS remarks, 'No contact information configured yet' AS explain_, 0 AS is_admin
  UNION ALL
  SELECT @t_zh AS tid, '微信' AS code, '微信' AS remarks, '微信' AS explain_, 0 AS is_admin
  UNION ALL
  SELECT @t_vi AS tid, '微信' AS code, '[待审]微信' AS remarks, 'WeChat' AS explain_, 0 AS is_admin
  UNION ALL
  SELECT @t_en AS tid, '微信' AS code, '微信' AS remarks, 'WeChat' AS explain_, 0 AS is_admin
  UNION ALL
  SELECT @t_zh AS tid, '电话' AS code, '电话' AS remarks, '电话' AS explain_, 0 AS is_admin
  UNION ALL
  SELECT @t_vi AS tid, '电话' AS code, '[待审]电话' AS remarks, 'Điện thoại' AS explain_, 0 AS is_admin
  UNION ALL
  SELECT @t_en AS tid, '电话' AS code, '电话' AS remarks, 'Phone' AS explain_, 0 AS is_admin
  UNION ALL
  SELECT @t_zh AS tid, '邮箱' AS code, '邮箱' AS remarks, '邮箱' AS explain_, 0 AS is_admin
  UNION ALL
  SELECT @t_vi AS tid, '邮箱' AS code, '[待审]邮箱' AS remarks, 'Email' AS explain_, 0 AS is_admin
  UNION ALL
  SELECT @t_en AS tid, '邮箱' AS code, '邮箱' AS remarks, 'Email' AS explain_, 0 AS is_admin
  UNION ALL
  SELECT @t_zh AS tid, '复制成功' AS code, '复制成功' AS remarks, '复制成功' AS explain_, 0 AS is_admin
  UNION ALL
  SELECT @t_vi AS tid, '复制成功' AS code, '[待审]复制成功' AS remarks, 'Sao chép thành công' AS explain_, 0 AS is_admin
  UNION ALL
  SELECT @t_en AS tid, '复制成功' AS code, '复制成功' AS remarks, 'Copied' AS explain_, 0 AS is_admin
  UNION ALL
  SELECT @t_zh AS tid, '联系我们' AS code, '联系我们' AS remarks, '联系我们' AS explain_, 0 AS is_admin
  UNION ALL
  SELECT @t_vi AS tid, '联系我们' AS code, '[待审]联系我们' AS remarks, 'Liên hệ chúng tôi' AS explain_, 0 AS is_admin
  UNION ALL
  SELECT @t_en AS tid, '联系我们' AS code, '联系我们' AS remarks, 'Contact us' AS explain_, 0 AS is_admin
) v
WHERE v.tid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM eb_lang_code e WHERE e.type_id = v.tid AND e.code = v.code);

-- 使语言包缓存失效：执行后在后台“清除缓存”
