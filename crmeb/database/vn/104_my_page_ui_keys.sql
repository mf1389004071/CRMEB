-- 「我的」页 DIY 高频中文词条三语补齐；幂等。
SET NAMES utf8mb4;
SET @t_zh := (SELECT id FROM eb_lang_type WHERE file_name='zh-CN' AND is_del=0 LIMIT 1);
SET @t_vi := (SELECT id FROM eb_lang_type WHERE file_name='vi-VN' AND is_del=0 LIMIT 1);
SET @t_en := (SELECT id FROM eb_lang_type WHERE file_name='en-US' AND is_del=0 LIMIT 1);

INSERT INTO eb_lang_code (type_id, code, remarks, lang_explain, is_admin)
SELECT v.tid, v.code, v.remarks, v.explain_, 0 FROM (
  SELECT @t_zh tid, '会员中心' code, '会员中心' remarks, '会员中心' explain_
  UNION ALL SELECT @t_vi, '会员中心', '[待审]会员中心', 'Trung tâm hội viên'
  UNION ALL SELECT @t_en, '会员中心', '会员中心', 'Member center'
  UNION ALL SELECT @t_zh, '积分商城', '积分商城', '积分商城'
  UNION ALL SELECT @t_vi, '积分商城', '[待审]积分商城', 'Cửa hàng điểm'
  UNION ALL SELECT @t_en, '积分商城', '积分商城', 'Points mall'
  UNION ALL SELECT @t_zh, '查看新权益', '查看新权益', '查看新权益'
  UNION ALL SELECT @t_vi, '查看新权益', '[待审]查看新权益', 'Xem quyền lợi mới'
  UNION ALL SELECT @t_en, '查看新权益', '查看新权益', 'View new benefits'
  UNION ALL SELECT @t_zh, '限量兑神券', '限量兑神券', '限量兑神券'
  UNION ALL SELECT @t_vi, '限量兑神券', '[待审]限量兑神券', 'Đổi phiếu giới hạn'
  UNION ALL SELECT @t_en, '限量兑神券', '限量兑神券', 'Limited coupons'
  UNION ALL SELECT @t_zh, '更多', '更多', '更多'
  UNION ALL SELECT @t_vi, '更多', '[待审]更多', 'Thêm'
  UNION ALL SELECT @t_en, '更多', '更多', 'More'
  UNION ALL SELECT @t_zh, '领券中心', '领券中心', '领券中心'
  UNION ALL SELECT @t_vi, '领券中心', '[待审]领券中心', 'Trung tâm phiếu'
  UNION ALL SELECT @t_en, '领券中心', '领券中心', 'Coupon center'
  UNION ALL SELECT @t_zh, '个人资料', '个人资料', '个人资料'
  UNION ALL SELECT @t_vi, '个人资料', '[待审]个人资料', 'Hồ sơ cá nhân'
  UNION ALL SELECT @t_en, '个人资料', '个人资料', 'Profile'
  UNION ALL SELECT @t_zh, '售后', '售后', '售后'
  UNION ALL SELECT @t_vi, '售后', '[待审]售后', 'Hậu mãi'
  UNION ALL SELECT @t_en, '售后', '售后', 'After-sales'
  UNION ALL SELECT @t_zh, '售后/退款', '售后/退款', '售后/退款'
  UNION ALL SELECT @t_vi, '售后/退款', '[待审]售后/退款', 'Hậu mãi / hoàn tiền'
  UNION ALL SELECT @t_en, '售后/退款', '售后/退款', 'After-sales / Refund'
  UNION ALL SELECT @t_zh, '去登录', '去登录', '去登录'
  UNION ALL SELECT @t_vi, '去登录', '[待审]去登录', 'Đăng nhập'
  UNION ALL SELECT @t_en, '去登录', '去登录', 'Sign in'
  UNION ALL SELECT @t_zh, '设置', '设置', '设置'
  UNION ALL SELECT @t_vi, '设置', '[待审]设置', 'Cài đặt'
  UNION ALL SELECT @t_en, '设置', '设置', 'Settings'
) v
WHERE v.tid IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM eb_lang_code e WHERE e.type_id=v.tid AND e.code=v.code AND e.is_admin=0);

UPDATE eb_lang_code c
JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0
JOIN (
  SELECT '会员中心' zh, 'Trung tâm hội viên' vi UNION ALL
  SELECT '积分商城', 'Cửa hàng điểm' UNION ALL
  SELECT '查看新权益', 'Xem quyền lợi mới' UNION ALL
  SELECT '限量兑神券', 'Đổi phiếu giới hạn' UNION ALL
  SELECT '更多', 'Thêm' UNION ALL
  SELECT '领券中心', 'Trung tâm phiếu' UNION ALL
  SELECT '个人资料', 'Hồ sơ cá nhân' UNION ALL
  SELECT '售后', 'Hậu mãi' UNION ALL
  SELECT '售后/退款', 'Hậu mãi / hoàn tiền' UNION ALL
  SELECT '去登录', 'Đăng nhập' UNION ALL
  SELECT '设置', 'Cài đặt' UNION ALL
  SELECT '优品推荐', 'Gợi ý sản phẩm tốt'
) m ON m.zh=c.code
SET c.lang_explain=m.vi
WHERE c.is_admin=0;

DELETE FROM eb_cache WHERE `key` LIKE '%lang%' OR `key` LIKE 'api_lang%' OR `key`='lang_version';
