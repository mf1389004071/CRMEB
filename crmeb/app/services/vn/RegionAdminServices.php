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
use app\services\system\SystemCityPathServices;
use crmeb\exceptions\ApiException;
use think\facade\Cache;
use think\facade\Db;

/**
 * 后台区划管理：列表/开放/热门/排序/新增编辑/Excel 导入/重建 path
 * Class RegionAdminServices
 * @package app\services\vn
 */
class RegionAdminServices extends BaseServices
{
    /** 导入列：city_id?、parent_city_id、level、name、area_code、lng、lat、country_code */
    const IMPORT_COLUMNS = ['city_id', 'parent_city_id', 'level', 'name', 'area_code', 'lng', 'lat', 'country_code'];

    /**
     * 列表（子节点）。parent_id<=0 列出国家层
     */
    public function lst(array $where): array
    {
        $page = max(1, (int)($where['page'] ?? 1));
        $limit = min(500, max(1, (int)($where['limit'] ?? 50)));
        $q = Db::name('system_city');
        $parentId = (int)($where['parent_id'] ?? 0);
        $kw = trim((string)($where['keyword'] ?? ''));
        if ($kw !== '') {
            $q->where(function ($qq) use ($kw) {
                $qq->whereLike('name', '%' . $kw . '%')->whereOr('merger_name', 'like', '%' . $kw . '%');
            });
        } elseif ($parentId <= 0) {
            $q->where('level', -1);
        } else {
            $parent = Db::name('system_city')->where('city_id', $parentId)->find();
            if ($parent && (int)$parent['level'] === -1 && $parent['country_code'] === 'CN') {
                $q->where(['level' => 0, 'country_code' => 'CN']);
            } else {
                $q->where('parent_id', $parentId);
            }
        }
        if (!empty($where['country_code'])) {
            $q->where('country_code', $where['country_code']);
        }
        if (isset($where['is_open']) && $where['is_open'] !== '') {
            $q->where('is_open', (int)$where['is_open']);
        }
        $count = (clone $q)->count();
        $list = $q->order('sort', 'desc')->order('city_id', 'asc')->page($page, $limit)->select()->toArray();
        $ids = array_column($list, 'city_id');
        $has = $ids ? Db::name('system_city')->whereIn('parent_id', $ids)->group('parent_id')->column('count(*) c', 'parent_id') : [];
        foreach ($list as &$i) {
            $i['has_children'] = isset($has[$i['city_id']]) || ((int)$i['level'] === -1 && $i['country_code'] === 'CN');
        }
        return compact('list', 'count');
    }

    /**
     * 批量开放/取消；cascade=1 时连同所有后代节点
     */
    public function setOpen(array $cityIds, int $isOpen, bool $cascade): int
    {
        $cityIds = array_values(array_filter(array_map('intval', $cityIds)));
        if (!$cityIds) {
            throw new ApiException('参数错误');
        }
        $isOpen = $isOpen ? 1 : 0;
        $n = Db::name('system_city')->whereIn('city_id', $cityIds)->update(['is_open' => $isOpen]);
        if ($cascade) {
            foreach ($cityIds as $id) {
                $n += Db::name('system_city')->where('path', 'like', '%,' . $id . ',%')->where('city_id', '<>', $id)->update(['is_open' => $isOpen]);
            }
        }
        RegionServices::bumpVersion();
        return $n;
    }

    public function setHot(array $cityIds, int $isHot): int
    {
        $cityIds = array_values(array_filter(array_map('intval', $cityIds)));
        if (!$cityIds) {
            throw new ApiException('参数错误');
        }
        $n = Db::name('system_city')->whereIn('city_id', $cityIds)->update(['is_hot' => $isHot ? 1 : 0]);
        RegionServices::bumpVersion();
        return $n;
    }

    public function setSort(int $cityId, int $sort): bool
    {
        Db::name('system_city')->where('city_id', $cityId)->update(['sort' => $sort]);
        RegionServices::bumpVersion();
        return true;
    }

    /**
     * 新增/编辑单个节点。新增需 parent_id（国家根传 0 且 level=-1）
     * @return int city_id
     */
    public function save(array $d): int
    {
        $name = trim((string)($d['name'] ?? ''));
        if ($name === '') {
            throw new ApiException('请填写名称');
        }
        $cityId = (int)($d['city_id'] ?? 0);
        $fields = [
            'name'      => $name,
            'area_code' => (string)($d['area_code'] ?? ''),
            'lng'       => (string)($d['lng'] ?? ''),
            'lat'       => (string)($d['lat'] ?? ''),
        ];
        if (isset($d['is_show'])) {
            $fields['is_show'] = (int)$d['is_show'] ? 1 : 0;
        }
        if ($cityId > 0 && Db::name('system_city')->where('city_id', $cityId)->count()) {
            Db::name('system_city')->where('city_id', $cityId)->update($fields);
        } else {
            $parentId = (int)($d['parent_id'] ?? 0);
            $parent = Db::name('system_city')->where('city_id', $parentId)->find();
            if (!$parent) {
                throw new ApiException('上级区划不存在');
            }
            $newId = $cityId > 0 ? $cityId : $this->nextCityId($parent['country_code']);
            $level = (int)$parent['level'] + 1;
            $cc = $parent['country_code'];
            $fields += [
                'city_id'      => $newId,
                'level'        => $level,
                'parent_id'    => $parentId,
                'merger_name'  => ((int)$parent['level'] === -1 ? '' : $parent['merger_name'] . ',') . $name,
                'country_code' => $cc,
                'path'         => rtrim($parent['path'] ?: (',' . $parentId . ','), ',') . ',' . $newId . ',',
                'is_show'      => $fields['is_show'] ?? 1,
                'is_open'      => 0,
            ];
            Db::name('system_city')->insert($fields);
            $cityId = $newId;
        }
        RegionServices::bumpVersion();
        return $cityId;
    }

    /**
     * Excel 导入：返回 ['ok'=>n,'fail'=>[['row'=>行号,'reason'=>原因]]]
     * @param string $filePath xlsx/xls/csv 路径
     */
    public function importFile(string $filePath): array
    {
        $sheet = \PhpOffice\PhpSpreadsheet\IOFactory::load($filePath)->getActiveSheet();
        $rows = $sheet->toArray(null, true, false, false);
        if (!$rows) {
            throw new ApiException('文件内容为空');
        }
        // 表头行：首行若 B 列非数字视为表头
        $start = 0;
        if (isset($rows[0][1]) && !is_numeric($rows[0][1]) && (string)$rows[0][1] !== '') {
            $start = 1;
        }
        $parsed = [];
        $fail = [];
        $fileIds = [];
        for ($i = $start; $i < count($rows); $i++) {
            $r = $rows[$i];
            $line = $i + 1;
            if (!array_filter($r, function ($v) { return $v !== null && $v !== ''; })) {
                continue;
            }
            $d = [];
            foreach (self::IMPORT_COLUMNS as $k => $col) {
                $d[$col] = isset($r[$k]) ? trim((string)$r[$k]) : '';
            }
            if ($d['name'] === '') {
                $fail[] = ['row' => $line, 'reason' => '名称为空'];
                continue;
            }
            if (!is_numeric($d['level']) || (int)$d['level'] < -1 || (int)$d['level'] > 6) {
                $fail[] = ['row' => $line, 'reason' => 'level 不合法'];
                continue;
            }
            if (!in_array($d['country_code'], ['CN', 'VN'], true)) {
                $fail[] = ['row' => $line, 'reason' => 'country_code 仅支持 CN/VN'];
                continue;
            }
            if ($d['lng'] !== '' && (!is_numeric($d['lng']) || abs((float)$d['lng']) > 180)) {
                $fail[] = ['row' => $line, 'reason' => '经度不合法'];
                continue;
            }
            if ($d['lat'] !== '' && (!is_numeric($d['lat']) || abs((float)$d['lat']) > 90)) {
                $fail[] = ['row' => $line, 'reason' => '纬度不合法'];
                continue;
            }
            $d['_line'] = $line;
            $parsed[] = $d;
            if ($d['city_id'] !== '' && is_numeric($d['city_id'])) {
                $fileIds[(int)$d['city_id']] = 1;
            }
        }
        $ok = 0;
        Db::transaction(function () use (&$parsed, &$fail, &$ok, $fileIds) {
            $existing = Db::name('system_city')->column('city_id');
            $existing = array_flip($existing);
            $next = [];
            foreach ($parsed as $d) {
                $level = (int)$d['level'];
                $parent = (int)$d['parent_city_id'];
                if ($level !== -1 && $parent <= 0 && !($level === 0 && $d['country_code'] === 'CN')) {
                    $fail[] = ['row' => $d['_line'], 'reason' => 'parent_city_id 缺失'];
                    continue;
                }
                if ($parent > 0 && !isset($existing[$parent]) && !isset($fileIds[$parent])) {
                    $fail[] = ['row' => $d['_line'], 'reason' => '上级区划不存在: ' . $parent];
                    continue;
                }
                $cityId = $d['city_id'] !== '' ? (int)$d['city_id'] : 0;
                if ($cityId <= 0) {
                    $cc = $d['country_code'];
                    if (!isset($next[$cc])) {
                        $next[$cc] = $this->nextCityId($cc);
                    }
                    $cityId = $next[$cc]++;
                }
                $mergerParent = '';
                $row = [
                    'city_id'      => $cityId,
                    'level'        => $level,
                    'parent_id'    => $level === -1 ? -1 : $parent,
                    'area_code'    => $d['area_code'],
                    'name'         => $d['name'],
                    'merger_name'  => $d['name'],
                    'lng'          => $d['lng'],
                    'lat'          => $d['lat'],
                    'country_code' => $d['country_code'],
                    'is_show'      => 1,
                ];
                if (isset($existing[$cityId])) {
                    unset($row['city_id']);
                    Db::name('system_city')->where('city_id', $cityId)->update($row);
                } else {
                    $row['city_id'] = $cityId;
                    Db::name('system_city')->insert($row);
                    $existing[$cityId] = 1;
                }
                $ok++;
            }
        });
        // 重建 path 与 merger_name
        app()->make(SystemCityPathServices::class)->rebuild();
        $this->rebuildMergerNames();
        RegionServices::bumpVersion();
        return ['ok' => $ok, 'fail' => $fail];
    }

    /**
     * 重建 path
     */
    public function rebuildPath(): int
    {
        $n = app()->make(SystemCityPathServices::class)->rebuild();
        RegionServices::bumpVersion();
        return $n;
    }

    /**
     * 按 path 重建 merger_name（仅 VN；CN 存量保持原样）：省名,郡名,坊名
     */
    protected function rebuildMergerNames(): void
    {
        $rows = Db::name('system_city')->where('country_code', 'VN')->field('id,city_id,name,path,level')->select()->toArray();
        $names = array_column($rows, 'name', 'city_id');
        foreach ($rows as $r) {
            if ((int)$r['level'] < 0) {
                continue;
            }
            $parts = [];
            foreach (array_filter(explode(',', $r['path'])) as $id) {
                if (isset($names[(int)$id]) && (int)$id !== 900002) {
                    $parts[] = $names[(int)$id];
                }
            }
            $m = implode(',', $parts);
            if ($m !== '') {
                Db::name('system_city')->where('id', $r['id'])->update(['merger_name' => $m]);
            }
        }
    }

    /**
     * 下一个可用 city_id：VN 从 910000 起；CN 取全表最大值+1（避开国家根段）
     */
    protected function nextCityId(string $country): int
    {
        if ($country === 'VN') {
            $max = (int)Db::name('system_city')->where('country_code', 'VN')->where('city_id', '>=', 910000)->max('city_id');
            return max($max + 1, 910000);
        }
        $max = (int)Db::name('system_city')->where('city_id', '<', 900000)->max('city_id');
        return $max + 1;
    }
}
