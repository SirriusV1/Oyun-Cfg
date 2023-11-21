
$host.ui.RawUI.WindowTitle = "ATA CFG"
Clear-Host

# Baslangicta hangi oyunun CFG dosyasini indirmek istedigini sor
$secim = Read-Host "Hangi oyunun CFG dosyasini indirmek istiyorsunuz?
1. Cs
2. Rust
3. Minecraft
Lutfen bir numara girin (1-3)"

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
    default {
        # Gecersiz bir secim yapildiginda uyarı ver
        Write-Host "Gecersiz bir secim yaptiniz. Lutfen 1-3 arasinda bir numara girin." -ForegroundColor Red
        Start-Sleep -Seconds 3
        break
    }
}
