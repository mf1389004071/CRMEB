<?php
// M1 配送区域：服务层 + H5 接口 + 后台管理（含 Excel 导入）
require __DIR__ . '/bootstrap.php';
require __DIR__ . '/Fixtures.php';

use think\facade\Db;
use app\services\vn\RegionServices;

/** @var RegionServices $svc */
$svc = app()->make(RegionServices::class);
$B = VnFx::base();

// ---- 服务层：层级/祖先链 ----
$countries = $svc->children(0);
$codes = array_column($countries, 'country_code');
t_assert(in_array('VN', $codes, true) && !in_array('CN', $codes, true), 'country layer lists only open countries (VN open, CN not)');
$provinces = $svc->children(900002);
t_assert(count($provinces) >= 5 && $provinces[0]['name'] === 'Hà Nội' && $provinces[1]['name'] === 'TP. Hồ Chí Minh', 'VN provinces ordered by sort desc');
t_assert($provinces[0]['has_children'] === true, 'province has_children');
$districts = $svc->children(910001);
t_assert(array_column($districts, 'name') === ['Ba Đình', 'Hoàn Kiếm', 'Đống Đa', 'Cầu Giấy'], 'Hà Nội districts: ' . implode('|', array_column($districts, 'name')));
t_assert($districts[0]['has_children'] === false, 'district has_children=false for switcher (wards not switchable)');
$wardsSwitch = $svc->children(911001);
t_assert($wardsSwitch === [], 'switcher children of district excludes wards');
$wardsAddr = $svc->children(911001, false);
t_assert(count($wardsAddr) >= 1 && (int)$wardsAddr[0]['level'] === 2, 'address_children still returns wards');
t_assert($svc->chain(911001) === [911001, 910001, 900002], 'chain nearest->root: ' . json_encode($svc->chain(911001)));
t_assert($svc->chain(1) === [1, 900001], 'CN province chain gets country root prefix');
t_assert($svc->chain(99999999) === [], 'unknown node => empty chain');
t_assert($svc->isOpenId(911001) && !$svc->isOpenId(1) && !$svc->isOpenId(0), 'isOpenId');
t_assert($svc->level0Ancestor(912001) === 910001 && $svc->level0Ancestor(912002) === 910001, 'level0Ancestor wards => Hà Nội');
t_assert($svc->addressCompatibleWithRegion(912001, 912002) === true, 'sibling wards same city compatible');
t_assert($svc->addressCompatibleWithRegion(912001, 910002) === false, 'Hanoi ward vs HCMC incompatible');
t_assert($svc->addressCompatibleWithRegion(912001, 911001) === true, 'ward under district still addressInRegion');
// 归一演示/残留：仅保留河内、胡志明为热门，便于断言
Db::name('system_city')->where('is_hot', 1)->whereNotIn('city_id', [910001, 910002])->update(['is_hot' => 0]);
Db::name('system_city')->whereIn('city_id', [910001, 910002])->update(['is_hot' => 1, 'is_open' => 1]);
\app\services\vn\RegionServices::bumpVersion();
$hot = $svc->hot();
t_assert(array_column($hot, 'city_id') === [910001, 910002], 'hot cities: ' . json_encode(array_column($hot, 'city_id')));
foreach ($hot as $h) {
    t_assert((int)$h['level'] <= \app\services\vn\RegionServices::SWITCH_MAX_LEVEL, 'hot level <= switch max');
}

// ---- 定位 ----
$r = $svc->locate(21.03, 105.85);
t_assert($r['matched'] === true && $r['node']['city_id'] === 910001, 'locate near Hanoi => Hà Nội');
t_assert(array_column($r['chain'], 'city_id') === [900002, 910001], 'locate returns ancestors chain');
$r = $svc->locate(10.78, 106.70);
t_assert($r['matched'] && $r['node']['city_id'] === 910002, 'locate near HCMC');
$r = $svc->locate(35.68, 139.69);
t_assert($r['matched'] === false && $r['node'] === null, 'locate overseas (Tokyo) => matched=false');
$r = $svc->locate(21.9, 105.85);   // 河内以北约 100km，超过 60km
t_assert($r['matched'] === false, 'locate beyond locate_max_km => unmatched, dist=' . ($r['distance_km'] ?? ''));

// ---- 校验节点信息 ----
$i = $svc->info(912001);
t_assert($i['valid'] && array_column($i['chain'], 'city_id') === [900002, 910001, 911001, 912001], 'info chain root->self');
t_assert($svc->info(1)['valid'] === false, 'closed node info invalid');

// ---- HTTP（H5 公共接口）----
$r = VnFx::http('GET', "$B/api/region/children?parent_id=900002", '', [], ['Cb-lang: vi-VN']);
t_assert($r['status'] == 200 && count($r['data']) >= 5, 'http children');
$r = VnFx::http('GET', "$B/api/region/hot");
t_assert($r['status'] == 200 && count($r['data']) === 2, 'http hot');
$r = VnFx::http('POST', "$B/api/region/locate", '', ['lat' => 21.03, 'lng' => 105.85]);
t_assert($r['status'] == 200 && $r['data']['matched'] === true && $r['data']['node']['name'] === 'Hà Nội', 'http locate');
$r = VnFx::http('POST', "$B/api/region/locate", '', ['lat' => 'x', 'lng' => 1]);
t_assert($r['status'] != 200, 'http locate invalid params rejected');
// 伪造未开放 Cb-region 被中间件置 0；有效区域被识别
$r = VnFx::http('GET', "$B/api/region/info", '', [], ['Cb-region: 1']);
t_assert($r['status'] == 200 && $r['data']['valid'] === false, 'forged closed Cb-region ignored (regionId=0)');
$r = VnFx::http('GET', "$B/api/region/info", '', [], ['Cb-region: 911001']);
t_assert($r['data']['valid'] === true && $r['data']['node']['city_id'] === 911001, 'valid Cb-region resolved by middleware');
$r = VnFx::http('GET', "$B/api/region/address_children?parent_id=900002");
t_assert($r['status'] == 200, 'address_children ok');

// ---- 后台管理 ----
$at = VnFx::adminToken();
$r = VnFx::http('GET', "$B/adminapi/region/list?parent_id=0", $at);
t_assert($r['status'] == 200 && $r['data']['count'] >= 2, 'admin list countries');
$r = VnFx::http('POST', "$B/adminapi/region/open", $at, ['ids' => [910005], 'is_open' => 0]);
t_assert($r['status'] == 200 && !$svc->isOpenId(910005), 'admin close province (cache version bumped)');
$r = VnFx::http('POST', "$B/adminapi/region/open", $at, ['ids' => [910005], 'is_open' => 1, 'cascade' => 1]);
t_assert($r['status'] == 200 && $svc->isOpenId(910005) && $svc->isOpenId(911041), 'admin open with cascade reopens descendants');
$r = VnFx::http('POST', "$B/adminapi/region/hot", $at, ['ids' => [910003], 'is_hot' => 1]);
t_assert($r['status'] == 200 && count($svc->hot()) === 3, 'admin set hot');
VnFx::http('POST', "$B/adminapi/region/hot", $at, ['ids' => [910003], 'is_hot' => 0]);
$r = VnFx::http('POST', "$B/adminapi/region/save", $at, ['parent_id' => 910003, 'name' => 'Ngũ Hành Sơn', 'lng' => '108.26', 'lat' => '16.00']);
$newId = $r['data']['city_id'] ?? 0;
t_assert($r['status'] == 200 && $newId >= 910000, 'admin add child node');
$row = Db::name('system_city')->where('city_id', $newId)->find();
t_assert($row['level'] == 1 && $row['country_code'] === 'VN' && $row['path'] === ',900002,910003,' . $newId . ',' && $row['merger_name'] === 'Đà Nẵng,Ngũ Hành Sơn', 'added node has level/path/merger_name');

// ---- Excel 导入 ----
$xlsx = '/tmp/region_import.xlsx';
$sheet = new \PhpOffice\PhpSpreadsheet\Spreadsheet();
$ws = $sheet->getActiveSheet();
$ws->fromArray([
    ['city_id', 'parent_city_id', 'level', 'name', 'area_code', 'lng', 'lat', 'country_code'],
    [913001, 900002, 0, 'Cần Thơ', '', '105.7469', '10.0452', 'VN'],
    [913002, 913001, 1, 'Ninh Kiều', '', '105.7870', '10.0340', 'VN'],
    ['', 913002, 2, 'Xuân Khánh', '', '105.7700', '10.0250', 'VN'],     // 自动分配 city_id
    [913004, 777777, 1, 'Orphan', '', '', '', 'VN'],                     // 上级不存在 => 失败
    [913005, 913001, 1, '', '', '', '', 'VN'],                           // 名称为空 => 失败
    [913006, 913001, 1, 'BadLng', '', '999', '10', 'VN'],                // 经度非法 => 失败
], null, 'A1', true);   // strictNullComparison：否则 0 会被当作空值丢弃
(new \PhpOffice\PhpSpreadsheet\Writer\Xlsx($sheet))->save($xlsx);
$ch = curl_init("$B/adminapi/region/import");
curl_setopt_array($ch, [CURLOPT_RETURNTRANSFER => true, CURLOPT_POST => true, CURLOPT_HTTPHEADER => ['Authori-zation: Bearer ' . $at],
    CURLOPT_POSTFIELDS => ['file' => new CURLFile($xlsx, 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', 'region.xlsx')]]);
$res = json_decode(curl_exec($ch), true);
t_assert($res['status'] == 200 && $res['data']['ok'] === 3 && count($res['data']['fail']) === 3, 'import ok=3 fail=3: ' . json_encode($res, JSON_UNESCAPED_UNICODE));
$failRows = array_column($res['data']['fail'], 'row');
sort($failRows);
t_assert($failRows === [5, 6, 7], 'failure rows reported with line numbers: ' . json_encode($failRows));
$can = Db::name('system_city')->where('city_id', 913001)->find();
t_assert($can && $can['path'] === ',900002,913001,' && $can['is_open'] == 0, 'imported province: path built, not open by default');
$ward = Db::name('system_city')->where(['name' => 'Xuân Khánh'])->find();
t_assert($ward && $ward['level'] == 2 && $ward['path'] === ',900002,913001,913002,' . $ward['city_id'] . ',' && $ward['merger_name'] === 'Cần Thơ,Ninh Kiều,Xuân Khánh', 'auto-id ward path & merger_name');
$r = VnFx::http('POST', "$B/adminapi/region/rebuild_path", $at);
t_assert($r['status'] == 200, 'admin rebuild path');
t_assert(Db::name('system_city')->where('path', '')->count() === 0, 'no node without path after rebuild');

// 清理新增数据
Db::name('system_city')->whereIn('city_id', [913001, 913002, 913004, 913005, 913006, $newId, (int)($ward['city_id'] ?? 0)])->delete();
RegionServices::bumpVersion();
t_done();
