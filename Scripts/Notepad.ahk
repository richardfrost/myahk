;************************************************;
; Script Function:
;   Add CTRL+W shortcut to close Notepad.
;   Add CTRL+Backspace to remove previous word.
;************************************************;
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SetTitleMatchMode Regex ; Required if not specified elsewhere in the script.

#IfWinActive - Notepad$ ahk_class Notepad
	^w::WinClose
	^Backspace::Send ^+{Left}{Backspace}
#IfWinActive
