-- VN UI：版权、分类内容多语、首页/页脚常用 DIY 文案词条。幂等。
SET NAMES utf8mb4;

-- 1) 版权文案 → Alpha Fangding（英文）
INSERT INTO eb_system_config (menu_name, type, input_type, parameter, upload_type, required, width, high, value, info, `desc`, sort, status)
SELECT 'nncnL_crmeb_copyright', 'text', 'input', '', 1, '', 100, 0,
       '"Copyright © Alpha Fangding. All rights reserved."',
       '移动端版权文案', '我的页底部版权', 0, 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM eb_system_config WHERE menu_name='nncnL_crmeb_copyright');

UPDATE eb_system_config
SET value='"Copyright © Alpha Fangding. All rights reserved."'
WHERE menu_name='nncnL_crmeb_copyright';

UPDATE eb_system_config
SET value='""'
WHERE menu_name='nncnL_crmeb_copyright_image';

-- 2) 一级分类内容多语：主表保留中文；补 vi-VN / en-US / zh-CN
--    API 按 Cb-lang 走 applyTree，缺译文时回落主表。
DROP TEMPORARY TABLE IF EXISTS tmp_cate_i18n;
CREATE TEMPORARY TABLE tmp_cate_i18n (
  cate_name_zh VARCHAR(64) PRIMARY KEY,
  vi VARCHAR(128) NOT NULL,
  en VARCHAR(128) NOT NULL
);
INSERT INTO tmp_cate_i18n (cate_name_zh, vi, en) VALUES
('手机数码', 'Điện thoại & số', 'Phones & Digital'),
('电脑办公', 'Máy tính & văn phòng', 'Computers & Office'),
('日常用品', 'Đồ dùng hàng ngày', 'Daily necessities'),
('户外运动', 'Thể thao ngoài trời', 'Outdoor & Sports'),
('家电电器', 'Điện gia dụng', 'Home appliances'),
('手表首饰', 'Đồng hồ & trang sức', 'Watches & Jewelry'),
('美妆个护', 'Làm đẹp & chăm sóc', 'Beauty & Personal care'),
('服饰鞋包', 'Thời trang & túi', 'Fashion & Bags'),
('生活家居', 'Đời sống & nhà cửa', 'Home & Living'),
('运动专区', 'Khu thể thao', 'Sports zone'),
('电子产品', 'Điện tử', 'Electronics'),
('家用电器', 'Điện gia dụng', 'Home appliances');

-- MySQL 临时表不可在同一语句中打开两次，拆成三次插入
INSERT INTO eb_i18n_content (entity_type, entity_id, field, lang, value, status, add_time, update_time)
SELECT 'category', c.id, 'cate_name', 'vi-VN', t.vi, 1, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
FROM eb_store_category c
JOIN tmp_cate_i18n t ON t.cate_name_zh = c.cate_name
WHERE NOT EXISTS (
  SELECT 1 FROM eb_i18n_content e
  WHERE e.entity_type='category' AND e.entity_id=c.id AND e.field='cate_name' AND e.lang='vi-VN'
);

INSERT INTO eb_i18n_content (entity_type, entity_id, field, lang, value, status, add_time, update_time)
SELECT 'category', c.id, 'cate_name', 'en-US', t.en, 1, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
FROM eb_store_category c
JOIN tmp_cate_i18n t ON t.cate_name_zh = c.cate_name
WHERE NOT EXISTS (
  SELECT 1 FROM eb_i18n_content e
  WHERE e.entity_type='category' AND e.entity_id=c.id AND e.field='cate_name' AND e.lang='en-US'
);

INSERT INTO eb_i18n_content (entity_type, entity_id, field, lang, value, status, add_time, update_time)
SELECT 'category', c.id, 'cate_name', 'zh-CN', t.cate_name_zh, 1, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
FROM eb_store_category c
JOIN tmp_cate_i18n t ON t.cate_name_zh = c.cate_name
WHERE NOT EXISTS (
  SELECT 1 FROM eb_i18n_content e
  WHERE e.entity_type='category' AND e.entity_id=c.id AND e.field='cate_name' AND e.lang='zh-CN'
);

DROP TEMPORARY TABLE IF EXISTS tmp_cate_i18n;

-- 3) DIY / 页脚常用 front 词条（三语）
SET @t_zh := (SELECT id FROM eb_lang_type WHERE file_name='zh-CN' AND is_del=0 LIMIT 1);
SET @t_vi := (SELECT id FROM eb_lang_type WHERE file_name='vi-VN' AND is_del=0 LIMIT 1);
SET @t_en := (SELECT id FROM eb_lang_type WHERE file_name='en-US' AND is_del=0 LIMIT 1);

INSERT INTO eb_lang_code (type_id, code, remarks, lang_explain, is_admin)
SELECT v.tid, v.code, v.remarks, v.explain_, 0 FROM (
  SELECT @t_zh AS tid, '优品推荐' AS code, '优品推荐' AS remarks, '优品推荐' AS explain_
  UNION ALL SELECT @t_vi, '优品推荐', '[待审]优品推荐', 'Gợi ý sản phẩm tốt'
  UNION ALL SELECT @t_en, '优品推荐', '优品推荐', 'Featured picks'
  UNION ALL SELECT @t_zh, '热门推荐', '热门推荐', '热门推荐'
  UNION ALL SELECT @t_vi, '热门推荐', '[待审]热门推荐', 'Đề xuất phổ biến'
  UNION ALL SELECT @t_en, '热门推荐', '热门推荐', 'Popular'
  UNION ALL SELECT @t_zh, '首页', '首页', '首页'
  UNION ALL SELECT @t_vi, '首页', '[待审]首页', 'Trang chủ'
  UNION ALL SELECT @t_en, '首页', '首页', 'Home'
  UNION ALL SELECT @t_zh, '分类', '分类', '分类'
  UNION ALL SELECT @t_vi, '分类', '[待审]分类', 'Danh mục'
  UNION ALL SELECT @t_en, '分类', '分类', 'Category'
  UNION ALL SELECT @t_zh, '购物车', '购物车', '购物车'
  UNION ALL SELECT @t_vi, '购物车', '[待审]购物车', 'Giỏ hàng'
  UNION ALL SELECT @t_en, '购物车', '购物车', 'Cart'
  UNION ALL SELECT @t_zh, '我的', '我的', '我的'
  UNION ALL SELECT @t_vi, '我的', '[待审]我的', 'Tôi'
  UNION ALL SELECT @t_en, '我的', '我的', 'Me'
  UNION ALL SELECT @t_zh, '语言切换', '语言切换', '语言切换'
  UNION ALL SELECT @t_vi, '语言切换', '[待审]语言切换', 'Đổi ngôn ngữ'
  UNION ALL SELECT @t_en, '语言切换', '语言切换', 'Language'
  UNION ALL SELECT @t_zh, '语言', '语言', '语言'
  UNION ALL SELECT @t_vi, '语言', '[待审]语言', 'Ngôn ngữ'
  UNION ALL SELECT @t_en, '语言', '语言', 'Language'
  UNION ALL SELECT @t_zh, '请输入搜索词', '请输入搜索词', '请输入搜索词'
  UNION ALL SELECT @t_vi, '请输入搜索词', '[待审]请输入搜索词', 'Nhập từ khóa tìm kiếm'
  UNION ALL SELECT @t_en, '请输入搜索词', '请输入搜索词', 'Enter keywords'
  UNION ALL SELECT @t_zh, '限时秒杀', '限时秒杀', '限时秒杀'
  UNION ALL SELECT @t_vi, '限时秒杀', '[待审]限时秒杀', 'Flash sale'
  UNION ALL SELECT @t_en, '限时秒杀', '限时秒杀', 'Flash sale'
  UNION ALL SELECT @t_zh, '拼团活动', '拼团活动', '拼团活动'
  UNION ALL SELECT @t_vi, '拼团活动', '[待审]拼团活动', 'Mua chung'
  UNION ALL SELECT @t_en, '拼团活动', '拼团活动', 'Group buy'
  UNION ALL SELECT @t_zh, '商品分类', '商品分类', '商品分类'
  UNION ALL SELECT @t_vi, '商品分类', '[待审]商品分类', 'Danh mục sản phẩm'
  UNION ALL SELECT @t_en, '商品分类', '商品分类', 'Categories'
  UNION ALL SELECT @t_zh, '生活家居', '生活家居', '生活家居'
  UNION ALL SELECT @t_vi, '生活家居', '[待审]生活家居', 'Đời sống & nhà cửa'
  UNION ALL SELECT @t_en, '生活家居', '生活家居', 'Home & Living'
  UNION ALL SELECT @t_zh, '运动专区', '运动专区', '运动专区'
  UNION ALL SELECT @t_vi, '运动专区', '[待审]运动专区', 'Khu thể thao'
  UNION ALL SELECT @t_en, '运动专区', '运动专区', 'Sports'
  UNION ALL SELECT @t_zh, '电子产品', '电子产品', '电子产品'
  UNION ALL SELECT @t_vi, '电子产品', '[待审]电子产品', 'Điện tử'
  UNION ALL SELECT @t_en, '电子产品', '电子产品', 'Electronics'
  UNION ALL SELECT @t_zh, '家用电器', '家用电器', '家用电器'
  UNION ALL SELECT @t_vi, '家用电器', '[待审]家用电器', 'Điện gia dụng'
  UNION ALL SELECT @t_en, '家用电器', '家用电器', 'Appliances'
  UNION ALL SELECT @t_zh, '首发新品', '首发新品', '首发新品'
  UNION ALL SELECT @t_vi, '首发新品', '[待审]首发新品', 'Hàng mới'
  UNION ALL SELECT @t_en, '首发新品', '首发新品', 'New arrivals'
  UNION ALL SELECT @t_zh, '最新出炉', '最新出炉', '最新出炉'
  UNION ALL SELECT @t_vi, '最新出炉', '[待审]最新出炉', 'Mới nhất'
  UNION ALL SELECT @t_en, '最新出炉', '最新出炉', 'Just in'
  UNION ALL SELECT @t_zh, '好物好价', '好物好价', '好物好价'
  UNION ALL SELECT @t_vi, '好物好价', '[待审]好物好价', 'Giá tốt'
  UNION ALL SELECT @t_en, '好物好价', '好物好价', 'Good deals'
  UNION ALL SELECT @t_zh, '爆款热卖', '爆款热卖', '爆款热卖'
  UNION ALL SELECT @t_vi, '爆款热卖', '[待审]爆款热卖', 'Bán chạy'
  UNION ALL SELECT @t_en, '爆款热卖', '爆款热卖', 'Best sellers'
  UNION ALL SELECT @t_zh, '鞋靴箱包', '鞋靴箱包', '鞋靴箱包'
  UNION ALL SELECT @t_vi, '鞋靴箱包', '[待审]鞋靴箱包', 'Giày dép & túi'
  UNION ALL SELECT @t_en, '鞋靴箱包', '鞋靴箱包', 'Shoes & bags'
  UNION ALL SELECT @t_zh, '猜你喜欢', '猜你喜欢', '猜你喜欢'
  UNION ALL SELECT @t_vi, '猜你喜欢', '[待审]猜你喜欢', 'Có thể bạn thích'
  UNION ALL SELECT @t_en, '猜你喜欢', '猜你喜欢', 'You may like'
) v
WHERE v.tid IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM eb_lang_code e WHERE e.type_id=v.tid AND e.code=v.code AND e.is_admin=0);

-- 页脚等高频词强制覆盖（含历史机翻不准的 Lớp / Của tôi 等）
UPDATE eb_lang_code c
JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0
JOIN (
  SELECT '优品推荐' zh, 'Gợi ý sản phẩm tốt' vi UNION ALL
  SELECT '热门推荐', 'Đề xuất phổ biến' UNION ALL
  SELECT '首页', 'Trang chủ' UNION ALL
  SELECT '分类', 'Danh mục' UNION ALL
  SELECT '购物车', 'Giỏ hàng' UNION ALL
  SELECT '我的', 'Tôi' UNION ALL
  SELECT '语言切换', 'Đổi ngôn ngữ' UNION ALL
  SELECT '语言', 'Ngôn ngữ' UNION ALL
  SELECT '请输入搜索词', 'Nhập từ khóa tìm kiếm' UNION ALL
  SELECT '商品分类', 'Danh mục sản phẩm' UNION ALL
  SELECT '生活家居', 'Đời sống & nhà cửa' UNION ALL
  SELECT '运动专区', 'Khu thể thao' UNION ALL
  SELECT '电子产品', 'Điện tử' UNION ALL
  SELECT '家用电器', 'Điện gia dụng' UNION ALL
  SELECT '首发新品', 'Hàng mới' UNION ALL
  SELECT '最新出炉', 'Mới nhất' UNION ALL
  SELECT '好物好价', 'Giá tốt' UNION ALL
  SELECT '爆款热卖', 'Bán chạy' UNION ALL
  SELECT '鞋靴箱包', 'Giày dép & túi' UNION ALL
  SELECT '猜你喜欢', 'Có thể bạn thích'
) m ON m.zh=c.code
SET c.lang_explain=m.vi, c.remarks=CONCAT('[待审]', m.zh)
WHERE c.is_admin=0;

-- 清语言缓存标记：执行后删 runtime/cache 与 eb_cache lang_*
DELETE FROM eb_cache WHERE `key` LIKE '%lang%' OR `key` LIKE 'api_lang%' OR `key`='lang_version' OR `key` LIKE '%config%';
