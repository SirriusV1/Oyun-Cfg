function Test-PowerShell {
    $isInstalled = $false
    try {
        $version = (Get-Command pwsh -ErrorAction SilentlyContinue).FileVersionInfo.ProductVersion
        if ($version) {
            $isInstalled = $true
        }
    } catch {
        Write-Host "PowerShell yüklü değil." -ForegroundColor Red
    }
    return $isInstalled
}

function Install-PowerShell {
    Write-Host "PowerShell yükleniyor..." -ForegroundColor Yellow
    Start-Process -FilePath "winget" -ArgumentList "install Microsoft.PowerShell" -NoNewWindow -Wait
    Write-Host "PowerShell başarıyla yüklendi." -ForegroundColor Green
}

function Main {
    $isInstalled = Test-PowerShell
    if (-not $isInstalled) {
        Install-PowerShell
    }
}

Main



function Test-PathWithFallback {
    param (
        [string]$fallbackPath,
        [string]$primaryPath
    )
    if (Test-Path -Path $primaryPath) {
        return $primaryPath
    } elseif (Test-Path -Path $fallbackPath) {
        return $fallbackPath
    } else {
        return $null
    }
}

$oneDriveDesktopPath = [System.IO.Path]::Combine($env:USERPROFILE, "OneDrive", "Desktop")
$defaultDesktopPath = [System.IO.Path]::Combine($env:USERPROFILE, "Desktop")
$desktopPath = Test-PathWithFallback -fallbackPath $defaultDesktopPath -primaryPath $oneDriveDesktopPath

$oneDriveDocumentsPath = [System.IO.Path]::Combine($env:USERPROFILE, "OneDrive", "Documents")
$defaultDocumentsPath = [System.IO.Path]::Combine($env:USERPROFILE, "Documents")
$documentsPath = Test-PathWithFallback -fallbackPath $defaultDocumentsPath -primaryPath $oneDriveDocumentsPath

$shortcutName = "ATA Script.lnk"
$shortcutPath = [System.IO.Path]::Combine($desktopPath, $shortcutName)
$iconUrl = "https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/favicon.ico"
$iconPath = [System.IO.Path]::Combine($documentsPath, "favicon.ico")
$oldBatchFilePath = [System.IO.Path]::Combine($desktopPath, "ATA_CFG.bat")

function Get-FileSize {
    param (
        [string]$url
    )
    try {
        $request = [System.Net.HttpWebRequest]::Create($url)
        $request.Method = "HEAD"
        $response = $request.GetResponse()
        $size = $response.Headers["Content-Length"]
        $response.Close()
        return $size
    } catch {
        Write-Error "Dosya boyutu alınırken hata oluştu: $_"
        return $null
    }
}

$githubIconSize = Get-FileSize -url $iconUrl


$localIconSize = if (Test-Path -Path $iconPath) {
    (Get-Item -Path $iconPath).Length
} else {
    0
}

$updateShortcut = $false

if (-Not (Test-Path -Path $shortcutPath)) {
    $updateShortcut = $true
} elseif ($localIconSize -ne $githubIconSize) {
    try {
        Invoke-WebRequest -Uri $iconUrl -OutFile $iconPath -UseBasicP
        $updateShortcut = $true
    } catch {
        Write-Error "Simge dosyasını indirirken hata oluştu: $_"
    }
}

if ($updateShortcut) {
    try {
        $shell = New-Object -ComObject WScript.Shell
        $shortcut = $shell.CreateShortcut($shortcutPath)
        $shortcut.TargetPath = "PowerShell.exe"
        $shortcut.Arguments = "-ExecutionPolicy Bypass -Command `"& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/main.ps1' | Invoke-Expression }`""
        $shortcut.WorkingDirectory = $desktopPath
        $shortcut.Description = "Her Şey Sizin İçin..."
        $shortcut.IconLocation = $iconPath
        $shortcut.Save()
    } catch {
        Write-Error "Kısayolu oluştururken hata oluştu: $_"
    }
}


if (Test-Path -Path $oldBatchFilePath) {
    try {
        Remove-Item -Path $oldBatchFilePath
    } catch {
        Write-Error "Eski .bat dosyasını silerken hata oluştu: $_"
    }
}


$host.ui.RawUI.WindowTitle = "ATA CFG"
Clear-Host

Write-Host "Hangi oyunun CFG dosyasını indirmek istiyorsunuz? "
Write-Host "1. Cs        " -NoNewline
Write-Host "1.0.4 [09.01.2024] " -ForegroundColor DarkYellow
Write-Host "2. Rust      " -NoNewline
Write-Host "1.0.8 [13.08.2024]" -ForegroundColor Green
Write-Host "3. Minecraft " -NoNewline
Write-Host "1.21 Geldi Geldi" -ForegroundColor Green
Write-Host "4. Pubg "
Write-Host "5. Pc Ayar "
Write-Host "6. Discord"
$sec = "(1-6)"
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
            Write-Host "[" -NoNewline -ForegroundColor Green
            Write-Host " Güncellemeler belirsiz bir tarihe kadar duraklatılmıştır. " -NoNewline -ForegroundColor Red
            Write-Host "]" -ForegroundColor Green
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
    6 {
        while ($true) {
            clear-host
            $host.ui.RawUI.WindowTitle = "Discord Menü"
            Write-Host "        ╔════════════════╗"  -ForegroundColor Blue
            Write-Host "        ║  Discord Menü  ║"  -ForegroundColor Blue
            Write-Host "        ╚════════════════╝"  -ForegroundColor Blue
            Write-Host ""
            Write-Host "1. Otomatik Ayar" -ForegroundColor Green
            Write-Host "2. Discord 10"
            Write-Host "3. Geri Dön" -ForegroundColor Cyan
            $subSecim = Read-Host "Lütfen bir numara girin (1-3)"

            switch ($subSecim) {
                1 {
                    Start-Process "discord://"
                    Sleep -Milliseconds 1000
                    Start-Process powershell.exe -Verb RunAs -ArgumentList "-Command `$TaskService = New-Object -ComObject 'Schedule.Service'; `$TaskService.Connect(); `$RootFolder = `$TaskService.GetFolder('\'); `$RootFolder.CreateFolder('Siri')"
                    Sleep -Milliseconds 200
                    PowerShell -Command "Start-Process PowerShell -ArgumentList '-ExecutionPolicy Bypass -Command ""Invoke-RestMethod -Uri ''https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/dc+.ps1'' | Invoke-Expression""' "
                    Start-Sleep -seconds 5
                    Start-Process PowerShell.exe -ArgumentList '-NoProfile -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri ''https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/discord.ps1'' | Invoke-Expression }"'
                    Start-Sleep -seconds 5
                    Stop-Process -Name "Discord" -Force
                    Start-Sleep -seconds 1
                    Start-Process "discord://channels/148419527825162240/148419527825162240"
                    Clear-Host
                    Start-Sleep -seconds 5
                    Write-Host "Hallettim." -ForegroundColor Green
                    Clear-Host
                    break
                }
                2 {
                    Start-Process "discord://"
                    Write-Host "Sakin ol hallediyorum.." -ForegroundColor Yellow
                    Start-Sleep -Seconds 5
                    Start-Process PowerShell.exe -ArgumentList '-NoProfile -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri ''https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/discord.ps1'' | Invoke-Expression }" > $null 2> $null' -Verb RunAs
                    Start-Sleep -seconds 5
                    Stop-Process -Name "Discord" -Force
                    Start-Sleep -seconds 1
                    Start-Process "discord://channels/148419527825162240/148419527825162240"
                    Clear-Host
                    Start-Sleep -seconds 5
                    Write-Host "Hallettim." -ForegroundColor Green
                    Clear-Host
                    break
                }
                3 {
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
        Write-Host "Geçersiz bir seçim yaptınız. Lütfen 1-5 arasında bir numara girin." -ForegroundColor Red
        Start-Sleep -Seconds 1
        PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/main.ps1' | Invoke-Expression }"
    }
}