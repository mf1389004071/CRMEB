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

namespace app\services\user;

use think\exception\ValidateException;
use think\facade\Cache;
use think\facade\Db;

/**
 * 国际手机号：清洗/规范化/校验（按 eb_phone_country 字典）
 * 约定：本地号(national)=去区号、去干线前缀(VN 的 0)后的纯数字；e164 = '+'区号本地号。
 * Class PhoneServices
 * @package app\services\user
 */
class PhoneServices
{
    /**
     * 清洗：去空格、-、()、. 等所有非数字（保留首位 +）
     */
    public static function clean(string $raw): string
    {
        $raw = trim($raw);
        $plus = (substr($raw, 0, 1) === '+') ? '+' : '';
        return $plus . preg_replace('/\D+/', '', $raw);
    }

    /**
     * 区号字典（缓存 10 分钟）
     * @return array [ '+84' => row ]
     */
    public static function countries(): array
    {
        $rows = Cache::get('phone_countries');
        if ($rows === null) {
            $rows = Db::name('phone_country')->where('status', 1)->order('sort', 'desc')->select()->toArray();
            Cache::set('phone_countries', $rows, 600);
        }
        return array_column($rows, null, 'code');
    }

    /**
     * 规范化
     * @param string $countryCode 如 '+84'、'84'、''（空取 default_phone_country）
     * @param string $raw 用户输入，如 '+84 0912-345-678'、'0912345678'、'912345678'
     * @return array ['country_code'=>'+84','national'=>'912345678','e164'=>'+84912345678']
     */
    public static function normalize(string $countryCode, string $raw): array
    {
        $countryCode = trim($countryCode) !== '' ? trim($countryCode) : (string)sys_config('default_phone_country', '+84');
        $cc = '+' . ltrim(preg_replace('/[^\d+]/', '', $countryCode), '+');
        $ccDigits = ltrim($cc, '+');
        $country = self::countries()[$cc] ?? null;
        $maxLen = $country ? (int)$country['max_len'] : 15;
        $trunk = $country ? (string)$country['trunk_prefix'] : '';

        $clean = self::clean($raw);
        $hadPlus = substr($clean, 0, 1) === '+';
        $digits = ltrim($clean, '+');
        if (strpos($digits, '00') === 0 && !$hadPlus && strpos(substr($digits, 2), $ccDigits) === 0) {
            $digits = substr($digits, 2);
            $hadPlus = true;
        }
        // 带国际前缀：去掉区号
        if (($hadPlus || strlen($digits) > $maxLen) && $ccDigits !== '' && strpos($digits, $ccDigits) === 0) {
            $digits = substr($digits, strlen($ccDigits));
        }
        // 去干线前缀（VN 的 0）
        if ($trunk !== '' && strpos($digits, $trunk) === 0) {
            $digits = substr($digits, strlen($trunk));
        }
        return ['country_code' => $cc, 'national' => $digits, 'e164' => $cc . $digits];
    }

    /**
     * 校验：按字典的长度/正则；失败抛 ValidateException('手机号格式不正确')
     */
    public static function validate(string $countryCode, string $raw): bool
    {
        $n = self::normalize($countryCode, $raw);
        $country = self::countries()[$n['country_code']] ?? null;
        $national = $n['national'];
        $ok = $national !== '' && ctype_digit($national);
        if ($ok) {
            if ($country) {
                $len = strlen($national);
                $ok = $len >= (int)$country['min_len'] && $len <= (int)$country['max_len'];
                if ($ok && $country['pattern'] !== '') {
                    $ok = (bool)preg_match('/' . str_replace('/', '\/', $country['pattern']) . '/', $national);
                }
            } else {
                // 字典外的区号：E.164 总长度 8~15
                $ok = strlen($national) >= 6 && strlen($national) + strlen(ltrim($n['country_code'], '+')) <= 15;
            }
        }
        if (!$ok) {
            throw new ValidateException('手机号格式不正确');
        }
        return true;
    }
}
