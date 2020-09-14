If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] “Administrator”))

{

    Write-Warning “Weiter kommst du mit Adminrechten ;-).”

    Break

}