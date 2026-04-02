# Functions/Invoke-DiscordCleanup.ps1
Clear-Host
Write-Host "[>] Discord Cache Temizleme Başlatılıyor..." -ForegroundColor Cyan
Write-Host "-------------------------------------------" -ForegroundColor Gray

# Discord'u kapat
Write-Host "[!] Discord işlemleri durduruluyor..." -ForegroundColor Yellow
Get-Process -Name "Discord" -ErrorAction SilentlyContinue | Stop-Process -Force
Start-Sleep -Seconds 2

$DiscordPath = "$env:APPDATA\discord"
$Keep = @("Local State", "Preferences", "settings.json", "quotes.json", "Network", "Local Storage", "Session Storage", "WebStorage", "SharedStorage", "Shared Dictionary", "shared_proto_db")

if (Test-Path $DiscordPath) {
    $AllItems = Get-ChildItem $DiscordPath -ErrorAction SilentlyContinue
    foreach ($item in $AllItems) {
        if ($Keep -notcontains $item.Name) {
            Write-Host "[+] Siliniyor: $($item.Name)" -ForegroundColor Green
            Remove-Item $item.FullName -Recurse -Force -ErrorAction SilentlyContinue
        }
    }
    Write-Host "`n[V] Temizlik tamamlandı! Giriş bilgileri korundu." -ForegroundColor Cyan
} else {
    Write-Host "[X] Discord klasörü bulunamadı." -ForegroundColor Red
}

# Discord'u yeniden aç
Write-Host "[>] Discord yeniden başlatılıyor..." -ForegroundColor Yellow
$DiscordExe = "$env:LOCALAPPDATA\Discord\Update.exe"
if (Test-Path $DiscordExe) {
    Start-Process $DiscordExe -ArgumentList "--processStart", "Discord.exe"
} else {
    Write-Host "[!] Discord.exe bulunamadı, lütfen manuel açın." -ForegroundColor Red
}

Write-Host "`n[!] İşlem bitti." -ForegroundColor Gray