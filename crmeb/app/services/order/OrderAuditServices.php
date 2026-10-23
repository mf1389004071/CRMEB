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

use app\dao\order\StoreOrderStatusDao;
use app\services\BaseServices;

/**
 * 订单操作审计（写入 eb_store_order_status，含操作人）
 * Class OrderAuditServices
 * @package app\services\order
 */
class OrderAuditServices extends BaseServices
{
    const T_CREATED = 'cod_created';
    const T_CONFIRM = 'cod_confirm';
    const T_DELIVERING = 'cod_delivering';
    const T_DELIVERED = 'cod_delivered';
    const T_COLLECT = 'cod_collect';
    const T_AMOUNT_EDIT = 'cod_amount_edit';
    const T_CANCEL = 'cod_cancel';
    const T_CODE_VERIFY = 'cod_code_verify';
    const T_PRINT = 'cod_print';
    const T_CALL_MARK = 'cod_call_mark';

    public function __construct(StoreOrderStatusDao $dao)
    {
        $this->dao = $dao;
    }

    /**
     * 统一审计入口
     * @param int $oid
     * @param string $type change_type
     * @param string $message
     * @param array $operator ['id'=>int,'type'=>'admin|user|system','name'=>string]，为空则从请求上下文推断
     * @return bool
     */
    public function record(int $oid, string $type, string $message, array $operator = []): bool
    {
        if (!$operator) {
            $operator = $this->operatorFromRequest();
        }
        $this->dao->save([
            'oid'           => $oid,
            'change_type'   => $type,
            'change_message' => mb_substr($message, 0, 250),
            'change_time'   => time(),
            'operator_id'   => (int)($operator['id'] ?? 0),
            'operator_type' => (string)($operator['type'] ?? 'system'),
            'operator_name' => mb_substr((string)($operator['name'] ?? ''), 0, 64),
        ]);
        return true;
    }

    /**
     * 从当前请求上下文推断操作人：后台管理员 > H5 用户 > 系统（队列/定时）
     * @return array
     */
    public function operatorFromRequest(): array
    {
        try {
            $request = app()->request;
            if ($request->hasMacro('adminId') && (int)$request->adminId() > 0) {
                $info = $request->hasMacro('adminInfo') ? $request->adminInfo() : [];
                return [
                    'id'   => (int)$request->adminId(),
                    'type' => 'admin',
                    'name' => (string)($info['real_name'] ?? $info['account'] ?? ''),
                ];
            }
            if ($request->hasMacro('uid') && (int)$request->uid() > 0) {
                $user = $request->hasMacro('user') ? $request->user() : [];
                return [
                    'id'   => (int)$request->uid(),
                    'type' => 'user',
                    'name' => (string)(is_array($user) ? ($user['nickname'] ?? '') : ''),
                ];
            }
        } catch (\Throwable $e) {
            // 无请求上下文（CLI/队列）
        }
        return ['id' => 0, 'type' => 'system', 'name' => 'system'];
    }

    /**
     * 订单的操作记录（含操作人）
     * @param int $oid
     * @return array
     */
    public function getList(int $oid): array
    {
        $list = $this->dao->selectList(['oid' => $oid], '*', 0, 0, 'change_time desc')->toArray();
        foreach ($list as &$item) {
            $item['change_time_text'] = date('Y-m-d H:i:s', (int)$item['change_time']);
        }
        return $list;
    }
}
