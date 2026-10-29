<?php
namespace app\adminapi\controller\v1\vn;

use app\adminapi\controller\AuthController;
use app\services\vn\WarehouseAdminServices;
use think\facade\App;

/**
 * 后台提货仓库
 */
class Warehouse extends AuthController
{
    /** @var WarehouseAdminServices */
    protected $services;

    public function __construct(App $app, WarehouseAdminServices $services)
    {
        parent::__construct($app);
        $this->services = $services;
    }

    public function lst()
    {
        $where = $this->request->getMore([
            ['keyword', ''], ['is_enable', ''], ['page', 1], ['limit', 20],
        ]);
        return app('json')->success($this->services->lst($where));
    }

    public function read()
    {
        [$id] = $this->request->getMore([['id', 0]], true);
        return app('json')->success($this->services->read((int)$id));
    }

    public function save()
    {
        $d = $this->request->postMore([
            ['id', 0], ['code', ''], ['name', ''], ['address', ''], ['detailed_address', ''],
            ['introduction', ''], ['phone', ''], ['lng', ''], ['lat', ''],
            ['is_enable', 1], ['effective_start', 0], ['effective_end', 0],
            ['pickup_slots', []], ['auto_match', 1], ['exact_match_only', 0], ['sort', 0],
            ['regions', []],
        ]);
        return app('json')->success('保存成功', ['id' => $this->services->save($d)]);
    }

    public function delete()
    {
        [$id] = $this->request->postMore([['id', 0]], true);
        $this->services->delete((int)$id);
        return app('json')->success('删除成功');
    }

    public function quick_create()
    {
        $d = $this->request->postMore([
            ['name', ''], ['code', ''], ['address', ''], ['detailed_address', ''],
            ['phone', ''], ['introduction', ''], ['city_id', 0], ['force', 0], ['sort', 0],
            ['pickup_slots', []],
        ]);
        $ret = $this->services->quickCreate($d);
        if (!empty($ret['need_confirm'])) {
            return app('json')->success('该区域已有默认仓，请确认是否覆盖', $ret);
        }
        return app('json')->success('开仓成功', $ret);
    }

    public function regions()
    {
        [$id, $regions] = $this->request->postMore([['id', 0], ['regions', []]], true);
        $this->services->saveRegions((int)$id, is_array($regions) ? $regions : []);
        return app('json')->success('关联已保存');
    }

    public function set_region_default()
    {
        [$cityId, $warehouseId, $force] = $this->request->postMore([
            ['city_id', 0], ['warehouse_id', 0], ['force', 0],
        ], true);
        $ret = $this->services->setRegionDefault((int)$cityId, (int)$warehouseId, (bool)$force);
        if (!empty($ret['need_confirm'])) {
            return app('json')->success('该区域已有默认仓，请确认是否覆盖', $ret);
        }
        return app('json')->success('已设为默认提货仓', $ret);
    }

    public function for_region()
    {
        [$cityId] = $this->request->getMore([['city_id', 0]], true);
        return app('json')->success($this->services->forRegion((int)$cityId));
    }

    public function health()
    {
        return app('json')->success($this->services->health());
    }

    public function options()
    {
        return app('json')->success($this->services->options());
    }
}
