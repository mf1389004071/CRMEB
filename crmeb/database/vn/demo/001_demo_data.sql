-- 菜集鲜开发环境演示数据（非生产）。幂等可重复执行。
-- 依赖：已执行 database/vn/000～100 迁移；021 区划种子；现有商品 id 1～4。
-- 回滚提示：DELETE FROM eb_store_product_region_price WHERE product_id IN (1,2,3,4);
--           DELETE FROM eb_i18n_content WHERE entity_type='product' AND entity_id IN (1,2,3,4);
--           DELETE FROM eb_system_group_data WHERE gid=(SELECT id FROM eb_system_group WHERE config_name='vn_contact');
SET NAMES utf8mb4;

SET @now := UNIX_TIMESTAMP();

-- ========== 1) 联系方式演示 ==========
SET @gid := (SELECT id FROM eb_system_group WHERE config_name = 'vn_contact' LIMIT 1);
INSERT INTO eb_system_group_data (gid, value, add_time, sort, status)
SELECT @gid,
  '{"type":{"type":"select","value":"zalo"},"account":{"type":"input","value":"0901234567"},"qrcode_url":{"type":"upload","value":""}}',
  @now, 10, 1
FROM DUAL WHERE @gid IS NOT NULL
  AND NOT EXISTS (
    SELECT 1 FROM eb_system_group_data d
    WHERE d.gid = @gid AND d.value LIKE '%"value":"zalo"%' AND d.value LIKE '%0901234567%'
  );
INSERT INTO eb_system_group_data (gid, value, add_time, sort, status)
SELECT @gid,
  '{"type":{"type":"select","value":"phone"},"account":{"type":"input","value":"+84901234567"},"qrcode_url":{"type":"upload","value":""}}',
  @now, 9, 1
FROM DUAL WHERE @gid IS NOT NULL
  AND NOT EXISTS (
    SELECT 1 FROM eb_system_group_data d
    WHERE d.gid = @gid AND d.value LIKE '%"value":"phone"%' AND d.value LIKE '%84901234567%'
  );
INSERT INTO eb_system_group_data (gid, value, add_time, sort, status)
SELECT @gid,
  '{"type":{"type":"select","value":"email"},"account":{"type":"input","value":"demo@caijixian.vn"},"qrcode_url":{"type":"upload","value":""}}',
  @now, 8, 1
FROM DUAL WHERE @gid IS NOT NULL
  AND NOT EXISTS (
    SELECT 1 FROM eb_system_group_data d
    WHERE d.gid = @gid AND d.value LIKE '%demo@caijixian.vn%'
  );

-- ========== 2) 区划：确保演示城市开放/热门 ==========
UPDATE eb_system_city SET is_open = 1, is_hot = 1, sort = 100 WHERE city_id = 910001; -- Hà Nội
UPDATE eb_system_city SET is_open = 1, is_hot = 1, sort = 99 WHERE city_id = 910002;  -- HCMC
UPDATE eb_system_city SET is_open = 1, is_hot = 1, sort = 80 WHERE city_id = 910003;  -- Đà Nẵng
UPDATE eb_system_city SET is_open = 1 WHERE country_code = 'VN' AND level >= 0;
UPDATE eb_system_city SET is_open = 1, is_hot = 0 WHERE city_id = 900002;

-- ========== 3) 商品改成生鲜演示品（沿用 id 1～4，避免重建规格） ==========
UPDATE eb_store_product SET
  store_name = 'Rau cải xanh (demo)',
  store_info = 'Rau tươi Đà Lạt',
  unit_name = 'kg',
  price = 45000.00,
  ot_price = 52000.00,
  is_fresh = 1,
  net_weight = 1.00,
  shelf_life_days = 3,
  shelf_life_text = '3 ngày',
  origin = 'Đà Lạt',
  need_cold_chain = 1,
  cold_chain_note = 'Giữ mát 0-4℃',
  tax_rate = 0.00,
  allow_national_price = 0,
  is_show = 1,
  is_del = 0
WHERE id = 1;

UPDATE eb_store_product SET
  store_name = 'Cà chua bi (demo)',
  store_info = 'Giá cấp quốc gia',
  unit_name = 'kg',
  price = 35000.00,
  ot_price = 40000.00,
  is_fresh = 1,
  net_weight = 1.00,
  shelf_life_days = 5,
  shelf_life_text = '5 ngày',
  origin = 'Lâm Đồng',
  need_cold_chain = 0,
  cold_chain_note = '',
  tax_rate = 0.00,
  allow_national_price = 0,
  is_show = 1,
  is_del = 0
WHERE id = 2;

UPDATE eb_store_product SET
  store_name = 'Chuối sứ (demo)',
  store_info = 'Chuối tươi',
  unit_name = 'kg',
  price = 28000.00,
  ot_price = 32000.00,
  is_fresh = 1,
  net_weight = 1.00,
  shelf_life_days = 4,
  shelf_life_text = '4 ngày',
  origin = 'Đồng Nai',
  need_cold_chain = 0,
  cold_chain_note = '',
  tax_rate = 0.00,
  allow_national_price = 0,
  is_show = 1,
  is_del = 0
WHERE id = 3;

UPDATE eb_store_product SET
  store_name = 'Tôm thẻ (demo)',
  store_info = 'Hải sản cần lạnh',
  unit_name = 'kg',
  price = 180000.00,
  ot_price = 199000.00,
  is_fresh = 1,
  net_weight = 1.00,
  shelf_life_days = 2,
  shelf_life_text = '2 ngày',
  origin = 'Cà Mau',
  need_cold_chain = 1,
  cold_chain_note = 'Đông lạnh / đá lạnh',
  tax_rate = 0.00,
  allow_national_price = 1,
  is_show = 1,
  is_del = 0
WHERE id = 4;

-- 规格主表价同步为本位币演示价（列表/全国价回落用）
UPDATE eb_store_product_attr_value a
JOIN eb_store_product p ON p.id = a.product_id
SET a.price = p.price, a.ot_price = p.ot_price, a.stock = GREATEST(a.stock, 100)
WHERE a.product_id IN (1, 2, 3, 4);

-- ========== 4) 区域价演示（对齐 M2-7 场景） ==========
-- 商品1：Hà Nội 45000 / Ba Đình 42000 / Hoàn Kiếm 43000（兄弟不串价）
-- 商品2：仅国家层 VN 35000（向上命中国家价）
-- 商品3：Hà Nội 28000 / Ba Đình 26000
-- 商品4：Hà Nội 180000 / Ba Đình 175000（允许全国价开关已开，Thanh Hóa 可回落主表价需系统总闸）

DELETE FROM eb_store_product_region_price WHERE product_id IN (1, 2, 3, 4);

INSERT INTO eb_store_product_region_price (product_id, `unique`, city_id, price, ot_price, stock, status, add_time, update_time)
SELECT a.product_id, a.`unique`, c.city_id, c.price, c.ot_price, c.stock, 1, @now, @now
FROM eb_store_product_attr_value a
JOIN (
  SELECT 1 AS product_id, 910001 AS city_id, 45000.00 AS price, 52000.00 AS ot_price, NULL AS stock
  UNION ALL SELECT 1, 911001, 42000.00, 50000.00, 80
  UNION ALL SELECT 1, 911002, 43000.00, 50000.00, NULL
  UNION ALL SELECT 2, 900002, 35000.00, 40000.00, NULL
  UNION ALL SELECT 3, 910001, 28000.00, 32000.00, NULL
  UNION ALL SELECT 3, 911001, 26000.00, 30000.00, NULL
  UNION ALL SELECT 4, 910001, 180000.00, 199000.00, 50
  UNION ALL SELECT 4, 911001, 175000.00, 195000.00, 40
) c ON c.product_id = a.product_id
WHERE a.product_id IN (1, 2, 3, 4);

-- ========== 5) 商品多语演示 ==========
DELETE FROM eb_i18n_content WHERE entity_type = 'product' AND entity_id IN (1, 2, 3, 4) AND field = 'store_name';

INSERT INTO eb_i18n_content (entity_type, entity_id, field, lang, value, status, add_time, update_time) VALUES
('product', 1, 'store_name', 'zh-CN', '青菜（演示）', 1, @now, @now),
('product', 1, 'store_name', 'en-US', 'Leafy greens (demo)', 1, @now, @now),
('product', 1, 'store_name', 'vi-VN', 'Rau cải xanh (demo)', 1, @now, @now),
('product', 2, 'store_name', 'zh-CN', '小番茄（演示）', 1, @now, @now),
('product', 2, 'store_name', 'en-US', 'Cherry tomato (demo)', 1, @now, @now),
('product', 2, 'store_name', 'vi-VN', 'Cà chua bi (demo)', 1, @now, @now),
('product', 3, 'store_name', 'zh-CN', '香蕉（演示）', 1, @now, @now),
('product', 3, 'store_name', 'en-US', 'Banana (demo)', 1, @now, @now),
('product', 3, 'store_name', 'vi-VN', 'Chuối sứ (demo)', 1, @now, @now),
('product', 4, 'store_name', 'zh-CN', '南美白对虾（演示）', 1, @now, @now),
('product', 4, 'store_name', 'en-US', 'White shrimp (demo)', 1, @now, @now),
('product', 4, 'store_name', 'vi-VN', 'Tôm thẻ (demo)', 1, @now, @now);

-- 区划名中文演示
INSERT INTO eb_i18n_content (entity_type, entity_id, field, lang, value, status, add_time, update_time)
SELECT 'city', 910001, 'name', 'zh-CN', '河内', 1, @now, @now FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM eb_i18n_content WHERE entity_type='city' AND entity_id=910001 AND field='name' AND lang='zh-CN');
INSERT INTO eb_i18n_content (entity_type, entity_id, field, lang, value, status, add_time, update_time)
SELECT 'city', 910002, 'name', 'zh-CN', '胡志明市', 1, @now, @now FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM eb_i18n_content WHERE entity_type='city' AND entity_id=910002 AND field='name' AND lang='zh-CN');
INSERT INTO eb_i18n_content (entity_type, entity_id, field, lang, value, status, add_time, update_time)
SELECT 'city', 900002, 'name', 'zh-CN', '越南', 1, @now, @now FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM eb_i18n_content WHERE entity_type='city' AND entity_id=900002 AND field='name' AND lang='zh-CN');
