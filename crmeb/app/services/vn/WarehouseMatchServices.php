<?php
// +----------------------------------------------------------------------
// | 菜集鲜：提货仓匹配（地址最细→最粗）
// +----------------------------------------------------------------------

namespace app\services\vn;

use app\services\BaseServices;
use crmeb\exceptions\ApiException;
use think\facade\Db;

/**
 * 按收货地址 city_id 倒查提货仓
 */
class WarehouseMatchServices extends BaseServices
{
    /**
     * @param int $addressCityId 地址最细 city_id
     * @param bool $forAuto 是否自动匹配场景（过滤 auto_match=0）
     * @return array{default_id:int,list:array,match_city_id:int}
     */
    public function match(int $addressCityId, bool $forAuto = true): array
    {
        if ($addressCityId <= 0) {
            return ['default_id' => 0, 'list' => [], 'match_city_id' => 0];
        }
        $chain = app()->make(RegionServices::class)->chain($addressCityId);
        if (!$chain) {
            return ['default_id' => 0, 'list' => [], 'match_city_id' => 0];
        }
        $now = time();
        $q = Db::name('vn_warehouse_region')->alias('r')
            ->join('vn_warehouse w', 'w.id=r.warehouse_id')
            ->whereIn('r.city_id', $chain)
            ->where(['w.is_del' => 0, 'w.is_enable' => 1]);
        if ($forAuto) {
            $q->where('w.auto_match', 1);
        }
        $rows = $q->field('r.warehouse_id,r.city_id,r.sort as rel_sort,r.is_default,w.name,w.address,w.detailed_address,w.phone,w.introduction,w.pickup_slots,w.exact_match_only,w.sort as wh_sort,w.lng,w.lat,w.effective_start,w.effective_end,w.code')
            ->select()->toArray();

        $candidates = [];
        foreach ($rows as $row) {
            $start = (int)$row['effective_start'];
            $end = (int)$row['effective_end'];
            if ($start > 0 && $now < $start) {
                continue;
            }
            if ($end > 0 && $now > $end) {
                continue;
            }
            if ((int)$row['exact_match_only'] === 1 && (int)$row['city_id'] !== $addressCityId) {
                continue;
            }
            $depth = array_search((int)$row['city_id'], $chain, true);
            if ($depth === false) {
                continue;
            }
            $row['_depth'] = (int)$depth;
            $candidates[] = $row;
        }
        if (!$candidates) {
            return ['default_id' => 0, 'list' => [], 'match_city_id' => 0];
        }

        $bestDepth = min(array_column($candidates, '_depth'));
        $set = array_values(array_filter($candidates, static function ($r) use ($bestDepth) {
            return (int)$r['_depth'] === $bestDepth;
        }));
        usort($set, static function ($a, $b) {
            if ((int)$a['is_default'] !== (int)$b['is_default']) {
                return (int)$b['is_default'] <=> (int)$a['is_default'];
            }
            if ((int)$a['rel_sort'] !== (int)$b['rel_sort']) {
                return (int)$b['rel_sort'] <=> (int)$a['rel_sort'];
            }
            if ((int)$a['wh_sort'] !== (int)$b['wh_sort']) {
                return (int)$b['wh_sort'] <=> (int)$a['wh_sort'];
            }
            return (int)$a['warehouse_id'] <=> (int)$b['warehouse_id'];
        });

        // 同一仓可能因多关联入选，按 warehouse_id 去重保序
        $seen = [];
        $list = [];
        foreach ($set as $r) {
            $wid = (int)$r['warehouse_id'];
            if (isset($seen[$wid])) {
                continue;
            }
            $seen[$wid] = 1;
            $slots = $r['pickup_slots'];
            if (is_string($slots) && $slots !== '') {
                $decoded = json_decode($slots, true);
                $slots = is_array($decoded) ? $decoded : [];
            } elseif (!is_array($slots)) {
                $slots = [];
            }
            $list[] = [
                'id'               => $wid,
                'code'             => (string)$r['code'],
                'name'             => (string)$r['name'],
                'address'          => (string)$r['address'],
                'detailed_address' => (string)$r['detailed_address'],
                'phone'            => (string)$r['phone'],
                'introduction'     => (string)$r['introduction'],
                'pickup_slots'     => $slots,
                'lng'              => (string)$r['lng'],
                'lat'              => (string)$r['lat'],
                'is_default'       => (int)$r['is_default'],
                'match_city_id'    => (int)$r['city_id'],
            ];
        }
        $defaultId = $list ? (int)$list[0]['id'] : 0;
        $matchCityId = $list ? (int)$list[0]['match_city_id'] : 0;
        return ['default_id' => $defaultId, 'list' => $list, 'match_city_id' => $matchCityId];
    }

    /**
     * 校验用户所选仓属于匹配集，返回快照字段
     * @throws ApiException
     */
    public function assertAndSnapshot(int $addressCityId, int $warehouseId): array
    {
        $matched = $this->match($addressCityId, true);
        if (!$matched['list']) {
            throw new ApiException('当前地址暂无可用提货仓');
        }
        if ($warehouseId <= 0) {
            $warehouseId = (int)$matched['default_id'];
        }
        $hit = null;
        foreach ($matched['list'] as $item) {
            if ((int)$item['id'] === $warehouseId) {
                $hit = $item;
                break;
            }
        }
        if (!$hit) {
            throw new ApiException('所选提货仓不可用，请重新选择');
        }
        $addr = trim($hit['address'] . ' ' . $hit['detailed_address']);
        return [
            'warehouse_id'      => (int)$hit['id'],
            'warehouse_name'    => (string)$hit['name'],
            'warehouse_address' => mb_substr($addr, 0, 500),
        ];
    }
}
