$host.ui.RawUI.WindowTitle = "Fabric 1.21 Yükleniyor..."
Clear-Host

# Hedef klasör
$minecraftFolder = "$env:USERPROFILE\AppData\Roaming\.minecraft"

# Silinmeyecek dosya ve klasörler
$protectedItems = @(
    "versions",
    "TLauncher.exe",
    "TlauncherProfiles.json"
)

# Klasördeki dosya ve alt klasörleri listele
$items = Get-ChildItem -Path $minecraftFolder -Recurse -ErrorAction SilentlyContinue

foreach ($item in $items) {
    # Korumalı dosya veya klasör olup olmadığını kontrol et
    $isProtected = $protectedItems | Where-Object { $item.FullName -like "*$_*" }

    if (-not $isProtected) {
        if (Test-Path -Path $item.FullName) {
            try {
                # Dosya veya klasörü sil
                Remove-Item -Path $item.FullName -Recurse -Force -ErrorAction Stop
            }
            catch {
                Write-Warning "Silinemeyen dosya veya klasör: $($item.FullName). Hata: $_"
            }
        }
    }
}

# Zip dosyasının indirileceği URL
$zipUrl = "https://github.com/SirriusV1/Oyun-Cfg/raw/main/updated/mc/Fabric_1.21.zip"

# Dosya adı
$fileName = "Fabric_1.21.zip"

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
