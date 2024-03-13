$host.ui.RawUI.WindowTitle = "Forge Yükleniyor..."
Clear-Host

# Zip dosyasının indirileceği URL
$zipUrl = "https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/mc/Forge.zip"

# Hedef klasör
$minecraftFolder = "$env:USERPROFILE\AppData\Roaming\.minecraft"

# İndirme işlemi
curl -o "$minecraftFolder\Forge.zip" $zipUrl

# Hedef klasörde aynı isimde klasör var mı kontrol et
if (Test-Path $minecraftFolder -PathType Container) {
    $confirmation = Read-Host "Hedef klasörde aynı isimde klasör bulunmaktadır. Üzerine yazmak istiyor musunuz? (E/H)"
    if ($confirmation -eq "E") {
        # Zip içeriğini çıkart
        Expand-Archive -Path "$minecraftFolder\Forge.zip" -DestinationPath $minecraftFolder -Force

        # Zip dosyasını sil
        Remove-Item "$minecraftFolder\Forge.zip" -Force

        Write-Host "Forge başarıyla yüklendi." -ForegroundColor Cyan
    } else {
        Write-Host "İşlem iptal edildi." -ForegroundColor Red
    }
} else {
    # Hedef klasörde aynı isimde klasör bulunmuyorsa, normal çıkartma işlemini yap
    Expand-Archive -Path "$minecraftFolder\Forge.zip" -DestinationPath $minecraftFolder -Force

    # Zip dosyasını sil
    Remove-Item "$minecraftFolder\Forge.zip" -Force

    Write-Host "Forge başarıyla yüklendi." -ForegroundColor Cyan
}
Start-Sleep -Seconds 1
PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/minecraft.ps1' | Invoke-Expression }"
