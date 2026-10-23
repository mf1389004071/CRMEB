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

/**
 * 越南站点开关：营销/无关入口的裁剪（M10-3）
 * Class VnSiteServices
 * @package app\services\vn
 */
class VnSiteServices extends BaseServices
{
    /**
     * 越南模式下隐藏的“我的”菜单链接（与前端 $permission/vnMode 配套，后端接口保留）
     * @return array
     */
    public function hiddenMenuUrls(): array
    {
        return [
            '/pages/annex/vip_paid/index',          // 付费会员
            '/pages/users/user_invoice_list/index', // 发票管理
            '/pages/users/user_integral/index',     // 积分中心
            '/pages/users/user_coupon/index',       // 优惠券
            '/pages/users/user_money/index',        // 余额
            '/pages/users/user_spread_user/index',  // 推广
            '/pages/annex/settled/index',           // 分销申请
            '/pages/activity/bargain/index',        // 砍价记录
            '/pages/users/user_vip/index',          // 会员等级
            '/pages/extension/customer_list/chat',  // 站内客服（改为联系方式页）
        ];
    }

    /**
     * 规范化登录/注册账号：区号数字 + 去前导 0 的本地号，如 +84 0912-345-678 → 84912345678
     * 优先使用 PhoneServices（M8），不存在时按通用规则处理
     * @param string $countryCode 如 +84 / 84，空则取 default_phone_country
     * @param string $raw 用户输入
     * @return string 规范化后的账号（纯数字），无法识别返回空串
     */
    public function accountOf(string $countryCode, string $raw): string
    {
        $countryCode = $countryCode !== '' ? $countryCode : (string)sys_config('default_phone_country', '+84');
        $cls = '\\app\\services\\user\\PhoneServices';
        if (class_exists($cls)) {
            $n = $cls::normalize($countryCode, $raw);
            // 空号码/无本地号：返回空串（避免所有“无手机号”用户共用同一个账号键）
            return $n['national'] === '' ? '' : ltrim($n['e164'], '+');
        }
        $cc = preg_replace('/\D+/', '', $countryCode);
        $num = preg_replace('/\D+/', '', $raw);
        if ($num === '') {
            return '';
        }
        // 已带区号则不重复拼接
        if ($cc !== '' && strpos($num, $cc) === 0 && strlen($num) > strlen($cc) + 6) {
            $num = substr($num, strlen($cc));
        }
        return $cc . ltrim($num, '0');
    }

    /**
     * 过滤“我的”菜单；站内客服替换为联系方式入口
     * @param array $menus
     * @return array
     */
    public function filterUserMenus(array $menus): array
    {
        if (!vn_mode_enabled()) {
            return $menus;
        }
        $hidden = $this->hiddenMenuUrls();
        $contactPic = '';
        $out = [];
        foreach ($menus as $item) {
            $url = $item['url'] ?? '';
            if ($url === '/pages/extension/customer_list/chat') {
                $contactPic = $item['pic'] ?? '';
            }
            if (in_array($url, $hidden, true)) {
                continue;
            }
            $out[] = $item;
        }
        $has = false;
        foreach ($out as $item) {
            if (($item['url'] ?? '') === '/pages/users/contact/index') {
                $has = true;
            }
        }
        if (!$has) {
            $out[] = [
                'id'      => 0,
                'name'    => '联系我们',
                'url'     => '/pages/users/contact/index',
                'pic'     => $contactPic,
                'sort'    => 0,
                'status'  => 1,
                'is_show' => 1,
            ];
        }
        return $out;
    }
}
