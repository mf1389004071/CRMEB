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
use app\services\system\MoneyServices;
use crmeb\exceptions\ApiException;
use think\facade\Db;

/**
 * 后台币种与汇率管理：本位币唯一且不可删，汇率修改写日志
 * Class CurrencyAdminServices
 * @package app\services\vn
 */
class CurrencyAdminServices extends BaseServices
{
    public function lst(): array
    {
        return Db::name('system_currency')->order('sort', 'desc')->order('id', 'asc')->select()->toArray();
    }

    /**
     * 新增/编辑（有 id 为编辑）
     */
    public function save(array $d, int $operatorId = 0): int
    {
        $id = (int)($d['id'] ?? 0);
        $code = strtoupper(trim((string)($d['code'] ?? '')));
        if (!preg_match('/^[A-Z]{3}$/', $code)) {
            throw new ApiException('币种码必须是3位大写字母');
        }
        $rate = (string)($d['rate'] ?? '');
        if (!is_numeric($rate) || bccomp($rate, '0', 6) <= 0) {
            throw new ApiException('汇率必须大于0');
        }
        $dp = (int)($d['decimal_places'] ?? 2);
        if ($dp < 0 || $dp > 6) {
            throw new ApiException('小数位数不正确');
        }
        $isBase = !empty($d['is_base']) ? 1 : 0;
        $old = $id ? Db::name('system_currency')->where('id', $id)->find() : null;
        if ($id && !$old) {
            throw new ApiException('数据不存在');
        }
        if (!$id && Db::name('system_currency')->where('code', $code)->count()) {
            throw new ApiException('币种码已存在');
        }
        if ($id && $old['code'] !== $code && Db::name('system_currency')->where('code', $code)->count()) {
            throw new ApiException('币种码已存在');
        }
        // 本位币规则：只能有一个；本位币汇率恒为 1；不可取消本位币（须先指定另一个本位币）
        $baseRow = Db::name('system_currency')->where('is_base', 1)->find();
        if ($isBase && $baseRow && (int)$baseRow['id'] !== $id) {
            throw new ApiException('已存在本位币，不允许同时设置两个本位币');
        }
        if ($old && (int)$old['is_base'] === 1 && !$isBase) {
            throw new ApiException('不允许取消本位币');
        }
        if ($isBase) {
            $rate = '1';
        }
        $data = [
            'code'           => $code,
            'symbol'         => mb_substr((string)($d['symbol'] ?? ''), 0, 8),
            'name_zh'        => mb_substr((string)($d['name_zh'] ?? ''), 0, 32),
            'name_vi'        => mb_substr((string)($d['name_vi'] ?? ''), 0, 32),
            'name_en'        => mb_substr((string)($d['name_en'] ?? ''), 0, 32),
            'decimal_places' => $dp,
            'thousand_sep'   => mb_substr((string)($d['thousand_sep'] ?? ','), 0, 2),
            'decimal_sep'    => mb_substr((string)($d['decimal_sep'] ?? '.'), 0, 2),
            'rate'           => bcadd($rate, '0', 6),
            'is_base'        => $isBase,
            'status'         => isset($d['status']) ? ((int)$d['status'] ? 1 : 0) : 1,
            'sort'           => (int)($d['sort'] ?? 0),
            'update_time'    => time(),
        ];
        if ($old && (int)$old['is_base'] === 1 && !$data['status']) {
            throw new ApiException('本位币不可停用');
        }
        Db::transaction(function () use ($id, $old, $data, $operatorId, &$newId) {
            if ($old) {
                if (bccomp((string)$old['rate'], $data['rate'], 6) !== 0) {
                    Db::name('system_exchange_rate_log')->insert([
                        'code' => $data['code'], 'old_rate' => $old['rate'], 'new_rate' => $data['rate'], 'operator_id' => $operatorId, 'add_time' => time(),
                    ]);
                }
                Db::name('system_currency')->where('id', $id)->update($data);
                $newId = $id;
            } else {
                $newId = (int)Db::name('system_currency')->insertGetId($data);
            }
        });
        MoneyServices::flush();
        return (int)$newId;
    }

    public function delete(int $id): bool
    {
        $row = Db::name('system_currency')->where('id', $id)->find();
        if (!$row) {
            return true;
        }
        if ((int)$row['is_base'] === 1) {
            throw new ApiException('不允许删除本位币');
        }
        Db::name('system_currency')->where('id', $id)->delete();
        MoneyServices::flush();
        return true;
    }

    public function logs(string $code = '', int $limit = 100): array
    {
        $q = Db::name('system_exchange_rate_log')->order('id', 'desc')->limit($limit);
        if ($code !== '') {
            $q->where('code', $code);
        }
        $list = $q->select()->toArray();
        foreach ($list as &$i) {
            $i['add_time_text'] = date('Y-m-d H:i:s', (int)$i['add_time']);
        }
        return $list;
    }
}
