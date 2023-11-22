
$host.ui.RawUI.WindowTitle = "ATA CFG"
Clear-Host

# Baslangicta hangi oyunun CFG dosyasini indirmek istedigini sor
Write-Host "Hangi oyunun CFG dosyasini indirmek istiyorsunuz?"
Write-Host "1. Cs        " -NoNewline
Write-Host "1.0.4" -ForegroundColor Green
Write-Host "2. Rust      " -NoNewline
Write-Host "1.0.4" -ForegroundColor Green
Write-Host "3. Minecraft " -NoNewline
Write-Host "1.20.1" -ForegroundColor Green
Write-Host "4. Pubg "
$secim = Read-Host "Lütfen bir numara girin (1-4)"

# Secime gore yonlendirme yap
switch ($secim) {
    1 {
        # Cs secildiginde yapilacak islemler
        PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/cs.ps1' | Invoke-Expression }"
        break
    }
    2 {
        # Rust secildiginde yapilacak islemler
        PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/rust.ps1' | Invoke-Expression }"
        break
    }
    3 {
        # Minecraft secildiginde yapilacak islemler
        PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/minecraft.ps1' | Invoke-Expression }"
        break
    }
    4 {
        # Pubg secildiginde yapilacak islemler
        PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/pubg.ps1' | Invoke-Expression }"
        break
    }
    default {
        # Gecersiz bir secim yapildiginda uyarı ver
        Write-Host "Geçersiz bir seçim yaptınız. Lütfen 1-4 arasinda bir numara girin." -ForegroundColor Red
        Start-Sleep -Seconds 1
        PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/main.ps1' | Invoke-Expression }"
    }
}
