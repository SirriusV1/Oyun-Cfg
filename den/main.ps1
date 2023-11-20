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
        "https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/den/cs.ps1"
        break
    }
    2 {
        # Rust secildiginde yapilacak islemler
        Clear-Host
        "https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/den/rust.ps1"
        break
    }
    3 {
        # Minecraft secildiginde yapilacak islemler
        "https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/den/Minecraft.ps1"
        break
    }
    default {
        # Gecersiz bir secim yapildiginda uyarı ver
        Write-Host "Gecersiz bir secim yaptiniz. Lutfen 1-3 arasinda bir numara girin."
        break
    }
}
