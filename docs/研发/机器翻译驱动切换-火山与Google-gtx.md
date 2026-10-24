# 机器翻译驱动切换（火山 / Google gtx）

> 状态：**已实现**。默认 **Google gtx（无 Key）**；火山引擎保留为可切换旧方案。  
> 依据：后台「翻译配置」`/admin/setting/lang_config/3/106`、kizERP `I18nUtil` 同族接口、菜集鲜机翻仅后台草稿。

---

## 1. 背景与结论

| 项 | 说明 |
|----|------|
| 现况 | `crmeb\utils\Translate` 走火山 `TranslateText`，依赖 `hs_accesskey` / `hs_secretkey` |
| 调用点 | ① 语言包单条机翻 ② 新增语种批量队列 ③ 商品等多语 `machineFill` |
| 新方案 | 与 kizERP 相同：`translate.googleapis.com/translate_a/single?client=gtx`（**非** Cloud Translation） |
| 官方 Cloud | 本期不做 |
| 策略 | **配置切换**；默认 gtx；火山代码保留可回退 |

机翻只生成后台草稿并落库，前台不实时调翻译接口。

---

## 2. 配置项（写入「翻译配置」tab，`eng_title=online_translation`，id 通常为 106）

| menu_name | 类型 | 默认 | 说明 |
|-----------|------|------|------|
| `translate_driver` | radio | `google_gtx` | `google_gtx`=Google 无 Key；`volcano`=火山 |
| `translate_proxy_host` | text | 空 | 可选 HTTP 代理主机（如 `127.0.0.1`） |
| `translate_proxy_port` | text | `7890` | 代理端口；仅 host 非空时生效 |
| `translate_gtx_interval_ms` | text | `150` | gtx 多条请求间隔（毫秒），防限流 |
| `hs_accesskey` / `hs_secretkey` | 已有 | 空 | **仅** `volcano` 时必填；文案改为「火山驱动专用」 |

迁移脚本：`crmeb/database/vn/088_translate_driver.sql`（幂等）。执行后清缓存。

---

## 3. 代码改动（最小面）

### 3.1 新增

| 文件 | 职责 |
|------|------|
| `crmeb/crmeb/utils/GoogleGtxTranslate.php` | gtx GET；正规 `json_decode`；可选代理；多条时 sleep；返回 `[['Translation'=>...],...]` 与火山一致 |
| `crmeb/crmeb/utils/TranslateFactory.php` | 读 `translate_driver`；组装并校验；`create()` / `assertReady()` |

`GoogleGtxTranslate` 行为对齐 kizERP：

- URL：`client=gtx&sl={source}&tl={target}&dt=t&q={text}`
- 源语默认 `zh-CN`（调用方传空时）
- 目标：`zh-Hant` → `zh-TW`；其余沿用调用方已算好的短码（`vi`/`en`/`zh`…）
- 先直连，失败且配置了代理再走代理（进程内标记，同 Java）

### 3.2 修改（仅换入口，不改业务落库）

| 文件 | 改动 |
|------|------|
| `LangCodeServices::langCodeTranslate` | `TranslateFactory::assertReady()` + `create()->translateText(...)`；去掉写死「请先配置火山」 |
| `TranslateJob::doJob` | 同上 |
| `I18nContentServices::machineFill` | 同上；注释改为「按驱动配置」 |
| `crmeb/tests/vn/i18n_*_test.php` | 「无密钥报错」用例改为切到 `volcano` 并清空密钥后再断言 |

**不改**：`Translate.php` 火山实现本体；后台 Vue（配置页由表单驱动）；路由与菜单。

### 3.3 调用契约（保持不变）

```text
$translator->translateText($sourceLanguage, $targetLanguage, array $textList): array
// 每项含键 Translation
```

批量：火山仍可一次 `TextList`；gtx 在类内拆成单条 + 间隔。

---

## 4. 运维与回退

1. 执行 `088_translate_driver.sql`，后台清缓存。  
2. 默认即可机翻（需服务器能访问 Google；国内/受限环境填代理）。  
3. 回退：翻译配置里将驱动改为 `volcano`，填好火山 AK/SK。  

风险：gtx 无 SLA，可能限流/变更；已用间隔与可回退火山缓解。长文本注意 GET URL 长度，超长可截断或失败记日志（与现 Job catch 一致）。

---

## 5. 验收

- [ ] 驱动默认 `google_gtx`，语言包弹窗「翻译」中→越/英可用（网络可达时）  
- [ ] 商品机翻接口在 gtx 下无需火山 Key  
- [ ] 切 `volcano` 且无 Key → 明确报错（测试覆盖）  
- [ ] 切 `volcano` 且 Key 正确 → 行为与改前一致  
- [ ] 配置代理后，直连失败可走代理（有代理环境时）  

---

## 6. 实施顺序

1. 本文档落地  
2. SQL `088_translate_driver.sql`  
3. `GoogleGtxTranslate` + `TranslateFactory`  
4. 三处调用点 + 测试断言  
5. 本地清缓存后点验「翻译」按钮  

---

## 7. 已落地文件清单

| 路径 | 说明 |
|------|------|
| `docs/研发/机器翻译驱动切换-火山与Google-gtx.md` | 本方案 |
| `crmeb/database/vn/088_translate_driver.sql` | 配置项迁移 |
| `crmeb/crmeb/utils/GoogleGtxTranslate.php` | gtx 实现 |
| `crmeb/crmeb/utils/TranslateFactory.php` | 驱动工厂 |
| `LangCodeServices` / `TranslateJob` / `I18nContentServices` | 调用点改工厂 |
| `tests/vn/i18n_content_test.php` / `i18n_admin_test.php` | volcano 无 Key 断言 |

说明：容器出口 IP 可能对 gtx 返回 **HTTP 429**，属接口限流而非代码错误；配置代理或换网络后再验。
