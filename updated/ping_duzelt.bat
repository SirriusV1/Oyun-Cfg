@echo off
chcp 65001 > nul
title Windows Ag Yığını Sıfırlama
echo İnternet ayarları sıfırlanıyor...
echo.

netsh int ip reset
netsh winsock reset

ipconfig /release
ipconfig /flushdns
ipconfig /renew

echo.
echo İnternet ayarları sıfırlandı.
echo.
echo Bilgisayarınızı yeniden başlatmanız gerekebilir.


pause