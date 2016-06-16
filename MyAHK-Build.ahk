;*****************************************************************;
; AutoInclude - Combine several AHK scripts into a single script.
;*****************************************************************;
#SingleInstance Force
#NoEnv			; Recommended for performance and compatibility with future AutoHotkey releases.
#NoTrayIcon		; Disable tray icon
SendMode Input	; Recommended for new scripts due to its superior speed and reliability.
SetTitleMatchMode Regex


MyWorkingDir = %A_ScriptDir%
OutputFileName = %MyWorkingDir%\MyAHK\MyAHK.ahk

; Check to see if there is an existing combined script, and offer to use it.
IfExist, %OutputFileName%
	MsgBox, 262164, Combined Script Detected, Would you like to overwrite the existing MyAHK.ahk file? ; always on top: 262144
		IfMsgBox No
			Goto, Compile

; @IncludeFolders:
; A list of all the folders to search:
IncludeFolders =
(comments ltrim
	%MyWorkingDir%\Scripts
)

; @IncludeOrCombine:
;IncludeOrCombine = INCLUDE
IncludeOrCombine = COMBINE

;************************************************;
; Display progress bar to indicate AHK startup
;************************************************;

	;Example: Progress, b w200, My SubText, My MainText, My Title

	;Progress, b w150, , Loading AHK, ; Progress Bar: Default, Background: Default, Text: Default.
	Progress, b CBDefault CT008000 CW000000 w150, , Loading AHK, ; Progress Bar: Default, Background: Black Text: Green.
	Progress, 100 ; Set the position of the bar to 100%.
	Sleep, 550
	Progress, Off


;************************************************;
; End of the customizable section
;************************************************;

;Let's collect all the Auto-Execute lines from each file,
;as well as all the code from each file,
;and create a new script that includes all of them!

InitializeFunctions =
IncludeFiles =

;We have to "Split" the folders list for each line:
Loop Parse, IncludeFolders, `n
{
	IncludeFolder := A_LoopField
	;Set the Include Path:
	IncludeFiles =
	(ltrim
		%IncludeFiles%
	)

	;Let's load all the files from the folder:
	SetWorkingDir %IncludeFolder%
	Loop *.ahk,0,1 ;recursive
	{
		; Ignore any files with "exclude" in the title:
		If RegexMatch(A_LoopFileFullPath, "i)\bEXCLUDE\b")
			continue

		; We are going to create an "#Include" directive for each file, but just in case
		; there is an auto-execute initialize function, let's be sure to copy that.

		FirstLineOfFile =
		FileReadLine FirstLineOfFile, %A_LoopFileFullPath%, 1

		;See if the line is an "Init":
		IfInString FirstLineOfFile, _init(
		{
			InitializeFunctions =
			(ltrim
				%InitializeFunctions%
				%FirstLineOfFile%
			)
		}
		If RegexMatch(FirstLineOfFile, "i);.*auto.*execute") {
			; Create a label:
			label := A_LoopFileFullPath
			label := RegExReplace(label, "[-+'=,.!$#() `t\^[\]\\]", "_") ; Replace all filename characters that are not valid for labels
			InitializeFunctions =
			(ltrim
				%InitializeFunctions%
				GoSub %label%_Init ; Run the Auto-Execute code for this file
			)
			IncludeFiles =
			(ltrim
				%IncludeFiles%
				%label%_Init: ; Run the Auto-Execute code for this file
			)
		}


		If IncludeOrCombine = COMBINE
		{	FileRead FullFile, %A_LoopFileFullPath%
			IncludeFiles =
			(ltrim
				%IncludeFiles%

				; #############################################################################
				; ###################################### Beginning of file %A_LoopFileFullPath%
				; #############################################################################
				%FullFile%
				; #############################################################################
				; ###################################### End Of File %A_LoopFileFullPath%
				; #############################################################################
			)
		} Else {
			IncludeFiles =
			(ltrim
				%IncludeFiles%
				#Include %A_LoopFileFullPath%
			)
		}
	}
}

; If old file exists, delete it.
FileDelete %OutputFileName%

;Create our new file:
FileAppend ,
(ltrim
	; This file was automatically created from all the scripts found in the IncludeFolder

	; Display Window to indicate AHK startup
	Gui +LastFound +AlwaysOnTop -Caption +ToolWindow  ; +ToolWindow avoids a taskbar button and an alt-tab menu item.
	Gui, Color, black
	Gui, Font, s18  ; Set a large font size (18-point).
	WinSet, Transparent, 205
	Gui, Add, Text, vMyText cgreen, Loading AHK
	Gui, Show, NoActivate  ; NoActivate avoids deactivating the currently active window.
	Sleep 450
	Gui, Destroy

	#SingleInstance Force
	#NoEnv			; Recommended for performance and compatibility with future AutoHotkey releases.
	#NoTrayIcon		; Disable tray icon
	SendMode Input	; Recommended for new scripts due to its superior speed and reliability.
	SetTitleMatchMode Regex
		; Regex Examples:
		; SetTitleMatchMode 1: #IfWinActive MyTitle$
		; SetTitleMatchMode 2: #IfWinActive MyTitle
		; SetTitleMatchMode 3: #IfWinActive ^MyTitle$


	; Global Variables:
	Global CombinedScript = 1     ; Allow for individual scripts to check if they are standalone with '#If (!CombinedScript)'
	Global BlockMouseToggle = 0   ; Set default value for BlockMouseToggle variable
	Global ExecutorToggle = 1     ; True for active
	Global CMDToggle = 1          ; True for active


	; Close various windows with CTRL+W: (System windows may require admin privileges)
	GroupAdd, CloseWindows, ahk_class HelpPane                          ; System: Windows F1 Help Pane
	GroupAdd, CloseWindows, Task Manager ahk_class TaskManagerWindow    ; System: Task Manager
	GroupAdd, CloseWindows, ahk_class #32770                            ; System: Properties/Applet window
	GroupAdd, CloseWindows, ahk_class MMCMainFrame                      ; System: MMC windows
	GroupAdd, CloseWindows, ahk_class USurface_\d{5} ahk_exe Steam.exe  ; Steam
	GroupAdd, CloseWindows, ahk_class FM ahk_exe 7zFM.exe               ; 7-Zip

  ; Explorer Group to disable F1 help in Explorer.ahk
  GroupAdd, DisableHelpF1, ahk_class CabinetWClass  ; Win8 Explorer
  GroupAdd, DisableHelpF1, ahk_class WorkerW        ; Win8 Desktop
  GroupAdd, DisableHelpF1, ahk_class Progman        ; Win7 Explorer


	; Group for annoying nag screens
	GroupAdd, NagWindows, ^This is an unregistered copy$ ahk_class #32770   ; Sublime Text
	GroupAdd, NagWindows, ^Please Donate$ ahk_class SunAwtDialog            ; FileBot
	GroupAdd, NagWindows, ^Sublime Text$ ahk_class #32770, Buy Now          ; Sublime SFTP


	SetTimer, Nags, 30

	; Watch for nag screens
	Nags:
		IfWinActive ahk_group NagWindows
			WinClose
	Return

	%IncludeFiles%
)
, %OutputFileName%


; Offer to compile the script to allow running without having AHK installed
Compile:
MsgBox, 262180, Compile?, Would you like to compile the script to run standalone? ; 36 + 262144

	IfMsgBox No
		Return

	IfMsgBox Yes
	{
		; Get the path to AutoHotKey.exe
		SplitPath, A_AhkPath,,AHK_Dir
		Compile = "%AHK_Dir%\Compiler\Ahk2Exe.exe" /in "%OutputFileName%"

		; Delete old MyAHK.exe if it exists
		StringTrimRight, CompiledFileName, OutputFileName, 3
		CompiledFileName = %CompiledFileName%exe
		FileDelete %CompiledFileName%

		; Compile script to MyAHK.exe
		RunWait, %Compile%
	}


AllowUAC:
MsgBox, 262180, Allow UAC Interaction?, Would you like this script to be able to interact with UAC-protected windows? ; 36 + 262144
	IfMsgBox Yes
	{
		Run, %MyWorkingDir%\Bin\EnableUIAccess.ahk %CompiledFileName%
		MsgBox ,262208, How To Use, The compiled file, MyAHK.exe, must be placed in a trusted location such as C:\Program Files\.`n`nThe executable will not run on any other PC unless you install the certificate. It can be installed by following these steps:`n`n1. Open the properties for the executable.`n2. Click on the "Digital Signatures" tab.`n3. Double-click the Signature.`n4. Click "View Certificate" and then click "Install Certificate".`n5. Choose "Current User" and follow the wizard to install it.`n6. Store it in the Trusted Root Certificate Authorities. ; 64 + 262144

		; Open Program Files to help copy MyAHK.exe
		EnvGet, OutputVar, ProgramFiles
		IfWinNotExist, Program Files
			Run, Explore %OutputVar%
		Else,
			WinActivate, Program Files
	}


FileDelete, %CompiledFileName%~*.bak ; Auto-remove backup compiled file.
RemoveBAK:
IfExist, %CompiledFileName%~*.bak
{
	MsgBox, 262180, Remove Backup Files?, Would you like to remove backup files? ; 36 + 262144
		IfMsgBox No
			Return
		IfMsgBox Yes
		{
			FileDelete, %CompiledFileName%~*.bak
		}
}


; Exit App
Return
