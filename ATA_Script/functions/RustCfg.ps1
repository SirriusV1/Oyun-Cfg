param($playerName)

Clear-Host
Write-Host "[>] Rust CFG Hazirlaniyor: $playerName" -ForegroundColor Cyan
Write-Host "----------------------------------------------------" -ForegroundColor Gray

# --- 1. RUST KLASÖRÜNÜ BULMA ---
$fileName = "ata.cfg"
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

if (-not $foundPath) {
    Write-Host "[X] Rust klasörü bulunamadı!" -ForegroundColor Red
    return
}

# --- 2. OYUNCU VERİTABANI & AYARLAR ---
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

# --- 3. STEAM'DEN RUMUZ ÇEKME ---
function Get-SteamNick {
    param([string]$targetID)
    if ($targetID.StartsWith("765611980000") -or [string]::IsNullOrWhiteSpace($targetID)) { return $null }
    try {
        $wc = New-Object System.Net.WebClient
        $wc.Encoding = [System.Text.Encoding]::UTF8
        $page = $wc.DownloadString("https://steamcommunity.com/profiles/$targetID")
        if ($page -like '*actual_persona_name*') {
            return ($page -split '<span class="actual_persona_name">' | Select-Object -Last 1 | ForEach-Object { ($_ -split '</span>')[0] }).Trim()
        }
    } catch {} return $null
}

# --- 4. GLOBAL DOSYAYI İNDİRME VE BİRLEŞTİRME ---
try {
    Write-Host "[+] Global Base indiriliyor..." -ForegroundColor Cyan
    # İndirme için doğrudan text'i değişkene alıyoruz
    $globalDriveId = "1u1Ol1tm9SFPUzOrNjMK0jnnpykIZhklv"
    $cfgContent = Invoke-RestMethod -Uri "https://drive.google.com/uc?export=download&id=$globalDriveId" -UseBasicParsing

    # Eğer seçilen "Global" değilse dinamik kişiselleştirmeleri yap
    if ($playerName -ne "Global") {
        
        # Kişisel Ayarları Hazırla
        $personalSection = ""
        if ($PersonalConfigs.ContainsKey($playerName)) {
            $personalSection = "`n# --- $playerName OZEL AYARLARI ---`n"
            $userSettings = $PersonalConfigs[$playerName]
            foreach ($cmd in $userSettings.Keys) {
                $val = $userSettings[$cmd]
                $personalSection += "$cmd `"$val`"`n"
            }
            $personalSection += "# ---------------------------------`n"
        }

        # Kullanıcı Rumuzu Çek
        $userIDs = $PlayerDatabase[$playerName]
        $userRealName = if ($userIDs) { Get-SteamNick -targetID $userIDs[0] } else { $null }
        if (-not $userRealName) { $userRealName = $playerName }

        # Dinamik Bind'leri Hazırla
        $dynamicBinds = "`n# --- DINAMIK ARKADAS LISTESI ---`n"
        foreach ($item in $PlayerDatabase.GetEnumerator() | Sort-Object Name) {
            if ($item.Key -eq $playerName) { continue }
            
            $foundNicks = New-Object System.Collections.Generic.List[string]
            foreach ($id in $item.Value) {
                $live = Get-SteamNick -targetID $id
                if ($live) { $foundNicks.Add($live) }
            }
            if ($foundNicks.Count -eq 0) { $foundNicks.Add($item.Key) }

            $tprCmd = ""; $tradeCmd = ""; $clanCmd = ""
            foreach ($n in $foundNicks) {
                $tprCmd += "chat.teamsay `"/tpr $n`";"; $tradeCmd += "chat.teamsay `"/trade $n`";"
                $clanCmd += "chat.teamsay `"/clan invite $n`";chat.teamsay `"/clan promote $n`";"
            }
            
            $keys = $KeyMap[$item.Key]
            if ($keys) {
                $dynamicBinds += "`n# --- $($item.Key) ---`n"
                $dynamicBinds += "bind [$($keys.tpr)] $($tprCmd)chat.add 0 0 `"Teleport $($item.Key)!`"`n"
                $dynamicBinds += "bind [$($keys.trade)] $($tradeCmd)chat.add 0 0 `"Trade $($item.Key)!`"`n"
                $dynamicBinds += "bind [$($keys.clan)] $($clanCmd)chat.add 0 0 `"Invite $($item.Key)! + Yetkilendir`"`n"
            }
        }

        # Enjeksiyon işlemi (global.writecfg'nin hemen üzerine yazdır)
        $marker = 'global.writecfg'
        $escapedMarker = [Regex]::Escape($marker)
        $regex = New-Object Regex($escapedMarker)
        
        $finalBlock = $personalSection + $dynamicBinds + "`n" + $marker
        $cfgContent = $regex.Replace($cfgContent, $finalBlock, 1)

        # İmzayı Değiştir
        $cfgContent = $cfgContent -replace '~ Global ~', "~ $userRealName ~"
    }

    # --- 5. KAYDETME İŞLEMİ ---
    $savePath = Join-Path $foundPath $fileName
    $cfgContent | Out-File -FilePath $savePath -Encoding utf8 -Force
    
    Write-Host "`n[+] $playerName CFG basariyla olusturuldu ve kaydedildi!" -ForegroundColor Green
    if ($userRealName -and $playerName -ne "Global") { 
        Write-Host "[>] Guncel Steam Ismi: $userRealName" -ForegroundColor White 
    }
    
    Set-Clipboard -Value "exec ata.cfg"
    Write-Host "[!] Konsola 'exec ata.cfg' yazmayi unutma! (Panoya Kopyalandi)" -ForegroundColor Yellow

} catch {
    Write-Host "[X] İndirme/Düzenleme hatası! İnterneti kontrol edin veya Google API sınırını aşmış olabilirsiniz." -ForegroundColor Red
    Write-Error $_
}