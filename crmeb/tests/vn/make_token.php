<?php
// 测试辅助：为测试库中的管理员/用户签发 JWT，供 curl 联调使用
// 用法: bash tests/vn/run.sh tests/vn/make_token.php admin 1   或   ... user <uid>
// 输出一行 token；注意签发 token 写入 runtime 缓存，需与 HTTP 服务共享同一 runtime 目录
require __DIR__ . '/bootstrap.php';

use think\facade\Db;

$type = $argv[1] ?? 'admin';
$id = (int)($argv[2] ?? 1);
/** @var \app\services\system\admin\SystemAdminServices $svc */
$svc = app()->make(\app\services\system\admin\SystemAdminServices::class);
if ($type === 'admin') {
    $pwd = Db::name('system_admin')->where('id', $id)->value('pwd');
    $res = $svc->createToken($id, 'admin', $pwd);
} else {
    $res = $svc->createToken($id, 'api');
}
echo $res['token'], "\n";
