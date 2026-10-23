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

namespace app\adminapi\controller\v1\order;

use app\adminapi\controller\AuthController;
use app\services\order\OrderRiskServices;
use think\facade\App;

/**
 * 下单黑名单
 * Class OrderBlacklist
 * @package app\adminapi\controller\v1\order
 */
class OrderBlacklist extends AuthController
{
    /**
     * @var OrderRiskServices
     */
    protected $services;

    public function __construct(App $app, OrderRiskServices $services)
    {
        parent::__construct($app);
        $this->services = $services;
    }

    public function lst()
    {
        $where = $this->request->getMore([
            ['type', ''],
            ['keyword', ''],
            ['page', 1],
            ['limit', 20],
        ]);
        return app('json')->success($this->services->blacklist($where));
    }

    public function save()
    {
        [$type, $value, $remark] = $this->request->postMore([
            ['type', ''],
            ['value', ''],
            ['remark', ''],
        ], true);
        $this->services->addBlacklist((string)$type, (string)$value, (string)$remark);
        return app('json')->success('操作成功');
    }

    public function delete($id)
    {
        $this->services->removeBlacklist((int)$id);
        return app('json')->success('操作成功');
    }
}
