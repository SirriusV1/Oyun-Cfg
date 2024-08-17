# Java işlemlerini sonlandır
Stop-Process -Name "java" -Force -ErrorAction SilentlyContinue
Stop-Process -Name "javaw" -Force -ErrorAction SilentlyContinue

# 1 saniye bekle
Start-Sleep -Seconds 1

# options.txt dosya yolu
$optionsFilePath = "$env:APPDATA\.minecraft\options.txt"

# Güncellenecek anahtar kelimeler ve yeni tuş değerleri
$keysToModify = @{
    "key_key.journeymap.zoom_in" = "key.keyboard.keypad.add";
    "key_key.journeymap.zoom_out" = "key.keyboard.keypad.subtract";
    "key_key.journeymap.minimap_type" = "key.keyboard.unknown";
    "key_key.journeymap.minimap_preset" = "key.keyboard.backslash";
    "key_key.journeymap.create_waypoint" = "key.keyboard.unknown";
    "key_key.journeymap.toggle_waypoints" = "key.keyboard.unknown";
    "key_key.journeymap.fullscreen_create_waypoint" = "key.keyboard.unknown";
    "key_key.journeymap.fullscreen_chat_position" = "key.keyboard.unknown";
    "key_key.journeymap.map_toggle_alt" = "key.keyboard.g";
    "key_key.journeymap.fullscreen_waypoints" = "key.keyboard.unknown";
    "key_key.journeymap.minimap_toggle_alt" = "key.keyboard.n";
    "key_key.journeymap.fullscreen_options" = "key.keyboard.unknown";
    "key_key.journeymap.fullscreen.north" = "key.keyboard.up";
    "key_key.journeymap.fullscreen.south" = "key.keyboard.down";
    "key_key.journeymap.fullscreen.east" = "key.keyboard.right";
    "key_key.journeymap.fullscreen.west" = "key.keyboard.left";
    "key_key.journeymap.fullscreen_follow_player" = "key.keyboard.unknown";
    "key_key.journeymap.fullscreen.disable_buttons" = "key.keyboard.unknown";
    "key_key.journeymap.toggle_entity_names" = "key.keyboard.unknown";
    "key_key.cavedust.toggle" = "key.keyboard.unknown";
    "key_key.cavedust.reload" = "key.keyboard.unknown";
    "key_key.jade.config" = "key.keyboard.unknown";
    "key_key.jade.show_overlay" = "key.keyboard.unknown";
    "key_key.jade.toggle_liquid" = "key.keyboard.unknown";
    "key_key.jade.show_recipes" = "key.keyboard.unknown";
    "key_key.jade.show_uses" = "key.keyboard.unknown";
    "key_key.jade.narrate" = "key.keyboard.unknown";
    "key_iris.keybind.reload" = "key.keyboard.unknown";
    "key_iris.keybind.toggleShaders" = "key.keyboard.k";
    "key_iris.keybind.shaderPackSelection" = "key.keyboard.0";
    "key_iris.keybind.wireframe" = "key.keyboard.unknown";
}

# Güncellenecek ayarlar ve yeni değerler
$settingsToUpdate = @{
    "forceUnicodeFont" = "true";
    "enableVsync" = "false";
    "guiScale" = "2";
    "renderDistance" = "12";
    "simulationDistance" = "6";
    "gamma" = "1.0";
    "maxFps" = "260";
    "renderClouds" = "fast";
    "showSubtitles" = "true";
    "bobView" = "false";
    "resourcePacks" = '["vanilla","fabric","visualoverhaul:rounddiscs","minecraft:supporteatinganimation","presencefootsteps:default_sound_pack","programmer_art","visualoverhaul:coloredwaterbucket","visualoverhaul:nobrewingbottles","file/ATA.zip","visualoverhaul:fancyfurnace","file/xalis Enhanced Vanilla.zip"]';
    "tutorialStep" = "none";
    "skipMultiplayerWarning" = "true";
    "joinedFirstServer" = "true";
    "soundCategory_master" = "1.0";
    "soundCategory_music" = "0.0";
    "soundCategory_hostile" = "0.0";
}

# Anahtar ve değerlerle regex uyumlu hale getirmek için fonksiyon
function Update-SettingInContent {
    param (
        [string]$content,
        [string]$setting,
        [string]$newValue
    )
    
    # Regex deseni oluşturulurken `:` karakterinin doğru şekilde ele alınmasını sağlar
    $regex = [regex]::Escape("${setting}:") + "\s*.*"
    
    # Değiştirilecek değeri uygun şekilde hazırlar
    $replacement = "${setting}:${newValue}" # Burada aradaki boşluğu kaldırdık
    
    # İçeriği günceller ve geri döndürür
    return $content -replace $regex, $replacement
}

# Dosya içeriğini oku
$optionsContent = Get-Content -Path $optionsFilePath -Raw

# Her anahtar kelime için güncelleme yap
foreach ($key in $keysToModify.Keys) {
    $newKeyValue = $keysToModify[$key]
    $optionsContent = Update-SettingInContent -content $optionsContent -setting $key -newValue $newKeyValue
}

# Her ayar için güncelleme yap
foreach ($setting in $settingsToUpdate.Keys) {
    $newValue = $settingsToUpdate[$setting]
    $optionsContent = Update-SettingInContent -content $optionsContent -setting $setting -newValue $newValue
}

# Değiştirilen içeriği dosyaya geri yaz
Set-Content -Path $optionsFilePath -Value $optionsContent

Write-Host "Tüm anahtarlar ve ayarlar başarıyla güncellendi."
pwsh.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/mc/settings.ps1' | Invoke-Expression }"