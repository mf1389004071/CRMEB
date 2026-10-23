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

namespace app\services\system;

use think\facade\Db;

/**
 * eb_system_city.path 重建：形如 ,国家根,省,市,区, （含自身 city_id，首尾逗号）
 * 注意：parent_id 引用的是 city_id，不是 id。
 * Class SystemCityPathServices
 * @package app\services\system
 */
class SystemCityPathServices
{
    /**
     * 全量重建（按 parent_id 迭代回填，防环）
     * @return int 更新的节点数
     */
    public function rebuild(): int
    {
        $rows = Db::name('system_city')->field('id,city_id,parent_id,level,country_code')->select()->toArray();
        $byCity = [];
        foreach ($rows as $r) {
            $byCity[(int)$r['city_id']] = $r;
        }
        // 国家根：level=-1，按 country_code 建索引
        $roots = [];
        foreach ($rows as $r) {
            if ((int)$r['level'] === -1) {
                $roots[$r['country_code']] = (int)$r['city_id'];
            }
        }
        $cache = [];
        $resolve = function (int $cityId) use (&$resolve, &$cache, $byCity, $roots) {
            if (isset($cache[$cityId])) {
                return $cache[$cityId];
            }
            $r = $byCity[$cityId] ?? null;
            if (!$r) {
                return $cache[$cityId] = ',' . $cityId . ',';
            }
            $cache[$cityId] = ',' . $cityId . ',';   // 先占位防环
            if ((int)$r['level'] === -1) {
                return $cache[$cityId] = ',' . $cityId . ',';
            }
            $parent = (int)$r['parent_id'];
            if ($parent > 0 && isset($byCity[$parent])) {
                $path = $resolve($parent) . $cityId . ',';
            } elseif ((int)$r['level'] === 0 && isset($roots[$r['country_code']])) {
                // 省级且无父节点（CN 存量 parent_id=0）：前缀补国家根
                $path = ',' . $roots[$r['country_code']] . ',' . $cityId . ',';
            } else {
                $path = ',' . $cityId . ',';
            }
            return $cache[$cityId] = $path;
        };
        $n = 0;
        Db::transaction(function () use ($rows, $resolve, &$n) {
            foreach ($rows as $r) {
                $path = $resolve((int)$r['city_id']);
                $n += Db::name('system_city')->where('id', $r['id'])->where('path', '<>', $path)->update(['path' => $path]);
            }
        });
        \think\facade\Cache::delete('region_chain_all');
        return $n;
    }
}
