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

use app\model\order\StoreOrder;
use app\services\BaseServices;
use crmeb\exceptions\ApiException;
use crmeb\services\SpreadsheetExcelService;
use think\facade\Db;

/**
 * 到付订单：配送单打印数据、拣货汇总、Excel 导出
 * 配送单不含送达码（cod_delivery_code）
 * Class CodPrintServices
 * @package app\services\order
 */
class CodPrintServices extends BaseServices
{
    const MAX_IDS = 100;

    /**
     * 解析订单范围：ids（逗号分隔，最多 100）或 date(+region_id) —— date 取当日未取消、未送达的到付单
     * @param array $params ids、date、region_id
     * @return array 订单 id 列表
     */
    public function resolveOrderIds(array $params): array
    {
        $ids = [];
        if (!empty($params['ids'])) {
            $raw = is_array($params['ids']) ? $params['ids'] : explode(',', (string)$params['ids']);
            $ids = array_values(array_unique(array_filter(array_map('intval', $raw))));
            if (count($ids) > self::MAX_IDS) {
                throw new ApiException('一次最多处理100个订单');
            }
            if ($ids) {
                $ids = StoreOrder::where('is_cod', 1)->where('is_del', 0)->whereIn('id', $ids)->column('id');
            }
        } elseif (!empty($params['date'])) {
            $start = strtotime($params['date'] . ' 00:00:00');
            $query = StoreOrder::where(['is_cod' => 1, 'is_del' => 0, 'is_cancel' => 0])
                ->where('add_time', 'between', [$start, $start + 86399]);
            if (!empty($params['region_id'])) {
                $query->where('region_id', (int)$params['region_id']);
            }
            $ids = $query->limit(self::MAX_IDS)->column('id');
        }
        if (!$ids) {
            throw new ApiException('请选择要处理的订单');
        }
        sort($ids);
        return array_values($ids);
    }

    /**
     * 批量配送单数据
     * @param array $oids
     * @param string $lang vi-VN | zh-CN | both
     * @return array
     */
    public function printData(array $oids, string $lang = 'vi-VN'): array
    {
        $lang = $this->normalizePrintLang($lang);
        $orders = StoreOrder::whereIn('id', $oids)->order('id', 'asc')->select()->toArray();
        $cartMap = $this->cartItems($oids);
        $pids = [];
        foreach ($cartMap as $items) {
            foreach ($items as $it) {
                $pids[$it['product_id']] = 1;
            }
        }
        $products = $pids ? Db::name('store_product')->whereIn('id', array_keys($pids))->select()->toArray() : [];
        $products = array_column($products, null, 'id');
        $regionIds = array_values(array_unique(array_filter(array_column($orders, 'region_id'))));
        $regionNames = $regionIds ? Db::name('system_city')->whereIn('city_id', $regionIds)->column('merger_name', 'city_id') : [];
        $baseCode = $this->baseCurrency();
        $out = [];
        foreach ($orders as $o) {
            $goods = [];
            $total = '0';
            foreach ($cartMap[$o['id']] ?? [] as $it) {
                $prod = $products[$it['product_id']] ?? [];
                $unitPrice = bcadd((string)$it['price'], '0', 2);
                $sub = bcmul($unitPrice, (string)$it['num'], 2);
                $total = bcadd($total, $sub, 2);
                $goods[] = [
                    'product_id'    => (int)$it['product_id'],
                    'name'          => $this->goodsName((int)$it['product_id'], $it['name'], $lang === 'both' ? 'vi-VN' : $lang),
                    'name_zh'       => $lang === 'both' ? $this->goodsName((int)$it['product_id'], $it['name'], 'zh-CN') : '',
                    'sku'           => $it['suk'],
                    'unit'          => $it['unit'],
                    'num'           => (int)$it['num'],
                    'price'         => $unitPrice,
                    'subtotal'      => $sub,
                    'origin'        => (string)($prod['origin'] ?? ''),
                    'need_cold_chain' => (int)($prod['need_cold_chain'] ?? 0),
                    'cold_chain_note' => (string)($prod['cold_chain_note'] ?? ''),
                    'shelf_life'    => (string)($prod['shelf_life_text'] ?? ''),
                    'tax_rate'      => (string)($prod['tax_rate'] ?? '0'),
                ];
            }
            $postage = bcadd((string)$o['pay_postage'], '0', 2);
            $receivable = bcadd((string)$o['cod_receivable'], '0', 2);
            $row = [
                'id'                => (int)$o['id'],
                'order_id'          => $o['order_id'],
                'real_name'         => $o['real_name'],
                'user_phone'        => $o['user_phone'],
                'user_address'      => $o['user_address'],
                'region_name'       => $regionNames[$o['region_id']] ?? '',
                'add_time'          => date('Y-m-d H:i', (int)$o['add_time']),
                'mark'              => (string)$o['mark'],
                'need_call_confirm' => (int)$o['need_call_confirm'],
                'goods'             => $goods,
                'goods_total'       => $total,
                'postage'           => $postage,
                'receivable'        => $receivable,
                'base_currency'     => $baseCode,
                'display_currency'  => (string)$o['currency_code'],
                'receivable_display' => (string)$o['pay_amount_display'],
                'lang'              => $lang,
            ];
            // 保险：配送单绝不带送达码
            unset($row['cod_delivery_code']);
            $out[] = $row;
        }
        return $out;
    }

    /**
     * 拣货汇总：按 product_id + unique 汇总
     * @param array $oids
     * @param string $lang
     * @return array
     */
    public function pickSummary(array $oids, string $lang = 'vi-VN'): array
    {
        $lang = $this->normalizePrintLang($lang);
        $cartMap = $this->cartItems($oids);
        $agg = [];
        foreach ($cartMap as $oid => $items) {
            foreach ($items as $it) {
                $k = $it['product_id'] . '_' . $it['unique'];
                if (!isset($agg[$k])) {
                    $agg[$k] = [
                        'product_id' => (int)$it['product_id'],
                        'unique'     => $it['unique'],
                        'name_snap'  => $it['name'],
                        'sku'        => $it['suk'],
                        'unit'       => $it['unit'],
                        'total_num'  => 0,
                        'order_ids'  => [],
                    ];
                }
                $agg[$k]['total_num'] += (int)$it['num'];
                $agg[$k]['order_ids'][$oid] = 1;
            }
        }
        $pids = array_values(array_unique(array_column($agg, 'product_id')));
        $products = $pids ? array_column(Db::name('store_product')->whereIn('id', $pids)->select()->toArray(), null, 'id') : [];
        $rows = [];
        foreach ($agg as $a) {
            $prod = $products[$a['product_id']] ?? [];
            $rows[] = [
                'product_id'      => $a['product_id'],
                'unique'          => $a['unique'],
                'name'            => $this->goodsName($a['product_id'], $a['name_snap'], $lang === 'both' ? 'vi-VN' : $lang),
                'name_zh'         => $lang === 'both' ? $this->goodsName($a['product_id'], $a['name_snap'], 'zh-CN') : '',
                'sku'             => $a['sku'],
                'unit'            => $a['unit'],
                'total_num'       => $a['total_num'],
                'order_count'     => count($a['order_ids']),
                'need_cold_chain' => (int)($prod['need_cold_chain'] ?? 0),
                'origin'          => (string)($prod['origin'] ?? ''),
                'cate_id'         => (string)($prod['cate_id'] ?? ''),
            ];
        }
        // 冷链优先，其次品类、名称，便于仓库分区拣货
        usort($rows, function ($x, $y) {
            return [$y['need_cold_chain'], $x['cate_id'], $x['name']] <=> [$x['need_cold_chain'], $y['cate_id'], $y['name']];
        });
        return $rows;
    }

    /**
     * 导出 Excel（保存到 public 下并返回可下载地址）
     * @param string $type orders|pick
     * @param array $oids
     * @param string $lang
     * @return string url
     */
    public function export(string $type, array $oids, string $lang = 'vi-VN'): string
    {
        if ($type === 'pick') {
            $header = ['商品', '规格', '单位', '总数量', '涉及订单数', '冷链', '产地'];
            $rows = [];
            foreach ($this->pickSummary($oids, $lang) as $r) {
                $rows[] = [$r['name'] . ($r['name_zh'] ? ' / ' . $r['name_zh'] : ''), $r['sku'], $r['unit'], $r['total_num'], $r['order_count'], $r['need_cold_chain'] ? '是' : '', $r['origin']];
            }
            $title = '拣货汇总';
        } else {
            $header = ['订单号', '收货人', '电话', '地址', '区域', '下单时间', '商品', '商品合计', '运费', '应收', '备注', '需电话确认'];
            $rows = [];
            foreach ($this->printData($oids, $lang) as $r) {
                $goods = [];
                foreach ($r['goods'] as $g) {
                    $goods[] = $g['name'] . ($g['name_zh'] ? '/' . $g['name_zh'] : '') . ' ' . $g['sku'] . ' ×' . $g['num'] . ' @' . $g['price'];
                }
                $rows[] = [$r['order_id'], $r['real_name'], $r['user_phone'], $r['user_address'], $r['region_name'], $r['add_time'], implode("\n", $goods), $r['goods_total'], $r['postage'], $r['receivable'], $r['mark'], $r['need_call_confirm'] ? '是' : ''];
            }
            $title = '到付订单';
        }
        $path = SpreadsheetExcelService::instance()->setExcelHeader($header)
            ->setExcelTile($title, $title, date('Y-m-d H:i:s'))
            ->setExcelContent($rows)
            ->excelSave($title . '_' . date('YmdHis'), 'xlsx', true);
        return rtrim(request()->domain(), '/') . '/' . ltrim($path, './');
    }

    /**
     * 按订单取购物车商品快照
     * @param array $oids
     * @return array [oid => [item...]]
     */
    protected function cartItems(array $oids): array
    {
        $rows = Db::name('store_order_cart_info')->whereIn('oid', $oids)->order('id', 'asc')->select()->toArray();
        $map = [];
        foreach ($rows as $r) {
            $info = json_decode($r['cart_info'], true) ?: [];
            $attr = $info['productInfo']['attrInfo'] ?? [];
            $map[$r['oid']][] = [
                'product_id' => (int)$r['product_id'],
                'unique'     => $attr['unique'] ?? $r['unique'],
                'name'       => $info['productInfo']['store_name'] ?? '',
                'suk'        => $attr['suk'] ?? '',
                'unit'       => $info['productInfo']['unit_name'] ?? '',
                'num'        => (int)$r['cart_num'],
                'price'      => $info['truePrice'] ?? ($attr['price'] ?? 0),
            ];
        }
        return $map;
    }

    /**
     * 商品名：优先内容多语(M5)，取不到用下单快照
     */
    protected function goodsName(int $pid, string $snapshot, string $lang): string
    {
        $cls = '\\app\\services\\other\\I18nContentServices';
        if (class_exists($cls)) {
            $val = app()->make($cls)->get('product', $pid, 'store_name', $lang);
            if ($val !== null && $val !== '') {
                return $val;
            }
        }
        return $snapshot;
    }

    protected function normalizePrintLang(string $lang): string
    {
        $lang = $lang === 'both' ? 'both' : normalize_lang_code($lang);
        return in_array($lang, ['vi-VN', 'zh-CN', 'both'], true) ? $lang : 'vi-VN';
    }

    protected function baseCurrency(): string
    {
        return (string)sys_config('base_currency', 'VND');
    }
}
