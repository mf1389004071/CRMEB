# 初始部署包打包脚本（新站首次上线）
# 用法（仓库根目录）:
#   powershell -ExecutionPolicy Bypass -File .\pack-initial-deploy.ps1
#   powershell -File .\pack-initial-deploy.ps1 -SkipVendor
#   powershell -File .\pack-initial-deploy.ps1 -IncludeDemo
#
# 产出: crmeb-initial-YYMMDD.zip
# 内容: 完整 crmeb/（含 install 向导、vendor、database/vn SQL）+ INSTALL.txt
# 排除: .env、runtime 缓存、tests、backup
#Requires -Version 5.1
param(
    [switch]$SkipVendor,
    [switch]$IncludeDemo,
    [switch]$IncludeUploads,
    [string]$OutDir
)

$ErrorActionPreference = 'Stop'
. (Join-Path $PSScriptRoot 'pack-common.ps1')

$repo = Get-RepoRoot
$src = Assert-CrmebLayout -RepoRoot $repo
if (-not $OutDir) { $OutDir = $repo }
$stamp = Get-PackDateStamp
$zipName = "crmeb-initial-$stamp.zip"
$zipPath = Join-Path $OutDir $zipName
$stage = New-StageDir -RepoRoot $repo -Name '_pack_stage_initial'
$dst = Join-Path $stage 'crmeb'

Write-Host "==== 初始部署包 ===="
Write-Host "源: $src"
Write-Host "包: $zipPath"

Copy-CrmebTree `
    -SrcCrmeb $src `
    -DstCrmeb $dst `
    -IncludeVendor:( -not $SkipVendor) `
    -IncludeDemoSql:$IncludeDemo `
    -IncludeUploads:$IncludeUploads `
    -IncludeInstall `
    -IncludeRuntimePlaceholder

$installTxt = @"
菜集鲜 / CRMEB 初始部署包
========================
包名: $zipName
生成: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')

一、环境要求（宝塔）
- Nginx + MySQL 5.7/8.0 + PHP 7.4 + Redis（建议）
- PHP 扩展: fileinfo、pdo_mysql、openssl、mbstring、curl、redis、gd、zip、bcmath
- 网站根目录指向 crmeb/，运行目录设为 /public，伪静态选 ThinkPHP
- 详见: docs/deploy/宝塔部署说明.md

二、部署步骤
1. 解压本包，将 crmeb/ 上传到服务器（整目录）
2. 确保 runtime/、public/uploads/ 对 Web 用户可写
3. 浏览器打开域名，走安装向导（生成 .env / install.lock）
4. 安装完成后建议改名或限制 public/install/
5. 按序执行菜集鲜库迁移 database/vn/（000 → 105 → 900）
   说明见 crmeb/database/vn/README.md
   生产一般不要跑 demo（本包默认不含 demo；若打包时加了 -IncludeDemo 则可选）
6. 配置正式域名 site_url / 静态资源 URL
   见 docs/deploy/站点域名与静态资源切换说明.md
7. 配置消息队列、定时任务、Workerman 长连接
   见 docs/deploy/消息队列定时任务与长连接说明.md

三、前端
本包已含编译后的:
- 管理端: public/admin/
- H5: public/index.html + public/static/ 等
若源码有更新，需先在本机编译再重新打包:
- 管理端: template/admin → npm run build → 拷到 crmeb/public/admin/
- H5: HBuilderX 发行或仓库约定的 uniapp-cli 生产构建 → 拷到 crmeb/public/

四、默认账号（安装向导未改时）
后台: /admin
账号: admin
密码: crmeb.com
（以安装向导实际设置为准）

五、本包排除
.env（由安装向导生成）、runtime 缓存、tests、backup
$(if ($SkipVendor) { '本包未含 vendor/，服务器需执行: composer install --no-dev' } else { '已含 vendor/' })
"@

Set-Content -Path (Join-Path $stage 'INSTALL.txt') -Encoding UTF8 -Value $installTxt
Set-Content -Path (Join-Path $dst 'INSTALL.txt') -Encoding UTF8 -Value $installTxt

Write-Host '==== 压缩 ===='
New-ZipFromDirectory -StageDir $stage -ZipPath $zipPath
Remove-Item $stage -Recurse -Force

$report = Test-ZipPackage -ZipPath $zipPath -Expect @{
    install_txt   = '^INSTALL\.txt$'
    app           = '^crmeb/app/'
    install_wizard= 'public/install/'
    vn_sql        = 'database/vn/\d{3}_.*\.sql$'
    admin         = 'public/admin/index\.html$'
    h5            = 'public/index\.html$'
    env           = '(^|/)crmeb/\.env$'
    runtime_cache = 'crmeb/runtime/(cache|log|session|temp)/.+'
    demo          = 'database/vn/demo'
}
$sizeMb = [math]::Round((Get-Item $zipPath).Length / 1MB, 1)
Write-Host ""
Write-Host "完成: $zipPath ($sizeMb MB)"
$report | Format-List
if ($report.env -gt 0) { Write-Warning '包内含 .env，请检查' }
if (-not $IncludeDemo -and $report.demo -gt 0) { Write-Warning '包内含 demo SQL，请检查' }

Write-Host '使用: 解压后按 INSTALL.txt 部署。'
