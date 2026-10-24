<?php
// M5-4 后台内容多语接口：读取/保存/商品规格译文/缺译文/Excel 导入导出
require __DIR__ . '/bootstrap.php';
require __DIR__ . '/Fixtures.php';

use think\facade\Db;

$B = VnFx::base();
$at = VnFx::adminToken();
VnFx::dropProduct(883401);
Db::name('i18n_content')->whereIn('entity_type', ['product', 'product_attr', 'sku', 'category'])->where('entity_id', '<', 5)->delete();
$P = VnFx::product(883401, 'Dưa leo', [['suk' => 'a', 'price' => 10, 'stock' => 5], ['suk' => 'b', 'price' => 12, 'stock' => 5]], ['unit_name' => 'Kg']);
Db::name('store_product_description')->where('product_id', 883401)->delete();
Db::name('store_product_description')->insert(['product_id' => 883401, 'description' => '<p>Mô tả</p>', 'type' => 0]);
$attrId = (int)Db::name('store_product_attr')->where('product_id', 883401)->value('id');
$skuId = (int)Db::name('store_product_attr_value')->where(['product_id' => 883401, 'suk' => 'a'])->value('id');
$get = function ($p) use ($B, $at) { return VnFx::http('GET', "$B/adminapi/$p", $at); };
$post = function ($p, $d) use ($B, $at) { return VnFx::http('POST', "$B/adminapi/$p", $at, $d); };
$setCfg = function (string $k, $v) {
    $val = json_encode((string)$v);
    $n = Db::name('system_config')->where('menu_name', $k)->update(['value' => $val]);
    if (!$n && !Db::name('system_config')->where('menu_name', $k)->find()) {
        $tab = (int)(Db::name('system_config_tab')->where('eng_title', 'online_translation')->value('id') ?: 106);
        Db::name('system_config')->insert([
            'menu_name' => $k, 'type' => 'text', 'input_type' => 'input', 'config_tab_id' => $tab,
            'parameter' => '', 'upload_type' => 1, 'required' => '', 'width' => 100, 'high' => 0,
            'value' => $val, 'info' => $k, 'desc' => '', 'sort' => 0, 'status' => 1, 'level' => 0, 'link_id' => 0, 'link_value' => 0,
        ]);
    }
    \crmeb\services\CacheService::clear();
};

$r = VnFx::http('GET', "$B/adminapi/product/i18n/883401", '');
t_assert($r['status'] != 200, 'requires admin token');

$r = $get('product/i18n/883401');
t_assert($r['status'] == 200 && $r['data']['original']['store_name'] === 'Dưa leo' && $r['data']['original']['description'] === '<p>Mô tả</p>' && count($r['data']['attrs']) === 1 && count($r['data']['skus']) === 2, 'read product i18n bundle: ' . substr(json_encode($r, JSON_UNESCAPED_UNICODE), 0, 160));
t_assert($r['data']['default_lang'] === 'vi-VN' && $r['data']['fields'][0] === 'store_name', 'default language & field list');

$r = $post('product/i18n/883401', [
    'translations' => ['zh-CN' => ['store_name' => '黄瓜', 'description' => '<p>描述</p>'], 'en-US' => ['store_name' => 'Cucumber', 'unit_name' => 'kg']],
    'attrs' => [(string)$attrId => ['en-US' => ['attr_name' => 'Weight', 'attr_values' => '500g,1kg']]],
    'skus' => [(string)$skuId => ['en-US' => ['suk' => 'Small']]],
]);
t_assert($r['status'] == 200, 'save bundle: ' . json_encode($r, JSON_UNESCAPED_UNICODE));
$r = $get('product/i18n/883401');
t_assert($r['data']['translations']['zh-CN']['store_name']['value'] === '黄瓜' && $r['data']['translations']['en-US']['unit_name']['value'] === 'kg', 'product translations persisted');
t_assert($r['data']['attrs'][0]['translations']['en-US']['attr_values']['value'] === '500g,1kg', 'attr translation persisted');
t_assert($r['data']['skus'][0]['translations']['en-US']['suk']['value'] === 'Small', 'sku translation persisted');

// 校验：规格值数量不一致被拒
$r = $post('product/i18n/883401', ['attrs' => [(string)$attrId => ['en-US' => ['attr_values' => 'only-one']]]]);
t_assert($r['status'] != 200, 'misaligned attr_values rejected: ' . ($r['msg'] ?? ''));
// 不属于该商品的规格 id 被忽略（不写入）
$otherAttr = (int)Db::name('store_product_attr')->where('product_id', '<>', 883401)->value('id');
if ($otherAttr) {
    $post('product/i18n/883401', ['attrs' => [(string)$otherAttr => ['en-US' => ['attr_name' => 'HACK']]]]);
    t_assert(Db::name('i18n_content')->where(['entity_type' => 'product_attr', 'entity_id' => $otherAttr, 'value' => 'HACK'])->count() === 0, 'foreign attr id ignored');
}
$r = $post('i18n/product/99999999', ['translations' => ['en-US' => ['store_name' => 'x']]]);
t_assert($r['status'] != 200, 'unknown entity rejected');
$r = $post('i18n/nope/1', ['translations' => ['en-US' => ['store_name' => 'x']]]);
t_assert($r['status'] != 200, 'unknown type rejected');

// 清空某语言字段 => 删除译文
$post('product/i18n/883401', ['translations' => ['en-US' => ['unit_name' => '']]]);
t_assert(!isset($get('product/i18n/883401')['data']['translations']['en-US']['unit_name']), 'empty string removes translation');

// 缺译文
$r = $get('i18n/missing?type=product&lang=zh-CN&field=store_info');
t_assert($r['status'] == 200 && in_array(883401, array_column($r['data'], 'id'), true), 'missing list includes product lacking zh store_info');
$r = $get('i18n/missing?type=product&lang=en-US&field=store_name');
t_assert(!in_array(883401, array_column($r['data'], 'id'), true), 'translated product not in missing list');

// 机翻：volcano 驱动且未配置密钥时给出明确错误
$setCfg('translate_driver', 'volcano');
$setCfg('hs_accesskey', '');
$setCfg('hs_secretkey', '');
$at = VnFx::adminToken();
$r = $post('i18n/product/883401/machine', ['langs' => ['en-US']]);
t_assert($r['status'] != 200, 'machine translate volcano without keys => error: ' . ($r['msg'] ?? ''));
$setCfg('translate_driver', 'google_gtx');

// 导出 / 导入
$r = $get('i18n/export?type=product');
t_assert($r['status'] == 200 && strpos($r['data']['url'], '.xlsx') !== false, 'export url');
$file = '/app/public/' . ltrim(parse_url($r['data']['url'], PHP_URL_PATH), '/');
t_assert(is_file($file), 'export file exists');
$xlsx = '/tmp/i18n_import.xlsx';
$sheet = new \PhpOffice\PhpSpreadsheet\Spreadsheet();
$sheet->getActiveSheet()->fromArray([
    ['entity_type', 'entity_id', 'field', 'lang', 'value'],
    ['product', 883401, 'store_info', 'zh-CN', '新鲜黄瓜'],
    ['product', 883401, 'store_info', 'en_US', 'Fresh cucumber'],     // 旧别名 en_US 规范化
    ['product', 883401, 'price', 'en-US', '1'],                       // 不可翻译字段
    ['product', 883401, 'store_info', 'fr-FR', 'x'],                  // 不支持语种
    ['product', 0, 'store_info', 'en-US', 'x'],                       // id 不合法
], null, 'A1', true);
(new \PhpOffice\PhpSpreadsheet\Writer\Xlsx($sheet))->save($xlsx);
$ch = curl_init("$B/adminapi/i18n/import");
curl_setopt_array($ch, [CURLOPT_RETURNTRANSFER => true, CURLOPT_POST => true, CURLOPT_HTTPHEADER => ['Authori-zation: Bearer ' . $at],
    CURLOPT_POSTFIELDS => ['file' => new CURLFile($xlsx, 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', 'i18n.xlsx')]]);
$res = json_decode(curl_exec($ch), true);
t_assert($res['status'] == 200 && $res['data']['ok'] === 2 && count($res['data']['fail']) === 3, 'import ok=2 fail=3: ' . json_encode($res, JSON_UNESCAPED_UNICODE));
t_assert(Db::name('i18n_content')->where(['entity_type' => 'product', 'entity_id' => 883401, 'field' => 'store_info', 'lang' => 'en-US'])->value('value') === 'Fresh cucumber', 'imported en_US alias normalized');

// 类别/区划实体
$cid = (int)Db::name('store_category')->value('id');
if ($cid) {
    $r = $post("i18n/category/$cid", ['translations' => ['en-US' => ['cate_name' => 'Cat EN']]]);
    t_assert($r['status'] == 200, 'category i18n save');
    $post("i18n/category/$cid", ['translations' => ['en-US' => ['cate_name' => '']]]);
}
$r = $post('i18n/city/910001', ['translations' => ['en-US' => ['name' => 'Hanoi']]]);
t_assert($r['status'] == 200, 'city i18n save');
$r = VnFx::http('GET', "$B/api/region/children?parent_id=900002", '', [], ['Cb-lang: en-US']);
t_assert($r['data'][0]['name'] === 'Hanoi', 'H5 region list shows translated city name');
$post('i18n/city/910001', ['translations' => ['en-US' => ['name' => '']]]);

Db::name('i18n_content')->where('entity_id', 'in', [883401, $attrId, $skuId])->whereIn('entity_type', ['product', 'product_attr', 'sku'])->delete();
Db::name('store_product_description')->where('product_id', 883401)->delete();
VnFx::dropProduct(883401);
t_done();
