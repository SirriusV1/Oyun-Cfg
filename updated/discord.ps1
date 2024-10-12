$process = Get-Process | Where-Object { $_.Path -like "*Discord.exe" }

if ($process) {
    Write-Host "Discord çalışıyor. Google DNS ayarlanıyor..."
    # Discord çalışıyorsa Google DNS'e geçir
    Set-DnsClientServerAddress -InterfaceAlias 'Ethernet' -ServerAddresses '8.8.8.8'
} else {
    Write-Host "Discord çalışmıyor. DNS eski haline döndürülüyor..."
    # Discord çalışmıyorsa eski DNS ayarlarına döndür
    Set-DnsClientServerAddress -InterfaceAlias 'Ethernet' -ResetServerAddresses
}