-- 由 scripts/i18n_missing_keys_to_sql.py 生成
-- 执行前请确认：1) 表名与 .env 中 DB_PREFIX 一致；2) type_id 与 eb_lang_type 中文类型一致
-- 目标表: `eb_lang_code`  type_id=1  is_admin=0
START TRANSACTION;

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '一', '一', '一', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '一' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '三', '三', '三', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '三' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '专题页', '专题页', '专题页', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '专题页' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '个', '个', '个', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '个' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '二', '二', '二', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '二' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '二维码生成中', '二维码生成中', '二维码生成中', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '二维码生成中' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '五', '五', '五', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '五' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '会员专享', '会员专享', '会员专享', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '会员专享' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '体育用品', '体育用品', '体育用品', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '体育用品' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '健身器械', '健身器械', '健身器械', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '健身器械' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '全部商品', '全部商品', '全部商品', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '全部商品' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '六', '六', '六', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '六' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '冰冰蓝', '冰冰蓝', '冰冰蓝', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '冰冰蓝' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '分享', '分享', '分享', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '分享' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '切换地址', '切换地址', '切换地址', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '切换地址' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '到手价', '到手价', '到手价', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '到手价' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '化妆品', '化妆品', '化妆品', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '化妆品' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '原价', '原价', '原价', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '原价' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '参数', '参数', '参数', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '参数' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '可选', '可选', '可选', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '可选' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '台式机', '台式机', '台式机', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '台式机' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '向右滑动完成验证', '向右滑动完成验证', '向右滑动完成验证', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '向右滑动完成验证' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '周', '周', '周', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '周' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '周一', '周一', '周一', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '周一' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '周三', '周三', '周三', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '周三' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '周二', '周二', '周二', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '周二' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '周五', '周五', '周五', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '周五' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '周六', '周六', '周六', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '周六' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '周四', '周四', '周四', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '周四' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '周日', '周日', '周日', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '周日' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '售价', '售价', '售价', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '售价' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '商品列表', '商品列表', '商品列表', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '商品列表' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '商城配送', '商城配送', '商城配送', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '商城配送' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '四', '四', '四', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '四' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '填写图片验证码', '填写图片验证码', '填写图片验证码', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '填写图片验证码' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '大电器', '大电器', '大电器', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '大电器' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '套', '套', '套', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '套' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '家电电器', '家电电器', '家电电器', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '家电电器' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '对话详情', '对话详情', '对话详情', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '对话详情' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '小家电', '小家电', '小家电', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '小家电' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '小白裙', '小白裙', '小白裙', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '小白裙' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '工具', '工具', '工具', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '工具' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '已读', '已读', '已读', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '已读' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '已连续签到', '已连续签到', '已连续签到', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '已连续签到' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '平板电脑', '平板电脑', '平板电脑', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '平板电脑' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '开通SVIP会员预计省', '开通SVIP会员预计省', '开通SVIP会员预计省', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '开通SVIP会员预计省' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '影音周边', '影音周边', '影音周边', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '影音周边' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '我的优惠券', '我的优惠券', '我的优惠券', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '我的优惠券' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '我的订单', '我的订单', '我的订单', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '我的订单' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '户外装备', '户外装备', '户外装备', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '户外装备' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '户外运动', '户外运动', '户外运动', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '户外运动' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '手机数码', '手机数码', '手机数码', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '手机数码' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '手机配件', '手机配件', '手机配件', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '手机配件' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '手表', '手表', '手表', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '手表' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '手表首饰', '手表首饰', '手表首饰', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '手表首饰' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '折叠手机', '折叠手机', '折叠手机', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '折叠手机' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '护肤品', '护肤品', '护肤品', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '护肤品' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '拼团简介', '拼团简介', '拼团简介', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '拼团简介' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '推广人', '推广人', '推广人', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '推广人' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '推广佣金', '推广佣金', '推广佣金', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '推广佣金' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '提供具有辨识度的用户中心界面', '提供具有辨识度的用户中心界面', '提供具有辨识度的用户中心界面', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '提供具有辨识度的用户中心界面' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '收藏商品', '收藏商品', '收藏商品', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '收藏商品' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '日', '日', '日', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '日' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '日常用品', '日常用品', '日常用品', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '日常用品' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '智能家居', '智能家居', '智能家居', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '智能家居' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '智能手机', '智能手机', '智能手机', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '智能手机' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '服务保障', '服务保障', '服务保障', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '服务保障' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '服饰', '服饰', '服饰', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '服饰' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '服饰鞋包', '服饰鞋包', '服饰鞋包', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '服饰鞋包' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '机型', '机型', '机型', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '机型' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '杂货', '杂货', '杂货', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '杂货' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '款', '款', '款', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '款' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '消息中心', '消息中心', '消息中心', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '消息中心' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '清洁', '清洁', '清洁', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '清洁' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '清洁用品', '清洁用品', '清洁用品', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '清洁用品' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '游戏机', '游戏机', '游戏机', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '游戏机' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '点击查看', '点击查看', '点击查看', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '点击查看' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '用户协议', '用户协议', '用户协议', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '用户协议' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '由平台为您提供配送服务', '由平台为您提供配送服务', '由平台为您提供配送服务', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '由平台为您提供配送服务' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '申请', '申请', '申请', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '申请' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '电脑办公', '电脑办公', '电脑办公', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '电脑办公' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '直径', '直径', '直径', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '直径' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '知道了', '知道了', '知道了', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '知道了' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '积分详情', '积分详情', '积分详情', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '积分详情' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '穿戴设备', '穿戴设备', '穿戴设备', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '穿戴设备' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '立即试用', '立即试用', '立即试用', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '立即试用' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '笔记本', '笔记本', '笔记本', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '笔记本' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '签到功能已关闭', '签到功能已关闭', '签到功能已关闭', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '签到功能已关闭' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '签到立即获取', '签到立即获取', '签到立即获取', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '签到立即获取' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '箱包', '箱包', '箱包', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '箱包' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '美妆个护', '美妆个护', '美妆个护', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '美妆个护' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '获取您的昵称、头像', '获取您的昵称、头像', '获取您的昵称、头像', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '获取您的昵称、头像' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '设置', '设置', '设置', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '设置' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '请依次点击【', '请依次点击【', '请依次点击【', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '请依次点击【' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '请完成安全验证', '请完成安全验证', '请完成安全验证', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '请完成安全验证' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '请点击登录', '请点击登录', '请点击登录', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '请点击登录' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '请输入昵称', '请输入昵称', '请输入昵称', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '请输入昵称' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '这是送您的一份礼物~', '这是送您的一份礼物~', '这是送您的一份礼物~', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '这是送您的一份礼物~' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '连续签到', '连续签到', '连续签到', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '连续签到' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '选择', '选择', '选择', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '选择' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '银色', '银色', '银色', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '银色' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '限量剩余', '限量剩余', '限量剩余', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '限量剩余' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '鞋子', '鞋子', '鞋子', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '鞋子' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '颜色', '颜色', '颜色', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '颜色' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '饰品', '饰品', '饰品', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '饰品' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '首饰', '首饰', '首饰', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '首饰' AND `is_admin` = 0);

INSERT INTO `eb_lang_code` (`type_id`, `code`, `remarks`, `lang_explain`, `is_admin`)
SELECT 1, '黑色', '黑色', '黑色', 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `eb_lang_code` WHERE `type_id` = 1 AND `code` = '黑色' AND `is_admin` = 0);


COMMIT;
