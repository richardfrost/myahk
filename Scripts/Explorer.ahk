;************************************************;
; Open specified folders in Explorer.
; Credit: Lifehacker
;
; Instructions: Specify path in script to be
; executed with the Win+W shortcut to start
; Windows Explorer.
;************************************************;
#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
SetTitleMatchMode Regex ; Required if not specified elsewhere in the script.
#Include %A_ScriptDir%\..\Lib\ParentDir.ahk

; Close various windows with CTRL+W (System windows may require admin privileges)
; (GroupAdd Lines are also included in MyAHK-Build.ahk, duplicates are ignored)
GroupAdd, CloseWindows, ahk_class FM ahk_exe 7zFM.exe               ; 7-Zip
GroupAdd, CloseWindows, Calculator ahk_class CalcFrame              ; Calculator (>Win 10)
GroupAdd, CloseWindows, Calculator ahk_class ApplicationFrameWindow ; Calculator (Win 10)
GroupAdd, CloseWindows, Notepad$ ahk_class Notepad                  ; Notepad
GroupAdd, CloseWindows, ahk_class Microsoft-Windows-Tablet-Snipper  ; Snipping Tool
GroupAdd, CloseWindows, ahk_class USurface_\d{5} ahk_exe Steam.exe  ; Steam
GroupAdd, CloseWindows, ahk_class HelpPane                          ; System: Windows F1 Help Pane
GroupAdd, CloseWindows, Task Manager ahk_class TaskManagerWindow    ; System: Task Manager
GroupAdd, CloseWindows, ahk_class #32770                            ; System: Properties/Applet window
GroupAdd, CloseWindows, ahk_class MMCMainFrame                      ; System: MMC windows

; Disable the F1 help window, helpctr.exe
; (GroupAdd Lines are also included in MyAHK-Build.ahk, duplicates are ignored)
GroupAdd, DisableHelpF1, ahk_class CabinetWClass  ; Win8 Explorer
GroupAdd, DisableHelpF1, ahk_class WorkerW        ; Win8 Desktop
GroupAdd, DisableHelpF1, ahk_class Progman        ; Win7 Explorer

; Close various windows with CTRL+W (System windows may require admin privileges)
#IfWinActive ahk_group CloseWindows
	^w::WinClose
#IfWinActive

; Disable the F1 help window, helpctr.exe
#IfWinActive ahk_group DisableHelpF1
	F1::Return
#IfWinActive

; Open %SyncHome% folder, switch to currently running instance, or open user Downloads
*#w::
	EnvGet, OutputVar, SyncHome

	; If %SyncHome% doesn't exist or doesn't point to an existing folder, use %UserProfile%\Downloads.
	IfNotExist, %OutputVar%
	{
		EnvGet, OutputVar, UserProfile
		OutputVar := OutputVar . "\Downloads"
	}

	OutputVar := OutputVar . "\" ; ParentDir needs to have the trailing backslash when ending on a folder.
	DirName := ParentDir(OutputVar)

	; Open desired folder if it is not already open
	IfWinNotExist, %DirName% ahk_class CabinetWClass
		Run, Explore %OutputVar%
	Else ; If there is already an instance running (Window exists), either make it active, or open another (shift)
	{
		If (GetKeyState("Shift"))
			Run, Explore %OutputVar%
		Else
			WinActivate %DirName% ahk_class CabinetWClass
	}
Return

; Open %Working% folder, switch to currently running instance, or open user Downloads
+#d::
	EnvGet, OutputVar, Working ; Environmental Variable Path

	; If %Working% doesn't exist or doesn't point to an existing folder, use %UserProfile%\Downloads.
	IfNotExist, %OutputVar%
	{
		IfWinNotExist, Desktop ahk_class CabinetWClass ; Open the desktop if it is not already open.
			Run, Explore "Shell:Desktop"
		Else ; If the desktop is already open, make it active.
			WinActivate Desktop ahk_class CabinetWClass
	}
	Else
	{
		OutputVar := OutputVar . "\" ; ParentDir needs to have the trailing baskslash when ending on a folder.
		DirName := ParentDir(OutputVar)

		IfWinNotExist, %DirName% ahk_class CabinetWClass ; Open the Working directory if it is not already open.
			Run, Explore %OutputVar%
		Else ; If the WorkingDir is already open, make it active.
			WinActivate %DirName% ahk_class CabinetWClass
	}
Return

; Explore to Desktop
;+#d::
;	IfWinNotExist, Desktop ahk_class CabinetWClass ; Open the desktop if it is not already open.
;		Run, Explore "Shell:Desktop"
;	Else ; If the desktop is already open, make it active.
;		WinActivate Desktop ahk_class CabinetWClass
;Return

; Lock workstation
^!l::Run, % "rundll32.exe user32.dll,LockWorkStation"

; Remap Right Control key to a Windows Key.
;RCtrl::LWin
