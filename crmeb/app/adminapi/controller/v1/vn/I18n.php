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

namespace app\adminapi\controller\v1\vn;

use app\adminapi\controller\AuthController;
use app\services\other\I18nContentServices;
use app\services\vn\I18nAdminServices;
use think\facade\App;

/**
 * 后台：内容多语（商品/分类/区划）
 * Class I18n
 * @package app\adminapi\controller\v1\vn
 */
class I18n extends AuthController
{
    /**
     * @var I18nAdminServices
     */
    protected $services;

    public function __construct(App $app, I18nAdminServices $services)
    {
        parent::__construct($app);
        $this->services = $services;
    }

    public function read($type, $id)
    {
        return app('json')->success($this->services->read((string)$type, (int)$id));
    }

    public function write($type, $id)
    {
        [$translations, $attrs, $skus] = $this->request->postMore([
            ['translations', []],
            ['attrs', []],
            ['skus', []],
        ], true);
        $this->services->write((string)$type, (int)$id, (array)$translations, (array)$attrs, (array)$skus);
        return app('json')->success('保存成功');
    }

    /**
     * 商品多语别名路由：product/i18n/:id
     */
    public function productRead($id)
    {
        return $this->read('product', $id);
    }

    public function productWrite($id)
    {
        return $this->write('product', $id);
    }

    /**
     * 机翻填充
     */
    public function machine($type, $id)
    {
        [$fields, $langs] = $this->request->postMore([['fields', []], ['langs', ['vi-VN', 'en-US']]], true);
        $fields = $fields ?: I18nContentServices::ENTITY_FIELDS[(string)$type] ?? [];
        app()->make(I18nContentServices::class)->machineFill((string)$type, (int)$id, (array)$fields, (array)$langs);
        return app('json')->success('机翻完成，请人工审核后再发布');
    }

    /**
     * 缺译文清单
     */
    public function missing()
    {
        [$type, $lang, $field] = $this->request->getMore([['type', 'product'], ['lang', 'vi-VN'], ['field', 'store_name']], true);
        return app('json')->success($this->services->missing((string)$type, (string)$lang, (string)$field));
    }

    public function export()
    {
        [$type] = $this->request->getMore([['type', '']], true);
        return app('json')->success(['url' => rtrim($this->request->domain(), '/') . $this->services->exportFile((string)$type)]);
    }

    public function import()
    {
        $file = $this->request->file('file');
        if (!$file) {
            return app('json')->fail('请选择文件');
        }
        return app('json')->success($this->services->importFile($file->getPathname()));
    }
}
