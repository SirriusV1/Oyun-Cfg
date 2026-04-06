param($fileId, $playerName)

# --- 1. AYARLAR VE ENCODING ---
$OutputEncoding = [System.Text.Encoding]::UTF8
$Utf8NoBom = New-Object System.Text.Encoding.UTF8Encoding $false

# --- 2. VERİ TABANI (PersonalConfigs Geri Geldi) ---
$PlayerDatabase = @{
    "MFA"     = @("76561198151275292")
    "Burak"   = @("76561198272139799")
    "Cagri"   = @("76561199118365761", "76561198828667093")
    "Bugra"   = @("76561198152140802")
    "Sirrius" = @("76561198325167544") 
    "Emir"    = @("76561198263732430")
    "Arda"    = @("76561198119628226")
}

# Kişisel Grafik/Sistem Ayarları
$PersonalConfigs = @{
    "Sirrius" = @{ "gc.buffer" = "4096"; "input.sensitivity" = "0.5" }
    "Burak"   = @{ "gc.buffer" = "2048"; "graphics.itemskins" = "false" }
}

# Güncel Tuş Maplemesi (1, 2, 3...)
$KeyMap = @{
    "MFA"     = @{ tpr="leftcontrol+m"; trade="leftalt+m"; clan="rightcontrol+m" }
    "Burak"   = @{ tpr="leftcontrol+1"; trade="leftalt+1"; clan="rightcontrol+1" }
    "Cagri"   = @{ tpr="leftcontrol+2"; trade="leftalt+2"; clan="rightcontrol+2" }
    "Bugra"   = @{ tpr="leftcontrol+3"; trade="leftalt+3"; clan="rightcontrol+3" }
    "Sirrius" = @{ tpr="leftcontrol+x"; trade="leftalt+x"; clan="rightcontrol+x" }
    "Emir"    = @{ tpr="leftcontrol+y"; trade="leftalt+y"; clan="rightcontrol+y" }
    "Arda"    = @{ tpr="leftcontrol+q"; trade="leftalt+q"; clan="rightcontrol+q" }
}

# --- 3. FONKSİYONLAR ---
function Get-SteamNick {
    param([string]$id)
    try {
        $wc = New-Object System.Net.WebClient
        $wc.Encoding = [System.Text.Encoding]::UTF8
        $page = $wc.DownloadString("https://steamcommunity.com/profiles/$id")
        if ($page -like '*actual_persona_name*') {
            return ($page -split '<span class="actual_persona_name">' | Select-Object -Last 1 | ForEach-Object { ($_ -split '</span>')[0] }).Trim()
        }
    } catch {} return $null
}

# --- 4. RUST KLASÖRÜ BULMA ---
$fileName = "ata.cfg"
$foundPath = $null
foreach ($drive in (Get-PSDrive -PSProvider FileSystem | Where-Object { $_.Free -gt 0 })) {
    $paths = @("Program Files (x86)\Steam\steamapps\common\Rust\cfg\", "SteamLibrary\steamapps\common\Rust\cfg\", "Steam\steamapps\common\Rust\cfg\")
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
        
        $fileUrl = "https://docs.google.com/uc?export=download&id=$fileId"
        $cfgContent = Invoke-RestMethod -Uri $fileUrl -UseBasicParsing

        if ($playerName -ne "Global") {
            Write-Host "[+] Kişisel ayarlar ve bindlar enjekte ediliyor..." -ForegroundColor Magenta
            
            # --- PersonalConfigs Bölümü ---
            $personalSection = ""
            if ($PersonalConfigs.ContainsKey($playerName)) {
                $personalSection = "`n# --- $playerName OZEL AYARLARI ---`n"
                $uSet = $PersonalConfigs[$playerName]
                foreach ($k in $uSet.Keys) { $personalSection += "$k `"$($uSet[$k])`"`n" }
                $personalSection += "# ---------------------------------`n"
            }

            $uIDs = $PlayerDatabase[$playerName]
            $uRealName = if ($uIDs) { Get-SteamNick -id $uIDs[0] } else { $playerName }
            
            $dynamicBinds = "`n# --- DINAMIK ARKADAS LISTESI ---`n"
            foreach ($item in $PlayerDatabase.GetEnumerator() | Sort-Object Name) {
                if ($item.Key -eq $playerName) { continue }
                $fNicks = New-Object System.Collections.Generic.List[string]
                foreach ($id in $item.Value) { $live = Get-SteamNick -id $id; if ($live) { $fNicks.Add($live) } }
                if ($fNicks.Count -eq 0) { $fNicks.Add($item.Key) }

                $tprC = ""; $trdC = ""; $clnC = ""
                foreach ($n in $fNicks) {
                    $tprC += "chat.teamsay `"/tpr $n`";"; $trdC += "chat.teamsay `"/trade $n`";"
                    $clnC += "chat.teamsay `"/clan invite $n`";chat.teamsay `"/clan promote $n`";"
                }
                $k = $KeyMap[$item.Key]
                if ($k) {
                    $dynamicBinds += "`n# --- $($item.Key) ---`nbind [$($k.tpr)] $($tprC)chat.add 0 0 `"Teleport $($item.Key)!`"`nbind [$($k.trade)] $($trdC)chat.add 0 0 `"Trade $($item.Key)!`"`nbind [$($k.clan)] $($clnC)chat.add 0 0 `"Invite $($item.Key)!`"`n"
                }
            }

            # Enjeksiyon (Hatasız Replace Yöntemi)
            $marker = 'global.writecfg'
            $cfgContent = $cfgContent.Replace($marker, ($personalSection + $dynamicBinds + "`n" + $marker))
            $cfgContent = $cfgContent.Replace('~ Global ~', "~ $uRealName ~")
        }

        # Dosya Kaydetme (UTF-8 No BOM)
        $finalPath = Join-Path $foundPath $fileName
        [System.IO.File]::WriteAllText($finalPath, $cfgContent, $Utf8NoBom)

        Write-Host "[+] Kurulum Tamam: $finalPath" -ForegroundColor Green
        Set-Clipboard -Value "exec $fileName"
        Write-Host "[!] Konsola 'exec $fileName' yazın." -ForegroundColor Yellow
    } catch {
        Write-Host "[X] Hata: $($_.Exception.Message)" -ForegroundColor Red
    }
} else {
    Write-Host "[X] Rust bulunamadı!" -ForegroundColor Red
}