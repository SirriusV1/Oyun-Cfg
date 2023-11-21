$host.ui.RawUI.WindowTitle = "CS"
# Cs oyunu için işlemler yapılıyor...
Invoke-WebRequest -Uri "https://drive.google.com/uc?id=1iNfubaww_df_A9IlIS-bavKWVqfHt3dw" -OutFile "C:\Users\sirri\OneDrive\Masaüstü\deneme\cs\ata.cfg"

Write-Host "Islem tamamlandi. Ana menuye donuluyor..." -ForegroundColor Green
Start-Sleep -Seconds 2