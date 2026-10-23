<?php
// M3-4 钩子测试：tidyOrder 到付文案/送达码可见性、cancelOrder 守卫
require __DIR__ . '/bootstrap.php';

use think\facade\Db;
use app\services\order\CodOrderServices;
use app\services\order\StoreOrderServices;

/** @var CodOrderServices $cod */
$cod = app()->make(CodOrderServices::class);
/** @var StoreOrderServices $orderServices */
$orderServices = app()->make(StoreOrderServices::class);
$admin = ['id' => 1, 'type' => 'admin', 'name' => 'tester'];

$pid = 880002;
$uniq = 'tst88002';
Db::name('store_product')->where('id', $pid)->delete();
Db::name('store_product_attr_value')->where('product_id', $pid)->delete();
Db::name('store_product')->insert(['id' => $pid, 'store_name' => 'cod-hook', 'price' => 100, 'stock' => 8, 'sales' => 2, 'is_show' => 1, 'is_del' => 0, 'add_time' => time()]);
Db::name('store_product_attr_value')->insert(['product_id' => $pid, 'suk' => 'default', 'stock' => 8, 'sales' => 2, 'price' => 100, 'unique' => $uniq, 'type' => 0]);

function mk($pid, $uniq, array $extra = [])
{
    static $n = 0;
    $n++;
    $orderId = 'cod_h_' . time() . '_' . $n;
    $cartId = 960000 + $n;
    $oid = Db::name('store_order')->insertGetId(array_merge([
        'order_id' => $orderId, 'uid' => 7, 'real_name' => 'A', 'user_phone' => '0912345678', 'user_address' => 'HN',
        'cart_id' => json_encode([$cartId]), 'total_num' => 1, 'total_price' => 100, 'pay_price' => 100, 'paid' => 0, 'pay_type' => 'offline',
        'add_time' => time(), 'status' => 0, 'unique' => md5($orderId), 'mark' => '',
    ], $extra));
    Db::name('store_order_cart_info')->insert([
        'oid' => $oid, 'uid' => 7, 'cart_id' => $cartId, 'product_id' => $pid, 'cart_num' => 1, 'surplus_num' => 1,
        'cart_info' => json_encode(['cart_num' => 1, 'productInfo' => ['id' => $pid, 'attrInfo' => ['unique' => $uniq]]]),
        'unique' => md5($orderId . 'c'),
    ]);
    return $oid;
}

$ids = [];
// ---- tidyOrder 文案（列表：不返回送达码）----
$a = mk($pid, $uniq);
$ids[] = $a;
$cod->onCreated(['id' => $a]);
$row = Db::name('store_order')->where('id', $a)->find();
$out = $orderServices->tidyOrder($row, false);
t_assert($out['_status']['_title'] === '备货中' && $out['_status']['_type'] === 1, 'stockup status text, got ' . json_encode($out['_status'], JSON_UNESCAPED_UNICODE));
t_assert(strpos($out['_status']['_msg'], '请在') === false, 'no "pay before" message for cod');
t_assert($out['fulfil_key'] === 'cod_stockup' && $out['can_cancel'] === false, 'fulfil_key & can_cancel');
t_assert(!array_key_exists('cod_delivery_code', $out) && $out['cod_code'] === '', 'list never exposes delivery code');

// ---- 订单所有者详情可见送达码 ----
$request = app()->request;
$request->macro('uid', function () { return 7; });
$outDetail = $cod->tidyOrderFields($row, true);
t_assert(preg_match('/^[0-9]{6}$/', $outDetail['cod_code']) === 1, 'owner detail exposes cod_code');
$request->macro('uid', function () { return 8; });
t_assert($cod->tidyOrderFields($row, true)['cod_code'] === '', 'non-owner does not see code');
$request->macro('uid', function () { return 7; });
$request->macro('adminId', function () { return 1; });
t_assert($cod->tidyOrderFields($row, true)['cod_code'] === '', 'admin context does not see code');
$request->macro('adminId', function () { return 0; });

// ---- cancelOrder 守卫 ----
$threw = false;
try {
    $orderServices->cancelOrder($row['order_id'], 7);
} catch (\Throwable $e) {
    $threw = true;
}
t_assert($threw && Db::name('store_order')->where('id', $a)->value('is_cancel') == 0, 'user cancel rejected when stocking up');

$b = mk($pid, $uniq, ['is_cod' => 1, 'fulfil_status' => 0, 'cod_receivable' => 100, 'cod_delivery_code' => '222222']);
$ids[] = $b;
$rowB = Db::name('store_order')->where('id', $b)->find();
t_assert($orderServices->tidyOrder($rowB, false)['_status']['_title'] === '待确认', 'pending status text');
$stock0 = Db::name('store_product')->where('id', $pid)->value('stock');
$orderServices->cancelOrder($rowB['order_id'], 7);
t_assert(Db::name('store_order')->where('id', $b)->value('is_cancel') == 1, 'user can cancel pending cod');
t_assert(Db::name('store_product')->where('id', $pid)->value('stock') == $stock0 + 1, 'stock restored on user cancel');

// ---- 非到付订单不受影响 ----
$c = mk($pid, $uniq);
$ids[] = $c;
$rowC = Db::name('store_order')->where('id', $c)->find();
$outC = $orderServices->tidyOrder($rowC, false);
t_assert(!isset($outC['fulfil_key']) && strpos($outC['_status']['_title'], '线下') !== false, 'non-cod unchanged: ' . $outC['_status']['_title']);
$orderServices->cancelOrder($rowC['order_id'], 7);
t_assert(Db::name('store_order')->where('id', $c)->value('is_cancel') == 1, 'non-cod cancel unchanged');

foreach ($ids as $id) {
    Db::name('store_order_status')->where('oid', $id)->delete();
    Db::name('store_order_cart_info')->where('oid', $id)->delete();
    Db::name('store_order')->where('id', $id)->delete();
}
Db::name('store_product')->where('id', $pid)->delete();
Db::name('store_product_attr_value')->where('product_id', $pid)->delete();
t_done();
