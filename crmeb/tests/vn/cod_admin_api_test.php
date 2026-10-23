<?php
// M3-5 后台/员工端到付接口 HTTP 联调测试。需先启动 HTTP 服务（见 README 测试一节，默认 host.docker.internal:8089）
require __DIR__ . '/bootstrap.php';

use think\facade\Db;

$base = getenv('VN_API_BASE') ?: 'http://host.docker.internal:8089';

function http($method, $url, $token = '', array $data = [])
{
    $ch = curl_init($url);
    curl_setopt_array($ch, [
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_TIMEOUT        => 60,
        CURLOPT_CUSTOMREQUEST  => $method,
        CURLOPT_HTTPHEADER     => array_filter(['Authori-zation: Bearer ' . $token, 'Content-Type: application/json', 'Cb-lang: vi-VN']),
    ]);
    if ($data) {
        curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($data));
    }
    $res = curl_exec($ch);
    $j = json_decode($res, true);
    return $j ?: ['status' => -1, 'raw' => $res];
}

/** @var \app\services\system\admin\SystemAdminServices $svc */
$svc = app()->make(\app\services\system\admin\SystemAdminServices::class);
$adminTok = $svc->createToken(1, 'admin', Db::name('system_admin')->where('id', 1)->value('pwd'))['token'];

// 夹具用户（orderOffline 记资金流水需要用户信息）
if (!Db::name('user')->where('uid', 7)->find()) {
    Db::name('user')->insert(['uid' => 7, 'account' => 'cod_t7', 'nickname' => 'CodT7', 'phone' => '0987654321', 'add_time' => time()]);
}
$pid = 880003;
$uniq = 'tst88003';
Db::name('store_product')->where('id', $pid)->delete();
Db::name('store_product_attr_value')->where('product_id', $pid)->delete();
Db::name('store_product')->insert(['id' => $pid, 'store_name' => 'api-test', 'price' => 50, 'stock' => 5, 'sales' => 0, 'is_show' => 1, 'is_del' => 0, 'add_time' => time()]);
Db::name('store_product_attr_value')->insert(['product_id' => $pid, 'suk' => 'default', 'stock' => 5, 'sales' => 0, 'price' => 50, 'unique' => $uniq, 'type' => 0]);

$ids = [];
function mkOrder($pid, $uniq, array $extra = [])
{
    static $n = 0;
    $n++;
    $orderId = 'cod_a_' . time() . '_' . $n;
    $cartId = 950000 + $n;
    $oid = Db::name('store_order')->insertGetId(array_merge([
        'order_id' => $orderId, 'uid' => 7, 'real_name' => 'Tran', 'user_phone' => '0987654321', 'user_address' => 'Ha Noi Ba Dinh',
        'cart_id' => json_encode([$cartId]), 'total_num' => 1, 'total_price' => 50, 'pay_price' => 50, 'paid' => 0, 'pay_type' => 'offline',
        'add_time' => time(), 'status' => 0, 'unique' => md5($orderId), 'mark' => '', 'is_cod' => 1, 'fulfil_status' => 1,
        'cod_receivable' => 50, 'cod_delivery_code' => (string)random_int(100000, 999999),
    ], $extra));
    Db::name('store_order_cart_info')->insert([
        'oid' => $oid, 'uid' => 7, 'cart_id' => $cartId, 'product_id' => $pid, 'cart_num' => 1, 'surplus_num' => 1,
        'cart_info' => json_encode(['cart_num' => 1, 'truePrice' => 50, 'productInfo' => ['id' => $pid, 'store_name' => 'api-test', 'attrInfo' => ['unique' => $uniq, 'suk' => 'default', 'price' => 50]]]),
        'unique' => md5($orderId . 'c'),
    ]);
    return $oid;
}

$a = mkOrder($pid, $uniq);
$b = mkOrder($pid, $uniq, ['fulfil_status' => 0]);
$ids = [$a, $b];

// 无 token 被拒
$r = http('GET', "$base/adminapi/order/cod/list");
t_assert($r['status'] != 200, 'list requires admin token');

$r = http('GET', "$base/adminapi/order/cod/list?limit=50", $adminTok);
t_assert($r['status'] == 200 && $r['data']['counts']['pending'] >= 1 && $r['data']['counts']['stockup'] >= 1, 'list counts: ' . json_encode($r['data']['counts'] ?? null));
$found = array_values(array_filter($r['data']['list'], function ($x) use ($a) { return $x['id'] == $a; }));
t_assert(count($found) === 1 && $found[0]['goods'][0]['name'] === 'api-test' && $found[0]['fulfil_key'] === 'cod_stockup', 'list item has goods & fulfil_key');
t_assert(!array_key_exists('cod_delivery_code', $found[0]), 'admin list does not expose delivery code');

$r = http('GET', "$base/adminapi/order/cod/list?fulfil_status=0&keyword=0987654321", $adminTok);
t_assert($r['status'] == 200 && count(array_filter($r['data']['list'], function ($x) use ($b) { return $x['id'] == $b; })) === 1, 'filter fulfil_status=0 + keyword');
$r = http('GET', "$base/adminapi/order/cod/list?fulfil_status=2", $adminTok);
t_assert(count(array_filter($r['data']['list'], function ($x) use ($a, $b) { return in_array($x['id'], [$a, $b]); })) === 0, 'filter excludes other states');

$r = http('POST', "$base/adminapi/order/cod/confirm/$b", $adminTok);
t_assert($r['status'] == 200 && Db::name('store_order')->where('id', $b)->value('fulfil_status') == 1, 'confirm via http');
$r = http('POST', "$base/adminapi/order/cod/confirm/$b", $adminTok);
t_assert($r['status'] != 200, 'confirm twice error: ' . ($r['msg'] ?? ''));
t_assert(strpos($r['msg'] ?? '', 'xác nhận') !== false, 'error message localized to vi: ' . ($r['msg'] ?? ''));

$r = http('POST', "$base/adminapi/order/cod/delivering/$a", $adminTok, ['delivery_name' => 'Anh Ba', 'delivery_id' => '0909']);
t_assert($r['status'] == 200 && Db::name('store_order')->where('id', $a)->value('fulfil_status') == 2, 'delivering via http');

$code = Db::name('store_order')->where('id', $a)->value('cod_delivery_code');
$r = http('POST', "$base/adminapi/order/cod/verify", $adminTok, ['code' => '000000']);
t_assert($r['status'] != 200, 'verify wrong code rejected');
$r = http('POST', "$base/adminapi/order/cod/verify", $adminTok, ['code' => $code]);
t_assert($r['status'] == 200 && $r['data']['fulfil_status'] == 3 && $r['data']['paid'] === 0, 'verify by code via http');

$r = http('POST', "$base/adminapi/order/cod/collect/$a", $adminTok, ['received' => '40']);
t_assert($r['status'] != 200, 'collect mismatch needs remark');
$r = http('POST', "$base/adminapi/order/cod/collect/$a", $adminTok, ['received' => '50']);
t_assert($r['status'] == 200 && Db::name('store_order')->where('id', $a)->value('status') == 3, 'collect => finished');

$r = http('POST', "$base/adminapi/order/cod/call_mark/$b", $adminTok, ['need' => 1]);
t_assert($r['status'] == 200 && Db::name('store_order')->where('id', $b)->value('need_call_confirm') == 1, 'call_mark');
$r = http('POST', "$base/adminapi/order/cod/cancel/$b", $adminTok, ['reason' => 'dup']);
t_assert($r['status'] == 200 && Db::name('store_order')->where('id', $b)->value('is_cancel') == 1, 'cancel via http');

$r = http('GET', "$base/adminapi/order/cod/audit/$a", $adminTok);
$adminRows = array_filter($r['data'], function ($x) { return $x['operator_type'] === 'admin' && $x['operator_id'] == 1; });
t_assert($r['status'] == 200 && count($adminRows) >= 4, 'audit list rows carry admin operator, count=' . count($adminRows));
t_assert(count(array_filter($r['data'], function ($x) { return $x['operator_type'] === ''; })) === 0, 'no audit row without operator (offline row stamped)');

// 新订单轮询
$latest = (int)Db::name('store_order')->where('is_cod', 1)->max('id');
$r = http('GET', "$base/adminapi/order/cod/new?since_id=0", $adminTok);
t_assert($r['data']['latest_id'] == $latest && $r['data']['list'] === [], 'new since_id=0 only returns latest id');
$c = mkOrder($pid, $uniq);
$ids[] = $c;
$r = http('GET', "$base/adminapi/order/cod/new?since_id=$latest", $adminTok);
t_assert(count($r['data']['list']) === 1 && $r['data']['list'][0]['id'] == $c && $r['data']['latest_id'] == $c, 'new returns only newer orders');
$r = http('GET', "$base/adminapi/order/cod/new?since_id=$c", $adminTok);
t_assert($r['data']['list'] === [] && $r['data']['latest_id'] == $c, 'no duplicate notification');

// ---- 员工端（配送员）核销 ----
Db::name('delivery_service')->where('uid', 7)->delete();
$d = mkOrder($pid, $uniq, ['uid' => 7]);
$ids[] = $d;
$dcode = Db::name('store_order')->where('id', $d)->value('cod_delivery_code');
$dorder = Db::name('store_order')->where('id', $d)->value('order_id');
$userTok = $svc->createToken(7, 'api')['token'];
$r = http('POST', "$base/api/admin/order/cod/verify", $userTok, ['code' => $dcode]);
t_assert($r['status'] != 200, 'non-staff user rejected');
Db::name('delivery_service')->insert(['uid' => 7, 'nickname' => 'Shipper', 'phone' => '0900', 'add_time' => time(), 'status' => 1]);
$r = http('GET', "$base/api/admin/order/cod/detail?code=$dcode", $userTok);
t_assert($r['status'] == 200 && $r['data']['order_id'] === $dorder && !isset($r['data']['cod_delivery_code']) && !isset($r['data']['code']), 'staff detail by code (no code echoed)');
$r = http('POST', "$base/api/admin/order/cod/verify", $userTok, ['order_id' => $dorder, 'code' => '123456']);
t_assert($r['status'] != 200, 'staff wrong code rejected');
$r = http('POST', "$base/api/admin/order/cod/verify", $userTok, ['order_id' => $dorder, 'code' => $dcode]);
t_assert($r['status'] == 200 && $r['data']['fulfil_status'] == 3 && $r['data']['cod_receivable'] == 50, 'staff verify ok => receivable shown');
$aud = Db::name('store_order_status')->where(['oid' => $d, 'change_type' => 'cod_code_verify'])->find();
t_assert($aud && $aud['operator_type'] === 'staff' && $aud['operator_id'] == 7, 'staff verify audited with operator');
Db::name('delivery_service')->where('uid', 7)->delete();

foreach ($ids as $id) {
    Db::name('store_order_status')->where('oid', $id)->delete();
    Db::name('store_order_cart_info')->where('oid', $id)->delete();
    Db::name('store_order')->where('id', $id)->delete();
}
Db::name('store_product')->where('id', $pid)->delete();
Db::name('store_product_attr_value')->where('product_id', $pid)->delete();
Db::name('user')->where('uid', 7)->where('account', 'cod_t7')->delete();
t_done();
