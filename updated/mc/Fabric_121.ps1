$host.ui.RawUI.WindowTitle = "Fabric 1.21 Yükleniyor..."
Clear-Host

# Hedef klasör
$minecraftFolder = "$env:USERPROFILE\AppData\Roaming\.minecraft"
$versionsFolder = "$minecraftFolder\versions"
$zipPath = "$minecraftFolder\Fabric_1.21.zip"

# Silinmeyecek dosya ve klasörler
$protectedItems = @(
    "TLauncher.exe",
    "TlauncherProfiles.json"
)

# Silinmeyecek dosyalar hariç tüm klasörleri temizle
$items = Get-ChildItem -Path $minecraftFolder -Recurse -ErrorAction SilentlyContinue

foreach ($item in $items) {
    $isProtected = $protectedItems | Where-Object { $item.FullName -like "*$_*" }

    if (-not $isProtected) {
        if (Test-Path -Path $item.FullName) {
            try {
                Remove-Item -Path $item.FullName -Recurse -Force -ErrorAction Stop
            }
            catch {
                Write-Warning "Silinemeyen dosya veya klasör: $($item.FullName). Hata: $_"
            }
        }
    }
}

# 'versions' klasörünü sil
if (Test-Path -Path $versionsFolder) {
    try {
        Remove-Item -Path $versionsFolder -Recurse -Force -ErrorAction Stop
        Write-Host "'versions' klasörü başarıyla silindi." -ForegroundColor Green
    } catch {
        Write-Error "'versions' klasörünü silerken hata oluştu: $_"
        exit
    }
}

# Zip dosyasının indirileceği URL
$zipUrl = "https://github.com/SirriusV1/Oyun-Cfg/raw/main/updated/mc/Fabric_1.21.zip"

# İndirme işlemi
try {
    $webClient = New-Object System.Net.WebClient
    $webClient.DownloadFile($zipUrl, $zipPath)
} catch {
    Write-Error "Zip dosyasını indirirken hata oluştu: $_"
    exit
}

# Zip dosyasını çıkart
Add-Type -AssemblyName System.IO.Compression.FileSystem
try {
    [System.IO.Compression.ZipFile]::ExtractToDirectory($zipPath, $minecraftFolder)
    Write-Host "Zip dosyası başarıyla çıkartıldı." -ForegroundColor Green
} catch {
    Write-Error "Zip dosyasını çıkartırken hata oluştu: $_"
    exit
}

# Zip dosyasını sil
try {
    Remove-Item -Path $zipPath -Force
    Write-Host "Zip dosyası başarıyla silindi." -ForegroundColor Green
} catch {
    Write-Warning "Zip dosyasını silerken hata oluştu: $_"
}

Write-Host "Fabric başarıyla yüklendi." -ForegroundColor Cyan

Start-Sleep -Seconds 1

try {
    PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/minecraft.ps1' | Invoke-Expression }"
} catch {
    Write-Error "Script'i çalıştırırken hata oluştu: $_"
}
