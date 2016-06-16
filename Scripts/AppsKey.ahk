;************************************************;
; Perform several actions by pressing keys in 
;   conjunction with the Apps Key.
;
; Instructions: 
; 	AppsKey+Enter - Insert a line break
;	AppsKey+Tab	  - Insert tab
;	AppsKey+LWin  - Disable Windows keys
;   AppsKey+Shift+LWin - Enable Windows keys
;	AppsKey+Insert - Search Google for selected text or go to url directly
;	AppsKey+H	- Hide the current window.
;   AppsKey+L	- Lock workstation
;	AppsKey+Shift+H	- Restore all hidden windows
;************************************************;
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Include %A_ScriptDir%\..\Lib\AppsKey.ahk
#Include %A_ScriptDir%\..\Lib\IsWindow.ahk
#Include %A_ScriptDir%\..\Lib\Nothing.ahk
#Include %A_ScriptDir%\..\Lib\Text.ahk

SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.


; Insert a line break (useful when hitting enter will submit a form)
AppsKey & Enter::
	PutText("`r`n")
Return


; Insert a tab (useful when pressing tab would change the focus)
AppsKey & tab::
	PutText("`t")
Return


; Disable/Enable the Windows Keys
AppsKey & LWin::
	If GetKeyState("Shift")	{
		Hotkey RWin, Nothing, Off
		Hotkey LWin, Nothing, Off
	}
	Else {
		Hotkey RWin, Nothing, On
		Hotkey LWin, Nothing, On
	}
Return


; Search Google for selected text, or if URL go straight there.
AppsKey & Insert::
TempText := GetText()
TempText := RegExReplace(TempText, "^\s+|\s+$") ;trim whitespace
If RegExMatch(TempText, "\w\.[a-zA-Z]+(/|$)") ;contains .com etc
{
   If SubStr(TempText, 1, 4) != "http"
      TempText := "http://" . TempText
}
Else
{
   If InStr(TempText, " ")
   {
      StringReplace TempText, TempText, %A_Space%, +
      TempText := "%22" . TempText . "%22"
   }
   TempText := "http://www.google.com/search?&q=" . TempText
}
Run %TempText%
Return


; Hide or unhide the active window
AppsKey & h::
If GetKeyState("shift")
{
   Loop Parse, HiddenWins, |
      WinShow ahk_id %A_LoopField%
   HiddenWins =
}
else
{
   MyWin := WinExist("A")
   if IsWindow(MyWin)
   {
      HiddenWins .= (HiddenWins ? "|" : "") . MyWin
      WinHide ahk_id %MyWin%
      GroupActivate All
   }
}
Return