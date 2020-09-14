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
.\IfIsAdmin.ps1
$SourcePath = "\\ul-dc-05\timerec\"
$TargetPath = "C:\Windows\SysWOW64\"
#$Bibl = @($SourcePath+"Msflxgrd.ocx",$SourcePath+"msstdfmt.dll")

function Register-File {

[CmdletBinding()]
param (
[ValidateScript({ Test-Path -Path $_ -PathType 'Leaf' })]
[string]$FilePath
)
process {
 try {
  $Result = Start-Process -FilePath 'regsvr32.exe' -Args "/s $FilePath" -Wait -NoNewWindow -PassThru
  $Result
 }
 catch {
   Write-Error $_.Exception.Message $false
  }
 }
}

Copy-Item -Path "\\ul-dc-05\timerec\Msflxgrd.ocx" -Destination $TargetPath
Copy-Item -Path "\\ul-dc-05\timerec\msstdfmt.dll" -Destination $TargetPath
Register-File "C:\Windows\SysWOW64\Msflxgrd.ocx"
Register-File "C:\Windows\SysWOW64\msstdfmt.dll"