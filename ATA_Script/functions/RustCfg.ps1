param($fileId, $playerName)

Clear-Host
Write-Host "[>] Rust CFG Yükleniyor: $playerName" -ForegroundColor Cyan
Write-Host "----------------------------------------------------" -ForegroundColor Gray

$fileName = "ata.cfg"
$fileUrl = "https://drive.google.com/uc?export=download&id=$fileId"

$logicalDrives = Get-PSDrive -PSProvider FileSystem | Where-Object { $_.Free -gt 0 }
$foundPath = $null

foreach ($drive in $logicalDrives) {
    $paths = @(
        "Program Files (x86)\Steam\steamapps\common\Rust\cfg\",
        "SteamLibrary\steamapps\common\Rust\cfg\",
        "Steam\steamapps\common\Rust\cfg\"
    )
    foreach ($p in $paths) {
        $fullDir = Join-Path $drive.Root $p
        if (Test-Path $fullDir) { $foundPath = $fullDir; break }
    }
    if ($foundPath) { break }
}

if ($foundPath) {
    try {
        Invoke-WebRequest -Uri $fileUrl -OutFile (Join-Path $foundPath $fileName) -UserAgent "Mozilla/5.0" -ErrorAction Stop
        Write-Host "[+] $playerName CFG başarıyla indirildi!" -ForegroundColor Green
        Set-Clipboard -Value "exec ata.cfg"
        Write-Host "[!] 'exec ata.cfg' komutu panoya kopyalandı." -ForegroundColor Yellow
    } catch {
        Write-Host "[X] İndirme hatası! Linki veya interneti kontrol edin." -ForegroundColor Red
    }
} else {
    Write-Host "[X] Rust klasörü bulunamadı!" -ForegroundColor Red
}