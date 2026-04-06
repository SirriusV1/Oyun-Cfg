param($playerName) # Sadece oyuncu ismini alıyoruz, link içeride sabit.

# --- 1. AYARLAR VE LİNK ---
$GlobalFileId = "1u1Ol1tm9SFPUzOrNjMK0jnnpykIZhklv" # Senin Global CFG Linkin
$fileName = "ata.cfg"
$OutputEncoding = [System.Text.Encoding]::UTF8
$Utf8NoBom = New-Object System.Text.Encoding.UTF8Encoding $false

# --- 2. OYUNCU VERİ TABANI ---
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
    try {
        $wc = New-Object System.Net.WebClient
        $wc.Encoding = [System.Text.Encoding]::UTF8
        $page = $wc.DownloadString("https://steamcommunity.com/profiles/$id")
        if ($page -like '*actual_persona_name*') {
            return ($page -split '<span class="actual_persona_name">' | Select-Object -Last 1 | ForEach-Object { ($_ -split '</span>')[0] }).Trim()
        }
    } catch {} return $null
}

# --- 4. RUST KLASÖRÜ BUL ---
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
        Write-Host "[>] İşlem Başlıyor: $playerName" -ForegroundColor Cyan
        
        # Dosyayı indir
        $url = "https://docs.google.com/uc?export=download&id=$GlobalFileId"
        $cfgContent = Invoke-RestMethod -Uri $url -UseBasicParsing

        # EĞER GLOBAL DEĞİLSE MODİFİYE ET
        if ($playerName -ne "Global") {
            Write-Host "[+] Kişisel bindlar ve ayarlar dikiliyor..." -ForegroundColor Magenta
            
            # Kişisel Ayar (Hassasiyet vb.)
            $pSec = ""
            if ($PersonalConfigs.ContainsKey($playerName)) {
                $pSec = "`n# --- OZEL AYARLAR ---`n"
                foreach ($k in $PersonalConfigs[$playerName].Keys) { $pSec += "$k `"$($PersonalConfigs[$playerName][$k])`"`n" }
            }

            # Dinamik Bindlar
            $binds = "`n# --- DINAMIK BINDLAR ---`n"
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
                    $binds += "bind [$($k.tpr)] $($tprC)chat.add 0 0 `"Teleport $($item.Key)!`"`n"
                    $binds += "bind [$($k.trade)] $($trdC)chat.add 0 0 `"Trade $($item.Key)!`"`n"
                    $binds += "bind [$($k.clan)] $($clnC)chat.add 0 0 `"Invite $($item.Key)!`"`n"
                }
            }

            # Enjeksiyon
            $marker = 'global.writecfg'
            if ($cfgContent.Contains($marker)) {
                $cfgContent = $cfgContent.Replace($marker, ($pSec + $binds + "`n" + $marker))
            } else { $cfgContent += ($pSec + $binds) }

            # İmza Değişimi
            $cfgContent = $cfgContent -replace '~ Global ~', "~ $playerName ~"
        }

        # KAYDET
        $finalPath = Join-Path $foundPath $fileName
        [System.IO.File]::WriteAllText($finalPath, $cfgContent, $Utf8NoBom)

        Write-Host "[✓] Başarıyla yüklendi: $finalPath" -ForegroundColor Green
        Set-Clipboard -Value "exec $fileName"
        Write-Host "[!] Konsola 'exec $fileName' yazın." -ForegroundColor Yellow
    } catch { Write-Host "[X] Hata: $($_.Exception.Message)" -ForegroundColor Red }
} else { Write-Host "[X] Rust bulunamadı!" -ForegroundColor Red }