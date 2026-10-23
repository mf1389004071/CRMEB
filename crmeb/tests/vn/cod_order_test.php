<?php
// M3-3 到付订单状态机测试：php tests/vn/cod_order_test.php（经 run.sh 在 docker 内运行，直接操作测试库）
require __DIR__ . '/bootstrap.php';

use think\facade\Db;
use app\services\order\CodOrderServices;
use app\services\order\OrderAuditServices;

/** @var CodOrderServices $cod */
$cod = app()->make(CodOrderServices::class);
$admin = ['id' => 1, 'type' => 'admin', 'name' => 'tester'];

// ---------- 造数据：1 个商品(库存10) + 1 个单规格 + 订单(下单已扣库存) ----------
$pid = 880001;
$uniq = 'tst88001';
Db::name('store_product')->where('id', $pid)->delete();
Db::name('store_product_attr_value')->where('product_id', $pid)->delete();
Db::name('store_product')->insert(['id' => $pid, 'store_name' => 'cod-test', 'price' => 100, 'stock' => 8, 'sales' => 2, 'is_show' => 1, 'is_del' => 0, 'add_time' => time()]);
Db::name('store_product_attr_value')->insert(['product_id' => $pid, 'suk' => 'default', 'stock' => 8, 'sales' => 2, 'price' => 100, 'unique' => $uniq, 'type' => 0]);

function makeOrder($pid, $uniq, array $extra = [])
{
    static $n = 0;
    $n++;
    $orderId = 'cod_t_' . time() . '_' . $n;
    $cartId = 970000 + $n;
    $data = array_merge([
        'order_id' => $orderId, 'uid' => 1, 'real_name' => 'Nguyen', 'user_phone' => '0912345678', 'user_address' => 'Ha Noi',
        'cart_id' => json_encode([$cartId]), 'total_num' => 2, 'total_price' => 200, 'pay_price' => 200, 'paid' => 0, 'pay_type' => 'offline',
        'add_time' => time(), 'status' => 0, 'unique' => md5($orderId), 'mark' => '',
    ], $extra);
    $oid = Db::name('store_order')->insertGetId($data);
    Db::name('store_order_cart_info')->insert([
        'oid' => $oid, 'uid' => 1, 'cart_id' => $cartId, 'product_id' => $pid, 'cart_num' => 2, 'surplus_num' => 2,
        'cart_info' => json_encode(['cart_num' => 2, 'productInfo' => ['id' => $pid, 'attrInfo' => ['unique' => $uniq]]]),
        'unique' => md5($orderId . 'c'),
    ]);
    return $oid;
}

function row($oid)
{
    return Db::name('store_order')->where('id', $oid)->find();
}

function expectThrow(callable $fn, string $name)
{
    try {
        $fn();
        t_assert(false, $name . ' (no exception)');
    } catch (\Throwable $e) {
        t_assert(true, $name);
    }
}

// ---------- 1) 创建钩子：默认直接备货中 ----------
$oid = makeOrder($pid, $uniq);
$cod->onCreated(['id' => $oid]);
$r = row($oid);
t_assert($r['is_cod'] == 1 && $r['fulfil_status'] == 1, 'onCreated => cod, fulfil=1 (cod_auto_stock_up default)');
t_assert(preg_match('/^[0-9]{6}$/', $r['cod_delivery_code']) === 1, 'delivery code 6 digits');
t_assert(bccomp($r['cod_receivable'], '200', 2) === 0, 'receivable snapshot');
t_assert($r['lang'] === 'vi-VN', 'lang snapshot vi-VN, got ' . $r['lang']);
$code1 = $r['cod_delivery_code'];
$cod->onCreated(['id' => $oid]); // 幂等
t_assert(row($oid)['cod_delivery_code'] === $code1, 'onCreated idempotent');

// ---------- 2) 用户取消守卫 ----------
t_assert($cod->userCanCancel(row($oid)) === false, 'user cannot cancel when stocking up');
t_assert($cod->userCanCancel(['is_cod' => 0]) === true, 'non-cod passes through');

// ---------- 3) 待确认模式 ----------
$oid2 = makeOrder($pid, $uniq, ['is_cod' => 1, 'fulfil_status' => 0, 'cod_receivable' => 200, 'cod_delivery_code' => '111111']);
t_assert($cod->userCanCancel(row($oid2)) === true, 'user can cancel when pending');
$cod->confirm($oid2, $admin);
t_assert(row($oid2)['fulfil_status'] == 1, 'confirm 0->1');
expectThrow(function () use ($cod, $oid2, $admin) { $cod->confirm($oid2, $admin); }, 'confirm twice rejected');

// ---------- 4) 配送 + 核销 ----------
$cod->startDelivery($oid, ['delivery_name' => 'Driver A', 'delivery_id' => '0988'], $admin);
$r = row($oid);
t_assert($r['fulfil_status'] == 2 && $r['delivery_type'] === 'send' && $r['delivery_name'] === 'Driver A' && $r['status'] == 0, 'startDelivery 1->2 keeps status');
expectThrow(function () use ($cod, $r, $admin) { $cod->verifyDelivered($r['order_id'], '000000', $admin); }, 'wrong code rejected');
t_assert(row($oid)['fulfil_status'] == 2, 'wrong code leaves state');
$sum = $cod->verifyDelivered($r['order_id'], $code1, $admin);
t_assert(row($oid)['fulfil_status'] == 3 && $sum['paid'] === 0 && row($oid)['delivered_time'] > 0, 'verify by order_id+code => delivered');
expectThrow(function () use ($cod, $code1, $admin) { $cod->verifyDelivered($code1, null, $admin); }, 'code reuse rejected after delivered');

// ---------- 5) 收款 ----------
t_assert(row($oid)['status'] == 0, 'delivered but unpaid is not finished');
expectThrow(function () use ($cod, $oid, $admin) { $cod->collect($oid, '150', '', $admin); }, 'amount mismatch without remark rejected');
t_assert(row($oid)['paid'] == 0, 'rejected collect leaves paid=0');
$cod->collect($oid, '150', 'customer returned one item', $admin);
$r = row($oid);
t_assert($r['paid'] == 1 && bccomp($r['cod_received'], '150', 2) === 0 && $r['cod_collector_id'] == 1 && $r['cod_collect_time'] > 0, 'collect stored received/collector');
t_assert($r['status'] == 3, 'delivered+paid => finished status=3');
expectThrow(function () use ($cod, $oid, $admin) { $cod->collect($oid, '200', '', $admin); }, 'second collect rejected');
expectThrow(function () use ($cod, $oid, $admin) { $cod->adminCancel($oid, 'x', $admin); }, 'cancel finished order rejected');

// ---------- 6) 后台取消回退库存 ----------
$stockBefore = Db::name('store_product')->where('id', $pid)->value('stock');
$attrBefore = Db::name('store_product_attr_value')->where('product_id', $pid)->value('stock');
$cod->adminCancel($oid2, 'customer asked', $admin);
t_assert(row($oid2)['is_cancel'] == 1, 'adminCancel sets is_cancel');
t_assert(Db::name('store_product')->where('id', $pid)->value('stock') == $stockBefore + 2, 'product stock restored +2');
t_assert(Db::name('store_product_attr_value')->where('product_id', $pid)->value('stock') == $attrBefore + 2, 'sku stock restored +2');
expectThrow(function () use ($cod, $oid2, $admin) { $cod->confirm($oid2, $admin); }, 'cancelled order cannot be confirmed');

// ---------- 7) 电话确认标记 / 审计 ----------
$oid3 = makeOrder($pid, $uniq);
$cod->onCreated(['id' => $oid3]);
$cod->callMark($oid3, 1, $admin);
t_assert(row($oid3)['need_call_confirm'] == 1, 'call mark on');
$cod->markDelivered($oid3, $admin);
t_assert(row($oid3)['fulfil_status'] == 3, 'admin markDelivered');
$audit = app()->make(OrderAuditServices::class)->getList($oid);
$types = array_column($audit, 'change_type');
foreach (['cod_created', 'cod_delivering', 'cod_code_verify', 'cod_amount_edit', 'cod_collect'] as $t) {
    t_assert(in_array($t, $types, true), "audit has $t");
}
t_assert(count(array_filter($audit, function ($a) { return $a['operator_name'] === 'tester'; })) >= 4, 'audit rows carry operator');

// ---------- 8) 无码核销（仅 6 位码） ----------
$oid4 = makeOrder($pid, $uniq);
$cod->onCreated(['id' => $oid4]);
$c4 = row($oid4)['cod_delivery_code'];
$sum = $cod->verifyDelivered($c4, null, $admin);
t_assert($sum['order_id'] === row($oid4)['order_id'], 'verify by code only');

// ---------- 清理 ----------
foreach ([$oid, $oid2, $oid3, $oid4] as $id) {
    Db::name('store_order_status')->where('oid', $id)->delete();
    Db::name('store_order_cart_info')->where('oid', $id)->delete();
    Db::name('store_order')->where('id', $id)->delete();
}
Db::name('store_product')->where('id', $pid)->delete();
Db::name('store_product_attr_value')->where('product_id', $pid)->delete();
Db::name('store_order_status')->where('change_type', 'offline')->where('oid', 'in', [$oid, $oid2, $oid3, $oid4])->delete();
t_done();
