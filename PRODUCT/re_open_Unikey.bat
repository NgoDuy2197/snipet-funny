@echo off
setlocal

:: Tên file exe để kill (thử vài biến thể)
set "PROC1=UniKeyNT.exe"
set "PROC2=unikey.exe"
set "PROC3=UniKey.exe"

:: Đường dẫn tuyệt đối tới UniKey cần khởi động lại
set "EXEPATH=C:\_Workspace\DuyNQ18\_Tools\GoTiengViet\UniKeyNT.exe"

echo ================================
echo Restart UniKey - kill then start
echo ================================

echo Killing possible UniKey processes...
taskkill /F /IM "%PROC1%" >nul 2>&1
taskkill /F /IM "%PROC2%" >nul 2>&1
taskkill /F /IM "%PROC3%" >nul 2>&1

:: Đợi process thực sự biến mất (tối đa 10 giây)
set /a TRY=0
:WAIT_LOOP
set /a TRY+=1
REM kiểm tra nếu còn process nào trong 3 tên trên
tasklist 2>nul | findstr /I "%PROC1% %PROC2% %PROC3%" >nul
if %ERRORLEVEL%==0 (
  if %TRY% GEQ 10 (
    echo Warning: UniKey process still running after 10s, proceeding to start anyway.
    goto START_IT
  )
  timeout /t 1 >nul
  goto WAIT_LOOP
)

:START_IT
if not exist "%EXEPATH%" (
  echo ❌ Cannot find executable: %EXEPATH%
  echo Please check the path in the .bat file.
  pause
  endlocal
  exit /b 1
)

echo Starting: "%EXEPATH%"
start "" "%EXEPATH%"

echo Done.
endlocal
exit /b 0
