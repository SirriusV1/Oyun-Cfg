# Functions/Invoke-PubgCfg.ps1
Clear-Host
Write-Host "[>] PUBG CFG İndiriliyor..." -ForegroundColor Cyan
Write-Host "-------------------------------------------" -ForegroundColor Gray

$TargetDir = "$env:LOCALAPPDATA\TslGame\Saved\Config\WindowsNoEditor"
$OutputFile = Join-Path $TargetDir "GameUserSettings.ini"

# Klasör kontrolü (Eğer PUBG hiç açılmadıysa klasör olmayabilir)
if (-not (Test-Path $TargetDir)) {
    Write-Host "[!] Hedef klasör bulunamadı, oluşturuluyor..." -ForegroundColor Yellow
    New-Item -ItemType Directory -Path $TargetDir -Force | Out-Null
}

Write-Host "[>] Dosya indiriliyor: GameUserSettings.ini" -ForegroundColor Yellow
try {
    Invoke-WebRequest -Uri "https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/cfg/GameUserSettings.ini" -OutFile $OutputFile -ErrorAction Stop
    Write-Host "[+] İşlem başarıyla tamamlandı!" -ForegroundColor Green
} catch {
    Write-Host "[X] Hata: Dosya indirilemedi. İnternet bağlantınızı kontrol edin." -ForegroundColor Red
}
