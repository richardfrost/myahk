;************************************************;
; Toggle Desktop Icons
;
; Instructions:  Press F12 Key to toggle showing
; or hiding desktop icons.
;************************************************;
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.

^F12::
	ControlGet, HWND, Hwnd,, SysListView321, ahk_class Progman
	If HWND =
		ControlGet, HWND, Hwnd,, SysListView321, ahk_class WorkerW
	If DllCall("IsWindowVisible", UInt, HWND)
		WinHide, ahk_id %HWND%
	Else
		WinShow, ahk_id %HWND%
Return
