$winrarPath = "C:\Program Files\WinRAR\WinRAR.exe"
$sevenZipPath = "C:\Program Files\7-Zip\7z.exe"

# Google Drive Config URL'sini belirleyin
$zipUrl = "https://drive.usercontent.google.com/u/0/uc?id=1WTb7qytxLTNrs_5qJfPAKosQ-FgpUrqE&export=download"
$zipFilePath = "$env:APPDATA\.minecraft\versions\ATA\config.zip"
$extractPath = "$env:APPDATA\.minecraft\versions\ATA"
$configFolder = "$env:APPDATA\.minecraft\versions\ATA\config"

# PowerShell 7 ve üstü sürümler için
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

    # Config klasörü oluştur (silme yok, sadece güncellenecek)
    Write-Host "Config dosyaları güncelleniyor..."
    if (-not (Test-Path $configFolder)) {
        New-Item -ItemType Directory -Path $configFolder -Force | Out-Null
    }

    # ZIP dosyasını çıkarma (üzerine yazarak)
    Write-Host "ZIP dosyasını çıkarıyor..."

    if (Test-Path $sevenZipPath) {
        # 7-Zip kullanarak çıkarma
        Start-Process -FilePath $sevenZipPath -ArgumentList "x `"$zipFilePath`" -o`"$extractPath`" -y" -NoNewWindow -Wait
    } elseif (Test-Path $winrarPath) {
        # WinRAR kullanarak çıkarma
        Start-Process -FilePath $winrarPath -ArgumentList "x `"$zipFilePath`" `"$extractPath`" -y" -NoNewWindow -Wait
    } else {
        # Expand-Archive kullanarak çıkarma
        Expand-Archive -Path $zipFilePath -DestinationPath $extractPath -Force
    }

    # ZIP dosyasını sil
    Remove-Item -Path $zipFilePath -Force

    Write-Host "Config dosyaları başarıyla güncellendi." -ForegroundColor Green

} else {
    # PowerShell 6 ve altı sürümler için - curl (en hızlı)
    Write-Host "İndirme işlemi başlatılıyor..." -ForegroundColor Cyan
    
    # Dizin oluştur
    if (-not (Test-Path (Split-Path $zipFilePath))) {
        New-Item -ItemType Directory -Path (Split-Path $zipFilePath) -Force | Out-Null
    }
    
    try {
        # curl.exe ile indir (Windows 10+, en hızlı)
        & curl.exe -L -o $zipFilePath $zipUrl
        
        if ($LASTEXITCODE -ne 0) {
            throw "curl indirme başarısız"
        }
    } catch {
        Write-Host "curl başarısız, BITS Transfer deneniyor..." -ForegroundColor Yellow
        try {
            Start-BitsTransfer -Source $zipUrl -Destination $zipFilePath -DisplayName "Config indiriliyor" -Priority High
        } catch {
            Write-Host "BITS başarısız, Invoke-WebRequest deneniyor..." -ForegroundColor Yellow
            Invoke-WebRequest -Uri $zipUrl -OutFile $zipFilePath
        }
    }

    # Config klasörü oluştur (silme yok, sadece güncellenecek)
    Write-Host "Config dosyaları güncelleniyor..."
    if (-not (Test-Path $configFolder)) {
        New-Item -ItemType Directory -Path $configFolder -Force | Out-Null
    }

    # ZIP dosyasını çıkarma (üzerine yazarak)
    Write-Host "ZIP dosyasını çıkarıyor..." -ForegroundColor Green

    if (Test-Path $sevenZipPath) {
        # 7-Zip kullanarak çıkarma
        Start-Process -FilePath $sevenZipPath -ArgumentList "x `"$zipFilePath`" -o`"$extractPath`" -y" -NoNewWindow -Wait
    } elseif (Test-Path $winrarPath) {
        # WinRAR kullanarak çıkarma
        Start-Process -FilePath $winrarPath -ArgumentList "x `"$zipFilePath`" `"$extractPath`" -y" -NoNewWindow -Wait
    } else {
        # Expand-Archive kullanarak çıkarma
        Expand-Archive -Path $zipFilePath -DestinationPath $extractPath -Force
    }

    # ZIP dosyasını sil
    Remove-Item -Path $zipFilePath -Force
}

Write-Host "Config dosyaları başarıyla güncellendi." -ForegroundColor Green
Start-Sleep -Seconds 1
