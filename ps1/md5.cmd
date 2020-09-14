@echo off
setlocal enabledelayedexpansion
set /a count=1 
for /f "skip=1 delims=:" %%a in ('CertUtil -hashfile "%1" MD5') do (
  if !count! equ 1 set "md5=%%a"
  set/a count+=1
)
set "md5=%md5: =%
echo %md5%
pause
endlocal
exit/B