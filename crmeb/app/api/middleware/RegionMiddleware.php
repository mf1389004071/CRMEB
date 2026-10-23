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

namespace app\api\middleware;

use app\Request;
use app\services\vn\RegionServices;
use crmeb\interfaces\MiddlewareInterface;

/**
 * 读取 Cb-region 并校验：存在且 is_open=1 才生效，否则置 0（调用方据此返回 region_required）
 * 挂到商品/购物车/订单路由组
 * Class RegionMiddleware
 * @package app\api\middleware
 */
class RegionMiddleware implements MiddlewareInterface
{
    public function handle(Request $request, \Closure $next)
    {
        $id = (int)$request->header('cb-region');
        $valid = $id > 0 && app()->make(RegionServices::class)->isOpenId($id);
        $request->regionId = $valid ? $id : 0;
        return $next($request);
    }
}
