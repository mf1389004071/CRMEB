<?php
// M8：国际手机号（PhoneServices）、地址保存（国别/区划/区号）、配送区域一致性
require __DIR__ . '/bootstrap.php';
require __DIR__ . '/Fixtures.php';

use think\facade\Db;
use app\services\user\PhoneServices;

$B = VnFx::base();
$HN = 910001; $BD = 911001; $PX = 912001; $HCM = 910002; $Q1 = 911011;

// ---- PhoneServices ----
t_assert(PhoneServices::clean(' +84 (0912)-345.678 ') === '+840912345678', 'clean keeps leading + only');
t_assert(PhoneServices::normalize('+84', '+84 0912-345-678')['national'] === '912345678', 'M8-5: +84 0912-345-678 => 912345678');
t_assert(PhoneServices::normalize('+84', '0912345678')['e164'] === '+84912345678', 'local 0-leading => e164');
t_assert(PhoneServices::normalize('+84', '912345678')['e164'] === '+84912345678', 'no trunk prefix => same e164');
t_assert(PhoneServices::normalize('84', '84912345678')['e164'] === '+84912345678', 'digits already carrying country code stripped');
t_assert(PhoneServices::normalize('+84', '0084912345678')['e164'] === '+84912345678', '00 international prefix');
t_assert(PhoneServices::normalize('+86', '138 0000 1111')['e164'] === '+8613800001111', 'CN number');
$bad = function ($cc, $raw) { try { PhoneServices::validate($cc, $raw); return false; } catch (\Throwable $e) { return true; } };
t_assert(PhoneServices::validate('+84', '0912-345-678') === true, 'VN 9-digit ok');
t_assert(PhoneServices::validate('+84', '0243 123 4567') === true, 'VN 10-digit (landline style) ok');
t_assert($bad('+84', '09123456') && $bad('+84', '091234567890'), 'M8-5: VN too short/long rejected');
t_assert($bad('+84', '') && $bad('+84', 'abcdefghi'), 'empty/non-digits rejected');
t_assert(PhoneServices::validate('+86', '13800001111') === true, 'M8-5: +86 11 digits ok');
t_assert($bad('+86', '2380000111') && $bad('+86', '1380000111'), 'CN wrong pattern/length rejected');
t_assert(check_phone_intl('+84', '0912345678') === true && check_phone_intl('+84', '123') === false, 'check_phone_intl wrapper');

// ---- 区号字典接口 ----
$r = VnFx::http('GET', "$B/api/phone/countries", '', [], ['Cb-lang: vi-VN']);
t_assert($r['status'] == 200 && $r['data'][0]['code'] === '+84' && $r['data'][0]['name'] === 'Việt Nam' && $r['data'][1]['code'] === '+86', 'phone/countries localized');
$r = VnFx::http('GET', "$B/api/phone/countries", '', [], ['Cb-lang: en-US']);
t_assert($r['data'][0]['name'] === 'Vietnam', 'phone/countries in English');

// ---- 地址 ----
$uid = VnFx::user();
$ut = VnFx::userToken($uid);
Db::name('user_address')->where('uid', $uid)->delete();
$save = function (array $d) use ($B, $ut) { return VnFx::http('POST', "$B/api/address/edit", $ut, $d, ['Cb-lang: vi-VN']); };
$r = $save(['real_name' => 'Lê Thị Hoa', 'phone' => '0912-345-678', 'phone_country_code' => '+84', 'city_id' => $PX, 'detail' => 'Số 1 Hùng Vương', 'is_default' => true]);
t_assert($r['status'] == 200 && !empty($r['data']['id']), 'save VN address: ' . json_encode($r, JSON_UNESCAPED_UNICODE));
$id = $r['data']['id'] ?? 0;
$row = Db::name('user_address')->where('id', $id)->find();
t_assert($row['phone'] === '912345678' && $row['phone_country_code'] === '+84' && $row['country_code'] === 'VN', 'phone stored normalized + country_code');
t_assert($row['province'] === 'Hà Nội' && $row['city'] === 'Ba Đình' && $row['district'] === 'Phúc Xá' && $row['ward'] === 'Phúc Xá' && (int)$row['city_id'] === $PX, 'text derived from region chain (client text ignored): ' . json_encode([$row['province'], $row['city'], $row['district'], $row['ward']], JSON_UNESCAPED_UNICODE));
t_assert($row['is_default'] == 1, 'first address becomes default');

// 客户端伪造的省市区文本被忽略
$r = $save(['real_name' => 'X', 'phone' => '0912345679', 'phone_country_code' => '+84', 'city_id' => $Q1, 'address' => ['province' => 'HACK', 'city' => 'HACK', 'district' => 'HACK'], 'detail' => 'abc']);
$row2 = Db::name('user_address')->where('id', $r['data']['id'] ?? 0)->find();
t_assert($row2 && $row2['province'] === 'TP. Hồ Chí Minh' && $row2['city'] === 'Quận 1' && $row2['district'] === '', 'forged text ignored, derived from city_id; level-1 node has empty district');

// 校验
foreach ([
    ['bad phone', ['real_name' => 'A', 'phone' => '12345', 'phone_country_code' => '+84', 'city_id' => $PX, 'detail' => 'x']],
    ['no detail', ['real_name' => 'A', 'phone' => '0912345670', 'phone_country_code' => '+84', 'city_id' => $PX, 'detail' => '']],
    ['no name', ['real_name' => '', 'phone' => '0912345670', 'phone_country_code' => '+84', 'city_id' => $PX, 'detail' => 'x']],
    ['unknown city', ['real_name' => 'A', 'phone' => '0912345670', 'phone_country_code' => '+84', 'city_id' => 99999999, 'detail' => 'x']],
    ['country root as city', ['real_name' => 'A', 'phone' => '0912345670', 'phone_country_code' => '+84', 'city_id' => 900002, 'detail' => 'x']],
    ['cn phone under +84', ['real_name' => 'A', 'phone' => '13800001111x', 'phone_country_code' => '+84', 'city_id' => $PX, 'detail' => 'x']],
] as [$name, $d]) {
    $r = $save($d);
    t_assert($r['status'] != 200, "address validation: $name rejected (" . ($r['msg'] ?? '') . ')');
}
$r = $save(['real_name' => 'Lê Thị Hoa', 'phone' => '0912345678', 'phone_country_code' => '+84', 'city_id' => $PX, 'detail' => 'Số 1 Hùng Vương']);
t_assert($r['status'] != 200, 'duplicate address rejected');

// 修改
$r = $save(['id' => $id, 'real_name' => 'Lê Thị Hoa B', 'phone' => '+84 912 345 000', 'phone_country_code' => '+84', 'city_id' => $BD, 'detail' => 'Số 2']);
$row = Db::name('user_address')->where('id', $id)->find();
t_assert($r['status'] == 200 && $row['real_name'] === 'Lê Thị Hoa B' && $row['phone'] === '912345000' && $row['ward'] === '' && $row['district'] === '', 'edit address (moved to district-level node)');

// 列表返回新字段
$r = VnFx::http('GET', "$B/api/address/list", $ut, [], ['Cb-lang: vi-VN']);
t_assert($r['status'] == 200 && isset($r['data'][0]['phone_country_code']) && isset($r['data'][0]['ward']) && isset($r['data'][0]['country_code']), 'address list exposes new fields');

// 中国号码地址（CN 区划节点，+86）
Db::name('system_city')->where('city_id', 3)->update(['is_open' => 0]);
$r = $save(['real_name' => '张三', 'phone' => '13800001111', 'phone_country_code' => '+86', 'city_id' => 3, 'detail' => '长安街1号']);
$rowCn = Db::name('user_address')->where('id', $r['data']['id'] ?? 0)->find();
t_assert($r['status'] == 200 && $rowCn['province'] === '北京市' && $rowCn['district'] === '东城区' && $rowCn['country_code'] === 'CN', 'CN address still supported (old data model)');

// ---- 配送区域一致性（下单）----
$addrVn = $id;   // 当前在 Ba Đình（Hà Nội 下）
$addrHcm = Db::name('user_address')->where('id', $row2['id'])->value('id');   // TP.HCM Quận 1
$pr = VnFx::product(882001, 'Addr-Item', [['suk' => '默认', 'price' => 5000, 'stock' => 20]]);
foreach ([$HN, $HCM] as $city) {
    Db::name('store_product_region_price')->insert(['product_id' => 882001, 'unique' => $pr['uniques']['默认'], 'city_id' => $city, 'price' => 5000, 'ot_price' => 0, 'stock' => null, 'status' => 1, 'add_time' => time(), 'update_time' => time()]);
}
\app\services\product\RegionPriceServices::class;
app()->make(\app\services\product\RegionPriceServices::class)->flush(882001);
$order = function (int $region, int $addr) use ($B, $ut, $pr) {
    $h = ['Cb-region: ' . $region, 'Cb-lang: vi-VN'];
    $r = VnFx::http('POST', "$B/api/cart/add", $ut, ['productId' => 882001, 'cartNum' => 1, 'uniqueId' => $pr['uniques']['默认'], 'new' => 1], $h);
    $cid = $r['data']['cartId'] ?? 0;
    $r = VnFx::http('POST', "$B/api/order/confirm", $ut, ['cartId' => (string)$cid, 'new' => 1, 'addressId' => $addr], $h);
    $key = $r['data']['orderKey'] ?? '';
    return [VnFx::http('POST', "$B/api/order/create/$key", $ut, ['addressId' => $addr, 'payType' => 'offline', 'shipping_type' => 1, 'new' => 1], $h), $key];
};
// 提高限频阈值避免干扰
Db::name('system_config')->where('menu_name', 'order_rate_limit_per_hour')->update(['value' => '"50"']);
\crmeb\services\CacheService::clear();
$ut = VnFx::userToken($uid);
[$r, $k] = $order($HN, $addrHcm);
t_assert($r['status'] != 200 && strpos($r['msg'] ?? '', 'khu vực') !== false, 'address in HCM while region=Hà Nội rejected: ' . ($r['msg'] ?? ''));
[$r, $k] = $order($HN, $addrVn);
t_assert($r['status'] == 200, 'address inside region accepted: ' . json_encode($r, JSON_UNESCAPED_UNICODE));
$o = Db::name('store_order')->where('unique', $k)->find();
t_assert($o && $o['user_phone'] === '+84912345000' && strpos($o['user_address'], 'Hà Nội') !== false, 'order phone is E.164 and address text derived: ' . json_encode([$o['user_phone'] ?? null, $o['user_address'] ?? null], JSON_UNESCAPED_UNICODE));
[$r, $k] = $order($HCM, $addrHcm);
t_assert($r['status'] == 200, 'region HCM + HCM address accepted');

// 清理
foreach (Db::name('store_order')->where('uid', $uid)->column('id') as $oid) { VnFx::dropOrder((int)$oid); }
VnFx::dropProduct(882001);
Db::name('user_address')->where('uid', $uid)->delete();
Db::name('store_cart')->where('uid', $uid)->delete();
Db::name('system_config')->where('menu_name', 'order_rate_limit_per_hour')->update(['value' => '"5"']);
\crmeb\services\CacheService::clear();
t_done();
