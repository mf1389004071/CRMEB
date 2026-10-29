<?php
// +----------------------------------------------------------------------
// | 菜集鲜：提货仓库后台管理
// +----------------------------------------------------------------------

namespace app\services\vn;

use app\services\BaseServices;
use crmeb\exceptions\AdminException;
use think\facade\Db;

class WarehouseAdminServices extends BaseServices
{
    public function lst(array $where): array
    {
        $page = max(1, (int)($where['page'] ?? 1));
        $limit = min(100, max(1, (int)($where['limit'] ?? 20)));
        $q = Db::name('vn_warehouse')->where('is_del', 0);
        if (isset($where['is_enable']) && $where['is_enable'] !== '') {
            $q->where('is_enable', (int)$where['is_enable']);
        }
        $kw = trim((string)($where['keyword'] ?? ''));
        if ($kw !== '') {
            $q->where(function ($qq) use ($kw) {
                $qq->whereLike('name', '%' . $kw . '%')->whereOr('code', 'like', '%' . $kw . '%')
                    ->whereOr('address', 'like', '%' . $kw . '%')->whereOr('phone', 'like', '%' . $kw . '%');
            });
        }
        $count = (clone $q)->count();
        $list = $q->order('sort', 'desc')->order('id', 'desc')->page($page, $limit)->select()->toArray();
        $ids = array_column($list, 'id');
        $relMap = [];
        if ($ids) {
            $rels = Db::name('vn_warehouse_region')->alias('r')
                ->leftJoin('system_city c', 'c.city_id=r.city_id')
                ->whereIn('r.warehouse_id', $ids)
                ->field('r.*,c.name as city_name,c.merger_name,c.level')
                ->order('r.is_default', 'desc')->order('r.sort', 'desc')
                ->select()->toArray();
            foreach ($rels as $r) {
                $relMap[(int)$r['warehouse_id']][] = $r;
            }
        }
        foreach ($list as &$row) {
            $row['pickup_slots'] = $this->decodeSlots($row['pickup_slots'] ?? '');
            $row['regions'] = $relMap[(int)$row['id']] ?? [];
            $row['region_count'] = count($row['regions']);
        }
        unset($row);
        return compact('list', 'count');
    }

    public function read(int $id): array
    {
        $row = Db::name('vn_warehouse')->where(['id' => $id, 'is_del' => 0])->find();
        if (!$row) {
            throw new AdminException('仓库不存在');
        }
        $row['pickup_slots'] = $this->decodeSlots($row['pickup_slots'] ?? '');
        $row['regions'] = Db::name('vn_warehouse_region')->alias('r')
            ->leftJoin('system_city c', 'c.city_id=r.city_id')
            ->where('r.warehouse_id', $id)
            ->field('r.*,c.name as city_name,c.merger_name,c.level')
            ->order('r.is_default', 'desc')->order('r.sort', 'desc')
            ->select()->toArray();
        return $row;
    }

    public function save(array $data): int
    {
        $id = (int)($data['id'] ?? 0);
        $name = trim((string)($data['name'] ?? ''));
        if ($name === '') {
            throw new AdminException('请填写仓库名称');
        }
        $code = trim((string)($data['code'] ?? ''));
        if ($code !== '') {
            $exist = Db::name('vn_warehouse')->where(['code' => $code, 'is_del' => 0])->where('id', '<>', $id)->value('id');
            if ($exist) {
                throw new AdminException('仓库编码已存在');
            }
        }
        $now = time();
        $row = [
            'code'             => $code,
            'name'             => $name,
            'address'          => trim((string)($data['address'] ?? '')),
            'detailed_address' => trim((string)($data['detailed_address'] ?? '')),
            'introduction'     => trim((string)($data['introduction'] ?? '')),
            'phone'            => trim((string)($data['phone'] ?? '')),
            'lng'              => trim((string)($data['lng'] ?? '')),
            'lat'              => trim((string)($data['lat'] ?? '')),
            'is_enable'        => (int)($data['is_enable'] ?? 1) ? 1 : 0,
            'effective_start'  => (int)($data['effective_start'] ?? 0),
            'effective_end'    => (int)($data['effective_end'] ?? 0),
            'pickup_slots'     => $this->encodeSlots($data['pickup_slots'] ?? []),
            'auto_match'       => (int)($data['auto_match'] ?? 1) ? 1 : 0,
            'exact_match_only' => (int)($data['exact_match_only'] ?? 0) ? 1 : 0,
            'sort'             => (int)($data['sort'] ?? 0),
            'update_time'      => $now,
        ];
        if ($id > 0) {
            if (!Db::name('vn_warehouse')->where(['id' => $id, 'is_del' => 0])->value('id')) {
                throw new AdminException('仓库不存在');
            }
            Db::name('vn_warehouse')->where('id', $id)->update($row);
        } else {
            $row['add_time'] = $now;
            $id = (int)Db::name('vn_warehouse')->insertGetId($row);
        }
        if (isset($data['regions']) && is_array($data['regions'])) {
            $this->saveRegions($id, $data['regions']);
        }
        return $id;
    }

    /**
     * 快速开仓：建仓并挂一个区划为默认
     * @return array{id:int,overwritten:bool,prev_default:?array}
     */
    public function quickCreate(array $data): array
    {
        $cityId = (int)($data['city_id'] ?? 0);
        if ($cityId <= 0) {
            throw new AdminException('请选择区划节点');
        }
        if (!Db::name('system_city')->where('city_id', $cityId)->value('city_id')) {
            throw new AdminException('区划不存在');
        }
        $force = !empty($data['force']);
        $prev = $this->currentDefault($cityId);
        if ($prev && !$force) {
            return [
                'need_confirm' => true,
                'prev_default' => $prev,
                'id'           => 0,
                'overwritten'  => false,
            ];
        }
        $id = $this->save([
            'id' => 0,
            'name' => $data['name'] ?? '',
            'code' => $data['code'] ?? '',
            'address' => $data['address'] ?? '',
            'detailed_address' => $data['detailed_address'] ?? '',
            'phone' => $data['phone'] ?? '',
            'introduction' => $data['introduction'] ?? '',
            'is_enable' => 1,
            'auto_match' => 1,
            'exact_match_only' => 0,
            'sort' => (int)($data['sort'] ?? 0),
            'pickup_slots' => $data['pickup_slots'] ?? [],
        ]);
        $this->setRegionDefault($cityId, $id, true);
        return [
            'need_confirm' => false,
            'id'           => $id,
            'overwritten'  => (bool)$prev,
            'prev_default' => $prev,
        ];
    }

    public function delete(int $id): void
    {
        if ($id <= 0) {
            throw new AdminException('参数错误');
        }
        Db::name('vn_warehouse')->where('id', $id)->update(['is_del' => 1, 'update_time' => time()]);
    }

    /**
     * 覆盖保存某仓的全部区划关联
     * @param array $regions [['city_id'=>, 'sort'=>, 'is_default'=>], ...]
     */
    public function saveRegions(int $warehouseId, array $regions): void
    {
        if (!Db::name('vn_warehouse')->where(['id' => $warehouseId, 'is_del' => 0])->value('id')) {
            throw new AdminException('仓库不存在');
        }
        $now = time();
        $keepCity = [];
        foreach ($regions as $r) {
            $cityId = (int)($r['city_id'] ?? 0);
            if ($cityId <= 0) {
                continue;
            }
            $keepCity[] = $cityId;
            $isDefault = !empty($r['is_default']) ? 1 : 0;
            if ($isDefault) {
                Db::name('vn_warehouse_region')->where('city_id', $cityId)->update(['is_default' => 0]);
            }
            $exist = Db::name('vn_warehouse_region')->where(['warehouse_id' => $warehouseId, 'city_id' => $cityId])->find();
            $payload = [
                'sort'       => (int)($r['sort'] ?? 0),
                'is_default' => $isDefault,
            ];
            if ($exist) {
                Db::name('vn_warehouse_region')->where('id', $exist['id'])->update($payload);
            } else {
                Db::name('vn_warehouse_region')->insert($payload + [
                    'warehouse_id' => $warehouseId,
                    'city_id'      => $cityId,
                    'add_time'     => $now,
                ]);
            }
        }
        $q = Db::name('vn_warehouse_region')->where('warehouse_id', $warehouseId);
        if ($keepCity) {
            $q->whereNotIn('city_id', $keepCity);
        }
        $q->delete();
    }

    /**
     * 配送区域页：设某 city_id 的默认仓（可顺带建关联）
     * @return array{need_confirm?:bool,prev_default?:array,ok?:bool,overwritten?:bool}
     */
    public function setRegionDefault(int $cityId, int $warehouseId, bool $force = false): array
    {
        if ($cityId <= 0 || $warehouseId <= 0) {
            throw new AdminException('参数错误');
        }
        if (!Db::name('system_city')->where('city_id', $cityId)->value('city_id')) {
            throw new AdminException('区划不存在');
        }
        $wh = Db::name('vn_warehouse')->where(['id' => $warehouseId, 'is_del' => 0])->find();
        if (!$wh) {
            throw new AdminException('仓库不存在');
        }
        $prev = $this->currentDefault($cityId);
        if ($prev && (int)$prev['warehouse_id'] !== $warehouseId && !$force) {
            return ['need_confirm' => true, 'prev_default' => $prev, 'ok' => false];
        }
        Db::name('vn_warehouse_region')->where('city_id', $cityId)->update(['is_default' => 0]);
        $exist = Db::name('vn_warehouse_region')->where(['warehouse_id' => $warehouseId, 'city_id' => $cityId])->find();
        if ($exist) {
            Db::name('vn_warehouse_region')->where('id', $exist['id'])->update(['is_default' => 1]);
        } else {
            Db::name('vn_warehouse_region')->insert([
                'warehouse_id' => $warehouseId,
                'city_id'      => $cityId,
                'sort'         => 100,
                'is_default'   => 1,
                'add_time'     => time(),
            ]);
        }
        return [
            'need_confirm' => false,
            'ok'           => true,
            'overwritten'  => (bool)($prev && (int)$prev['warehouse_id'] !== $warehouseId),
            'prev_default' => $prev,
        ];
    }

    public function forRegion(int $cityId): array
    {
        $linked = [];
        if ($cityId > 0) {
            $linked = Db::name('vn_warehouse_region')->alias('r')
                ->join('vn_warehouse w', 'w.id=r.warehouse_id')
                ->where(['r.city_id' => $cityId, 'w.is_del' => 0])
                ->field('w.id,w.name,w.code,w.address,w.is_enable,w.auto_match,r.is_default,r.sort')
                ->order('r.is_default', 'desc')->order('r.sort', 'desc')
                ->select()->toArray();
        }
        $all = Db::name('vn_warehouse')->where(['is_del' => 0])->order('sort', 'desc')->order('id', 'desc')
            ->field('id,name,code,address,is_enable,auto_match')->select()->toArray();
        $default = $this->currentDefault($cityId);
        return ['linked' => $linked, 'all' => $all, 'default' => $default];
    }

    public function options(): array
    {
        return Db::name('vn_warehouse')->where(['is_del' => 0, 'is_enable' => 1])
            ->order('sort', 'desc')->order('id', 'desc')
            ->field('id,name,code,address')->select()->toArray();
    }

    /**
     * 开放城缺仓/缺默认健康检查
     */
    public function health(): array
    {
        $openCities = Db::name('system_city')
            ->where(['is_open' => 1, 'country_code' => 'VN'])
            ->where('level', '>=', 0)
            ->field('city_id,name,level,merger_name,is_hot')
            ->order('level', 'asc')->order('sort', 'desc')
            ->limit(500)
            ->select()->toArray();
        $cityIds = array_column($openCities, 'city_id');
        $hasRel = $cityIds ? Db::name('vn_warehouse_region')->whereIn('city_id', $cityIds)->group('city_id')->column('count(*) c', 'city_id') : [];
        $defaults = $cityIds ? Db::name('vn_warehouse_region')->alias('r')
            ->join('vn_warehouse w', 'w.id=r.warehouse_id')
            ->whereIn('r.city_id', $cityIds)->where(['r.is_default' => 1, 'w.is_del' => 0])
            ->column('w.name', 'r.city_id') : [];
        $noWarehouse = [];
        $noDefault = [];
        foreach ($openCities as $c) {
            $cid = (int)$c['city_id'];
            // 仅提示省级(level0)开放城，避免坊级刷屏；子级可模糊命中父仓
            if ((int)$c['level'] !== 0) {
                continue;
            }
            if (empty($hasRel[$cid])) {
                $noWarehouse[] = $c;
            } elseif (empty($defaults[$cid])) {
                $c['hint'] = '有关联仓但未设默认';
                $noDefault[] = $c;
            }
        }
        return [
            'no_warehouse' => $noWarehouse,
            'no_default'   => $noDefault,
            'ok'           => !$noWarehouse && !$noDefault,
        ];
    }

    /**
     * 批量附带默认仓信息到区划列表行
     */
    public function attachDefaultToCities(array $list): array
    {
        $ids = array_column($list, 'city_id');
        if (!$ids) {
            return $list;
        }
        $rows = Db::name('vn_warehouse_region')->alias('r')
            ->join('vn_warehouse w', 'w.id=r.warehouse_id')
            ->whereIn('r.city_id', $ids)->where(['r.is_default' => 1, 'w.is_del' => 0])
            ->field('r.city_id,r.warehouse_id,w.name as warehouse_name')
            ->select()->toArray();
        $map = [];
        foreach ($rows as $r) {
            $map[(int)$r['city_id']] = $r;
        }
        foreach ($list as &$i) {
            $d = $map[(int)$i['city_id']] ?? null;
            $i['default_warehouse_id'] = $d ? (int)$d['warehouse_id'] : 0;
            $i['default_warehouse_name'] = $d ? (string)$d['warehouse_name'] : '';
        }
        unset($i);
        return $list;
    }

    protected function currentDefault(int $cityId): ?array
    {
        if ($cityId <= 0) {
            return null;
        }
        $row = Db::name('vn_warehouse_region')->alias('r')
            ->join('vn_warehouse w', 'w.id=r.warehouse_id')
            ->where(['r.city_id' => $cityId, 'r.is_default' => 1, 'w.is_del' => 0])
            ->field('r.warehouse_id,w.name,w.code,w.address')
            ->find();
        return $row ?: null;
    }

    protected function decodeSlots($raw): array
    {
        if (is_array($raw)) {
            return $raw;
        }
        if (!is_string($raw) || $raw === '') {
            return [];
        }
        $d = json_decode($raw, true);
        return is_array($d) ? $d : [];
    }

    protected function encodeSlots($slots): string
    {
        if (is_string($slots)) {
            return $slots;
        }
        if (!is_array($slots)) {
            return '';
        }
        return $slots ? json_encode(array_values($slots), JSON_UNESCAPED_UNICODE) : '';
    }
}
