<?php
// M5-5 内容多语验收（HTTP）：列表/详情/规格/购物车/分类/订单快照/打印语言重取/待审机翻开关
require __DIR__ . '/bootstrap.php';
require __DIR__ . '/Fixtures.php';

use think\facade\Db;
use app\services\other\I18nContentServices;

$B = VnFx::base();
$BD = 911001;
$uid = VnFx::user();
$addrId = VnFx::address($uid);
$i18n = app()->make(I18nContentServices::class);
$setCfg = function (string $k, $v) { Db::name('system_config')->where('menu_name', $k)->update(['value' => json_encode((string)$v)]); \crmeb\services\CacheService::clear(); };
$setCfg('order_rate_limit_per_hour', 50);
$setCfg('i18n_show_pending_machine', 1);
$ut = VnFx::userToken($uid);
$at = VnFx::adminToken();

VnFx::dropProduct(883201);
Db::name('i18n_content')->where('entity_id', 'in', [883201, 883301])->whereIn('entity_type', ['product', 'category', 'product_attr', 'sku'])->delete();
$P = VnFx::product(883201, 'Cải thìa I18N', [['suk' => 'a', 'price' => 30000, 'stock' => 20], ['suk' => 'b', 'price' => 50000, 'stock' => 20]], ['unit_name' => 'Kg', 'store_info' => 'Rau sạch']);
$ua = $P['uniques']['a'];
foreach (['a', 'b'] as $s) {
    Db::name('store_product_region_price')->insert(['product_id' => 883201, 'unique' => $P['uniques'][$s], 'city_id' => $BD, 'price' => $s === 'a' ? 30000 : 50000, 'ot_price' => 0, 'stock' => null, 'status' => 1, 'add_time' => time(), 'update_time' => time()]);
}
app()->make(\app\services\product\RegionPriceServices::class)->flush(883201);
$attrId = (int)Db::name('store_product_attr')->where('product_id', 883201)->value('id');
$i18n->save('product', 883201, [
    'zh-CN' => ['store_name' => '小白菜', 'unit_name' => '公斤', 'store_info' => '干净蔬菜'],
    'en-US' => ['store_name' => 'Baby bok choy', 'unit_name' => 'kg'],   // 缺英文简介 => 回落越南语
]);
$i18n->save('product_attr', $attrId, [
    'zh-CN' => ['attr_name' => '重量', 'attr_values' => '半斤,一斤'],
    'en-US' => ['attr_name' => 'Weight', 'attr_values' => '500g,1kg'],
]);

$api = function (string $method, string $path, array $data, string $lang) use ($B, &$ut, $BD) {
    return VnFx::http($method, "$B/api/$path", $ut, $data, ['Cb-lang: ' . $lang, 'Cb-region: ' . $BD]);
};
$pick = function (array $r) {
    foreach ($r['data'] ?? [] as $it) { if ((int)$it['id'] === 883201) return $it; }
    return null;
};

// ===== 列表 =====
$vi = $pick($api('GET', 'products?keyword=I18N&page=1&limit=20', [], 'vi-VN'));
$zh = $pick($api('GET', 'products?keyword=I18N&page=1&limit=20', [], 'zh-CN'));
$en = $pick($api('GET', 'products?keyword=I18N&page=1&limit=20', [], 'en-US'));
t_assert($vi && $vi['store_name'] === 'Cải thìa I18N' && $vi['unit_name'] === 'Kg', 'list vi => original');
t_assert($zh && $zh['store_name'] === '小白菜' && $zh['unit_name'] === '公斤', 'list zh translated');
t_assert($en && $en['store_name'] === 'Baby bok choy' && $en['unit_name'] === 'kg', 'list en translated');
t_assert((float)$zh['price'] === 30000.0 && (float)$en['price'] === 30000.0, 'price unaffected by language');

// ===== 详情 + 规格 =====
$d = $api('GET', 'product/detail/883201', [], 'en-US')['data'];
t_assert($d['storeInfo']['store_name'] === 'Baby bok choy' && $d['storeInfo']['store_info'] === 'Rau sạch', 'detail en: name translated, missing intro falls back to vi');
t_assert($d['productAttr'][0]['attr_name'] === 'Weight' && $d['productAttr'][0]['attr_values'] === ['500g', '1kg'], 'detail en: attr name/values translated: ' . json_encode($d['productAttr'][0]['attr_values']));
t_assert(array_keys($d['productValue']) === ['500g', '1kg'] && $d['productValue']['1kg']['suk'] === '1kg' && $d['productValue']['1kg']['unique'] === $P['uniques']['b'], 'detail en: productValue keys localized and still match unique: ' . json_encode(array_keys($d['productValue'])));
$dz = $api('GET', 'product/detail/883201', [], 'zh-CN')['data'];
t_assert(array_keys($dz['productValue']) === ['半斤', '一斤'] && $dz['productAttr'][0]['attr_value'][1]['attr'] === '一斤', 'detail zh: attr_value display text translated');
$dv = $api('GET', 'product/detail/883201', [], 'vi-VN')['data'];
t_assert(array_keys($dv['productValue']) === ['a', 'b'], 'detail vi: original keys');

// ===== 分类 =====
$cid = (int)Db::name('store_category')->where('pid', 0)->value('id');
if ($cid) {
    $orig = Db::name('store_category')->where('id', $cid)->value('cate_name');
    $i18n->save('category', $cid, ['en-US' => ['cate_name' => 'Category EN']]);
    \crmeb\services\CacheService::delete('CATEGORY');
    $ut = VnFx::userToken($uid);
    $r = $api('GET', 'category', [], 'en-US');
    $names = array_column($r['data'], 'cate_name', 'id');
    t_assert(($names[$cid] ?? '') === 'Category EN', 'category tree name translated (en)');
    $r = $api('GET', 'category', [], 'vi-VN');
    t_assert((array_column($r['data'], 'cate_name', 'id')[$cid] ?? '') === $orig, 'category vi keeps original');
    $v1 = $api('GET', 'category_version', [], 'en-US')['data']['version'];
    $v2 = $api('GET', 'category_version', [], 'vi-VN')['data']['version'];
    t_assert($v1 !== $v2, 'category_version differs per language (client cache refresh)');
    $i18n->save('category', $cid, ['en-US' => ['cate_name' => '']]);
}

// ===== 购物车 + 订单快照 =====
$api('POST', 'cart/clear_all', ['x' => 1], 'en-US');
$r = $api('POST', 'cart/add', ['productId' => 883201, 'cartNum' => 2, 'uniqueId' => $P['uniques']['b']], 'en-US');
t_assert($r['status'] == 200, 'add to cart (en)');
$cartList = $api('GET', 'cart/list', [], 'en-US')['data']['valid'] ?? [];
t_assert(count($cartList) === 1 && $cartList[0]['productInfo']['store_name'] === 'Baby bok choy' && $cartList[0]['productInfo']['attrInfo']['suk'] === '1kg', 'cart shows en name & sku: ' . json_encode([$cartList[0]['productInfo']['store_name'] ?? null, $cartList[0]['productInfo']['attrInfo']['suk'] ?? null]));
$cartListZh = $api('GET', 'cart/list', [], 'zh-CN')['data']['valid'] ?? [];
t_assert($cartListZh[0]['productInfo']['store_name'] === '小白菜' && $cartListZh[0]['productInfo']['attrInfo']['suk'] === '一斤', 'same cart in zh');

$cartId = $cartList[0]['id'];
$r = $api('POST', 'order/confirm', ['cartId' => (string)$cartId, 'new' => 0, 'addressId' => $addrId], 'en-US');
$key = $r['data']['orderKey'] ?? '';
$r = $api('POST', "order/create/$key", ['addressId' => $addrId, 'payType' => 'offline', 'shipping_type' => 1, 'new' => 0], 'en-US');
t_assert($r['status'] == 200, 'create order in en: ' . json_encode($r, JSON_UNESCAPED_UNICODE));
$api('POST', 'order/pay', ['uni' => $r['data']['result']['orderId'], 'paytype' => 'offline'], 'en-US');   // 到付：标记 is_cod
$oid = (int)Db::name('store_order')->where('unique', $key)->value('id');
$snap = json_decode(Db::name('store_order_cart_info')->where('oid', $oid)->value('cart_info'), true);
t_assert($snap['productInfo']['store_name'] === 'Baby bok choy' && $snap['productInfo']['attrInfo']['suk'] === '1kg', 'order snapshot stores order-language (en) name & sku');

// 订单创建后修改译文：已下订单详情仍显示快照语言
$i18n->save('product', 883201, ['en-US' => ['store_name' => 'RENAMED']]);
$od = $api('GET', "order/detail/$key", [], 'zh-CN')['data'];
t_assert($od['cartInfo'][0]['productInfo']['store_name'] === 'Baby bok choy', 'existing order keeps snapshot language even after translation edit and UI language switch');

// 后台打印：按所选语言重取（快照作兜底）
$print = VnFx::http('GET', "$B/adminapi/order/cod/print_data?ids=$oid&lang=zh-CN", $at);
t_assert($print['status'] == 200 && $print['data'][0]['goods'][0]['name'] === '小白菜', 'print zh re-fetches current zh name: ' . json_encode($print['data'][0]['goods'][0] ?? $print));
$print = VnFx::http('GET', "$B/adminapi/order/cod/print_data?ids=$oid&lang=en-US", $at);
t_assert($print['data'][0]['goods'][0]['name'] === 'RENAMED', 'print en re-fetches current en name, got ' . json_encode($print['data'][0]['goods'][0]['name'] ?? $print, JSON_UNESCAPED_UNICODE));
$print = VnFx::http('GET', "$B/adminapi/order/cod/print_data?ids=$oid&lang=both", $at);
t_assert($print['data'][0]['goods'][0]['name'] === 'Cải thìa I18N' && $print['data'][0]['goods'][0]['name_zh'] === '小白菜', 'print both: vi name + zh name, got ' . json_encode($print['data'][0]['goods'] ?? $print, JSON_UNESCAPED_UNICODE));
$i18n->save('product', 883201, ['en-US' => ['store_name' => 'Baby bok choy']]);

// ===== 机翻待审开关 =====
$i18n->save('product', 883201, ['en-US' => ['store_info' => 'Clean veg (machine)']], 0);
$en = $api('GET', 'product/detail/883201', [], 'en-US')['data']['storeInfo'];
t_assert($en['store_info'] === 'Clean veg (machine)', 'pending machine text shown by default');
$setCfg('i18n_show_pending_machine', 0);
$ut = VnFx::userToken($uid);
$en = $api('GET', 'product/detail/883201', [], 'en-US')['data']['storeInfo'];
t_assert($en['store_info'] === 'Rau sạch', 'pending machine hidden when switch is off => falls back to vi: ' . $en['store_info']);
$setCfg('i18n_show_pending_machine', 1);

// 清理
foreach (Db::name('store_order')->where('uid', $uid)->column('id') as $o) { VnFx::dropOrder((int)$o); }
Db::name('i18n_content')->where('entity_id', 'in', array_merge([883201, 883301, $cid ?: 0], [$attrId]))->whereIn('entity_type', ['product', 'category', 'product_attr', 'sku'])->delete();
VnFx::dropProduct(883201);
Db::name('user_address')->where('uid', $uid)->delete();
Db::name('store_cart')->where('uid', $uid)->delete();
$setCfg('order_rate_limit_per_hour', 5);
t_done();
