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

namespace app\api\controller\v1\vn;

use app\Request;
use app\services\vn\RegionServices;

/**
 * H5 配送区域接口
 * Class RegionController
 * @package app\api\controller\v1\vn
 */
class RegionController
{
    /**
     * @var RegionServices
     */
    protected $services;

    public function __construct(RegionServices $services)
    {
        $this->services = $services;
    }

    /**
     * 子节点（仅 is_open=1）；parent_id 缺省=国家层
     */
    public function children(Request $request)
    {
        [$parentId] = $request->getMore([['parent_id', 0]], true);
        return app('json')->success($this->services->children((int)$parentId, true));
    }

    /**
     * 热门城市
     */
    public function hot()
    {
        return app('json')->success($this->services->hot());
    }

    /**
     * 经纬度定位
     */
    public function locate(Request $request)
    {
        [$lat, $lng] = $request->postMore([['lat', ''], ['lng', '']], true);
        if (!is_numeric($lat) || !is_numeric($lng) || abs((float)$lat) > 90 || abs((float)$lng) > 180) {
            return app('json')->fail('参数错误');
        }
        return app('json')->success($this->services->locate((float)$lat, (float)$lng));
    }

    /**
     * 校验并返回节点完整链（恢复本地缓存）
     */
    public function info(Request $request)
    {
        [$cityId] = $request->getMore([['city_id', 0]], true);
        // 未传 city_id 时按 Cb-region 头（经 RegionMiddleware 校验）返回当前区域
        $cityId = (int)$cityId ?: current_region_id();
        return app('json')->success($this->services->info((int)$cityId));
    }

    /**
     * 地址选择用：所有 is_show=1 的子节点（不受 is_open 白名单限制）
     */
    public function address_children(Request $request)
    {
        [$parentId] = $request->getMore([['parent_id', 0]], true);
        return app('json')->success($this->services->children((int)$parentId, false));
    }
}
