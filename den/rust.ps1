# Hangi oyuncunun CFG dosyasını indirmek istiyorsunuz?
Write-Host "1. Burak"
Write-Host "2. Bugra"
Write-Host "3. Arda"
Write-Host "4. Emir"
Write-Host "5. Cagri"
Write-Host "6. MFA"
Write-Host "7. Sirius"

$player_choice = Read-Host "Lutfen bir oyuncu secin (1-7)"

switch ($player_choice) {
    "1" {
        Invoke-WebRequest -Uri "https://drive.google.com/u/0/uc?id=1VWUYc-L5yq6T7ipNNieAA0G9kpOf02gE&export=download" -OutFile "C:\deneme\rust\ata.cfg"
    }
    "2" {
        Invoke-WebRequest -Uri "https://drive.google.com/u/0/uc?id=1bWyD709q0tb8R2yUm0_b6_sggO8TQftH&export=download" -OutFile "C:\deneme\rust\ata.cfg"
    }
    "3" {
        Invoke-WebRequest -Uri "https://drive.google.com/u/0/uc?id=1u1Ol1tm9SFPUzOrNjMK0jnnpykIZhklv&export=download" -OutFile "C:\deneme\rust\ata.cfg"
    }
    "4" {
        Invoke-WebRequest -Uri "https://drive.google.com/u/0/uc?id=1LWxIO5JvwRIqt9-ywIS9kGh6UgTimqhZ&export=download" -OutFile "C:\deneme\rust\ata.cfg"
    }
    "5" {
        Invoke-WebRequest -Uri "https://drive.google.com/u/0/uc?id=1b3rAzOlDQVa8LoIn8Een8-FpcxYQrKLA&export=download" -OutFile "C:\deneme\rust\ata.cfg"
    }
    "6" {
        Invoke-WebRequest -Uri "https://drive.google.com/u/0/uc?id=1zmcK4soNCz4T2ZEvxXoPESSUN2G0S_xe&export=download" -OutFile "C:\deneme\rust\ata.cfg"
    }
    "7" {
        Invoke-WebRequest -Uri "https://drive.google.com/u/0/uc?id=1L3FmXtfaD3OCOF3_4Ra7IdaO8-n_tO_J&export=downloads" -OutFile "C:\deneme\rust\ata.cfg"
    }
    default {
        Write-Host "Gecersiz oyuncu secenegi! Lutfen tekrar deneyin."
        Start-Sleep -Seconds 3
        exit
    }
}

Write-Host "Islem tamamlandi. Ana menuye donuluyor..."
Start-Sleep -Seconds 3
exit
