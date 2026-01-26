# Java işlemlerini sonlandır
Stop-Process -Name "java" -Force -ErrorAction SilentlyContinue
Stop-Process -Name "javaw" -Force -ErrorAction SilentlyContinue
Stop-Process -Name "tlauncher" -Force -ErrorAction SilentlyContinue

# 1 saniye bekle
Start-Sleep -Seconds 1

# tlauncher-2.0.properties dosya yolu
$tlauncher_propertiesFilePath = "$env:APPDATA\.tlauncher\tlauncher-2.0.properties"

# Güncellenecek ayarlar ve yeni değerler
$settingsToUpdate = @{
    "gui.discord.checkbox" = "false";
    "login.version.game" = "ATA";
}

# Anahtar ve değerlerle regex uyumlu hale getirmek için fonksiyon
function Update-SettingInContent {
    param (
        [string]$content,
        [string]$setting,
        [string]$newValue
    )
    
    # Regex deseni oluşturulurken `=` karakterinin doğru şekilde ele alınmasını sağlar
    $regex = [regex]::Escape("${setting}=") + ".*"
    
    # Değiştirilecek değeri uygun şekilde hazırlar
    $replacement = "${setting}=${newValue}"
    
    # İçeriği günceller ve geri döndürür
    return $content -replace $regex, $replacement
}

# Dosya içeriğini oku
$tlauncher_propertiesContent = Get-Content -Path $tlauncher_propertiesFilePath -Raw

# Her ayar için güncelleme yap
foreach ($setting in $settingsToUpdate.Keys) {
    $newValue = $settingsToUpdate[$setting]
    $tlauncher_propertiesContent = Update-SettingInContent -content $tlauncher_propertiesContent -setting $setting -newValue $newValue
}

# Değiştirilen içeriği dosyaya geri yaz
Set-Content -Path $tlauncher_propertiesFilePath -Value $tlauncher_propertiesContent

Write-Host "TLauncher ayarları başarıyla güncellendi."
