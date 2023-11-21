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
    Write-Host "Hedef klasörde aynı isimde klasör bulunmaktadır."

    $confirmation = Read-Host "Üzerine yazmak istiyor musunuz? (E/H)"
    if ($confirmation -eq "H") {
        Write-Host "İşlem iptal edildi."
        Exit
    }
    
    # Hedef klasörü sil
    Remove-Item $minecraftFolder -Recurse -Force
}

# Zip içeriğini çıkart
Expand-Archive -Path $zipFilePath -DestinationPath $minecraftFolder -Force

# Zip dosyasını sil
Remove-Item $zipFilePath -Force

Write-Host "Minecraft ayarları başarıyla güncellendi." -ForegroundColor Green

# Kullanıcıya birkaç saniye beklemesi için mesaj göster
Start-Sleep -Seconds 3

# Minecraft ayarlarını başka bir PowerShell betiği ile de güncelle
Write-Host "Minecraft ayarları yükleniyor..."
PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/minecraft.ps1' | Invoke-Expression }"
Write-Host "Minecraft ayarları başarıyla yüklendi." -ForegroundColor Green
