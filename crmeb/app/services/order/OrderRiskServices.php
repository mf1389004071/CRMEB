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

use app\services\BaseServices;
use app\services\vn\VnSiteServices;
use crmeb\exceptions\ApiException;
use think\facade\Cache;
use think\facade\Db;
use think\facade\Log;

/**
 * 下单防刷：黑名单（phone/ip/uid）+ 同手机号/同 IP 每小时限频
 * IP 说明：TP6 Request::ip() 默认不信任代理头，直接取 REMOTE_ADDR。
 *   - Nginx + PHP-FPM（宝塔默认）下 REMOTE_ADDR 即客户端 IP，可用；
 *   - 若前面还有 CDN/负载均衡，REMOTE_ADDR 会是内网/代理地址 → 本服务检测到私网地址时**跳过 IP 维度限频**（避免全站同 IP 误杀），
 *     并记录一次警告日志；需在 Nginx 配置 real_ip 后恢复。
 * Class OrderRiskServices
 * @package app\services\order
 */
class OrderRiskServices extends BaseServices
{
    const WINDOW = 3600;

    /**
     * 下单前检查，不通过抛 ApiException
     * @param array $user 当前用户（含 uid、phone）
     * @param string $ip 客户端 IP
     * @param string $phone 收货人手机号（可空）
     */
    public function check(array $user, string $ip, string $phone = ''): void
    {
        $phones = $this->phoneKeys($user, $phone);
        // 1) 黑名单
        $hit = false;
        if (!empty($user['uid']) && $this->inBlacklist('uid', (string)$user['uid'])) {
            $hit = true;
        }
        foreach ($phones as $p) {
            if ($this->inBlacklist('phone', $p)) {
                $hit = true;
            }
        }
        if ($ip !== '' && $this->inBlacklist('ip', $ip)) {
            $hit = true;
        }
        if ($hit) {
            throw new ApiException('暂时无法下单，请联系客服');
        }
        // 2) 限频
        $limit = (int)sys_config('order_rate_limit_per_hour', 5);
        if ($limit <= 0) {
            return;
        }
        foreach ($phones as $p) {
            if ($this->count('phone', $p) >= $limit) {
                throw new ApiException('下单过于频繁，请稍后再试或联系客服');
            }
        }
        if ($this->ipUsable($ip) && $this->count('ip', $ip) >= $limit) {
            throw new ApiException('下单过于频繁，请稍后再试或联系客服');
        }
    }

    /**
     * 下单成功后计数
     */
    public function hit(array $user, string $ip, string $phone = ''): void
    {
        foreach ($this->phoneKeys($user, $phone) as $p) {
            $this->incr('phone', $p);
        }
        if ($this->ipUsable($ip)) {
            $this->incr('ip', $ip);
        }
    }

    /**
     * 黑名单分页列表
     */
    public function blacklist(array $where = []): array
    {
        $page = max(1, (int)($where['page'] ?? 1));
        $limit = min(200, max(1, (int)($where['limit'] ?? 20)));
        $q = Db::name('order_blacklist');
        if (!empty($where['type'])) {
            $q->where('type', $where['type']);
        }
        if (!empty($where['keyword'])) {
            $q->whereLike('value', '%' . $where['keyword'] . '%');
        }
        $count = (clone $q)->count();
        $list = $q->order('id', 'desc')->page($page, $limit)->select()->toArray();
        foreach ($list as &$i) {
            $i['add_time_text'] = date('Y-m-d H:i:s', (int)$i['add_time']);
        }
        return compact('list', 'count');
    }

    /**
     * 加入黑名单（幂等）
     */
    public function addBlacklist(string $type, string $value, string $remark = ''): bool
    {
        $type = strtolower($type);
        if (!in_array($type, ['phone', 'ip', 'uid'], true)) {
            throw new ApiException('参数错误');
        }
        $value = $this->normalizeValue($type, $value);
        if ($value === '') {
            throw new ApiException('参数错误');
        }
        if (Db::name('order_blacklist')->where(['type' => $type, 'value' => $value])->count()) {
            return true;
        }
        Db::name('order_blacklist')->insert(['type' => $type, 'value' => $value, 'remark' => mb_substr($remark, 0, 250), 'add_time' => time()]);
        Cache::delete('order_bl_' . $type . '_' . $value);
        return true;
    }

    public function removeBlacklist(int $id): bool
    {
        $row = Db::name('order_blacklist')->where('id', $id)->find();
        if ($row) {
            Db::name('order_blacklist')->where('id', $id)->delete();
            Cache::delete('order_bl_' . $row['type'] . '_' . $row['value']);
        }
        return true;
    }

    /**
     * 当前请求客户端 IP
     */
    public function clientIp(): string
    {
        try {
            return (string)app()->request->ip();
        } catch (\Throwable $e) {
            return '';
        }
    }

    protected function inBlacklist(string $type, string $value): bool
    {
        if ($value === '') {
            return false;
        }
        return Db::name('order_blacklist')->where(['type' => $type, 'value' => $value])->count() > 0;
    }

    /**
     * 本次下单涉及的手机号规范化集合（用户手机号 + 收货手机号）
     * @return string[]
     */
    protected function phoneKeys(array $user, string $phone): array
    {
        $out = [];
        foreach ([$phone, (string)($user['phone'] ?? '')] as $raw) {
            $v = $this->normalizeValue('phone', $raw);
            if ($v !== '') {
                $out[$v] = $v;
            }
        }
        return array_values($out);
    }

    protected function normalizeValue(string $type, string $value): string
    {
        $value = trim($value);
        if ($type === 'phone') {
            return app()->make(VnSiteServices::class)->accountOf('', $value);
        }
        return $value;
    }

    protected function ipUsable(string $ip): bool
    {
        if ($ip === '' || !filter_var($ip, FILTER_VALIDATE_IP)) {
            return false;
        }
        $public = filter_var($ip, FILTER_VALIDATE_IP, FILTER_FLAG_NO_PRIV_RANGE | FILTER_FLAG_NO_RES_RANGE);
        if ($public === false) {
            if (!Cache::get('order_risk_private_ip_warned')) {
                Cache::set('order_risk_private_ip_warned', 1, 86400);
                Log::warning('OrderRiskServices: client IP is private/loopback (' . $ip . '), IP rate limit skipped. Check reverse proxy real_ip config.');
            }
            return false;
        }
        return true;
    }

    protected function key(string $type, string $value): string
    {
        return 'order_cnt_' . $type . '_' . md5($value);
    }

    protected function count(string $type, string $value): int
    {
        $v = Cache::get($this->key($type, $value));
        if (!is_array($v) || (time() - (int)$v['t']) >= self::WINDOW) {
            return 0;
        }
        return (int)$v['n'];
    }

    protected function incr(string $type, string $value): void
    {
        $k = $this->key($type, $value);
        $v = Cache::get($k);
        if (!is_array($v) || (time() - (int)$v['t']) >= self::WINDOW) {
            $v = ['n' => 0, 't' => time()];
        }
        $v['n']++;
        Cache::set($k, $v, self::WINDOW);
    }
}
