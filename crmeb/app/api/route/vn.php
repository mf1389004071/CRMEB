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
})->middleware(\app\http\middleware\AllowOriginMiddleware::class)
    ->middleware(\app\api\middleware\StationOpenMiddleware::class)
    ->middleware(\app\api\middleware\AuthTokenMiddleware::class, false);
