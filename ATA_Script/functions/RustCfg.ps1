param($fileId, $playerName)

# --- 1. KARAKTER KODLAMA AYARLARI (Encoding Fix) ---
$OutputEncoding = [System.Text.Encoding]::UTF8
$Utf8NoBom = New-Object System.Text.Encoding.UTF8Encoding $false
$wc = New-Object System.Net.WebClient
$wc.Encoding = [System.Text.Encoding]::UTF8

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
    param([string]$id)
    if ($id.StartsWith("765611980000") -or [string]::IsNullOrWhiteSpace($id)) { return $null }
    try {
        $page = $wc.DownloadString("https://steamcommunity.com/profiles/$id")
        if ($page -like '*actual_persona_name*') {
            return ($page -split '<span class="actual_persona_name">' | Select-Object -Last 1 | ForEach-Object { ($_ -split '</span>')[0] }).Trim()
        }
    } catch {} return $null
}

# --- 4. BAŞLANGIÇ VE TARAMA ---
Clear-Host
Write-Host "[>] Rust CFG Hazırlanıyor: $playerName" -ForegroundColor Cyan
Write-Host "----------------------------------------------------" -ForegroundColor Gray

$fileName = "ata.cfg"
$logicalDrives = Get-PSDrive -PSProvider FileSystem | Where-Object { $_.Free -gt 0 }
$foundPath = $null

foreach ($drive in $logicalDrives) {
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
        # Global Dosyayı İndir (Encoding korumalı)
        $fileUrl = "https://docs.google.com/uc?export=download&id=$fileId"
        $cfgContent = $wc.DownloadString($fileUrl)

        if ($playerName -ne "Global") {
            Write-Host "[+] Kişisel ayarlar ve bindlar işleniyor..." -ForegroundColor Magenta
            
            # Özel Ayarlar
            $personalSection = ""
            if ($PersonalConfigs.ContainsKey($playerName)) {
                $personalSection = "`n# --- $playerName OZEL AYARLARI ---`n"
                $uSet = $PersonalConfigs[$playerName]
                foreach ($k in $uSet.Keys) { $personalSection += "$k `"$($uSet[$k])`"`n" }
                $personalSection += "# ---------------------------------`n"
            }

            # Kullanıcı Bilgisi
            $uIDs = $PlayerDatabase[$playerName]
            $uRealName = if ($uIDs) { Get-SteamNick -id $uIDs[0] } else { $playerName }
            if (-not $uRealName) { $uRealName = $playerName }

            # Dinamik Bindlar
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

            # Enjeksiyon
            $marker = 'global.writecfg'
            if ($cfgContent -match $marker) {
                $regex = New-Object Regex([Regex]::Escape($marker))
                $cfgContent = $regex.Replace($cfgContent, ($personalSection + $dynamicBinds + "`n" + $marker), 1)
            }
            
            # İmza Değişimi
            $cfgContent = $cfgContent -replace '~ Global ~', "~ $uRealName ~"
        }

        # --- GÜVENLİ KAYIT (UTF-8 No BOM) ---
        $finalPath = Join-Path $foundPath $fileName
        [System.IO.File]::WriteAllText($finalPath, $cfgContent, $Utf8NoBom)

        Write-Host "[+] $playerName için $fileName başarıyla kuruldu!" -ForegroundColor Green
        Set-Clipboard -Value "exec $fileName"
        Write-Host "----------------------------------------------------" -ForegroundColor Gray
        Write-Host "[!] Konsola 'exec $fileName' yazmayı unutma!" -ForegroundColor Yellow
        Write-Host "[*] Komut panoya kopyalandı." -ForegroundColor Cyan

    } catch {
        Write-Host "[X] Hata: $($_.Exception.Message)" -ForegroundColor Red
    }
} else {
    Write-Host "[X] Rust klasörü bulunamadı!" -ForegroundColor Red
}