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
  Get-Content -Raw -Encoding UTF8 $demo | docker exec -i $Container mysql "-u${User}" "-p${Pass}" --default-character-set=utf8mb4 $Db
  if ($LASTEXITCODE -ne 0) { throw "Failed: demo" }
}

Write-Host "OK all SQL applied"
