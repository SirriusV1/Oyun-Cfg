# Discord Cache Temizleme Scripti
# Bu script Discord'u kapatır, kritik dosyaları koruyarak cache'i temizler ve Discord'u yeniden açar.
# Kullanım: Yönetici olarak çalıştırın.

Write-Host "Discord kapatılıyor..." -ForegroundColor Yellow
Get-Process -Name "Discord" -ErrorAction SilentlyContinue | Stop-Process -Force
Start-Sleep -Seconds 2

$DiscordPath = "$env:APPDATA\discord"

# Kritik dosyaları koru (giriş bilgileri için)
$Keep = @("Local State", "Preferences", "settings.json", "quotes.json", "Network", "Local Storage", "Session Storage", "WebStorage", "SharedStorage", "Shared Dictionary", "shared_proto_db")

# Tüm alt öğeleri al
$AllItems = Get-ChildItem $DiscordPath -ErrorAction SilentlyContinue

# Kritik olmayanları sil
foreach ($item in $AllItems) {
    if ($Keep -notcontains $item.Name) {
        Write-Host "Siliniyor: $($item.Name)" -ForegroundColor Green
        Remove-Item $item.FullName -Recurse -Force -ErrorAction SilentlyContinue
    }
}

Write-Host "Temizlik tamamlandı! Giriş bilgileri korundu." -ForegroundColor Cyan

# Discord'u yeniden aç
Write-Host "Discord açılıyor..." -ForegroundColor Yellow
$DiscordExe = "$env:LOCALAPPDATA\Discord\Update.exe"
if (Test-Path $DiscordExe) {
    Start-Process $DiscordExe -ArgumentList "--processStart", "Discord.exe"
} else {
    Write-Host "Discord exe bulunamadı. Manuel açın." -ForegroundColor Red
}

Write-Host "İşlem tamamlandı." -ForegroundColor Green