-- 由 scripts/i18n_extract_uni_t_keys.py 生成；幂等。
SET NAMES utf8mb4;
SET @t_zh := (SELECT id FROM eb_lang_type WHERE file_name='zh-CN' AND is_del=0 LIMIT 1);
SET @t_vi := (SELECT id FROM eb_lang_type WHERE file_name='vi-VN' AND is_del=0 LIMIT 1);
SET @t_en := (SELECT id FROM eb_lang_type WHERE file_name='en-US' AND is_del=0 LIMIT 1);

INSERT INTO eb_lang_code (type_id, code, remarks, lang_explain, is_admin)
SELECT v.tid, v.code, v.remarks, v.explain_, v.is_admin FROM (
  SELECT @t_zh AS tid, '请输入搜索词' AS code, '请输入搜索词' AS remarks, '请输入搜索词' AS explain_, 0 AS is_admin, '请输入搜索词' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请输入搜索词' AS code, '[待审]请输入搜索词' AS remarks, 'Nhập từ khóa tìm kiếm' AS explain_, 0 AS is_admin, '请输入搜索词' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请输入搜索词' AS code, '请输入搜索词' AS remarks, 'Enter search keywords' AS explain_, 0 AS is_admin, '请输入搜索词' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '猜你喜欢' AS code, '猜你喜欢' AS remarks, '猜你喜欢' AS explain_, 0 AS is_admin, '猜你喜欢' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '猜你喜欢' AS code, '[待审]猜你喜欢' AS remarks, 'Có thể bạn thích' AS explain_, 0 AS is_admin, '猜你喜欢' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '猜你喜欢' AS code, '猜你喜欢' AS remarks, 'You may also like' AS explain_, 0 AS is_admin, '猜你喜欢' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '砍价中心' AS code, '砍价中心' AS remarks, '砍价中心' AS explain_, 0 AS is_admin, '砍价中心' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '砍价中心' AS code, '[待审]砍价中心' AS remarks, 'Trung tâm mặc cả' AS explain_, 0 AS is_admin, '砍价中心' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '砍价中心' AS code, '砍价中心' AS remarks, 'Bargain center' AS explain_, 0 AS is_admin, '砍价中心' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '抽奖活动' AS code, '抽奖活动' AS remarks, '抽奖活动' AS explain_, 0 AS is_admin, '抽奖活动' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '抽奖活动' AS code, '[待审]抽奖活动' AS remarks, 'Hoạt động rút thăm' AS explain_, 0 AS is_admin, '抽奖活动' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '抽奖活动' AS code, '抽奖活动' AS remarks, 'Lucky draw' AS explain_, 0 AS is_admin, '抽奖活动' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '最新出炉' AS code, '最新出炉' AS remarks, '最新出炉' AS explain_, 0 AS is_admin, '最新出炉' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '最新出炉' AS code, '[待审]最新出炉' AS remarks, 'Mới nhất' AS explain_, 0 AS is_admin, '最新出炉' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '最新出炉' AS code, '最新出炉' AS remarks, 'Just dropped' AS explain_, 0 AS is_admin, '最新出炉' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '好物好价' AS code, '好物好价' AS remarks, '好物好价' AS explain_, 0 AS is_admin, '好物好价' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '好物好价' AS code, '[待审]好物好价' AS remarks, 'Hàng tốt giá tốt' AS explain_, 0 AS is_admin, '好物好价' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '好物好价' AS code, '好物好价' AS remarks, 'Good deals' AS explain_, 0 AS is_admin, '好物好价' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '爆款热卖' AS code, '爆款热卖' AS remarks, '爆款热卖' AS explain_, 0 AS is_admin, '爆款热卖' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '爆款热卖' AS code, '[待审]爆款热卖' AS remarks, 'Bán chạy' AS explain_, 0 AS is_admin, '爆款热卖' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '爆款热卖' AS code, '爆款热卖' AS remarks, 'Best sellers' AS explain_, 0 AS is_admin, '爆款热卖' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '鞋靴箱包' AS code, '鞋靴箱包' AS remarks, '鞋靴箱包' AS explain_, 0 AS is_admin, '鞋靴箱包' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '鞋靴箱包' AS code, '[待审]鞋靴箱包' AS remarks, 'Giày dép & túi' AS explain_, 0 AS is_admin, '鞋靴箱包' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '鞋靴箱包' AS code, '鞋靴箱包' AS remarks, 'Shoes & bags' AS explain_, 0 AS is_admin, '鞋靴箱包' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '个' AS code, '个' AS remarks, '个' AS explain_, 0 AS is_admin, '个' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '个' AS code, '[待审]个' AS remarks, 'cái' AS explain_, 0 AS is_admin, '个' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '个' AS code, '个' AS remarks, 'pcs' AS explain_, 0 AS is_admin, '个' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '套' AS code, '套' AS remarks, '套' AS explain_, 0 AS is_admin, '套' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '套' AS code, '[待审]套' AS remarks, 'bộ' AS explain_, 0 AS is_admin, '套' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '套' AS code, '套' AS remarks, 'set' AS explain_, 0 AS is_admin, '套' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '商品列表' AS code, '商品列表' AS remarks, '商品列表' AS explain_, 0 AS is_admin, '商品列表' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '商品列表' AS code, '[待审]商品列表' AS remarks, 'Danh sách sản phẩm' AS explain_, 0 AS is_admin, '商品列表' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '商品列表' AS code, '商品列表' AS remarks, 'Product list' AS explain_, 0 AS is_admin, '商品列表' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '生活家居' AS code, '生活家居' AS remarks, '生活家居' AS explain_, 0 AS is_admin, '生活家居' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '生活家居' AS code, '[待审]生活家居' AS remarks, 'Đời sống & nhà cửa' AS explain_, 0 AS is_admin, '生活家居' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '生活家居' AS code, '生活家居' AS remarks, 'Home & living' AS explain_, 0 AS is_admin, '生活家居' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '运动专区' AS code, '运动专区' AS remarks, '运动专区' AS explain_, 0 AS is_admin, '运动专区' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '运动专区' AS code, '[待审]运动专区' AS remarks, 'Khu thể thao' AS explain_, 0 AS is_admin, '运动专区' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '运动专区' AS code, '运动专区' AS remarks, 'Sports zone' AS explain_, 0 AS is_admin, '运动专区' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '电子产品' AS code, '电子产品' AS remarks, '电子产品' AS explain_, 0 AS is_admin, '电子产品' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '电子产品' AS code, '[待审]电子产品' AS remarks, 'Điện tử' AS explain_, 0 AS is_admin, '电子产品' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '电子产品' AS code, '电子产品' AS remarks, 'Electronics' AS explain_, 0 AS is_admin, '电子产品' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '家用电器' AS code, '家用电器' AS remarks, '家用电器' AS explain_, 0 AS is_admin, '家用电器' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '家用电器' AS code, '[待审]家用电器' AS remarks, 'Điện gia dụng' AS explain_, 0 AS is_admin, '家用电器' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '家用电器' AS code, '家用电器' AS remarks, 'Home appliances' AS explain_, 0 AS is_admin, '家用电器' AS zh_
) v
WHERE v.tid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM eb_lang_code e WHERE e.type_id = v.tid AND e.code = v.code);

-- 补翻：已有越语/英语占位（等于中文）时更新 lang_explain
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Nhập từ khóa tìm kiếm', c.remarks='[待审]请输入搜索词' WHERE c.code='请输入搜索词' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请输入搜索词');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Enter search keywords' WHERE c.code='请输入搜索词' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请输入搜索词');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Có thể bạn thích', c.remarks='[待审]猜你喜欢' WHERE c.code='猜你喜欢' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='猜你喜欢');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='You may also like' WHERE c.code='猜你喜欢' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='猜你喜欢');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Trung tâm mặc cả', c.remarks='[待审]砍价中心' WHERE c.code='砍价中心' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='砍价中心');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Bargain center' WHERE c.code='砍价中心' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='砍价中心');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Hoạt động rút thăm', c.remarks='[待审]抽奖活动' WHERE c.code='抽奖活动' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='抽奖活动');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Lucky draw' WHERE c.code='抽奖活动' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='抽奖活动');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Mới nhất', c.remarks='[待审]最新出炉' WHERE c.code='最新出炉' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='最新出炉');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Just dropped' WHERE c.code='最新出炉' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='最新出炉');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Hàng tốt giá tốt', c.remarks='[待审]好物好价' WHERE c.code='好物好价' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='好物好价');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Good deals' WHERE c.code='好物好价' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='好物好价');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Bán chạy', c.remarks='[待审]爆款热卖' WHERE c.code='爆款热卖' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='爆款热卖');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Best sellers' WHERE c.code='爆款热卖' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='爆款热卖');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Giày dép & túi', c.remarks='[待审]鞋靴箱包' WHERE c.code='鞋靴箱包' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='鞋靴箱包');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Shoes & bags' WHERE c.code='鞋靴箱包' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='鞋靴箱包');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='cái', c.remarks='[待审]个' WHERE c.code='个' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='个');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='pcs' WHERE c.code='个' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='个');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='bộ', c.remarks='[待审]套' WHERE c.code='套' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='套');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='set' WHERE c.code='套' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='套');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Danh sách sản phẩm', c.remarks='[待审]商品列表' WHERE c.code='商品列表' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='商品列表');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Product list' WHERE c.code='商品列表' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='商品列表');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Đời sống & nhà cửa', c.remarks='[待审]生活家居' WHERE c.code='生活家居' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='生活家居');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Home & living' WHERE c.code='生活家居' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='生活家居');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Khu thể thao', c.remarks='[待审]运动专区' WHERE c.code='运动专区' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='运动专区');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Sports zone' WHERE c.code='运动专区' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='运动专区');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Điện tử', c.remarks='[待审]电子产品' WHERE c.code='电子产品' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='电子产品');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Electronics' WHERE c.code='电子产品' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='电子产品');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Điện gia dụng', c.remarks='[待审]家用电器' WHERE c.code='家用电器' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='家用电器');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Home appliances' WHERE c.code='家用电器' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='家用电器');

