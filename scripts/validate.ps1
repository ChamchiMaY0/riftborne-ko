Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$RepoRoot = Resolve-Path (Join-Path $PSScriptRoot "..")
$SourceRoot = Join-Path $RepoRoot "source\10.77\Content"
$KoRoot = Join-Path $RepoRoot "ko\Content"

function Get-CsvRows($Path) {
    return @(Import-Csv -LiteralPath $Path)
}

function Assert-SameCsvShape($RelativePath) {
    $sourcePath = Join-Path $SourceRoot $RelativePath
    $koPath = Join-Path $KoRoot $RelativePath

    if (-not (Test-Path -LiteralPath $koPath)) {
        throw "Missing translated CSV: $RelativePath"
    }

    $sourceHeader = (Get-Content -LiteralPath $sourcePath -TotalCount 1).TrimStart([char]0xFEFF)
    $koHeader = (Get-Content -LiteralPath $koPath -TotalCount 1).TrimStart([char]0xFEFF)
    if ($sourceHeader -ne $koHeader) {
        throw "CSV header mismatch: $RelativePath"
    }

    $sourceRows = Get-CsvRows $sourcePath
    $koRows = Get-CsvRows $koPath
    if ($sourceRows.Count -ne $koRows.Count) {
        throw "CSV row count mismatch: $RelativePath source=$($sourceRows.Count) ko=$($koRows.Count)"
    }

    Write-Host "OK CSV $RelativePath rows=$($koRows.Count)"
}

function Assert-SameGuideSet {
    $sourceGuideRoot = Join-Path $SourceRoot "GAMEPLAY_GUIDE"
    $koGuideRoot = Join-Path $KoRoot "GAMEPLAY_GUIDE"
    $sourceNames = @(Get-ChildItem -LiteralPath $sourceGuideRoot -Filter "*.txt" | Sort-Object Name | Select-Object -ExpandProperty Name)
    $koNames = @(Get-ChildItem -LiteralPath $koGuideRoot -Filter "*.txt" | Sort-Object Name | Select-Object -ExpandProperty Name)

    if ($sourceNames.Count -ne $koNames.Count) {
        throw "Guide file count mismatch: source=$($sourceNames.Count) ko=$($koNames.Count)"
    }

    for ($i = 0; $i -lt $sourceNames.Count; $i++) {
        if ($sourceNames[$i] -ne $koNames[$i]) {
            throw "Guide filename mismatch: source=$($sourceNames[$i]) ko=$($koNames[$i])"
        }
    }

    Write-Host "OK guides files=$($koNames.Count)"
}

Assert-SameCsvShape "Data\directive_paths.csv"
Assert-SameCsvShape "Data\main_menu_taglines.csv"
Assert-SameCsvShape "Data\player_transmissions.csv"
Assert-SameCsvShape "Data\spu_bonuses.csv"
Assert-SameGuideSet

Write-Host "Validation complete."
