<?php
// M2-6 后台区域价接口：读取/整品覆盖保存/校验/Excel 导入导出
require __DIR__ . '/bootstrap.php';
require __DIR__ . '/Fixtures.php';

use think\facade\Db;
use app\services\product\RegionPriceServices;

$B = VnFx::base();
$at = VnFx::adminToken();
$HN = 910001; $BD = 911001; $HK = 911002; $TH = 910005;
VnFx::dropProduct(881201);
$Q = VnFx::product(881201, 'Admin-RP', [['suk' => 'a', 'price' => 60, 'stock' => 10], ['suk' => 'b', 'price' => 70, 'stock' => 10]]);
$qa = $Q['uniques']['a'];
$qb = $Q['uniques']['b'];
$rps = app()->make(RegionPriceServices::class);
$post = function ($path, $data) use ($B, $at) { return VnFx::http('POST', "$B/adminapi/$path", $at, $data); };
$get = function ($path) use ($B, $at) { return VnFx::http('GET', "$B/adminapi/$path", $at); };

// 未登录被拒
$r = VnFx::http('GET', "$B/adminapi/product/region_price/881201", '');
t_assert($r['status'] != 200, 'requires admin token');

// 读取空
$r = $get('product/region_price/881201');
t_assert($r['status'] == 200 && count($r['data']['skus']) === 2 && $r['data']['groups'] === [], 'read empty: ' . json_encode($r, JSON_UNESCAPED_UNICODE));

// 保存两个区域
$r = $post('product/region_price/881201', ['rows' => [
    ['unique' => $qa, 'city_id' => $HN, 'price' => '50', 'ot_price' => '60', 'stock' => 7],
    ['unique' => $qb, 'city_id' => $HN, 'price' => '65', 'stock' => ''],
    ['unique' => $qa, 'city_id' => $BD, 'price' => '48'],
], 'scope_city_ids' => [$HN, $BD]]);
t_assert($r['status'] == 200 && $r['data']['saved'] === 3 && $r['data']['deleted'] === 0, 'save 3 rows: ' . json_encode($r));
$r = $get('product/region_price/881201');
$byCity = array_column($r['data']['groups'], null, 'city_id');
t_assert(count($byCity) === 2 && count($byCity[$HN]['rows']) === 2 && $byCity[$HN]['city_name'] !== '', 'read groups by city with names');
t_assert($rps->resolveOne(881201, $qa, $BD)['price'] === '48.00' && $rps->resolveOne(881201, $qa, $HN)['stock'] === 7, 'prices effective immediately (cache flushed)');
t_assert($rps->resolveOne(881201, $qb, $BD)['price'] === '65.00', 'b at Ba Đình falls back to Hà Nội price');

// 覆盖：移除 Ba Đình 区域（scope 内未提交 => 删除），修改 Hà Nội 价
$r = $post('product/region_price/881201', ['rows' => [
    ['unique' => $qa, 'city_id' => $HN, 'price' => '55'],
    ['unique' => $qb, 'city_id' => $HN, 'price' => '65'],
], 'scope_city_ids' => [$HN, $BD]]);
t_assert($r['status'] == 200 && $r['data']['deleted'] === 1, 'rows in scope but not submitted are deleted: ' . json_encode($r));
t_assert($rps->resolveOne(881201, $qa, $BD)['price'] === '55.00', 'Ba Đình now inherits Hà Nội 55');
t_assert(Db::name('store_product_region_price')->where('product_id', 881201)->count() === 2, '2 rows remain');

// 校验
foreach ([
    ['bad price zero', ['unique' => $qa, 'city_id' => $HN, 'price' => '0']],
    ['bad price text', ['unique' => $qa, 'city_id' => $HN, 'price' => 'abc']],
    ['unknown unique', ['unique' => 'zzzzzzzz', 'city_id' => $HN, 'price' => '1']],
    ['unknown city', ['unique' => $qa, 'city_id' => 99999999, 'price' => '1']],
    ['negative stock', ['unique' => $qa, 'city_id' => $HN, 'price' => '1', 'stock' => -1]],
    ['negative ot', ['unique' => $qa, 'city_id' => $HN, 'price' => '1', 'ot_price' => -5]],
] as [$name, $row]) {
    $r = $post('product/region_price/881201', ['rows' => [$row]]);
    t_assert($r['status'] != 200, "validation: $name rejected");
}
t_assert(Db::name('store_product_region_price')->where('product_id', 881201)->count() === 2, 'invalid saves are atomic (no partial writes)');

// 全国价开关：系统总闸关闭时不可设置
$r = $post('product/region_price/881201', ['rows' => [], 'allow_national_price' => 1]);
t_assert($r['status'] != 200, 'cannot enable product national price while system switch is off');

// 导出 / 模板
$r = $get('product/region_price/export?product_id=881201');
t_assert($r['status'] == 200 && strpos($r['data']['url'], '.xlsx') !== false, 'export url');
$file = '/app/public/' . ltrim(parse_url($r['data']['url'], PHP_URL_PATH), '/');
t_assert(is_file($file), 'export file exists');
$r = $get('product/region_price/template');
t_assert($r['status'] == 200 && strpos($r['data']['url'], '.xlsx') !== false, 'template url');

// 导入
$xlsx = '/tmp/rp_import.xlsx';
$sheet = new \PhpOffice\PhpSpreadsheet\Spreadsheet();
$sheet->getActiveSheet()->fromArray([
    ['product_id', 'spec', 'unique', 'city_id', 'city_name', 'price', 'ot_price', 'stock'],
    [881201, 'a', $qa, $TH, 'Thanh Hóa', '45', '60', 5],
    [881201, 'b', $qb, $TH, 'Thanh Hóa', '52.5', '', ''],
    [881201, 'a', $qa, $HN, 'Hà Nội', '58', '', ''],          // 更新已有
    [881201, 'x', 'nouniqu', $TH, '', '10', '', ''],            // 规格不存在
    [881201, 'a', $qa, 12345678, '', '10', '', ''],             // 区域不存在
    [999999999, 'a', $qa, $TH, '', '10', '', ''],               // 商品不存在
    [881201, 'a', $qa, $HK, '', '0', '', ''],                   // 价格非法
], null, 'A1', true);
(new \PhpOffice\PhpSpreadsheet\Writer\Xlsx($sheet))->save($xlsx);
$ch = curl_init("$B/adminapi/product/region_price/import");
curl_setopt_array($ch, [CURLOPT_RETURNTRANSFER => true, CURLOPT_POST => true, CURLOPT_HTTPHEADER => ['Authori-zation: Bearer ' . $at],
    CURLOPT_POSTFIELDS => ['file' => new CURLFile($xlsx, 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', 'rp.xlsx')]]);
$res = json_decode(curl_exec($ch), true);
t_assert($res['status'] == 200 && $res['data']['ok'] === 3 && count($res['data']['fail']) === 4, 'import ok=3 fail=4: ' . json_encode($res, JSON_UNESCAPED_UNICODE));
$failRows = array_column($res['data']['fail'], 'row');
sort($failRows);
t_assert($failRows === [5, 6, 7, 8], 'failed row numbers: ' . json_encode($failRows));
t_assert($rps->resolveOne(881201, $qa, $TH)['price'] === '45.00' && $rps->resolveOne(881201, $qb, $TH)['price'] === '52.50', 'imported rows effective');
t_assert($rps->resolveOne(881201, $qa, $HN)['price'] === '58.00', 'import updates existing rows');
t_assert($rps->resolveOne(881201, $qa, $TH)['stock'] === 5, 'imported region stock');

VnFx::dropProduct(881201);
t_done();
