# 升级包打包脚本（已有站点覆盖升级，如 2026-04-19 → 当前）
# 用法（仓库根目录）:
#   powershell -ExecutionPolicy Bypass -File .\pack-upgrade.ps1
#   powershell -File .\pack-upgrade.ps1 -SkipVendor
#
# 产出: crmeb-upgrade-YYMMDD.zip
# 内容: 可覆盖的 crmeb/ 代码 + 编译前端 + database/vn SQL + UPGRADE.txt
# 排除: .env、runtime、uploads 用户文件、install 向导、demo、tests、backup
#Requires -Version 5.1
param(
    [switch]$SkipVendor,
    [string]$OutDir
)

$ErrorActionPreference = 'Stop'
. (Join-Path $PSScriptRoot 'pack-common.ps1')

$repo = Get-RepoRoot
$src = Assert-CrmebLayout -RepoRoot $repo
if (-not $OutDir) { $OutDir = $repo }
$stamp = Get-PackDateStamp
$zipName = "crmeb-upgrade-$stamp.zip"
$zipPath = Join-Path $OutDir $zipName
$stage = New-StageDir -RepoRoot $repo -Name '_pack_stage_upgrade'
$dst = Join-Path $stage 'crmeb'

Write-Host "==== 升级包 ===="
Write-Host "源: $src"
Write-Host "包: $zipPath"

Copy-CrmebTree `
    -SrcCrmeb $src `
    -DstCrmeb $dst `
    -IncludeVendor:( -not $SkipVendor) `
    -IncludeDemoSql:$false `
    -IncludeUploads:$false `
    -IncludeInstall:$false `
    -IncludeRuntimePlaceholder:$false

$upgradeTxt = @"
菜集鲜 / CRMEB 升级包说明
========================
包名: $zipName
生成: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')
场景: 已有站点覆盖升级（例如服务器约 2026-04-19 → 本包）

一、升级前备份
1. 整站代码备份（至少 crmeb/）
2. 数据库全量 mysqldump
3. 确认可回滚

二、覆盖规则（重要）
【覆盖】把本包 crmeb/ 目录内容覆盖到服务器网站 crmeb/：
  - app/、crmeb/、config/、route/、upgrade/
  - database/vn/（SQL 文件供下一步执行，不会自动跑）
  - public/admin/、public/index.html、public/mobile.html（若有）
  - public/static/、public/assets/、public/pages/（若有）
  - vendor/（若本包含）、composer.json、composer.lock、.version、think 等

【必须保留服务器原文件，禁止覆盖】
  - .env（数据库/Redis 等线上配置）
  - public/uploads/（用户上传）
  - public/install.lock
  - runtime/ 可清空缓存；本包不含 runtime，勿用空目录误删线上日志策略以外的东西

三、执行数据库迁移（生产库）
在生产 MySQL 按文件名顺序执行 crmeb/database/vn/ 下 NNN_*.sql：
  000_helpers → 001 → 010 → 020 → 021 → 030 → … → 105 → 900

脚本幂等，可重复执行。生产不要跑 demo（本包已排除）。
详见 crmeb/database/vn/README.md

示例:
  mysql -uroot -p --default-character-set=utf8mb4 你的库名 < database/vn/000_helpers.sql

四、域名与静态资源
若库来自演示/本地，按 docs/deploy/站点域名与静态资源切换说明.md
把 site_url 与 DIY/商品绝对 URL 改为正式域名。

五、清缓存并重启
1. 删除 runtime/cache、runtime/temp（或后台「清除缓存」）
2. 必要时清理 eb_cache 中 lang_version / api_lang_*
3. 重启: PHP-FPM、消息队列、定时任务、Workerman
   见 docs/deploy/消息队列定时任务与长连接说明.md

六、验收
- 后台 /admin 可登录，越南站相关菜单可见
- H5 首页区域栏/分类/多语正常（Ctrl+F5）
- 下单 / COD / 区域价 / 语言切换抽测

七、本包刻意排除
.env、runtime/、public/uploads 用户文件、public/install 安装向导、
database/vn/demo/、tests/、backup/
$(if ($SkipVendor) { '本包未含 vendor/，服务器需: composer install --no-dev' } else { '已含 vendor/' })

不要使用官方「在线升级」覆盖本二开站点。
"@

Set-Content -Path (Join-Path $stage 'UPGRADE.txt') -Encoding UTF8 -Value $upgradeTxt
Set-Content -Path (Join-Path $dst 'UPGRADE.txt') -Encoding UTF8 -Value $upgradeTxt

Write-Host '==== 压缩 ===='
New-ZipFromDirectory -StageDir $stage -ZipPath $zipPath
Remove-Item $stage -Recurse -Force

$report = Test-ZipPackage -ZipPath $zipPath -Expect @{
    upgrade_txt   = '^UPGRADE\.txt$'
    app           = '^crmeb/app/'
    region_mw     = 'RegionMiddleware'
    vn_sql        = 'database/vn/\d{3}_.*\.sql$'
    admin         = 'public/admin/index\.html$'
    h5            = 'public/index\.html$'
    env           = '(^|/)crmeb/\.env$'
    runtime       = 'crmeb/runtime/'
    uploads_file  = 'public/uploads/.+'
    install       = 'public/install/'
    demo          = 'database/vn/demo'
}
$sizeMb = [math]::Round((Get-Item $zipPath).Length / 1MB, 1)
Write-Host ""
Write-Host "完成: $zipPath ($sizeMb MB)"
$report | Format-List

$bad = @()
if ($report.env -gt 0) { $bad += '.env' }
if ($report.runtime -gt 0) { $bad += 'runtime' }
if ($report.install -gt 0) { $bad += 'install' }
if ($report.demo -gt 0) { $bad += 'demo' }
# uploads 允许仅有 DO_NOT_OVERWRITE.txt
if ($report.uploads_file -gt 1) { $bad += 'uploads' }
if ($bad.Count) { Write-Warning ("包内不应存在: " + ($bad -join ', ')) }

Write-Host '使用: 解压后按 UPGRADE.txt 覆盖升级（务必先备份）。'
