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
use app\services\vn\RegionPriceAdminServices;
use think\facade\App;

/**
 * 后台：商品区域价
 * Class ProductRegionPrice
 * @package app\adminapi\controller\v1\vn
 */
class ProductRegionPrice extends AuthController
{
    /**
     * @var RegionPriceAdminServices
     */
    protected $services;

    public function __construct(App $app, RegionPriceAdminServices $services)
    {
        parent::__construct($app);
        $this->services = $services;
    }

    /**
     * 读取某商品区域价
     */
    public function read($product_id)
    {
        return app('json')->success($this->services->get((int)$product_id));
    }

    /**
     * 保存某商品区域价（整品覆盖）
     */
    public function save($product_id)
    {
        [$rows, $scope, $allow] = $this->request->postMore([
            ['rows', []],
            ['scope_city_ids', []],
            ['allow_national_price', null],
        ], true);
        return app('json')->success($this->services->save(
            (int)$product_id,
            is_array($rows) ? $rows : [],
            is_array($scope) ? $scope : [],
            $allow === null || $allow === '' ? null : (int)$allow
        ));
    }

    /**
     * 导入模板（返回下载地址）
     */
    public function template()
    {
        return app('json')->success(['url' => rtrim($this->request->domain(), '/') . $this->services->exportFile(0, true)]);
    }

    /**
     * Excel 导入
     */
    public function import()
    {
        $file = $this->request->file('file');
        if (!$file) {
            return app('json')->fail('请选择文件');
        }
        return app('json')->success($this->services->importFile($file->getPathname()));
    }

    /**
     * 导出（product_id 为空导出全部）
     */
    public function export()
    {
        [$pid] = $this->request->getMore([['product_id', 0]], true);
        return app('json')->success(['url' => rtrim($this->request->domain(), '/') . $this->services->exportFile((int)$pid)]);
    }
}
