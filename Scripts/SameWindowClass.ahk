;************************************************;
; Switch between apps of the same window class
; Credit: Richard Frost
;
; Instructions: Alt+` (~ key)
;************************************************;
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetTitleMatchMode Regex

!`::
	WinGetClass, ActiveClass, A
	WinGet, ActiveProcess, ProcessName, A
	WinActivateBottom, ahk_class i)%ActiveClass% ahk_exe i)%ActiveProcess%
return