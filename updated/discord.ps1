$process = Get-Process | Where-Object { $_.Path -like "*Discord.exe" }

if ($process) {
    Write-Host "Discord çalışıyor. Cloudflare DNS ayarlanıyor..."
    # Tüm ağ arayüzlerine Cloudflare DNS ayarla
    Get-DnsClient | ForEach-Object {
        Set-DnsClientServerAddress -InterfaceIndex $_.InterfaceIndex -ServerAddresses '1.1.1.1', '1.0.0.1'
    }
} else {
    Write-Host "Discord çalışmıyor. DNS eski haline döndürülüyor..."
    # Tüm ağ arayüzlerindeki DNS ayarlarını eski haline döndür
    Get-DnsClient | ForEach-Object {
        Set-DnsClientServerAddress -InterfaceIndex $_.InterfaceIndex -ResetServerAddresses
    }
}
Start-Sleep -seconds 3
