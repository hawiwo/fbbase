Expand-Archive -LiteralPath 'Firebird-2.5.9.27139-0_x64.zip' -DestinationPath C:\Firebird\Firebird-2.5.9_x64
[System.Environment]::SetEnvironmentVariable('isc_password','masterkey',[System.EnvironmentVariableTarget]::User)
[System.Environment]::SetEnvironmentVariable('isc_user','sysdba',[System.EnvironmentVariableTarget]::User)