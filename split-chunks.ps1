param(
    [string]$SourceJar = "",
    [string]$OutputDir = "",
    [int]$ChunkSizeMB = 30,
    [string]$Version = ""
)

$ErrorActionPreference = "Stop"
$scriptDir = $PSScriptRoot
if (-not $scriptDir) { $scriptDir = Get-Location }

# Determine Version
if (-not $Version) {
    $versionFile = Join-Path $scriptDir "version.v"
    if (Test-Path $versionFile) {
        $Version = (Get-Content $versionFile -Raw).Trim()
    } else {
        $Version = "1.0.0"
    }
}

# Locate Source JAR
if (-not $SourceJar) {
    $candidates = @(
        (Join-Path $scriptDir "nexttest\target\nexttest-desktop.jar"),
        (Join-Path $scriptDir "target\nexttest-desktop.jar"),
        (Join-Path $scriptDir "nexttest-desktop.jar"),
        (Join-Path $scriptDir "nexttest-desktop-v$Version.jar")
    )
    foreach ($c in $candidates) {
        if (Test-Path $c) {
            $SourceJar = $c
            break
        }
    }
}

if (-not $SourceJar -or -not (Test-Path $SourceJar)) {
    Write-Error "Source JAR not found! Please specify -SourceJar <path-to-jar>"
    exit 1
}

# Determine Output Directory
if (-not $OutputDir) {
    $OutputDir = Join-Path $scriptDir "chunks"
}
if (-not (Test-Path $OutputDir)) {
    New-Item -ItemType Directory -Path $OutputDir -Force | Out-Null
}

$fileInfo = Get-Item $SourceJar
$totalMB = [Math]::Round($fileInfo.Length / 1MB, 2)
Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host " NextTest Binary Splitter" -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "Source JAR : $SourceJar ($totalMB MB)"
Write-Host "Output Dir : $OutputDir"
Write-Host "Chunk Size : <= $ChunkSizeMB MB"
Write-Host "Version    : $Version"
Write-Host "----------------------------------------------------------"

$chunkBytes = $ChunkSizeMB * 1024 * 1024
$buffer = New-Object byte[] $chunkBytes

$fileStream = [System.IO.File]::OpenRead($SourceJar)
$partNum = 1

while (($bytesRead = $fileStream.Read($buffer, 0, $buffer.Length)) -gt 0) {
    $partFormatted = "{0:D2}" -f $partNum
    $chunkFileName = "nexttest-desktop-v${Version}.part${partFormatted}"
    $destPath = Join-Path $OutputDir $chunkFileName

    $outStream = [System.IO.File]::Create($destPath)
    $outStream.Write($buffer, 0, $bytesRead)
    $outStream.Close()

    $mbFormatted = [Math]::Round($bytesRead / 1MB, 2)
    Write-Host "  [+] Created chunk ${partNum}: $chunkFileName ($mbFormatted MB)" -ForegroundColor Green
    $partNum++
}
$fileStream.Close()

$totalChunks = $partNum - 1
Write-Host "----------------------------------------------------------"
Write-Host " Successfully created $totalChunks chunks in $OutputDir" -ForegroundColor Green
Write-Host "==========================================================" -ForegroundColor Cyan
