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
use app\services\vn\FreshAdminServices;
use think\facade\App;

/**
 * 后台：商品生鲜属性
 * Class ProductFresh
 * @package app\adminapi\controller\v1\vn
 */
class ProductFresh extends AuthController
{
    /**
     * @var FreshAdminServices
     */
    protected $services;

    public function __construct(App $app, FreshAdminServices $services)
    {
        parent::__construct($app);
        $this->services = $services;
    }

    public function read($id)
    {
        return app('json')->success($this->services->get((int)$id));
    }

    public function save($id)
    {
        $d = $this->request->postMore([
            ['is_fresh', 0], ['net_weight', 0], ['shelf_life_days', 0], ['shelf_life_text', ''],
            ['origin', ''], ['need_cold_chain', 0], ['cold_chain_note', ''], ['tax_rate', 0],
        ]);
        $this->services->save((int)$id, $d);
        return app('json')->success('保存成功');
    }
}
