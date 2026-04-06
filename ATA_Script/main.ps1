# 1. UTF-8 VE KÜTÜPHANE AYARLARI
[Console]::InputEncoding = [System.Text.Encoding]::UTF8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8
chcp 65001 | Out-Null

Add-Type -AssemblyName PresentationFramework, PresentationCore, WindowsBase, System.Windows.Forms

# --- GITHUB AYARLARI ---
$GitHubUser = "SirriusV1"
$GitHubRepo = "Oyun-Cfg"
$BaseUrl = "https://raw.githubusercontent.com/$GitHubUser/$GitHubRepo/refs/heads/main/ATA_Script/functions"

# --- TARİH RENK SİSTEMİ ---
function Get-DateColor ([string]$dateStr) {
    if ([string]::IsNullOrWhiteSpace($dateStr)) { return "#444" }
    try {
        $targetDate = [datetime]::ParseExact($dateStr, "dd.MM.yyyy", $null)
        $diff = (Get-Date) - $targetDate
        if ($diff.Days -lt 180) { return "#27ae60" } 
        if ($diff.Days -lt 365) { return "#f1c40f" } 
        return "#e74c3c"
    } catch { return "#555" }
}
$csDate = "09.01.2024" ; $rustDate = "13.08.2024"
$csC = Get-DateColor $csDate ; $rustC = Get-DateColor $rustDate

# --- XAML ARAYÜZ TASARIMI  ---
$XAML_Raw = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="ATA Script" Height="600" Width="480" Background="Transparent" 
        WindowStartupLocation="CenterScreen" AllowsTransparency="True" WindowStyle="None">
    <Border Background="#080808" BorderBrush="#3C1867" BorderThickness="2">
        <Grid Margin="25">
            <Grid.RowDefinitions>
                <RowDefinition Height="Auto"/>
                <RowDefinition Height="*"/>
                <RowDefinition Height="Auto"/>
            </Grid.RowDefinitions>

            <Grid Grid.Row="0" Margin="0,0,0,15">
                <TextBlock Text="ATA Script" Foreground="White" FontSize="22" FontWeight="Bold" VerticalAlignment="Center"/>
                <Button Name="btnClose" Content="X" HorizontalAlignment="Right" Width="30" Height="30" Background="#440000" Foreground="White" BorderThickness="0" Cursor="Hand" FontWeight="Bold"/>
            </Grid>

            <Grid Grid.Row="1">
                <Grid.Resources>
                    <Style x:Key="BaseBtn" TargetType="Button">
                        <Setter Property="Background" Value="#121212"/>
                        <Setter Property="Foreground" Value="White"/>
                        <Setter Property="Height" Value="50"/>
                        <Setter Property="Margin" Value="0,4"/>
                        <Setter Property="FontSize" Value="14"/>
                        <Setter Property="FontWeight" Value="SemiBold"/>
                        <Setter Property="Template">
                            <Setter.Value>
                                <ControlTemplate TargetType="Button">
                                    <Border Name="b" Background="{TemplateBinding Background}" BorderBrush="#222" BorderThickness="1">
                                        <ContentPresenter HorizontalAlignment="{TemplateBinding HorizontalContentAlignment}" VerticalAlignment="Center" Margin="{TemplateBinding Padding}"/>
                                    </Border>
                                    <ControlTemplate.Triggers>
                                        <Trigger Property="IsMouseOver" Value="True">
                                            <Setter TargetName="b" Property="Background" Value="#3C1867"/>
                                        </Trigger>
                                        <Trigger Property="IsEnabled" Value="False">
                                            <Setter TargetName="b" Property="Background" Value="#050505"/>
                                            <Setter Property="Foreground" Value="#444"/>
                                        </Trigger>
                                    </ControlTemplate.Triggers>
                                </ControlTemplate>
                            </Setter.Value>
                        </Setter>
                    </Style>
                </Grid.Resources>

                <StackPanel Name="MainMenu" VerticalAlignment="Center" Visibility="Visible">
                    <Button Name="btnCsNav" Style="{StaticResource BaseBtn}" HorizontalContentAlignment="Left" Padding="20,0,0,0">
                        <DockPanel Width="380">
                            <TextBlock Text="CS" VerticalAlignment="Center"/>
                            <StackPanel Orientation="Horizontal" HorizontalAlignment="Right" VerticalAlignment="Center">
                                <TextBlock Text="v1.0.4" Foreground="#888" Margin="0,0,10,0"/>
                                <TextBlock Text="[$csDate]" Foreground="$csC"/>
                            </StackPanel>
                        </DockPanel>
                    </Button>
                    <Button Name="btnRustNav" Style="{StaticResource BaseBtn}" HorizontalContentAlignment="Left" Padding="20,0,0,0">
                        <DockPanel Width="380">
                            <TextBlock Text="Rust" VerticalAlignment="Center"/>
                            <StackPanel Orientation="Horizontal" HorizontalAlignment="Right" VerticalAlignment="Center">
                                <TextBlock Text="v1.0.8" Foreground="#888" Margin="0,0,10,0"/>
                                <TextBlock Text="[$rustDate]" Foreground="$rustC"/>
                            </StackPanel>
                        </DockPanel>
                    </Button>
                    <Button Name="btnMcNav" Content="Minecraft (Yakında)" IsEnabled="False" Style="{StaticResource BaseBtn}" HorizontalContentAlignment="Left" Padding="20,0,0,0"/>
                    <Button Name="btnPubgNav" Content="PUBG" Style="{StaticResource BaseBtn}" HorizontalContentAlignment="Left" Padding="20,0,0,0"/>
                    <Button Name="btnPcNav" Content="PC Ayarları" Style="{StaticResource BaseBtn}" HorizontalContentAlignment="Left" Padding="20,0,0,0" Background="#1A1A1A" BorderBrush="#3C1867"/>
                </StackPanel>

                <StackPanel Name="CsMenu" Visibility="Collapsed" VerticalAlignment="Center">
                    <TextBlock Text="CS2 AYARLARI" Foreground="#e38717" FontSize="18" FontWeight="Bold" Margin="0,0,0,15" HorizontalAlignment="Center"/>
                    <Button Name="btnCsCfg" Content="CFG İndir (ata.cfg)" Style="{StaticResource BaseBtn}" HorizontalContentAlignment="Left" Padding="20,0,0,0"/>
                    <Button Name="btnCsLaunch" Content="Başlatma Kodlarını Kopyala" Style="{StaticResource BaseBtn}" HorizontalContentAlignment="Left" Padding="20,0,0,0"/>
                    <Button Name="btnCsBack" Content="Geri Dön" Style="{StaticResource BaseBtn}" HorizontalContentAlignment="Center" Background="#222"/>
                </StackPanel>

                <StackPanel Name="PubgMenu" Visibility="Collapsed" VerticalAlignment="Center">
                    <TextBlock Text="PUBG AYARLARI" Foreground="#d9d9d9" FontSize="18" FontWeight="Bold" Margin="0,0,0,15" HorizontalAlignment="Center"/>
                    <Button Name="btnPubgCfg" Content="CFG İndir (GameUserSettings)" Style="{StaticResource BaseBtn}" HorizontalContentAlignment="Left" Padding="20,0,0,0"/>
                    <Button Name="btnPubgLaunch" Content="Başlatma Kodlarını Kopyala" Style="{StaticResource BaseBtn}" HorizontalContentAlignment="Left" Padding="20,0,0,0"/>
                    <Button Name="btnPubgBack" Content="Geri Dön" Style="{StaticResource BaseBtn}" HorizontalContentAlignment="Center" Background="#222"/>
                </StackPanel>

                <StackPanel Name="RustMenu" Visibility="Collapsed" VerticalAlignment="Center">
                    <TextBlock Text="RUST AYARLARI" Foreground="#ce3f27" FontSize="18" FontWeight="Bold" Margin="0,0,0,15" HorizontalAlignment="Center"/>
                    <Button Name="btnRustCfgNav" Content="Oyuncu CFG Seçenekleri" Style="{StaticResource BaseBtn}" HorizontalContentAlignment="Left" Padding="20,0,0,0"/>
                    <Button Name="btnRustLaunch" Content="Başlatma Kodlarını Kopyala" Style="{StaticResource BaseBtn}" HorizontalContentAlignment="Left" Padding="20,0,0,0"/>
                    <Button Name="btnRustBack" Content="Geri Dön" Style="{StaticResource BaseBtn}" HorizontalContentAlignment="Center" Background="#222"/>
                </StackPanel>

                <StackPanel Name="RustPlayerMenu" Visibility="Collapsed" VerticalAlignment="Center">
                    <TextBlock Text="RUST OYUNCU SEÇİN" Foreground="#ce3f27" FontSize="16" FontWeight="Bold" Margin="0,0,0,15" HorizontalAlignment="Center"/>
                    <UniformGrid Columns="2">
                        <Button Name="btnR1" Content="Burak" Style="{StaticResource BaseBtn}" HorizontalContentAlignment="Center" Margin="4"/>
                        <Button Name="btnR2" Content="Buğra" Style="{StaticResource BaseBtn}" HorizontalContentAlignment="Center" Margin="4"/>
                        <Button Name="btnR3" Content="Emir" Style="{StaticResource BaseBtn}" HorizontalContentAlignment="Center" Margin="4"/>
                        <Button Name="btnR4" Content="Çağrı" Style="{StaticResource BaseBtn}" HorizontalContentAlignment="Center" Margin="4"/>
                        <Button Name="btnR5" Content="MFA" Style="{StaticResource BaseBtn}" HorizontalContentAlignment="Center" Margin="4"/>
                        <Button Name="btnR6" Content="Sirrius" Style="{StaticResource BaseBtn}" HorizontalContentAlignment="Center" Margin="4"/>
                        <Button Name="btnR7" Content="Global" Style="{StaticResource BaseBtn}" HorizontalContentAlignment="Center" Margin="4"/>
                        <Button Name="btnRBack" Content="Geri" Style="{StaticResource BaseBtn}" HorizontalContentAlignment="Center" Background="#222" Margin="4"/>
                    </UniformGrid>
                </StackPanel>

                <StackPanel Name="PcMenu" Visibility="Collapsed" VerticalAlignment="Center">
                    <TextBlock Text="PC SİSTEM AYARLARI" Foreground="#3C1867" FontSize="18" FontWeight="Bold" Margin="0,0,0,15" HorizontalAlignment="Center"/>
                    <Button Name="btnPcTitus" Content="Chris Titus Windows Tool" Style="{StaticResource BaseBtn}" HorizontalContentAlignment="Left" Padding="20,0,0,0"/>
                    <Button Name="btnPcFixOverlay" Content="Fix ms-gamingoverlay Hatası" Style="{StaticResource BaseBtn}" HorizontalContentAlignment="Left" Padding="20,0,0,0"/>
                    <Button Name="btnPcActiv" Content="Windows Etkinleştirme (Yakında)" IsEnabled="False" Style="{StaticResource BaseBtn}" HorizontalContentAlignment="Left" Padding="20,0,0,0"/>
                    <Button Name="btnPcDiscord" Content="Discord Cache Temizliği" Style="{StaticResource BaseBtn}" HorizontalContentAlignment="Left" Padding="20,0,0,0"/>
                    <Button Name="btnPcBack" Content="Geri Dön" Style="{StaticResource BaseBtn}" HorizontalContentAlignment="Center" Background="#222"/>
                </StackPanel>
            </Grid>

            <Grid Grid.Row="2" Margin="0,15,0,0">
                <StackPanel Orientation="Vertical">
                    <ProgressBar Name="pbStatus" Height="3" IsIndeterminate="False" Background="#111" Foreground="#3C1867" BorderThickness="0" Visibility="Hidden" Margin="0,0,0,5"/>
                    <DockPanel>
                        <TextBlock Name="txtStatus" Text="Sistem Hazır." Foreground="#666" FontSize="11" VerticalAlignment="Center"/>
                        <TextBlock Text="v1.0.0" Foreground="#3C1867" FontWeight="Bold" DockPanel.Dock="Right" HorizontalAlignment="Right"/>
                    </DockPanel>
                </StackPanel>
            </Grid>
        </Grid>
    </Border>
</Window>
"@

# --- DEĞİŞKENLERİ XAML İÇİNE GÖMME (HATASIZ YÖNTEM) ---
$XAML_Processed = $XAML_Raw.Replace('[$csDate]', $csDate).Replace('$csC', $csC).Replace('[$rustDate]', $rustDate).Replace('$rustC', $rustC)

# --- XAML YÜKLEME ---
[xml]$XAML = $XAML_Processed
$reader = (New-Object System.Xml.XmlNodeReader $XAML)
$Form = [Windows.Markup.XamlReader]::Load($reader)

# --- ARAYÜZ ELEMANLARINI TANIMLAMA ---
$txtStatus = $Form.FindName("txtStatus")
$pbStatus = $Form.FindName("pbStatus")
$MainMenu = $Form.FindName("MainMenu"); $PcMenu = $Form.FindName("PcMenu")
$CsMenu = $Form.FindName("CsMenu"); $PubgMenu = $Form.FindName("PubgMenu")
$RustMenu = $Form.FindName("RustMenu"); $RustPlayerMenu = $Form.FindName("RustPlayerMenu")

# --- FONKSİYONLAR ---
function Set-Menu ($targetMenu) {
    @($MainMenu, $PcMenu, $CsMenu, $PubgMenu, $RustMenu, $RustPlayerMenu) | ForEach-Object { $_.Visibility = "Collapsed" }
    $targetMenu.Visibility = "Visible"
}

function Update-UIStatus ([string]$msg, [bool]$working) {
    $txtStatus.Text = $msg
    if ($working) {
        $pbStatus.Visibility = "Visible"
        $pbStatus.IsIndeterminate = $true
    } else {
        $pbStatus.Visibility = "Hidden"
        $pbStatus.IsIndeterminate = $false
    }
    [System.Windows.Forms.Application]::DoEvents() 
}

function Run-LocalAction ($scriptName, $displayName) {
    $fullUrl = "$BaseUrl/$scriptName"
    Update-UIStatus "$displayName kontrol ediliyor..." $true
    
    try { 
        $code = Invoke-RestMethod -Uri $fullUrl -UseBasicParsing -ErrorAction Stop
        $scriptBlock = [ScriptBlock]::Create($code)
        
        Clear-Host
        Write-Host "--- $displayName Çalıştırılıyor ---" -ForegroundColor Magenta
        & $scriptBlock
        
        Update-UIStatus "Tamamlandı: $displayName" $false 
    } 
    catch { 
        if ($_.Exception.Response.StatusCode -eq "NotFound") {
            Update-UIStatus "Özellik henüz aktif değil." $false
            [System.Windows.MessageBox]::Show("Bu özellik henüz geliştirme aşamasındadır.", "ATA Script", "OK", "Information")
        } else {
            Update-UIStatus "Hata: Bağlantı sorunu!" $false 
            Write-Error $_.Exception.Message
        }
    }
}

function Run-RustCfg ($name) {
    $fullUrl = "$BaseUrl/RustCfg.ps1"
    Update-UIStatus "$name CFG indiriliyor..." $true
    try {
        $code = Invoke-RestMethod -Uri $fullUrl -UseBasicParsing
        $scriptBlock = [ScriptBlock]::Create($code)
        & $scriptBlock -playerName $name  # Sadece playerName gönderiyor
        Update-UIStatus "Hazır: $name" $false
    } catch { Update-UIStatus "Hata!" $false }
}

# --- BUTON OLAYLARI (EVENT HANDLERS) ---
$Form.FindName("btnClose").Add_Click({ $Form.Close() })
$Form.Add_MouseLeftButtonDown({ $this.DragMove() })

# Menü Geçişleri
$Form.FindName("btnCsNav").Add_Click({ Set-Menu $CsMenu })
$Form.FindName("btnCsBack").Add_Click({ Set-Menu $MainMenu })
$Form.FindName("btnRustNav").Add_Click({ Set-Menu $RustMenu })
$Form.FindName("btnRustBack").Add_Click({ Set-Menu $MainMenu })
$Form.FindName("btnPubgNav").Add_Click({ Set-Menu $PubgMenu })
$Form.FindName("btnPubgBack").Add_Click({ Set-Menu $MainMenu })
$Form.FindName("btnPcNav").Add_Click({ Set-Menu $PcMenu })
$Form.FindName("btnPcBack").Add_Click({ Set-Menu $MainMenu })
$Form.FindName("btnRustCfgNav").Add_Click({ Set-Menu $RustPlayerMenu })
$Form.FindName("btnRBack").Add_Click({ Set-Menu $RustMenu })

# Aksiyonlar
$Form.FindName("btnPcTitus").Add_Click({ Run-LocalAction "Titus.ps1" "Titus Tool" })
$Form.FindName("btnPcFixOverlay").Add_Click({ Run-LocalAction "FixOverlay.ps1" "Fix ms-gamingoverlay Hatası" })
$Form.FindName("btnPcActiv").Add_Click({ Run-LocalAction "Activation.ps1" "Activation" })
$Form.FindName("btnPcDiscord").Add_Click({ Run-LocalAction "DiscordCleanup.ps1" "Discord Cleanup" })
$Form.FindName("btnCsCfg").Add_Click({ Run-LocalAction "CsCfg.ps1" "CS2 CFG" })
$Form.FindName("btnCsLaunch").Add_Click({ Run-LocalAction "CsLaunch.ps1" "CS2 Launch" })
$Form.FindName("btnPubgCfg").Add_Click({ Run-LocalAction "PubgCfg.ps1" "PUBG CFG" })
$Form.FindName("btnPubgLaunch").Add_Click({ Run-LocalAction "PubgLaunch.ps1" "PUBG Launch" })
$Form.FindName("btnRustLaunch").Add_Click({ Run-LocalAction "RustLaunch.ps1" "Rust Launch" })

# Rust Oyuncu CFGleri
$Form.FindName("btnR1").Add_Click({ Run-RustCfg "Burak" })
$Form.FindName("btnR2").Add_Click({ Run-RustCfg "Bugra" })
$Form.FindName("btnR3").Add_Click({ Run-RustCfg "Emir" })
$Form.FindName("btnR4").Add_Click({ Run-RustCfg "Cagri" })
$Form.FindName("btnR5").Add_Click({ Run-RustCfg "MFA" })
$Form.FindName("btnR6").Add_Click({ Run-RustCfg "Sirrius" })
$Form.FindName("btnR7").Add_Click({ Run-RustCfg "Global" })

$Form.ShowDialog() | Out-Null