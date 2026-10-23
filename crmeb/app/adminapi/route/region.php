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

/**
 * VN: 商品区域价路由（URL 前缀 product/region_price）
 */
Route::group('product/region_price', function () {
    Route::get('template', 'v1.vn.ProductRegionPrice/template')->option(['real_name' => '区域价导入模板']);
    Route::post('import', 'v1.vn.ProductRegionPrice/import')->option(['real_name' => '区域价Excel导入']);
    Route::get('export', 'v1.vn.ProductRegionPrice/export')->option(['real_name' => '区域价Excel导出']);
    Route::get(':product_id', 'v1.vn.ProductRegionPrice/read')->option(['real_name' => '商品区域价读取']);
    Route::post(':product_id', 'v1.vn.ProductRegionPrice/save')->option(['real_name' => '商品区域价保存']);
})->middleware([
    \app\http\middleware\AllowOriginMiddleware::class,
    \app\adminapi\middleware\AdminAuthTokenMiddleware::class,
    \app\adminapi\middleware\AdminCheckRoleMiddleware::class,
    \app\adminapi\middleware\AdminLogMiddleware::class
])->option(['mark' => 'regionPrice', 'mark_name' => '商品区域价']);

/**
 * VN: 内容多语路由
 */
Route::group('i18n', function () {
    Route::get('missing', 'v1.vn.I18n/missing')->option(['real_name' => '缺译文清单']);
    Route::get('export', 'v1.vn.I18n/export')->option(['real_name' => '译文导出']);
    Route::post('import', 'v1.vn.I18n/import')->option(['real_name' => '译文导入']);
    Route::get(':type/:id', 'v1.vn.I18n/read')->option(['real_name' => '译文读取']);
    Route::post(':type/:id/machine', 'v1.vn.I18n/machine')->option(['real_name' => '译文机翻']);
    Route::post(':type/:id', 'v1.vn.I18n/write')->option(['real_name' => '译文保存']);
})->middleware([
    \app\http\middleware\AllowOriginMiddleware::class,
    \app\adminapi\middleware\AdminAuthTokenMiddleware::class,
    \app\adminapi\middleware\AdminCheckRoleMiddleware::class,
    \app\adminapi\middleware\AdminLogMiddleware::class
])->option(['mark' => 'i18n', 'mark_name' => '内容多语']);

Route::group('product/i18n', function () {
    Route::get(':id', 'v1.vn.I18n/productRead')->option(['real_name' => '商品译文读取']);
    Route::post(':id', 'v1.vn.I18n/productWrite')->option(['real_name' => '商品译文保存']);
})->middleware([
    \app\http\middleware\AllowOriginMiddleware::class,
    \app\adminapi\middleware\AdminAuthTokenMiddleware::class,
    \app\adminapi\middleware\AdminCheckRoleMiddleware::class,
    \app\adminapi\middleware\AdminLogMiddleware::class
])->option(['mark' => 'productI18n', 'mark_name' => '商品多语']);
