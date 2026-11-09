param(
    [string]$ChunksDir = "",
    [string]$OutputJar = "",
    [string]$Version = "",
    [switch]$Force
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

# Determine Chunks Directory
if (-not $ChunksDir) {
    $candidates = @(
        (Join-Path $scriptDir "chunks"),
        (Join-Path $scriptDir "bin\chunks"),
        (Join-Path $scriptDir "dist\chunks"),
        (Join-Path $scriptDir "dist\bin\chunks")
    )
    foreach ($c in $candidates) {
        if (Test-Path $c) {
            $partsTest = Get-ChildItem -Path $c -Filter "nexttest-desktop-v$Version.part*" -ErrorAction SilentlyContinue
            if ($partsTest.Count -gt 0) {
                $ChunksDir = $c
                break
            }
        }
    }
    if (-not $ChunksDir) {
        $ChunksDir = Join-Path $scriptDir "chunks"
    }
}

if (-not (Test-Path $ChunksDir)) {
    Write-Error "Chunks directory not found at $ChunksDir!"
    exit 1
}

# Find chunks sorted numerically
$parts = Get-ChildItem -Path $ChunksDir -Filter "nexttest-desktop-v$Version.part*" |
         Sort-Object { [int]($_.Name -replace '.*\.part','') }

if ($parts.Count -eq 0) {
    # Try any version if specific version not found
    $parts = Get-ChildItem -Path $ChunksDir -Filter "nexttest-desktop-*.part*" |
             Sort-Object { [int]($_.Name -replace '.*\.part','') }
}

if ($parts.Count -eq 0) {
    Write-Error "No chunks found in '$ChunksDir'!"
    exit 1
}

# Determine Output JAR path
if (-not $OutputJar) {
    $OutputJar = Join-Path $scriptDir "nexttest-desktop-v$Version.jar"
}

$aliasJar = Join-Path (Split-Path $OutputJar -Parent) "nexttest-desktop.jar"

if ((Test-Path $OutputJar) -and (-not $Force)) {
    Write-Host "[INFO] Merged JAR already exists at $OutputJar (use -Force to re-stitch)." -ForegroundColor Yellow
    if (-not (Test-Path $aliasJar)) {
        Copy-Item -Path $OutputJar -Destination $aliasJar -Force -ErrorAction SilentlyContinue
    }
    return
}

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host " NextTest Binary Merger" -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "Chunks Dir : $ChunksDir"
Write-Host "Found      : $($parts.Count) chunks"
Write-Host "Output JAR : $OutputJar"
Write-Host "----------------------------------------------------------"

$outStream = [System.IO.File]::Create($OutputJar)
$totalBytes = 0
foreach ($part in $parts) {
    $inStream = [System.IO.File]::OpenRead($part.FullName)
    $partBytes = $inStream.Length
    $totalBytes += $partBytes
    $mb = [Math]::Round($partBytes / 1MB, 2)
    Write-Host "  [+] Stitched: $($part.Name) ($mb MB)" -ForegroundColor Gray
    $inStream.CopyTo($outStream)
    $inStream.Close()
}
$outStream.Close()

# Create alias nexttest-desktop.jar
Copy-Item -Path $OutputJar -Destination $aliasJar -Force -ErrorAction SilentlyContinue

$totalMB = [Math]::Round($totalBytes / 1MB, 2)
Write-Host "----------------------------------------------------------"
Write-Host " Assembly completed successfully! ($totalMB MB)" -ForegroundColor Green
Write-Host " Executable ready: $OutputJar" -ForegroundColor Green
Write-Host " Alias created   : $aliasJar" -ForegroundColor Green
Write-Host "==========================================================" -ForegroundColor Cyan
