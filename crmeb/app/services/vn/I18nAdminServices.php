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
use app\services\other\I18nContentServices;
use crmeb\exceptions\ApiException;
use crmeb\services\SpreadsheetExcelService;
use think\facade\Db;

/**
 * 后台内容多语：按实体读取/保存译文、缺译文清单、Excel 导入导出
 * Class I18nAdminServices
 * @package app\services\vn
 */
class I18nAdminServices extends BaseServices
{
    /** 实体主表与展示字段 */
    const TABLES = [
        'product'   => ['store_product', 'id', 'store_name'],
        'category'  => ['store_category', 'id', 'cate_name'],
        'city'      => ['system_city', 'city_id', 'name'],
        'warehouse' => ['vn_warehouse', 'id', 'name'],
    ];

    /**
     * 读取：主表原值 + 译文 + （商品）规格/规格值清单
     */
    public function read(string $type, int $id): array
    {
        $meta = self::TABLES[$type] ?? null;
        if (!$meta) {
            throw new ApiException('参数错误');
        }
        $row = Db::name($meta[0])->where($meta[1], $id)->find();
        if (!$row) {
            throw new ApiException('数据不存在');
        }
        $fields = I18nContentServices::ENTITY_FIELDS[$type];
        $original = [];
        foreach ($fields as $f) {
            $original[$f] = $row[$f] ?? '';
        }
        if ($type === 'product') {
            $original['description'] = (string)Db::name('store_product_description')->where(['product_id' => $id, 'type' => 0])->value('description');
        }
        /** @var I18nContentServices $i18n */
        $i18n = app()->make(I18nContentServices::class);
        $data = [
            'type'         => $type,
            'id'           => $id,
            'title'        => $row[$meta[2]],
            'fields'       => $fields,
            'original'     => $original,
            'translations' => $i18n->getAll($type, $id),
            'langs'        => I18nContentServices::LANGS,
            'default_lang' => normalize_lang_code((string)sys_config('default_lang', 'vi-VN')) ?: 'vi-VN',
        ];
        if ($type === 'product') {
            $attrs = Db::name('store_product_attr')->where(['product_id' => $id, 'type' => 0])->order('id', 'asc')->select()->toArray();
            $data['attrs'] = [];
            foreach ($attrs as $a) {
                $data['attrs'][] = [
                    'id' => (int)$a['id'], 'attr_name' => $a['attr_name'], 'attr_values' => $a['attr_values'],
                    'translations' => $i18n->getAll('product_attr', (int)$a['id']),
                ];
            }
            $skus = Db::name('store_product_attr_value')->where(['product_id' => $id, 'type' => 0])->field('id,suk,unique')->order('id', 'asc')->select()->toArray();
            $data['skus'] = [];
            foreach ($skus as $s) {
                $data['skus'][] = ['id' => (int)$s['id'], 'suk' => $s['suk'], 'translations' => $i18n->getAll('sku', (int)$s['id'])];
            }
        }
        return $data;
    }

    /**
     * 保存：translations[lang][field]；商品额外 attrs[attrId][lang][field]、skus[skuId][lang][suk]
     */
    public function write(string $type, int $id, array $translations, array $attrs = [], array $skus = [], int $status = 1): bool
    {
        if (!isset(self::TABLES[$type])) {
            throw new ApiException('参数错误');
        }
        $meta = self::TABLES[$type];
        if (!Db::name($meta[0])->where($meta[1], $id)->count()) {
            throw new ApiException('数据不存在');
        }
        /** @var I18nContentServices $i18n */
        $i18n = app()->make(I18nContentServices::class);
        Db::transaction(function () use ($i18n, $type, $id, $translations, $attrs, $skus, $status) {
            if ($translations) {
                $i18n->save($type, $id, $translations, $status);
            }
            if ($type === 'product') {
                $ownAttr = Db::name('store_product_attr')->where('product_id', $id)->column('id');
                foreach ($attrs as $attrId => $byLang) {
                    if (in_array((int)$attrId, array_map('intval', $ownAttr), true)) {
                        $i18n->save('product_attr', (int)$attrId, $byLang, $status);
                    }
                }
                $ownSku = Db::name('store_product_attr_value')->where('product_id', $id)->column('id');
                foreach ($skus as $skuId => $byLang) {
                    if (in_array((int)$skuId, array_map('intval', $ownSku), true)) {
                        $i18n->save('sku', (int)$skuId, $byLang, $status);
                    }
                }
            }
        });
        return true;
    }

    /**
     * 缺译文清单（含名称）：返回 [['id','title'],…]
     */
    public function missing(string $type, string $lang, string $field, int $limit = 200): array
    {
        $meta = self::TABLES[$type] ?? null;
        if (!$meta) {
            throw new ApiException('参数错误');
        }
        $ids = app()->make(I18nContentServices::class)->missing($type, $lang, $field, $limit);
        if (!$ids) {
            return [];
        }
        $titles = Db::name($meta[0])->whereIn($meta[1], $ids)->column($meta[2], $meta[1]);
        $out = [];
        foreach ($ids as $i) {
            $out[] = ['id' => (int)$i, 'title' => $titles[$i] ?? ''];
        }
        return $out;
    }

    /**
     * 导出（实体类型可空=全部）：保存到 public，返回相对路径
     */
    public function exportFile(string $type = ''): string
    {
        $q = Db::name('i18n_content')->order('entity_type')->order('entity_id')->order('field')->order('lang');
        if ($type !== '') {
            $q->where('entity_type', $type);
        }
        $rows = [];
        foreach ($q->select() as $r) {
            $rows[] = [$r['entity_type'], $r['entity_id'], $r['field'], $r['lang'], $r['value']];
        }
        $title = '多语译文';
        $path = SpreadsheetExcelService::instance()
            ->setExcelHeader(['entity_type', 'entity_id', 'field', 'lang', 'value'])
            ->setExcelTile($title, $title, date('Y-m-d H:i:s'))
            ->setExcelContent($rows)
            ->excelSave($title . '_' . date('YmdHis'), 'xlsx', true);
        return '/' . ltrim($path, './');
    }

    /**
     * 导入：列 entity_type, entity_id, field, lang, value；返回 ['ok'=>n,'fail'=>[['row','reason']]]
     */
    public function importFile(string $filePath, int $status = 1): array
    {
        $rows = \PhpOffice\PhpSpreadsheet\IOFactory::load($filePath)->getActiveSheet()->toArray(null, true, false, false);
        if (!$rows) {
            throw new ApiException('文件内容为空');
        }
        $start = (isset($rows[0][0]) && $rows[0][0] === 'entity_type') ? 1 : 0;
        $i18n = app()->make(I18nContentServices::class);
        $ok = 0;
        $fail = [];
        for ($i = $start; $i < count($rows); $i++) {
            $r = $rows[$i];
            $line = $i + 1;
            if (!array_filter($r, function ($v) { return $v !== null && $v !== ''; })) {
                continue;
            }
            $type = trim((string)($r[0] ?? ''));
            $id = (int)($r[1] ?? 0);
            $field = trim((string)($r[2] ?? ''));
            $lang = normalize_lang_code(trim((string)($r[3] ?? '')));
            $value = (string)($r[4] ?? '');
            if (!isset(I18nContentServices::ENTITY_FIELDS[$type]) || !in_array($field, I18nContentServices::ENTITY_FIELDS[$type], true)) {
                $fail[] = ['row' => $line, 'reason' => 'entity_type/field 不支持'];
                continue;
            }
            if (!in_array($lang, I18nContentServices::LANGS, true)) {
                $fail[] = ['row' => $line, 'reason' => 'lang 不支持'];
                continue;
            }
            if ($id <= 0) {
                $fail[] = ['row' => $line, 'reason' => 'entity_id 不合法'];
                continue;
            }
            try {
                $i18n->save($type, $id, [$lang => [$field => $value]], $status);
                $ok++;
            } catch (\Throwable $e) {
                $fail[] = ['row' => $line, 'reason' => $e->getMessage()];
            }
        }
        return ['ok' => $ok, 'fail' => $fail];
    }
}
