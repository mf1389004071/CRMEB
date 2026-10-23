<?php
// 测试引导：加载 ThinkPHP 应用（需通过环境变量指向测试库，见 database/vn/README.md “测试”一节）
// 运行示例（docker，库在宿主 33060）：
//   docker run --rm --add-host=host.docker.internal:host-gateway -e DATABASE_HOSTNAME=host.docker.internal \
//     -e DATABASE_HOSTPORT=33060 -e DATABASE_DATABASE=crmeb -e DATABASE_USERNAME=root -e DATABASE_PASSWORD=root \
//     -e DATABASE_CHARSET=utf8mb4 -v <repo>/crmeb:/app -w /app dev-php74 php tests/vn/xxx_test.php

require dirname(__DIR__, 2) . '/vendor/autoload.php';

$app = new \think\App(dirname(__DIR__, 2));
$app->initialize();

if (!function_exists('t_assert')) {
    $GLOBALS['t_fail'] = 0;
    $GLOBALS['t_pass'] = 0;
    function t_assert($cond, string $name)
    {
        if ($cond) {
            $GLOBALS['t_pass']++;
        } else {
            $GLOBALS['t_fail']++;
            echo "FAIL: $name\n";
        }
    }
    function t_done()
    {
        echo $GLOBALS['t_fail'] ? "FAILED {$GLOBALS['t_fail']} (passed {$GLOBALS['t_pass']})\n" : "OK {$GLOBALS['t_pass']} assertions\n";
        exit($GLOBALS['t_fail'] ? 1 : 0);
    }
}
