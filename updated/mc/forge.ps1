
$host.ui.RawUI.WindowTitle = "Forge Yükleniyor..."
Clear-Host

# Zip dosyasının indirileceği URL
$zipUrl = "https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/mc/Forge.zip"

# Hedef klasör
$minecraftFolder = "$env:USERPROFILE\AppData\Roaming\.minecraft"

# Zip dosyasını indir
$zipFilePath = Join-Path $minecraftFolder "Forge.zip"
Invoke-WebRequest -Uri $zipUrl -OutFile $zipFilePath

# Zip dosyasını çıkart
Expand-Archive -Path $zipFilePath -DestinationPath $minecraftFolder -Force

# "versions" klasörünü kontrol et
if (Test-Path "$minecraftFolder\versions" -PathType Container) {
    # "versions" klasörü varsa, içeriği hedef klasöre taşı
    Move-Item -Path "$minecraftFolder\versions\*" -Destination $minecraftFolder -Force
    Write-Host "Uyarı: 'versions' klasörü içeriği hedef klasöre taşındı." -ForegroundColor Yellow
}

# Zip dosyasını sil
Remove-Item $zipFilePath -Force

Write-Host "Forge başarıyla yüklendi." -ForegroundColor Cyan

Start-Sleep -Seconds 1
PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/minecraft.ps1' | Invoke-Expression }"
Read-Host "Devam etmek için bir tuşa basın..."