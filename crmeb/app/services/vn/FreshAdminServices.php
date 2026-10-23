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
use crmeb\exceptions\ApiException;
use think\facade\Db;

/**
 * 后台：商品生鲜属性读写与校验
 * Class FreshAdminServices
 * @package app\services\vn
 */
class FreshAdminServices extends BaseServices
{
    const FIELDS = ['is_fresh', 'net_weight', 'shelf_life_days', 'shelf_life_text', 'origin', 'need_cold_chain', 'cold_chain_note', 'tax_rate'];

    public function get(int $productId): array
    {
        $row = Db::name('store_product')->where(['id' => $productId, 'is_del' => 0])->field('id,store_name,unit_name,' . implode(',', self::FIELDS))->find();
        if (!$row) {
            throw new ApiException('商品不存在');
        }
        return $row;
    }

    /**
     * 保存：is_fresh=1 时产地必填；保质期天数 >= 0；净含量/税率 >= 0
     */
    public function save(int $productId, array $d): bool
    {
        $this->get($productId);
        $isFresh = !empty($d['is_fresh']) ? 1 : 0;
        $origin = trim((string)($d['origin'] ?? ''));
        if ($isFresh && $origin === '') {
            throw new ApiException('生鲜商品必须填写产地');
        }
        $days = $d['shelf_life_days'] ?? 0;
        if ($days === '' || $days === null) {
            $days = 0;
        }
        if (!is_numeric($days) || (int)$days < 0) {
            throw new ApiException('保质期天数不能小于0');
        }
        $weight = $d['net_weight'] ?? 0;
        if ($weight === '' || $weight === null) {
            $weight = 0;
        }
        if (!is_numeric($weight) || bccomp((string)$weight, '0', 2) < 0) {
            throw new ApiException('净含量不能小于0');
        }
        $tax = $d['tax_rate'] ?? 0;
        if ($tax === '' || $tax === null) {
            $tax = 0;
        }
        if (!is_numeric($tax) || bccomp((string)$tax, '0', 2) < 0 || bccomp((string)$tax, '100', 2) > 0) {
            throw new ApiException('税率范围为0~100');
        }
        Db::name('store_product')->where('id', $productId)->update([
            'is_fresh'        => $isFresh,
            'net_weight'      => bcadd((string)$weight, '0', 2),
            'shelf_life_days' => (int)$days,
            'shelf_life_text' => mb_substr(trim((string)($d['shelf_life_text'] ?? '')), 0, 64),
            'origin'          => mb_substr($origin, 0, 64),
            'need_cold_chain' => !empty($d['need_cold_chain']) ? 1 : 0,
            'cold_chain_note' => mb_substr(trim((string)($d['cold_chain_note'] ?? '')), 0, 128),
            'tax_rate'        => bcadd((string)$tax, '0', 2),
        ]);
        return true;
    }
}
