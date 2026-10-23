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
namespace app\api\controller\v1\store;

use app\services\product\product\StoreCategoryServices;
use think\Request;

/**
 * Class CategoryController
 * @package app\api\controller\v1\store
 */
class CategoryController
{
    protected $services;

    public function __construct(StoreCategoryServices $services)
    {
        $this->services = $services;
    }

    /**
     * 获取分类列表
     * @param Request $request
     * @return mixed
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function category(Request $request)
    {
        $where = $request->getMore([
            ['pid', 0],
        ]);
        $category = $this->services->getCategory($where);
        // VN: 内容多语——分类名（树形）
        if (i18n_content_active() && is_array($category)) {
            $category = app()->make(\app\services\other\I18nContentServices::class)->applyTree($category, 'category', 'id', ['cate_name'], 'children');
        }
        return app('json')->success($category);
    }

    /**
     * @return mixed
     * @author 等风来
     * @email 136327134@qq.com
     * @date 2022/11/11
     */
    public function getCategoryVersion()
    {
        $data = $this->services->getCategoryVersion();
        // VN: 版本号带语种，保证切换语言后前端缓存的分类名随之刷新
        $version = i18n_content_active() ? $data['version'] . '_' . current_lang_code() : $data['version'];
        return app('json')->success(['version' => $version, 'is_diy' => $data['is_diy']]);
    }
}
