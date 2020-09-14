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
Set-Clipboard -Value "BNEC-XNB6-AKBG-9G9G-E4VA"
$result = Start-Process -Wait -FilePath '\\ul-dc-05\public\90_Download\ESET_Antivirus\eea_nt64.msi' -PassThru
