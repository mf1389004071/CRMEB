<?php
// M4-1/2/3 配送单数据、拣货汇总、导出（服务层 + HTTP）
require __DIR__ . '/bootstrap.php';
require __DIR__ . '/Fixtures.php';

use think\facade\Db;
use app\services\order\CodPrintServices;

$B = VnFx::base();
$uid = VnFx::user();
$at = VnFx::adminToken();
$pA = VnFx::product(880201, 'Cải xanh', [['suk' => '500g', 'price' => 30000, 'stock' => 50]], ['unit_name' => 'Kg']);
$pB = VnFx::product(880202, 'Thịt bò', [['suk' => '1kg', 'price' => 250000, 'stock' => 50]], ['unit_name' => 'Kg']);

function mkO($uid, array $lines, array $extra = [])
{
    static $n = 0;
    $n++;
    $orderId = 'cod_p_' . time() . '_' . $n;
    $cartIds = [];
    $total = 0;
    foreach ($lines as $l) {
        $total += $l['price'] * $l['num'];
    }
    $oid = Db::name('store_order')->insertGetId(array_merge([
        'order_id' => $orderId, 'uid' => $uid, 'real_name' => 'Lê Thị Hoa', 'user_phone' => '0912345678', 'user_address' => 'Hà Nội Ba Đình số 1',
        'cart_id' => '[]', 'total_num' => 1, 'total_price' => $total, 'pay_price' => $total, 'paid' => 0, 'pay_type' => 'offline', 'add_time' => time(),
        'status' => 0, 'unique' => md5($orderId), 'mark' => 'Giao buổi sáng', 'is_cod' => 1, 'fulfil_status' => 1, 'cod_receivable' => $total,
        'cod_delivery_code' => '654321', 'need_call_confirm' => 1,
    ], $extra));
    foreach ($lines as $i => $l) {
        Db::name('store_order_cart_info')->insert([
            'oid' => $oid, 'uid' => $uid, 'cart_id' => 940000 + $n * 10 + $i, 'product_id' => $l['pid'], 'cart_num' => $l['num'], 'surplus_num' => $l['num'],
            'cart_info' => json_encode(['cart_num' => $l['num'], 'truePrice' => $l['price'], 'productInfo' => ['id' => $l['pid'], 'store_name' => $l['name'], 'unit_name' => 'Kg',
                'attrInfo' => ['unique' => $l['unique'], 'suk' => $l['suk'], 'price' => $l['price']]]]),
            'unique' => md5($orderId . $i),
        ]);
    }
    return $oid;
}

$o1 = mkO($uid, [['pid' => 880201, 'name' => 'Cải xanh', 'suk' => '500g', 'unique' => $pA['uniques']['500g'], 'price' => 30000, 'num' => 2], ['pid' => 880202, 'name' => 'Thịt bò', 'suk' => '1kg', 'unique' => $pB['uniques']['1kg'], 'price' => 250000, 'num' => 1]]);
$o2 = mkO($uid, [['pid' => 880201, 'name' => 'Cải xanh', 'suk' => '500g', 'unique' => $pA['uniques']['500g'], 'price' => 30000, 'num' => 3]]);
$o3 = mkO($uid, [['pid' => 880201, 'name' => 'Cải xanh', 'suk' => '500g', 'unique' => $pA['uniques']['500g'], 'price' => 30000, 'num' => 1]]);
$ids = [$o1, $o2, $o3];

/** @var CodPrintServices $print */
$print = app()->make(CodPrintServices::class);

// 服务层：配送单
$data = $print->printData($ids, 'vi-VN');
t_assert(count($data) === 3, '3 orders');
t_assert($data[0]['goods'][0]['name'] === 'Cải xanh' && $data[0]['goods'][0]['subtotal'] === '60000.00' && $data[0]['goods_total'] === '310000.00', 'goods & totals: ' . json_encode($data[0]['goods_total']));
t_assert(json_encode($data, JSON_UNESCAPED_UNICODE) !== false && strpos(json_encode($data), '654321') === false && strpos(json_encode($data), 'cod_delivery_code') === false, 'print data never contains delivery code');
t_assert($data[0]['need_call_confirm'] === 1 && $data[0]['mark'] === 'Giao buổi sáng', 'mark & call-confirm carried');
t_assert($data[0]['goods'][0]['name_zh'] === '', 'name_zh empty unless both');
$both = $print->printData([$o1], 'both');
t_assert($both[0]['lang'] === 'both' && array_key_exists('name_zh', $both[0]['goods'][0]), 'both language carries zh name key');
t_assert($print->printData([$o1], 'xx-XX')[0]['lang'] === 'vi-VN', 'unknown lang falls back to vi-VN');

// 拣货汇总：数量 = 各单相应商品数量之和
$pick = $print->pickSummary($ids, 'vi-VN');
$byPid = array_column($pick, null, 'product_id');
t_assert($byPid[880201]['total_num'] === 6 && $byPid[880201]['order_count'] === 3, 'pick sum cabbage=2+3+1=6 across 3 orders');
t_assert($byPid[880202]['total_num'] === 1 && $byPid[880202]['order_count'] === 1, 'pick sum beef=1');

// 范围解析：ids 上限 / date
$threw = false;
try {
    $print->resolveOrderIds(['ids' => implode(',', range(1, 101))]);
} catch (\Throwable $e) {
    $threw = true;
}
t_assert($threw, 'more than 100 ids rejected');
$byDate = $print->resolveOrderIds(['date' => date('Y-m-d')]);
t_assert(count(array_intersect($byDate, $ids)) === 3, 'resolve by date includes today cod orders');

// HTTP
$r = VnFx::http('GET', "$B/adminapi/order/cod/print_data?ids=" . implode(',', $ids) . '&lang=both', $at);
t_assert($r['status'] == 200 && count($r['data']) === 3 && $r['data'][0]['lang'] === 'both', 'http print_data: ' . substr(json_encode($r, JSON_UNESCAPED_UNICODE), 0, 200));
t_assert(Db::name('store_order_status')->where(['oid' => $o1, 'change_type' => 'cod_print'])->count() == 1, 'print audited');
$r = VnFx::http('GET', "$B/adminapi/order/cod/pick_summary?ids=" . implode(',', $ids), $at);
t_assert($r['status'] == 200 && $r['data']['order_count'] === 3 && count($r['data']['list']) === 2, 'http pick_summary');
$r = VnFx::http('GET', "$B/adminapi/order/cod/export?type=pick&ids=" . implode(',', $ids), $at);
t_assert($r['status'] == 200 && !empty($r['data']['url']) && strpos($r['data']['url'], '.xlsx') !== false, 'http export pick: ' . json_encode($r, JSON_UNESCAPED_UNICODE));
$url = $r['data']['url'] ?? '';
$file = '/app/public/' . ltrim(parse_url($url, PHP_URL_PATH), '/');
t_assert(is_file($file) && filesize($file) > 1000, 'exported xlsx exists: ' . $file);
$r = VnFx::http('GET', "$B/adminapi/order/cod/export?type=orders&ids=" . implode(',', $ids), $at);
t_assert($r['status'] == 200 && !empty($r['data']['url']), 'http export orders');
if (class_exists('ZipArchive') && is_file($file)) {
    $zip = new ZipArchive();
    $zip->open($file);
    $sheet = $zip->getFromName('xl/sharedStrings.xml') ?: '';
    t_assert(strpos($sheet, 'Cải xanh') !== false, 'xlsx contains Vietnamese diacritics');
}

foreach ($ids as $id) {
    VnFx::dropOrder($id);
}
VnFx::dropProduct(880201);
VnFx::dropProduct(880202);
t_done();
