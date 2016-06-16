;************************************************;
; File Extension Toggle
; Credit: How-To Geek
;
; Instructions: Win+Y to hide/show file extensions.
;************************************************;
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Include %A_ScriptDir%\..\Lib\WinVer.ahk


#y::
  RegRead, HiddenFiles_Status, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, HideFileExt
  If (HiddenFiles_Status = 1)
  {
  	RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, HideFileExt, 0
  }
  Else
  { 
  	RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, HideFileExt, 1
  }

  ; If Windows Vista/2008 or later (v 6.0)
  If (WinVer() >= 6.0)
  	send, {F5}
  Else
  {
  	WinGetClass, CurrentWinClass, A
  	PostMessage, 0x111, 28931,,, A
  }
Return