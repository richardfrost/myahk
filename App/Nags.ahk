#Persistent ; keep a script running -- such as one that contains only timers
#NoEnv      ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance force
SetTitleMatchMode Regex


; Group for annoying nag screens
GroupAdd, NagWindows, ^This is an unregistered copy$ ahk_class #32770   ; Sublime Text
GroupAdd, NagWindows, ^Please Donate$ ahk_class SunAwtDialog            ; FileBot
GroupAdd, NagWindows, ^Sublime Text$ ahk_class #32770, Buy Now          ; Sublime SFTP


SetTimer, Nags, 30
Return

; Watch for nag screens
Nags:
  IfWinActive ahk_group NagWindows
    WinClose
Return
