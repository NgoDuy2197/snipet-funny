@echo off
setlocal enabledelayedexpansion

:: Initial UI
color 0F
echo.
echo ----------------------------------------
echo Script by DuyNQ18@fpt.com - Version: Ace
echo ----------------------------------------
echo.

:: Ask for OpenShift Token once
set /p TOKEN=Enter OpenShift Token: 

:: Login once at the beginning
echo.
echo Logging in to OpenShift...
%TOKEN%

if errorlevel 1 (
    echo Login failed. Please check your token.
    pause
    exit /b
)

:: Set namespace (fixed)
set /p NAMESPACE=Namespace (einvoice , fis-mbf-einvoice-dev): 

:: === Main menu loop ===
:main
echo.
echo ========== Available Actions ==========
echo 1. Auto Get Logs
echo 0. Exit
echo =======================================
set /p FUNC=Select: 

if "%FUNC%"=="0" (
    echo Exiting...
    timeout /t 1 >nul
    exit /b
)

if "%FUNC%" NEQ "1" (
    echo Invalid selection.
    goto main
)

:: Ask for deploymentconfig name
echo.
set /p DEPLOYMENTCONFIG=Enter service name (deploymentconfig): 

:: Ask if user wants to merge logs
echo.
echo Do you want to merge logs into a single file?
echo 1. Yes
echo 2. No
set /p MERGE_CHOICE=Select: 

color 0E
set MERGE_LOGS=false
if "%MERGE_CHOICE%"=="1" (
    set MERGE_LOGS=true
)

:: Create timestamped log directory with deploymentconfig name
for /f %%a in ('powershell -NoProfile -Command "Get-Date -Format yyyyMMdd_HHmmss"') do set LOGDIR=logs\%%a_%DEPLOYMENTCONFIG%
if not exist "%LOGDIR%" (
    mkdir "%LOGDIR%"
)

:: Step 1: Get pod list
echo [1/3] Getting pod list for deploymentconfig "%DEPLOYMENTCONFIG%"...
oc get pods -n %NAMESPACE% -l deploymentconfig=%DEPLOYMENTCONFIG% --no-headers > raw_pods.txt

:: Step 2: Extract pod names
echo [2/3] Extracting pod names...
if exist pods.txt del pods.txt
set COUNT=0
for /f "tokens=1" %%p in (raw_pods.txt) do (
    echo %%p >> pods.txt
    set /a COUNT+=1
)

:: Check if no pod found
if "!COUNT!"=="0" (
    echo No running pods found for deploymentconfig "%DEPLOYMENTCONFIG%".
    del raw_pods.txt >nul 2>&1
    del pods.txt >nul 2>&1
    if exist "%LOGDIR%" rd /s /q "%LOGDIR%"
    goto main
)

:: Merge logs init
if "!MERGE_LOGS!"=="true" (
    set MERGE_TEMP=%LOGDIR%\_merged.tmp
    (
        echo Script by DuyNQ18@fpt.com
        echo Timestamp: %DATE% %TIME%
        echo DeploymentConfig: %DEPLOYMENTCONFIG%
        echo Namespace: %NAMESPACE%
        echo.
    ) > "!MERGE_TEMP!"
)

:: Step 3: Download logs
echo [3/3] Downloading logs...
set INDEX=0
for /f %%i in (pods.txt) do (
    set /a INDEX+=1
    set "POD=%%i"
    set "MSG=Getting logs from pod !POD! (!INDEX!/%COUNT%!)"
    call echo !MSG!

    if "!MERGE_LOGS!"=="true" (
        (
            echo ------------------------------
            echo === Logs from pod !POD!
            echo ------------------------------
        ) >> "!MERGE_TEMP!"
        oc logs !POD! -n %NAMESPACE% >> "!MERGE_TEMP!"
        echo. >> "!MERGE_TEMP!"
    ) else (
        oc logs !POD! -n %NAMESPACE% > "%LOGDIR%\!POD!.log"
    )
)

:: Finalize merged log
if "!MERGE_LOGS!"=="true" (
    ren "!MERGE_TEMP!" all-logs.txt >nul
)

:: Cleanup
del raw_pods.txt >nul 2>&1
del pods.txt >nul 2>&1

:: Done
color 02
echo.
echo Done. Logs saved in: %LOGDIR%
if "!MERGE_LOGS!"=="true" (
    echo Merged log file: %LOGDIR%\all-logs.txt
)
color 0F
goto main
