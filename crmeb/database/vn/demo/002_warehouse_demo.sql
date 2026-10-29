-- 提货仓库多场景演示数据（依赖 021 区划种子 + 031/032 迁移）。幂等可重复执行。
-- 场景说明：
--   WH-HN-MAIN   河内主仓，挂 910001，默认，参与模糊匹配
--   WH-HN-SUB    河内副仓，同城可改选
--   WH-HN-WARD   仅 Phúc Xá(912001) 精确匹配
--   WH-HCM       胡志明默认仓
--   WH-DN        岘港默认仓
--   WH-HP-MANUAL 海防仓但不参与自动匹配（auto_match=0）
-- 回滚：DELETE FROM eb_vn_warehouse_region WHERE warehouse_id IN (SELECT id FROM eb_vn_warehouse WHERE code LIKE 'WH-%');
--       DELETE FROM eb_vn_warehouse WHERE code LIKE 'WH-%';
--       DELETE FROM eb_i18n_content WHERE entity_type='warehouse' AND field='name' AND lang='zh-CN';
SET NAMES utf8mb4;
SET @now := UNIX_TIMESTAMP();

-- 清旧演示仓（按 code）
DELETE r FROM eb_vn_warehouse_region r
INNER JOIN eb_vn_warehouse w ON w.id = r.warehouse_id
WHERE w.code IN ('WH-HN-MAIN','WH-HN-SUB','WH-HN-WARD','WH-HCM','WH-DN','WH-HP-MANUAL');
DELETE FROM eb_i18n_content WHERE entity_type='warehouse' AND field IN ('name','address','introduction') AND lang='zh-CN'
  AND entity_id IN (SELECT id FROM (SELECT id FROM eb_vn_warehouse WHERE code IN ('WH-HN-MAIN','WH-HN-SUB','WH-HN-WARD','WH-HCM','WH-DN','WH-HP-MANUAL')) t);
DELETE FROM eb_vn_warehouse WHERE code IN ('WH-HN-MAIN','WH-HN-SUB','WH-HN-WARD','WH-HCM','WH-DN','WH-HP-MANUAL');

INSERT INTO eb_vn_warehouse (code, name, address, detailed_address, introduction, phone, lng, lat, is_enable, effective_start, effective_end, pickup_slots, auto_match, exact_match_only, sort, is_del, add_time, update_time) VALUES
('WH-HN-MAIN', 'Kho Hà Nội chính', 'Quận Ba Đình, Hà Nội', 'Số 12 phố Liễu Giai', 'Kho mặc định Hà Nội, hỗ trợ fuzzy match cấp quận/phường', '024-1234567', '105.8142', '21.0340', 1, 0, 0,
 '[{"weekday":1,"start":"08:00","end":"17:00"},{"weekday":2,"start":"08:00","end":"17:00"},{"weekday":3,"start":"08:00","end":"17:00"},{"weekday":4,"start":"08:00","end":"17:00"},{"weekday":5,"start":"08:00","end":"17:00"},{"weekday":6,"start":"08:00","end":"12:00"}]',
 1, 0, 100, 0, @now, @now),
('WH-HN-SUB', 'Kho Hà Nội phụ', 'Quận Cầu Giấy, Hà Nội', 'Tòa nhà Keangnam', 'Cùng thành phố có thể đổi kho', '024-7654321', '105.7937', '21.0333', 1, 0, 0, '', 1, 0, 80, 0, @now, @now),
('WH-HN-WARD', 'Kho Phúc Xá (exact)', 'Phúc Xá, Ba Đình', 'Cổng A', 'Chỉ khớp chính xác phường Phúc Xá', '024-1111222', '105.8470', '21.0480', 1, 0, 0, '', 1, 1, 90, 0, @now, @now),
('WH-HCM', 'Kho TP.HCM', 'Quận 1, TP.HCM', 'Đường Nguyễn Huệ', 'Kho mặc định Hồ Chí Minh', '028-8888999', '106.7004', '10.7757', 1, 0, 0, '', 1, 0, 100, 0, @now, @now),
('WH-DN', 'Kho Đà Nẵng', 'Hải Châu, Đà Nẵng', 'Đường Bạch Đằng', 'Kho mặc định Đà Nẵng', '0236-3333444', '108.2208', '16.0471', 1, 0, 0, '', 1, 0, 90, 0, @now, @now),
('WH-HP-MANUAL', 'Kho Hải Phòng (manual)', 'Hồng Bàng, Hải Phòng', 'Cảng HP', 'Không tham gia auto match', '0225-5555666', '106.6590', '20.8610', 1, 0, 0, '', 0, 0, 70, 0, @now, @now);

SET @hn_main := (SELECT id FROM eb_vn_warehouse WHERE code='WH-HN-MAIN' LIMIT 1);
SET @hn_sub  := (SELECT id FROM eb_vn_warehouse WHERE code='WH-HN-SUB' LIMIT 1);
SET @hn_ward := (SELECT id FROM eb_vn_warehouse WHERE code='WH-HN-WARD' LIMIT 1);
SET @hcm     := (SELECT id FROM eb_vn_warehouse WHERE code='WH-HCM' LIMIT 1);
SET @dn      := (SELECT id FROM eb_vn_warehouse WHERE code='WH-DN' LIMIT 1);
SET @hp      := (SELECT id FROM eb_vn_warehouse WHERE code='WH-HP-MANUAL' LIMIT 1);

INSERT INTO eb_vn_warehouse_region (warehouse_id, city_id, sort, is_default, add_time) VALUES
(@hn_main, 910001, 100, 1, @now),
(@hn_sub,  910001,  80, 0, @now),
(@hn_ward, 912001, 100, 1, @now),
(@hcm,     910002, 100, 1, @now),
(@dn,      910003, 100, 1, @now),
(@hp,      910004, 100, 1, @now);

-- 中文译文（entity_id=仓id）
INSERT INTO eb_i18n_content (entity_type, entity_id, field, lang, value, status, add_time, update_time)
SELECT 'warehouse', id, 'name', 'zh-CN',
  CASE code
    WHEN 'WH-HN-MAIN' THEN '河内主仓'
    WHEN 'WH-HN-SUB' THEN '河内副仓'
    WHEN 'WH-HN-WARD' THEN '福舍精确仓'
    WHEN 'WH-HCM' THEN '胡志明仓'
    WHEN 'WH-DN' THEN '岘港仓'
    WHEN 'WH-HP-MANUAL' THEN '海防手工仓'
  END, 1, @now, @now
FROM eb_vn_warehouse WHERE code IN ('WH-HN-MAIN','WH-HN-SUB','WH-HN-WARD','WH-HCM','WH-DN','WH-HP-MANUAL');

INSERT INTO eb_i18n_content (entity_type, entity_id, field, lang, value, status, add_time, update_time)
SELECT 'warehouse', id, 'address', 'zh-CN',
  CASE code
    WHEN 'WH-HN-MAIN' THEN '河内巴亭区'
    WHEN 'WH-HN-SUB' THEN '河内纸桥区'
    WHEN 'WH-HN-WARD' THEN '巴亭福舍坊'
    WHEN 'WH-HCM' THEN '胡志明第一郡'
    WHEN 'WH-DN' THEN '岘港海洲'
    WHEN 'WH-HP-MANUAL' THEN '海防红傍'
  END, 1, @now, @now
FROM eb_vn_warehouse WHERE code IN ('WH-HN-MAIN','WH-HN-SUB','WH-HN-WARD','WH-HCM','WH-DN','WH-HP-MANUAL');
