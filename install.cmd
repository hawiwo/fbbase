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
pause
exit /b

*** Ab hier PowerShell ***
Expand-Archive -LiteralPath 'Firebird-2.5.9.27139-0_x64.zip' -DestinationPath C:\Firebird\Firebird-2.5.9_x64
[System.Environment]::SetEnvironmentVariable('isc_password','masterkey',[System.EnvironmentVariableTarget]::User)
[System.Environment]::SetEnvironmentVariable('isc_user','sysdba',[System.EnvironmentVariableTarget]::User)
