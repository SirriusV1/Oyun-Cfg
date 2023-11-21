# Minecraft.ps1

# Minecraft icin destek verilmedigini belirt
Write-Host "Minecraft icin su an destek verilmemektedir!!."-ForegroundColor Yellow

# Ana PowerShell dosyasina geri don
Start-Sleep -Seconds 3
PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/main.ps1' | Invoke-Expression }"
