<?php
// M9-1 登录/注册（无验证码，区号+手机号规范化）HTTP 测试
require __DIR__ . '/bootstrap.php';
require __DIR__ . '/Fixtures.php';

use think\facade\Db;

$B = VnFx::base();
Db::name('user')->whereIn('account', ['84912345601', '8613800001111'])->delete();

// 注册：无 captcha 参数，本地号带前导 0 与分隔符
$r = VnFx::http('POST', "$B/api/register", '', ['account' => '0912-345-601', 'password' => 'Abc12345', 'phone_country_code' => '+84', 'nickname' => 'Hoa']);
t_assert($r['status'] == 200, 'register without captcha: ' . json_encode($r, JSON_UNESCAPED_UNICODE));
$u = Db::name('user')->where('account', '84912345601')->find();
t_assert($u && $u['phone'] === '84912345601' && $u['phone_country_code'] === '+84' && $u['nickname'] === 'Hoa', 'user stored with normalized account/country/nickname');

// 重复注册（不同书写方式同一号码）被拒
$r = VnFx::http('POST', "$B/api/register", '', ['account' => '912345601', 'password' => 'Abc12345', 'phone_country_code' => '+84']);
t_assert($r['status'] != 200, '0912… and 912… are the same account (duplicate rejected): ' . ($r['msg'] ?? ''));
t_assert(Db::name('user')->where('account', '84912345601')->count() === 1, 'only one account row');

// 非法号码
$r = VnFx::http('POST', "$B/api/register", '', ['account' => '12345', 'password' => 'Abc12345', 'phone_country_code' => '+84']);
t_assert($r['status'] != 200, 'too short phone rejected: ' . ($r['msg'] ?? ''));
$r = VnFx::http('POST', "$B/api/register", '', ['account' => '0912345602', 'password' => '123456', 'phone_country_code' => '+84']);
t_assert($r['status'] != 200, 'weak default password rejected');

// 中国号码也可注册
$r = VnFx::http('POST', "$B/api/register", '', ['account' => '13800001111', 'password' => 'Abc12345', 'phone_country_code' => '+86']);
t_assert($r['status'] == 200 && Db::name('user')->where('account', '8613800001111')->count() === 1, 'cn number registered with +86 prefix');

// 登录：多种书写方式
foreach ([['0912345601', '+84'], ['912345601', '+84'], ['+84 912 345 601', '+84'], ['84912345601', '']] as [$acc, $cc]) {
    $r = VnFx::http('POST', "$B/api/login", '', ['account' => $acc, 'password' => 'Abc12345', 'phone_country_code' => $cc]);
    t_assert($r['status'] == 200 && !empty($r['data']['token']), "login with '$acc' $cc: " . ($r['msg'] ?? ''));
}
$r = VnFx::http('POST', "$B/api/login", '', ['account' => '0912345601', 'password' => 'wrongpass', 'phone_country_code' => '+84']);
t_assert($r['status'] != 200, 'wrong password rejected');

// 历史用户（旧账号无区号，如 13900001111）仍可用原账号登录
Db::name('user')->where('account', 'legacy13900001111')->delete();
Db::name('user')->insert(['account' => 'legacy13900001111', 'phone' => '13900001111', 'nickname' => 'old', 'pwd' => md5('Abc12345'), 'add_time' => time(), 'status' => 1, 'user_type' => 'h5']);
$r = VnFx::http('POST', "$B/api/login", '', ['account' => 'legacy13900001111', 'password' => 'Abc12345']);
t_assert($r['status'] == 200, 'legacy account login still works: ' . ($r['msg'] ?? ''));

// M9-2 后台重置密码
$at = VnFx::adminToken();
$uid1 = (int)Db::name('user')->where('account', '84912345601')->value('uid');
$r = VnFx::http('POST', "$B/adminapi/user/user/reset_password/$uid1", $at);
t_assert($r['status'] == 200 && strlen($r['data']['password']) === 8, 'admin reset password returns 8-char one-time password: ' . json_encode($r));
$newPwd = $r['data']['password'] ?? '';
t_assert(Db::name('user')->where('uid', $uid1)->value('pwd') === md5($newPwd), 'password hash updated');
$r = VnFx::http('POST', "$B/api/login", '', ['account' => '0912345601', 'password' => 'Abc12345', 'phone_country_code' => '+84']);
t_assert($r['status'] != 200, 'old password no longer works');
$r = VnFx::http('POST', "$B/api/login", '', ['account' => '0912345601', 'password' => $newPwd, 'phone_country_code' => '+84']);
t_assert($r['status'] == 200, 'new password works');
$r = VnFx::http('POST', "$B/adminapi/user/user/reset_password/99999999", $at);
t_assert($r['status'] != 200, 'reset unknown user rejected');
$r = VnFx::http('POST', "$B/adminapi/user/user/reset_password/$uid1", '');
t_assert($r['status'] != 200, 'reset requires admin token');

Db::name('user')->whereIn('account', ['84912345601', '8613800001111', 'legacy13900001111'])->delete();
t_done();
