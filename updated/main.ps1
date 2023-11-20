# Baslangicta hangi oyunun CFG dosyasini indirmek istedigini sor
$secim = Read-Host "Hangi oyunun CFG dosyasini indirmek istiyorsunuz?
1. Cs
2. Rust
3. Minecraft
Lutfen bir numara girin (1-3)"

# GitHub raw linklerini tanimla
$csScript = "https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/cs.ps1"
$rustScript = "https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/rust.ps1"
$minecraftScript = "https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/Minecraft.ps1"

# Secime gore yonlendirme yap
switch ($secim) {
    1 {
        # Cs secildiginde yapilacak islemler
        Clear-Host
        Invoke-RestMethod -Uri $csScript | Invoke-Expression
        break
    }
    2 {
        # Rust secildiginde yapilacak islemler
        Clear-Host
        Invoke-RestMethod -Uri $rustScript | Invoke-Expression
        break
    }
    3 {
        # Minecraft secildiginde yapilacak islemler
        Clear-Host
        Invoke-RestMethod -Uri $minecraftScript | Invoke-Expression
        break
    }
    default {
        # Gecersiz bir secim yapildiginda uyarı ver
        Write-Host "Gecersiz bir secim yaptiniz. Lutfen 1-3 arasinda bir numara girin." -ForegroundColor Red
        break
    }
}
