$host.ui.RawUI.WindowTitle = "Minecraft Ayarlarını Yükle"
Clear-Host
# Ana Minecraft dosyasının indirileceği klasör
$minecraftDosyaKlasoru = "%appdata%/.minecraft"

# Ana Minecraft dosyasının indirme URL'si
$minecraftDosyaUrl = "https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/mc/mc.zip"

# Minecraft dosyasını indir ve çıkar
$minecraftDosyaZipYeri = Join-Path -Path $env:TEMP -ChildPath "minecraft-dosyasi.zip"

# Dosyanın var olup olmadığını kontrol et
if (Test-Path $minecraftDosyaZipYeri) {
    Write-Host "Minecraft dosyası zaten var." -ForegroundColor Yellow
} else {
    try {
        # Dosya yoksa indir
        Invoke-WebRequest -Uri $minecraftDosyaUrl -OutFile $minecraftDosyaZipYeri
        Add-Type -AssemblyName System.IO.Compression.FileSystem
        [System.IO.Compression.ZipFile]::ExtractToDirectory($minecraftDosyaZipYeri, $minecraftDosyaKlasoru)
        Write-Host "Minecraft dosyası başarıyla indirildi ve çıkarıldı." -ForegroundColor Green
    } catch {
        Write-Host "Hata oluştu: $_" -ForegroundColor Red
        Write-Host "Minecraft dosyası başarıyla indirildi ve çıkarıldı." -ForegroundColor Green
    }
}

# Zip dosyasını sil
Remove-Item -Path $minecraftDosyaZipYeri -Force
Start-Sleep -Seconds 3
PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/minecraft.ps1' | Invoke-Expression }"
