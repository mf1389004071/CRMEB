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
use app\services\vn\CurrencyAdminServices;
use think\facade\App;

/**
 * 后台：币种与汇率
 * Class Currency
 * @package app\adminapi\controller\v1\vn
 */
class Currency extends AuthController
{
    /**
     * @var CurrencyAdminServices
     */
    protected $services;

    public function __construct(App $app, CurrencyAdminServices $services)
    {
        parent::__construct($app);
        $this->services = $services;
    }

    public function lst()
    {
        return app('json')->success($this->services->lst());
    }

    public function save()
    {
        $d = $this->request->postMore([
            ['id', 0], ['code', ''], ['symbol', ''], ['name_zh', ''], ['name_vi', ''], ['name_en', ''],
            ['decimal_places', 2], ['thousand_sep', ','], ['decimal_sep', '.'], ['rate', ''], ['is_base', 0], ['status', 1], ['sort', 0],
        ]);
        return app('json')->success('保存成功', ['id' => $this->services->save($d, (int)$this->adminId)]);
    }

    public function delete($id)
    {
        $this->services->delete((int)$id);
        return app('json')->success('删除成功');
    }

    public function logs()
    {
        [$code] = $this->request->getMore([['code', '']], true);
        return app('json')->success($this->services->logs((string)$code));
    }
}
