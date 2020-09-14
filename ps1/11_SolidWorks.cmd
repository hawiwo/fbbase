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
Set-Clipboard -Value "9010 0079 8045 8561 3N6K NPJF"
Write-Host "25734@ul-dc-06"
$result = Start-Process -Wait -FilePath 'P:\90_Download\Solidworks\SOLIDWORKS 2018 SP05\setup.exe' -PassThru
