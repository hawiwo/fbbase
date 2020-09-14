@echo off
setlocal enabledelayedexpansion

set power=0
if exist %temp%\%~n0.ps1 del %temp%\%~n0.ps1
for /f "tokens=*" %%l in ('type "%~f0"') do (
  if !power!==0 (
    if "%%l"=="*** Ab hier PowerShell ***" set power=1
  ) else (
    echo %%l >> %temp%\%~n0.ps1
  )
)
powershell -NoProfile -ExecutionPolicy Bypass -File %temp%\%~n0.ps1 %*
del %temp%\%~n0.ps1
REM pause
exit /b

*** Ab hier PowerShell ***
$result = Start-Process -Wait -FilePath 'P:\90_Download\Starface\STARFACE_UCC_Client_for_Windows_v6.4.2.86.exe' -PassThru
