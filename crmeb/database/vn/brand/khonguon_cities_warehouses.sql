-- Kho Nguon：15 城开放 + 缺仓补默认仓（幂等）
-- 保留现有 WHINIT:*；清化写入真实地址；其余缺仓地址「待补充」
SET NAMES utf8mb4;

-- 1) 补齐缺失省级区划（920010+，避开已有 920002/920003）
DROP TEMPORARY TABLE IF EXISTS tmp_kn_city;
CREATE TEMPORARY TABLE tmp_kn_city (
  city_id int, name varchar(100), merger varchar(255), lng varchar(50), lat varchar(50), is_hot tinyint, sort int
);
INSERT INTO tmp_kn_city VALUES
(910001, 'Hà Nội',          'Hà Nội',          '105.8542', '21.0285', 1, 100),
(910002, 'TP. Hồ Chí Minh', 'TP. Hồ Chí Minh', '106.6297', '10.8231', 1,  99),
(910003, 'Đà Nẵng',         'Đà Nẵng',         '108.2022', '16.0544', 0,  90),
(910004, 'Hải Phòng',       'Hải Phòng',       '106.6881', '20.8449', 0,  85),
(910005, 'Thanh Hóa',       'Thanh Hóa',       '105.7852', '19.8067', 0,  80),
(920002, 'Bắc Ninh',        'Bắc Ninh',        '106.0763', '21.1861', 0,  75),
(920003, 'Thừa Thiên Huế',  'Thừa Thiên Huế',  '107.5909', '16.4637', 0,  70),
(920010, 'Hải Dương',       'Hải Dương',       '106.3310', '20.9373', 0,  65),
(920011, 'Vinh',            'Vinh',            '105.6923', '18.6796', 0,  60),
(920012, 'Đồng Hới',        'Đồng Hới',        '106.6225', '17.4689', 0,  55),
(920013, 'Quy Nhơn',        'Quy Nhơn',        '109.2237', '13.7820', 0,  50),
(920014, 'Tuy Hòa',         'Tuy Hòa',         '109.3090', '13.0955', 0,  45),
(920015, 'Nha Trang',       'Nha Trang',       '109.1967', '12.2388', 0,  40),
(920016, 'Đà Lạt',          'Đà Lạt',          '108.4419', '11.9404', 0,  35),
(920017, 'Cần Thơ',         'Cần Thơ',         '105.7469', '10.0452', 0,  30);

INSERT INTO eb_system_city (city_id, level, parent_id, area_code, name, merger_name, lng, lat, is_show, country_code, path, is_open, is_hot, sort)
SELECT t.city_id, 0, 900002, '', t.name, t.merger, t.lng, t.lat, 1, 'VN',
       CONCAT(',900002,', t.city_id, ','), 1, t.is_hot, t.sort
FROM tmp_kn_city t
WHERE NOT EXISTS (SELECT 1 FROM eb_system_city c WHERE c.city_id = t.city_id);

UPDATE eb_system_city c
JOIN tmp_kn_city t ON t.city_id = c.city_id
SET c.is_open = 1,
    c.is_show = 1,
    c.is_hot = t.is_hot,
    c.sort = t.sort,
    c.name = t.name,
    c.merger_name = t.merger,
    c.path = CONCAT(',900002,', t.city_id, ','),
    c.country_code = 'VN',
    c.level = 0,
    c.parent_id = 900002;

-- 2) 清化仓：有则改地址，无则建
INSERT INTO eb_vn_warehouse
  (code, name, address, detailed_address, introduction, phone, lng, lat, is_enable, effective_start, effective_end,
   pickup_slots, auto_match, exact_match_only, sort, is_del, add_time, update_time)
SELECT 'WHINIT:KHO-THANH-HOA', 'Kho Thanh Hóa',
       '136 nguyễn duy hiệu,p.hạc thành-thanh hoá',
       '136 nguyễn duy hiệu,p.hạc thành-thanh hoá',
       '', '+84 988 619 355', '', '', 1, 0, 0, '[]', 1, 0, 80, 0, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM eb_vn_warehouse WHERE code='WHINIT:KHO-THANH-HOA' AND is_del=0);

UPDATE eb_vn_warehouse
SET name='Kho Thanh Hóa',
    address='136 nguyễn duy hiệu,p.hạc thành-thanh hoá',
    detailed_address='136 nguyễn duy hiệu,p.hạc thành-thanh hoá',
    phone='+84 988 619 355',
    is_enable=1, auto_match=1, is_del=0, update_time=UNIX_TIMESTAMP()
WHERE code='WHINIT:KHO-THANH-HOA';

INSERT INTO eb_vn_warehouse_region (warehouse_id, city_id, sort, is_default, add_time)
SELECT w.id, 910005, 0, 1, UNIX_TIMESTAMP()
FROM eb_vn_warehouse w
WHERE w.code='WHINIT:KHO-THANH-HOA' AND w.is_del=0
  AND NOT EXISTS (
    SELECT 1 FROM eb_vn_warehouse_region wr WHERE wr.warehouse_id=w.id AND wr.city_id=910005
  );

-- 3) 其余缺仓城：一城一默认仓（地址待补充）
DROP TEMPORARY TABLE IF EXISTS tmp_kn_wh;
CREATE TEMPORARY TABLE tmp_kn_wh (
  city_id int, code varchar(32), name varchar(100), address varchar(255), sort int
);
INSERT INTO tmp_kn_wh VALUES
(910003, 'WHINIT:KHO-DA-NANG',   'Kho Đà Nẵng',   '待补充', 90),
(910004, 'WHINIT:KHO-HAI-PHONG', 'Kho Hải Phòng', '待补充', 85),
(920010, 'WHINIT:KHO-HAI-DUONG', 'Kho Hải Dương', '待补充', 65),
(920011, 'WHINIT:KHO-VINH',      'Kho Vinh',      '待补充', 60),
(920012, 'WHINIT:KHO-DONG-HOI',  'Kho Đồng Hới',  '待补充', 55),
(920013, 'WHINIT:KHO-QUY-NHON',  'Kho Quy Nhơn',  '待补充', 50),
(920014, 'WHINIT:KHO-TUY-HOA',   'Kho Tuy Hòa',   '待补充', 45),
(920015, 'WHINIT:KHO-NHA-TRANG', 'Kho Nha Trang', '待补充', 40),
(920016, 'WHINIT:KHO-DA-LAT',    'Kho Đà Lạt',    '待补充', 35),
(920017, 'WHINIT:KHO-CAN-THO',   'Kho Cần Thơ',   '待补充', 30);

INSERT INTO eb_vn_warehouse
  (code, name, address, detailed_address, introduction, phone, lng, lat, is_enable, effective_start, effective_end,
   pickup_slots, auto_match, exact_match_only, sort, is_del, add_time, update_time)
SELECT t.code, t.name, t.address, t.address, '', '', '', '', 1, 0, 0, '[]', 1, 0, t.sort, 0, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
FROM tmp_kn_wh t
WHERE NOT EXISTS (SELECT 1 FROM eb_vn_warehouse w WHERE w.code=t.code AND w.is_del=0);

INSERT INTO eb_vn_warehouse_region (warehouse_id, city_id, sort, is_default, add_time)
SELECT w.id, t.city_id, 0, 1, UNIX_TIMESTAMP()
FROM tmp_kn_wh t
JOIN eb_vn_warehouse w ON w.code=t.code AND w.is_del=0
WHERE NOT EXISTS (
  SELECT 1 FROM eb_vn_warehouse_region wr WHERE wr.warehouse_id=w.id AND wr.city_id=t.city_id
);

-- 现有 WHINIT 仓保持不动；若关联缺失则补默认关联
INSERT INTO eb_vn_warehouse_region (warehouse_id, city_id, sort, is_default, add_time)
SELECT w.id, x.city_id, 0, 1, UNIX_TIMESTAMP()
FROM (
  SELECT 'WHINIT:KHO-HA-NOI' AS code, 910001 AS city_id UNION ALL
  SELECT 'WHINIT:KHO-TP-HCM', 910002 UNION ALL
  SELECT 'WHINIT:KHO-BAC-NINH', 920002 UNION ALL
  SELECT 'WHINIT:KHO-HUE', 920003
) x
JOIN eb_vn_warehouse w ON w.code=x.code AND w.is_del=0
WHERE NOT EXISTS (
  SELECT 1 FROM eb_vn_warehouse_region wr WHERE wr.warehouse_id=w.id AND wr.city_id=x.city_id
);

DROP TEMPORARY TABLE IF EXISTS tmp_kn_city;
DROP TEMPORARY TABLE IF EXISTS tmp_kn_wh;
