
$host.ui.RawUI.WindowTitle = "Forge Yükleniyor..."
Clear-Host

# Zip dosyasının indirileceği URL
$zipUrl = "https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/mc/Forge.zip"

# Indirme hızını sınırlayan başlık
$headers = @{
    "Rate-Limit" = "25MB/s"  # 25MB/s'ye eşdeğer olan 200 Mbps
}

# Hedef klasör
$minecraftFolder = "$env:USERPROFILE\AppData\Roaming\.minecraft"

# Zip dosyasını indir
$zipFilePath = Join-Path $minecraftFolder "Forge.zip"
Invoke-WebRequest -Uri $zipUrl -Headers $headers -OutFile $zipFilePath

# Hedef klasörde aynı isimde klasör var mı kontrol et
if (Test-Path $minecraftFolder -PathType Container) {
    $confirmation = Read-Host "Hedef klasörde aynı isimde klasör bulunmaktadır. Üzerine yazmak istiyor musunuz? (E/H)"
    if ($confirmation -eq "E") {
        # Zip içeriğini çıkart
        Expand-Archive -Path $zipFilePath -DestinationPath $minecraftFolder -Force

        # Zip dosyasını sil
        Remove-Item $zipFilePath -Force

        Write-Host "Forge başarıyla yüklendi." -ForegroundColor Cyan
    } else {
        Write-Host "İşlem iptal edildi." -ForegroundColor Red
    }
} else {
    # Hedef klasörde aynı isimde klasör bulunmuyorsa, normal çıkartma işlemini yap
    Expand-Archive -Path $zipFilePath -DestinationPath $minecraftFolder -Force

    # Zip dosyasını sil
    Remove-Item $zipFilePath -Force

    Write-Host "Forge başarıyla yüklendi." -ForegroundColor Cyan
}
Start-Sleep -Seconds 1
PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/minecraft.ps1' | Invoke-Expression }"
