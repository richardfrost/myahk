; Block/Unblock Mouse Input
; [Used in DisableMouse.ahk, PastePlain.ahk]
#Include %A_ScriptDir%\..\Lib\Nothing.ahk


BlockMouseInput()
{
	Hotkey, LButton, nothing, On
	Hotkey, MButton, nothing, On
	Hotkey, RButton, nothing, On
	Hotkey, XButton1, nothing, On
	Hotkey, XButton2, nothing, On
	Hotkey, WheelUp, nothing, On
	Hotkey, WheelDown, nothing, On
	Hotkey, WheelLeft, nothing, On
	Hotkey, WheelRight, nothing, On
	BlockInput, MouseMove
}


UnblockMouseInput()
{
	Hotkey, LButton, nothing, Off
	Hotkey, MButton, nothing, Off
	Hotkey, RButton, nothing, Off
	Hotkey, XButton1, nothing, Off
	Hotkey, XButton2, nothing, Off
	Hotkey, WheelUp, nothing, Off
	Hotkey, WheelDown, nothing, Off
	Hotkey, WheelLeft, nothing, Off
	Hotkey, WheelRight, nothing, Off
	BlockInput, MouseMoveOff
}


; Block keyboard input except Escape
; http://www.autohotkey.com/board/topic/13865-disable-keyboard-and-mouse/
BlockKeyboardInput()
{
}


UnblockKeyboardInput()
{
}


; Block Keyboard and Mouse (Except Escape)
BlockAllInput()
{
	BlockMouseInput()
	BlockKeyboardInput()
}

; Unblock Keyboard and Mouse
UnblockAllInput()
{
	UnblockMouseInput()
	UnblockKeyboardInput()
}