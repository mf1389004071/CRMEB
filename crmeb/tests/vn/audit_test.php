<?php
require __DIR__ . '/bootstrap.php';

use app\services\order\OrderAuditServices;

/** @var OrderAuditServices $audit */
$audit = app()->make(OrderAuditServices::class);
$oid = 990001;
think\facade\Db::name('store_order_status')->where('oid', $oid)->delete();

$audit->record($oid, OrderAuditServices::T_CONFIRM, '确认接单', ['id' => 7, 'type' => 'admin', 'name' => 'tester']);
$audit->record($oid, OrderAuditServices::T_COLLECT, '收款');   // 无请求上下文 => system
$list = $audit->getList($oid);
t_assert(count($list) === 2, 'two audit rows');
$byType = array_column($list, null, 'change_type');
t_assert($byType['cod_confirm']['operator_id'] == 7 && $byType['cod_confirm']['operator_type'] === 'admin' && $byType['cod_confirm']['operator_name'] === 'tester', 'admin operator stored');
t_assert($byType['cod_collect']['operator_type'] === 'system', 'system operator fallback');
think\facade\Db::name('store_order_status')->where('oid', $oid)->delete();
t_done();
