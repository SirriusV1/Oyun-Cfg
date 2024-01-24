$host.ui.RawUI.WindowTitle = "Ruhunu satmaya hazır mısın?"
Clear-Host
function sorubir {
    $cevap = Read-Host "Ruhunu satmaya hazır mısın? (1. Evet / 2. Hayır)"
    
    if ($cevap -eq "1" -or $cevap -eq "2") {
        Clear-Host
        soruiki
    }
    else {
        Write-Host "Geçersiz bir seçenek girdin. Lütfen '1' (Evet) veya '2' (Hayır) olarak cevap ver."
        Start-Sleep -Seconds 1
        sorubir
    }
}

# Kararından emin olup olmadığını sormak için bir fonksiyon
function soruiki {
    $cevap = Read-Host "Bunu istediğine emin misin? (1. Evet / 2. Hayır)"

    if ($cevap -eq "1" -or $cevap -eq "2") {
        Clear-Host
        soruuc
    }
    else {
        Write-Host "Geçersiz bir seçenek girdin. Lütfen '1' (Evet) veya '2' (Hayır) olarak cevap ver."
        Start-Sleep -Seconds 1
        soruiki
    }
}

# Tekrar düşünmek için zaman isteyip istemediğini sormak için bir fonksiyon
function soruuc {
    $cevap = Read-Host "Tekrar düşünmek için zaman istemiyor musun? (1. Evet / 2. Hayır)"

    if ($cevap -eq "1" -or $cevap -eq "2") {
        Clear-Host
        sorudort
    }
    else {
        Write-Host "Geçersiz bir seçenek girdin. Lütfen '1' (Evet) veya '2' (Hayır) olarak cevap ver."
        Start-Sleep -Seconds 1
        soruuc
    }
}

# Emin olup olmadığını sormak için bir fonksiyon
function sorudort {
    $cevap = Read-Host "Emin misin? (1. Evet / 2. Hayır)"

    if ($cevap -eq "1" -or $cevap -eq "2") {
        Clear-Host
        sorubes
    }
    else {
        Write-Host "Geçersiz bir seçenek girdin. Lütfen '1' (Evet) veya '2' (Hayır) olarak cevap ver."
        Start-Sleep -Seconds 1
        sorudort
    }
}

function sorubes {
    $cevap = Read-Host "Tamam, nasıl istersen dostum 1 yaz."

    if ($cevap -eq "1" -or $cevap -eq "2") {
        Clear-Host
        sorualtı
    }
    else {
        Write-Host "Geçersiz bir seçenek girdin. Lütfen '1' (Evet) veya '2' (Hayır) olarak cevap ver."
        Start-Sleep -Seconds 1
        sorubes
    }
}
function sorualtı {
    Write-Host "1. Hayır, bekle bunu düşüneceğim."
   $secim = Read-Host "2. Ruhumu Sat" 
    

    switch ($secim) {
    1 {
        PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/main.ps1' | Invoke-Expression }"
        break
    }
    2 {
        Start-Process steam://connect/104.152.142.26:28010
        # Start-Process steam://rungameid/252490
        break
    }
    default {
        # Gecersiz bir secim yapildiginda uyarı version
        Write-Host "Gecersiz bir secim yaptiniz. Lutfen 1-2 arasinda bir numara girin." -ForegroundColor Red
        Start-Sleep -Seconds 1
        sorualtı
        
    }
}
}


# Ana program
sorubir
