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
namespace crmeb\utils;

use crmeb\exceptions\AdminException;
use crmeb\exceptions\ApiException;

/**
 * 机器翻译驱动工厂：google_gtx（默认）/ volcano
 */
class TranslateFactory
{
    public const DRIVER_GOOGLE_GTX = 'google_gtx';
    public const DRIVER_VOLCANO = 'volcano';

    public static function driver(): string
    {
        $d = (string)sys_config('translate_driver', self::DRIVER_GOOGLE_GTX);
        return $d === self::DRIVER_VOLCANO ? self::DRIVER_VOLCANO : self::DRIVER_GOOGLE_GTX;
    }

    /**
     * 当前驱动是否已具备调用条件
     * @param bool $asAdmin true 抛 AdminException，否则 ApiException
     */
    public static function assertReady(bool $asAdmin = true): void
    {
        if (self::driver() !== self::DRIVER_VOLCANO) {
            return;
        }
        if (sys_config('hs_accesskey') == '' || sys_config('hs_secretkey') == '') {
            $msg = '请先在翻译配置中填写火山 AccessKey/SecretKey，或改用 Google gtx 驱动';
            if ($asAdmin) {
                throw new AdminException($msg);
            }
            throw new ApiException($msg);
        }
    }

    /**
     * @return Translate|GoogleGtxTranslate 均实现 translateText(...)
     */
    public static function create()
    {
        self::assertReady(true);
        if (self::driver() === self::DRIVER_VOLCANO) {
            $translator = Translate::getInstance();
            $translator->setAccessKey(sys_config('hs_accesskey'));
            $translator->setSecretKey(sys_config('hs_secretkey'));
            return $translator;
        }
        return new GoogleGtxTranslate();
    }

    /**
     * API 侧（非后台）创建
     * @return Translate|GoogleGtxTranslate
     */
    public static function createForApi()
    {
        self::assertReady(false);
        if (self::driver() === self::DRIVER_VOLCANO) {
            $translator = Translate::getInstance();
            $translator->setAccessKey(sys_config('hs_accesskey'));
            $translator->setSecretKey(sys_config('hs_secretkey'));
            return $translator;
        }
        return new GoogleGtxTranslate();
    }
}
