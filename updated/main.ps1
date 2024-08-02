# Kullanıcı masaüstü yolunu belirleyin
$oneDriveDesktopPath = [System.IO.Path]::Combine($env:USERPROFILE, "OneDrive", "Desktop")
$defaultDesktopPath = [System.IO.Path]::Combine($env:USERPROFILE, "Desktop")
$desktopPath = if (Test-Path -Path $oneDriveDesktopPath) { $oneDriveDesktopPath } else { $defaultDesktopPath }

# Kullanıcı belgelerim yolunu belirleyin
$oneDriveDocumentsPath = [System.IO.Path]::Combine($env:USERPROFILE, "OneDrive", "Documents")
$defaultDocumentsPath = [System.IO.Path]::Combine($env:USERPROFILE, "Documents")
$documentsPath = if (Test-Path -Path $oneDriveDocumentsPath) { $oneDriveDocumentsPath } else { $defaultDocumentsPath }

# Kısayol ve simge dosyasının yolu
$shortcutName = "ATA Script.lnk"
$shortcutPath = [System.IO.Path]::Combine($desktopPath, $shortcutName)
$iconUrl = "https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/favicon.ico"
$iconPath = [System.IO.Path]::Combine($documentsPath, "favicon.ico")
$oldBatchFilePath = [System.IO.Path]::Combine($desktopPath, "ATA_CFG.bat")

# GitHub'daki favicon.ico'nun boyutunu al
function Get-FileSize {
    param (
        [string]$url
    )
    $request = [System.Net.HttpWebRequest]::Create($url)
    $request.Method = "HEAD"
    $response = $request.GetResponse()
    $size = $response.Headers["Content-Length"]
    $response.Close()
    return $size
}

$githubIconSize = Get-FileSize -url $iconUrl

# Mevcut simge dosyasının boyutunu kontrol et
$localIconSize = if (Test-Path -Path $iconPath) {
    (Get-Item -Path $iconPath).Length
} else {
    0
}

# Kısayolu kontrol edin ve gerekiyorsa oluşturun
$updateShortcut = $false

if (-Not (Test-Path -Path $shortcutPath)) {
    $updateShortcut = $true
} elseif ($localIconSize -ne $githubIconSize) {
    # Favicon.ico'yu GitHub'dan indirin
    Invoke-WebRequest -Uri $iconUrl -OutFile $iconPath
    $updateShortcut = $true
}

# Eğer kısayol güncellenmeli veya yeni oluşturulmalıysa
if ($updateShortcut) {
    # WScript.Shell COM nesnesini oluşturun
    $shell = New-Object -ComObject WScript.Shell
    $shortcut = $shell.CreateShortcut($shortcutPath)
    $shortcut.TargetPath = "PowerShell.exe"
    $shortcut.Arguments = "-ExecutionPolicy Bypass -Command `"& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/main.ps1' | Invoke-Expression }`""
    $shortcut.WorkingDirectory = $desktopPath
    $shortcut.Description = "Her Şey Sizin İçin..."
    $shortcut.IconLocation = $iconPath
    $shortcut.Save()
}

# Masaüstündeki eski .bat dosyasını silin, varsa
if (Test-Path -Path $oldBatchFilePath) {
    Remove-Item -Path $oldBatchFilePath
}






$host.ui.RawUI.WindowTitle = "ATA CFG"
Clear-Host

Write-Host "Hangi oyunun CFG dosyasını indirmek istiyorsunuz? "
Write-Host "1. Cs        " -NoNewline
Write-Host "1.0.4 [09.01.2024]" -ForegroundColor Green
Write-Host "2. Rust      " -NoNewline
Write-Host "1.0.6 [21.02.2024]" -ForegroundColor Green
Write-Host "3. Minecraft " -NoNewline
Write-Host "1.20.1" -ForegroundColor Green
Write-Host "4. Pubg "
Write-Host "5. Pc Ayar "
$sec = "(1-5)"
$secim = Read-Host "Lütfen bir numara girin $sec"


switch ($secim) {
    1 {
        while ($true) {
            clear-host
            $host.ui.RawUI.WindowTitle = "CS Menü"
            Write-Host "        ╔═══════════╗"  -ForegroundColor Blue
            Write-Host "        ║  CS Menü  ║"  -ForegroundColor Blue
            Write-Host "        ╚═══════════╝"  -ForegroundColor Blue
            Write-Host ""
            Write-Host "1. Başlatma Seçenekleri "
            Write-Host "2. CFG İndir "
            Write-Host "3. Bind Komutları"
            Write-Host "4. Geri Dön" -ForegroundColor Cyan
            $subSecim = Read-Host "Lütfen bir numara girin (1-4)"

            switch ($subSecim) {
                1 {
                    $launchoptions = "-high -novid -tickrate 128 +exec ata.cfg"
                    Set-Clipboard -Value $launchoptions
                    Set-Clipboard -Value $launchoptions
                    Write-Host "Başlatma Seçenekleri panoya kopyalandı." -ForegroundColor Green
                    Start-Sleep -Seconds 1
                    Write-Host "Steam Kütüphane Açılıyor." -ForegroundColor Cyan
                    Start-Sleep -Seconds 1
                    Start-Process steam://open/library
                    Start-Sleep -Seconds 1
                    break
                }
                2 {
                    PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/cs.ps1' | Invoke-Expression }"
                }
                3 {
                    Start-Process "https://github.com/SirriusV1/Oyun-Cfg/blob/main/Counter-Strike%20Global%20Offensive%20(CSGO)/README.md"
                }
                4 {
                    PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/main.ps1' | Invoke-Expression }"
                }
                default {
                    Write-Host "Geçersiz bir seçim yaptınız. Lütfen 1-4 arasında bir numara girin." -ForegroundColor Red
                    Start-Sleep -Seconds 1
                    break
                }
            }
        }
    }

    2 {
        while ($true) {
            clear-host
            $host.ui.RawUI.WindowTitle = "Rust Menü"
            Write-Host "        ╔═══════════╗"  -ForegroundColor DarkYellow
            Write-Host "        ║ Rust Menü ║"  -ForegroundColor DarkYellow
            Write-Host "        ╚═══════════╝"  -ForegroundColor DarkYellow
            Write-Host ""
            Write-Host "1. Başlatma Seçenekleri "
            Write-Host "2. CFG İndir "
            Write-Host "3. Bind Komutları"
            Write-Host "4. Geri Dön" -ForegroundColor Cyan
            $subSecim = Read-Host "Lütfen bir numara girin (1-4)"

            switch ($subSecim) {
                1 {
                    $launchoptions = "-malloc=system -USEALLAVAILABLECORES -system.cpu_priority high -gc.incremental_milliseconds 1 -effects.maxgibs -1 -physics.steps 60 -graphics.waves false"
                    Set-Clipboard -Value $launchoptions
                    Set-Clipboard -Value $launchoptions
                    Write-Host "Başlatma Seçenekleri panoya kopyalandı." -ForegroundColor Green
                    Start-Sleep -Seconds 1
                    Write-Host "Steam Kütüphane Açılıyor." -ForegroundColor Cyan
                    Start-Sleep -Seconds 1
                    Start-Process steam://open/library
                    Start-Sleep -Seconds 1
                    break
                }
                2 {
                    PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/rust.ps1' | Invoke-Expression }"
                }
                3{
                    Start-Process "https://github.com/SirriusV1/Oyun-Cfg/blob/main/Rust/README.md"
                }
                4{
                    PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/main.ps1' | Invoke-Expression }"
                }
                default {
                    Write-Host "Geçersiz bir seçim yaptınız. Lütfen 1-4 arasında bir numara girin." -ForegroundColor Red
                    Start-Sleep -Seconds 1
                    break
                }
            }
        }
        
    }
    3 {
        PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/minecraft.ps1' | Invoke-Expression }"
    }
    4 {
        while ($true) {
            clear-host
            $host.ui.RawUI.WindowTitle = "Pubg Menü"
            Write-Host "1. Başlatma Seçenekleri "
            Write-Host "2. CFG İndir "
            Write-Host "3. Geri Dön" -ForegroundColor Cyan
            $subSecim = Read-Host "Lütfen bir numara girin (1-3)"

            switch ($subSecim) {
                1 {
                    $launchoptions = "-USEALLAVAILABLECORES -malloc=system -KoreanRating"
                    Set-Clipboard -Value $launchoptions
                    Set-Clipboard -Value $launchoptions
                    Write-Host "Başlatma Seçenekleri panoya kopyalandı." -ForegroundColor Green
                    Start-Sleep -Seconds 1
                    Write-Host "Steam Kütüphane Açılıyor." -ForegroundColor Cyan
                    Start-Sleep -Seconds 1
                    Start-Process steam://open/library
                    Start-Sleep -Seconds 1
                    break
                }
                2 {
                    PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/pubg.ps1' | Invoke-Expression }"
                }
                3{
                    PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/main.ps1' | Invoke-Expression }"
                }
                default {
                    Write-Host "Geçersiz bir seçim yaptınız. Lütfen 1-3 arasında bir numara girin." -ForegroundColor Red
                    Start-Sleep -Seconds 1
                    break
                }
            }
        }
        
    }
    5 {
        while ($true) {
            clear-host
            $host.ui.RawUI.WindowTitle = "Pc Menü"
            Write-Host "        ╔═══════════╗"  -ForegroundColor Blue
            Write-Host "        ║  Pc Menü  ║"  -ForegroundColor Blue
            Write-Host "        ╚═══════════╝"  -ForegroundColor Blue
            Write-Host ""
            Write-Host "1. Chris Titus Tech's Windows Utility "
            Write-Host "2. C++ All-in-One + Java 8 "
            Write-Host "3. Nvidia Ayarları "
            Write-Host "4. Geri Dön" -ForegroundColor Cyan
            $subSecim = Read-Host "Lütfen bir numara girin (1-4)"

            switch ($subSecim) {
                1 {
                    powershell -Command "Start-Process PowerShell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -Command irm https://christitus.com/win | iex' -Verb RunAs"
                    break
                }
                2 {
                    Start-Process PowerShell.exe -ArgumentList '-NoProfile -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri ''https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/c++.ps1'' | Invoke-Expression }"' -Verb RunAs
                }
                3 {
                    Start-Process "discord://discord.com/channels/148419527825162240/1118943418421362839/1118945575040192614"
                    Start-Sleep -Milliseconds 500
                    Clear-Host
                }
                4 {
                    PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/main.ps1' | Invoke-Expression }"
                }
                default {
                    Write-Host "Geçersiz bir seçim yaptınız. Lütfen 1-4 arasında bir numara girin." -ForegroundColor Red
                    Start-Sleep -Seconds 1
                    break
                }
            }
        }
    }
    default {
        Write-Host "Geçersiz bir seçim yaptınız. Lütfen 1-5 arasinda bir numara girin." -ForegroundColor Red
        Start-Sleep -Seconds 1
        PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/main.ps1' | Invoke-Expression }"
    }
}
