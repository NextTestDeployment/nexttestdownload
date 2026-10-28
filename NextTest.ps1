param(
    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]]$AppArgs
)
$scriptDir = $PSScriptRoot
if (-not $scriptDir) { $scriptDir = Get-Location }

$versionFile = Join-Path $scriptDir "version.v"
$version = if (Test-Path $versionFile) { (Get-Content $versionFile -Raw).Trim() } else { "1.0.0" }

$targetJar = Join-Path $scriptDir "nexttest-desktop-v$version.jar"
$aliasJar = Join-Path $scriptDir "nexttest-desktop.jar"

if (Test-Path $targetJar) {
    $execJar = $targetJar
} elseif (Test-Path $aliasJar) {
    $execJar = $aliasJar
} else {
    Write-Host "[INFO] First run: Assembling nexttest-desktop-v$version.jar from 30MB chunks..." -ForegroundColor Cyan
    $chunksDir = Join-Path $scriptDir "chunks"
    if (-not (Test-Path $chunksDir)) {
        $chunksDir = Join-Path $scriptDir "bin\chunks"
    }
    $parts = Get-ChildItem -Path $chunksDir -Filter "nexttest-desktop-v$version.part*" | Sort-Object { [int]($_.Name -replace '.*\.part','') }
    if ($parts.Count -eq 0) {
        Write-Error "No chunks found in '$chunksDir' for version $version!"
        exit 1
    }
    $outStream = [System.IO.File]::Create($targetJar)
    foreach ($part in $parts) {
        $inStream = [System.IO.File]::OpenRead($part.FullName)
        $inStream.CopyTo($outStream)
        $inStream.Close()
    }
    $outStream.Close()
    Copy-Item -Path $targetJar -Destination $aliasJar -Force -ErrorAction SilentlyContinue
    Write-Host "[INFO] Assembly complete. Subsequent runs will use the merged JAR directly." -ForegroundColor Green
    $execJar = $targetJar
}

if ($AppArgs.Count -eq 0) {
    Write-Host "Launching NextTest Desktop UI..."
    Start-Process -FilePath "javaw" -ArgumentList "-jar", "`"$execJar`""
} else {
    & java -jar "$execJar" @AppArgs
}
