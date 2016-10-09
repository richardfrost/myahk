;************************************************;
; Script Function:
;   Add CTRL+V paste shortcut & CTRL+W close
;	  window shortcut to Window's Command Prompt
;
;   Also adds scrolling with CTRL+UP/Down
;	  and SHIFT+PGUP/PGDN
;************************************************;
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetTitleMatchMode Regex ; Required if not specified elsewhere in the script.
Global CMDToggle = 1 ; Included in MyAHK-Build.ahk
#Include %A_ScriptDir%\..\Lib\TransparentWindow.ahk

; Command Prompt Tweaks
#IfWinActive ahk_class ConsoleWindowClass
; Toggle Command Prompt aliases on/off with ALT+F12 (On by default)
!F12::
	CMDToggle := CMDToggle<1  ? 1 : 0

	WinGetPos,x,y,w,h,A 				; Get active window's width/heigth
	boxW:=146, boxH=38 ; Variables for TransparentWindow box size (224, 55)

	if CMDToggle
		TransparentWindow("CMD Aliases On", 550, 12,"green",0,230,x+w/2-boxW/2,y+h/2-boxH/2,boxW,boxH)
	else
		TransparentWindow("CMD Aliases Off", 550, 12,"green",0,230,x+w/2-boxW/2,y+h/2-boxH/2,boxW,boxH)
Return

^v::SendInput {Raw}%ClipBoard% ; Paste
^w::WinClose, A ; Close CMD window

; Navigation
^a::Send, {Home}
^e::Send, {End}
^u::Send, ^{Home}

; Scrolling
^Up::Send {WheelUp}
^Down::Send {WheelDown}

+PgUp::
	Loop, 10
		Send {WheelUp}
Return

+PgDn::
	Loop, 10
		Send {WheelDown}
Return
#IfWinActive

; Command Prompt aliases that can be problematic with some bash-like shells. Disable with ALT+F12, not applied to PowerShell windows.
#If WinActive("ahk_class ConsoleWindowClass","","i)PowerShell") && (CMDToggle)

; Specify user home directory with ~
:*:~::
	EnvGet, OutputVar, UserProfile
	SendInput %OutputVar%
return

; Other Aliases
:c:cat::type
:c:clear::cls
:c:cp::copy
:c:ls::dir
:c:mkdir::md
:c:mv::move
:c:ps::start powershell
:c:rm::del
#If
