;************************************************;
; Script Function:
;   Add CTRL+Backspace to remove previous word.
;************************************************;
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SetTitleMatchMode Regex ; Required if not specified elsewhere in the script.

#IfWinActive - Excel ahk_class XLMAIN
^Backspace::Send ^+{Left}{Backspace}
#IfWinActive
