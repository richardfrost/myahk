;************************************************;
; Start Windows Calculator
;
; Instructions: WIN+C or WIN+SHIFT+C (New Instance).
;************************************************;
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SetTitleMatchMode Regex ; Required if not specified elsewhere in the script.

; Start Calculator or switch focus to calculator is already running
#c::
	; If calculator is not running, open it
	IfWinNotExist ^Calculator$ ; ahk_class CalcFrame ; Removed ahk_class for Windows 10 support
		Run, calc.exe
	Else ; If calculator is running, switch focus to it
		WinActivate ^Calculator$, ; Removed ahk_class for Windows 10 support
Return

; Start a new Calculator instance
+#c::
	Run, calc.exe ; Run application
	WinActivate, ^Calculator$ ; ahk_class CalcFrame ; Removed ahk_class for Windows 10 support
Return

; Close Calculator Window
#IfWinActive ^Calculator$ ; ahk_class CalcFrame ; Removed ahk_class for Windows 10 support
	^w::WinClose
#IfWinActive
