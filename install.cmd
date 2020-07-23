@echo off
setlocal enabledelayedexpansion

net use s: http://live.sysinternals.com/tools 
mkdir c:\sysinternals
xcopy s:\*.* c:\sysinternals /s

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

echo cd C:\Firebird\Firebird-2.5.9_x64\bin > ifb.cmd
echo start install_super.bat >> ifb.cmd
start ifb.cmd
pause
exit /b

*** Ab hier PowerShell ***
Expand-Archive -LiteralPath 'Firebird-2.5.9.27139-0_x64.zip' -DestinationPath C:\Firebird\Firebird-2.5.9_x64
Expand-Archive -LiteralPath 'UPS-CONF_setup_v2_7_0_51.zip' -DestinationPath C:\tmp\UPS-CONF
[System.Environment]::SetEnvironmentVariable('isc_password','masterkey',[System.EnvironmentVariableTarget]::User)
[System.Environment]::SetEnvironmentVariable('isc_user','sysdba',[System.EnvironmentVariableTarget]::User)

