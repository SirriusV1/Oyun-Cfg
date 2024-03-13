
$host.ui.RawUI.WindowTitle = "Forge Yükleniyor..."
Clear-Host

# Zip dosyasının indirileceği URL
$zipUrl = "https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/mc/Forge.zip"

# Hedef klasör
$minecraftFolder = "$env:USERPROFILE\AppData\Roaming\.minecraft"

# Dosya adı
$fileName = "Forge.zip"

# İndirme işlemi
$webClient = New-Object System.Net.WebClient
$webClient.DownloadFile($zipUrl, "$minecraftFolder\$fileName")

# Zip dosyasını çıkart
Expand-Archive -Path "$minecraftFolder\$fileName" -DestinationPath $minecraftFolder -Force

# "versions" klasörünü hedef klasöre taşı
Move-Item -Path "$minecraftFolder\versions\*" -Destination $minecraftFolder -Force

# "versions" klasörünü silecek
Remove-Item -Path "$minecraftFolder\versions" -Force

# Zip dosyasını sil
Remove-Item "$minecraftFolder\$fileName" -Force

Write-Host "Forge başarıyla yüklendi." -ForegroundColor Cyan

Start-Sleep -Seconds 1
PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/minecraft.ps1' | Invoke-Expression }"
