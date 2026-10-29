<?php
// 提货仓匹配：精确/模糊/auto_match=0/同城多仓默认与排序/无仓
require __DIR__ . '/bootstrap.php';

use think\facade\Db;
use app\services\vn\WarehouseMatchServices;

$HN = 910001;
$BD = 911001;
$PX = 912001; // Phúc Xá under Ba Đình
$HCM = 910002;
$HP = 910004;

$svc = app()->make(WarehouseMatchServices::class);
$now = time();

$clean = function () {
    $ids = Db::name('vn_warehouse')->whereLike('code', 'TWH-%')->column('id');
    if ($ids) {
        Db::name('vn_warehouse_region')->whereIn('warehouse_id', $ids)->delete();
        Db::name('vn_warehouse')->whereIn('id', $ids)->delete();
    }
};
$clean();
// 隔离：暂时摘掉演示仓在测试城上的关联，避免与 TWH-* 串扰（测完不恢复，请重跑 demo/002）
Db::name('vn_warehouse_region')->whereIn('city_id', [$HN, $BD, $PX, $HCM, $HP, 910005, 911011])->delete();

$mk = function (string $code, array $extra = []) use ($now) {
    $id = (int)Db::name('vn_warehouse')->insertGetId(array_merge([
        'code' => $code,
        'name' => $code,
        'address' => 'addr',
        'detailed_address' => '',
        'introduction' => '',
        'phone' => '',
        'lng' => '',
        'lat' => '',
        'is_enable' => 1,
        'effective_start' => 0,
        'effective_end' => 0,
        'pickup_slots' => '',
        'auto_match' => 1,
        'exact_match_only' => 0,
        'sort' => 0,
        'is_del' => 0,
        'add_time' => $now,
        'update_time' => $now,
    ], $extra));
    return $id;
};
$link = function (int $wid, int $city, int $sort = 0, int $def = 0) use ($now) {
    Db::name('vn_warehouse_region')->insert([
        'warehouse_id' => $wid, 'city_id' => $city, 'sort' => $sort, 'is_default' => $def, 'add_time' => $now,
    ]);
};

// 1) 河内双仓：默认 + 排序
$a = $mk('TWH-HN-A', ['sort' => 10]);
$b = $mk('TWH-HN-B', ['sort' => 50]);
$link($a, $HN, 10, 1);
$link($b, $HN, 20, 0);
$r = $svc->match($HN);
t_assert((int)$r['default_id'] === $a, 'default is A (is_default)');
t_assert(count($r['list']) === 2, 'HN has 2 warehouses');
t_assert((int)$r['list'][0]['id'] === $a && (int)$r['list'][1]['id'] === $b, 'order default then other');

// 2) 坊级精确仓：仅地址=坊时命中，祖先地址不命中该仓
$ex = $mk('TWH-EXACT', ['exact_match_only' => 1, 'sort' => 99]);
$link($ex, $PX, 100, 1);
$rPx = $svc->match($PX);
t_assert((int)$rPx['default_id'] === $ex, 'exact warehouse wins at ward');
$rBd = $svc->match($BD);
$idsBd = array_column($rBd['list'], 'id');
t_assert(!in_array($ex, $idsBd, true), 'exact warehouse not in district fuzzy set');
// 郡级地址应回落到河内城仓
t_assert(in_array($a, $idsBd, true) || in_array($b, $idsBd, true), 'district falls back to city warehouses');

// 3) auto_match=0 不进自动匹配
$manual = $mk('TWH-MANUAL', ['auto_match' => 0, 'sort' => 999]);
$link($manual, $HP, 100, 1);
$rHp = $svc->match($HP);
t_assert((int)$rHp['default_id'] === 0 && count($rHp['list']) === 0, 'auto_match=0 excluded');

// 4) 无仓城市
$rEmpty = $svc->match(910005); // Thanh Hóa 未挂仓
t_assert((int)$rEmpty['default_id'] === 0, 'no warehouse city empty');

// 5) assertAndSnapshot 拒非法仓
try {
    $svc->assertAndSnapshot($HN, $manual);
    t_assert(false, 'assert should reject unmatched warehouse');
} catch (\Throwable $e) {
    t_assert(true, 'assert rejects unmatched');
}
$snap = $svc->assertAndSnapshot($HN, 0);
t_assert((int)$snap['warehouse_id'] === $a, 'assert picks default');

// 6) HCM 模糊：挂省级即可命中下级（若链含 HCM）
$hcm = $mk('TWH-HCM', ['sort' => 1]);
$link($hcm, $HCM, 1, 1);
$rHcm = $svc->match(911011); // Quận 1
t_assert((int)$rHcm['default_id'] === $hcm, 'district under HCM matches city warehouse');

$clean();
t_done();
