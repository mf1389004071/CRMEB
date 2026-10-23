<?php
// M6 币种：MoneyServices、H5 接口、后台币种管理规则、订单币种快照
require __DIR__ . '/bootstrap.php';
require __DIR__ . '/Fixtures.php';

use think\facade\Db;
use app\services\system\MoneyServices as M;

$B = VnFx::base();
M::flush();

// ---- 服务层：换算/格式化 ----
t_assert(M::base() === 'VND', 'base is VND');
t_assert(M::convert('449000', 'USD') === '17.96', 'M6-5: 449000 VND -> USD 17.96 (rate 0.00004), got ' . M::convert('449000', 'USD'));
t_assert(M::convert('449000', 'CNY') === '125.72', '449000 VND -> CNY 125.72, got ' . M::convert('449000', 'CNY'));
t_assert(M::convert('449000', 'VND') === '449000', 'base convert is identity, no decimals');
t_assert(M::convert('12500', 'USD') === '0.50', 'rounding to 2dp: ' . M::convert('12500', 'USD'));
t_assert(M::convert('1', 'USD') === '0.00', 'tiny amount rounds to 0.00');
t_assert(M::convert('-449000', 'USD') === '-17.96', 'negative amounts');
t_assert(M::format('449000', 'VND') === '₫449.000', 'VND format: dot thousands, no decimals, no ≈: ' . M::format('449000', 'VND'));
t_assert(M::format('17.96', 'USD') === '≈$17.96', 'USD format with ≈: ' . M::format('17.96', 'USD'));
t_assert(M::format('1234567.5', 'VND', false) === '1.234.568', 'half-up rounding & thousands: ' . M::format('1234567.5', 'VND', false));
t_assert(M::format('1234.5', 'USD', false) === '1,234.50', 'USD thousands & 2 decimals');

// 合计 = 本位币合计再换算（与行价逐个换算求和不同）
$lines = ['12500', '12500', '12500'];
$sumOfRounded = '0';
foreach ($lines as $l) { $sumOfRounded = bcadd($sumOfRounded, M::convert($l, 'USD'), 2); }
$totalConverted = M::convert((string)array_sum($lines), 'USD');
t_assert($totalConverted === '1.50' && $sumOfRounded === '1.50', 'total converted once from base total');
$lines2 = ['1000', '1000', '1000'];
t_assert(M::convert((string)array_sum($lines2), 'USD') === '0.12' && bcadd(bcadd(M::convert('1000', 'USD'), M::convert('1000', 'USD'), 2), M::convert('1000', 'USD'), 2) === '0.12', 'rounding sample');

$snap = M::snapshot('449000', 'USD');
t_assert($snap['currency_code'] === 'USD' && $snap['exchange_rate'] == '0.00004' && $snap['pay_amount_display'] === '17.96', 'snapshot fields: ' . json_encode($snap));
t_assert(M::snapshot('449000', 'XXX')['currency_code'] === 'VND', 'unknown code falls back to base');
t_assert(M::resolveDisplayCode() === 'VND', 'CLI default display = base');

// ---- H5 接口 ----
$r = VnFx::http('GET', "$B/api/public/currency", '', [], ['Cb-lang: vi-VN']);
t_assert($r['status'] == 200 && $r['data']['base'] === 'VND' && count($r['data']['list']) === 3 && $r['data']['default_display'] === 'VND', 'public/currency: ' . substr(json_encode($r, JSON_UNESCAPED_UNICODE), 0, 120));
$r = VnFx::http('GET', "$B/api/public/currency", '', [], ['Cb-currency: USD']);
t_assert($r['data']['default_display'] === 'USD', 'Cb-currency header wins');
$r = VnFx::http('GET', "$B/api/public/currency", '', [], ['Cb-currency: ZZZ']);
t_assert($r['data']['default_display'] === 'VND', 'invalid Cb-currency ignored');
$r = VnFx::http('GET', "$B/api/public/currency", '', [], ['Cb-region: 911001']);
t_assert($r['data']['default_display'] === 'VND', 'VN region => VND default');
$r = VnFx::http('GET', "$B/api/basic_config");
t_assert(count($r['data']['currencies'] ?? []) === 3, 'basic_config exposes currencies');

$uid = VnFx::user();
$ut = VnFx::userToken($uid);
$r = VnFx::http('POST', "$B/api/user/currency", $ut, ['currency' => 'cny']);
t_assert($r['status'] == 200 && Db::name('user')->where('uid', $uid)->value('display_currency') === 'CNY', 'user currency saved (case-insensitive)');
$r = VnFx::http('GET', "$B/api/public/currency", $ut);
t_assert($r['data']['default_display'] === 'CNY', 'user preference becomes default_display');
$r = VnFx::http('GET', "$B/api/userinfo", $ut);
t_assert($r['data']['display_currency'] === 'CNY', 'userinfo returns display_currency');
$r = VnFx::http('POST', "$B/api/user/currency", $ut, ['currency' => 'EUR']);
t_assert($r['status'] != 200, 'unknown currency rejected');
Db::name('user')->where('uid', $uid)->update(['display_currency' => '']);

// ---- 后台币种管理 ----
$at = VnFx::adminToken();
$post = function ($p, $d) use ($B, $at) { return VnFx::http('POST', "$B/adminapi/$p", $at, $d); };
$get = function ($p) use ($B, $at) { return VnFx::http('GET', "$B/adminapi/$p", $at); };
$r = $get('setting/currency');
t_assert($r['status'] == 200 && count($r['data']) === 3, 'admin list currencies');
$usd = array_values(array_filter($r['data'], function ($c) { return $c['code'] === 'USD'; }))[0];
$vnd = array_values(array_filter($r['data'], function ($c) { return $c['code'] === 'VND'; }))[0];

// 改汇率写日志
$r = $post('setting/currency', array_merge($usd, ['rate' => '0.000042']));
t_assert($r['status'] == 200, 'update USD rate');
$logs = $get('setting/currency/logs?code=USD');
t_assert(count($logs['data']) >= 1 && $logs['data'][0]['new_rate'] == '0.000042' && $logs['data'][0]['old_rate'] == '0.000040', 'rate change logged');
t_assert(M::convert('449000', 'USD') === '18.86', 'new rate effective immediately (cache flushed): ' . M::convert('449000', 'USD'));
// 订单快照用汇率发生当时的值
$snapOld = M::snapshot('449000', 'USD');
$post('setting/currency', array_merge($usd, ['rate' => '0.000040']));
t_assert($snapOld['exchange_rate'] == '0.000042' && M::snapshot('449000', 'USD')['exchange_rate'] == '0.00004', 'earlier snapshot unaffected by later rate change (value copy)');

// 本位币规则
$r = $post('setting/currency', array_merge($usd, ['is_base' => 1]));
t_assert($r['status'] != 200, 'cannot set a second base currency');
$r = VnFx::http('DELETE', "$B/adminapi/setting/currency/" . $vnd['id'], $at);
t_assert($r['status'] != 200, 'cannot delete base currency');
$r = $post('setting/currency', array_merge($vnd, ['is_base' => 0]));
t_assert($r['status'] != 200, 'cannot unset base flag');
$r = $post('setting/currency', array_merge($vnd, ['status' => 0]));
t_assert($r['status'] != 200, 'cannot disable base currency');
$r = $post('setting/currency', array_merge($vnd, ['rate' => '5']));
t_assert($r['status'] == 200 && Db::name('system_currency')->where('code', 'VND')->value('rate') == '1.000000', 'base rate forced to 1');
$r = $post('setting/currency', ['code' => 'usd', 'rate' => '1', 'symbol' => '$']);
t_assert($r['status'] != 200, 'duplicate code rejected');
$r = $post('setting/currency', ['code' => 'AB', 'rate' => '1']);
t_assert($r['status'] != 200, 'invalid code rejected');
$r = $post('setting/currency', ['code' => 'EUR', 'rate' => '0', 'symbol' => '€']);
t_assert($r['status'] != 200, 'zero rate rejected');
$r = $post('setting/currency', ['code' => 'EUR', 'rate' => '0.000037', 'symbol' => '€', 'decimal_places' => 2, 'name_en' => 'Euro']);
t_assert($r['status'] == 200, 'add EUR');
$eurId = $r['data']['id'];
t_assert(M::convert('1000000', 'EUR') === '37.00', 'new currency usable');
$r = VnFx::http('DELETE', "$B/adminapi/setting/currency/$eurId", $at);
t_assert($r['status'] == 200 && !Db::name('system_currency')->where('code', 'EUR')->count(), 'delete non-base currency');
Db::name('system_exchange_rate_log')->where('code', 'EUR')->delete();

// ---- 订单币种快照（到付下单）----
$addr = VnFx::address($uid);
$pr = VnFx::product(884001, 'Cur-Item', [['suk' => '默认', 'price' => 449000, 'stock' => 10]]);
Db::name('store_product_region_price')->insert(['product_id' => 884001, 'unique' => $pr['uniques']['默认'], 'city_id' => 911001, 'price' => 449000, 'ot_price' => 0, 'stock' => null, 'status' => 1, 'add_time' => time(), 'update_time' => time()]);
app()->make(\app\services\product\RegionPriceServices::class)->flush(884001);
$ut = VnFx::userToken($uid);
$h = ['Cb-region: 911001', 'Cb-currency: USD'];
$r = VnFx::http('POST', "$B/api/cart/add", $ut, ['productId' => 884001, 'cartNum' => 1, 'uniqueId' => $pr['uniques']['默认'], 'new' => 1], $h);
$cid = $r['data']['cartId'];
$r = VnFx::http('POST', "$B/api/order/confirm", $ut, ['cartId' => (string)$cid, 'new' => 1, 'addressId' => $addr], $h);
$key = $r['data']['orderKey'];
$r = VnFx::http('POST', "$B/api/order/create/$key", $ut, ['addressId' => $addr, 'payType' => 'offline', 'shipping_type' => 1, 'new' => 1], $h);
$orderId = $r['data']['result']['orderId'] ?? '';
VnFx::http('POST', "$B/api/order/pay", $ut, ['uni' => $orderId, 'paytype' => 'offline'], $h);
$o = Db::name('store_order')->where('unique', $key)->find();
t_assert($o['currency_code'] === 'USD' && $o['exchange_rate'] == '0.00004' && (float)$o['pay_amount_display'] === 17.96, 'order snapshot: USD / rate / 17.96: ' . json_encode([$o['currency_code'], $o['exchange_rate'], $o['pay_amount_display']]));
t_assert((float)$o['pay_price'] === 449000.0 && (float)$o['cod_receivable'] === 449000.0, 'order amount stays in base currency');
// 改汇率后旧订单快照不变
$post('setting/currency', array_merge($usd, ['rate' => '0.000099']));
$o2 = Db::name('store_order')->where('id', $o['id'])->find();
t_assert((float)$o2['pay_amount_display'] === 17.96 && $o2['exchange_rate'] == '0.00004', 'old order snapshot unchanged after rate edit');
$post('setting/currency', array_merge($usd, ['rate' => '0.000040']));

VnFx::dropOrder((int)$o['id']);
VnFx::dropProduct(884001);
Db::name('user_address')->where('uid', $uid)->delete();
Db::name('store_cart')->where('uid', $uid)->delete();
M::flush();
t_done();
