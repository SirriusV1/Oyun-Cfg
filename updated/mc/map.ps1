$host.ui.RawUI.WindowTitle = "Map İndirliyor.."
Clear-Host

Write-Host "Google drive bağlanılıyor..."


# WinRAR ve 7-Zip kurulum yolları
$winrarPath = "C:\Program Files\WinRAR\WinRAR.exe"
$sevenZipPath = "C:\Program Files\7-Zip\7z.exe"

# Google Drive veya GitHub URL'sini belirleyin
$zipUrl = "https://drive.usercontent.google.com/download?id=1GmS0wXDDzsaAFTCiIot2IWvsXgfgQFwJ&export=download&authuser=0&confirm=t&uuid=b80de976-0a49-4424-851a-9cbde57dc3ae&at=APZUnTV1QhEx9O9C_shzKjDxneaw%3A1723742521745"
$zipFilePath = "$env:APPDATA\.minecraft\map.zip"
$extractPath = "$env:APPDATA\.minecraft"

# PowerShell sürümünü kontrol et
if ($PSVersionTable.PSVersion.Major -lt 7) {
    # PowerShell 7 yüklenmiş mi kontrol et
    $pwshPath = "C:\Program Files\PowerShell\7\pwsh.exe"
    
    if (Test-Path $pwshPath) {
        Start-Process -FilePath $pwshPath -ArgumentList "-File `"$PSCommandPath`"" -NoNewWindow -Wait
        exit
    } else {
        Write-Host "PowerShell 7 yüklü değil, script eski sürümle çalışmaya devam edecek."  -ForegroundColor Red
        Write-Host "Bu işlem uzun sürecek."
        Write-Host ""
    }
}

# PowerShell 7 ile çalıştırılmaya devam edecek scriptin geri kalanı buradan devam eder


if ($PSVersionTable.PSVersion.Major -ge 7) {
    # PowerShell 7 ve üstü sürümler için
    # HttpClient nesnesi oluştur
    $client = New-Object System.Net.Http.HttpClient
    $client.Timeout = [TimeSpan]::FromHours(1)

    # İndirme işlemi için zamanlayıcıyı başlat
    $stopwatch = [System.Diagnostics.Stopwatch]::StartNew()

    # İndirme işlemi
    $response = $client.GetAsync($zipUrl, [System.Net.Http.HttpCompletionOption]::ResponseHeadersRead).Result
    $totalBytes = $response.Content.Headers.ContentLength

    # İndirme akışını okuyun
    $stream = $response.Content.ReadAsStreamAsync().Result
    $fileStream = [System.IO.File]::Create($zipFilePath)

    # İndirme ilerlemesini hesaplamak için ara
    $buffer = New-Object byte[] 8192
    $totalBytesRead = 0
    $lastUpdate = $stopwatch.Elapsed.TotalSeconds

    while (($bytesRead = $stream.Read($buffer, 0, $buffer.Length)) -gt 0) {
        $fileStream.Write($buffer, 0, $bytesRead)
        $totalBytesRead += $bytesRead

        $currentTime = $stopwatch.Elapsed.TotalSeconds
        $elapsedTime = $currentTime - $lastUpdate

        if ($elapsedTime -gt 1) {
            $speedMBps = [math]::Round(($totalBytesRead / 1MB) / $currentTime, 2)
            $progressPercentage = [math]::Round(($totalBytesRead / $totalBytes) * 100, 2)
            Write-Progress -Activity "İndiriliyor" -Status "$progressPercentage% tamamlandı, Anlık Hız: $speedMBps MB/sn" -PercentComplete $progressPercentage
            $lastUpdate = $currentTime
        }
    }

    $stream.Close()
    $fileStream.Close()
    $stopwatch.Stop()

    # Dosya boyutunu hesapla
    $fileInfo = Get-Item $zipFilePath
    $fileSizeMB = [math]::Round($fileInfo.Length / 1MB, 2)

    # Toplam geçen süreyi hesapla
    $elapsedSeconds = $stopwatch.Elapsed.TotalSeconds

    # İndirme hızını hesapla
    $speedMBps = [math]::Round($fileSizeMB / $elapsedSeconds, 2)

    # ZIP dosyasını çıkarma
    Write-Host "ZIP dosyasını çıkarıyor..."

    if (Test-Path $sevenZipPath) {
        # 7-Zip kullanarak çıkarma (Tüm dosyaların üzerine yazılmasını sağlar)
        Start-Process -FilePath $sevenZipPath -ArgumentList "x `"$zipFilePath`" -o`"$extractPath`" -y" -NoNewWindow -Wait
    } elseif (Test-Path $winrarPath) {
        # WinRAR kullanarak çıkarma (Tüm dosyaların üzerine yazılmasını sağlar)
        Start-Process -FilePath $winrarPath -ArgumentList "x `"$zipFilePath`" `"$extractPath`" -y" -NoNewWindow -Wait
    } else {
        # Expand-Archive kullanarak çıkarma
        Expand-Archive -Path $zipFilePath -DestinationPath $extractPath -Force
    }

    # ZIP dosyasını sil
    Remove-Item -Path $zipFilePath -Force

    Write-Host "Dosyalar başarıyla güncellendi."

} else {
    # PowerShell 6 ve altı sürümler için
    # İndirme işlemi
    Write-Host "İndirme işlemi başlatılıyor..."
    Invoke-WebRequest -Uri $zipUrl -OutFile $zipFilePath

    # ZIP dosyasını çıkarma
    Write-Host "ZIP dosyasını çıkarıyor..." -ForegroundColor Green

    if (Test-Path $sevenZipPath) {
        # 7-Zip kullanarak çıkarma (Tüm dosyaların üzerine yazılmasını sağlar)
        Start-Process -FilePath $sevenZipPath -ArgumentList "x `"$zipFilePath`" -o`"$extractPath`" -y" -NoNewWindow -Wait
    } elseif (Test-Path $winrarPath) {
        # WinRAR kullanarak çıkarma (Tüm dosyaların üzerine yazılmasını sağlar)
        Start-Process -FilePath $winrarPath -ArgumentList "x `"$zipFilePath`" `"$extractPath`" -y" -NoNewWindow -Wait
    } else {
        # Expand-Archive kullanarak çıkarma
        Expand-Archive -Path $zipFilePath -DestinationPath $extractPath -Force
    }

    # ZIP dosyasını sil
    Remove-Item -Path $zipFilePath -Force

    Write-Host "Dosyalar başarıyla güncellendi." -ForegroundColor Green
}
Start-Sleep -Seconds 1
PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/minecraft.ps1' | Invoke-Expression }"