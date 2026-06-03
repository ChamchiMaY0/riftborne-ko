param(
    [string]$GameRoot = (Resolve-Path (Join-Path $PSScriptRoot "..\..")).Path
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$RepoRoot = Resolve-Path (Join-Path $PSScriptRoot "..")
$SourceContent = Join-Path $RepoRoot "source\10.77\Content"
$GameContent = Join-Path $GameRoot "Content"

if (-not (Test-Path -LiteralPath $GameContent)) {
    throw "Game Content directory not found: $GameContent"
}

Copy-Item -Path (Join-Path $SourceContent "Data\*.csv") -Destination (Join-Path $GameContent "Data") -Force
Copy-Item -Path (Join-Path $SourceContent "GAMEPLAY_GUIDE\*.txt") -Destination (Join-Path $GameContent "GAMEPLAY_GUIDE") -Force

Write-Host "Original 10.77 content restored to: $GameContent"
