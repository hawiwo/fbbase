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
Write-Host
Write-Host -ForegroundColor Red "ACHTUNG: PC wird nach Ausführung des Scripts automatisch neu gestartet!"
Write-Host
Write-Host -ForegroundColor Yellow "Richtlinien für die Namensvergabe. Verwende nicht:"
Write-Host
Write-Host -ForegroundColor Yellow " - Ein Punkt in einem NetBIOS-Namen, auch wenn Sie dazu in der Lage sind."
Write-Host
Write-Host -ForegroundColor Yellow " - Ein Unterstrich in einem NetBIOS-Namen, obwohl dies zulässig ist."
Write-Host
Write-Host -ForegroundColor Yellow " - Ein Bindestrich in einem NetBIOS-Namen, obwohl dies zulässig ist."
Write-Host
Write-Host -ForegroundColor Yellow " - Nur Nummern in einem NetBIOS-Namen, da DNS, obwohl zulässig, nicht alle"
Write-Host
Write-Host -ForegroundColor Yellow " - Nummern in einem Hostnamen zulässt (Sie wissen bereits jetzt, dass ein"
Write-Host
Write-Host -ForegroundColor Yellow " - Hostname standardmäßig mit dem NetBIOS-Namen identisch ist)."
Write-Host
Write-Host -ForegroundColor Yellow " - Keine 2 Stelligen Namen"
Write-Host

Write-Host -ForegroundColor Green "Hostname: " -NoNewline 
$NewCompName = Read-Host
    $Computerinfo = Get-WmiObject -class win32_computersystem
    $Computerinfo.rename($NewCompName)

#Domäne:    
$Domainname = "ul-dom.ulmer-automation.de"
 Add-Computer -DomainName $Domainname -Credential ul-dom\hwolf -NewName $NewCompName -Restart
