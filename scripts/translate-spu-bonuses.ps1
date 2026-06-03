Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$RepoRoot = Resolve-Path (Join-Path $PSScriptRoot "..")
$SourcePath = Join-Path $RepoRoot "source\10.77\Content\Data\spu_bonuses.csv"
$OutPath = Join-Path $RepoRoot "ko\Content\Data\spu_bonuses.csv"

$categoryMap = @{
    Ships = "함선"
    Economy = "경제"
    Logistics = "군수"
    Combat = "전투"
    Espionage = "첩보"
    Diplomacy = "외교"
}

$targetMap = @{
    LightFighter = "경전투기"
    HeavyFighter = "중전투기"
    Bomber = "폭격기"
    Drone = "드론"
    Frigate = "호위함"
    Destroyer = "구축함"
    Colonization = "개척선"
    Intelligence = "첩보선"
    Siege = "공성함"
    Corvette = "초계함"
    Gunship = "건쉽"
    Cruiser = "순양함"
    Capital = "주력함"
    Carrier = "항공모함"
    Vulkron = "벌크론"
    Aurelite = "아우렐라이트"
    Deuterium = "중수소"
    Astra = "아스트라"
}

function Format-Label($kind, $param) {
    $name = $null
    if ($param -and $targetMap.ContainsKey($param)) {
        $name = $targetMap[$param]
    }

    switch ($kind) {
        "UnitAttack" { return "+$name 공격 배율" }
        "UnitDefense" { return "+$name 방어 배율" }
        "UnitSpeed" { return "+$name 속도" }
        "UnitTrainingSpeed" { return "+$name 훈련 속도" }
        "UnitUpkeepReduction" { return "-$name 유지비" }
        "BaseProduction" { return "+$name 생산량" }
        "BaseStorage" { return "+$name 저장량" }
        "BuildSpeed" { return "+건설 속도" }
        "ShipBuildSpeed" { return "+함선 건조 속도" }
        "TravelSpeed" { return "+함대 이동 속도" }
        "BaseDefense" { return "+기지 방어 배율" }
        "ResearchSpeed" { return "+연구 속도" }
        "UpkeepReduction" { return "-전체 유지비" }
        "TransmuteSpeed" { return "+변환 속도" }
        "FleetAttack" { return "+함대 공격 배율" }
        "FleetDefense" { return "+함대 방어 배율" }
        "FleetSiege" { return "+함대 공성 위력" }
        "FleetRaidLoot" { return "+약탈 수익" }
        "FleetCargo" { return "+함대 화물 적재량" }
        "FleetCrit" { return "+함대 치명타" }
        "FleetEvasion" { return "+함대 회피" }
        "FleetTracking" { return "+함대 추적" }
        "SpySurvival" { return "+첩보 생존율" }
        "DiplomacyPenaltyReduction" { return "-외교 페널티" }
        default { throw "Unknown TargetKind: $kind" }
    }
}

$rows = @(Import-Csv -LiteralPath $SourcePath)
foreach ($row in $rows) {
    if ($categoryMap.ContainsKey($row.Category)) {
        $row.Category = $categoryMap[$row.Category]
    }
    $row.Label = Format-Label $row.TargetKind $row.TargetParam
}

function Escape-CsvValue($value) {
    $text = [string]$value
    if ($text -match '[,"\r\n]') {
        return '"' + $text.Replace('"', '""') + '"'
    }
    return $text
}

$csv = New-Object System.Collections.Generic.List[string]
$csv.Add("PermutationKey,Category,TargetKind,TargetParam,Label")
foreach ($row in $rows) {
    $values = @(
        $row.PermutationKey,
        $row.Category,
        $row.TargetKind,
        $row.TargetParam,
        $row.Label
    )
    $csv.Add((@($values | ForEach-Object { Escape-CsvValue $_ }) -join ","))
}
$utf8NoBom = New-Object System.Text.UTF8Encoding($false)
[System.IO.File]::WriteAllLines($OutPath, $csv, $utf8NoBom)
Write-Host "Translated SPU bonuses: $OutPath"
