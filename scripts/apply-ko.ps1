param(
    [string]$GameRoot = (Resolve-Path (Join-Path $PSScriptRoot "..\..")).Path,
    [switch]$NoBackup
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$RepoRoot = Resolve-Path (Join-Path $PSScriptRoot "..")
$KoContent = Join-Path $RepoRoot "ko\Content"
$GameContent = Join-Path $GameRoot "Content"

& (Join-Path $PSScriptRoot "validate.ps1")

if (-not (Test-Path -LiteralPath $GameContent)) {
    throw "Game Content directory not found: $GameContent"
}

if (-not $NoBackup) {
    $timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
    $backupRoot = Join-Path $RepoRoot "backup\$timestamp\Content"
    New-Item -ItemType Directory -Force (Join-Path $backupRoot "Data"), (Join-Path $backupRoot "GAMEPLAY_GUIDE") | Out-Null
    Copy-Item -Path (Join-Path $GameContent "Data\*.csv") -Destination (Join-Path $backupRoot "Data")
    Copy-Item -Path (Join-Path $GameContent "GAMEPLAY_GUIDE\*.txt") -Destination (Join-Path $backupRoot "GAMEPLAY_GUIDE")
    Write-Host "Backup created: $backupRoot"
}

Copy-Item -Path (Join-Path $KoContent "Data\*.csv") -Destination (Join-Path $GameContent "Data") -Force
Copy-Item -Path (Join-Path $KoContent "GAMEPLAY_GUIDE\*.txt") -Destination (Join-Path $GameContent "GAMEPLAY_GUIDE") -Force

Write-Host "Korean translation applied to: $GameContent"
