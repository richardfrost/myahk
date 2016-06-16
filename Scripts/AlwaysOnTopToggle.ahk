;************************************************;
; File Extension Toggle
; Credit: superuser.com
;
; Instructions: CTRL+SHIFT+A to toggle Always On Top
;************************************************;
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Include %A_ScriptDir%\..\Lib\TransparentWindow.ahk


; Always on Top Toggle
^+a::
; Don't allow the desktop shell to be Always on Top (Progman < Win8, WorkerW = Win8, Shell_TrayWnd = Taskbar, DV2ControlHost = Win7 StartMenu)
WinGetClass, CurrentWinClass, A
If (CurrentWinClass = "Progman" || CurrentWinClass = "WorkerW" || CurrentWinClass = "Shell_TrayWnd" || CurrentWinClass = "DV2ControlHost")
Return

WinSet, AlwaysOnTop, Toggle, A		; Toggle Always on Top status

; Notify User
WinGetPos,x,y,w,h,A         ; Get active window's width/heigth
boxW:=146, boxH=38 ; Variables for TransparentWindow box size (224, 55)
WinGet, ExStyle, ExStyle, A

If (ExStyle & 0x8)  ; 0x8 is WS_EX_TOPMOST.
	TransparentWindow("On-Top Enabled",550,12,"teal",0,0,x+w/2-boxW/2,y+h/2-boxH/2,boxW,boxH)
Else ; Not Always On Top
	TransparentWindow("On-Top Disabled",550,12,"Teal",0,0,x+w/2-boxW/2,y+h/2-boxH/2,boxW,boxH)
Return