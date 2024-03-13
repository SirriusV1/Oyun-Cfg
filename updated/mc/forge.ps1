
$host.ui.RawUI.WindowTitle = "Forge Yükleniyor..."
Clear-Host

# Zip dosyasının indirileceği URL
$zipUrl = "https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/mc/Forge.zip"

# Hedef klasör
$minecraftFolder = "$env:USERPROFILE\AppData\Roaming\.minecraft"

# Dosya adı
$fileName = "Forge.zip"

# İndirme işlemi
$webClient = New-Object System.Net.WebClient
$webClient.DownloadFile($zipUrl, "$minecraftFolder\$fileName")

# Zip dosyasını çıkart
Add-Type -AssemblyName System.IO.Compression.FileSystem
$zipFile = [System.IO.Compression.ZipFile]::OpenRead("$minecraftFolder\$fileName")
foreach ($entry in $zipFile.Entries) {
    $entryPath = Join-Path $minecraftFolder $entry.FullName
    if (-not (Test-Path $entryPath)) {
        $null = [System.IO.Directory]::CreateDirectory([System.IO.Path]::GetDirectoryName($entryPath))
        $fileStream = [System.IO.File]::Create($entryPath)
        $entry.Open().CopyTo($fileStream)
        $fileStream.Close()
    }
}

# "versions" klasörünü hedef klasöre taşı
if (Test-Path "$minecraftFolder\versions" -PathType Container) {
    Move-Item -Path "$minecraftFolder\versions\*" -Destination $minecraftFolder -Force
}

# Zip dosyasını sil
Remove-Item "$minecraftFolder\$fileName" -Force

Write-Host "Forge başarıyla yüklendi." -ForegroundColor Cyan

Start-Sleep -Seconds 1
PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/minecraft.ps1' | Invoke-Expression }"

Read-Host "Devam etmek için bir tuşa basın..."