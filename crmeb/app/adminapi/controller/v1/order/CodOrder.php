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

namespace app\adminapi\controller\v1\order;

use app\adminapi\controller\AuthController;
use app\services\order\CodOrderServices;
use app\services\order\CodPrintServices;
use app\services\order\OrderAuditServices;
use think\facade\App;

/**
 * 到付(货到付款)订单管理
 * Class CodOrder
 * @package app\adminapi\controller\v1\order
 */
class CodOrder extends AuthController
{
    /**
     * @var CodOrderServices
     */
    protected $services;

    public function __construct(App $app, CodOrderServices $services)
    {
        parent::__construct($app);
        $this->services = $services;
    }

    /**
     * 当前操作人
     * @return array
     */
    protected function operator(): array
    {
        return app()->make(OrderAuditServices::class)->operatorFromRequest();
    }

    /**
     * 到付订单列表
     * @return mixed
     */
    public function lst()
    {
        $where = $this->request->getMore([
            ['fulfil_status', ''],
            ['region_id', 0],
            ['date_start', ''],
            ['date_end', ''],
            ['keyword', ''],
            ['paid', ''],
            ['is_cancel', ''],
            ['page', 1],
            ['limit', 20],
        ]);
        return app('json')->success($this->services->getList($where));
    }

    /**
     * 确认接单
     */
    public function confirm($id)
    {
        $this->services->confirm((int)$id, $this->operator());
        return app('json')->success('操作成功');
    }

    /**
     * 开始配送
     */
    public function delivering($id)
    {
        $driver = $this->request->postMore([
            ['delivery_uid', 0],
            ['delivery_name', ''],
            ['delivery_id', ''],
        ]);
        $this->services->startDelivery((int)$id, $driver, $this->operator());
        return app('json')->success('操作成功');
    }

    /**
     * 后台直接标记已送达
     */
    public function delivered($id)
    {
        $this->services->markDelivered((int)$id, $this->operator());
        return app('json')->success('操作成功');
    }

    /**
     * 送达核销（order_id + code，或仅 code）
     */
    public function verify()
    {
        [$orderId, $code] = $this->request->postMore([
            ['order_id', ''],
            ['code', ''],
        ], true);
        if ($orderId === '' && $code === '') {
            return app('json')->fail('核销码格式不正确');
        }
        $data = $orderId !== ''
            ? $this->services->verifyDelivered((string)$orderId, (string)$code, $this->operator())
            : $this->services->verifyDelivered((string)$code, null, $this->operator());
        return app('json')->success($data);
    }

    /**
     * 确认收款
     */
    public function collect($id)
    {
        [$received, $remark] = $this->request->postMore([
            ['received', ''],
            ['remark', ''],
        ], true);
        $this->services->collect((int)$id, (string)$received, (string)$remark, $this->operator());
        return app('json')->success('操作成功');
    }

    /**
     * 后台取消
     */
    public function cancel($id)
    {
        [$reason] = $this->request->postMore([['reason', '']], true);
        $this->services->adminCancel((int)$id, (string)$reason, $this->operator());
        return app('json')->success('操作成功');
    }

    /**
     * 标记“需电话确认”
     */
    public function call_mark($id)
    {
        [$need] = $this->request->postMore([['need', 1]], true);
        $this->services->callMark((int)$id, (int)$need, $this->operator());
        return app('json')->success('操作成功');
    }

    /**
     * 操作记录（含操作人）
     */
    public function audit($id)
    {
        return app('json')->success(app()->make(OrderAuditServices::class)->getList((int)$id));
    }

    /**
     * 配送单打印数据（不含送达码）
     */
    public function print_data()
    {
        [$ids, $date, $regionId, $lang] = $this->request->getMore([
            ['ids', ''],
            ['date', ''],
            ['region_id', 0],
            ['lang', 'vi-VN'],
        ], true);
        /** @var CodPrintServices $print */
        $print = app()->make(CodPrintServices::class);
        $oids = $print->resolveOrderIds(['ids' => $ids, 'date' => $date, 'region_id' => $regionId]);
        $data = $print->printData($oids, (string)$lang);
        $audit = app()->make(OrderAuditServices::class);
        $operator = $this->operator();
        foreach ($oids as $oid) {
            $audit->record((int)$oid, OrderAuditServices::T_PRINT, '打印配送单(' . $lang . ')', $operator);
        }
        return app('json')->success($data);
    }

    /**
     * 拣货汇总
     */
    public function pick_summary()
    {
        [$ids, $date, $regionId, $lang] = $this->request->getMore([
            ['ids', ''],
            ['date', ''],
            ['region_id', 0],
            ['lang', 'vi-VN'],
        ], true);
        /** @var CodPrintServices $print */
        $print = app()->make(CodPrintServices::class);
        $oids = $print->resolveOrderIds(['ids' => $ids, 'date' => $date, 'region_id' => $regionId]);
        return app('json')->success(['order_count' => count($oids), 'list' => $print->pickSummary($oids, (string)$lang)]);
    }

    /**
     * 导出 Excel：type=orders|pick，返回下载地址
     */
    public function export()
    {
        [$type, $ids, $date, $regionId, $lang] = $this->request->getMore([
            ['type', 'orders'],
            ['ids', ''],
            ['date', ''],
            ['region_id', 0],
            ['lang', 'vi-VN'],
        ], true);
        /** @var CodPrintServices $print */
        $print = app()->make(CodPrintServices::class);
        $oids = $print->resolveOrderIds(['ids' => $ids, 'date' => $date, 'region_id' => $regionId]);
        return app('json')->success(['url' => $print->export((string)$type, $oids, (string)$lang)]);
    }

    /**
     * 新订单轮询
     */
    public function new_orders()
    {
        [$sinceId] = $this->request->getMore([['since_id', 0]], true);
        return app('json')->success($this->services->newOrders((int)$sinceId));
    }
}
