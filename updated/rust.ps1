﻿$host.ui.RawUI.WindowTitle = "Rust"
Clear-Host

Write-Host "Hangi oyuncunun CFG dosyasını indirmek istiyorsunuz?" -ForegroundColor Cyan
Write-Host "1. Burak"
Write-Host "2. Buğra"
Write-Host "3. Emir"
Write-Host "4. Çağri"
Write-Host "5. MFA"
Write-Host "6. Sirrius"
Write-Host "7. Global"
Write-Host "8. Geri Dön" -ForegroundColor Cyan

$player_choice = Read-Host "Lütfen bir oyuncu seçin (1-8)"

# Define the base URL for CFG files
$baseCfgUrl = "https://drive.google.com/u/0/uc?id="

# Define the file name
$fileName = "ata.cfg"

# Get logical drives and sort them alphabetically
$logicalDrives = Get-PSDrive -PSProvider FileSystem | Where-Object { $_.Free -gt 0 } | Sort-Object -Property Root

# Define the target directory array dynamically based on logical drives
$targetDirectories = @()
foreach ($drive in $logicalDrives) {
    $programFilesDirectory = Join-Path $drive.Root "Program Files (x86)\Steam\steamapps\common\Rust\cfg\"
    $steamLibraryDirectory = Join-Path $drive.Root "SteamLibrary\steamapps\common\Rust\cfg\"

    $targetDirectories += $programFilesDirectory, $steamLibraryDirectory
}

switch ($player_choice) {
    "1" {
        $fileId = "1VWUYc-L5yq6T7ipNNieAA0G9kpOf02gE"
    }
    "2" {
        $fileId = "1bWyD709q0tb8R2yUm0_b6_sggO8TQftH"
    }
    "3" {
        $fileId = "1LWxIO5JvwRIqt9-ywIS9kGh6UgTimqhZ"
    }
    "4" {
        $fileId = "1b3rAzOlDQVa8LoIn8Een8-FpcxYQrKLA"
    }
    "5" {
        $fileId = "1zmcK4soNCz4T2ZEvxXoPESSUN2G0S_xe"
    }
    "6" {
        $fileId = "1L3FmXtfaD3OCOF3_4Ra7IdaO8-n_tO_J"
    }
    "7" {
        $fileId = "1u1Ol1tm9SFPUzOrNjMK0jnnpykIZhklv"
    }
    "8" {
        PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/main.ps1' | Invoke-Expression }"
        exit
    }
    default {
        Write-Host "Geçersiz oyuncu seçeneği! Lütfen tekrar deneyin." -ForegroundColor Red
        Start-Sleep -Seconds 2
        PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/rust.ps1' | Invoke-Expression }"
        exit
    }
}

# İndirilecek dosyanın tam URL'sini oluştur
$fileUrl = "$baseCfgUrl$fileId&export=download"

# Her bir hedef dizini için dosyayı indir
foreach ($targetDirectory in $targetDirectories) {
    $fullPath = Join-Path $targetDirectory $fileName

    try {
        # Dosyayı indir
        Invoke-WebRequest -Uri $fileUrl -OutFile $fullPath -ErrorAction Stop
        Write-Host "Dosya başarıyla indirildi: $fullPath" -ForegroundColor Green
        Set-Clipboard -Value "exec ata.cfg"
        Set-Clipboard -Value "exec ata.cfg"
        break
    }
    catch {
        Write-Host "Dosya indirme hatası: $_" -ForegroundColor Red
    }
}

Set-Clipboard -Value "exec ata.cfg"
Set-Clipboard -Value "exec ata.cfg"
Write-Host "İşlem tamamlandı. Ana menüye dönülüyor..." -ForegroundColor Green
Start-Sleep -Seconds 2
PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/main.ps1' | Invoke-Expression }"
