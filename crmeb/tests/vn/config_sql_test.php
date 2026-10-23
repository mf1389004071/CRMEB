<?php
// 运行：php crmeb/tests/vn/config_sql_test.php [host] [port]  —— 校验 M10-1 配置项已入库且取值可 JSON 解码
$host = $argv[1] ?? '127.0.0.1';
$port = (int)($argv[2] ?? 33060);
$pdo = new PDO("mysql:host=$host;port=$port;dbname=crmeb;charset=utf8mb4", 'root', 'root');
$keys = ['vn_mode_enable','region_pricing_enable','allow_national_price','locate_max_km','cod_auto_stock_up',
    'cod_user_cancel_before_confirm','order_notify_poll_seconds','order_rate_limit_per_hour','base_currency',
    'default_lang','i18n_fallback_lang','i18n_show_pending_machine','default_phone_country'];
$fail = 0;
foreach ($keys as $k) {
    $row = $pdo->query("select value, config_tab_id from eb_system_config where menu_name='$k'")->fetch(PDO::FETCH_ASSOC);
    if (!$row || json_decode($row['value'], true) === null) { $fail++; echo "FAIL $k\n"; }
}
echo $fail ? "FAILED $fail\n" : "OK " . count($keys) . " keys\n";
exit($fail ? 1 : 0);
