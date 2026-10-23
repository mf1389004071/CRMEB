<?php
// 运行：php crmeb/tests/vn/lang_code_test.php  —— 只抽取 normalize_lang_code 函数体做纯函数测试
$src = file_get_contents(__DIR__ . '/../../app/common.php');
if (!preg_match('/if \(!function_exists\(\'normalize_lang_code\'\)\) \{(.*?)\R\}\R\Rif \(!function_exists\(\'current_lang_code\'\)/s', $src, $m)) {
    fwrite(STDERR, "cannot extract normalize_lang_code\n");
    exit(2);
}
eval($m[1]);
$cases = [
    'vi_vn' => 'vi-VN', 'vi-VN' => 'vi-VN', 'VI' => 'vi-VN', ' vi ' => 'vi-VN',
    'zh_cn' => 'zh-CN', 'zh' => 'zh-CN', 'zh-Hans' => 'zh-CN', 'zh_hans_cn' => 'zh-CN',
    'en' => 'en-US', 'en_US' => 'en-US', 'en-gb' => 'en-US',
    'fr-FR' => 'fr-FR', '' => '',
];
$fail = 0;
foreach ($cases as $in => $exp) {
    $got = normalize_lang_code($in);
    if ($got !== $exp) { $fail++; echo "FAIL '$in' => '$got' (expect '$exp')\n"; }
}
echo $fail ? "FAILED $fail\n" : "OK " . count($cases) . " cases\n";
exit($fail ? 1 : 0);
