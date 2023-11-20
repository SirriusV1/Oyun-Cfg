# Cs oyunu için işlemler yapılıyor...
Invoke-WebRequest -Uri "https://drive.google.com/uc?id=1iNfubaww_df_A9IlIS-bavKWVqfHt3dw" -OutFile "C:\Program Files (x86)\Steam\steamapps\common\Counter-Strike Global Offensive\game\csgo\cfg\ata.cfg"

Write-Host "Islem tamamlandi. Ana menuye donuluyor..." -ForegroundColor Green
$host.ui.RawUI.WindowTitle = "Indirme Tamamlandi - Cs"
Start-Sleep -Seconds 2
exit
