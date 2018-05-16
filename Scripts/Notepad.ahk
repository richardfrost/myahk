;************************************************;
; Script Function:
;   Add CTRL+Backspace to remove previous word.
;   Add CTRL+Delete to remove previous word.
;************************************************;
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SetTitleMatchMode Regex ; Required if not specified elsewhere in the script.

#IfWinActive - Notepad$ ahk_class Notepad
^Backspace::Send ^+{Left}{Backspace}
^Delete::Send ^+{Right}{Backspace}
#IfWinActive
