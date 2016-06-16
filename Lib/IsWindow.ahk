; Function to check if a window is, in fact a window as opposed to the desktop or a menu, etc.
; [Used in AlwaysOnTop.ahk and AppsKey.ahk]


IsWindow(hwnd)
{
  WinGet, s, Style, ahk_id %hwnd%
  return s & 0xC00000 ? (s & 0x80000000 ? 0 : 1) : 0
  ;WS_CAPTION AND !WS_POPUP(for tooltips etc)
  return
}