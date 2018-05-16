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

; CommandPrompt Windows Group
; (GroupAdd Lines are also included in MyAHK-Build.ahk, duplicates are ignored)
GroupAdd, CommandPromptWindows, Command Prompt ahk_class ConsoleWindowClass  ; Command Prompt
GroupAdd, CommandPromptWindows, i)\\cmd.exe ahk_class ConsoleWindowClass     ; Command Prompt

; Console Windows Group
; (GroupAdd Lines are also included in MyAHK-Build.ahk, duplicates are ignored)
GroupAdd, ConsoleWindows, Command Prompt ahk_class ConsoleWindowClass  ; Command Prompt
GroupAdd, ConsoleWindows, i)\\cmd.exe ahk_class ConsoleWindowClass     ; Command Prompt
GroupAdd, ConsoleWindows, i)PowerShell$ ahk_class ConsoleWindowClass   ; PowerShell

; Command Prompt Tweaks
#If WinActive("ahk_group ConsoleWindows")
; Toggle Command Prompt aliases on/off with ALT+F12 (On by default)
!F12::
	CMDToggle := CMDToggle<1  ? 1 : 0

	WinGetPos,x,y,w,h,A 				; Get active window's width/heigth
	boxW:=200, boxH=38 ; Variables for TransparentWindow box size (224, 55)

	if CMDToggle
		TransparentWindow("CMD Enhancements On", 550, 12,"green",0,230,x+w/2-boxW/2,y+h/2-boxH/2,boxW,boxH)
	else
		TransparentWindow("CMD Enhancements Off", 550, 12,"green",0,230,x+w/2-boxW/2,y+h/2-boxH/2,boxW,boxH)
Return
#If

; For Command Prompt and PowerShell
#If WinActive("ahk_group ConsoleWindows") && (CMDToggle)
^v::SendInput {Raw}%ClipBoard% ; Paste
^w::WinClose, A ; Close window

; Navigation
^a::Send, {Home}
^e::Send, {End}
^u::Send, ^{Home}
^k::Send, ^{End}

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
#If

; For Command Prompt
#If WinActive("ahk_group CommandPromptWindows") && (CMDToggle)
; Shortcuts
^l::Send, cls{enter}

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

; For Arch WSL
#If WinActive("ahk_exe Arch.exe") && (CMDToggle)
^v::SendInput {Raw}%ClipBoard% ; Paste
#If