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
            '/pages/users/user_spread_code/index',  // 推广码
            '/pages/users/promoter-order/index',    // 推广订单
            '/pages/users/user_cash/index',         // 提现
            '/pages/users/user_payment/index',      // 充值
            '/pages/users/commission_rank/index',   // 佣金排行
            '/pages/annex/settled/index',           // 分销申请
            '/pages/activity/bargain/index',        // 砍价记录
            '/pages/activity/goods_seckill/index',  // 秒杀
            '/pages/activity/goods_combination/index', // 拼团
            '/pages/activity/goods_bargain/index',  // 砍价
            '/pages/activity/presell/index',        // 预售
            '/pages/users/user_vip/index',          // 会员等级
            '/pages/users/user_get_coupon/index',   // 领券
            '/pages/extension/customer_list/chat',  // 站内客服（改为联系方式页）
            '/pages/users/user_sgin/index',         // 签到
            '/pages/points_mall/index',             // 积分商城
        ];
    }

    /**
     * 越南模式下后台侧栏隐藏的 unique_auth（页面级 auth_type=1）；接口权限保留
     * @return string[]
     */
    public function hiddenAdminUniqueAuths(): array
    {
        return [
            'setting-system-city',           // 官方城市数据（销售区划请用配送区域）
            'admin-wechat',                  // 公众号
            'admin-routine',                 // 小程序
            'admin-app',                     // APP
            'admin-pc',                      // PC
            'finance-user_extract-index',    // 提现
            'finance-user-recharge-index',   // 充值
            'finance-finance-index',         // 佣金
            'finance-balance-index',         // 余额记录
            'cms-article-index',
            'cms-article-category',
            'admin-order-offline',           // 收银订单
            'setting-merchant-system-verify-order',
            'marketing-channel_code-index',
        ];
    }

    /**
     * 越南模式下隐藏的后台顶级菜单 id（分销/营销/财务/内容/应用/客服）
     * @return int[]
     */
    public function hiddenAdminTopMenuIds(): array
    {
        return [26, 27, 35, 43, 135, 165];
    }

    /**
     * 过滤后台侧栏菜单集合（Model 列表或数组）
     * @param iterable $menusList
     * @return array
     */
    public function filterAdminMenus($menusList): array
    {
        $hideAuth = array_flip($this->hiddenAdminUniqueAuths());
        $hideTop = array_flip($this->hiddenAdminTopMenuIds());
        $hidePathNeedle = [
            '/setting/freight/city/list',
            '/marketing/',
            '/agent/',
            '/finance/',
            '/cms/',
            '/app/',
            '/kefu',
        ];
        $out = [];
        foreach ($menusList as $item) {
            $d = (is_object($item) && method_exists($item, 'getData')) ? $item->getData() : (array)$item;
            $id = (int)($d['id'] ?? 0);
            $pid = (int)($d['pid'] ?? 0);
            $auth = (string)($d['unique_auth'] ?? '');
            $path = (string)($d['menu_path'] ?? '');
            if (isset($hideTop[$id]) || isset($hideTop[$pid])) {
                continue;
            }
            if ($auth !== '' && isset($hideAuth[$auth])) {
                continue;
            }
            $skip = false;
            foreach ($hidePathNeedle as $n) {
                if ($path !== '' && strpos($path, $n) !== false) {
                    $skip = true;
                    break;
                }
            }
            if ($skip) {
                continue;
            }
            $out[] = $item;
        }
        return $out;
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
