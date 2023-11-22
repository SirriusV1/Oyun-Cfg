
$host.ui.RawUI.WindowTitle = "Pubg"
Clear-Host

# Pubg oyunu için işlemler yapılıyor...
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/cfg/GameUserSettings.ini" -OutFile "$env:USERPROFILE\AppData\Local\TslGame\Saved\Config\WindowsNoEditor\GameUserSettings.ini"

Write-Host "İşlem tamamlandı. Ana menüye dönülüyor..." -ForegroundColor Green
Start-Sleep -Seconds 1
PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/main.ps1' | Invoke-Expression }"