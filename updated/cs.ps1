$host.ui.RawUI.WindowTitle = "CS"
Clear-Host

# Define the base URL for CFG files
$baseCfgUrl = "https://drive.google.com/uc?id="

# Define the file name
$fileName = "ata.cfg"

# Define multiple target directories
$targetDirectories = @(
    "C:\Program Files (x86)\Steam\steamapps\common\Counter-Strike Global Offensive\game\csgo\cfg\",
    "C:\SteamLibrary\steamapps\common\Counter-Strike Global Offensive\game\csgo\cfg\",
    "D:\Program Files (x86)\Steam\steamapps\common\Counter-Strike Global Offensive\game\csgo\cfg\",
    "D:\SteamLibrary\steamapps\common\Counter-Strike Global Offensive\game\csgo\cfg\",
    "E:\Program Files (x86)\Steam\steamapps\common\Counter-Strike Global Offensive\game\csgo\cfg\",
    "E:\SteamLibrary\steamapps\common\Counter-Strike Global Offensive\game\csgo\cfg\",
    "F:\Program Files (x86)\Steam\steamapps\common\Counter-Strike Global Offensive\game\csgo\cfg\",
    "F:\SteamLibrary\steamapps\common\Counter-Strike Global Offensive\game\csgo\cfg\"
    # Ek hedef dizinleri burada ekleyebilirsiniz
)

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
