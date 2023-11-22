
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
Write-Host "4. DST "
$secim = Read-Host "Lutfen bir numara girin (1-3)"

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
        # Minecraft secildiginde yapilacak islemler
        PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://drive.google.com/file/d/17j_zzuQwT-tOvTE3_bXMyrGXS7gKnHlL/preview' | Invoke-Expression }"
        break
    }
    default {
        # Gecersiz bir secim yapildiginda uyarı ver
        Write-Host "Gecersiz bir secim yaptiniz. Lutfen 1-3 arasinda bir numara girin." -ForegroundColor Red
        Start-Sleep -Seconds 2
        PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/main.ps1' | Invoke-Expression }"
    }
}
