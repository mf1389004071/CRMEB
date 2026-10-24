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

use crmeb\exceptions\ApiException;

/**
 * Google 网页 gtx 机翻（与 kizERP I18nUtil 同族；非 Cloud Translation）
 * 返回结构对齐火山 Translate::translateText → [['Translation' => string], ...]
 */
class GoogleGtxTranslate
{
    /** @var bool 进程内：直连已失败则后续优先走代理 */
    private static $directUnavailable = false;

    private const URL = 'https://translate.googleapis.com/translate_a/single?client=gtx&sl=%s&tl=%s&dt=t&q=%s';

    /**
     * @param string $sourceLanguage 空则按 zh-CN
     * @param string $targetLanguage 如 vi / en / zh-Hant
     * @param array $textList
     * @return array
     */
    public function translateText(string $sourceLanguage, string $targetLanguage, array $textList): array
    {
        $source = $sourceLanguage !== '' ? $sourceLanguage : 'zh-CN';
        $target = $this->normalizeTarget($targetLanguage);
        $intervalMs = (int)sys_config('translate_gtx_interval_ms', 150);
        if ($intervalMs < 0) {
            $intervalMs = 0;
        }
        $out = [];
        $i = 0;
        foreach ($textList as $text) {
            if ($i > 0 && $intervalMs > 0) {
                usleep($intervalMs * 1000);
            }
            $out[] = ['Translation' => $this->translateOne($source, $target, (string)$text)];
            $i++;
        }
        return $out;
    }

    protected function normalizeTarget(string $target): string
    {
        $t = str_replace('_', '-', trim($target));
        if ($t === 'zh-Hant' || stripos($t, 'Hant') !== false || strcasecmp($t, 'zh-TW') === 0) {
            return 'zh-TW';
        }
        // vi-VN / en-US → vi / en（BatchTranslation 传入的是 file_name）
        if (preg_match('/^([a-zA-Z]{2,3})/', $t, $m)) {
            return strtolower($m[1]) === 'zh' ? 'zh-CN' : strtolower($m[1]);
        }
        return $t;
    }

    protected function translateOne(string $source, string $target, string $text): string
    {
        if ($text === '') {
            return '';
        }
        $proxyHost = trim((string)sys_config('translate_proxy_host', ''));
        $proxyPort = (int)sys_config('translate_proxy_port', 7890);
        $proxyConfigured = $proxyHost !== '';

        if (!self::$directUnavailable) {
            try {
                return $this->doRequest($source, $target, $text, null, 0);
            } catch (\Throwable $e) {
                self::$directUnavailable = true;
                if (!$proxyConfigured) {
                    throw $e;
                }
            }
        }

        if (self::$directUnavailable && $proxyConfigured) {
            return $this->doRequest($source, $target, $text, $proxyHost, $proxyPort);
        }

        return $this->doRequest($source, $target, $text, null, 0);
    }

    protected function doRequest(string $source, string $target, string $text, $proxyHost, int $proxyPort): string
    {
        $url = sprintf(
            self::URL,
            rawurlencode($source),
            rawurlencode($target),
            rawurlencode($text)
        );

        $ch = curl_init($url);
        if ($ch === false) {
            throw new ApiException('Google gtx curl_init failed');
        }
        $opts = [
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_CONNECTTIMEOUT => 10,
            CURLOPT_TIMEOUT => 10,
            CURLOPT_HTTPHEADER => ['User-Agent: Mozilla/5.0'],
            CURLOPT_SSL_VERIFYPEER => false,
            CURLOPT_SSL_VERIFYHOST => false,
        ];
        if ($proxyHost !== null && $proxyHost !== '') {
            $opts[CURLOPT_PROXY] = $proxyHost;
            $opts[CURLOPT_PROXYPORT] = $proxyPort > 0 ? $proxyPort : 7890;
            $opts[CURLOPT_PROXYTYPE] = CURLPROXY_HTTP;
        }
        curl_setopt_array($ch, $opts);
        $body = curl_exec($ch);
        $errno = curl_errno($ch);
        $err = curl_error($ch);
        $code = (int)curl_getinfo($ch, CURLINFO_HTTP_CODE);
        curl_close($ch);

        if ($errno || $body === false) {
            throw new ApiException('Google gtx request failed: ' . ($err ?: 'errno=' . $errno));
        }
        if ($code < 200 || $code >= 300) {
            throw new ApiException('Google gtx http ' . $code . ': ' . mb_substr((string)$body, 0, 200));
        }

        $data = json_decode((string)$body, true);
        if (!is_array($data) || !isset($data[0]) || !is_array($data[0])) {
            throw new ApiException('Google gtx invalid response');
        }
        $parts = [];
        foreach ($data[0] as $seg) {
            if (is_array($seg) && isset($seg[0]) && is_string($seg[0])) {
                $parts[] = $seg[0];
            }
        }
        return implode('', $parts);
    }
}
