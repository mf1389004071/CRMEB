-- 空态文案词条三语补齐；幂等。
SET NAMES utf8mb4;
SET @t_zh := (SELECT id FROM eb_lang_type WHERE file_name='zh-CN' AND is_del=0 LIMIT 1);
SET @t_vi := (SELECT id FROM eb_lang_type WHERE file_name='vi-VN' AND is_del=0 LIMIT 1);
SET @t_en := (SELECT id FROM eb_lang_type WHERE file_name='en-US' AND is_del=0 LIMIT 1);

INSERT INTO eb_lang_code (type_id, code, remarks, lang_explain, is_admin)
SELECT v.tid, v.code, v.remarks, v.explain_, 0 FROM (
  SELECT @t_zh tid, '暂无添加地址~' code, '暂无添加地址~' remarks, '暂无添加地址~' explain_
  UNION ALL SELECT @t_vi, '暂无添加地址~', '[待审]暂无添加地址~', 'Chưa thêm địa chỉ~'
  UNION ALL SELECT @t_en, '暂无添加地址~', '暂无添加地址~', 'No address yet~'
  UNION ALL SELECT @t_zh, '还没有关注，赶快去关注一波吧~', '还没有关注，赶快去关注一波吧~', '还没有关注，赶快去关注一波吧~'
  UNION ALL SELECT @t_vi, '还没有关注，赶快去关注一波吧~', '[待审]还没有关注，赶快去关注一波吧~', 'Chưa theo dõi sản phẩm nào, hãy đi xem ngay~'
  UNION ALL SELECT @t_en, '还没有关注，赶快去关注一波吧~', '还没有关注，赶快去关注一波吧~', 'No favorites yet, go follow some~'
) v
WHERE v.tid IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM eb_lang_code e WHERE e.type_id=v.tid AND e.code=v.code AND e.is_admin=0);

UPDATE eb_lang_code c
JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0
JOIN (
  SELECT '暂无添加地址~' zh, 'Chưa thêm địa chỉ~' vi UNION ALL
  SELECT '还没有关注，赶快去关注一波吧~', 'Chưa theo dõi sản phẩm nào, hãy đi xem ngay~'
) m ON m.zh=c.code
SET c.lang_explain=m.vi, c.remarks=CONCAT('[待审]', m.zh)
WHERE c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain=m.zh);

UPDATE eb_lang_code c
JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0
JOIN (
  SELECT '暂无添加地址~' zh, 'No address yet~' en UNION ALL
  SELECT '还没有关注，赶快去关注一波吧~', 'No favorites yet, go follow some~'
) m ON m.zh=c.code
SET c.lang_explain=m.en
WHERE c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain=m.zh);

-- 单位「件」越语基线「Mảnh」偏怪，按商品销量单位改为 kiện
UPDATE eb_lang_code c
JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0
SET c.lang_explain='kiện', c.remarks='[待审]件'
WHERE c.code='件' AND c.is_admin=0 AND c.lang_explain IN ('件','Mảnh');

-- 「单」作订单量词时简写 đơn 更自然
UPDATE eb_lang_code c
JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0
SET c.lang_explain='đơn', c.remarks='[待审]单'
WHERE c.code='单' AND c.is_admin=0 AND c.lang_explain IN ('单','Đơn hàng');

DELETE FROM eb_cache WHERE `key` LIKE '%lang%' OR `key` LIKE 'api_lang%' OR `key`='lang_version';
