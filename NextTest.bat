@echo off
setlocal enabledelayedexpansion
cd /d "%~dp0"
echo ========================================================
echo  NextTest Enterprise Test Automation Engine
echo ========================================================

java -version >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo [ERROR] Java 17+ is required but was not found in PATH.
    echo Please install Java 17 or higher from https://adoptium.net/
    pause
    exit /b 1
)

set "VERSION=1.0.0"
if exist "%~dp0version.v" (
    set /p VERSION=<"%~dp0version.v"
)
set "VERSION=!VERSION: =!"

set "TARGET_JAR=%~dp0nexttest-desktop-v!VERSION!.jar"
set "ALIAS_JAR=%~dp0nexttest-desktop.jar"

REM Check if merged JAR already exists; if present, skip merge completely
if exist "!TARGET_JAR!" (
    set "EXEC_JAR=!TARGET_JAR!"
) else if exist "!ALIAS_JAR!" (
    set "EXEC_JAR=!ALIAS_JAR!"
) else (
    echo [INFO] First run: Assembling nexttest-desktop-v!VERSION!.jar from 30MB chunks...
    powershell -NoProfile -ExecutionPolicy Bypass -Command "$v='!VERSION!'; $t='%TARGET_JAR%'; $a='%ALIAS_JAR%'; $d='%~dp0'; $c=Join-Path $d 'chunks'; if(-not (Test-Path $c)){ $c=Join-Path $d 'bin\chunks' }; $parts=Get-ChildItem -Path $c -Filter ('nexttest-desktop-v' + $v + '.part*') | Sort-Object Name; if($parts.Count -eq 0){ exit 1 }; $out=[System.IO.File]::Create($t); foreach($p in $parts){ $in=[System.IO.File]::OpenRead($p.FullName); $in.CopyTo($out); $in.Close() }; $out.Close(); Copy-Item -Path $t -Destination $a -Force -ErrorAction SilentlyContinue"
    if not exist "!TARGET_JAR!" (
        echo [ERROR] Failed to assemble binary chunks!
        pause
        exit /b 1
    )
    echo [INFO] Assembly complete. Subsequent runs will use the merged JAR directly.
    set "EXEC_JAR=!TARGET_JAR!"
)

if "%~1"=="" (
    echo Launching NextTest Desktop UI...
    start javaw -jar "!EXEC_JAR!"
) else (
    echo Running NextTest Headless CLI...
    java -jar "!EXEC_JAR!" %*
)
