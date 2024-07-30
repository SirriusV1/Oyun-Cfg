
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
