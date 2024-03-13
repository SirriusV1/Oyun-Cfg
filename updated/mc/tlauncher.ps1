
$host.ui.RawUI.WindowTitle = "TLauncher Ayarı Yükleniyor..."
Clear-Host

# Zip dosyasının indirileceği URL
$zipUrl = "https://github.com/SirriusV1/Oyun-Cfg/raw/main/updated/mc/tlauncher-2.0.properties"

# Hedef klasör
$minecraftFolder = "$env:USERPROFILE\AppData\Roaming\.tlauncher"

# Dosya adı
$fileName = "tlauncher-2.0.properties"

# İndirme işlemi
$webClient = New-Object System.Net.WebClient
$webClient.DownloadFile($zipUrl, "$minecraftFolder\$fileName")

# Zip dosyasını çıkart
Add-Type -AssemblyName System.IO.Compression.FileSystem
[System.IO.Compression.ZipFile]::ExtractToDirectory("$minecraftFolder\$fileName", $minecraftFolder)

# Zip dosyasını sil
Remove-Item "$minecraftFolder\$fileName" -Force

Write-Host "TLauncher Ayarı başarıyla yüklendi." -ForegroundColor Cyan

Start-Sleep -Seconds 1
PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/minecraft.ps1' | Invoke-Expression }"

