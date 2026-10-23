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

namespace app\services\product;

use app\services\BaseServices;
use app\services\vn\RegionServices;
use crmeb\exceptions\ApiException;
use think\facade\Cache;
use think\facade\Db;

/**
 * 区域价：全站唯一取价入口
 * 规则：按（规格 unique + 区域祖先链）取“最近祖先”的价；不跨兄弟；链上无价=不可售，
 *       除非系统总闸 allow_national_price=1 且商品 allow_national_price=1 才回落规格主表价（全国价）。
 * 库存：区域价行 stock 为 NULL 时沿用规格主表库存；非 NULL 时用区域库存（下单扣/回退该行）。
 * Class RegionPriceServices
 * @package app\services\product
 */
class RegionPriceServices extends BaseServices
{
    const TTL = 300;

    /**
     * 订单取消/退款等无请求区域头的场景，显式指定区域（订单 region_id）
     * @var int|null
     */
    protected static $contextRegion = null;

    /**
     * 在指定区域上下文中执行（库存回退使用订单的区域）
     */
    public static function withRegion(int $regionId, callable $fn)
    {
        $old = self::$contextRegion;
        self::$contextRegion = $regionId;
        try {
            return $fn();
        } finally {
            self::$contextRegion = $old;
        }
    }

    /**
     * 进入区域上下文（不使用闭包的场景），返回旧值供 leaveRegion 还原
     */
    public static function enterRegion(int $regionId): ?int
    {
        $old = self::$contextRegion;
        self::$contextRegion = $regionId;
        return $old;
    }

    public static function leaveRegion(?int $old): void
    {
        self::$contextRegion = $old;
    }

    public function enabled(): bool
    {
        return region_pricing_enabled();
    }

    public function currentRegionId(): int
    {
        return self::$contextRegion !== null ? (int)self::$contextRegion : current_region_id();
    }

    /**
     * 祖先链：[自身, 父…国家根]
     */
    public function chain(int $cityId): array
    {
        return app()->make(RegionServices::class)->chain($cityId);
    }

    /**
     * 是否允许该商品回落全国价
     */
    public function nationalAllowed(int $productId): bool
    {
        if ((int)sys_config('allow_national_price', 0) !== 1) {
            return false;
        }
        return (int)Db::name('store_product')->where('id', $productId)->value('allow_national_price') === 1;
    }

    /**
     * 批量解析商品各规格在区域上的价：[pid => [unique => info]]
     * info: price, ot_price, stock, suk, source(region|national), from_city_id, stock_row(区域库存行id|null)
     */
    public function resolveProducts(array $pids, int $cityId): array
    {
        $pids = array_values(array_unique(array_filter(array_map('intval', $pids))));
        $out = [];
        $miss = [];
        foreach ($pids as $pid) {
            $c = Cache::get($this->cacheKey($pid, $cityId));
            if (is_array($c)) {
                $out[$pid] = $c;
            } else {
                $miss[] = $pid;
            }
        }
        if (!$miss) {
            return $this->attachStocks($out);
        }
        $chain = $this->chain($cityId);
        $rank = array_flip($chain);   // city_id => 0(最近)…
        $attrs = Db::name('store_product_attr_value')->whereIn('product_id', $miss)->where('type', 0)
            ->field('product_id,unique,suk,price,ot_price,stock,is_show')->select()->toArray();
        $rows = $chain ? Db::name('store_product_region_price')->whereIn('product_id', $miss)->whereIn('city_id', $chain)
            ->where('status', 1)->select()->toArray() : [];
        $best = [];
        foreach ($rows as $r) {
            $k = $r['product_id'] . '|' . $r['unique'];
            if (!isset($best[$k]) || $rank[$r['city_id']] < $rank[$best[$k]['city_id']]) {
                $best[$k] = $r;
            }
        }
        $flags = [];
        if ((int)sys_config('allow_national_price', 0) === 1) {
            $flags = Db::name('store_product')->whereIn('id', $miss)->column('allow_national_price', 'id');
        }
        $built = [];
        foreach ($attrs as $a) {
            if ((int)$a['is_show'] === 0) {
                continue;
            }
            $pid = (int)$a['product_id'];
            $k = $pid . '|' . $a['unique'];
            $built[$pid] = $built[$pid] ?? [];
            if (isset($best[$k])) {
                $r = $best[$k];
                $ot = bccomp((string)$r['ot_price'], '0', 2) > 0 ? $r['ot_price'] : $r['price'];
                $built[$pid][$a['unique']] = [
                    'price' => bcadd((string)$r['price'], '0', 2), 'ot_price' => bcadd((string)$ot, '0', 2),
                    'stock' => 0,   // 库存实时附加（见 attachStocks），不进缓存
                    'suk' => $a['suk'], 'source' => 'region', 'from_city_id' => (int)$r['city_id'],
                    'stock_row' => $r['stock'] === null ? null : (int)$r['id'],
                ];
            } elseif (!empty($flags[$pid])) {
                $built[$pid][$a['unique']] = [
                    'price' => bcadd((string)$a['price'], '0', 2), 'ot_price' => bcadd((string)($a['ot_price'] ?: $a['price']), '0', 2),
                    'stock' => 0, 'suk' => $a['suk'], 'source' => 'national', 'from_city_id' => 0, 'stock_row' => null,
                ];
            }
        }
        foreach ($miss as $pid) {
            $out[$pid] = $built[$pid] ?? [];
            Cache::set($this->cacheKey($pid, $cityId), $out[$pid], self::TTL);
        }
        return $this->attachStocks($out);
    }

    /**
     * 实时附加库存：区域库存行(非 NULL)用该行库存，否则用规格主表库存。库存变化频繁，不缓存。
     * @param array $map [pid => [unique => info]]
     * @return array
     */
    protected function attachStocks(array $map): array
    {
        $pids = array_keys($map);
        if (!$pids) {
            return $map;
        }
        $attrStock = [];
        foreach (Db::name('store_product_attr_value')->whereIn('product_id', $pids)->where('type', 0)->field('product_id,unique,stock')->select() as $r) {
            $attrStock[$r['product_id'] . '|' . $r['unique']] = (int)$r['stock'];
        }
        $rowIds = [];
        foreach ($map as $skus) {
            foreach ($skus as $info) {
                if ($info['stock_row'] !== null) {
                    $rowIds[] = $info['stock_row'];
                }
            }
        }
        $rowStock = $rowIds ? Db::name('store_product_region_price')->whereIn('id', $rowIds)->column('stock', 'id') : [];
        foreach ($map as $pid => &$skus) {
            foreach ($skus as $unique => &$info) {
                $info['stock'] = $info['stock_row'] !== null ? (int)($rowStock[$info['stock_row']] ?? 0) : ($attrStock[$pid . '|' . $unique] ?? 0);
            }
            unset($info);
        }
        unset($skus);
        return $map;
    }

    /**
     * 批量取价：$pairs [[pid, unique], …]；返回 ["{pid}_{unique}" => info]，缺失键=不可售
     */
    public function resolveSkus(array $pairs, int $cityId): array
    {
        $pids = array_column($pairs, 0);
        $map = $this->resolveProducts($pids, $cityId);
        $out = [];
        foreach ($pairs as $p) {
            $info = $map[(int)$p[0]][$p[1]] ?? null;
            if ($info) {
                $out[(int)$p[0] . '_' . $p[1]] = $info;
            }
        }
        return $out;
    }

    /**
     * 单规格取价；不可售返回 null
     */
    public function resolveOne(int $productId, string $unique, int $cityId): ?array
    {
        $map = $this->resolveProducts([$productId], $cityId);
        return $map[$productId][$unique] ?? null;
    }

    /**
     * 商品在区域内是否至少有一个可售规格
     */
    public function productSellable(int $productId, int $cityId): bool
    {
        $map = $this->resolveProducts([$productId], $cityId);
        return !empty($map[$productId]);
    }

    /**
     * 列表：附加区域价（取可售规格的最小价），剔除不可售商品
     * @param array $list
     * @param int $cityId
     * @param string $idKey
     * @return array
     */
    public function applyToList(array $list, int $cityId, string $idKey = 'id'): array
    {
        if (!$list) {
            return [];
        }
        $map = $this->resolveProducts(array_column($list, $idKey), $cityId);
        $out = [];
        foreach ($list as $item) {
            $skus = $map[(int)$item[$idKey]] ?? [];
            if (!$skus) {
                continue;
            }
            $min = null;
            $stock = 0;
            foreach ($skus as $s) {
                if ($min === null || bccomp($s['price'], $min['price'], 2) < 0) {
                    $min = $s;
                }
                $stock += (int)$s['stock'];
            }
            $item['price'] = $min['price'];
            if (array_key_exists('ot_price', $item)) {
                $item['ot_price'] = $min['ot_price'];
            }
            if (array_key_exists('stock', $item)) {
                $item['stock'] = $stock;
            }
            if (array_key_exists('vip_price', $item)) {
                $item['vip_price'] = 0;
            }
            $out[] = $item;
        }
        return $out;
    }

    /**
     * 规格列表（getProductAttrDetail 的 $values，键为 suk）：覆盖区域价/库存，剔除不可售规格
     * @param int $productId
     * @param array $values [suk => ['unique'=>..,'price'=>..,…]]
     * @param int $cityId
     * @return array
     */
    public function applyToAttr(int $productId, array $values, int $cityId): array
    {
        $skus = $this->resolveProducts([$productId], $cityId)[$productId] ?? [];
        $out = [];
        foreach ($values as $suk => $v) {
            $info = $skus[$v['unique']] ?? null;
            if (!$info) {
                continue;
            }
            $v['price'] = $info['price'];
            $v['ot_price'] = $info['ot_price'];
            $v['stock'] = $info['stock'];
            $v['vip_price'] = 0;
            $out[$suk] = $v;
        }
        return $out;
    }

    /**
     * 订单创建前校验（购物车行）：区域不可售抛错；价格与当前区域服务端价不一致抛错（要求重新确认订单）
     * @param array $cartInfo createOrder 缓存的 cartInfo
     */
    public function assertCartMatches(array $cartInfo, int $cityId): void
    {
        if ($cityId <= 0) {
            throw new ApiException('请先选择配送区域');
        }
        foreach ($cartInfo as $cart) {
            if (!empty($cart['seckill_id']) || !empty($cart['bargain_id']) || !empty($cart['combination_id']) || !empty($cart['advance_id'])) {
                continue;
            }
            $pid = (int)($cart['product_id'] ?? $cart['productInfo']['id'] ?? 0);
            $unique = (string)($cart['productInfo']['attrInfo']['unique'] ?? $cart['product_attr_unique'] ?? '');
            $info = $unique !== '' ? $this->resolveOne($pid, $unique, $cityId) : null;
            if (!$info) {
                throw new ApiException('商品 {:name} 当前区域不可售', ['name' => $cart['productInfo']['store_name'] ?? '']);
            }
            // 缓存行单价（会员折扣已关闭，truePrice 应与区域价一致）
            $cached = isset($cart['truePrice']) ? bcadd((string)$cart['truePrice'], '0', 2) : null;
            if ($cached !== null && bccomp($cached, $info['price'], 2) !== 0) {
                throw new ApiException('商品价格已变化，请重新确认订单');
            }
            if ((int)$cart['cart_num'] > (int)$info['stock']) {
                throw new ApiException('该商品库存不足{:num}', ['num' => (int)$cart['cart_num']]);
            }
        }
    }

    /**
     * 商品 scope：当前区域链上至少有一个有效价目，或允许全国价
     * @param \think\db\Query|\think\Model $query
     * @param int $cityId
     */
    public function visibleScope($query, int $cityId): void
    {
        $chain = $this->chain($cityId);
        $prefix = (string)config('database.connections.mysql.prefix', 'eb_');
        $product = $prefix . 'store_product';
        $rp = $prefix . 'store_product_region_price';
        $allowSys = (int)sys_config('allow_national_price', 0) === 1;
        $in = $chain ? implode(',', array_map('intval', $chain)) : '0';
        $sql = "EXISTS (SELECT 1 FROM `{$rp}` rp WHERE rp.product_id = `{$product}`.id AND rp.status = 1 AND rp.city_id IN ({$in}))";
        if ($allowSys) {
            $sql = "({$sql} OR `{$product}`.allow_national_price = 1)";
        }
        $query->whereRaw($sql);
    }

    /**
     * 区域库存扣减：命中区域库存行返回 true/false(库存不足)；未使用区域库存返回 null（沿用主表）
     */
    public function decRegionStock(int $productId, string $unique, int $num): ?bool
    {
        $info = $this->resolveOne($productId, $unique, $this->currentRegionId());
        if (!$info || $info['stock_row'] === null) {
            return null;
        }
        $n = Db::name('store_product_region_price')->where('id', $info['stock_row'])->where('stock', '>=', $num)->dec('stock', $num)->update();
        $this->flush($productId);
        return $n > 0;
    }

    /**
     * 区域库存回退
     */
    public function incRegionStock(int $productId, string $unique, int $num): ?bool
    {
        $info = $this->resolveOne($productId, $unique, $this->currentRegionId());
        if (!$info || $info['stock_row'] === null) {
            return null;
        }
        Db::name('store_product_region_price')->where('id', $info['stock_row'])->inc('stock', $num)->update();
        $this->flush($productId);
        return true;
    }

    /**
     * 区域价变更后失效该商品的价目缓存
     */
    public function flush(int $productId): void
    {
        Cache::set('region_price_ver_' . $productId, ((int)Cache::get('region_price_ver_' . $productId, 1)) + 1, 0);
    }

    protected function cacheKey(int $pid, int $cityId): string
    {
        return 'region_price:' . (int)Cache::get('region_price_ver_' . $pid, 1) . ':' . RegionServices::version() . ':' . $pid . ':' . $cityId;
    }
}
