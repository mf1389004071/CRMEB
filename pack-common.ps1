# 打包公共函数（由 pack-initial-deploy.ps1 / pack-upgrade.ps1 点源引用）
#Requires -Version 5.1
$ErrorActionPreference = 'Stop'

function Get-RepoRoot {
    if ($PSScriptRoot) { return $PSScriptRoot }
    return (Get-Location).Path
}

function Assert-CrmebLayout {
    param([string]$RepoRoot)
    $crmeb = Join-Path $RepoRoot 'crmeb'
    foreach ($need in @('app', 'public', 'composer.json')) {
        $p = Join-Path $crmeb $need
        if (-not (Test-Path $p)) {
            throw "仓库结构异常，找不到: $p（请在仓库根目录执行打包脚本）"
        }
    }
    return $crmeb
}

function New-StageDir {
    param([string]$RepoRoot, [string]$Name)
    $stage = Join-Path $RepoRoot $Name
    if (Test-Path $stage) { Remove-Item $stage -Recurse -Force }
    New-Item -ItemType Directory -Path $stage | Out-Null
    return $stage
}

function Invoke-RoboCopySafe {
    param(
        [Parameter(Mandatory)][string]$From,
        [Parameter(Mandatory)][string]$To,
        [string[]]$ExcludeDirs = @(),
        [string[]]$ExcludeFiles = @()
    )
    if (-not (Test-Path $From)) { throw "源不存在: $From" }
    $null = New-Item -ItemType Directory -Path $To -Force
    $args = @($From, $To, '/E', '/NFL', '/NDL', '/NJH', '/NJS', '/nc', '/ns', '/np')
    if ($ExcludeDirs.Count) { $args += @('/XD') + $ExcludeDirs }
    if ($ExcludeFiles.Count) { $args += @('/XF') + $ExcludeFiles }
    & robocopy @args | Out-Null
    # robocopy: 0-7 成功；>=8 失败
    if ($LASTEXITCODE -ge 8) {
        throw "robocopy 失败 ($LASTEXITCODE): $From -> $To"
    }
}

function Copy-CrmebTree {
    param(
        [Parameter(Mandatory)][string]$SrcCrmeb,
        [Parameter(Mandatory)][string]$DstCrmeb,
        [switch]$IncludeVendor,
        [switch]$IncludeDemoSql,
        [switch]$IncludeUploads,
        [switch]$IncludeInstall,
        [switch]$IncludeRuntimePlaceholder
    )

    $null = New-Item -ItemType Directory -Path $DstCrmeb -Force

    $topDirs = @('app', 'config', 'crmeb', 'database', 'public', 'route', 'upgrade')
    if ($IncludeVendor) { $topDirs += 'vendor' }

    $topFiles = @(
        'composer.json', 'composer.lock', '.version', '.htaccess', '.constant',
        'think', 'LICENSE.txt', 'README.md', 'FILE_GUIDE.md', 'workerman.bat', 'index.html'
    )

    foreach ($name in $topDirs) {
        $from = Join-Path $SrcCrmeb $name
        if (-not (Test-Path $from)) {
            Write-Host "  skip missing dir: $name"
            continue
        }
        $to = Join-Path $DstCrmeb $name
        Write-Host "  copy $name/"
        switch ($name) {
            'public' {
                $xd = @('runtime')
                if (-not $IncludeUploads) { $xd += 'uploads' }
                $xf = @()
                if (-not $IncludeInstall) { $xf += 'install.lock' }
                Invoke-RoboCopySafe -From $from -To $to -ExcludeDirs $xd -ExcludeFiles $xf
                if (-not $IncludeInstall) {
                    $installDir = Join-Path $to 'install'
                    # 升级包默认去掉整个 install 安装向导，避免误装
                    if (Test-Path $installDir) { Remove-Item $installDir -Recurse -Force }
                }
            }
            'database' {
                $xd = @()
                if (-not $IncludeDemoSql) { $xd += 'demo' }
                Invoke-RoboCopySafe -From $from -To $to -ExcludeDirs $xd
            }
            default {
                Invoke-RoboCopySafe -From $from -To $to -ExcludeDirs @('.git')
            }
        }
    }

    foreach ($name in $topFiles) {
        $from = Join-Path $SrcCrmeb $name
        if (-not (Test-Path $from)) { continue }
        Copy-Item $from (Join-Path $DstCrmeb $name) -Force
    }

    # 永不打包线上配置
    $envFile = Join-Path $DstCrmeb '.env'
    if (Test-Path $envFile) { Remove-Item $envFile -Force }

    # uploads：无内容时放占位说明
    $uploads = Join-Path $DstCrmeb 'public\uploads'
    if (-not (Test-Path $uploads)) {
        $null = New-Item -ItemType Directory -Path $uploads -Force
    }
    if (-not $IncludeUploads) {
        Set-Content -Path (Join-Path $uploads 'DO_NOT_OVERWRITE.txt') -Encoding UTF8 -Value @(
            '升级/部署时请保留服务器上原有 public/uploads，不要用本目录覆盖用户上传文件。'
            '本文件仅作占位说明。'
        )
    }

    if ($IncludeRuntimePlaceholder) {
        foreach ($sub in @('cache', 'log', 'session', 'temp')) {
            $d = Join-Path $DstCrmeb "runtime\$sub"
            $null = New-Item -ItemType Directory -Path $d -Force
            Set-Content -Path (Join-Path $d '.gitkeep') -Encoding ASCII -Value ''
        }
    }

    # 双保险去掉 demo
    if (-not $IncludeDemoSql) {
        $demo = Join-Path $DstCrmeb 'database\vn\demo'
        if (Test-Path $demo) { Remove-Item $demo -Recurse -Force }
    }
}

function New-ZipFromDirectory {
    param(
        [Parameter(Mandatory)][string]$StageDir,
        [Parameter(Mandatory)][string]$ZipPath
    )
    if (Test-Path $ZipPath) { Remove-Item $ZipPath -Force }
    Add-Type -AssemblyName System.IO.Compression
    Add-Type -AssemblyName System.IO.Compression.FileSystem
    [System.IO.Compression.ZipFile]::CreateFromDirectory(
        $StageDir,
        $ZipPath,
        [System.IO.Compression.CompressionLevel]::Optimal,
        $false
    )
}

function Test-ZipPackage {
    param(
        [Parameter(Mandatory)][string]$ZipPath,
        [hashtable]$Expect
    )
    Add-Type -AssemblyName System.IO.Compression.FileSystem
    $z = [System.IO.Compression.ZipFile]::OpenRead($ZipPath)
    try {
        $names = $z.Entries | ForEach-Object { $_.FullName -replace '\\', '/' }
        $report = [ordered]@{
            entries = $names.Count
        }
        foreach ($key in $Expect.Keys) {
            $pat = $Expect[$key]
            $n = @($names | Where-Object { $_ -match $pat }).Count
            $report[$key] = $n
        }
        return [pscustomobject]$report
    }
    finally {
        $z.Dispose()
    }
}

function Get-PackDateStamp {
    Get-Date -Format 'yyMMdd-HHmmss'
}
