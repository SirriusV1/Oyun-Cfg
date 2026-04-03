# Functions/FixOverlay.ps1
Clear-Host
Write-Host "[>] ms-gamingoverlay Hatası Gideriliyor..." -ForegroundColor Cyan
Write-Host "-------------------------------------------" -ForegroundColor Gray

$RegPath1 = "HKCU:\Software\Microsoft\Windows\CurrentVersion\GameDVR"
$RegPath2 = "HKCU:\System\GameConfigStore"

try {
    # GameDVR Ayarı
    if (-not (Test-Path $RegPath1)) { 
        New-Item -Path $RegPath1 -Force | Out-Null 
    }
    Set-ItemProperty -Path $RegPath1 -Name "AppCaptureEnabled" -Value 0 -Type DWord
    Write-Host "[+] GameDVR Devre Dışı Bırakıldı." -ForegroundColor Green

    # GameConfigStore Ayarı
    if (-not (Test-Path $RegPath2)) { 
        New-Item -Path $RegPath2 -Force | Out-Null 
    }
    Set-ItemProperty -Path $RegPath2 -Name "GameDVR_Enabled" -Value 0 -Type DWord
    Write-Host "[+] GameConfigStore Güncellendi." -ForegroundColor Green

    Write-Host "`n[V] İşlem Başarılı! Artık o uyarıyı almayacaksınız." -ForegroundColor Cyan
}
catch {
    Write-Host "[X] Hata Oluştu: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host "`n[!] İşlem bitti." -ForegroundColor Gray