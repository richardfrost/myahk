;************************************************;
; Paste unformatted text from clipboard
;
; Instructions: Paste using Ctrl+Shift+V 
; to paste unformatted (plain) text.
;************************************************;
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#ClipboardTimeout 2000
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
CoordMode, Mouse, Screen
#Include %A_ScriptDir%\..\Lib\BlockUserInput.ahk


; Paste without formatting
; Note: Has a rough time with remote file locations (UNC paths in explorer for instance)
;  http://superuser.com/questions/7271/most-useful-autohotkey-scripts
;  http://www.autohotkey.com/board/topic/83298-clipboard-loses-formatting-after-restoring-clipboardall/
;  https://www.donationcoder.com/forum/index.php?topic=30125.msg295111#msg295111
^+v::
	ClipSaved := ClipBoardAll		; Save original clipboard contents
	Clipboard = %Clipboard%			; Convert any copied files, HTML, or other formatted text to plain text.
	ClipWait, 2
	if ErrorLevel
	{	
		Clipboard := ClipSaved
		ErrorLevel = 0				; Reset error flag
		return
	}

	Send ^v
	Sleep 250
	Clipboard := ClipSaved			; Restore original ClipBoard
	VarSetCapacity(ClipSaved, 0)	; Free the memory in case the clipboard was very large.
return


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; type out clipboard (useful for remote connections/software keys) ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
^!v::
	ClipSaved := ClipBoardAll		; Save original clipboard contents
	Clipboard = %Clipboard%			; Convert any copied files, HTML, or other formatted text to plain text.
	
	GoSub ClipLogic 				; Run logic on the clipboard's contents

	Sleep 2000						; Give user time to select right window

	; Send, {Raw}%Clipboard% ; Send the entire clipboard at once
	
	; send it one character at a time.
	StringLen, Length, Clipboard ; Get length of clipboard to calculate progress bar

	; Display a progress bar
	SetFormat, Float, 1.1 ; clean up percentage complete
	Gui, Add, Progress, w300 Smooth Range0-%Length% vProgressBar
	Gui, Add, Text, xp yp+2 hp wp Center BackgroundTrans vPercent, 0`%
	Gui, Add, Text, yp+18 wp Center BackgroundTrans vCurrent
	Gui, +AlwaysOnTop +Disabled -SysMenu +Owner
	Gui, Show, NoActivate, Pasting Clipboard...

	BlockAllInput()
	Loop, Parse, Clipboard
	{
		if % GetKeyState("Escape",P)
			break

		Send, {Raw}%A_LoopField%

		; Update progress bar
		GuiControl,, ProgressBar, +1
		GuiControl,, Percent, % 100*(A_Index/Length)`%
		GuiControl,, Current, % "Character: " . A_Index . "/" . Length
	}
	UnblockAllInput()

	Gui, Destroy ; Remove the progress bar

	; Just in case keys get "stuck"
	Send, {SHIFTUP}{ALTUP}{CTRLUP}

	Clipboard := ClipSaved			; Restore original ClipBoard
	VarSetCapacity(ClipSaved, 0)	; Free the memory in case the clipboard was very large.
Return


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; type out clipboard (Slow) (For remote connections/slow windows)  ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
^!+v::
	ClipSaved := ClipboardAll 	; Save the entire clipboard to a variable of your choice.
	Clipboard = %clipboard%  	; Convert any copied files, HTML, or other formatted text to plain text.

	GoSub ClipLogic ; Run logic on the clipboard's contents
	
	; Warn if typing will take over 10 seconds.
	StringLen, Length, Clipboard
	If Length > 250
	{
		MsgBox, 0x24, Slow Operation, % "Typing " . Length . " characters will take approximately " . Round(2*(Length/50)) . " seconds. Continue?", 5
		IfMsgBox, No
		{
			Exit
		}
		IfMsgBox, Timeout
		{
			Exit
		}
	}
	
	Sleep 2000 ; Give user time to select right window
	
	SetKeyDelay, 50 ; Slow the send rate for windows that can't keep up
	StringLen, Length, Clipboard ; Get length of clipboard to calculate progress bar
	; SendEvent {Raw}%Clipboard% ; Send all keys (useful if not wanting a progress bar)

	; Display a progress bar
	SetFormat, Float, 1.1 ; clean up percentage complete
	Gui, Add, Progress, w300 Smooth Range0-%Length% vProgressBar
	Gui, Add, Text, xp yp+2 hp wp Center BackgroundTrans vPercent, 0`%
	Gui, Add, Text, yp+18 wp Center BackgroundTrans vCurrent
	Gui, +AlwaysOnTop +Disabled -SysMenu +Owner
	
	;WinGetPos , x, y, w, h, A
	;center_x = % x+(w/2)
	;center_y = % y+(h/2)
	;msgbox, %center_x% %center_y%
	;Gui, Show, X%x% Y%y% NoActivate, Pasting Clipboard...
	Gui, Show, NoActivate, Pasting Clipboard...

	BlockAllInput()
	Loop, Parse, Clipboard
	{
		if % GetKeyState("Escape",P)
			break

		SendEvent {Raw}%A_LoopField%

		; Update progress bar
		GuiControl,, ProgressBar, +1
		GuiControl,, Percent, % 100*(A_Index/Length)`%
		GuiControl,, Current, % "Character: " . A_Index . "/" . Length
	}
	UnblockAllInput()
	Gui, Destroy ; Remove the progress bar

	; Just in case keys get "stuck"
	Send, {SHIFTUP}{ALTUP}{CTRLUP}
	
	Clipboard := ClipSaved  	; Restore the original clipboard. Note the use of Clipboard (not ClipboardAll).
  ClipSaved =   				; Free the memory in case the clipboard was very large.
Return


; Perform logic on the clipboard's contents
ClipLogic:
	; Offer to replace hyphens (-) with Tabs (Useful for product keys)
	If InStr(Clipboard, "-")
	{
		MsgBox, 0x24, Hyphen(s) Detected, Convert hypen(s) to Tabs?, 5
		IfMsgBox, Yes
		{
			StringReplace, Clipboard, Clipboard, -, `t, All ; Replace all hyphens (-) with tabs
		}
	}
	
	Clipboard = % RegExReplace(Clipboard, "\r\n?|\n\r?", "`n") ; Remove "double linebreaks" (\r\n)
Return