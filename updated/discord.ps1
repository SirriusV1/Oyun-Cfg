# Yönetici yetkisiyle çalışıp çalışmadığını kontrol et
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    Write-Host "Bu komut yöneticilik gerektirir. Lütfen PowerShell'i yönetici olarak çalıştırın."
    exit
}

$process = Get-Process | Where-Object { $_.Path -like "*Discord.exe" }

if ($process) {
    Write-Host "Discord çalışıyor. Google DNS ayarlanıyor..."
    # Tüm ağ arayüzlerine Google DNS ayarla
    Get-DnsClient | ForEach-Object {
        try {
            Set-DnsClientServerAddress -InterfaceIndex $_.InterfaceIndex -ServerAddresses '8.8.8.8', '8.8.4.4'
            Write-Host "DNS başarıyla ayarlandı: $($_.InterfaceAlias)"
        } catch {
            Write-Host "DNS ayarlanamadı: $($_.InterfaceAlias). Hata: $_"
        }
    }
} else {
    Write-Host "Discord çalışmıyor. DNS eski haline döndürülüyor..."
    # Tüm ağ arayüzlerindeki DNS ayarlarını eski haline döndür
    Get-DnsClient | ForEach-Object {
        try {
            Set-DnsClientServerAddress -InterfaceIndex $_.InterfaceIndex -ResetServerAddresses
            Write-Host "DNS başarıyla sıfırlandı: $($_.InterfaceAlias)"
        } catch {
            Write-Host "DNS sıfırlanamadı: $($_.InterfaceAlias). Hata: $_"
        }
    }
}
Start-Sleep -seconds 3
