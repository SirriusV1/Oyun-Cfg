
$host.ui.RawUI.WindowTitle = "Rust"
Clear-Host

Write-Host "Hangi oyuncunun CFG dosyasını indirmek istiyorsunuz?" -ForegroundColor Cyan
Write-Host "1. Burak"
Write-Host "2. Buğra"
Write-Host "3. Arda"
Write-Host "4. Emir"
Write-Host "5. Çağri"
Write-Host "6. MFA"
Write-Host "7. Sirrius"
Write-Host "8. Geri Dön" -ForegroundColor Cyan

$player_choice = Read-Host "Lütfen bir oyuncu seçin (1-8)"

switch ($player_choice) {
    "1" {
        Invoke-WebRequest -Uri "https://drive.google.com/u/0/uc?id=1VWUYc-L5yq6T7ipNNieAA0G9kpOf02gE&export=download" -OutFile "C:\Program Files (x86)\Steam\steamapps\common\Rust\cfg\ata.cfg"
    }
    "2" {
        Invoke-WebRequest -Uri "https://drive.google.com/u/0/uc?id=1bWyD709q0tb8R2yUm0_b6_sggO8TQftH&export=download" -OutFile "C:\Program Files (x86)\Steam\steamapps\common\Rust\cfg\ata.cfg"
    }
    "3" {
        Invoke-WebRequest -Uri "https://drive.google.com/u/0/uc?id=1u1Ol1tm9SFPUzOrNjMK0jnnpykIZhklv&export=download" -OutFile "C:\Program Files (x86)\Steam\steamapps\common\Rust\cfg\ata.cfg"
    }
    "4" {
        Invoke-WebRequest -Uri "https://drive.google.com/u/0/uc?id=1LWxIO5JvwRIqt9-ywIS9kGh6UgTimqhZ&export=download" -OutFile "C:\Program Files (x86)\Steam\steamapps\common\Rust\cfg\ata.cfg"
    }
    "5" {
        Invoke-WebRequest -Uri "https://drive.google.com/u/0/uc?id=1b3rAzOlDQVa8LoIn8Een8-FpcxYQrKLA&export=download" -OutFile "C:\Program Files (x86)\Steam\steamapps\common\Rust\cfg\ata.cfg"
    }
    "6" {
        Invoke-WebRequest -Uri "https://drive.google.com/u/0/uc?id=1zmcK4soNCz4T2ZEvxXoPESSUN2G0S_xe&export=download" -OutFile "C:\Program Files (x86)\Steam\steamapps\common\Rust\cfg\ata.cfg"
    }
    "7" {
        Invoke-WebRequest -Uri "https://drive.google.com/u/0/uc?id=1L3FmXtfaD3OCOF3_4Ra7IdaO8-n_tO_J&export=downloads" -OutFile "C:\Program Files (x86)\Steam\steamapps\common\Rust\cfg\ata.cfg"
    }
    "8" {
        PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/main.ps1' | Invoke-Expression }"
    }
    default {
        Write-Host "Geçersiz oyuncu seçeneği! Lütfen tekrar deneyin." -ForegroundColor Red
        Start-Sleep -Seconds 2
        PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/rust.ps1' | Invoke-Expression }"
    }
}

Write-Host "İşlem tamamlandı. Ana menüye dönülüyor..." -ForegroundColor Green
Start-Sleep -Seconds 1
PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/main.ps1' | Invoke-Expression }"
