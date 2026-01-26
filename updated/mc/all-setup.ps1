$host.ui.RawUI.WindowTitle = "Oyun Konfigürasyonu Güncelleniyor..."
Clear-Host

# Adım 1: tlauncher.ps1 çalıştır
Write-Host "Adım 1/3: TLauncher ayarları güncelleniyor..." -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
try {
    PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/mc/tlauncher.ps1' | Invoke-Expression }"
} catch {
    Write-Error "tlauncher.ps1 çalıştırılırken hata oluştu: $_"
    Start-Sleep -Seconds 3
}

Write-Host ""
Write-Host "Adım 2/3: Mods güncelleniyor..." -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan

# Adım 2: mods.ps1 çalıştır
try {
    PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/mc/mods.ps1' | Invoke-Expression }"
} catch {
    Write-Error "mods.ps1 çalıştırılırken hata oluştu: $_"
    Start-Sleep -Seconds 3
}

Write-Host ""
Write-Host "Adım 3/3: Minecraft konfigürasyonu uygulanıyor..." -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan

# Adım 3: Remote minecraft.ps1 çalıştır
try {
    PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/minecraft.ps1' | Invoke-Expression }"
} catch {
    Write-Error "minecraft.ps1 çalıştırılırken hata oluştu: $_"
}

Write-Host ""
Write-Host "================================================" -ForegroundColor Green
Write-Host "Tüm güncellemeler tamamlandı!" -ForegroundColor Green
Write-Host "================================================" -ForegroundColor Green
Start-Sleep -Seconds 2
