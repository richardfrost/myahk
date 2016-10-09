;************************************************;
; Reload the main Autohotkey script or Exit it.
;
; Instructions: Press the Left and Right shift
; keys simultaneously to reload the script or
; CTRL+ALT+BACKSPACE to exit.
;************************************************;
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Include %A_ScriptDir%\..\Lib\TransparentWindow.ahk

; Reload the main AHK Script
RShift & LShift::
LShift & RShift::
	If A_IsCompiled <> 1 ; If the script is not compiled in an .exe
			Run, %A_ScriptFullPath%
	Else
		Reload
Return

; Exit AutoHotKey
^!Backspace::
	TransparentWindow("Closing AHK", 450)
	ExitApp
Return

; Suspend & Pause AutoHotKey
!Pause::
	Suspend ; Suspend hotkeys

	; Has to be after suspend or it won't be able to un-suspend with the same key.
	If A_IsSuspended = 1
		TransparentWindow("AHK Disabled", 400)
	If A_IsSuspended = 0
		TransparentWindow("AHK Enabled", 400)

	Pause, Toggle, 1 ; Pause running threads
Return
