;************************************************;
; Check to see if Executor is running, and if not
; start it.
;
; Instructions: Press Win+Z to access Executor
;  Ctrl+Shift+Z To restart Executor
;  Ctrl+Shift+Win+Z To disable the Shortcut
;************************************************;
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
Global ExecutorToggle = 1 ; True for active, included in MyAHK-Build.ahk
#Include %A_ScriptDir%\..\Lib\TransparentWindow.ahk


; Only enable if Executor exists
#If ExecutorExists()
	ExecutorExists()
	{
		EnvGet, OutputVar, Apps
		IfExist %OutputVar%\Executor\Executor.exe
			return true
	}


	StartExecutor(Restart = false) {
		If ExecutorToggle <> 0
		{
			If (Restart)
				Process, Close, Executor.exe ; Close Executor if it is already running

			WinActivate, ahk_class Progman ; Helpful to ensure new window will be activated properly. More Info: http://www.autohotkey.com/board/topic/85227-mozilla-firefox-and-runwinactivate-glitch/

			EnvGet, OutputVar, Apps
			Run, %OutputVar%\Executor\Executor.exe, %OutputVar%\Executor\
		}
	}


	; Start/Open Executor
	#z::StartExecutor()
	!Space::StartExecutor()


	; Restart Executor
	^+z::StartExecutor(true)


	; Disable Executor Shortcut
	^#+z::
		ExecutorToggle := ExecutorToggle<1  ? 1 : 0
		If ExecutorToggle = 0
			TransparentWindow("Executor Disabled", 400) ; Function in Autohotkey.ahk
		If ExecutorToggle = 1
			TransparentWindow("Executor Enabled", 400) ; Function in Autohotkey.ahk
	Return
#If ; End the If Context
