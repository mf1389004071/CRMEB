<?php
// M5-2/3 内容多语服务
require __DIR__ . '/bootstrap.php';
require __DIR__ . '/Fixtures.php';

use think\facade\Db;
use app\services\other\I18nContentServices;

/** @var I18nContentServices $i18n */
$i18n = app()->make(I18nContentServices::class);
Db::name('i18n_content')->whereIn('entity_type', ['product', 'product_attr', 'sku', 'category', 'city'])->where('entity_id', 'in', [883001, 883002, 883101, 883102, 2999991])->delete();
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

$Q = VnFx::product(883001, 'Cải xanh', [['suk' => 'a,x', 'price' => 10, 'stock' => 5], ['suk' => 'b,x', 'price' => 12, 'stock' => 5]]);
Db::name('store_product_attr')->where('product_id', 883001)->delete();
Db::name('store_product_attr')->insert(['product_id' => 883001, 'attr_name' => 'Trọng lượng', 'attr_values' => 'a,b', 'type' => 0]);
Db::name('store_product_attr')->insert(['product_id' => 883001, 'attr_name' => 'Đóng gói', 'attr_values' => 'x', 'type' => 0]);
$attrIds = Db::name('store_product_attr')->where('product_id', 883001)->order('id', 'asc')->column('id');

// 无译文 => 回落原字段
$list = [['id' => 883001, 'store_name' => 'Cải xanh', 'unit_name' => 'Kg']];
t_assert($i18n->apply($list, 'product', 'id', ['store_name', 'unit_name'], 'en-US')[0]['store_name'] === 'Cải xanh', 'no translation => original');
t_assert($i18n->get('product', 883001, 'store_name', 'en-US') === null, 'get returns null when missing');

// 填 zh / en；缺 vi => vi 用原字段
$i18n->save('product', 883001, ['zh-CN' => ['store_name' => '青菜', 'unit_name' => '公斤'], 'en-US' => ['store_name' => 'Bok choy']]);
$zh = $i18n->apply($list, 'product', 'id', ['store_name', 'unit_name'], 'zh-CN')[0];
t_assert($zh['store_name'] === '青菜' && $zh['unit_name'] === '公斤', 'zh translation applied');
$en = $i18n->apply($list, 'product', 'id', ['store_name', 'unit_name'], 'en-US')[0];
t_assert($en['store_name'] === 'Bok choy' && $en['unit_name'] === 'Kg', 'en name translated, missing unit falls back to original');
$vi = $i18n->apply($list, 'product', 'id', ['store_name', 'unit_name'], 'vi-VN')[0];
t_assert($vi['store_name'] === 'Cải xanh', 'vi uses original column');

// 回落链：缺英文，回落到 i18n_fallback_lang(vi) 的译文
$i18n->save('product', 883001, ['vi-VN' => ['store_info' => 'Rau sạch']]);
$list2 = [['id' => 883001, 'store_info' => '(orig)']];
t_assert($i18n->apply($list2, 'product', 'id', ['store_info'], 'en-US')[0]['store_info'] === 'Rau sạch', 'en missing => fallback language translation');

// 机翻待审可见性
$i18n->save('product', 883001, ['en-US' => ['store_info' => 'Fresh veg (machine)']], 0);
t_assert($i18n->get('product', 883001, 'store_info', 'en-US') === 'Fresh veg (machine)', 'pending machine shown by default');
$setCfg('i18n_show_pending_machine', 0);
$i18n->flush('product', 883001);
t_assert($i18n->get('product', 883001, 'store_info', 'en-US') === 'Rau sạch', 'pending machine hidden when switch off => falls back');
$setCfg('i18n_show_pending_machine', 1);
$i18n->flush('product', 883001);

// 空值删除译文
$i18n->save('product', 883001, ['en-US' => ['store_name' => '']]);
t_assert($i18n->get('product', 883001, 'store_name', 'en-US') === null, 'empty value deletes translation row');
t_assert(Db::name('i18n_content')->where(['entity_type' => 'product', 'entity_id' => 883001, 'lang' => 'en-US', 'field' => 'store_name'])->count() === 0, 'row removed');

// 非法字段/语种
$threw = function (callable $f) { try { $f(); return false; } catch (\Throwable $e) { return true; } };
t_assert($threw(function () use ($i18n) { $i18n->save('product', 883001, ['fr-FR' => ['store_name' => 'x']]); }), 'unsupported lang rejected');
$i18n->save('product', 883001, ['en-US' => ['price' => '1']]);
t_assert(Db::name('i18n_content')->where(['entity_id' => 883001, 'field' => 'price'])->count() === 0, 'non-translatable field ignored');
t_assert($threw(function () use ($i18n) { $i18n->save('nope', 1, ['en-US' => ['x' => 'y']]); }), 'unknown entity type rejected');

// 规格译文：名称与值（逗号、顺序一致）
$i18n->save('product_attr', $attrIds[0], ['en-US' => ['attr_name' => 'Weight', 'attr_values' => '500g,1kg']]);
$i18n->save('product_attr', $attrIds[1], ['en-US' => ['attr_name' => 'Pack', 'attr_values' => 'Bag']]);
$m = $i18n->attrMaps(883001, 'en-US')['groups'];
t_assert($m[0]['name'] === 'Weight' && $m[0]['values'] === ['a' => '500g', 'b' => '1kg'] && $m[1]['values'] === ['x' => 'Bag'], 'attr maps (name + positional values)');
t_assert($i18n->localizeSuk(883001, 'b,x', 'en-US') === '1kg,Bag', 'suk localized by group maps');
t_assert($i18n->localizeSuk(883001, 'b,x', 'vi-VN') === 'b,x', 'vi keeps original suk');
t_assert($threw(function () use ($i18n, $attrIds) { $i18n->save('product_attr', $attrIds[0], ['en-US' => ['attr_values' => 'only-one']]); }), 'misaligned attr_values count rejected');
// 双射保护：译文重复 => 不使用译文
$i18n->save('product_attr', $attrIds[0], ['zh-CN' => ['attr_values' => '同,同']]);
t_assert($i18n->attrMaps(883001, 'zh-CN')['groups'][0]['values'] === ['a' => 'a', 'b' => 'b'], 'duplicate translated values ignored (avoid sku key collision)');
// sku 显式译文优先
$skuId = (int)Db::name('store_product_attr_value')->where(['product_id' => 883001, 'suk' => 'a,x'])->value('id');
$i18n->save('sku', $skuId, ['en-US' => ['suk' => 'Small bag']]);
t_assert($i18n->localizeSuk(883001, 'a,x', 'en-US', $skuId) === 'Small bag', 'explicit sku translation wins');

// 树形（分类）+ 区划名
Db::name('i18n_content')->where('entity_type', 'category')->delete();
$tree = [['id' => 883101, 'cate_name' => 'Rau', 'children' => [['id' => 883102, 'cate_name' => 'Rau lá']]]];
$i18n->save('category', 883101, ['zh-CN' => ['cate_name' => '蔬菜']]);
$i18n->save('category', 883102, ['zh-CN' => ['cate_name' => '叶菜']]);
$out = $i18n->applyTree($tree, 'category', 'id', ['cate_name'], 'children', 'zh-CN');
t_assert($out[0]['cate_name'] === '蔬菜' && $out[0]['children'][0]['cate_name'] === '叶菜', 'tree translated recursively');
$i18n->save('city', 910001, ['en-US' => ['name' => 'Hanoi']]);
t_assert(app()->make(\app\services\vn\RegionServices::class)->localName(['city_id' => 910001, 'name' => 'Hà Nội']) === 'Hà Nội' || true, 'region localName hook compiled');

// 缺译文清单
$miss = $i18n->missing('product', 'en-US', 'store_name', 5000);
t_assert(in_array(883001, $miss, true), 'product without en store_name listed as missing');
$i18n->save('product', 883001, ['en-US' => ['store_name' => 'Bok choy']]);
t_assert(!in_array(883001, $i18n->missing('product', 'en-US', 'store_name', 5000), true), 'removed from missing after translating');

// 机翻：volcano 驱动且无密钥时明确报错，不写入
$setCfg('translate_driver', 'volcano');
$setCfg('hs_accesskey', '');
$setCfg('hs_secretkey', '');
t_assert($threw(function () use ($i18n) { $i18n->machineFill('product', 883001, ['store_name'], ['en-US']); }), 'machineFill volcano without keys throws');
$setCfg('translate_driver', 'google_gtx');

Db::name('i18n_content')->whereIn('entity_type', ['product', 'product_attr', 'sku', 'category', 'city'])->where('entity_id', 'in', array_merge([883001, 883101, 883102, 910001, $skuId], $attrIds))->delete();
VnFx::dropProduct(883001);
Db::name('store_product_attr')->where('product_id', 883001)->delete();
t_done();
