<?php
// M2-7 验收（HTTP 真实接口）：区域价 13 项
require __DIR__ . '/bootstrap.php';
require __DIR__ . '/Fixtures.php';

use think\facade\Db;
use app\services\product\RegionPriceServices;

$B = VnFx::base();
$HN = 910001; $BD = 911001; $HK = 911002; $TH = 910005; $VN = 900002;
$uid = VnFx::user();
$addrId = VnFx::address($uid);
$setCfg = function (string $k, $v) {
    Db::name('system_config')->where('menu_name', $k)->update(['value' => json_encode((string)$v)]);
    \crmeb\services\CacheService::clear();
};
$setCfg('allow_national_price', 0);
$setCfg('region_pricing_enable', 1);
$setCfg('vn_mode_enable', 1);
$ut = VnFx::userToken($uid);   // CacheService::clear 会清登录态，必须在 clear 之后签发
$rps = app()->make(RegionPriceServices::class);

$clearProducts = function () {
    foreach ([881101, 881102, 881103, 881104, 881105] as $pid) {
        Db::name('store_product_region_price')->where('product_id', $pid)->delete();
        VnFx::dropProduct($pid);
    }
};
$clearProducts();
$P = VnFx::product(881101, 'E2E-P', [['suk' => '默认', 'price' => 120, 'stock' => 50]]);
$Q = VnFx::product(881102, 'E2E-Q', [['suk' => 'a', 'price' => 60, 'stock' => 50], ['suk' => 'b', 'price' => 70, 'stock' => 50]]);
$R = VnFx::product(881103, 'E2E-R', [['suk' => '默认', 'price' => 10, 'stock' => 50]]);
$S = VnFx::product(881104, 'E2E-S', [['suk' => '默认', 'price' => 500, 'stock' => 50]]);
$T = VnFx::product(881105, 'E2E-T', [['suk' => '默认', 'price' => 70, 'stock' => 50]]);
$pu = $P['uniques']['默认'];
$qa = $Q['uniques']['a'];
$qb = $Q['uniques']['b'];
$price = function ($pid, $unique, $city, $p, $stock = null) {
    Db::name('store_product_region_price')->insert(['product_id' => $pid, 'unique' => $unique, 'city_id' => $city, 'price' => $p, 'ot_price' => 0, 'stock' => $stock, 'status' => 1, 'add_time' => time(), 'update_time' => time()]);
    app()->make(RegionPriceServices::class)->flush($pid);
};
$H = function (int $region) { return $region ? ['Cb-region: ' . $region, 'Cb-lang: vi-VN'] : ['Cb-lang: vi-VN']; };
$api = function (string $method, string $path, array $data = [], int $region = 0, string $token = '') use ($B, $H, &$ut) {
    return VnFx::http($method, "$B/api/$path", $token === '' ? $ut : $token, $data, $H($region));
};
$listPrice = function (int $region, int $pid) use ($api) {
    $r = $api('GET', 'products?keyword=E2E&page=1&limit=50', [], $region);
    foreach ($r['data'] ?? [] as $it) {
        if ((int)$it['id'] === $pid) {
            return $it['price'];
        }
    }
    return null;
};
$clearCart = function () use ($api) { $api('POST', 'cart/clear_all', ['x' => 1]); };

// ===== #1 #2 价格一致性：列表/详情/规格实时价/购物车/确认订单 =====
$price(881101, $pu, $HN, 100);
$price(881101, $pu, $BD, 90);
t_assert((float)$listPrice($BD, 881101) === 90.0, '#1 list price at Ba Đình = 90, got ' . json_encode($listPrice($BD, 881101)));
$r = $api('GET', 'product/detail/881101', [], $BD);
t_assert($r['status'] == 200 && (float)$r['data']['storeInfo']['price'] === 90.0, '#1 detail price = 90: ' . substr(json_encode($r, JSON_UNESCAPED_UNICODE), 0, 160));
$r = $api('GET', "product/real_price/881101/$pu", [], $BD);
t_assert($r['status'] == 200 && (float)($r['data']['price'] ?? $r['data']['realPrice'] ?? 0) === 90.0, '#1 real_price = 90: ' . substr(json_encode($r['data'] ?? $r, JSON_UNESCAPED_UNICODE), 0, 160));
$clearCart();
$r = $api('POST', 'cart/add', ['productId' => 881101, 'cartNum' => 2, 'uniqueId' => $pu], $BD);
t_assert($r['status'] == 200, '#1 add to cart: ' . json_encode($r, JSON_UNESCAPED_UNICODE));
$cartId = $r['data']['cartId'] ?? 0;
$r = $api('GET', 'cart/list', [], $BD);
$line = null;
foreach ($r['data']['valid'] ?? [] as $v) { if ((int)$v['product_id'] === 881101) $line = $v; }
t_assert($line && (float)$line['truePrice'] === 90.0 && (float)$line['sum_price'] === 90.0, '#1 cart line price=90: ' . json_encode($line ? [$line['truePrice'], $line['sum_price']] : $r));
$r = $api('POST', 'order/confirm', ['cartId' => (string)$cartId, 'new' => 0, 'addressId' => $addrId], $BD);
t_assert($r['status'] == 200 && (float)$r['data']['priceGroup']['totalPrice'] === 180.0, '#1 confirm total = 90*2: ' . json_encode($r['data']['priceGroup'] ?? $r));
$key1 = $r['data']['orderKey'] ?? '';
$r = $api('POST', "order/create/$key1", ['addressId' => $addrId, 'payType' => 'offline', 'shipping_type' => 1, 'new' => 0, 'price' => 1, 'truePrice' => 1, 'pay_price' => 1], $BD);
t_assert($r['status'] == 200, '#1/#9 create order ok (extra price fields ignored): ' . json_encode($r, JSON_UNESCAPED_UNICODE));
$o = Db::name('store_order')->where('unique', $key1)->find();
t_assert($o && (float)$o['total_price'] === 180.0 && (float)$o['pay_price'] === 180.0 && (int)$o['region_id'] === $BD, '#1/#9 order amount = server price 180, region_id=BD');
$info = Db::name('store_order_cart_info')->where('oid', $o['id'])->find();
t_assert((float)json_decode($info['cart_info'], true)['truePrice'] === 90.0, '#1 order snapshot truePrice=90');

// #2 Hà Nội = 100
$clearCart();
t_assert((float)$listPrice($HN, 881101) === 100.0, '#2 list price at Hà Nội = 100');
$r = $api('POST', 'cart/add', ['productId' => 881101, 'cartNum' => 1, 'uniqueId' => $pu], $HN);
$r = $api('GET', 'cart/list', [], $HN);
$line = null;
foreach ($r['data']['valid'] ?? [] as $v) { if ((int)$v['product_id'] === 881101) $line = $v; }
t_assert($line && (float)$line['truePrice'] === 100.0, '#2 cart price at Hà Nội = 100');

// ===== #3 Thanh Hóa 不展示 =====
t_assert($listPrice($TH, 881101) === null, '#3 P not listed in Thanh Hóa');
$r = $api('GET', 'product/detail/881101', [], $TH);
t_assert($r['status'] != 200, '#3 detail rejected in Thanh Hóa: ' . ($r['msg'] ?? ''));
t_assert(strpos($r['msg'] ?? '', 'vực') !== false, '#3 error message in Vietnamese: ' . ($r['msg'] ?? ''));
$r = $api('POST', 'cart/add', ['productId' => 881101, 'cartNum' => 1, 'uniqueId' => $pu], $TH);
t_assert($r['status'] != 200, '#3 add to cart rejected in Thanh Hóa');

// ===== #4 仅国家层价 80 =====
Db::name('store_product_region_price')->where('product_id', 881101)->delete();
$rps->flush(881101);
$price(881101, $pu, $VN, 80);
t_assert((float)$listPrice($BD, 881101) === 80.0, '#4 country-level price flows down to Ba Đình');

// ===== #5 Q：a 在 Hà Nội 50，b 无价 =====
$price(881102, $qa, $HN, 50);
t_assert((float)$listPrice($HN, 881102) === 50.0, '#5 list price = 50');
$r = $api('GET', 'product/detail/881102', [], $HN);
$sukKeys = array_keys($r['data']['productValue'] ?? []);
t_assert($r['status'] == 200 && $sukKeys === ['a'], '#5 detail only sku a: ' . json_encode($sukKeys));
$attrVals = $r['data']['productAttr'][0]['attr_values'] ?? [];
t_assert($attrVals === ['a'], '#5 attr option b hidden: ' . json_encode($attrVals));
$r = $api('POST', 'cart/add', ['productId' => 881102, 'cartNum' => 1, 'uniqueId' => $qb], $HN);
t_assert($r['status'] != 200, '#5 sku b cannot be added');
$r = $api('GET', "product/real_price/881102/$qb", [], $HN);
t_assert($r['status'] != 200, '#5 real_price of sku b rejected');

// ===== #6 不借兄弟区价 =====
Db::name('store_product_region_price')->where('product_id', 881101)->delete();
$rps->flush(881101);
$price(881101, $pu, $BD, 90);
$price(881101, $pu, $HK, 70);
t_assert((float)$listPrice($HK, 881101) === 70.0 && (float)$listPrice($BD, 881101) === 90.0, '#6 siblings keep own price');
$r = $api('POST', 'cart/add', ['productId' => 881101, 'cartNum' => 1, 'uniqueId' => $pu], 911003);   // Đống Đa 无价
t_assert($r['status'] != 200 && $listPrice(911003, 881101) === null, '#6 third sibling (Đống Đa) unsellable');

// ===== #7 允许全国价 =====
Db::name('store_product_region_price')->where('product_id', 881101)->delete();
$rps->flush(881101);
$setCfg('allow_national_price', 1);
$ut = VnFx::userToken($uid);
Db::name('store_product')->where('id', 881101)->update(['allow_national_price' => 1]);
$rps->flush(881101);
t_assert((float)$listPrice($TH, 881101) === 120.0, '#7 national base price 120 in Thanh Hóa when allowed');
Db::name('store_product')->where('id', 881101)->update(['allow_national_price' => 0]);
$setCfg('allow_national_price', 0);
$ut = VnFx::userToken($uid);
$rps->flush(881101);

// ===== #8 切换区域：清车 =====
$price(881101, $pu, $HN, 100);
$price(881101, $pu, $BD, 90);
$api('POST', 'cart/add', ['productId' => 881101, 'cartNum' => 1, 'uniqueId' => $pu], $BD);
$r = $api('POST', 'cart/clear_all', ['x' => 1], $HN);
t_assert($r['status'] == 200, '#8 cart/clear_all');
$r = $api('GET', 'cart/list', [], $HN);
t_assert(count($r['data']['valid'] ?? []) === 0 && count($r['data']['invalid'] ?? []) === 0, '#8 cart empty after clear');
t_assert((float)$listPrice($HN, 881101) === 100.0, '#8 prices refresh for the new region');

// ===== #9 切区后下单被拒（缓存价 vs 当前区价）=====
$api('POST', 'cart/clear_all', ['x' => 1]);
$r = $api('POST', 'cart/add', ['productId' => 881101, 'cartNum' => 1, 'uniqueId' => $pu], $BD);
$cid = $r['data']['cartId'];
$r = $api('POST', 'order/confirm', ['cartId' => (string)$cid, 'new' => 0, 'addressId' => $addrId], $BD);
$keyX = $r['data']['orderKey'];
$r = $api('POST', "order/create/$keyX", ['addressId' => $addrId, 'payType' => 'offline', 'shipping_type' => 1, 'new' => 0], $HN);   // 用 Hà Nội 区域头下单
t_assert($r['status'] != 200, '#9 order confirmed at BD but created under HN is rejected: ' . ($r['msg'] ?? ''));
t_assert(!Db::name('store_order')->where('unique', $keyX)->count(), '#9 no order row created');

// ===== #10 区域库存 =====
Db::name('store_product_region_price')->where('product_id', 881103)->delete();
$price(881103, $R['uniques']['默认'], $HN, 300, 3);
$api('POST', 'cart/clear_all', ['x' => 1]);
$r = $api('POST', 'cart/add', ['productId' => 881103, 'cartNum' => 5, 'uniqueId' => $R['uniques']['默认']], $HN);
t_assert($r['status'] != 200, '#10 5 > region stock 3 rejected: ' . ($r['msg'] ?? ''));
$r = $api('POST', 'cart/add', ['productId' => 881103, 'cartNum' => 2, 'uniqueId' => $R['uniques']['默认']], $HN);
$cid = $r['data']['cartId'] ?? 0;
$r = $api('POST', 'order/confirm', ['cartId' => (string)$cid, 'new' => 0, 'addressId' => $addrId], $HN);
$key10 = $r['data']['orderKey'] ?? '';
$r = $api('POST', "order/create/$key10", ['addressId' => $addrId, 'payType' => 'offline', 'shipping_type' => 1, 'new' => 0], $HN);
t_assert($r['status'] == 200, '#10 order of 2 created: ' . json_encode($r, JSON_UNESCAPED_UNICODE));
$rowStock = (int)Db::name('store_product_region_price')->where(['product_id' => 881103, 'city_id' => $HN])->value('stock');
t_assert($rowStock === 1, '#10 region stock deducted 3 -> 1, got ' . $rowStock);
t_assert((int)Db::name('store_product_attr_value')->where('product_id', 881103)->value('stock') === 50, '#10 main sku stock untouched (50)');
t_assert((int)Db::name('store_product_attr_value')->where('product_id', 881103)->value('sales') === 2, '#10 sku sales +2');
// 取消订单 => 区域库存回退
$o10 = Db::name('store_order')->where('unique', $key10)->find();
$r = $api('POST', 'order/cancel', ['id' => $o10['order_id']], $HN);
$rowStock = (int)Db::name('store_product_region_price')->where(['product_id' => 881103, 'city_id' => $HN])->value('stock');
t_assert($r['status'] == 200 && $rowStock === 3, '#10 cancel restores region stock to 3: ' . json_encode($r, JSON_UNESCAPED_UNICODE) . ' stock=' . $rowStock);
t_assert((int)Db::name('store_product_attr_value')->where('product_id', 881103)->value('sales') === 0, '#10 sku sales restored');

// ===== #11 价格排序（区域价，内存排序后分页）=====
Db::name('store_product_region_price')->whereIn('product_id', [881103, 881104, 881105])->delete();
$price(881103, $R['uniques']['默认'], $HN, 300);   // 主表 10
$price(881104, $S['uniques']['默认'], $HN, 20);    // 主表 500
$price(881105, $T['uniques']['默认'], $HN, 100);   // 主表 70
$sorted = function (string $order, int $page, int $limit) use ($api, $HN) {
    $r = $api('GET', "products?keyword=E2E&priceOrder=$order&page=$page&limit=$limit", [], $HN);
    return array_values(array_filter(array_map(function ($i) { return in_array((int)$i['id'], [881103, 881104, 881105], true) ? (int)$i['id'] : null; }, $r['data'] ?? [])));
};
t_assert($sorted('asc', 1, 50) === [881104, 881105, 881103], '#11 asc by region price: ' . json_encode($sorted('asc', 1, 50)));
t_assert($sorted('desc', 1, 50) === [881103, 881105, 881104], '#11 desc by region price');
$p1 = $api('GET', 'products?keyword=E2E-&priceOrder=asc&page=1&limit=2', [], $HN)['data'];
$p2 = $api('GET', 'products?keyword=E2E-&priceOrder=asc&page=2&limit=2', [], $HN)['data'];
$prices1 = array_map('floatval', array_column($p1, 'price'));
$prices2 = array_map('floatval', array_column($p2, 'price'));
$all = array_merge($prices1, $prices2);
$sortedAll = $all;
sort($sortedAll);
t_assert($all === $sortedAll && count($p1) === 2, '#11 pagination preserves global price order: ' . json_encode($all));

// ===== #12 未选区域 =====
$r = $api('GET', 'products?keyword=E2E', [], 0);
t_assert($r['status'] == 200 && ($r['region_required'] ?? false) === true && $r['data'] === [], '#12 list without region => region_required=true & empty');
$r = $api('GET', 'products?keyword=E2E', [], 1);   // 未开放节点（北京）按未选处理
t_assert(($r['region_required'] ?? false) === true, '#12 closed/forged region treated as not selected');
$r = $api('GET', 'product/detail/881101', [], 0);
t_assert($r['status'] != 200 && strpos($r['msg'] ?? '', 'vực') !== false, '#12 detail without region rejected');
$r = $api('GET', 'product/hot', [], 0);
t_assert(($r['region_required'] ?? false) === true, '#12 product/hot region_required');

// ===== #13 region_pricing_enable=0：行为同原版 =====
$setCfg('region_pricing_enable', 0);
$ut = VnFx::userToken($uid);
$r = $api('GET', 'products?keyword=E2E-&page=1&limit=50', [], 0);
$byId = array_column($r['data'] ?? [], 'price', 'id');
t_assert(($r['region_required'] ?? false) === false && (float)($byId[881103] ?? 0) === 10.0 && (float)($byId[881104] ?? 0) === 500.0, '#13 switch off => base prices, no region filtering: ' . json_encode($byId));
$r = $api('GET', 'product/detail/881101', [], 0);
t_assert($r['status'] == 200 && (float)$r['data']['storeInfo']['price'] === 120.0, '#13 detail shows base price 120');
$setCfg('region_pricing_enable', 1);

// ===== #9 其它出口：收藏列表按区域价展示 =====
Db::name('store_product_relation')->where('uid', $uid)->delete();
Db::name('store_product_relation')->insert(['uid' => $uid, 'product_id' => 881104, 'type' => 'collect', 'category' => 'product', 'add_time' => time()]);
Db::name('store_product_relation')->insert(['uid' => $uid, 'product_id' => 881101, 'type' => 'collect', 'category' => 'product', 'add_time' => time()]);
$r = $api('GET', 'collect/user?page=1&limit=20', [], $HN);
$byPid = [];
foreach ($r['data']['list'] ?? [] as $it) { $byPid[$it['pid']] = $it; }
t_assert($r['status'] == 200 && (float)$byPid[881104]['price'] === 20.0, '#9 collect list shows region price 20 (main 500): ' . json_encode(array_map(function ($i) { return $i['price']; }, $byPid)));
$r = $api('GET', 'collect/user?page=1&limit=20', [], $TH);
$byPid = [];
foreach ($r['data']['list'] ?? [] as $it) { $byPid[$it['pid']] = $it; }
t_assert(!empty($byPid[881104]['is_fail']), '#9 collect list marks region-unsellable item as failed in Thanh Hóa');
Db::name('store_product_relation')->where('uid', $uid)->delete();

// 清理
foreach (Db::name('store_order')->where('uid', $uid)->column('id') as $oid) { VnFx::dropOrder((int)$oid); }
$clearProducts();
Db::name('user_address')->where('uid', $uid)->delete();
Db::name('store_cart')->where('uid', $uid)->delete();
\crmeb\services\CacheService::clear();
t_done();
