;************************************************;
; Provide a menu to manipulate text.
; Credit: Richard
;
; Instructions: Select your desired text and
;  press Left-Win+Caps-Lock to see the menu.
;************************************************;
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability. You may need "Event" for some UAC and Java applications
#Include %A_ScriptDir%\..\Lib\Case.ahk

; Case menu
MenuCase:
	Menu,Case,Add,&UPPER CASE,UPPER
	Menu,Case,Add,&lower case,LOWER
	Menu,Case,Add,&Title Case,TITLE
	Menu,Case,Add,&Sentence case,SENTENCE
	Menu Case,Add ; Separator
	Menu,Case,Add,&camelCase,CAMEL_CASE
	Menu,Case,Add,&NO_CAMEL_CASE,NO_CAMEL_CASE
	Menu,Case,Add,&iNVERT cASE,INVERT
	Menu Case,Add ; Separator
	Menu,Case,Add,Spaces to &_,UNDERSCORES
	Menu,Case,Add,_ to &spaces,_2SPACES
	Menu,Case,Add,T&abs to spaces,TAB2SPACES
	Menu,Case,Add,&Reverse Selection,REVERSE
Return

; Hotkey to activate menu
; *CapsLock:: ; * will fire the hotkey even if extra modifiers are being held down
LWin & CapsLock::
	OAutoTrim = %A_AutoTrim% ; Store Old AutoTrim Value.
	AutoTrim On  ; Strip out any leading and trailing whitespace from selection

	GoSub, MenuCase ; Create the menu. Done initially to ensure it can be deleted

	Clip()
	If NOT ERRORLEVEL ; Only show menu when something is selected
		Menu, Case, Show

	Menu,Case,DeleteAll ; Clear menu to avoid additional separators being appeneded
	AutoTrim, %OAutoTrim%
Return
