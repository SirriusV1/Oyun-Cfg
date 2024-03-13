
$host.ui.RawUI.WindowTitle = "Fabric Yükleniyor..."
Clear-Host

# Zip dosyasının indirileceği URL
$zipUrl = "https://github.com/SirriusV1/Oyun-Cfg/raw/main/updated/mc/Fabric.zip"

# Hedef klasör
$minecraftFolder = "$env:USERPROFILE\AppData\Roaming\.minecraft"

# Dosya adı
$fileName = "Fabric.zip"

# İndirme işlemi
$webClient = New-Object System.Net.WebClient
$webClient.DownloadFile($zipUrl, "$minecraftFolder\$fileName")

# Zip dosyasını çıkart
Add-Type -AssemblyName System.IO.Compression.FileSystem
[System.IO.Compression.ZipFile]::ExtractToDirectory("$minecraftFolder\$fileName", $minecraftFolder)

# Zip dosyasını sil
Remove-Item "$minecraftFolder\$fileName" -Force

Write-Host "Fabric başarıyla yüklendi." -ForegroundColor Cyan

Start-Sleep -Seconds 1
PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/minecraft.ps1' | Invoke-Expression }"

