# Kısayol ve simge URL'leri
$faviconUrl = "https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/favicon.ico"  # Simge URL'sini güncelleyin
$iconPath = [System.IO.Path]::Combine($env:USERPROFILE, 'Desktop', 'favicon.ico')
$shortcutPath = [System.IO.Path]::Combine($env:USERPROFILE, 'Desktop', 'ATA.lnk')
$errorLogPath = [System.IO.Path]::Combine($env:USERPROFILE, 'Desktop', 'error_log.txt')

# Favicon.ico dosyasını indir
try {
    Invoke-WebRequest -Uri $faviconUrl -OutFile $iconPath -ErrorAction Stop
} catch {
    $_ | Out-File $errorLogPath -Append
    Write-Error "İkon dosyası indirilemedi: $_"
    exit
}

# Kısayolu oluştur veya güncelle
try {
    $WshShell = New-Object -ComObject WScript.Shell
    $Shortcut = $WshShell.CreateShortcut($shortcutPath)
    $Shortcut.TargetPath = "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe"
    $Shortcut.Arguments = "-ExecutionPolicy Bypass -Command & { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/main.ps1' | Invoke-Expression }"
    $Shortcut.WorkingDirectory = "C:\Path\To\Working\Directory"  # Gerekirse bu yolu güncelleyin
    $Shortcut.IconLocation = $iconPath
    $Shortcut.Save()
} catch {
    $_ | Out-File $errorLogPath -Append
    Write-Error "Kısayol oluşturulamadı: $_"
    exit
}

# Kısayolu oluşturduktan sonra kısa bir bekleme süresi ekleyin
Start-Sleep -Milliseconds 1000

# İndirilen ikon dosyasını sil
try {
    Remove-Item -Path $iconPath -Force -ErrorAction Stop
} catch {
    $_ | Out-File $errorLogPath -Append
    Write-Error "İkon dosyası silinemedi: $_"
}
