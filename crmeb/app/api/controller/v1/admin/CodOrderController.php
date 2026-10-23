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

namespace app\api\controller\v1\admin;

use app\Request;
use app\model\order\StoreOrder;
use app\services\order\CodOrderServices;
use crmeb\exceptions\ApiException;

/**
 * H5 员工端（配送员/核销员/订单管理员）：到付订单送达核销
 * Class CodOrderController
 * @package app\api\controller\v1\admin
 */
class CodOrderController
{
    /**
     * @var CodOrderServices
     */
    protected $services;

    public function __construct(CodOrderServices $services)
    {
        $this->services = $services;
    }

    /**
     * 当前员工作为操作人
     * @param Request $request
     * @return array
     */
    protected function operator(Request $request): array
    {
        $user = $request->hasMacro('user') ? $request->user() : [];
        return [
            'id'   => (int)$request->uid(),
            'type' => 'staff',
            'name' => (string)(is_array($user) || $user instanceof \ArrayAccess ? ($user['nickname'] ?? '') : ''),
        ];
    }

    /**
     * 核销：订单号+核销码，或仅 6 位核销码
     * @param Request $request
     * @return mixed
     */
    public function verify(Request $request)
    {
        [$orderId, $code] = $request->postMore([
            ['order_id', ''],
            ['code', ''],
        ], true);
        $orderId = trim((string)$orderId);
        $code = trim((string)$code);
        if ($orderId === '' && $code === '') {
            return app('json')->fail('核销码格式不正确');
        }
        $data = $orderId !== ''
            ? $this->services->verifyDelivered($orderId, $code, $this->operator($request))
            : $this->services->verifyDelivered($code, null, $this->operator($request));
        return app('json')->success($data);
    }

    /**
     * 核销前查看订单摘要（不返回核销码）：order_id 或 6 位 code
     * @param Request $request
     * @return mixed
     */
    public function detail(Request $request)
    {
        [$orderId, $code] = $request->getMore([
            ['order_id', ''],
            ['code', ''],
        ], true);
        $query = StoreOrder::where(['is_cod' => 1, 'is_del' => 0, 'is_cancel' => 0]);
        if ($orderId !== '') {
            $query->where('order_id', trim((string)$orderId));
        } elseif ($code !== '' && preg_match('/^[0-9]{6}$/', trim((string)$code))) {
            $query->where('cod_delivery_code', trim((string)$code))->where('fulfil_status', '<', CodOrderServices::F_DELIVERED);
        } else {
            throw new ApiException('核销码格式不正确');
        }
        $order = $query->find();
        if (!$order) {
            throw new ApiException('核销码错误或订单不可核销');
        }
        return app('json')->success([
            'order_id'       => $order['order_id'],
            'real_name'      => $order['real_name'],
            'user_phone'     => $order['user_phone'],
            'user_address'   => $order['user_address'],
            'cod_receivable' => $order['cod_receivable'],
            'paid'           => (int)$order['paid'],
            'fulfil_status'  => (int)$order['fulfil_status'],
        ]);
    }
}
