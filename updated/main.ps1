# İndirilecek ico dosyasının URL'si
$faviconUrl = "data:image/png;base64,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"

# Kullanıcının masaüstü dizinini belirleme
$desktopPath = [Environment]::GetFolderPath("Desktop")

# Dosya yolunu belirleme
$iconPath = [System.IO.Path]::Combine($desktopPath, 'favicon.ico')

try {
    # İco dosyasını indir
    Invoke-WebRequest -Uri $faviconUrl -OutFile $iconPath -ErrorAction Stop
    Write-Output "İco dosyası başarıyla indirildi: $iconPath"
} catch {
    # Hata durumunda mesajı yazdır
    Write-Error "İco dosyası indirilemedi: $_"
}





$host.ui.RawUI.WindowTitle = "ATA CFG"
Clear-Host

Write-Host "Hangi oyunun CFG dosyasını indirmek istiyorsunuz? "
Write-Host "1. Cs        " -NoNewline
Write-Host "1.0.4 [09.01.2024]" -ForegroundColor Green
Write-Host "2. Rust      " -NoNewline
Write-Host "1.0.6 [21.02.2024]" -ForegroundColor Green
Write-Host "3. Minecraft " -NoNewline
Write-Host "1.20.1" -ForegroundColor Green
Write-Host "4. Pubg "
Write-Host "5. Nvidia Ayarları "
Write-Host "6. Windows Yardımcı Programı"
$sec = "(1-6)"
$secim = Read-Host "Lütfen bir numara girin $sec"


switch ($secim) {
    1 {
        while ($true) {
            clear-host
            $host.ui.RawUI.WindowTitle = "CS Menü"
            Write-Host "        ╔═══════════╗"  -ForegroundColor Blue
            Write-Host "        ║  CS Menü  ║"  -ForegroundColor Blue
            Write-Host "        ╚═══════════╝"  -ForegroundColor Blue
            Write-Host ""
            Write-Host "1. Başlatma Seçenekleri "
            Write-Host "2. CFG İndir "
            Write-Host "3. Bind Komutları"
            Write-Host "4. Geri Dön" -ForegroundColor Cyan
            $subSecim = Read-Host "Lütfen bir numara girin (1-4)"

            switch ($subSecim) {
                1 {
                    $launchoptions = "-high -novid -tickrate 128 +exec ata.cfg"
                    Set-Clipboard -Value $launchoptions
                    Set-Clipboard -Value $launchoptions
                    Write-Host "Başlatma Seçenekleri panoya kopyalandı." -ForegroundColor Green
                    Start-Sleep -Seconds 1
                    Write-Host "Steam Kütüphane Açılıyor." -ForegroundColor Cyan
                    Start-Sleep -Seconds 1
                    Start-Process steam://open/library
                    Start-Sleep -Seconds 1
                    break
                }
                2 {
                    PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/cs.ps1' | Invoke-Expression }"
                }
                3 {
                    Start-Process "https://github.com/SirriusV1/Oyun-Cfg/blob/main/Counter-Strike%20Global%20Offensive%20(CSGO)/README.md"
                }
                4 {
                    PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/main.ps1' | Invoke-Expression }"
                }
                default {
                    Write-Host "Geçersiz bir seçim yaptınız. Lütfen 1-4 arasında bir numara girin." -ForegroundColor Red
                    Start-Sleep -Seconds 1
                    break
                }
            }
        }
    }

    2 {
        while ($true) {
            clear-host
            $host.ui.RawUI.WindowTitle = "Rust Menü"
            Write-Host "        ╔═══════════╗"  -ForegroundColor DarkYellow
            Write-Host "        ║ Rust Menü ║"  -ForegroundColor DarkYellow
            Write-Host "        ╚═══════════╝"  -ForegroundColor DarkYellow
            Write-Host ""
            Write-Host "1. Başlatma Seçenekleri "
            Write-Host "2. CFG İndir "
            Write-Host "3. Bind Komutları"
            Write-Host "4. Geri Dön" -ForegroundColor Cyan
            $subSecim = Read-Host "Lütfen bir numara girin (1-4)"

            switch ($subSecim) {
                1 {
                    $launchoptions = "-malloc=system -USEALLAVAILABLECORES -system.cpu_priority high -gc.incremental_milliseconds 1 -effects.maxgibs -1 -physics.steps 60 -graphics.waves false"
                    Set-Clipboard -Value $launchoptions
                    Set-Clipboard -Value $launchoptions
                    Write-Host "Başlatma Seçenekleri panoya kopyalandı." -ForegroundColor Green
                    Start-Sleep -Seconds 1
                    Write-Host "Steam Kütüphane Açılıyor." -ForegroundColor Cyan
                    Start-Sleep -Seconds 1
                    Start-Process steam://open/library
                    Start-Sleep -Seconds 1
                    break
                }
                2 {
                    PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/rust.ps1' | Invoke-Expression }"
                }
                3{
                    Start-Process "https://github.com/SirriusV1/Oyun-Cfg/blob/main/Rust/README.md"
                }
                4{
                    PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/main.ps1' | Invoke-Expression }"
                }
                default {
                    Write-Host "Geçersiz bir seçim yaptınız. Lütfen 1-4 arasında bir numara girin." -ForegroundColor Red
                    Start-Sleep -Seconds 1
                    break
                }
            }
        }
        
    }
    3 {
        PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/minecraft.ps1' | Invoke-Expression }"
    }
    4 {
        while ($true) {
            clear-host
            $host.ui.RawUI.WindowTitle = "Pubg Menü"
            Write-Host "1. Başlatma Seçenekleri "
            Write-Host "2. CFG İndir "
            Write-Host "3. Geri Dön" -ForegroundColor Cyan
            $subSecim = Read-Host "Lütfen bir numara girin (1-3)"

            switch ($subSecim) {
                1 {
                    $launchoptions = "-USEALLAVAILABLECORES -malloc=system -KoreanRating"
                    Set-Clipboard -Value $launchoptions
                    Set-Clipboard -Value $launchoptions
                    Write-Host "Başlatma Seçenekleri panoya kopyalandı." -ForegroundColor Green
                    Start-Sleep -Seconds 1
                    Write-Host "Steam Kütüphane Açılıyor." -ForegroundColor Cyan
                    Start-Sleep -Seconds 1
                    Start-Process steam://open/library
                    Start-Sleep -Seconds 1
                    break
                }
                2 {
                    PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/pubg.ps1' | Invoke-Expression }"
                }
                3{
                    PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/main.ps1' | Invoke-Expression }"
                }
                default {
                    Write-Host "Geçersiz bir seçim yaptınız. Lütfen 1-3 arasında bir numara girin." -ForegroundColor Red
                    Start-Sleep -Seconds 1
                    break
                }
            }
        }
        
    }
    5 {
        PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/dc.ps1' | Invoke-Expression }"
    }
    6 {
        powershell -Command "Start-Process PowerShell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -Command irm https://christitus.com/win | iex' -Verb RunAs"
        PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/main.ps1' | Invoke-Expression }"
    }
    default {
        Write-Host "Geçersiz bir seçim yaptınız. Lütfen 1-5 arasinda bir numara girin." -ForegroundColor Red
        Start-Sleep -Seconds 1
        PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/main.ps1' | Invoke-Expression }"
    }
}
