; Function to display a Message in a transparent window centered on the screen, or active window (provide x,y,w,h).
; [Used in AutoHotKey.ahk, CMDPrompt, DisableKeyboard.ahk, DisableMouse.ahk, Executor.ahk, AlwaysOnTopToggle.ahk]


; TransparentWindow("Message",time,[fontSize], ["fontColor"], ["backColor"], [transparency], [xCoord],[yCoord],[boxW],[boxH])
; Colors: http://www.autohotkey.com/docs/commands/Progress.htm#colors
TransparentWindow(Message, Time, fontSize = 0, fontColor = 0, backColor = 0, transparency = 0, xCoord = 0, yCoord = 0, boxW = 0, boxH = 0)
{
  Static ; set variables to static by default inside this function
  
  If (fontSize = 0)
    fontSize:=18
  
  If (backColor = 0)
    backColor:="black"
  
  If (fontColor = 0)
    fontColor:="green"
  
  If (transparency = 0)
    transparency:=205
  
  Gui +LastFound +AlwaysOnTop -Caption +ToolWindow  ; +ToolWindow avoids a taskbar button and an alt-tab menu item.
  Gui, Color, %backColor%
  Gui, Font, % "s"fontSize  ; Set a large font size (18-point).
  Gui, Add, Text, vMyText c%fontColor%, %Message% 
  WinSet, Transparent, %transparency%
  
  if (xCoord = 0 or yCoord = 0 or boxW = 0 or boxH = 0)
    Gui, Show, NoActivate
  else  ; Centers on Screen if no x,y coordinates provided.
    Gui, Show, % "x"xCoord "y"yCoord "w"boxW "h"boxH "NoActivate"

  Sleep %Time% ; 550 is a good amount of time
  Gui, Destroy
}

; Old Version (Message, Time)
; Retrieve box coordinates and size
; Gui +LastFound
; WinGetPos X,Y,W,H   ; Get window position and dimensions
; msgbox, X (Top-left): %x%`nY (Top-left): %y%`nGUI W: %w%`nGUI H: %h%
; Original Function
;TransparentWindow(Message, Time)
;{
; Static ; set variables to static by default inside this function
; 
; Gui +LastFound +AlwaysOnTop -Caption +ToolWindow  ; +ToolWindow avoids a taskbar button and an alt-tab menu item.
; Gui, Color, black
; Gui, Font, s18  ; Set a large font size (18-point).
; WinSet, Transparent, 205
; Gui, Add, Text, vMyText cgreen, %Message% 
; Gui, Show, ,, NoActivate  ; NoActivate avoids deactivating the currently active window.
; Sleep %Time% ; 550 is a good amount of time
; Gui, Destroy
;}