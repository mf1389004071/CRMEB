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

namespace app\api\controller\v1\vn;

use app\Request;

/**
 * 越南站点公共接口（联系方式等）
 * Class VnController
 * @package app\api\controller\v1\vn
 */
class VnController
{
    /**
     * 币种列表、汇率与本次请求的默认展示币种（本位币金额在展示层按此换算）
     * @return mixed
     */
    public function currency()
    {
        $list = [];
        foreach (\app\services\system\MoneyServices::currencies(true) as $c) {
            $list[] = [
                'code' => $c['code'], 'symbol' => $c['symbol'], 'name' => $c['name_' . substr(current_lang_code(), 0, 2)] ?? $c['name_en'],
                'name_zh' => $c['name_zh'], 'name_vi' => $c['name_vi'], 'name_en' => $c['name_en'],
                'decimal_places' => (int)$c['decimal_places'], 'thousand_sep' => $c['thousand_sep'], 'decimal_sep' => $c['decimal_sep'],
                'rate' => $c['rate'], 'is_base' => (int)$c['is_base'],
            ];
        }
        return app('json')->success([
            'base'            => \app\services\system\MoneyServices::base(),
            'default_display' => \app\services\system\MoneyServices::resolveDisplayCode(),
            'list'            => $list,
        ]);
    }

    /**
     * 保存用户展示币种（需登录）
     * @param Request $request
     * @return mixed
     */
    public function setCurrency(Request $request)
    {
        [$code] = $request->postMore([['currency', '']], true);
        $code = strtoupper(trim((string)$code));
        if (!isset(\app\services\system\MoneyServices::currencies(true)[$code])) {
            return app('json')->fail('参数错误');
        }
        \app\model\user\User::where('uid', (int)$request->uid())->update(['display_currency' => $code]);
        return app('json')->success(['currency' => $code]);
    }

    /**
     * 保存用户语种（需登录）：规范化后必须在启用语言内
     * @param Request $request
     * @return mixed
     */
    public function setLocale(Request $request)
    {
        [$locale] = $request->postMore([['locale', '']], true);
        $locale = normalize_lang_code((string)$locale);
        $enabled = \think\facade\Db::name('lang_type')->where(['status' => 1, 'is_del' => 0])->column('file_name');
        $enabled = array_map('normalize_lang_code', $enabled);
        if ($locale === '' || !in_array($locale, $enabled, true)) {
            return app('json')->fail('当前语言不可用');
        }
        \app\model\user\User::where('uid', (int)$request->uid())->update(['locale' => $locale]);
        return app('json')->success(['locale' => $locale]);
    }

    /**
     * 手机区号字典（名称按当前语言）
     * @return mixed
     */
    public function phoneCountries()
    {
        $lang = current_lang_code();
        $out = [];
        foreach (\app\services\user\PhoneServices::countries() as $c) {
            $name = $lang === 'vi-VN' ? $c['name_vi'] : ($lang === 'en-US' ? $c['name_en'] : $c['name']);
            $out[] = ['code' => $c['code'], 'country_code' => $c['country_code'], 'name' => $name ?: $c['name'], 'min_len' => (int)$c['min_len'], 'max_len' => (int)$c['max_len']];
        }
        return app('json')->success($out);
    }

    /**
     * 清空当前用户购物车（切换配送区域时调用）
     * @param Request $request
     * @return mixed
     */
    public function clearCart(Request $request)
    {
        $uid = (int)$request->uid();
        $n = \app\model\order\StoreCart::where(['uid' => $uid, 'is_new' => 0, 'is_pay' => 0])->delete();
        return app('json')->success(['cleared' => $n]);
    }

    /**
     * 联系方式列表（组合数据 vn_contact，仅 status=1，由 sys_data 过滤）
     * @param Request $request
     * @return mixed
     */
    public function contacts(Request $request)
    {
        $list = sys_data('vn_contact') ?: [];
        $out = [];
        foreach ($list as $item) {
            if (empty($item['account']) && empty($item['qrcode_url'])) {
                continue;
            }
            $out[] = [
                'type'       => $item['type'] ?? '',
                'account'    => $item['account'] ?? '',
                'qrcode_url' => $item['qrcode_url'] ?? '',
            ];
        }
        return app('json')->success($out);
    }
}
