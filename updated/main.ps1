
$host.ui.RawUI.WindowTitle = "ATA CFG"
Clear-Host

Write-Host "Hangi oyunun CFG dosyasini indirmek istiyorsunuz? " -NoNewline
Write-Host "(Başlatma Seçenekleri panoya kopyalanır.)" -ForegroundColor Cyan
Write-Host "1. Cs        " -NoNewline
Write-Host "1.0.4 [06.12.2023]" -ForegroundColor Green
Write-Host "2. Rust      " -NoNewline
Write-Host "1.0.5 [25.12.2023]" -ForegroundColor Green
Write-Host "3. Minecraft " -NoNewline
Write-Host "1.20.1" -ForegroundColor Green
Write-Host "4. Pubg "
Write-Host "5. Ruhunu Sat " -ForegroundColor DarkMagenta
$sec = "(1-5)"
$secim = Read-Host "Lütfen bir numara girin $sec"


switch ($secim) {
    1 {
        $launchoptions = "-high -novid -tickrate 128 +exec ata.cfg"
        Set-Clipboard -Value $launchoptions
        PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/cs.ps1' | Invoke-Expression }"
        break
    }
    2 {
        $launchoptions = "-malloc=system -USEALLAVAILABLECORES -system.cpu_priority high -gc.incremental_milliseconds 1 -effects.maxgibs -1 -physics.steps 60 -graphics.waves false"
        Set-Clipboard -Value $launchoptions
        PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/rust.ps1' | Invoke-Expression }"
        break
    }
    3 {
        PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/minecraft.ps1' | Invoke-Expression }"
        break
    }
    4 {
        $launchoptions = "-USEALLAVAILABLECORES -malloc=system -KoreanRating"
        Set-Clipboard -Value $launchoptions
        PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/pubg.ps1' | Invoke-Expression }"
        break
    }
    5 {
        PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/sell.ps1' | Invoke-Expression }"
        break
    }
    default {
        Write-Host "Geçersiz bir seçim yaptınız. Lütfen 1-5 arasinda bir numara girin." -ForegroundColor Red
        Start-Sleep -Seconds 1
        PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/main.ps1' | Invoke-Expression }"
    }
}
