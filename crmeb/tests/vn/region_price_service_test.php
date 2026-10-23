<?php
// M2-2/M2-3 RegionPriceServices：取价规则（M2-7 验收表 1~7、10 的服务层部分）
require __DIR__ . '/bootstrap.php';
require __DIR__ . '/Fixtures.php';

use think\facade\Db;
use app\services\product\RegionPriceServices;
use app\model\product\product\StoreProduct;

/** @var RegionPriceServices $rps */
$rps = app()->make(RegionPriceServices::class);
Db::name('store_product_region_price')->where('product_id', 'in', [881001, 881002])->delete();

$HN = 910001;      // Hà Nội（市）
$BD = 911001;      // Ba Đình（区，Hà Nội 下）
$HK = 911002;      // Hoàn Kiếm（区，Hà Nội 下，兄弟）
$TH = 910005;      // Thanh Hóa（市）
$VN = 900002;      // 国家根

$P = VnFx::product(881001, 'P-single', [['suk' => 'default', 'price' => 120, 'stock' => 10]]);
$Q = VnFx::product(881002, 'Q-multi', [['suk' => 'a', 'price' => 60, 'stock' => 10], ['suk' => 'b', 'price' => 70, 'stock' => 10]]);
$pu = $P['uniques']['default'];
$qa = $Q['uniques']['a'];
$qb = $Q['uniques']['b'];
$setPrice = function ($pid, $unique, $city, $price, $stock = null, $ot = 0) {
    Db::name('store_product_region_price')->insert(['product_id' => $pid, 'unique' => $unique, 'city_id' => $city, 'price' => $price, 'ot_price' => $ot, 'stock' => $stock, 'status' => 1, 'add_time' => time(), 'update_time' => time()]);
    app()->make(RegionPriceServices::class)->flush($pid);
};
$clear = function () {
    Db::name('store_product_region_price')->where('product_id', 'in', [881001, 881002])->delete();
    app()->make(RegionPriceServices::class)->flush(881001);
    app()->make(RegionPriceServices::class)->flush(881002);
};
$sysAllow = function (int $v) {
    Db::name('system_config')->where('menu_name', 'allow_national_price')->update(['value' => json_encode((string)$v)]);
    \crmeb\services\CacheService::clear();
};
$sysAllow(0);

// 1/2) P 在 Hà Nội 100、Ba Đình 90
$setPrice(881001, $pu, $HN, 100);
$setPrice(881001, $pu, $BD, 90);
t_assert($rps->resolveOne(881001, $pu, $BD)['price'] === '90.00', '#1 Ba Đình => 90');
t_assert($rps->resolveOne(881001, $pu, $HN)['price'] === '100.00', '#2 Hà Nội => 100');
// 3) Thanh Hóa 不展示
t_assert($rps->resolveOne(881001, $pu, $TH) === null, '#3 Thanh Hóa unsellable (no national)');
$list = $rps->applyToList([['id' => 881001, 'price' => '120', 'ot_price' => '120', 'stock' => 10], ['id' => 881002, 'price' => '60', 'ot_price' => '60', 'stock' => 20]], $TH);
t_assert($list === [], '#3 list excludes both products in Thanh Hóa');
// 4) 仅国家层价 80
$clear();
$setPrice(881001, $pu, $VN, 80);
t_assert($rps->resolveOne(881001, $pu, $BD)['price'] === '80.00' && $rps->resolveOne(881001, $pu, $BD)['from_city_id'] === $VN, '#4 falls up to country price 80');
t_assert($rps->resolveOne(881001, $pu, $TH)['price'] === '80.00', '#4 country price applies to Thanh Hóa too');
// 5) Q：a 在 Hà Nội 50，b 无价
$clear();
$setPrice(881002, $qa, $HN, 50);
$vals = ['a' => ['unique' => $qa, 'price' => '60', 'stock' => 10], 'b' => ['unique' => $qb, 'price' => '70', 'stock' => 10]];
$applied = $rps->applyToAttr(881002, $vals, $HN);
t_assert(array_keys($applied) === ['a'] && $applied['a']['price'] === '50.00', '#5 only sku a sellable at 50');
$l = $rps->applyToList([['id' => 881002, 'price' => '60', 'ot_price' => '60', 'stock' => 20]], $HN);
t_assert(count($l) === 1 && $l[0]['price'] === '50.00' && $l[0]['stock'] === 10, '#5 list price=50, stock only counts sellable sku: ' . json_encode($l));
// 6) 不借兄弟区价
$clear();
$setPrice(881001, $pu, $BD, 90);
$setPrice(881001, $pu, $HK, 70);
t_assert($rps->resolveOne(881001, $pu, $HK)['price'] === '70.00' && $rps->resolveOne(881001, $pu, $BD)['price'] === '90.00', '#6 siblings keep own price');
$clear();
$setPrice(881001, $pu, $BD, 90);
t_assert($rps->resolveOne(881001, $pu, $HK) === null, '#6 no borrowing from sibling district');
// 7) 允许全国价
$clear();
t_assert($rps->resolveOne(881001, $pu, $TH) === null, '#7 precondition: unsellable');
$sysAllow(1);
t_assert($rps->resolveOne(881001, $pu, $TH) === null, '#7 system allow alone is not enough');
Db::name('store_product')->where('id', 881001)->update(['allow_national_price' => 1]);
$rps->flush(881001);
$r7 = $rps->resolveOne(881001, $pu, $TH);
t_assert($r7 && $r7['price'] === '120.00' && $r7['source'] === 'national', '#7 national price 120 when both switches on');
Db::name('store_product')->where('id', 881001)->update(['allow_national_price' => 0]);
$sysAllow(0);
$rps->flush(881001);

// 10) 区域库存
$clear();
$setPrice(881001, $pu, $HN, 100, 3);
$i = $rps->resolveOne(881001, $pu, $HN);
t_assert($i['stock'] === 3 && $i['stock_row'] !== null, '#10 region stock=3 used instead of main 10');
$rps::withRegion($HN, function () use ($rps, $pu) {
    t_assert($rps->decRegionStock(881001, $pu, 5) === false, '#10 dec 5 > 3 fails');
    t_assert($rps->decRegionStock(881001, $pu, 2) === true, '#10 dec 2 ok');
    t_assert($rps->resolveOne(881001, $pu, 910001)['stock'] === 1, '#10 stock now 1 (live, not cached)');
    t_assert($rps->incRegionStock(881001, $pu, 2) === true && $rps->resolveOne(881001, $pu, 910001)['stock'] === 3, '#10 inc restores');
});
// 区域库存 NULL => 沿用主表
$clear();
$setPrice(881001, $pu, $HN, 100, null);
$rps::withRegion($HN, function () use ($rps, $pu) {
    t_assert($rps->decRegionStock(881001, $pu, 1) === null, 'null region stock => defer to main table');
});
Db::name('store_product_attr_value')->where('product_id', 881001)->update(['stock' => 4]);
t_assert($rps->resolveOne(881001, $pu, $HN)['stock'] === 4, 'null region stock follows live main stock');

// 状态=0 的价目不生效
$clear();
$setPrice(881001, $pu, $HN, 100);
Db::name('store_product_region_price')->where('product_id', 881001)->update(['status' => 0]);
$rps->flush(881001);
t_assert($rps->resolveOne(881001, $pu, $HN) === null, 'disabled price row ignored');

// visibleScope：真实 SQL
$clear();
$setPrice(881001, $pu, $HN, 100);
$setPrice(881002, $qa, $TH, 55);
$ids = function (int $city) use ($rps) {
    $q = StoreProduct::where('id', 'in', [881001, 881002]);
    $rps->visibleScope($q, $city);
    $r = $q->column('id');
    sort($r);
    return $r;
};
t_assert($ids($BD) === [881001], 'scope Ba Đình => only P: ' . json_encode($ids($BD)));
t_assert($ids($TH) === [881002], 'scope Thanh Hóa => only Q');
t_assert($ids($HN) === [881001], 'scope Hà Nội => only P');
$sysAllow(1);
Db::name('store_product')->where('id', 881002)->update(['allow_national_price' => 1]);
t_assert($ids($BD) === [881001, 881002], 'scope with national allowed includes Q');
Db::name('store_product')->where('id', 881002)->update(['allow_national_price' => 0]);
$sysAllow(0);

// 价格断言：下单校验
$clear();
$setPrice(881001, $pu, $HN, 100);
$cart = [['product_id' => 881001, 'cart_num' => 2, 'truePrice' => '100', 'productInfo' => ['id' => 881001, 'store_name' => 'P', 'attrInfo' => ['unique' => $pu]]]];
$threw = function (callable $f) { try { $f(); return ''; } catch (\Throwable $e) { return $e->getMessage() ?: 'x'; } };
t_assert($threw(function () use ($rps, $cart, $HN) { $rps->assertCartMatches($cart, $HN); }) === '', 'assertCartMatches passes with matching price');
$cart[0]['truePrice'] = '1';
t_assert($threw(function () use ($rps, $cart, $HN) { $rps->assertCartMatches($cart, $HN); }) !== '', 'tampered/stale price rejected');
$cart[0]['truePrice'] = '100';
t_assert($threw(function () use ($rps, $cart, $TH) { $rps->assertCartMatches($cart, $TH); }) !== '', 'unsellable region rejected');
t_assert($threw(function () use ($rps, $cart) { $rps->assertCartMatches($cart, 0); }) !== '', 'no region rejected');
$cart[0]['cart_num'] = 99;
t_assert($threw(function () use ($rps, $cart, $HN) { $rps->assertCartMatches($cart, $HN); }) !== '', 'over stock rejected');

$clear();
VnFx::dropProduct(881001);
VnFx::dropProduct(881002);
t_done();
