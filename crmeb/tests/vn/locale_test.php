<?php
// M5-1 用户语种持久化
require __DIR__ . '/bootstrap.php';
require __DIR__ . '/Fixtures.php';

use think\facade\Db;

$B = VnFx::base();
$uid = VnFx::user();
Db::name('user')->where('uid', $uid)->update(['locale' => '']);
$ut = VnFx::userToken($uid);
$post = function ($d, $lang = 'vi-VN') use ($B, &$ut) { return VnFx::http('POST', "$B/api/user/locale", $ut, $d, ['Cb-lang: ' . $lang]); };

$r = VnFx::http('GET', "$B/api/userinfo", $ut);
t_assert($r['status'] == 200 && $r['data']['locale'] === '', 'new user has empty locale');

$r = $post(['locale' => 'vi_vn']);
t_assert($r['status'] == 200 && $r['data']['locale'] === 'vi-VN', 'legacy alias normalized and saved: ' . json_encode($r));
t_assert(Db::name('user')->where('uid', $uid)->value('locale') === 'vi-VN', 'stored in eb_user.locale');

// 换设备登录（新 token）读取到语种
$ut2 = VnFx::userToken($uid);
$r = VnFx::http('GET', "$B/api/userinfo", $ut2);
t_assert($r['status'] == 200 && $r['data']['locale'] === 'vi-VN', 'userinfo returns saved locale on another device');

$r = $post(['locale' => 'en']);
t_assert($r['status'] == 200 && Db::name('user')->where('uid', $uid)->value('locale') === 'en-US', 'switch to English persisted');

foreach (['', 'fr-FR', 'xx', 'zh-Hant'] as $bad) {
    $r = $post(['locale' => $bad]);
    t_assert($r['status'] != 200, "locale '$bad' rejected (not enabled)");
}
$r = $post(['locale' => 'fr-FR']);
t_assert(strpos($r['msg'] ?? '', 'ngôn ngữ') !== false || strpos($r['msg'] ?? '', 'Ngôn ngữ') !== false, 'rejection message localized: ' . ($r['msg'] ?? ''));
t_assert(Db::name('user')->where('uid', $uid)->value('locale') === 'en-US', 'invalid attempts leave locale unchanged');

$r = VnFx::http('POST', "$B/api/user/locale", '', ['locale' => 'vi-VN']);
t_assert($r['status'] != 200, 'requires login');

Db::name('user')->where('uid', $uid)->update(['locale' => '']);
t_done();
