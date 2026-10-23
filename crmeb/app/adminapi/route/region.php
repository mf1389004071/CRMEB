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
use think\facade\Route;

/**
 * VN: 配送区域/区划管理路由
 */
Route::group('region', function () {
    Route::get('list', 'v1.vn.Region/lst')->option(['real_name' => '区划列表']);
    Route::post('open', 'v1.vn.Region/open')->option(['real_name' => '区划批量开放/取消']);
    Route::post('hot', 'v1.vn.Region/hot')->option(['real_name' => '区划批量热门']);
    Route::post('sort', 'v1.vn.Region/sort')->option(['real_name' => '区划排序']);
    Route::post('save', 'v1.vn.Region/save')->option(['real_name' => '区划新增编辑']);
    Route::post('import', 'v1.vn.Region/import')->option(['real_name' => '区划Excel导入']);
    Route::post('rebuild_path', 'v1.vn.Region/rebuild_path')->option(['real_name' => '区划重建path']);
    Route::get('template', 'v1.vn.Region/template')->option(['real_name' => '区划导入模板列']);
})->middleware([
    \app\http\middleware\AllowOriginMiddleware::class,
    \app\adminapi\middleware\AdminAuthTokenMiddleware::class,
    \app\adminapi\middleware\AdminCheckRoleMiddleware::class,
    \app\adminapi\middleware\AdminLogMiddleware::class
])->option(['mark' => 'region', 'mark_name' => '配送区域']);
