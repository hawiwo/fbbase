
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