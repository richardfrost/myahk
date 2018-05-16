;************************************************;
; Browser Shortcuts
;
; Prevent closing all browser windows (Ctrl+Shift+Q)
; Credit: Richard
;************************************************;
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetTitleMatchMode Regex ; Required if not specified elsewhere in the script.

; Browser Windows
; (GroupAdd Lines are also included in MyAHK-Build.ahk, duplicates are ignored)
GroupAdd, BrowserWindows, ahk_exe chrome.exe      ; Chrome
GroupAdd, BrowserWindows, ahk_exe firefox.exe     ; Firefox

#IfWinActive ahk_group BrowserWindows
^+q::Return
#IfWinActive