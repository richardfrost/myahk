;************************************************;
; Control the mouse with your keyboard.
;
; Instructions:
;	AppsKey+Arrows	- Move mouse cursor
;	CTRL/AppsKey+Numpad0	- Send left click
;	CTRL/AppsKey+Numpad0	- Send left click
;************************************************;
#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
#Include %A_ScriptDir%\..\Lib\AppsKey.ahk

; Move mouse pointer with Arrow keys
AppsKey & Left::MouseMove, -5, 0, 0, R
AppsKey & Right::MouseMove, 5, 0, 0, R
AppsKey & Up::MouseMove, 0, -5, 0, R
AppsKey & Down::MouseMove, 0, 5, 0, R

; Left Mouse Clicks
^Numpad0::Send {Click}
^NumpadIns::Send {Click}
AppsKey & Numpad0::Send {Click}
AppsKey & NumpadIns::Send {Click}

; Right Mouse Clicks
^NumpadDot::Send {Click, right}
^NumpadDel::Send {Click, right}
AppsKey & NumpadDot::Send {Click, right}
AppsKey & NumpadDel::Send {Click, right}
