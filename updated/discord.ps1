$process = Get-Process | Where-Object { $_.Path -like "*Discord.exe" }

if ($process) {
    Write-Host "Discord çalışıyor. Cloudflare DNS ayarlanıyor..."
    # Discord çalışıyorsa Cloudflare DNS'e geçir
    Set-DnsClientServerAddress -InterfaceAlias 'Ethernet' -ServerAddresses '1.1.1.1', '1.0.0.1'
} else {
    Write-Host "Discord çalışmıyor. DNS eski haline döndürülüyor..."
    # Discord çalışmıyorsa eski DNS ayarlarına döndür
    Set-DnsClientServerAddress -InterfaceAlias 'Ethernet' -ResetServerAddresses
}
Start-Sleep -seconds 3
