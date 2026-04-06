param($fileId, $playerName)

# --- 1. UTF-8 VE AYARLAR ---
$OutputEncoding = [System.Text.Encoding]::UTF8
$Utf8NoBom = New-Object System.Text.Encoding.UTF8Encoding $false

# --- 2. VERİ TABANI ---
$PlayerDatabase = @{
    "MFA"       = @("76561198151275292")
    "Burak"     = @("76561198272139799")
    "Cagri"     = @("76561199118365761", "76561198828667093")
    "Bugra"     = @("76561198152140802")
    "Sirrius"   = @("76561198325167544") 
    "Emir"      = @("76561198263732430")
    "Arda"      = @("76561198119628226")
}

$PersonalConfigs = @{
    "Sirrius"   = @{ "gc.buffer" = "4096"; "input.sensitivity" = "0.5" }
    "Burak"     = @{ "gc.buffer" = "2048"; "graphics.itemskins" = "false" }
}

$KeyMap = @{
    "MFA"       = @{ tpr="leftcontrol+m"; trade="leftalt+m"; clan="rightcontrol+m" }
    "Burak"     = @{ tpr="leftcontrol+b"; trade="leftalt+b"; clan="rightcontrol+b" }
    "Cagri"     = @{ tpr="leftcontrol+c"; trade="leftalt+c"; clan="rightcontrol+c" }
    "Bugra"     = @{ tpr="leftcontrol+v"; trade="leftalt+v"; clan="rightcontrol+v" }
    "Sirrius"   = @{ tpr="leftcontrol+x"; trade="leftalt+x"; clan="rightcontrol+x" }
    "Emir"      = @{ tpr="leftcontrol+y"; trade="leftalt+y"; clan="rightcontrol+y" }
    "Arda"      = @{ tpr="leftcontrol+q"; trade="leftalt+q"; clan="rightcontrol+q" }
}

# --- 3. YARDIMCI FONKSİYONLAR ---
function Get-SteamNick {
    param([string]$targetID)
    try {
        $wc = New-Object System.Net.WebClient
        $wc.Encoding = [System.Text.Encoding]::UTF8
        $page = $wc.DownloadString("https://steamcommunity.com/profiles/$targetID")
        if ($page -like '*actual_persona_name*') {
            return ($page -split '<span class="actual_persona_name">' | Select-Object -Last 1 | ForEach-Object { ($_ -split '</span>')[0] }).Trim()
        }
    } catch {} return $null
}

# --- 4. RUST KLASÖRÜNÜ BUL ---
$fileName = "ata.cfg"
$foundPath = $null
$logicalDrives = Get-PSDrive -PSProvider FileSystem | Where-Object { $_.Free -gt 0 }

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

# --- 5. ANA İŞLEM ---
if ($foundPath) {
    try {
        Clear-Host
        Write-Host "[>] Rust CFG Hazırlanıyor: $playerName" -ForegroundColor Cyan
        Write-Host "----------------------------------------------------" -ForegroundColor Gray

        # 1. Base CFG İndir (Google Drive üzerinden)
        $fileUrl = "https://docs.google.com/uc?export=download&id=$fileId"
        $cfgContent = Invoke-RestMethod -Uri $fileUrl -UseBasicParsing

        if ($playerName -ne "Global") {
            Write-Host "[+] Kişisel ayarlar ve bindlar enjekte ediliyor..." -ForegroundColor Magenta

            # Kişisel Ayarlar (Sensitivity vb.)
            $personalSection = ""
            if ($PersonalConfigs.ContainsKey($playerName)) {
                $personalSection = "`n# --- $playerName OZEL AYARLARI ---`n"
                $uSet = $PersonalConfigs[$playerName]
                foreach ($k in $uSet.Keys) { $personalSection += "$k `"$($uSet[$k])`"`n" }
                $personalSection += "# ---------------------------------`n"
            }

            # Kullanıcı Gerçek Adı (Steam'den)
            $uIDs = $PlayerDatabase[$playerName]
            $uRealName = if ($uIDs) { Get-SteamNick -targetID $uIDs[0] } else { $playerName }
            if (-not $uRealName) { $uRealName = $playerName }

            # Dinamik Arkadaş Bindları
            $dynamicBinds = "`n# --- DINAMIK ARKADAS LISTESI ---`n"
            foreach ($item in $PlayerDatabase.GetEnumerator() | Sort-Object Name) {
                if ($item.Key -eq $playerName) { continue }
                
                $fNicks = New-Object System.Collections.Generic.List[string]
                foreach ($id in $item.Value) { $live = Get-SteamNick -targetID $id; if ($live) { $fNicks.Add($live) } }
                if ($fNicks.Count -eq 0) { $fNicks.Add($item.Key) }

                $tprC = ""; $trdC = ""; $clnC = ""
                foreach ($n in $fNicks) {
                    $tprC += "chat.teamsay `"/tpr $n`";"; $trdC += "chat.teamsay `"/trade $n`";"
                    $clnC += "chat.teamsay `"/clan invite $n`";chat.teamsay `"/clan promote $n`";"
                }

                $k = $KeyMap[$item.Key]
                if ($k) {
                    $dynamicBinds += "`n# --- $($item.Key) ---`n"
                    $dynamicBinds += "bind [$($k.tpr)] $($tprC)chat.add 0 0 `"Teleport $($item.Key)!`"`n"
                    $dynamicBinds += "bind [$($k.trade)] $($trdC)chat.add 0 0 `"Trade $($item.Key)!`"`n"
                    $dynamicBinds += "bind [$($k.clan)] $($clnC)chat.add 0 0 `"Invite $($item.Key)!`"`n"
                }
            }

            # Enjeksiyon (marker: global.writecfg)
            $marker = 'global.writecfg'
            if ($cfgContent -contains $marker -or $cfgContent.Contains($marker)) {
                $cfgContent = $cfgContent.Replace($marker, ($personalSection + $dynamicBinds + "`n" + $marker))
            } else {
                # Marker bulunamazsa en sona ekle
                $cfgContent += ($personalSection + $dynamicBinds)
            }

            # İmzayı Güncelle
            $cfgContent = $cfgContent -replace '~ Global ~', "~ $uRealName ~"
        }

        # --- DOSYAYI KAYDET ---
        $finalPath = Join-Path $foundPath $fileName
        # UTF-8 No BOM (Rust için en güvenli kayıt yöntemi)
        [System.IO.File]::WriteAllText($finalPath, $cfgContent, $Utf8NoBom)

        Write-Host "[✓] $playerName için CFG başarıyla kuruldu!" -ForegroundColor Green
        Write-Host "[>] Konum: $finalPath" -ForegroundColor Gray
        
        Set-Clipboard -Value "exec $fileName"
        Write-Host "----------------------------------------------------" -ForegroundColor Gray
        Write-Host "[!] Konsola 'exec $fileName' yazmayı unutma!" -ForegroundColor Yellow
        Write-Host "[*] Komut panoya kopyalandı." -ForegroundColor Cyan

    } catch {
        Write-Host "[X] Hata oluştu: $($_.Exception.Message)" -ForegroundColor Red
    }
} else {
    Write-Host "[X] Rust CFG klasörü bulunamadı! Lütfen oyunu bir kez çalıştırın." -ForegroundColor Red
}