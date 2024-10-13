$process = Get-Process | Where-Object { $_.Path -like "*Discord.exe" }

if ($process) {
    Write-Host "Discord çalışıyor. Google DNS ayarlanıyor..."
    # Tüm ağ arayüzlerine Google DNS ayarla
    Get-DnsClient | ForEach-Object {
        Set-DnsClientServerAddress -InterfaceIndex $_.InterfaceIndex -ServerAddresses '8.8.8.8', '8.8.4.4'
    }
} else {
    Write-Host "Discord çalışmıyor. DNS eski haline döndürülüyor..."
    # Tüm ağ arayüzlerindeki DNS ayarlarını eski haline döndür
    Get-DnsClient | ForEach-Object {
        Set-DnsClientServerAddress -InterfaceIndex $_.InterfaceIndex -ResetServerAddresses
    }
}
Start-Sleep -seconds 3
