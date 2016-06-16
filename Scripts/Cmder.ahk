;************************************************;
; Start Cmder if it isn't already running.
; Credit: Richard Frost
;
; Instructions: Create an Environmental Varible 
; Named "Cmder" and set its value to the full path
; to the Cmder executable.
; To activate it, press CTRL+` (Backtick/Tilde)
;************************************************;
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#NoTrayIcon
#SingleInstance force
SetTitleMatchMode Regex
#Include %A_ScriptDir%\..\Lib\ParentDir.ahk

#IfWinNotExist ^Cmder$ ahk_class VirtualConsoleClass
^`::
	EnvGet, Executable, Cmder
	IfExist, %Executable% {
		Run %Executable%
	else {
		EnvGet, Executable, Apps
		Executable := Executable . "\System\Cmder\Cmder.exe"

		IfExist, %Executable%
			Run %Executable%
		else {
			EnvGet, Executable, Comspec
			Run %Executable% /k "CD /D `%UserProfile`% & ECHO Couldn't find Cmder.exe & ECHO Create an environmental variable named 'Cmder' that points to 'Cmder.exe'"
		}
	}
Return
#IfWinNotExist