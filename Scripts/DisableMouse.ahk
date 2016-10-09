;************************************************;
; Script Function:
;       Toggle to disable/enable mouse input.
;************************************************;
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
CoordMode, Mouse, Screen
Global BlockMouseToggle = 0 ; Included in MyAHK-Build.ahk
#Include %A_ScriptDir%\..\Lib\BlockUserInput.ahk
#Include %A_ScriptDir%\..\Lib\TransparentWindow.ahk

^!+m::
	If BlockMouseToggle = 0 ; block mouse input
	{
		BlockMouseInput()
		BlockMouseToggle := BlockMouseToggle<1  ? 1 : 0
		TransparentWindow("Mouse Disabled", 450)
	}
	Else If BlockMouseToggle = 1 ; restore mouse input
	{
		UnblockMouseInput()
		BlockMouseToggle := BlockMouseToggle<1  ? 1 : 0
		TransparentWindow("Mouse Enabled", 450)
	}
Return
