# Java işlemlerini sonlandır
Stop-Process -Name "java" -Force -ErrorAction SilentlyContinue
Stop-Process -Name "javaw" -Force -ErrorAction SilentlyContinue

# 1 saniye bekle
Start-Sleep -Seconds 1

# options.txt dosya yolu
$optionsFilePath = "$env:APPDATA\.minecraft\versions\ATA\options.txt"

# Güncellenecek anahtar kelimeler ve yeni tuş değerleri
$keysToModify = @{
    "key_tab.bettertab.keybind.toggle_mod" = "key.keyboard.unknown";
    "key_tab.bettertab.keybind.open_config" = "key.keyboard.unknown";
    "key_tab.bettertab.keybind.scroll_right" = "key.keyboard.unknown";
    "key_tab.bettertab.keybind.scroll_left" = "key.keyboard.unknown";
    "key_key.fabrishot.screenshot" = "key.keyboard.f9";
    "key_flashback.keybind.create_marker_1" = "key.keyboard.unknown";
    "key_flashback.keybind.create_marker_2" = "key.keyboard.unknown";
    "key_flashback.keybind.create_marker_3" = "key.keyboard.unknown";
    "key_flashback.keybind.create_marker_4" = "key.keyboard.unknown";
    "key_key.bridgingmod.toggle_bridging" = "key.keyboard.unknown";
    "key_key.commandkeys.main.edit" = "key.keyboard.k";
    "key_key.daycount.day_count" = "key.keyboard.unknown";
    "key_key.entityculling.toggle" = "key.keyboard.unknown";
    "key_key.entityculling.toggleBoxes" = "key.keyboard.unknown";
    "key_key.freecam.toggle" = "key.keyboard.f4";
    "key_key.freecam.playerControl" = "key.keyboard.keypad.4";
    "key_key.freecam.tripodReset" = "key.keyboard.unknown";
    "key_key.freecam.configGui" = "key.keyboard.unknown";
    "key_key.jade.config" = "key.keyboard.unknown";
    "key_key.jade.show_overlay" = "key.keyboard.unknown";
    "key_key.jade.toggle_liquid" = "key.keyboard.unknown";
    "key_key.jade.show_recipes" = "key.keyboard.unknown";
    "key_key.jade.show_uses" = "key.keyboard.unknown";
    "key_key.jade.narrate" = "key.keyboard.unknown";
    "key_key.jade.show_details" = "key.keyboard.unknown";
    "key_key.jade.profile.0" = "key.keyboard.unknown";
    "key_key.jade.profile.1" = "key.keyboard.unknown";
    "key_key.jade.profile.2" = "key.keyboard.unknown";
    "key_key.jade.profile.3" = "key.keyboard.unknown";
    "key_key.journeymap.zoom_in" = "key.keyboard.equal";
    "key_key.journeymap.zoom_out" = "key.keyboard.minus";
    "key_key.journeymap.minimap_type" = "key.keyboard.unknown";
    "key_key.journeymap.minimap_preset" = "key.keyboard.unknown";
    "key_key.journeymap.create_waypoint" = "key.keyboard.b";
    "key_key.journeymap.toggle_render_waypoints" = "key.keyboard.unknown";
    "key_key.journeymap.toggle_render_waypoints_world" = "key.keyboard.unknown";
    "key_key.journeymap.toggle_render_waypoints_map" = "key.keyboard.unknown";
    "key_key.journeymap.toggle_waypoints" = "key.keyboard.unknown";
    "key_key.journeymap.fullscreen_create_waypoint" = "key.keyboard.b";
    "key_key.journeymap.fullscreen_chat_position" = "key.keyboard.c";
    "key_key.journeymap.map_toggle_alt" = "key.keyboard.g";
    "key_key.journeymap.fullscreen_waypoints" = "key.keyboard.n";
    "key_key.journeymap.minimap_toggle_alt" = "key.keyboard.m";
    "key_key.journeymap.fullscreen_options" = "key.keyboard.o";
    "key_key.journeymap.fullscreen.north" = "key.keyboard.up";
    "key_key.journeymap.fullscreen.south" = "key.keyboard.down";
    "key_key.journeymap.fullscreen.east" = "key.keyboard.right";
    "key_key.journeymap.fullscreen.west" = "key.keyboard.left";
    "key_key.journeymap.fullscreen_follow_player" = "key.keyboard.f";
    "key_key.journeymap.fullscreen.disable_buttons" = "key.keyboard.unknown";
    "key_key.journeymap.toggle_entity_names" = "key.keyboard.unknown";
    "key_key.modmenu.open_menu" = "key.keyboard.unknown";
    "key_key.pingwheel.ping_location" = "key.mouse.middle";
    "key_key.pingwheel.open_settings" = "key.keyboard.unknown";
    "key_key.plasmovoice.settings" = "key.keyboard.v";
    "key_soundsbegone.config" = "key.keyboard.unknown";
    "key_key.trade_cycling.cycle_trades" = "key.keyboard.c";
    "key_iris.keybind.reload" = "key.keyboard.home";
    "key_iris.keybind.toggleShaders" = "key.keyboard.pause";
    "key_iris.keybind.shaderPackSelection" = "key.keyboard.scroll.lock";
    "key_iris.keybind.wireframe" = "key.keyboard.unknown";
    "key_lambdynlights.key.toggle_fps_dynamic_lighting" = "key.keyboard.unknown";
    "key_key.smoothCamera" = "key.keyboard.unknown";
    "key_key.fabrishot.screenshot" = "key.keyboard.unknown";
}

# Güncellenecek ayarlar ve yeni değerler
$settingsToUpdate = @{
    "forceUnicodeFont" = "false";
    "enableVsync" = "false";
    "guiScale" = "2";
    "renderDistance" = "12";
    "simulationDistance" = "6";
    "gamma" = "1.0";
    "maxFps" = "0";
    "renderClouds" = "fast";
    "tutorialStep" = "none";
    "skipMultiplayerWarning" = "true";
    "joinedFirstServer" = "true";
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
