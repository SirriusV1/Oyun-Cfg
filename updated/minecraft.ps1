
$host.ui.RawUI.WindowTitle = "Minecraft Menü"
Clear-Host
# Menüyü göster
Write-Host "1. Minecraft Ayarlarını Yükle"
Write-Host "2. Modları Yükle"
Write-Host "3. Journeymap Ayarlarını Yükle"
Write-Host "4. Geri Dön" -ForegroundColor Cyan
$secim = Read-Host "Lütfen yapmak istediğiniz işlemi seçin (1-4)"

# Seçime göre işlem yap
switch ($secim) {
    1 {
        # Minecraft ayarlarını yükle
        PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/mc/settings.ps1' | Invoke-Expression }"
    }
    2 {
        # Modları yükle
        PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/mc/mod.ps1' | Invoke-Expression }"
    }
    3 {
        # Journeymap ayarlarını yükle
        PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/mc/map.ps1' | Invoke-Expression }"
    }
    4 {
        # Çıkış
        PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/main.ps1' | Invoke-Expression }"
    }
    default {
        Write-Host "Gecersiz bir secim yaptiniz. Lutfen 1-3 arasinda bir numara girin." -ForegroundColor Red
        Start-Sleep -Seconds 2
        PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/minecraft.ps1' | Invoke-Expression }"
    }
}
