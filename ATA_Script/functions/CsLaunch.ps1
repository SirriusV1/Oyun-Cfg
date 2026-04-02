Clear-Host
Write-Host "[>] CS2 Başlatma Seçenekleri Hazırlanıyor..." -ForegroundColor Cyan
Write-Host "----------------------------------------------------" -ForegroundColor Gray

# Başlatma seçenekleri
$launchoptions = "-USEALLAVAILABLECORES -malloc=system -KoreanRating"

# Panoya kopyala
Set-Clipboard -Value $launchoptions
Write-Host "[+] Kodlar panoya kopyalandı: $launchoptions" -ForegroundColor Green
Write-Host "[!] Steam Kütüphanesi açılıyor..." -ForegroundColor Yellow

# Steam Kütüphanesini aç (En garanti komut budur)
Start-Process "steam://open/library"

Write-Host "`n" + ("=" * 50) -ForegroundColor Purple
Write-Host " ŞİMDİ NE YAPMALISIN?" -ForegroundColor White -BackgroundColor Purple
Write-Host " 1. Steam kütüphanende CS2'ye SAĞ TIKLA."
Write-Host " 2. ÖZELLİKLER (Properties) seçeneğine gir."
Write-Host " 3. BAŞLATMA SEÇENEKLERİ kutusuna CTRL+V yap."
Write-Host ("=" * 50) -ForegroundColor Purple
