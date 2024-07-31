# Mevcut yürütme politikasını al
$currentPolicy = Get-ExecutionPolicy

# Eğer politika 'RemoteSigned' veya 'Unrestricted' değilse, değiştirilir
if ($currentPolicy -ne 'RemoteSigned' -and $currentPolicy -ne 'Unrestricted') {
    Set-ExecutionPolicy RemoteSigned -Scope Process -Force
}

try {
    # Paketleri kur
    $packages = @(
        "Microsoft.VCRedist.2005.x86",
        "Microsoft.VCRedist.2008.x86",
        "Microsoft.VCRedist.2010.x86",
        "Microsoft.VCRedist.2012.x86",
        "Microsoft.VCRedist.2013.x86",
        "Microsoft.VCRedist.2015+.x86",
        "Microsoft.VCRedist.2005.x64",
        "Microsoft.VCRedist.2008.x64",
        "Microsoft.VCRedist.2010.x64",
        "Microsoft.VCRedist.2012.x64",
        "Microsoft.VCRedist.2013.x64",
        "Microsoft.VCRedist.2015+.x64"
    )

    # Her paketi yükle
    foreach ($package in $packages) {
        Write-Host "Installing $package..."
        winget install --id $package -h
    }

    Write-Host "Kurulum tamamlandı."
} catch {
    Write-Host "Bir hata oluştu: $_"
} finally {
    Write-Host "Script tamamlandı."
}
