<?php
// M3-8 全链路冒烟：H5 加购 → 确认订单 → 下单 → offline 支付 → 后台确认/配送/核销/收款/完结（HTTP 真实接口）
require __DIR__ . '/bootstrap.php';
require __DIR__ . '/Fixtures.php';

use think\facade\Db;

$B = VnFx::base();
$uid = VnFx::user();
$addrId = VnFx::address($uid);
$p = VnFx::product(880101, 'E2E-Cabbage', [['suk' => 'default', 'price' => 30000, 'stock' => 10]]);
$unique = $p['uniques']['default'];
$ut = VnFx::userToken($uid);
$at = VnFx::adminToken();
$hdr = ['Cb-lang: vi-VN'];

// 1) 加购
$r = VnFx::http('POST', "$B/api/cart/add", $ut, ['productId' => 880101, 'cartNum' => 2, 'uniqueId' => $unique, 'new' => 1], $hdr);
t_assert($r['status'] == 200 && !empty($r['data']['cartId']), 'cart/add: ' . json_encode($r, JSON_UNESCAPED_UNICODE));
$cartId = $r['data']['cartId'] ?? 0;

// 2) 确认订单
$r = VnFx::http('POST', "$B/api/order/confirm", $ut, ['cartId' => (string)$cartId, 'new' => 1, 'addressId' => $addrId], $hdr);
t_assert($r['status'] == 200 && !empty($r['data']['orderKey']), 'order/confirm: ' . json_encode($r, JSON_UNESCAPED_UNICODE));
$key = $r['data']['orderKey'] ?? '';
t_assert(isset($r['data']['priceGroup']) && bccomp((string)$r['data']['priceGroup']['totalPrice'], '60000', 2) === 0, 'confirm totalPrice=60000, got ' . json_encode($r['data']['priceGroup'] ?? null));

// 3) 创建订单（payType=offline）
$r = VnFx::http('POST', "$B/api/order/create/$key", $ut, ['addressId' => $addrId, 'payType' => 'offline', 'shipping_type' => 1, 'mark' => 'giao nhanh', 'new' => 1], $hdr);
t_assert($r['status'] == 200 && !empty($r['data']['result']['orderId']), 'order/create: ' . json_encode($r, JSON_UNESCAPED_UNICODE));
$orderId = $r['data']['result']['orderId'] ?? '';
$row = Db::name('store_order')->where('order_id', $orderId)->find();
t_assert($row && $row['is_cod'] == 0 && $row['paid'] == 0, 'created order is not cod yet (cod mark set on pay)');

// 4) 支付 offline => 到付钩子
$r = VnFx::http('POST', "$B/api/order/pay", $ut, ['uni' => $orderId, 'paytype' => 'offline'], $hdr);
t_assert($r['status'] == 200, 'order/pay offline: ' . json_encode($r, JSON_UNESCAPED_UNICODE));
$row = Db::name('store_order')->where('unique', $key)->find();
$oid = (int)$row['id'];
t_assert($row['is_cod'] == 1 && $row['fulfil_status'] == 1 && $row['paid'] == 0 && $row['pay_type'] === 'offline', 'order is cod/stockup/unpaid: ' . json_encode([$row['is_cod'], $row['fulfil_status'], $row['paid']]));
t_assert(preg_match('/^[0-9]{6}$/', $row['cod_delivery_code']) === 1 && bccomp($row['cod_receivable'], '60000', 2) === 0, 'code & receivable snapshot');
t_assert($row['lang'] === 'vi-VN', 'lang snapshot vi-VN');
t_assert(Db::name('store_product')->where('id', 880101)->value('stock') == 8, 'stock deducted at order time (10-2)');
$audit = Db::name('store_order_status')->where(['oid' => $oid, 'change_type' => 'cod_created'])->find();
t_assert((bool)$audit, 'audit cod_created written');

// 5) 用户详情：履约文案、送达码可见
$r = VnFx::http('GET', "$B/api/order/detail/$key", $ut, [], $hdr);
t_assert($r['status'] == 200 && $r['data']['_status']['_title'] === '备货中' && preg_match('/^[0-9]{6}$/', $r['data']['cod_code']) === 1 && $r['data']['can_cancel'] === false, 'user detail: ' . json_encode([$r['data']['_status'] ?? null, $r['data']['cod_code'] ?? null, $r['data']['can_cancel'] ?? null], JSON_UNESCAPED_UNICODE));
t_assert(!array_key_exists('cod_delivery_code', $r['data']), 'raw code column not leaked');
$r = VnFx::http('GET', "$B/api/order/list?page=1&limit=10", $ut, [], $hdr);
t_assert($r['status'] == 200, 'order list ok: ' . substr(json_encode($r), 0, 200));
if ($r['status'] == 200) {
    $found = array_values(array_filter($r['data'], function ($o) use ($oid) { return $o['id'] == $oid; }));
    t_assert(count($found) === 1 && ($found[0]['cod_code'] ?? '') === '', 'user list shows order without code');
}

// 6) 用户取消被拒
$r = VnFx::http('POST', "$B/api/order/cancel", $ut, ['id' => $orderId], $hdr);
t_assert($r['status'] != 200, 'user cancel rejected: ' . ($r['msg'] ?? ''));
t_assert(strpos($r['msg'] ?? '', 'hủy') !== false || strpos($r['msg'] ?? '', 'CSKH') !== false, 'cancel rejection message in vi: ' . ($r['msg'] ?? ''));

// 7) 超时取消任务不会取消 offline 单
$row['add_time'] = $row['add_time'] - 86400 * 3;
Db::name('store_order')->where('id', $oid)->update(['add_time' => $row['add_time']]);
app()->make(\app\services\order\StoreOrderServices::class)->orderUnpaidCancel();
t_assert(Db::name('store_order')->where('id', $oid)->value('is_cancel') == 0, 'unpaid-cancel job skips offline order');

// 8) 后台：配送 → 核销 → 收款 → 完结
$code = $row['cod_delivery_code'];
$r = VnFx::http('POST', "$B/adminapi/order/cod/delivering/$oid", $at, ['delivery_name' => 'Shipper'], $hdr);
t_assert($r['status'] == 200, 'admin delivering');
$r = VnFx::http('POST', "$B/adminapi/order/cod/verify", $at, ['order_id' => Db::name('store_order')->where('id', $oid)->value('order_id'), 'code' => $code], $hdr);
t_assert($r['status'] == 200 && $r['data']['fulfil_status'] == 3, 'admin verify');
$stats0 = Db::name('store_order')->where(['id' => $oid, 'paid' => 1])->count();
t_assert($stats0 === 0, 'unpaid delivered order not counted as paid (revenue excluded)');
$r = VnFx::http('POST', "$B/adminapi/order/cod/collect/$oid", $at, ['received' => '60000'], $hdr);
t_assert($r['status'] == 200, 'admin collect: ' . json_encode($r, JSON_UNESCAPED_UNICODE));
$row = Db::name('store_order')->where('id', $oid)->find();
t_assert($row['paid'] == 1 && $row['status'] == 3 && $row['pay_time'] > 0, 'finished: paid=1,status=3');
$flow = Db::name('capital_flow')->where("order_id", $row["order_id"])->count();
t_assert($flow >= 1, 'capital flow recorded for collection');

// 清理
VnFx::dropOrder($oid);
VnFx::dropProduct(880101);
Db::name('user_address')->where('uid', $uid)->delete();
Db::name('store_cart')->where('uid', $uid)->delete();
t_done();
