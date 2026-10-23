-- M1 示例区划数据（越南，演示/联调用）：5 个省/直辖市、若干郡/县、少量坊/社。幂等。
-- 正式上线请用后台“区划导入”导入完整行政区划（官方/开源数据），本文件仅供开发测试。
-- 回滚：DELETE FROM eb_system_city WHERE country_code='VN' AND level >= 0;
SET NAMES utf8mb4;

DROP TEMPORARY TABLE IF EXISTS tmp_vn_city;
CREATE TEMPORARY TABLE tmp_vn_city (city_id int, level int, parent_id int, name varchar(100), merger varchar(255), lng varchar(50), lat varchar(50), is_hot tinyint, sort int, path varchar(255));
INSERT INTO tmp_vn_city VALUES
-- 省/直辖市（level 0，parent=VN 根 900002）
(910001, 0, 900002, 'Hà Nội',          'Hà Nội',          '105.8542', '21.0285', 1, 100, ',900002,910001,'),
(910002, 0, 900002, 'TP. Hồ Chí Minh', 'TP. Hồ Chí Minh', '106.6297', '10.8231', 1,  99, ',900002,910002,'),
(910003, 0, 900002, 'Đà Nẵng',         'Đà Nẵng',         '108.2022', '16.0544', 0,  80, ',900002,910003,'),
(910004, 0, 900002, 'Hải Phòng',       'Hải Phòng',       '106.6881', '20.8449', 0,  70, ',900002,910004,'),
(910005, 0, 900002, 'Thanh Hóa',       'Thanh Hóa',       '105.7852', '19.8067', 0,  60, ',900002,910005,'),
-- 郡/县（level 1）
(911001, 1, 910001, 'Ba Đình',     'Hà Nội,Ba Đình',     '105.8142', '21.0340', 0, 10, ',900002,910001,911001,'),
(911002, 1, 910001, 'Hoàn Kiếm',   'Hà Nội,Hoàn Kiếm',   '105.8522', '21.0285', 0,  9, ',900002,910001,911002,'),
(911003, 1, 910001, 'Đống Đa',     'Hà Nội,Đống Đa',     '105.8290', '21.0180', 0,  8, ',900002,910001,911003,'),
(911004, 1, 910001, 'Cầu Giấy',    'Hà Nội,Cầu Giấy',    '105.7937', '21.0333', 0,  7, ',900002,910001,911004,'),
(911011, 1, 910002, 'Quận 1',      'TP. Hồ Chí Minh,Quận 1',  '106.7004', '10.7757', 0, 10, ',900002,910002,911011,'),
(911012, 1, 910002, 'Quận 3',      'TP. Hồ Chí Minh,Quận 3',  '106.6869', '10.7835', 0,  9, ',900002,910002,911012,'),
(911013, 1, 910002, 'Bình Thạnh',  'TP. Hồ Chí Minh,Bình Thạnh', '106.7091', '10.8106', 0, 8, ',900002,910002,911013,'),
(911021, 1, 910003, 'Hải Châu',    'Đà Nẵng,Hải Châu',   '108.2208', '16.0471', 0, 10, ',900002,910003,911021,'),
(911022, 1, 910003, 'Sơn Trà',     'Đà Nẵng,Sơn Trà',    '108.2480', '16.0970', 0,  9, ',900002,910003,911022,'),
(911031, 1, 910004, 'Hồng Bàng',   'Hải Phòng,Hồng Bàng', '106.6590', '20.8610', 0, 10, ',900002,910004,911031,'),
(911041, 1, 910005, 'TP. Thanh Hóa', 'Thanh Hóa,TP. Thanh Hóa', '105.7761', '19.8070', 0, 10, ',900002,910005,911041,'),
(911042, 1, 910005, 'Sầm Sơn',     'Thanh Hóa,Sầm Sơn',  '105.9000', '19.7390', 0,  9, ',900002,910005,911042,'),
-- 坊/社（level 2）
(912001, 2, 911001, 'Phúc Xá',     'Hà Nội,Ba Đình,Phúc Xá',   '105.8470', '21.0480', 0, 3, ',900002,910001,911001,912001,'),
(912002, 2, 911001, 'Trúc Bạch',   'Hà Nội,Ba Đình,Trúc Bạch', '105.8420', '21.0440', 0, 2, ',900002,910001,911001,912002,'),
(912003, 2, 911001, 'Vĩnh Phúc',   'Hà Nội,Ba Đình,Vĩnh Phúc', '105.8120', '21.0400', 0, 1, ',900002,910001,911001,912003,'),
(912011, 2, 911011, 'Bến Nghé',    'TP. Hồ Chí Minh,Quận 1,Bến Nghé', '106.7050', '10.7820', 0, 2, ',900002,910002,911011,912011,'),
(912012, 2, 911011, 'Bến Thành',   'TP. Hồ Chí Minh,Quận 1,Bến Thành', '106.6980', '10.7720', 0, 1, ',900002,910002,911011,912012,');

INSERT INTO eb_system_city (city_id, level, parent_id, area_code, name, merger_name, lng, lat, is_show, country_code, path, is_open, is_hot, sort)
SELECT t.city_id, t.level, t.parent_id, '', t.name, t.merger, t.lng, t.lat, 1, 'VN', t.path, 1, t.is_hot, t.sort
FROM tmp_vn_city t
WHERE NOT EXISTS (SELECT 1 FROM eb_system_city c WHERE c.city_id = t.city_id);

DROP TEMPORARY TABLE IF EXISTS tmp_vn_city;
