;************************************************;
; Opens a path in Windows Explorer
; Credit: Richard
;
; Instructions: CTRL + O to open
; the path contained on the clipboard.
;************************************************;
#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.

; Open path on clipboard
#o::
{
	Var = %clipboard%
	OAutoTrim = %A_AutoTrim% ; Store Old AutoTrim Value.
	AutoTrim On  ; Strip out any leading and trailing whitespace from selection
	Var = %Var%	; Remove leading and trailing white space. Need AutoTrim On

	SplitPath, var,, dir
	run explorer.exe %dir%

	AutoTrim, %OAutoTrim%
}
return
