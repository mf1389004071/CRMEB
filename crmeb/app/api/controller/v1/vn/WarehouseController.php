<?php
namespace app\api\controller\v1\vn;

use app\services\vn\WarehouseMatchServices;
use think\Request;

/**
 * H5 提货仓匹配
 */
class WarehouseController
{
    public function match(Request $request, WarehouseMatchServices $services)
    {
        $cityId = (int)$request->param('city_id', 0);
        return app('json')->success($services->match($cityId, true));
    }
}
