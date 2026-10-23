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
// 菜集鲜（越南站）新增 H5 接口路由，独立文件，避免改动 v1.php

use think\facade\Route;

// 无需登录（token 可选）
Route::group(function () {
    Route::get('vn/contacts', 'v1.vn.VnController/contacts')->option(['real_name' => '联系方式']);
    Route::get('phone/countries', 'v1.vn.VnController/phoneCountries')->option(['real_name' => '手机区号字典']);
    // 配送区域
    Route::get('region/children', 'v1.vn.RegionController/children')->option(['real_name' => '区域子节点']);
    Route::get('region/hot', 'v1.vn.RegionController/hot')->option(['real_name' => '热门区域']);
    Route::post('region/locate', 'v1.vn.RegionController/locate')->option(['real_name' => '经纬度定位区域']);
    Route::get('region/info', 'v1.vn.RegionController/info')->option(['real_name' => '区域校验与完整链']);
    Route::get('region/address_children', 'v1.vn.RegionController/address_children')->option(['real_name' => '地址选择子节点']);
})->middleware(\app\http\middleware\AllowOriginMiddleware::class)
    ->middleware(\app\api\middleware\StationOpenMiddleware::class)
    ->middleware(\app\api\middleware\AuthTokenMiddleware::class, false)
    ->middleware(\app\api\middleware\RegionMiddleware::class);

// 员工端（配送员/核销员/订单管理员，需登录）
Route::group(function () {
    Route::post('admin/order/cod/verify', 'v1.admin.CodOrderController/verify')->option(['real_name' => '到付订单送达核销']);
    Route::get('admin/order/cod/detail', 'v1.admin.CodOrderController/detail')->option(['real_name' => '到付订单核销详情']);
})->middleware(\app\http\middleware\AllowOriginMiddleware::class)
    ->middleware(\app\api\middleware\StationOpenMiddleware::class)
    ->middleware(\app\api\middleware\AuthTokenMiddleware::class, true)
    ->middleware(\app\api\middleware\CustomerMiddleware::class)
    ->option(['mark' => 'admin', 'mark_name' => '移动端订单管理']);

// 登录用户（无需员工权限）
Route::group(function () {
    Route::post('cart/clear_all', 'v1.vn.VnController/clearCart')->option(['real_name' => '清空购物车(切换区域)']);
})->middleware(\app\http\middleware\AllowOriginMiddleware::class)
    ->middleware(\app\api\middleware\StationOpenMiddleware::class)
    ->middleware(\app\api\middleware\AuthTokenMiddleware::class, true)
    ->middleware(\app\api\middleware\RegionMiddleware::class);
