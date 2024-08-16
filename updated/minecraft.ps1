
Clear-Host
$host.ui.RawUI.WindowTitle = "Minecraft Menü"
Write-Host "        ╔═════════════════╗"  -ForegroundColor DarkYellow
Write-Host "        ║  Minecraft Menü ║"  -ForegroundColor DarkYellow
Write-Host "        ╚═════════════════╝"  -ForegroundColor DarkYellow
Write-Host ""
Write-Host "1. ATA [1.21] (" -NoNewline
Write-Host "Önerilen" -ForegroundColor Green -NoNewline
Write-Host ") "
Write-Host "2. Güncel Map [" -NoNewline
Write-Host "157,8 MB" -ForegroundColor Green -NoNewline
Write-Host "]"
Write-Host "3. Geri Dön" -ForegroundColor Cyan
$secim = Read-Host "Lütfen bir numara girin (1-4)"


# Seçime göre işlem yap
switch ($secim) {
    1 {
        PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/mc/options.ps1' | Invoke-Expression }"
    }
    2 {
        PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/mc/map.ps1' | Invoke-Expression }"
    }
    3 {
        PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/main.ps1' | Invoke-Expression }"
    }
    default {
        Write-Host "Geçersiz bir seçim yaptınız. Lütfen 1-4 arasında bir numara girin." -ForegroundColor Red
        Start-Sleep -Seconds 1
        PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/minecraft.ps1' | Invoke-Expression }"
    }
}
