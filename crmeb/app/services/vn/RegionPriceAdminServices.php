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
use app\services\product\RegionPriceServices;
use crmeb\exceptions\ApiException;
use crmeb\services\SpreadsheetExcelService;
use think\facade\Db;

/**
 * 后台区域价管理：按商品读写、Excel 模板/导入/导出
 * Class RegionPriceAdminServices
 * @package app\services\vn
 */
class RegionPriceAdminServices extends BaseServices
{
    /** 导入/导出列 */
    const COLUMNS = ['product_id', 'spec_suk', 'unique', 'city_id', 'city_name', 'price', 'ot_price', 'stock'];

    /**
     * 读取：规格列表 + 已配置价目（按区域分组）
     */
    public function get(int $productId): array
    {
        $product = Db::name('store_product')->where(['id' => $productId, 'is_del' => 0])->field('id,store_name,spec_type,allow_national_price')->find();
        if (!$product) {
            throw new ApiException('商品不存在');
        }
        $skus = Db::name('store_product_attr_value')->where(['product_id' => $productId, 'type' => 0])
            ->field('unique,suk,price,ot_price,stock')->order('id', 'asc')->select()->toArray();
        $rows = Db::name('store_product_region_price')->where('product_id', $productId)->order('city_id', 'asc')->select()->toArray();
        $cityIds = array_values(array_unique(array_column($rows, 'city_id')));
        $cities = $cityIds ? Db::name('system_city')->whereIn('city_id', $cityIds)->column('merger_name,name,level,path', 'city_id') : [];
        $groups = [];
        foreach ($rows as $r) {
            $cid = (int)$r['city_id'];
            if (!isset($groups[$cid])) {
                $c = $cities[$cid] ?? ['merger_name' => '', 'name' => '#' . $cid, 'level' => 0, 'path' => ''];
                $groups[$cid] = ['city_id' => $cid, 'city_name' => $c['merger_name'] ?: $c['name'], 'rows' => []];
            }
            $groups[$cid]['rows'][] = [
                'unique' => $r['unique'], 'price' => $r['price'], 'ot_price' => $r['ot_price'],
                'stock' => $r['stock'], 'status' => (int)$r['status'],
            ];
        }
        return [
            'product'      => $product,
            'skus'         => $skus,
            'groups'       => array_values($groups),
            'system_allow' => (int)sys_config('allow_national_price', 0) === 1,
        ];
    }

    /**
     * 保存（整品覆盖）
     * @param int $productId
     * @param array $rows [{unique,city_id,price,ot_price,stock,status}]
     * @param array $scopeCityIds 本次表单涉及的区域；该范围内未提交的价目行会被删除
     * @param int|null $allowNational 商品级“允许全国价”（仅系统总闸开启时可修改）
     * @return array ['saved'=>n,'deleted'=>n]
     */
    public function save(int $productId, array $rows, array $scopeCityIds = [], ?int $allowNational = null): array
    {
        $product = Db::name('store_product')->where(['id' => $productId, 'is_del' => 0])->find();
        if (!$product) {
            throw new ApiException('商品不存在');
        }
        $uniques = Db::name('store_product_attr_value')->where(['product_id' => $productId, 'type' => 0])->column('unique');
        $uniques = array_flip($uniques);
        $clean = [];
        foreach ($rows as $i => $r) {
            $line = $i + 1;
            $unique = (string)($r['unique'] ?? '');
            $cityId = (int)($r['city_id'] ?? 0);
            if (!isset($uniques[$unique])) {
                throw new ApiException('第{:line}行规格不存在', ['line' => $line]);
            }
            if ($cityId <= 0 || !Db::name('system_city')->where('city_id', $cityId)->count()) {
                throw new ApiException('第{:line}行区域不存在', ['line' => $line]);
            }
            $price = $r['price'] ?? '';
            if (!is_numeric($price) || bccomp((string)$price, '0', 2) <= 0) {
                throw new ApiException('第{:line}行价格必须大于0', ['line' => $line]);
            }
            $ot = $r['ot_price'] ?? 0;
            if ($ot === '' || $ot === null) {
                $ot = 0;
            }
            if (!is_numeric($ot) || bccomp((string)$ot, '0', 2) < 0) {
                throw new ApiException('第{:line}行划线价不正确', ['line' => $line]);
            }
            $stock = $r['stock'] ?? null;
            if ($stock === '' || $stock === null) {
                $stock = null;
            } elseif (!is_numeric($stock) || (int)$stock < 0) {
                throw new ApiException('第{:line}行区域库存不正确', ['line' => $line]);
            } else {
                $stock = (int)$stock;
            }
            $clean[$cityId . '|' . $unique] = [
                'product_id' => $productId, 'unique' => $unique, 'city_id' => $cityId,
                'price' => bcadd((string)$price, '0', 2), 'ot_price' => bcadd((string)$ot, '0', 2),
                'stock' => $stock, 'status' => isset($r['status']) ? ((int)$r['status'] ? 1 : 0) : 1,
            ];
        }
        $scope = array_values(array_unique(array_merge(array_map('intval', $scopeCityIds), array_column($clean, 'city_id'))));
        $saved = $deleted = 0;
        Db::transaction(function () use ($productId, $clean, $scope, &$saved, &$deleted, $allowNational) {
            $now = time();
            foreach ($clean as $row) {
                $exist = Db::name('store_product_region_price')->where(['product_id' => $productId, 'unique' => $row['unique'], 'city_id' => $row['city_id']])->find();
                if ($exist) {
                    Db::name('store_product_region_price')->where('id', $exist['id'])->update($row + ['update_time' => $now]);
                } else {
                    Db::name('store_product_region_price')->insert($row + ['add_time' => $now, 'update_time' => $now]);
                }
                $saved++;
            }
            if ($scope) {
                $existing = Db::name('store_product_region_price')->where('product_id', $productId)->whereIn('city_id', $scope)->field('id,unique,city_id')->select()->toArray();
                foreach ($existing as $e) {
                    if (!isset($clean[$e['city_id'] . '|' . $e['unique']])) {
                        Db::name('store_product_region_price')->where('id', $e['id'])->delete();
                        $deleted++;
                    }
                }
            }
            if ($allowNational !== null) {
                if ((int)sys_config('allow_national_price', 0) !== 1 && $allowNational) {
                    throw new ApiException('系统未开启“允许全国价”，无法设置');
                }
                Db::name('store_product')->where('id', $productId)->update(['allow_national_price' => $allowNational ? 1 : 0]);
            }
        });
        app()->make(RegionPriceServices::class)->flush($productId);
        return ['saved' => $saved, 'deleted' => $deleted];
    }

    /**
     * 导入：返回 ['ok'=>n,'fail'=>[['row'=>行,'reason'=>原因]]]；按商品覆盖写入（upsert）
     */
    public function importFile(string $filePath): array
    {
        $rows = \PhpOffice\PhpSpreadsheet\IOFactory::load($filePath)->getActiveSheet()->toArray(null, true, false, false);
        if (!$rows) {
            throw new ApiException('文件内容为空');
        }
        $start = (isset($rows[0][0]) && !is_numeric($rows[0][0]) && (string)$rows[0][0] !== '') ? 1 : 0;
        $ok = 0;
        $fail = [];
        $touched = [];
        $now = time();
        $attrCache = [];
        $cityCache = [];
        for ($i = $start; $i < count($rows); $i++) {
            $r = $rows[$i];
            $line = $i + 1;
            if (!array_filter($r, function ($v) { return $v !== null && $v !== ''; })) {
                continue;
            }
            $pid = (int)($r[0] ?? 0);
            $unique = trim((string)($r[2] ?? ''));
            $cityId = (int)($r[3] ?? 0);
            $price = $r[5] ?? '';
            $ot = $r[6] ?? 0;
            $stock = $r[7] ?? null;
            if ($pid <= 0 || !Db::name('store_product')->where(['id' => $pid, 'is_del' => 0])->count()) {
                $fail[] = ['row' => $line, 'reason' => '商品不存在'];
                continue;
            }
            if (!isset($attrCache[$pid])) {
                $attrCache[$pid] = array_flip(Db::name('store_product_attr_value')->where(['product_id' => $pid, 'type' => 0])->column('unique'));
            }
            if (!isset($attrCache[$pid][$unique])) {
                $fail[] = ['row' => $line, 'reason' => '规格unique不存在'];
                continue;
            }
            if (!isset($cityCache[$cityId])) {
                $cityCache[$cityId] = $cityId > 0 && Db::name('system_city')->where('city_id', $cityId)->count() > 0;
            }
            if (!$cityCache[$cityId]) {
                $fail[] = ['row' => $line, 'reason' => '区域不存在'];
                continue;
            }
            if (!is_numeric($price) || bccomp((string)$price, '0', 2) <= 0) {
                $fail[] = ['row' => $line, 'reason' => '价格必须大于0'];
                continue;
            }
            if ($ot === '' || $ot === null) {
                $ot = 0;
            }
            if (!is_numeric($ot) || bccomp((string)$ot, '0', 2) < 0) {
                $fail[] = ['row' => $line, 'reason' => '划线价不正确'];
                continue;
            }
            if ($stock === '' || $stock === null) {
                $stock = null;
            } elseif (!is_numeric($stock) || (int)$stock < 0) {
                $fail[] = ['row' => $line, 'reason' => '区域库存不正确'];
                continue;
            } else {
                $stock = (int)$stock;
            }
            $data = ['price' => bcadd((string)$price, '0', 2), 'ot_price' => bcadd((string)$ot, '0', 2), 'stock' => $stock, 'status' => 1, 'update_time' => $now];
            $exist = Db::name('store_product_region_price')->where(['product_id' => $pid, 'unique' => $unique, 'city_id' => $cityId])->find();
            if ($exist) {
                Db::name('store_product_region_price')->where('id', $exist['id'])->update($data);
            } else {
                Db::name('store_product_region_price')->insert($data + ['product_id' => $pid, 'unique' => $unique, 'city_id' => $cityId, 'add_time' => $now]);
            }
            $touched[$pid] = 1;
            $ok++;
        }
        $rps = app()->make(RegionPriceServices::class);
        foreach (array_keys($touched) as $pid) {
            $rps->flush((int)$pid);
        }
        return ['ok' => $ok, 'fail' => $fail];
    }

    /**
     * 导出（或模板）：productId=0 且 $template=true 时导出示例模板（含表头）；保存到 public 并返回相对路径
     */
    public function exportFile(int $productId, bool $template = false): string
    {
        $rows = [];
        if ($template && $productId <= 0) {
            $rows[] = [1, '示例规格(仅参考)', 'abcd1234', 910001, 'Hà Nội', '100000.00', '120000.00', ''];
        } else {
            $q = Db::name('store_product_region_price')->alias('rp');
            if ($productId > 0) {
                $q->where('rp.product_id', $productId);
            }
            $list = $q->order('rp.product_id', 'asc')->order('rp.city_id', 'asc')->select()->toArray();
            $suks = [];
            foreach (Db::name('store_product_attr_value')->where('type', 0)->whereIn('product_id', array_unique(array_column($list, 'product_id')) ?: [0])->field('product_id,unique,suk')->select() as $a) {
                $suks[$a['product_id'] . '|' . $a['unique']] = $a['suk'];
            }
            $cityNames = Db::name('system_city')->whereIn('city_id', array_unique(array_column($list, 'city_id')) ?: [0])->column('merger_name', 'city_id');
            foreach ($list as $r) {
                $rows[] = [$r['product_id'], $suks[$r['product_id'] . '|' . $r['unique']] ?? '', $r['unique'], $r['city_id'], $cityNames[$r['city_id']] ?? '', $r['price'], $r['ot_price'], $r['stock']];
            }
        }
        $title = '区域价' . ($template ? '导入模板' : '');
        $path = SpreadsheetExcelService::instance()
            ->setExcelHeader(['product_id', '规格(spec_suk,仅参考)', 'unique', 'city_id', '区域名(仅参考)', 'price', 'ot_price', 'stock(可空=沿用规格库存)'])
            ->setExcelTile($title, $title, date('Y-m-d H:i:s'))
            ->setExcelContent($rows)
            ->excelSave($title . '_' . date('YmdHis'), 'xlsx', true);
        return '/' . ltrim($path, './');
    }
}
