Clear-Host
Write-Host "[>] CS2 CFG İndiriliyor..." -ForegroundColor Cyan
Write-Host "-------------------------------------------" -ForegroundColor Gray

$fileName = "ata.cfg"
$fileUrl = "https://drive.google.com/uc?export=download&id=1iNfubaww_df_A9IlIS-bavKWVqfHt3dw"
$logicalDrives = Get-PSDrive -PSProvider FileSystem | Where-Object { $_.Free -gt 0 }
$foundPath = $null

foreach ($drive in $logicalDrives) {
    $paths = @("Program Files (x86)\Steam\steamapps\common\Counter-Strike Global Offensive\game\csgo\cfg\", "SteamLibrary\steamapps\common\Counter-Strike Global Offensive\game\csgo\cfg\", "Steam\steamapps\common\Counter-Strike Global Offensive\game\csgo\cfg\")
    foreach ($p in $paths) {
        $fullDir = Join-Path $drive.Root $p
        if (Test-Path $fullDir) { $foundPath = $fullDir; break }
    }
    if ($foundPath) { break }
}

if ($foundPath) {
    try {
        Invoke-WebRequest -Uri $fileUrl -OutFile (Join-Path $foundPath $fileName) -UserAgent "Mozilla/5.0" -ErrorAction Stop
        Write-Host "[+] Başarıyla yüklendi: $foundPath" -ForegroundColor Green
        Write-Host "[!] Konsola 'exec ata' yazmayı unutma!" -ForegroundColor Yellow
    } catch { Write-Host "[X] İndirme hatası!" -ForegroundColor Red }
} else { Write-Host "[X] CS2 Klasörü Bulunamadı!" -ForegroundColor Red }