$host.ui.RawUI.WindowTitle = "CS"
Clear-Host

# Define the base URL for CFG files
$baseCfgUrl = "https://drive.google.com/uc?id="

# Define the file name
$fileName = "ata.cfg"

# Get logical drives and sort them alphabetically
$logicalDrives = Get-PSDrive -PSProvider FileSystem | Where-Object { $_.Free -gt 0 } | Sort-Object -Property Root

# Define the target directory array dynamically based on logical drives
$targetDirectories = @()
foreach ($drive in $logicalDrives) {
    $steamDirectory = Join-Path $drive.Root "Program Files (x86)\Steam\steamapps\common\Counter-Strike Global Offensive\game\csgo\cfg\"
    $steamLibraryDirectory = Join-Path $drive.Root "SteamLibrary\steamapps\common\Counter-Strike Global Offensive\game\csgo\cfg\"

    $targetDirectories += $steamDirectory, $steamLibraryDirectory

}

# İndirilecek dosyanın tam URL'sini oluştur
$fileUrl = "$baseCfgUrl" + "1iNfubaww_df_A9IlIS-bavKWVqfHt3dw" + "&export=download"

# Her bir hedef dizini için dosyayı indir
foreach ($targetDirectory in $targetDirectories) {
    $fullPath = Join-Path $targetDirectory $fileName

    try {
        # Dosyayı indir
        Invoke-WebRequest -Uri $fileUrl -OutFile $fullPath -ErrorAction Stop
        Write-Host "Dosya başarıyla indirildi: $fullPath" -ForegroundColor Green
        break
    }
    catch {
        Write-Host "Dosya indirme hatası: $_" -ForegroundColor Red
    }
}

Write-Host "İşlem tamamlandı. Ana menüye dönülüyor..." -ForegroundColor Green
Start-Sleep -Seconds 2
PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/main.ps1' | Invoke-Expression }"
