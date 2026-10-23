<?php
// +----------------------------------------------------------------------
// | CRMEB [ CRMEB赋能开发者，助力企业发展 ]
// +----------------------------------------------------------------------
// | Copyright (c) 2016~2026 https://www.crmeb.com All rights reserved.
// +----------------------------------------------------------------------
// | Licensed CRMEB并不是自由软件，未经许可不能去掉CRMEB相关版权
// +----------------------------------------------------------------------
// | Author: CRMEB Team <admin@crmeb.com>
// +----------------------------------------------------------------------

namespace app\services\vn;

use app\services\BaseServices;
use think\facade\Cache;
use think\facade\Db;

/**
 * 配送区域：选择、定位、祖先链（H5 与区域价共用）
 * 层级：国家根 level=-1；VN 0=省 1=郡/县 2=坊/社；CN 0=省 1=市 2=区。parent_id 引用 city_id。
 * Class RegionServices
 * @package app\services\vn
 */
class RegionServices extends BaseServices
{
    const CACHE_TTL = 600;

    /**
     * 缓存版本号：后台修改区划后递增使缓存失效
     */
    public static function version(): int
    {
        return (int)Cache::get('region_ver', 1);
    }

    public static function bumpVersion(): void
    {
        Cache::set('region_ver', self::version() + 1, 0);
    }

    /**
     * 取节点原始行
     * @param int $cityId
     * @return array|null
     */
    public function node(int $cityId): ?array
    {
        if ($cityId <= 0) {
            return null;
        }
        $key = 'region_node_' . self::version() . '_' . $cityId;
        $row = Cache::get($key);
        if ($row === null) {
            $row = Db::name('system_city')->where('city_id', $cityId)->find() ?: false;
            Cache::set($key, $row, self::CACHE_TTL);
        }
        return $row ?: null;
    }

    /**
     * 祖先链：[自身, 父…国家根]（近→远）。优先用 path 解析，path 为空时沿 parent_id 回溯
     * @param int $cityId
     * @return int[]
     */
    public function chain(int $cityId): array
    {
        $node = $this->node($cityId);
        if (!$node) {
            return [];
        }
        $path = trim((string)$node['path'], ',');
        if ($path !== '') {
            $ids = array_map('intval', explode(',', $path));
            return array_reverse($ids);
        }
        $out = [];
        $guard = 0;
        $cur = $node;
        while ($cur && $guard++ < 8) {
            $out[] = (int)$cur['city_id'];
            if ((int)$cur['level'] <= -1) {
                break;
            }
            $pid = (int)$cur['parent_id'];
            if ($pid > 0) {
                $cur = $this->node($pid);
            } else {
                $rootId = (int)Db::name('system_city')->where(['level' => -1, 'country_code' => $cur['country_code']])->value('city_id');
                if ($rootId) {
                    $out[] = $rootId;
                }
                break;
            }
        }
        return $out;
    }

    /**
     * 是否开放可选的有效区域
     */
    public function isOpenId(int $cityId): bool
    {
        $n = $this->node($cityId);
        return $n && (int)$n['is_open'] === 1;
    }

    /**
     * 子节点（H5 选择列表）。parent_id<=0 返回国家层。
     * @param int $parentId
     * @param bool $onlyOpen true=仅 is_open=1（区域选择）；false=所有 is_show=1（地址选择，M8）
     * @return array
     */
    public function children(int $parentId, bool $onlyOpen = true): array
    {
        $q = Db::name('system_city');
        if ($parentId <= 0) {
            $q->where('level', -1);
        } else {
            $parent = $this->node($parentId);
            if (!$parent) {
                return [];
            }
            if ((int)$parent['level'] === -1 && (int)$parent['parent_id'] === -1 && $parent['country_code'] === 'CN') {
                // CN 存量省节点 parent_id=0
                $q->where(['level' => 0, 'country_code' => 'CN']);
            } else {
                $q->where('parent_id', $parentId);
            }
        }
        $q->where('is_show', 1);
        if ($onlyOpen) {
            $q->where('is_open', 1);
        }
        $rows = $q->order('sort', 'desc')->order('city_id', 'asc')->select()->toArray();
        return $this->format($rows, $onlyOpen);
    }

    /**
     * 热门城市
     */
    public function hot(): array
    {
        $rows = Db::name('system_city')->where(['is_hot' => 1, 'is_open' => 1, 'is_show' => 1])
            ->where('level', '>=', 0)->order('sort', 'desc')->order('city_id', 'asc')->select()->toArray();
        return $this->format($rows, true);
    }

    /**
     * 经纬度定位：在 is_open=1 的“城市级”节点中取最近的一个，距离 ≤ locate_max_km 才算命中
     * @return array ['matched'=>bool,'distance_km'=>float,'node'=>array|null,'chain'=>array]
     */
    public function locate(float $lat, float $lng): array
    {
        $candidates = Cache::get('region_locate_' . self::version());
        if ($candidates === null) {
            $candidates = Db::name('system_city')
                ->where('is_open', 1)->where('is_show', 1)
                ->where(function ($q) {
                    $q->where(['country_code' => 'VN', 'level' => 0])->whereOr(function ($q2) {
                        $q2->where(['country_code' => 'CN', 'level' => 1]);
                    });
                })
                ->where('lng', '<>', '')->where('lat', '<>', '')
                ->field('city_id,lng,lat')->select()->toArray();
            Cache::set('region_locate_' . self::version(), $candidates, self::CACHE_TTL);
        }
        $best = null;
        $bestKm = null;
        foreach ($candidates as $c) {
            $km = self::haversine($lat, $lng, (float)$c['lat'], (float)$c['lng']);
            if ($bestKm === null || $km < $bestKm) {
                $bestKm = $km;
                $best = $c;
            }
        }
        $max = (float)sys_config('locate_max_km', 60);
        if ($best === null || $bestKm > $max) {
            return ['matched' => false, 'distance_km' => $bestKm === null ? null : round($bestKm, 2), 'node' => null, 'chain' => []];
        }
        return ['matched' => true, 'distance_km' => round($bestKm, 2)] + $this->info((int)$best['city_id']);
    }

    /**
     * 节点及完整链（根→自身，用于前端缓存恢复）。无效返回 valid=false
     * @return array ['valid'=>bool,'node'=>array|null,'chain'=>[]]
     */
    public function info(int $cityId): array
    {
        $node = $this->node($cityId);
        if (!$node || (int)$node['is_open'] !== 1) {
            return ['valid' => false, 'node' => null, 'chain' => []];
        }
        $chainIds = array_reverse($this->chain($cityId));
        $chain = [];
        foreach ($chainIds as $id) {
            $n = $this->node($id);
            if ($n) {
                $chain[] = $this->formatOne($n, false);
            }
        }
        return ['valid' => true, 'node' => $this->formatOne($node, false), 'chain' => $chain];
    }

    /**
     * 大圆距离（km）
     */
    public static function haversine(float $lat1, float $lng1, float $lat2, float $lng2): float
    {
        $r = 6371.0;
        $dLat = deg2rad($lat2 - $lat1);
        $dLng = deg2rad($lng2 - $lng1);
        $a = sin($dLat / 2) ** 2 + cos(deg2rad($lat1)) * cos(deg2rad($lat2)) * sin($dLng / 2) ** 2;
        return 2 * $r * asin(min(1, sqrt($a)));
    }

    /**
     * 本地化名称：优先内容多语（M5），否则取 name
     */
    public function localName(array $node): string
    {
        $cls = '\\app\\services\\other\\I18nContentServices';
        if (class_exists($cls)) {
            $v = app()->make($cls)->get('city', (int)$node['city_id'], 'name');
            if ($v !== null && $v !== '') {
                return $v;
            }
        }
        return (string)$node['name'];
    }

    /**
     * 批量格式化（带 has_children）
     */
    protected function format(array $rows, bool $onlyOpen): array
    {
        if (!$rows) {
            return [];
        }
        $ids = array_column($rows, 'city_id');
        $q = Db::name('system_city')->whereIn('parent_id', $ids)->where('is_show', 1);
        if ($onlyOpen) {
            $q->where('is_open', 1);
        }
        $has = $q->group('parent_id')->column('count(*) c', 'parent_id');
        $out = [];
        foreach ($rows as $r) {
            $hasChildren = isset($has[$r['city_id']]);
            // CN 根节点的子节点（省）parent_id=0，单独判断
            if ((int)$r['level'] === -1 && $r['country_code'] === 'CN') {
                $hasChildren = Db::name('system_city')->where(['level' => 0, 'country_code' => 'CN', 'is_show' => 1])->when($onlyOpen, function ($q) {
                    $q->where('is_open', 1);
                })->count() > 0;
            }
            $out[] = $this->formatOne($r, $hasChildren);
        }
        return $out;
    }

    protected function formatOne(array $r, $hasChildren): array
    {
        return [
            'city_id'      => (int)$r['city_id'],
            'name'         => $this->localName($r),
            'level'        => (int)$r['level'],
            'parent_id'    => (int)$r['parent_id'],
            'country_code' => $r['country_code'],
            'lng'          => $r['lng'],
            'lat'          => $r['lat'],
            'is_open'      => (int)$r['is_open'],
            'has_children' => $hasChildren === false ? false : (bool)$hasChildren,
        ];
    }
}
