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
use app\services\vn\RegionAdminServices;
use app\services\vn\WarehouseAdminServices;
use think\facade\App;

/**
 * 后台配送区域/区划管理
 * Class Region
 * @package app\adminapi\controller\v1\vn
 */
class Region extends AuthController
{
    /**
     * @var RegionAdminServices
     */
    protected $services;

    public function __construct(App $app, RegionAdminServices $services)
    {
        parent::__construct($app);
        $this->services = $services;
    }

    public function lst()
    {
        $where = $this->request->getMore([
            ['parent_id', 0], ['keyword', ''], ['country_code', ''], ['is_open', ''], ['page', 1], ['limit', 50],
        ]);
        $data = $this->services->lst($where);
        $data['list'] = app()->make(WarehouseAdminServices::class)->attachDefaultToCities($data['list'] ?? []);
        return app('json')->success($data);
    }

    public function open()
    {
        [$ids, $isOpen, $cascade] = $this->request->postMore([['ids', []], ['is_open', 1], ['cascade', 0]], true);
        $ids = is_array($ids) ? $ids : explode(',', (string)$ids);
        return app('json')->success(['affected' => $this->services->setOpen($ids, (int)$isOpen, (bool)$cascade)]);
    }

    public function hot()
    {
        [$ids, $isHot] = $this->request->postMore([['ids', []], ['is_hot', 1]], true);
        $ids = is_array($ids) ? $ids : explode(',', (string)$ids);
        return app('json')->success(['affected' => $this->services->setHot($ids, (int)$isHot)]);
    }

    public function sort()
    {
        [$cityId, $sort] = $this->request->postMore([['city_id', 0], ['sort', 0]], true);
        $this->services->setSort((int)$cityId, (int)$sort);
        return app('json')->success('操作成功');
    }

    public function save()
    {
        $d = $this->request->postMore([
            ['city_id', 0], ['parent_id', 0], ['name', ''], ['area_code', ''], ['lng', ''], ['lat', ''], ['is_show', 1],
        ]);
        return app('json')->success('保存成功', ['city_id' => $this->services->save($d)]);
    }

    /**
     * Excel 导入（multipart，字段 file）
     */
    public function import()
    {
        $file = $this->request->file('file');
        if (!$file) {
            return app('json')->fail('请选择文件');
        }
        return app('json')->success($this->services->importFile($file->getPathname()));
    }

    public function rebuild_path()
    {
        return app('json')->success(['updated' => $this->services->rebuildPath()]);
    }

    /**
     * 导入模板列
     */
    public function template()
    {
        return app('json')->success(['columns' => RegionAdminServices::IMPORT_COLUMNS]);
    }

    /**
     * 按 city_id 反显祖先链与颗粒度（管理端级联选择器用）
     */
    public function resolve()
    {
        [$cityId] = $this->request->getMore([['city_id', 0]], true);
        return app('json')->success($this->services->resolve((int)$cityId));
    }
}
