$host.ui.RawUI.WindowTitle = "Minecraft Ayarlarını Güncelle"
Clear-Host

# Zip dosyasının indirileceği URL
$zipUrl = "https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/mc/mc.zip"

# Hedef klasör
$minecraftFolder = "$env:USERPROFILE\AppData\Roaming\.minecraft"

# Zip dosyasını indir
$zipFilePath = Join-Path $minecraftFolder "mc.zip"
Invoke-WebRequest -Uri $zipUrl -OutFile $zipFilePath

# Hedef klasörde aynı isimde klasör var mı kontrol et
if (Test-Path $minecraftFolder -PathType Container) {
    $confirmation = Read-Host "Hedef klasörde aynı isimde klasör bulunmaktadır. Üzerine yazmak istiyor musunuz? (E/H)" -ForegroundColor Cyan
    if ($confirmation -eq "E") {
        # Zip içeriğini çıkart
        Expand-Archive -Path $zipFilePath -DestinationPath $minecraftFolder -Force

        # Zip dosyasını sil
        Remove-Item $zipFilePath -Force

        Write-Host "Minecraft ayarları başarıyla güncellendi."
    } else {
        Write-Host "İşlem iptal edildi."
    }
} else {
    # Hedef klasörde aynı isimde klasör bulunmuyorsa, normal çıkartma işlemini yap
    Expand-Archive -Path $zipFilePath -DestinationPath $minecraftFolder -Force

    # Zip dosyasını sil
    Remove-Item $zipFilePath -Force

    Write-Host "Minecraft ayarları başarıyla güncellendi." -ForegroundColor Cyan
}
Start-Sleep -Seconds 3
PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/minecraft.ps1' | Invoke-Expression }"
