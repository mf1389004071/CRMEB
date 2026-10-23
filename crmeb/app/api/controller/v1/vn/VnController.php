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
