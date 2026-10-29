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

namespace app\services\order;

use app\dao\order\StoreOrderDao;
use app\model\order\StoreOrder;
use app\services\BaseServices;
use app\services\pay\OrderOfflineServices;
use crmeb\exceptions\ApiException;

/**
 * 到付(货到付款)订单：履约状态机、送达核销、收款、取消
 * 履约：0待确认 → 1备货中 → 2发货中 → 3已送达；收款(paid=1)与履约独立，送达且已收款后完结(status=3)
 * Class CodOrderServices
 * @package app\services\order
 */
class CodOrderServices extends BaseServices
{
    const F_PENDING = 0;
    const F_STOCKUP = 1;
    const F_DELIVERING = 2;
    const F_DELIVERED = 3;

    /**
     * @param StoreOrderDao $dao
     */
    public function __construct(StoreOrderDao $dao)
    {
        $this->dao = $dao;
    }

    /**
     * 到付单创建后钩子（pay offline 分支之后调用，幂等）
     * @param array $order
     */
    public function onCreated(array $order): void
    {
        if (!vn_mode_enabled()) {
            return;
        }
        $row = StoreOrder::where('id', (int)$order['id'])->find();
        if (!$row || (int)$row['is_cod'] === 1 || (int)$row['paid'] === 1) {
            return;
        }
        $fulfil = (int)sys_config('cod_auto_stock_up', 1) === 1 ? self::F_STOCKUP : self::F_PENDING;
        $data = [
            'is_cod'            => 1,
            'fulfil_status'     => $fulfil,
            'cod_delivery_code' => $this->genDeliveryCode(),
            'cod_receivable'    => $row['pay_price'],
            'lang'              => current_lang_code(),
            'region_id'         => (int)$row['region_id'] ?: (function_exists('current_region_id') ? (int)current_region_id() : 0),
            'client_ip'         => app()->make(OrderRiskServices::class)->clientIp(),
        ];
        if (class_exists(\app\services\system\MoneyServices::class)) {
            $data = array_merge($data, \app\services\system\MoneyServices::snapshot((string)$row['pay_price']));
        }
        StoreOrder::where('id', (int)$row['id'])->update($data);
        app()->make(OrderAuditServices::class)->record(
            (int)$row['id'], OrderAuditServices::T_CREATED,
            $fulfil === self::F_STOCKUP ? '到付订单创建，已进入备货中' : '到付订单创建，待确认'
        );
    }

    /**
     * 后台：确认接单 0→1
     */
    public function confirm(int $oid, array $operator = []): bool
    {
        $order = $this->getCodOrder($oid);
        if ((int)$order['fulfil_status'] !== self::F_PENDING) {
            throw new ApiException('订单不是待确认状态');
        }
        return $this->transaction(function () use ($oid, $operator) {
            $n = StoreOrder::where(['id' => $oid, 'fulfil_status' => self::F_PENDING, 'is_cancel' => 0])->update(['fulfil_status' => self::F_STOCKUP]);
            if (!$n) {
                throw new ApiException('订单状态已变化，请刷新后重试');
            }
            app()->make(OrderAuditServices::class)->record($oid, OrderAuditServices::T_CONFIRM, '确认接单，进入备货中', $operator);
            return true;
        });
    }

    /**
     * 后台：开始配送 (0|1)→2，可附配送员/司机信息
     * @param array $driver ['delivery_uid'=>int,'delivery_name'=>string,'delivery_id'=>司机电话]
     */
    public function startDelivery(int $oid, array $driver = [], array $operator = []): bool
    {
        $order = $this->getCodOrder($oid);
        if (!in_array((int)$order['fulfil_status'], [self::F_PENDING, self::F_STOCKUP], true)) {
            throw new ApiException('当前状态不能开始配送');
        }
        return $this->transaction(function () use ($oid, $driver, $operator) {
            $data = ['fulfil_status' => self::F_DELIVERING, 'delivery_type' => 'send'];
            foreach (['delivery_uid', 'delivery_name', 'delivery_id'] as $k) {
                if (isset($driver[$k]) && $driver[$k] !== '') {
                    $data[$k] = $driver[$k];
                }
            }
            $n = StoreOrder::where(['id' => $oid, 'is_cancel' => 0])->whereIn('fulfil_status', [self::F_PENDING, self::F_STOCKUP])->update($data);
            if (!$n) {
                throw new ApiException('订单状态已变化，请刷新后重试');
            }
            $msg = '开始配送' . (!empty($data['delivery_name']) ? '，配送员：' . $data['delivery_name'] : '');
            app()->make(OrderAuditServices::class)->record($oid, OrderAuditServices::T_DELIVERING, $msg, $operator);
            return true;
        });
    }

    /**
     * 后台：直接标记已送达（不输码，仅管理员）
     */
    public function markDelivered(int $oid, array $operator = []): bool
    {
        $order = $this->getCodOrder($oid);
        return $this->doDelivered($order, OrderAuditServices::T_DELIVERED, '后台标记已送达', $operator);
    }

    /**
     * 送达核销：($orderIdOrCode=订单号, $code=核销码) 或 ($orderIdOrCode=核销码, $code=null)
     * @return array 订单摘要（订单号、收货人、应收金额、是否已收款）
     */
    public function verifyDelivered(string $orderIdOrCode, ?string $code, array $operator = []): array
    {
        $orderIdOrCode = trim($orderIdOrCode);
        $code = $code === null ? null : trim($code);
        if ($code === null || $code === '') {
            // 仅凭核销码
            if (!preg_match('/^[0-9]{6}$/', $orderIdOrCode)) {
                throw new ApiException('核销码格式不正确');
            }
            $order = StoreOrder::where(['is_cod' => 1, 'is_del' => 0, 'cod_delivery_code' => $orderIdOrCode])
                ->whereIn('fulfil_status', [self::F_STOCKUP, self::F_DELIVERING])->where('is_cancel', 0)->find();
        } else {
            $order = StoreOrder::where(['is_cod' => 1, 'is_del' => 0, 'order_id' => $orderIdOrCode])->find();
            if ($order && (string)$order['cod_delivery_code'] !== $code) {
                $order = null;
            }
        }
        if (!$order) {
            throw new ApiException('核销码错误或订单不可核销');
        }
        $this->doDelivered($order, OrderAuditServices::T_CODE_VERIFY, '送达核销', $operator, true);
        $fresh = StoreOrder::where('id', $order['id'])->find();
        return [
            'id'             => (int)$fresh['id'],
            'order_id'       => $fresh['order_id'],
            'real_name'      => $fresh['real_name'],
            'user_phone'     => $fresh['user_phone'],
            'cod_receivable' => $fresh['cod_receivable'],
            'paid'           => (int)$fresh['paid'],
            'fulfil_status'  => (int)$fresh['fulfil_status'],
            'status'         => (int)$fresh['status'],
        ];
    }

    /**
     * 后台：确认收款（包装 OrderOfflineServices::orderOffline，记实收/收款人/时间）
     * @param string $received 实收金额；与应收不同必须填写 $remark
     */
    public function collect(int $oid, string $received, string $remark = '', array $operator = []): bool
    {
        $order = $this->getCodOrder($oid);
        if ((int)$order['paid'] === 1) {
            throw new ApiException('订单已收款');
        }
        if ((int)$order['fulfil_status'] === self::F_PENDING) {
            throw new ApiException('请先确认接单');
        }
        if ($received === '' || !is_numeric($received) || bccomp($received, '0', 2) < 0) {
            throw new ApiException('实收金额不正确');
        }
        $received = bcadd($received, '0', 2);
        $receivable = bcadd((string)$order['cod_receivable'], '0', 2);
        $diff = bccomp($received, $receivable, 2) !== 0;
        $remark = trim($remark);
        if ($diff && $remark === '') {
            throw new ApiException('实收与应收不一致，请填写原因');
        }
        $audit = app()->make(OrderAuditServices::class);
        $res = $this->transaction(function () use ($oid, $received, $receivable, $diff, $remark, $operator, $audit) {
            app()->make(OrderOfflineServices::class)->orderOffline($oid);
            // orderOffline 写入的“线下付款”记录无操作人，补记
            $op = $operator ?: $audit->operatorFromRequest();
            \app\model\order\StoreOrderStatus::where(['oid' => $oid, 'change_type' => 'offline', 'operator_type' => ''])->update([
                'operator_id'   => (int)($op['id'] ?? 0),
                'operator_type' => (string)($op['type'] ?? 'system'),
                'operator_name' => (string)($op['name'] ?? ''),
            ]);
            StoreOrder::where('id', $oid)->update([
                'cod_received'     => $received,
                'cod_collector_id' => (int)($operator['id'] ?? 0),
                'cod_collect_time' => time(),
            ]);
            if ($diff) {
                $audit->record($oid, OrderAuditServices::T_AMOUNT_EDIT, '实收' . $received . '≠应收' . $receivable . '，原因：' . $remark, $operator);
            }
            $audit->record($oid, OrderAuditServices::T_COLLECT, '确认收款 ' . $received, $operator);
            return true;
        });
        $this->tryFinish($oid);
        return (bool)$res;
    }

    /**
     * 后台取消：fulfil<3 且未收款；回退库存、is_cancel=1
     */
    public function adminCancel(int $oid, string $reason, array $operator = []): bool
    {
        $order = $this->getCodOrder($oid);
        if ((int)$order['paid'] === 1 || (int)$order['fulfil_status'] === self::F_DELIVERED) {
            throw new ApiException('已收款/已送达订单请走售后');
        }
        $reason = trim($reason);
        if ($reason === '') {
            throw new ApiException('请填写取消原因');
        }
        $refundServices = app()->make(StoreOrderRefundServices::class);
        return $this->transaction(function () use ($oid, $order, $reason, $operator, $refundServices) {
            $res = $refundServices->integralAndCouponBack($order, 'cancel') && $refundServices->regressionStock($order);
            if (!$res) {
                throw new ApiException('取消失败');
            }
            $n = StoreOrder::where(['id' => $oid, 'paid' => 0, 'is_cancel' => 0])->where('fulfil_status', '<', self::F_DELIVERED)
                ->update(['is_cancel' => 1, 'mark' => mb_substr(trim((string)$order['mark'] . ' [取消]' . $reason), 0, 500)]);
            if (!$n) {
                throw new ApiException('订单状态已变化，请刷新后重试');
            }
            app()->make(OrderAuditServices::class)->record($oid, OrderAuditServices::T_CANCEL, '后台取消：' . $reason, $operator);
            return true;
        });
    }

    /**
     * 标记/取消“需电话确认”
     */
    public function callMark(int $oid, int $need, array $operator = []): bool
    {
        $this->getCodOrder($oid);
        $need = $need ? 1 : 0;
        StoreOrder::where('id', $oid)->update(['need_call_confirm' => $need]);
        app()->make(OrderAuditServices::class)->record($oid, OrderAuditServices::T_CALL_MARK, $need ? '标记需电话确认' : '取消电话确认标记', $operator);
        return true;
    }

    /**
     * 用户取消守卫：非到付单走旧逻辑；到付单仅 fulfil=0 且配置允许时可取消
     */
    public function userCanCancel(array $order): bool
    {
        if (empty($order['is_cod'])) {
            return true;
        }
        if ((int)($order['is_cancel'] ?? 0) === 1 || (int)($order['paid'] ?? 0) === 1) {
            return false;
        }
        return (int)$order['fulfil_status'] === self::F_PENDING && (int)sys_config('cod_user_cancel_before_confirm', 1) === 1;
    }

    /**
     * 履约状态 key（供前端 i18n 与文案）
     */
    public function fulfilKey(array $order): string
    {
        if (empty($order['is_cod'])) {
            return '';
        }
        if ((int)$order['is_cancel'] === 1) {
            return 'cod_cancelled';
        }
        if ((int)$order['status'] === 3) {
            return 'cod_finished';
        }
        $map = [
            self::F_PENDING    => 'cod_pending',
            self::F_STOCKUP    => 'cod_stockup',
            self::F_DELIVERING => 'cod_delivering',
            self::F_DELIVERED  => 'cod_delivered',
        ];
        return $map[(int)$order['fulfil_status']] ?? 'cod_pending';
    }

    /**
     * 后台到付订单列表 + 各状态计数
     * @param array $where fulfil_status('' 或 0-3)、region_id、date_start/date_end(Y-m-d)、keyword、paid('' 或 0/1)、is_cancel、page、limit
     * @return array ['list'=>[], 'count'=>int, 'counts'=>[...]]
     */
    public function getList(array $where): array
    {
        $page = max(1, (int)($where['page'] ?? 1));
        $limit = min(200, max(1, (int)($where['limit'] ?? 20)));
        $query = $this->listQuery($where);
        $count = (clone $query)->count();
        $rows = $query->order('id', 'desc')->page($page, $limit)->select()->toArray();
        $ids = array_column($rows, 'id');
        $goods = [];
        if ($ids) {
            $cartRows = \think\facade\Db::name('store_order_cart_info')->whereIn('oid', $ids)->field('oid,cart_num,cart_info')->select()->toArray();
            foreach ($cartRows as $c) {
                $info = json_decode($c['cart_info'], true) ?: [];
                $goods[$c['oid']][] = [
                    'name'  => $info['productInfo']['store_name'] ?? '',
                    'suk'   => $info['productInfo']['attrInfo']['suk'] ?? '',
                    'num'   => (int)$c['cart_num'],
                    'price' => $info['truePrice'] ?? ($info['productInfo']['attrInfo']['price'] ?? ''),
                    'image' => $info['productInfo']['attrInfo']['image'] ?? ($info['productInfo']['image'] ?? ''),
                ];
            }
        }
        $regionIds = array_values(array_unique(array_filter(array_column($rows, 'region_id'))));
        $regionNames = $regionIds ? \think\facade\Db::name('system_city')->whereIn('city_id', $regionIds)->column('merger_name', 'city_id') : [];
        $list = [];
        foreach ($rows as $r) {
            $list[] = [
                'id'                => (int)$r['id'],
                'order_id'          => $r['order_id'],
                'real_name'         => $r['real_name'],
                'user_phone'        => $r['user_phone'],
                'user_address'      => $r['user_address'],
                'mark'              => $r['mark'],
                'remark'            => $r['remark'],
                'pay_price'         => $r['pay_price'],
                'cod_receivable'    => $r['cod_receivable'],
                'cod_received'      => $r['cod_received'],
                'paid'              => (int)$r['paid'],
                'status'            => (int)$r['status'],
                'fulfil_status'     => (int)$r['fulfil_status'],
                'fulfil_key'        => $this->fulfilKey($r),
                'is_cancel'         => (int)$r['is_cancel'],
                'need_call_confirm' => (int)$r['need_call_confirm'],
                'region_id'         => (int)$r['region_id'],
                'region_name'       => $regionNames[$r['region_id']] ?? '',
                'warehouse_id'      => (int)($r['warehouse_id'] ?? 0),
                'warehouse_name'    => (string)($r['warehouse_name'] ?? ''),
                'warehouse_address' => (string)($r['warehouse_address'] ?? ''),
                'client_ip'         => (string)($r['client_ip'] ?? ''),
                'delivery_name'     => $r['delivery_name'],
                'delivery_id'       => $r['delivery_id'],
                'add_time'          => date('Y-m-d H:i:s', (int)$r['add_time']),
                'delivered_time'    => $r['delivered_time'] ? date('Y-m-d H:i:s', (int)$r['delivered_time']) : '',
                'goods'             => $goods[$r['id']] ?? [],
            ];
        }
        return ['list' => $list, 'count' => $count, 'counts' => $this->statusCounts()];
    }

    /**
     * 各状态计数（不含已取消）：待确认/备货中/发货中/已送达/待收款(已送达未收款)/全部
     * @return array
     */
    public function statusCounts(): array
    {
        $base = function () {
            return StoreOrder::where(['is_cod' => 1, 'is_del' => 0, 'is_cancel' => 0]);
        };
        return [
            'pending'    => (int)$base()->where('fulfil_status', self::F_PENDING)->count(),
            'stockup'    => (int)$base()->where('fulfil_status', self::F_STOCKUP)->count(),
            'delivering' => (int)$base()->where('fulfil_status', self::F_DELIVERING)->count(),
            'delivered'  => (int)$base()->where('fulfil_status', self::F_DELIVERED)->count(),
            'uncollected' => (int)$base()->where(['fulfil_status' => self::F_DELIVERED, 'paid' => 0])->count(),
            'all'        => (int)$base()->count(),
        ];
    }

    /**
     * 新订单轮询：since_id=0 仅返回当前最大 id（避免首次刷出历史订单）
     * @return array ['latest_id'=>int,'list'=>[...]]
     */
    public function newOrders(int $sinceId): array
    {
        $latest = (int)StoreOrder::where(['is_cod' => 1])->max('id');
        $meta = [
            'poll_seconds' => max(5, (int)sys_config('order_notify_poll_seconds', 20)),
            'pending'      => (int)StoreOrder::where(['is_cod' => 1, 'is_del' => 0, 'is_cancel' => 0, 'fulfil_status' => self::F_PENDING])->count(),
        ];
        if ($sinceId <= 0) {
            return ['latest_id' => $latest, 'list' => []] + $meta;
        }
        $rows = StoreOrder::where(['is_cod' => 1, 'is_del' => 0])->where('id', '>', $sinceId)->order('id', 'asc')->limit(20)->select()->toArray();
        $regionIds = array_values(array_unique(array_filter(array_column($rows, 'region_id'))));
        $regionNames = $regionIds ? \think\facade\Db::name('system_city')->whereIn('city_id', $regionIds)->column('merger_name', 'city_id') : [];
        $list = [];
        foreach ($rows as $r) {
            $list[] = [
                'id'          => (int)$r['id'],
                'order_id'    => $r['order_id'],
                'region_name'    => $regionNames[$r['region_id']] ?? '',
                'warehouse_name' => (string)($r['warehouse_name'] ?? ''),
                'pay_price'      => $r['pay_price'],
                'add_time'       => date('Y-m-d H:i:s', (int)$r['add_time']),
            ];
        }
        $max = $rows ? (int)end($rows)['id'] : $sinceId;
        return ['latest_id' => max($max, $sinceId), 'list' => $list] + $meta;
    }

    /**
     * 构建列表查询（打印/导出复用）
     * @param array $where
     * @return \think\db\Query|\think\Model
     */
    public function listQuery(array $where)
    {
        $query = StoreOrder::where(['is_cod' => 1, 'is_del' => 0]);
        if (isset($where['fulfil_status']) && $where['fulfil_status'] !== '' && $where['fulfil_status'] !== null) {
            $query->where('fulfil_status', (int)$where['fulfil_status']);
            if (!isset($where['is_cancel']) || $where['is_cancel'] === '') {
                $query->where('is_cancel', 0);
            }
        }
        if (isset($where['is_cancel']) && $where['is_cancel'] !== '') {
            $query->where('is_cancel', (int)$where['is_cancel']);
        }
        if (!empty($where['region_id'])) {
            $query->where('region_id', (int)$where['region_id']);
        }
        if (!empty($where['warehouse_id'])) {
            $query->where('warehouse_id', (int)$where['warehouse_id']);
        }
        if (isset($where['paid']) && $where['paid'] !== '') {
            $query->where('paid', (int)$where['paid']);
        }
        if (!empty($where['date_start'])) {
            $query->where('add_time', '>=', strtotime($where['date_start'] . ' 00:00:00'));
        }
        if (!empty($where['date_end'])) {
            $query->where('add_time', '<=', strtotime($where['date_end'] . ' 23:59:59'));
        }
        $kw = trim((string)($where['keyword'] ?? ''));
        if ($kw !== '') {
            $query->where(function ($q) use ($kw) {
                $q->whereLike('order_id', '%' . $kw . '%')->whereOr('user_phone', 'like', '%' . $kw . '%')->whereOr('real_name', 'like', '%' . $kw . '%');
            });
        }
        return $query;
    }

    /**
     * 到付订单状态文案（_status），退款/已取消沿用原逻辑
     * @param array $order
     * @param array $status tidyOrder 原有计算结果
     * @return array
     */
    public function tidyStatus(array $order, array $status): array
    {
        if ((int)$order['is_cancel'] === 1 || (int)($order['refund_status'] ?? 0) > 0) {
            return $status;
        }
        $key = $this->fulfilKey($order);
        $paid = (int)$order['paid'] === 1;
        switch ($key) {
            case 'cod_pending':
                $status = ['_type' => 1, '_title' => '待确认', '_msg' => '商家正在确认订单,请耐心等待', '_class' => 'state-nfh'];
                break;
            case 'cod_stockup':
                $status = ['_type' => 1, '_title' => '备货中', '_msg' => '商家正在备货,请耐心等待', '_class' => 'state-nfh'];
                break;
            case 'cod_delivering':
                $status = ['_type' => 2, '_title' => '发货中', '_msg' => '商品正在配送中,请保持电话畅通', '_class' => 'state-ysh'];
                break;
            case 'cod_delivered':
                $status = ['_type' => 2, '_title' => $paid ? '已送达' : '已送达待收款', '_msg' => $paid ? '已送达,感谢您的支持' : '已送达,请按应付金额支付货款', '_class' => 'state-ysh'];
                break;
            case 'cod_finished':
                $status = ['_type' => 4, '_title' => '交易完成', '_msg' => '交易完成,感谢您的支持', '_class' => 'state-ytk'];
                break;
        }
        return $status;
    }

    /**
     * 到付订单附加字段：fulfil_key、can_cancel；原始送达码列一律剔除，cod_code 默认空（仅详情接口经 attachCodCode 给所有者）
     * @param array $order
     * @param bool $detail
     * @return array
     */
    public function tidyOrderFields(array $order, bool $detail): array
    {
        unset($order['cod_delivery_code']);
        $order['fulfil_key'] = $this->fulfilKey($order);
        $order['can_cancel'] = $this->userCanCancel($order);
        $order['cod_code'] = '';
        return $order;
    }

    /**
     * 订单详情接口：订单所有者（H5 用户本人，非后台）在“未取消且未送达”时可见送达码
     * @param array $order tidyOrder 之后的订单数组
     * @return array
     */
    public function attachCodCode(array $order): array
    {
        try {
            $request = app()->request;
            $isOwner = $request->hasMacro('uid') && (int)$request->uid() > 0 && (int)$request->uid() === (int)($order['uid'] ?? 0);
            $isAdmin = $request->hasMacro('adminId') && (int)$request->adminId() > 0;
            if ($isOwner && !$isAdmin && (int)$order['is_cancel'] === 0 && (int)$order['fulfil_status'] < self::F_DELIVERED) {
                $order['cod_code'] = (string)StoreOrder::where('id', (int)$order['id'])->value('cod_delivery_code');
            }
        } catch (\Throwable $e) {
        }
        return $order;
    }

    /**
     * 完结：fulfil=3 且 paid=1 且 status=0 → status=3
     * 一期营销(积分/佣金/经验)已关闭，不走 storeProductOrderUserTakeDelivery
     */
    protected function tryFinish(int $oid): void
    {
        StoreOrder::where(['id' => $oid, 'is_cod' => 1, 'fulfil_status' => self::F_DELIVERED, 'paid' => 1, 'status' => 0, 'is_cancel' => 0])
            ->update(['status' => 3]);
    }

    /**
     * 生成不重复的 6 位送达码（在未完结到付单中唯一）
     */
    protected function genDeliveryCode(): string
    {
        for ($i = 0; $i < 30; $i++) {
            $code = (string)random_int(100000, 999999);
            $exists = StoreOrder::where(['is_cod' => 1, 'cod_delivery_code' => $code])->where('fulfil_status', '<', self::F_DELIVERED)->where('is_cancel', 0)->count();
            if (!$exists) {
                return $code;
            }
        }
        throw new ApiException('系统繁忙，请稍后重试');
    }

    /**
     * 送达处理：→3。$strict=true（输码核销）仅允许 1|2 → 3；后台直接标记允许 0|1|2 → 3
     */
    protected function doDelivered($order, string $auditType, string $msg, array $operator, bool $strict = false): bool
    {
        $oid = (int)$order['id'];
        $from = $strict ? [self::F_STOCKUP, self::F_DELIVERING] : [self::F_PENDING, self::F_STOCKUP, self::F_DELIVERING];
        if (!in_array((int)$order['fulfil_status'], $from, true) || (int)$order['is_cancel'] === 1) {
            throw new ApiException('当前状态不能标记送达');
        }
        $this->transaction(function () use ($oid, $from, $auditType, $msg, $operator) {
            $n = StoreOrder::where(['id' => $oid, 'is_cancel' => 0])->whereIn('fulfil_status', $from)
                ->update(['fulfil_status' => self::F_DELIVERED, 'delivered_time' => time()]);
            if (!$n) {
                throw new ApiException('订单状态已变化，请刷新后重试');
            }
            app()->make(OrderAuditServices::class)->record($oid, $auditType, $msg, $operator);
            return true;
        });
        $this->tryFinish($oid);
        return true;
    }

    /**
     * 取到付订单（校验存在、到付、未取消、未删除）
     * @return StoreOrder
     */
    protected function getCodOrder(int $oid)
    {
        $order = StoreOrder::where(['id' => $oid, 'is_del' => 0])->find();
        if (!$order) {
            throw new ApiException('订单不存在');
        }
        if ((int)$order['is_cod'] !== 1) {
            throw new ApiException('不是到付订单');
        }
        if ((int)$order['is_cancel'] === 1) {
            throw new ApiException('订单已取消');
        }
        return $order;
    }
}
