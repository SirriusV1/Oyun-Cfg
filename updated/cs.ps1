$host.ui.RawUI.WindowTitle = "CS"
Clear-Host

# Cs oyunu için işlemler yapılıyor...
Invoke-WebRequest -Uri "https://drive.google.com/uc?id=1iNfubaww_df_A9IlIS-bavKWVqfHt3dw" -OutFile "C:\Program Files (x86)\Steam\steamapps\common\Counter-Strike Global Offensive\game\csgo\cfg\ata.cfg"

Write-Host "İşlem tamamlandı. Ana menüye dönülüyor..." -ForegroundColor Green
Start-Sleep -Seconds 1
PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/main.ps1' | Invoke-Expression }"