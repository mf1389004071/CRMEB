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

namespace app\services\other;

use app\services\BaseServices;
use crmeb\exceptions\ApiException;
use think\facade\Cache;
use think\facade\Db;

/**
 * 内容多语（商品/分类/规格/区划）
 * 主表字段保存站点默认语言(vi-VN)内容；译文存 eb_i18n_content；回落链：当前语 → i18n_fallback_lang → 主表字段。
 * 机翻待审(status=0)内容受 i18n_show_pending_machine 控制。
 * Class I18nContentServices
 * @package app\services\other
 */
class I18nContentServices extends BaseServices
{
    /** 各实体可翻译字段 */
    const ENTITY_FIELDS = [
        'product'      => ['store_name', 'store_info', 'unit_name', 'keyword', 'origin', 'cold_chain_note', 'shelf_life_text', 'description'],
        'category'     => ['cate_name'],
        'product_attr' => ['attr_name', 'attr_values'],
        'sku'          => ['suk'],
        'city'         => ['name', 'merger_name'],
    ];
    const LANGS = ['zh-CN', 'vi-VN', 'en-US'];
    const TTL = 600;

    /** 请求内记忆：type|id|lang => [field => [value,status]] */
    protected static $memo = [];

    /**
     * 回落语言链：[当前语, 回落语]
     */
    public function langChain(?string $lang = null): array
    {
        $lang = normalize_lang_code($lang ?: current_lang_code());
        $fallback = normalize_lang_code((string)sys_config('i18n_fallback_lang', 'vi-VN')) ?: 'vi-VN';
        return array_values(array_unique([$lang, $fallback]));
    }

    /**
     * 取单个译文；全链都没有返回 null（调用方使用原字段）
     */
    public function get(string $type, int $id, string $field, ?string $lang = null): ?string
    {
        foreach ($this->langChain($lang) as $l) {
            $rows = $this->loadEntities($type, [$id], $l)[$id] ?? [];
            if (isset($rows[$field]) && $this->visible($rows[$field])) {
                return (string)$rows[$field]['value'];
            }
        }
        return null;
    }

    /**
     * 批量回写译文到列表项字段（缺失回落原字段）
     * @param array $list
     * @param string $type
     * @param string $idKey 列表项里实体 id 的键
     * @param array $fields 需要翻译的字段
     * @return array
     */
    public function apply(array $list, string $type, string $idKey, array $fields, ?string $lang = null): array
    {
        if (!$list) {
            return $list;
        }
        $ids = [];
        foreach ($list as $item) {
            if (isset($item[$idKey])) {
                $ids[] = (int)$item[$idKey];
            }
        }
        $ids = array_values(array_unique($ids));
        $maps = [];
        foreach ($this->langChain($lang) as $l) {
            $maps[$l] = $this->loadEntities($type, $ids, $l);
        }
        foreach ($list as &$item) {
            $id = (int)($item[$idKey] ?? 0);
            foreach ($fields as $f) {
                if (!array_key_exists($f, $item)) {
                    continue;
                }
                foreach ($maps as $m) {
                    if (isset($m[$id][$f]) && $this->visible($m[$id][$f]) && $m[$id][$f]['value'] !== '') {
                        $item[$f] = $m[$id][$f]['value'];
                        break;
                    }
                }
            }
        }
        unset($item);
        return $list;
    }

    /**
     * 递归应用于树形列表（分类树等，子节点键 $childKey）
     */
    public function applyTree(array $tree, string $type, string $idKey, array $fields, string $childKey = 'children', ?string $lang = null): array
    {
        $tree = $this->apply($tree, $type, $idKey, $fields, $lang);
        foreach ($tree as &$node) {
            if (!empty($node[$childKey]) && is_array($node[$childKey])) {
                $node[$childKey] = $this->applyTree($node[$childKey], $type, $idKey, $fields, $childKey, $lang);
            }
        }
        unset($node);
        return $tree;
    }

    /**
     * 保存（整体 upsert）：[lang => [field => value]]；空值=删除该译文（回落生效）
     * @param int $status 1=人工/已审核 0=机翻待审
     */
    public function save(string $type, int $id, array $fieldValuesByLang, int $status = 1): bool
    {
        $allowed = self::ENTITY_FIELDS[$type] ?? null;
        if ($allowed === null || $id <= 0) {
            throw new ApiException('参数错误');
        }
        $now = time();
        Db::transaction(function () use ($type, $id, $fieldValuesByLang, $status, $allowed, $now) {
            foreach ($fieldValuesByLang as $lang => $fields) {
                $lang = normalize_lang_code((string)$lang);
                if (!in_array($lang, self::LANGS, true)) {
                    throw new ApiException('当前语言不可用');
                }
                foreach ((array)$fields as $field => $value) {
                    if (!in_array($field, $allowed, true)) {
                        continue;
                    }
                    $value = is_string($value) ? $value : (string)$value;
                    $where = ['entity_type' => $type, 'entity_id' => $id, 'field' => $field, 'lang' => $lang];
                    if (trim($value) === '') {
                        Db::name('i18n_content')->where($where)->delete();
                        continue;
                    }
                    if ($type === 'product_attr' && $field === 'attr_values') {
                        $this->assertAttrValuesAligned($id, $value);
                    }
                    $exist = Db::name('i18n_content')->where($where)->find();
                    if ($exist) {
                        Db::name('i18n_content')->where('id', $exist['id'])->update(['value' => $value, 'status' => $status, 'update_time' => $now]);
                    } else {
                        Db::name('i18n_content')->insert($where + ['value' => $value, 'status' => $status, 'add_time' => $now, 'update_time' => $now]);
                    }
                }
            }
        });
        $this->flush($type, $id);
        return true;
    }

    /**
     * 读取实体全部译文：[lang => [field => ['value','status']]]
     */
    public function getAll(string $type, int $id): array
    {
        $out = [];
        foreach (Db::name('i18n_content')->where(['entity_type' => $type, 'entity_id' => $id])->select() as $r) {
            $out[$r['lang']][$r['field']] = ['value' => $r['value'], 'status' => (int)$r['status']];
        }
        return $out;
    }

    /**
     * 机翻填充（可选）：源语言取 zh-CN 译文，缺失用主表字段；结果 status=0 待审。需配置 hs_accesskey/hs_secretkey
     * @param string $type
     * @param int $id
     * @param array $fields 需要翻译的字段
     * @param array $targetLangs 如 ['vi-VN','en-US']
     */
    public function machineFill(string $type, int $id, array $fields, array $targetLangs): void
    {
        if (!sys_config('hs_accesskey') || !sys_config('hs_secretkey')) {
            throw new ApiException('未配置机器翻译密钥');
        }
        $source = $this->sourceTexts($type, $id, $fields);
        if (!$source) {
            return;
        }
        $map = ['vi-VN' => 'vi', 'en-US' => 'en', 'zh-CN' => 'zh'];
        $translator = \crmeb\utils\Translate::getInstance();
        $translator->setAccessKey(sys_config('hs_accesskey'));
        $translator->setSecretKey(sys_config('hs_secretkey'));
        $payload = [];
        foreach ($targetLangs as $lang) {
            $lang = normalize_lang_code($lang);
            if (!isset($map[$lang]) || $lang === 'zh-CN') {
                continue;
            }
            $texts = array_values($source);
            $res = $translator->translateText('', $map[$lang], $texts);
            $i = 0;
            foreach (array_keys($source) as $field) {
                $t = $res[$i++]['Translation'] ?? '';
                if ($t !== '') {
                    $payload[$lang][$field] = $t;
                }
            }
        }
        if ($payload) {
            $this->save($type, $id, $payload, 0);
        }
    }

    // ===================== 规格（product_attr）译文 =====================

    /**
     * 商品规格的翻译映射：[ 'groups' => [ [ 'id'=>attrId, 'name'=>译名, 'values'=>[原值=>译值] ] ... ] ]（按 attr.id 升序）
     */
    public function attrMaps(int $productId, ?string $lang = null): array
    {
        $attrs = Db::name('store_product_attr')->where(['product_id' => $productId, 'type' => 0])->order('id', 'asc')->select()->toArray();
        $ids = array_column($attrs, 'id');
        $maps = [];
        foreach ($this->langChain($lang) as $l) {
            $maps[$l] = $this->loadEntities('product_attr', $ids, $l);
        }
        $groups = [];
        foreach ($attrs as $a) {
            $orig = $this->splitValues((string)$a['attr_values']);
            $name = $a['attr_name'];
            $vals = $orig;
            foreach ($maps as $m) {
                if (isset($m[$a['id']]['attr_name']) && $this->visible($m[$a['id']]['attr_name'])) {
                    $name = $m[$a['id']]['attr_name']['value'];
                    break;
                }
            }
            foreach ($maps as $m) {
                if (isset($m[$a['id']]['attr_values']) && $this->visible($m[$a['id']]['attr_values'])) {
                    $tr = $this->splitValues($m[$a['id']]['attr_values']['value']);
                    if (count($tr) === count($orig)) {
                        $vals = $tr;
                        break;
                    }
                }
            }
            // 双射保护：译文出现重复则放弃翻译值，避免规格组合冲突
            if (count(array_unique($vals)) !== count($vals)) {
                $vals = $orig;
            }
            $groups[] = ['id' => (int)$a['id'], 'name' => $name, 'orig_name' => $a['attr_name'], 'values' => array_combine($orig, $vals) ?: []];
        }
        return ['groups' => $groups];
    }

    /**
     * 规格组合 suk（"a,b"）本地化：按各规格组值映射；sku 实体的显式译文优先
     */
    public function localizeSuk(int $productId, string $suk, ?string $lang = null, int $skuId = 0): string
    {
        if ($skuId > 0) {
            $explicit = $this->get('sku', $skuId, 'suk', $lang);
            if ($explicit !== null && $explicit !== '') {
                return $explicit;
            }
        }
        $groups = $this->attrMaps($productId, $lang)['groups'];
        if (!$groups) {
            return $suk;
        }
        $parts = explode(',', $suk);
        foreach ($parts as $i => $p) {
            if (isset($groups[$i]['values'][$p])) {
                $parts[$i] = $groups[$i]['values'][$p];
            }
        }
        return implode(',', $parts);
    }

    /**
     * 规格弹窗数据本地化：规格名/规格值/suk 键同步翻译
     * @param int $productId
     * @param array $attrDetail [['attr_name','attr_values'=>[],'attr_value'=>[['attr',…]]], …]
     * @param array $values [suk => 规格行]
     * @return array [$attrDetail, $values]
     */
    public function localizeAttrDetail(int $productId, array $attrDetail, array $values): array
    {
        $groups = $this->attrMaps($productId)['groups'];
        if (!$groups) {
            return [$attrDetail, $values];
        }
        $byName = [];
        foreach ($groups as $g) {
            $byName[$g['orig_name']] = $g;
        }
        foreach ($attrDetail as $i => $d) {
            $g = $byName[$d['attr_name']] ?? null;
            if (!$g) {
                continue;
            }
            $attrDetail[$i]['attr_name'] = $g['name'];
            if (isset($d['attr_values']) && is_array($d['attr_values'])) {
                $attrDetail[$i]['attr_values'] = array_map(function ($v) use ($g) {
                    return $g['values'][$v] ?? $v;
                }, $d['attr_values']);
            }
            if (isset($d['attr_value']) && is_array($d['attr_value'])) {
                foreach ($d['attr_value'] as $k => $av) {
                    if (isset($av['attr'])) {
                        $attrDetail[$i]['attr_value'][$k]['attr'] = $g['values'][$av['attr']] ?? $av['attr'];
                    }
                }
            }
        }
        $newValues = [];
        foreach ($values as $suk => $v) {
            $local = $this->localizeSuk($productId, (string)$suk);
            if (isset($newValues[$local])) {   // 键冲突：放弃翻译，保持原键
                return [$attrDetail, $values];
            }
            $v['suk'] = $local;
            $newValues[$local] = $v;
        }
        return [$attrDetail, $newValues];
    }

    /**
     * 购物车商品信息本地化：商品名/单位/规格名（productInfo.attrInfo.suk）
     */
    public function localizeCartProduct(array $productInfo, int $productId): array
    {
        if ($productId <= 0) {
            return $productInfo;
        }
        foreach (['store_name', 'unit_name'] as $f) {
            if (isset($productInfo[$f])) {
                $t = $this->get('product', $productId, $f);
                if ($t !== null && $t !== '') {
                    $productInfo[$f] = $t;
                }
            }
        }
        if (!empty($productInfo['attrInfo']['suk']) && $productInfo['attrInfo']['suk'] !== '已失效') {
            $productInfo['attrInfo']['suk'] = $this->localizeSuk($productId, (string)$productInfo['attrInfo']['suk'], null, (int)($productInfo['attrInfo']['id'] ?? 0));
        }
        return $productInfo;
    }

    /**
     * 缺译文清单：返回缺少 $lang 译文的实体 id（默认检查商品名）
     */
    public function missing(string $type, string $lang, string $field, int $limit = 200): array
    {
        $table = ['product' => ['store_product', 'id', ['is_del' => 0]], 'category' => ['store_category', 'id', ['is_show' => 1]]][$type] ?? null;
        if (!$table) {
            throw new ApiException('参数错误');
        }
        $have = Db::name('i18n_content')->where(['entity_type' => $type, 'field' => $field, 'lang' => normalize_lang_code($lang)])->column('entity_id');
        $q = Db::name($table[0])->where($table[2]);
        if ($have) {
            $q->whereNotIn($table[1], $have);
        }
        return $q->limit($limit)->column($table[1]);
    }

    /**
     * 使缓存失效
     */
    public function flush(string $type, int $id): void
    {
        foreach (self::LANGS as $l) {
            Cache::delete($this->cacheKey($type, $id, $l));
            unset(self::$memo[$type . '|' . $id . '|' . $l]);
        }
    }

    // ===================== 内部 =====================

    protected function visible(array $row): bool
    {
        if ((int)$row['status'] === 0 && (int)sys_config('i18n_show_pending_machine', 1) !== 1) {
            return false;
        }
        return true;
    }

    protected function cacheKey(string $type, int $id, string $lang): string
    {
        return 'i18n:' . $type . ':' . $id . ':' . $lang;
    }

    /**
     * 批量读取实体在某语种的译文（带请求内记忆 + 10 分钟缓存）
     * @return array [id => [field => ['value','status']]]
     */
    protected function loadEntities(string $type, array $ids, string $lang): array
    {
        $out = [];
        $miss = [];
        foreach ($ids as $id) {
            $id = (int)$id;
            $mk = $type . '|' . $id . '|' . $lang;
            if (isset(self::$memo[$mk])) {
                $out[$id] = self::$memo[$mk];
                continue;
            }
            $c = Cache::get($this->cacheKey($type, $id, $lang));
            if (is_array($c)) {
                self::$memo[$mk] = $out[$id] = $c;
            } else {
                $miss[] = $id;
            }
        }
        if ($miss) {
            $rows = Db::name('i18n_content')->where(['entity_type' => $type, 'lang' => $lang])->whereIn('entity_id', $miss)->select()->toArray();
            $found = [];
            foreach ($rows as $r) {
                $found[(int)$r['entity_id']][$r['field']] = ['value' => (string)$r['value'], 'status' => (int)$r['status']];
            }
            foreach ($miss as $id) {
                $set = $found[$id] ?? [];
                Cache::set($this->cacheKey($type, $id, $lang), $set, self::TTL);
                self::$memo[$type . '|' . $id . '|' . $lang] = $out[$id] = $set;
            }
        }
        return $out;
    }

    protected function splitValues(string $s): array
    {
        return $s === '' ? [] : explode(',', $s);
    }

    /**
     * attr_values 译文必须与原值个数一致（按位置一一对应）
     */
    protected function assertAttrValuesAligned(int $attrId, string $translated): void
    {
        $orig = (string)Db::name('store_product_attr')->where('id', $attrId)->value('attr_values');
        if (count($this->splitValues($orig)) !== count($this->splitValues($translated))) {
            throw new ApiException('规格值译文数量必须与原规格值一致(逗号分隔)');
        }
    }

    /**
     * 机翻源文：zh-CN 译文优先，其次主表字段
     */
    protected function sourceTexts(string $type, int $id, array $fields): array
    {
        $table = ['product' => 'store_product', 'category' => 'store_category'][$type] ?? null;
        $orig = $table ? (Db::name($table)->where('id', $id)->find() ?: []) : [];
        $zh = $this->getAll($type, $id)['zh-CN'] ?? [];
        $out = [];
        foreach ($fields as $f) {
            $v = isset($zh[$f]) ? $zh[$f]['value'] : ($orig[$f] ?? '');
            if ($v !== '' && $v !== null) {
                $out[$f] = (string)$v;
            }
        }
        return $out;
    }
}
