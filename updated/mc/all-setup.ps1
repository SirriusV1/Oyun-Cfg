$host.ui.RawUI.WindowTitle = "Oyun Konfigürasyonu Güncelleniyor..."
Clear-Host

# Adım 1: tlauncher.ps1 çalıştır
Write-Host "Adım 1/5: TLauncher ayarları güncelleniyor..." -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
try {
    PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/mc/tlauncher.ps1' | Invoke-Expression }"
} catch {
    Write-Error "tlauncher.ps1 çalıştırılırken hata oluştu: $_"
    Start-Sleep -Seconds 3
}

Write-Host ""
Write-Host "Adım 2/5: Mods güncelleniyor..." -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan

# Adım 2: mods.ps1 çalıştır
try {
    PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/mc/mods.ps1' | Invoke-Expression }"
} catch {
    Write-Error "mods.ps1 çalıştırılırken hata oluştu: $_"
    Start-Sleep -Seconds 3
}

Write-Host ""
Write-Host "Adım 3/5: Config dosyaları güncelleniyor..." -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan

# Adım 3: config.ps1 çalıştır
try {
    PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/mc/config.ps1' | Invoke-Expression }"
} catch {
    Write-Error "config.ps1 çalıştırılırken hata oluştu: $_"
    Start-Sleep -Seconds 3
}

Write-Host ""
Write-Host "Adım 4/5: Minecraft ayarları uygulanıyor..." -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan

# Adım 4: Config klasörünü silme veya ayarları sıfırlama işlemleri (gerekli ise)
Write-Host "Minecraft hazırlanıyor..." -ForegroundColor Gray

Write-Host ""
Write-Host "================================================" -ForegroundColor Green
Write-Host "Tüm güncellemeler tamamlandı!" -ForegroundColor Green
Write-Host "================================================" -ForegroundColor Green
Start-Sleep -Seconds 2

# TLauncher'ı aç
Write-Host "Adım 5/5: TLauncher açılıyor..." -ForegroundColor Cyan
Start-Sleep -Seconds 1

$tlaucherPath = "$env:APPDATA\.minecraft\TLauncher.exe"
if (Test-Path $tlaucherPath) {
    Start-Process $tlaucherPath
    Start-Sleep -Seconds 3
} else {
    Write-Host "TLauncher bulunamadı: $tlaucherPath" -ForegroundColor Yellow
}

# Minecraft menüsünü aç
Write-Host "Minecraft menüsü açılıyor..." -ForegroundColor Cyan
PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/minecraft.ps1' | Invoke-Expression }"
