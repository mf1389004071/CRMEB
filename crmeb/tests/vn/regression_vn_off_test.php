<?php
// §4.2 回归：vn_mode_enable=0 / region_pricing_enable=0 时站点行为与原版一致（开关可回滚）
require __DIR__ . '/bootstrap.php';
require __DIR__ . '/Fixtures.php';

use think\facade\Db;

$B = VnFx::base();
$uid = VnFx::user();
$setCfg = function (string $k, $v) { Db::name('system_config')->where('menu_name', $k)->update(['value' => json_encode((string)$v)]); \crmeb\services\CacheService::clear(); };
$origRate = Db::name('system_config')->where('menu_name', 'order_rate_limit_per_hour')->value('value');
$setCfg('vn_mode_enable', 0);
$ut = VnFx::userToken($uid);   // clear 之后签发
$at = VnFx::adminToken();

// 旧中文地址（原版数据结构：地址 city_id 取中国存量区划）
Db::name('user_address')->where('uid', $uid)->delete();
$addrId = Db::name('user_address')->insertGetId(['uid' => $uid, 'real_name' => '张三', 'phone' => '13800001111', 'province' => '北京市', 'city' => '北京市', 'city_id' => 2, 'district' => '东城区', 'detail' => '长安街1号', 'is_default' => 1, 'is_del' => 0, 'add_time' => time()]);
$P = VnFx::product(886001, 'Regression-Item', [['suk' => '默认', 'price' => 88, 'stock' => 20]]);
$api = function ($m, $p, $d = []) use ($B, &$ut) { return VnFx::http($m, "$B/api/$p", $ut, $d); };

// 公共配置反映开关
$r = VnFx::http('GET', "$B/api/basic_config");
t_assert($r['data']['vn_mode_enable'] === false, 'basic_config shows vn_mode_enable=false');

// 无区域头：列表/详情按主表价（原版行为），无 region_required
$r = $api('GET', 'products?keyword=Regression&page=1&limit=10');
$byId = array_column($r['data'] ?? [], 'price', 'id');
t_assert(($r['region_required'] ?? false) === false && (float)($byId[886001] ?? 0) === 88.0, 'list works without region at base price: ' . json_encode($byId));
$r = $api('GET', 'product/detail/886001');
t_assert($r['status'] == 200 && (float)$r['data']['storeInfo']['price'] === 88.0, 'detail without region at base price');
$r = $api('GET', 'category');
t_assert($r['status'] == 200, 'category works');

// “我的”菜单不被裁剪（营销入口保留）
$r = VnFx::http('GET', "$B/api/menu/user", $ut);
$urls = array_column($r['data']['routine_my_menus'], 'url');
t_assert(in_array('/pages/users/user_coupon/index', $urls, true) && !in_array('/pages/users/contact/index', $urls, true), 'user menu unchanged when vn mode is off');

// 原版下单流程：加购 → 确认 → 创建 → offline 支付（不再是到付单）
$r = $api('POST', 'cart/add', ['productId' => 886001, 'cartNum' => 2, 'uniqueId' => $P['uniques']['默认'], 'new' => 1]);
t_assert($r['status'] == 200, 'add to cart without region header: ' . json_encode($r, JSON_UNESCAPED_UNICODE));
$cid = $r['data']['cartId'];
$r = $api('POST', 'order/confirm', ['cartId' => (string)$cid, 'new' => 1, 'addressId' => $addrId]);
t_assert($r['status'] == 200 && (float)$r['data']['priceGroup']['totalPrice'] === 176.0, 'confirm total = 88*2 (base price)');
$key = $r['data']['orderKey'];
$r = $api('POST', "order/create/$key", ['addressId' => $addrId, 'payType' => 'offline', 'shipping_type' => 1, 'new' => 1]);
t_assert($r['status'] == 200, 'create order (old chinese address, no region): ' . json_encode($r, JSON_UNESCAPED_UNICODE));
$orderId = $r['data']['result']['orderId'];
$r = $api('POST', 'order/pay', ['uni' => $orderId, 'paytype' => 'offline']);
t_assert($r['status'] == 200, 'offline pay status ok');
$o = Db::name('store_order')->where('unique', $key)->find();
t_assert($o['is_cod'] == 0 && $o['paid'] == 0 && $o['pay_type'] === 'offline' && $o['fulfil_status'] == 0 && $o['cod_delivery_code'] === '' && $o['region_id'] == 0, 'order is a plain offline order (not COD): ' . json_encode([$o['is_cod'], $o['paid'], $o['region_id']]));
$d = $api('GET', "order/detail/$key");
t_assert($d['status'] == 200 && strpos($d['data']['_status']['_title'], '线下') !== false && empty($d['data']['cod_code']) && empty($d['data']['is_cod']), 'detail status text is the original "offline unpaid": ' . json_encode($d['data']['_status'] ?? null, JSON_UNESCAPED_UNICODE));

// 原版“后台线下支付”按钮对非到付订单仍可用
$r = VnFx::http('POST', "$B/adminapi/order/pay_offline/" . $o['id'], $at);
t_assert($r['status'] == 200 && Db::name('store_order')->where('id', $o['id'])->value('paid') == 1, 'admin pay_offline works on non-COD order');

// 原版用户取消流程（未支付订单）
$r = $api('POST', 'cart/add', ['productId' => 886001, 'cartNum' => 1, 'uniqueId' => $P['uniques']['默认'], 'new' => 1]);
$k2 = $api('POST', 'order/confirm', ['cartId' => (string)$r['data']['cartId'], 'new' => 1, 'addressId' => $addrId])['data']['orderKey'];
$r = $api('POST', "order/create/$k2", ['addressId' => $addrId, 'payType' => 'offline', 'shipping_type' => 1, 'new' => 1]);
$o2 = Db::name('store_order')->where('unique', $k2)->find();
$stockBefore = (int)Db::name('store_product')->where('id', 886001)->value('stock');
$r = $api('POST', 'order/cancel', ['id' => $o2['order_id']]);
t_assert($r['status'] == 200 && Db::name('store_order')->where('id', $o2['id'])->value('is_cancel') == 1, 'user cancel of unpaid order works (original behavior)');
t_assert((int)Db::name('store_product')->where('id', 886001)->value('stock') === $stockBefore + 1, 'stock restored on cancel');

// 注册走原版验证码流程（未提供验证码被拒）
$r = VnFx::http('POST', "$B/api/register", '', ['account' => '13900009999', 'password' => 'Abc12345']);
t_assert($r['status'] != 200, 'register requires captcha again when vn mode off: ' . ($r['msg'] ?? ''));

// 语言码规范化不依赖越南开关
$r = VnFx::http('GET', "$B/api/get_lang_json", '', [], ['Cb-lang: vi_vn']);
t_assert(isset($r['data']['vi-VN']), 'language alias normalization still works');

// ---- region_pricing_enable=0 且 vn_mode=1：其余越南能力保留，价格走主表 ----
$setCfg('vn_mode_enable', 1);
$setCfg('region_pricing_enable', 0);
$ut = VnFx::userToken($uid);
$r = $api('GET', 'products?keyword=Regression&page=1&limit=10');
t_assert(($r['region_required'] ?? false) === false && (float)(array_column($r['data'], 'price', 'id')[886001] ?? 0) === 88.0, 'region pricing off: list at base price without region');
$r = $api('POST', 'cart/add', ['productId' => 886001, 'cartNum' => 1, 'uniqueId' => $P['uniques']['默认'], 'new' => 1]);
t_assert($r['status'] == 200, 'region pricing off: add to cart ok');
$setCfg('region_pricing_enable', 1);

// 清理
foreach (Db::name('store_order')->where('uid', $uid)->column('id') as $oid) { VnFx::dropOrder((int)$oid); }
VnFx::dropProduct(886001);
Db::name('user_address')->where('uid', $uid)->delete();
Db::name('store_cart')->where('uid', $uid)->delete();
Db::name('system_config')->where('menu_name', 'order_rate_limit_per_hour')->update(['value' => $origRate]);
$setCfg('vn_mode_enable', 1);
\crmeb\services\CacheService::clear();
t_done();
