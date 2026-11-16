<?php
// +----------------------------------------------------------------------
// | CRMEB [ CRMEB赋能开发者，助力企业发展 ]
// +----------------------------------------------------------------------
// | Copyright (c) 2016~2026 https://www.kizerp.com All rights reserved.
// +----------------------------------------------------------------------
// | Licensed CRMEB并不是自由软件，未经许可不能去掉CRMEB相关版权
// +----------------------------------------------------------------------
// | Author: CRMEB Team <admin@kizerp.com>
// +----------------------------------------------------------------------

namespace app\listener\queue;


use think\console\Output;

class QueueStartListener
{

    public function handle(Output $output)
    {
        $output->writeln('消息队列已启动，正在运行中，windows请不要关闭命令行。linux请使用Supervisor进行进程守护');
    }
}
