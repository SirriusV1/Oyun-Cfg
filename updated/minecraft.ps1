
Clear-Host
$host.ui.RawUI.WindowTitle = "Minecraft Menü"
Write-Host "        ╔═════════════════╗"  -ForegroundColor DarkYellow
Write-Host "        ║  Minecraft Menü ║"  -ForegroundColor DarkYellow
Write-Host "        ╚═════════════════╝"  -ForegroundColor DarkYellow
Write-Host ""
Write-Host "1. Fabric (" -NoNewline
Write-Host "Önerilen" -ForegroundColor Green -NoNewline
Write-Host ") "
Write-Host "2. Forge "
Write-Host "3. TLauncher Ayarı "
Write-Host "4. Geri Dön" -ForegroundColor Cyan
$secim = Read-Host "Lütfen bir numara girin (1-4)"


# Seçime göre işlem yap
switch ($secim) {
    1 {
        PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/mc/fabric.ps1' | Invoke-Expression }"
    }
    2 {
        PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/mc/forge.ps1' | Invoke-Expression }"
    }
    3 {
        $host.ui.RawUI.WindowTitle = "tlauncher Ayarı yükleniyor..."
        Clear-Host
        $url = "https://github.com/SirriusV1/Oyun-Cfg/raw/main/updated/mc/tlauncher-2.0.properties.zip"
        $outputPath = "$env:USERPROFILE\AppData\Roaming\.tlauncher\tlauncher-2.0.properties"

        # Eğer hedef dosya zaten varsa, silerek üzerine yazma
        if (Test-Path $outputPath) {
            Remove-Item $outputPath
        }

        # Dosyayı indir
        $webClient = New-Object System.Net.WebClient
        $webClient.DownloadFile($url, $outputPath)
        Write-Host "tlauncher Ayarı başarıyla yüklendi." -ForegroundColor Cyan

        Start-Sleep -Seconds 1
        PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/minecraft.ps1' | Invoke-Expression }"
    }
    4 {
        PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/main.ps1' | Invoke-Expression }"
    }
    default {
        Write-Host "Geçersiz bir seçim yaptınız. Lütfen 1-4 arasında bir numara girin." -ForegroundColor Red
        Start-Sleep -Seconds 1
        PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/minecraft.ps1' | Invoke-Expression }"
    }
}
