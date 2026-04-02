Clear-Host
Write-Host "[>] Rust Başlatma Seçenekleri Hazırlanıyor..." -ForegroundColor Cyan
Write-Host "----------------------------------------------------" -ForegroundColor Gray

# Başlatma seçenekleri
$launchoptions = "-malloc=system -USEALLAVAILABLECORES -system.cpu_priority high -gc.incremental_milliseconds 1 -effects.maxgibs -1 -physics.steps 60 -graphics.waves false"

# Panoya kopyala
Set-Clipboard -Value $launchoptions
Write-Host "[+] Kodlar panoya kopyalandı: $launchoptions" -ForegroundColor Green
Write-Host "[!] Steam Kütüphanesi açılıyor..." -ForegroundColor Yellow

# Steam Kütüphanesini aç (En garanti komut budur)
Start-Process "steam://open/library"

Write-Host "`n" + ("=" * 50) -ForegroundColor Magenta
Write-Host " ŞİMDİ NE YAPMALISIN?" -ForegroundColor White -BackgroundColor Magenta
Write-Host " 1. Steam kütüphanende Rust'a SAĞ TIKLA."
Write-Host " 2. ÖZELLİKLER (Properties) seçeneğine gir."
Write-Host " 3. BAŞLATMA SEÇENEKLERİ kutusuna CTRL+V yap."
Write-Host ("=" * 50) -ForegroundColor Magenta
