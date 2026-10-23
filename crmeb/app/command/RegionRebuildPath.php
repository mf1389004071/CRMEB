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

namespace app\command;

use app\services\vn\RegionAdminServices;
use think\console\Command;
use think\console\Input;
use think\console\Output;

/**
 * 重建 eb_system_city.path：php think region:rebuild_path
 * Class RegionRebuildPath
 * @package app\command
 */
class RegionRebuildPath extends Command
{
    protected function configure()
    {
        $this->setName('region:rebuild_path')->setDescription('重建 eb_system_city.path 祖先链');
    }

    protected function execute(Input $input, Output $output)
    {
        $n = app()->make(RegionAdminServices::class)->rebuildPath();
        $output->writeln('path rebuilt, updated rows: ' . $n);
    }
}
