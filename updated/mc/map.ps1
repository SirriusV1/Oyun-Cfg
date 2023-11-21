Clear-Host
$host.ui.RawUI.WindowTitle = "Map Ayarlarını Yükle"

# Map ayarlarının indirileceği klasör
$mapAyarKlasoru = "$env:USERPROFILE\AppData\Roaming\.minecraft\"

# Map ayarlarının indirme URL'si
$mapAyarUrl = "https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/mc/journeymap.zip"

# Zip dosyasını indir
$zipDosyaYeri = Join-Path -Path $env:TEMP -ChildPath "journeymap.zip"
Invoke-WebRequest -Uri $mapAyarUrl -OutFile $zipDosyaYeri

# Zip dosyasını çıkar
Add-Type -AssemblyName System.IO.Compression.FileSystem
[System.IO.Compression.ZipFile]::ExtractToDirectory($zipDosyaYeri, $mapAyarKlasoru)

# Zip dosyasını sil
Remove-Item -Path $zipDosyaYeri -Force

# İşlem başarılı olup olmadığını kontrol et
if (-not $?) {
    Write-Host "Map ayarları yüklenmedi." -ForegroundColor Yellow
} else {
    Write-Host "Map ayarları başarıyla yüklendi." -ForegroundColor Green
}
Start-Sleep -Seconds 3
PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/minecraft.ps1' | Invoke-Expression }"