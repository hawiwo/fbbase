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
$Results = @()
$Adapters = Get-WmiObject win32_networkadapter | WHERE {$_.NetConnectionId -NOTLIKE '' -AND $_.NetConnectionId -NOTLIKE 'Local Area Connection*' }
$Physical = Get-NetAdapter -Physical

ForEach($Adapter in $Physical)
{
    $NIC = Get-NetIPAddress -AddressFamily IPv4 -InterfaceIndex $Adapter.InterfaceIndex
    $CState=""
    switch ($Adapter.MediaConnectState) {
        0{$CState = "Unknown"; break}
        1{$CState = "Connected"; break}
        2{$CState = "Disconnected"; break}
    }
    $Results += [PSCustomObject] @{
    IP = $NIC.IPAddress
    ConnectState = $CState
    AdapterName = $Adapter.InterfaceDescription    
    MAC = $Adapter.MacAddress
    DriverDescription = $Adapter.DriverDescription
    FullDuplex = $Adapter.FullDuplex
}

}
$Results | FT -auto