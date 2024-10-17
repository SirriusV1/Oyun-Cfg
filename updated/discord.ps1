# Yönetici yetkisiyle çalışıp çalışmadığını kontrol et
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    Write-Host "Bu komut yöneticilik gerektirir. Lütfen PowerShell'i yönetici olarak çalıştırın."
    exit
}

# Google DNS ayarlanıyor
Write-Host "1.1.1.1 DNS ayarlanıyor..."

# Tüm ağ arayüzlerine 1.1.1.1 DNS ayarla
Get-DnsClient | ForEach-Object {
    try {
        Set-DnsClientServerAddress -InterfaceIndex $_.InterfaceIndex -ServerAddresses '1.1.1.1'
        Write-Host "DNS başarıyla ayarlandı: $($_.InterfaceAlias)"
    } catch {
        Write-Host "DNS ayarlanamadı: $($_.InterfaceAlias). Hata: $_"
    }
}

Start-Sleep -seconds 3
