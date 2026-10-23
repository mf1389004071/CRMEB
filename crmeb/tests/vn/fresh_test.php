<?php
// M7 生鲜属性：后台保存校验、H5 列表/详情输出、多语、打印带出
require __DIR__ . '/bootstrap.php';
require __DIR__ . '/Fixtures.php';

use think\facade\Db;
use app\services\other\I18nContentServices;

$B = VnFx::base();
$BD = 911001;
$at = VnFx::adminToken();
$uid = VnFx::user();
$addr = VnFx::address($uid);
$i18n = app()->make(I18nContentServices::class);
Db::name('system_config')->where('menu_name', 'order_rate_limit_per_hour')->update(['value' => '"50"']);
\crmeb\services\CacheService::clear();
$ut = VnFx::userToken($uid);
$at = VnFx::adminToken();

VnFx::dropProduct(885001);
VnFx::dropProduct(885002);
$P = VnFx::product(885001, 'Thịt bò FRESH', [['suk' => '默认', 'price' => 250000, 'stock' => 10]], ['unit_name' => 'Kg']);
$O = VnFx::product(885002, 'Old FRESH', [['suk' => '默认', 'price' => 9000, 'stock' => 10]]);   // 旧商品：无生鲜属性
foreach ([885001, 885002] as $pid) {
    Db::name('store_product_region_price')->insert(['product_id' => $pid, 'unique' => substr(md5($pid . '_默认'), 0, 8), 'city_id' => $BD, 'price' => $pid == 885001 ? 250000 : 9000, 'ot_price' => 0, 'stock' => null, 'status' => 1, 'add_time' => time(), 'update_time' => time()]);
    app()->make(\app\services\product\RegionPriceServices::class)->flush($pid);
}
$post = function ($p, $d) use ($B, &$at) { return VnFx::http('POST', "$B/adminapi/$p", $at, $d); };
$api = function ($p, $lang = 'vi-VN') use ($B, &$ut, $BD) { return VnFx::http('GET', "$B/api/$p", $ut, [], ['Cb-lang: ' . $lang, 'Cb-region: ' . $BD]); };

// ---- 校验 ----
$r = $post('product/fresh/885001', ['is_fresh' => 1, 'origin' => '']);
t_assert($r['status'] != 200, 'is_fresh=1 without origin rejected: ' . ($r['msg'] ?? ''));
$r = $post('product/fresh/885001', ['is_fresh' => 1, 'origin' => 'Úc', 'shelf_life_days' => -1]);
t_assert($r['status'] != 200, 'negative shelf life rejected');
$r = $post('product/fresh/885001', ['is_fresh' => 1, 'origin' => 'Úc', 'net_weight' => -2]);
t_assert($r['status'] != 200, 'negative net weight rejected');
$r = $post('product/fresh/885001', ['is_fresh' => 1, 'origin' => 'Úc', 'tax_rate' => 150]);
t_assert($r['status'] != 200, 'tax rate > 100 rejected');
$r = $post('product/fresh/88500199', ['is_fresh' => 0]);
t_assert($r['status'] != 200, 'unknown product rejected');
$r = $post('product/fresh/885001', ['is_fresh' => 0, 'origin' => '']);
t_assert($r['status'] == 200, 'non-fresh may leave origin empty');

// ---- 保存 ----
$r = $post('product/fresh/885001', ['is_fresh' => 1, 'origin' => 'Úc', 'shelf_life_days' => 5, 'shelf_life_text' => '5 ngày, bảo quản 0-4°C', 'need_cold_chain' => 1, 'cold_chain_note' => 'Giữ lạnh 0-4°C', 'net_weight' => '0.5', 'tax_rate' => '5']);
t_assert($r['status'] == 200, 'save fresh attrs: ' . json_encode($r, JSON_UNESCAPED_UNICODE));
$r = VnFx::http('GET', "$B/adminapi/product/fresh/885001", $at);
t_assert($r['data']['origin'] === 'Úc' && $r['data']['need_cold_chain'] == 1 && $r['data']['net_weight'] == '0.50' && $r['data']['tax_rate'] == '5.00', 'read back');
$r = VnFx::http('GET', "$B/adminapi/product/fresh/885001", '');
t_assert($r['status'] != 200, 'requires admin token');

// ---- H5 列表 ----
$i18n->save('product', 885001, ['en-US' => ['origin' => 'Australia', 'cold_chain_note' => 'Keep chilled 0-4C', 'shelf_life_text' => '5 days']]);
$l = $api('products?keyword=FRESH&page=1&limit=20');
$items = array_column($l['data'], null, 'id');
t_assert($items[885001]['origin'] === 'Úc' && $items[885001]['need_cold_chain'] == 1 && $items[885001]['is_fresh'] == 1 && $items[885001]['unit_name'] === 'Kg', 'list exposes origin/cold-chain/is_fresh/unit: ' . json_encode($items[885001] ?? null, JSON_UNESCAPED_UNICODE));
t_assert($items[885002]['is_fresh'] == 0 && $items[885002]['origin'] === '', 'old product: not fresh, empty origin');
$l = $api('products?keyword=FRESH&page=1&limit=20', 'en-US');
t_assert(array_column($l['data'], null, 'id')[885001]['origin'] === 'Australia', 'list origin localized (en)');

// ---- H5 详情 ----
$d = $api('product/detail/885001')['data'];
t_assert($d['fresh']['origin'] === 'Úc' && $d['fresh']['shelf_life'] === '5 ngày, bảo quản 0-4°C' && $d['fresh']['need_cold_chain'] == 1 && $d['fresh']['net_weight'] === '0.50' && $d['fresh']['unit_name'] === 'Kg' && $d['fresh']['tax_rate'] === '5.00', 'detail fresh block: ' . json_encode($d['fresh'], JSON_UNESCAPED_UNICODE));
$de = $api('product/detail/885001', 'en-US')['data'];
t_assert($de['fresh']['origin'] === 'Australia' && $de['fresh']['cold_chain_note'] === 'Keep chilled 0-4C' && $de['fresh']['shelf_life'] === '5 days', 'detail fresh block localized (en)');
$do = $api('product/detail/885002')['data'];
t_assert($do['fresh']['is_fresh'] == 0 && $do['fresh']['origin'] === '' && $do['fresh']['need_cold_chain'] == 0 && (float)$do['fresh']['net_weight'] == 0, 'old product detail: empty fresh block (front hides it)');
// 无保质期文案时回落天数
Db::name('store_product')->where('id', 885001)->update(['shelf_life_text' => '']);
$d = $api('product/detail/885001')['data'];
t_assert((string)$d['fresh']['shelf_life'] === '5', 'shelf life falls back to days when text empty');
Db::name('store_product')->where('id', 885001)->update(['shelf_life_text' => '5 ngày, bảo quản 0-4°C']);

// ---- 打印带出 ----
$cid = VnFx::http('POST', "$B/api/cart/add", $ut, ['productId' => 885001, 'cartNum' => 1, 'uniqueId' => $P['uniques']['默认'], 'new' => 1], ['Cb-region: ' . $BD])['data']['cartId'];
$key = VnFx::http('POST', "$B/api/order/confirm", $ut, ['cartId' => (string)$cid, 'new' => 1, 'addressId' => $addr], ['Cb-region: ' . $BD])['data']['orderKey'];
$r = VnFx::http('POST', "$B/api/order/create/$key", $ut, ['addressId' => $addr, 'payType' => 'offline', 'shipping_type' => 1, 'new' => 1], ['Cb-region: ' . $BD]);
VnFx::http('POST', "$B/api/order/pay", $ut, ['uni' => $r['data']['result']['orderId'], 'paytype' => 'offline'], ['Cb-region: ' . $BD]);
$oid = (int)Db::name('store_order')->where('unique', $key)->value('id');
$pv = VnFx::http('GET', "$B/adminapi/order/cod/print_data?ids=$oid&lang=vi-VN", $at)['data'][0]['goods'][0];
t_assert($pv['origin'] === 'Úc' && $pv['need_cold_chain'] == 1 && $pv['shelf_life'] === '5 ngày, bảo quản 0-4°C' && $pv['tax_rate'] === '5.00', 'print note carries origin/cold chain/shelf life/tax: ' . json_encode($pv, JSON_UNESCAPED_UNICODE));
$pe = VnFx::http('GET', "$B/adminapi/order/cod/print_data?ids=$oid&lang=en-US", $at)['data'][0]['goods'][0];
t_assert($pe['origin'] === 'Australia', 'print origin localized by print language');

VnFx::dropOrder($oid);
Db::name('i18n_content')->where('entity_id', 885001)->where('entity_type', 'product')->delete();
VnFx::dropProduct(885001);
VnFx::dropProduct(885002);
Db::name('user_address')->where('uid', $uid)->delete();
Db::name('store_cart')->where('uid', $uid)->delete();
Db::name('system_config')->where('menu_name', 'order_rate_limit_per_hour')->update(['value' => '"5"']);
\crmeb\services\CacheService::clear();
t_done();
