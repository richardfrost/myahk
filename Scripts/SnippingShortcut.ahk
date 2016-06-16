;************************************************;
; Run the native Snipping Tool for screen capture
; Credit: Lifehacker
;
; Instructions: Win+S
;************************************************;
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetTitleMatchMode Regex ; Required if not specified elsewhere in the script.
#Include %A_ScriptDir%\..\Lib\WinVer.ahk


#s::
WinActivate, ahk_class Progman ; Helpful to ensure new window will be activated properly. More Info: http://www.autohotkey.com/board/topic/85227-mozilla-firefox-and-runwinactivate-glitch/
EnvGet, OutputVar, windir

; Check if OS is 64-bit, but ahk is running 32-bit (PtrSize = 4)
If (A_Is64bitOS && A_PtrSize = 4)
	Run, %OutputVar%\Sysnative\SnippingTool.exe ; Sysnative allows 32 bit applications to access System32 
Else
	Run, %OutputVar%\System32\SnippingTool.exe

; If Windows 8 (v 6.2) or Newer, automatically start snipping
If (WinVer() > 6.1)
	WinWaitActive, ahk_class Microsoft-Windows-Tablet-SnipperToolbar
		send ^{PrintScreen}
return

; Close Snipping Tool Toolbar or Editor
#IfWinActive ahk_class Microsoft-Windows-Tablet-Snipper
	^w::WinClose
#IfWinActive