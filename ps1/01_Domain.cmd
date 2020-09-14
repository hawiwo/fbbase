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
.\IfIsAdmin.ps1
#Computername:   
Write-Host -ForegroundColor Red "ACHTUNG: PC wird nach Ausführung des Scripts automatisch neu gestartet!"
Write-Host -ForegroundColor Green "Hostname: " -NoNewline 
$NewCompName = Read-Host
    $Computerinfo = Get-WmiObject -class win32_computersystem
    $Computerinfo.rename($NewCompName)

#Domäne:    
$Domainname = "ul-dom.ulmer-automation.de"
 Add-Computer -DomainName $Domainname -Credential ul-dom\hwolf -NewName $NewCompName -Restart