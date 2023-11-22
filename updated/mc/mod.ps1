
$host.ui.RawUI.WindowTitle = "Modları Yükle"
Clear-Host
# Modların indirileceği klasör
$modKlasoru = "$env:USERPROFILE\AppData\Roaming\.minecraft\mods"


# Mod bilgilerini içeren bir hash tablosu
$modBilgileri = @{
    "OptiFine" = @{
        "Url" = "https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/mc/mod/preview_OptiFine_1.20.1_HD_U_I6_pre6.jar"
        "GuncelSürüm" = "preview_OptiFine_1.20.1_HD_U_I6_pre6.jar"
    }
    "BetterF3" = @{
        "Url" = "https://www.curseforge.com/api/v1/mods/401648/files/4863626/download"
        "GuncelSürüm" = "BetterF3-7.0.2-Forge-1.20.1.jar"
    }
    "Cloth Config" = @{
        "Url" = "https://www.curseforge.com/api/v1/mods/348521/files/4633444/download"
        "GuncelSürüm" = "cloth-config-11.1.106-forge.jar"
    }
    "Jei" = @{
        "Url" = "https://www.curseforge.com/api/v1/mods/238222/files/4712868/download"
        "GuncelSürüm" = "jei-1.20.1-forge-15.2.0.27.jar"
    }
    "Journeymap" = @{
        "Url" = "https://www.curseforge.com/api/v1/mods/32274/files/4873848/download"
        "GuncelSürüm" = "journeymap-1.20.1-5.9.18-forge.jar"
    }
    "Optifabric" = @{
        "Url" = "https://www.curseforge.com/api/v1/mods/322385/files/4642832/download"
        "GuncelSürüm" = "optifabric-1.13.25.jar"
    }
}
Start-Sleep -Seconds 1
# Modları kontrol et, güncelle ve eski sürümleri temizle
foreach ($mod in $modBilgileri.GetEnumerator()) {
    $modAdi = $mod.Key
    $modDetaylari = $mod.Value
    $modUrl = $modDetaylari.Url
    $guncelSurum = $modDetaylari.GuncelSürüm
    $modDosyaYolu = Join-Path -Path $modKlasoru -ChildPath $guncelSurum

    # Mod dosyasının var olup olmadığını kontrol et
    if (Test-Path $modDosyaYolu) {
        $modSürüm = $guncelSurum
        # Eğer dosyanın sürümü güncel değilse, güncelle
        if ($modSürüm -ne $guncelSurum) {
            Invoke-WebRequest -Uri $modUrl -OutFile $modDosyaYolu
            Write-Host "Mod güncellendi: $modAdi" -ForegroundColor Yellow
        } else {
            Write-Host "Mod zaten güncel: $modAdi" -ForegroundColor Green
        }
    } else {
        # Dosya yoksa indir
        Invoke-WebRequest -Uri $modUrl -OutFile $modDosyaYolu
        Write-Host "Mod indirildi: $modAdi" -ForegroundColor Yellow
    }
}

# $modKlasoru klasöründeki indirilen modlar haricindeki tüm dosyaları temizle
Get-ChildItem $modKlasoru | Where-Object { $_.Name -notin $modBilgileri.Values.GuncelSürüm } | Remove-Item -Force
Write-Host "Güncellenmeyen dosyalar temizlendi." -ForegroundColor Green
Write-Host "Tüm modlar güncellendi." -ForegroundColor Green
Start-Sleep -Seconds 1
PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/minecraft.ps1' | Invoke-Expression }"