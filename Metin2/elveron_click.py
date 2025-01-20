import win32gui
import win32con
import win32api
import time
import ctypes

def inventory_click():
    # Elveron penceresini bul
    def callback(hwnd, hwnds):
        if win32gui.IsWindowVisible(hwnd):
            if 'elveron' in win32gui.GetWindowText(hwnd).lower():
                hwnds.append(hwnd)
        return True
    
    hwnds = []
    win32gui.EnumWindows(callback, hwnds)
    
    if not hwnds:
        print("Elveron penceresi bulunamadı!")
        return
        
    hwnd = hwnds[0]
    
    # Pencereyi aktifleştir
    win32gui.ShowWindow(hwnd, win32con.SW_RESTORE)
    win32gui.SetForegroundWindow(hwnd)

    # Mouse'un mevcut konumunu al
    current_pos = win32gui.GetCursorPos()
    
    # Mouse pozisyonunu pencere koordinatlarına çevir
    client_pos = win32gui.ScreenToClient(hwnd, current_pos)
    
    # Tıklama işlemi
    lParam = win32api.MAKELONG(client_pos[0], client_pos[1])
    win32gui.SendMessage(hwnd, win32con.WM_LBUTTONDOWN, win32con.MK_LBUTTON, lParam)

    win32gui.SendMessage(hwnd, win32con.WM_LBUTTONUP, 0, lParam)


inventory_click()

