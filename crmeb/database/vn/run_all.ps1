# 按序执行 database/vn 迁移 + demo（Windows PowerShell）
# 用法（仓库根或本目录）：powershell -File crmeb/database/vn/run_all.ps1
$ErrorActionPreference = 'Stop'
$Root = Split-Path -Parent $MyInvocation.MyCommand.Path
$Container = if ($env:CJX_MYSQL_CONTAINER) { $env:CJX_MYSQL_CONTAINER } else { 'cjx-mysql' }
$Db = if ($env:CJX_MYSQL_DB) { $env:CJX_MYSQL_DB } else { 'crmeb' }
$User = if ($env:CJX_MYSQL_USER) { $env:CJX_MYSQL_USER } else { 'root' }
$Pass = if ($env:CJX_MYSQL_PASS) { $env:CJX_MYSQL_PASS } else { 'root' }

$files = Get-ChildItem -Path $Root -Filter '*.sql' -File |
  Where-Object { $_.Name -match '^\d{3}_' } |
  Sort-Object Name

Write-Host "MySQL container=$Container db=$Db files=$($files.Count)"
foreach ($f in $files) {
  Write-Host ">> $($f.Name)"
  Get-Content -Raw -Encoding UTF8 $f.FullName | docker exec -i $Container mysql "-u${User}" "-p${Pass}" --default-character-set=utf8mb4 $Db
  if ($LASTEXITCODE -ne 0) { throw "Failed: $($f.Name)" }
}

$demo = Join-Path $Root 'demo\001_demo_data.sql'
if (Test-Path $demo) {
  Write-Host ">> demo/001_demo_data.sql"
  # 必须 UTF8 读文件 + utf8mb4 客户端；否则中/越文会落成字面量「?」
  Get-Content -Raw -Encoding UTF8 $demo | docker exec -i $Container mysql "-u${User}" "-p${Pass}" --default-character-set=utf8mb4 $Db
  if ($LASTEXITCODE -ne 0) { throw "Failed: demo" }
  $chk = docker exec $Container mysql "-u${User}" "-p${Pass}" --default-character-set=utf8mb4 -N $Db -e "SELECT COUNT(*) FROM eb_store_product WHERE id IN (1,2,3,4) AND store_name LIKE '%?%'; SELECT COUNT(*) FROM eb_i18n_content WHERE entity_type='product' AND entity_id IN (1,2,3,4) AND value LIKE '%?%';"
  if ($LASTEXITCODE -ne 0) { throw "Failed: demo charset check" }
  $nums = @($chk -split '\s+' | Where-Object { $_ -match '^\d+$' })
  if (($nums | Measure-Object -Sum).Sum -gt 0) {
    throw "demo 导入后仍含「?」，请确认客户端为 utf8mb4 且脚本以 UTF-8 读取（当前坏行: $($nums -join ','))"
  }
}

Write-Host "OK all SQL applied"
