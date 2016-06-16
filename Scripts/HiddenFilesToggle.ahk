;************************************************;
; Toggle Hidden Files and Folders
; Credit: LifeHacker -> turnersd
;
; Instructions:  Win+H to hide/show hidden files.
;************************************************;
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Include %A_ScriptDir%\..\Lib\WinVer.ahk


#h:: 
  RegRead, HiddenFiles_Status, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, Hidden
  If (HiddenFiles_Status = 2)
  {
  	RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, Hidden, 1
  }
  Else
  {
  	RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, Hidden, 2
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