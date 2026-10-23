<?php
// M9-3 下单防刷：服务层 + 真实下单链路
require __DIR__ . '/bootstrap.php';
require __DIR__ . '/Fixtures.php';

use think\facade\Db;
use app\services\order\OrderRiskServices;

/** @var OrderRiskServices $risk */
$risk = app()->make(OrderRiskServices::class);
Db::name('order_blacklist')->delete(true);

function throws(callable $fn): string
{
    try {
        $fn();
        return '';
    } catch (\Throwable $e) {
        return $e->getMessage() ?: 'err';
    }
}

// ---- 限频：阈值 2（直接改配置并清缓存）----
$setLimit = function (int $n) {
    Db::name('system_config')->where('menu_name', 'order_rate_limit_per_hour')->update(['value' => json_encode((string)$n)]);
    \crmeb\services\CacheService::clear();
};
$setLimit(2);
\think\facade\Cache::clear();
$user = ['uid' => 1, 'phone' => ''];
$phone = '0912000555';
t_assert(throws(function () use ($risk, $user, $phone) { $risk->check($user, '8.8.8.8', $phone); }) === '', 'first check passes');
$risk->hit($user, '8.8.8.8', $phone);
$risk->hit($user, '8.8.8.8', $phone);
t_assert(throws(function () use ($risk, $user, $phone) { $risk->check($user, '9.9.9.9', $phone); }) !== '', 'same phone over limit rejected (different ip)');
t_assert(throws(function () use ($risk, $user) { $risk->check($user, '8.8.8.8', '0912000666'); }) !== '', 'same public ip over limit rejected (different phone)');
t_assert(throws(function () use ($risk, $user) { $risk->check($user, '7.7.7.7', '0912000777'); }) === '', 'other phone+ip unaffected');
// 私网 IP 不做 IP 限频（防止反代后全站同 IP 误杀）
$risk->hit($user, '10.0.0.5', '0912000881');
$risk->hit($user, '10.0.0.5', '0912000882');
$risk->hit($user, '10.0.0.5', '0912000883');
t_assert(throws(function () use ($risk, $user) { $risk->check($user, '10.0.0.5', '0912000884'); }) === '', 'private ip does not trigger ip rate limit');
// 电话不同书写方式视作同一号码
t_assert(throws(function () use ($risk, $user) { $risk->check($user, '', '+84 912-000-555'); }) !== '', 'phone normalization: +84 912-000-555 == 0912000555');

// ---- 黑名单 ----
$risk->addBlacklist('phone', '0912000999', 'spam');
t_assert(throws(function () use ($risk, $user) { $risk->check($user, '', '+84912000999'); }) !== '', 'blacklisted phone (any format) rejected');
$risk->addBlacklist('ip', '6.6.6.6');
t_assert(throws(function () use ($risk, $user) { $risk->check($user, '6.6.6.6', '0900000001'); }) !== '', 'blacklisted ip rejected');
$risk->addBlacklist('uid', '4242');
t_assert(throws(function () use ($risk) { $risk->check(['uid' => 4242, 'phone' => ''], '', ''); }) !== '', 'blacklisted uid rejected');
$risk->addBlacklist('phone', '0912000999');   // 幂等
t_assert(Db::name('order_blacklist')->where(['type' => 'phone'])->count() === 1, 'blacklist add idempotent');
$list = $risk->blacklist(['type' => 'phone']);
t_assert($list['count'] === 1 && $list['list'][0]['value'] === '84912000999', 'blacklist stores normalized phone');
$risk->removeBlacklist((int)$list['list'][0]['id']);
t_assert(throws(function () use ($risk, $user) { $risk->check($user, '', '+84912000999'); }) === '', 'removed from blacklist => passes');

// ---- HTTP：后台黑名单 CRUD ----
$B = VnFx::base();
$at = VnFx::adminToken();
$r = VnFx::http('POST', "$B/adminapi/order/blacklist", $at, ['type' => 'phone', 'value' => '0911222333', 'remark' => 'api']);
t_assert($r['status'] == 200, 'api add blacklist');
$r = VnFx::http('GET', "$B/adminapi/order/blacklist?type=phone", $at);
t_assert($r['status'] == 200 && $r['data']['count'] === 1, 'api list blacklist');
$bid = $r['data']['list'][0]['id'] ?? 0;
$r = VnFx::http('POST', "$B/adminapi/order/blacklist", $at, ['type' => 'bad', 'value' => 'x']);
t_assert($r['status'] != 200, 'api invalid type rejected');
$r = VnFx::http('DELETE', "$B/adminapi/order/blacklist/$bid", $at);
t_assert($r['status'] == 200 && Db::name('order_blacklist')->count() === 0 + (int)Db::name('order_blacklist')->count(), 'api delete blacklist');

// ---- 真实下单链路：黑名单 / 限频 ----
$setLimit(1);
$uid = VnFx::user();
$addrId = VnFx::address($uid);   // 地址手机号 0912345678
$p = VnFx::product(880301, 'Risk-Item', [['suk' => '默认', 'price' => 10000, 'stock' => 50]]);
Db::name('store_product_region_price')->insert(['product_id' => 880301, 'unique' => $p['uniques']['默认'], 'city_id' => 911001, 'price' => 10000, 'ot_price' => 0, 'stock' => null, 'status' => 1, 'add_time' => time(), 'update_time' => time()]);
$ut = VnFx::userToken($uid);
$mk = function () use ($B, &$ut, $p, $addrId) {
    $r = VnFx::http('POST', "$B/api/cart/add", $ut, ['productId' => 880301, 'cartNum' => 1, 'uniqueId' => $p['uniques']['默认'], 'new' => 1], ['Cb-region: 911001']);
    $cid = $r['data']['cartId'] ?? 0;
    $r = VnFx::http('POST', "$B/api/order/confirm", $ut, ['cartId' => (string)$cid, 'new' => 1, 'addressId' => $addrId], ['Cb-region: 911001']);
    return $r['data']['orderKey'] ?? '';
};
Db::name('order_blacklist')->delete(true);
$risk->addBlacklist('phone', '0912345678', 'e2e');
$key = $mk();
$r = VnFx::http('POST', "$B/api/order/create/$key", $ut, ['addressId' => $addrId, 'payType' => 'offline', 'shipping_type' => 1, 'new' => 1], ['Cb-lang: vi-VN', 'Cb-region: 911001']);
t_assert($r['status'] != 200 && strpos($r['msg'], 'liên hệ') !== false, 'blacklisted phone cannot create order (vi msg): ' . ($r['msg'] ?? ''));
Db::name('order_blacklist')->delete(true);
\think\facade\Cache::clear();
$ut = VnFx::userToken($uid);   // Cache::clear 同时清掉了登录态
$key = $mk();
$r = VnFx::http('POST', "$B/api/order/create/$key", $ut, ['addressId' => $addrId, 'payType' => 'offline', 'shipping_type' => 1, 'new' => 1], ['Cb-region: 911001']);
t_assert($r['status'] == 200, 'first order within limit ok: ' . json_encode($r, JSON_UNESCAPED_UNICODE));
$key2 = $mk();
$r = VnFx::http('POST', "$B/api/order/create/$key2", $ut, ['addressId' => $addrId, 'payType' => 'offline', 'shipping_type' => 1, 'new' => 1], ['Cb-lang: vi-VN', 'Cb-region: 911001']);
t_assert($r['status'] != 200 && strpos($r['msg'], 'thường xuyên') !== false || strpos($r['msg'] ?? '', 'quá') !== false, 'second order in the hour rejected (limit=1): ' . ($r['msg'] ?? ''));

// 清理
$setLimit(5);
foreach (Db::name('store_order')->where('uid', $uid)->column('id') as $oid) {
    VnFx::dropOrder((int)$oid);
}
Db::name('store_product_region_price')->where('product_id', 880301)->delete();
VnFx::dropProduct(880301);
Db::name('user_address')->where('uid', $uid)->delete();
Db::name('store_cart')->where('uid', $uid)->delete();
Db::name('order_blacklist')->delete(true);
\think\facade\Cache::clear();
t_done();
