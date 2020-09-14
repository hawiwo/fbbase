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

$path="HKLM:\SOFTWARE\Policies\Microsoft\Windows\EdgeUI"

if (Test-Path $path){
	Write-Host "File found."
}
Else{
	New-Item $path
	New-ItemProperty $path -Name "AllowEdgeSwipe" -Value 0 -PropertyType "DWord"
}
