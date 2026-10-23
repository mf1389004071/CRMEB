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

use think\facade\Cache;
use think\facade\Db;

/**
 * 币种：区域价/订单/应付一律本位币；展示币只在展示层换算。
 * 购物车合计与订单总价 = 本位币合计再换算；行价仅展示；展示币金额前缀 ≈（本位币不加）。
 * Class MoneyServices
 * @package app\services\system
 */
class MoneyServices
{
    /**
     * 币种表（缓存 10 分钟，后台修改后失效）
     * @return array [code => row]
     */
    public static function currencies(bool $onlyActive = true): array
    {
        $rows = Cache::get('system_currencies');
        if ($rows === null) {
            $rows = Db::name('system_currency')->order('sort', 'desc')->order('id', 'asc')->select()->toArray();
            Cache::set('system_currencies', $rows, 600);
        }
        $out = [];
        foreach ($rows as $r) {
            if ($onlyActive && (int)$r['status'] !== 1) {
                continue;
            }
            $out[$r['code']] = $r;
        }
        return $out;
    }

    public static function flush(): void
    {
        Cache::delete('system_currencies');
    }

    /**
     * 本位币码
     */
    public static function base(): string
    {
        foreach (self::currencies(false) as $c) {
            if ((int)$c['is_base'] === 1) {
                return $c['code'];
            }
        }
        return (string)sys_config('base_currency', 'VND') ?: 'VND';
    }

    /**
     * 本位币金额 → 展示币金额（四舍五入到该币种小数位，返回字符串）
     */
    public static function convert(string $baseAmount, string $code): string
    {
        $cur = self::currencies(false)[$code] ?? null;
        if (!$cur) {
            return $baseAmount;
        }
        $dp = (int)$cur['decimal_places'];
        $raw = bcmul($baseAmount, (string)$cur['rate'], 8);
        return self::round($raw, $dp);
    }

    /**
     * 格式化：千分位/小数位/符号；非本位币加 ≈ 前缀
     */
    public static function format(string $amount, string $code, bool $withSymbol = true): string
    {
        $cur = self::currencies(false)[$code] ?? null;
        if (!$cur) {
            return $amount;
        }
        $dp = (int)$cur['decimal_places'];
        $n = self::round($amount, $dp);
        [$int, $dec] = array_pad(explode('.', $n), 2, '');
        $neg = strpos($int, '-') === 0;
        $int = ltrim($int, '-');
        $int = strrev(implode($cur['thousand_sep'], str_split(strrev($int), 3)));
        $s = ($neg ? '-' : '') . $int . ($dp > 0 ? $cur['decimal_sep'] . str_pad($dec, $dp, '0') : '');
        if ($withSymbol) {
            $s = $cur['symbol'] . $s;
            if ((int)$cur['is_base'] !== 1) {
                $s = '≈' . $s;
            }
        }
        return $s;
    }

    /**
     * 订单币种快照：['currency_code','exchange_rate','pay_amount_display']
     */
    public static function snapshot(string $baseTotal, ?string $code = null): array
    {
        $code = $code ?: self::resolveDisplayCode();
        $cur = self::currencies(false)[$code] ?? null;
        if (!$cur) {
            $code = self::base();
            $cur = self::currencies(false)[$code] ?? ['rate' => 1];
        }
        return [
            'currency_code'      => $code,
            'exchange_rate'      => (string)$cur['rate'],
            'pay_amount_display' => self::convert($baseTotal, $code),
        ];
    }

    /**
     * 展示币种：Cb-currency 头 → 用户 display_currency → 区域所属国家默认(VN→VND,CN→CNY) → 本位币
     */
    public static function resolveDisplayCode(): string
    {
        $active = self::currencies(true);
        try {
            $request = app()->request;
            $h = strtoupper(trim((string)$request->header('cb-currency')));
            if ($h !== '' && isset($active[$h])) {
                return $h;
            }
            if ($request->hasMacro('uid') && (int)$request->uid() > 0) {
                $user = $request->hasMacro('user') ? $request->user() : null;
                $c = $user ? strtoupper((string)($user['display_currency'] ?? '')) : '';
                if ($c !== '' && isset($active[$c])) {
                    return $c;
                }
            }
            $regionId = function_exists('current_region_id') ? current_region_id() : 0;
            if ($regionId > 0) {
                $node = app()->make(\app\services\vn\RegionServices::class)->node($regionId);
                $map = ['VN' => 'VND', 'CN' => 'CNY'];
                $c = $node ? ($map[$node['country_code']] ?? '') : '';
                if ($c !== '' && isset($active[$c])) {
                    return $c;
                }
            }
        } catch (\Throwable $e) {
        }
        return self::base();
    }

    /**
     * 四舍五入（bcmath，半数进位）
     */
    protected static function round(string $value, int $dp): string
    {
        $neg = bccomp($value, '0', 8) < 0;
        $abs = ltrim($value, '-');
        $half = '0.' . str_repeat('0', $dp) . '5';
        if ($dp === 0) {
            $half = '0.5';
        }
        $r = bcadd(bcadd($abs, $half, $dp + 1), '0', $dp);   // 先加半位再截断 = 半数进位
        return ($neg && bccomp($r, '0', $dp) !== 0 ? '-' : '') . $r;
    }
}
