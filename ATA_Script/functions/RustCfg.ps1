param($playerName)

# --- 1. AYARLAR VE LİNK ---
$GlobalFileId = "1u1Ol1tm9SFPUzOrNjMK0jnnpykIZhklv"
$fileName = "ata.cfg"
$Utf8NoBom = New-Object System.Text.Encoding.UTF8Encoding $false

# --- 2. VERİ TABANI ---
$PlayerDatabase = @{
    "MFA"     = @("76561198151275292")
    "Burak"   = @("76561198272139799")
    "Cagri"   = @("76561199118365761", "76561198828667093")
    "Bugra"   = @("76561198152140802")
    "Sirrius" = @("76561198325167544") 
    "Emir"    = @("76561198263732430")
    "Arda"    = @("76561198119628226")
}

$PersonalConfigs = @{
    "Sirrius" = @{ "gc.buffer" = "4096"; "input.sensitivity" = "0.5" }
    "Burak"   = @{ "gc.buffer" = "2048"; "graphics.itemskins" = "false" }
}

$KeyMap = @{
    "MFA"     = @{ tpr="leftcontrol+m"; trade="leftalt+m"; clan="rightcontrol+m" }
    "Burak"   = @{ tpr="leftcontrol+b"; trade="leftalt+b"; clan="rightcontrol+b" }
    "Cagri"   = @{ tpr="leftcontrol+c"; trade="leftalt+c"; clan="rightcontrol+c" }
    "Bugra"   = @{ tpr="leftcontrol+v"; trade="leftalt+v"; clan="rightcontrol+v" }
    "Sirrius" = @{ tpr="leftcontrol+x"; trade="leftalt+x"; clan="rightcontrol+x" }
    "Emir"    = @{ tpr="leftcontrol+y"; trade="leftalt+y"; clan="rightcontrol+y" }
    "Arda"    = @{ tpr="leftcontrol+q"; trade="leftalt+q"; clan="rightcontrol+q" }
}

# --- 3. RUST KLASÖRÜ BUL ---
$foundPath = $null
foreach ($drive in (Get-PSDrive -PSProvider FileSystem | Where-Object { $_.Free -gt 0 })) {
    $paths = @("Program Files (x86)\Steam\steamapps\common\Rust\cfg\", "SteamLibrary\steamapps\common\Rust\cfg\", "Steam\steamapps\common\Rust\cfg\")
    foreach ($p in $paths) {
        $fullDir = Join-Path $drive.Root $p
        if (Test-Path $fullDir) { $foundPath = $fullDir; break }
    }
    if ($foundPath) { break }
}

# --- 4. ANA İŞLEM ---
if ($null -ne $foundPath) {
    try {
        Clear-Host
        Write-Host "[>] İşlem Başlıyor: $playerName" -ForegroundColor Cyan
        
        $url = "https://docs.google.com/uc?export=download&id=$GlobalFileId"
        $cfgContent = Invoke-RestMethod -Uri $url -UseBasicParsing

        # KRİTİK KONTROL: Dosya indi mi?
        if ($null -eq $cfgContent -or $cfgContent -eq "") {
            throw "Dosya indirilemedi veya boş! Linki kontrol et."
        }

        if ($playerName -ne "Global") {
            Write-Host "[+] Özelleştiriliyor..." -ForegroundColor Magenta
            
            # Kişisel Ayarlar Kontrolü
            $pSec = ""
            if ($PersonalConfigs.ContainsKey($playerName)) {
                $pSec = "`n# --- OZEL AYARLAR ---`n"
                $configs = $PersonalConfigs[$playerName]
                if ($null -ne $configs) {
                    foreach ($k in $configs.Keys) { $pSec += "$k `"$($configs[$k])`"`n" }
                }
            }

            # Bindlar Kontrolü
            $binds = "`n# --- DINAMIK BINDLAR ---`n"
            foreach ($item in $PlayerDatabase.GetEnumerator()) {
                if ($item.Key -eq $playerName) { continue }
                
                $k = $KeyMap[$item.Key]
                if ($null -ne $k) {
                    # Nick çekme kısmını hata riskine karşı basitleştirdik
                    $targetNick = $item.Key 
                    $tprC = "chat.teamsay `"/tpr $targetNick`";"
                    $trdC = "chat.teamsay `"/trade $targetNick`";"
                    
                    $binds += "bind [$($k.tpr)] $($tprC)chat.add 0 0 `"Teleport $targetNick!`"`n"
                    $binds += "bind [$($k.trade)] $($trdC)chat.add 0 0 `"Trade $targetNick!`"`n"
                }
            }

            # Enjeksiyon Kontrolü
            $marker = 'global.writecfg'
            if ($cfgContent.Contains($marker)) {
                $cfgContent = $cfgContent.Replace($marker, ($pSec + $binds + "`n" + $marker))
            } else {
                $cfgContent = $cfgContent + "`n" + $pSec + $binds
            }
        }

        # KAYDET
        $finalPath = Join-Path $foundPath $fileName
        [System.IO.File]::WriteAllText($finalPath, $cfgContent, $Utf8NoBom)

        Write-Host "[✓] İşlem Başarılı!" -ForegroundColor Green
        Set-Clipboard -Value "exec $fileName"

    } catch {
        Write-Host "[X] Hata Detayı: $($_.Exception.Message)" -ForegroundColor Red
    }
} else {
    Write-Host "[X] Rust klasörü bulunamadı!" -ForegroundColor Red
}