
$host.ui.RawUI.WindowTitle = "Journeymap Ayarlarını Yükle"
Clear-Host

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
    Write-Host "Journeymap ayarları yüklenmedi." -ForegroundColor Yellow
} else {
    Write-Host "Journeymap ayarları başarıyla yüklendi." -ForegroundColor Green
}
Start-Sleep -Seconds 1
PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/minecraft.ps1' | Invoke-Expression }"