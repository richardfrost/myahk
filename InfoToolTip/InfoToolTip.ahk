;Please note for Link feature XP++ is requiered
/*
[Config]
Hotkey=#q
UseBalloon=1
BGColor=FFFFFF
TextColor=Black

HideOnClick=0
ExitOnClick=0

UpdatePosTimer=40
UpdateTextTimer=400


[Items]
Window=1
Control=1
Mouse=1
Color=1
Time=1

[Script]
*/
;____SCRIPT_____________________________
#NoEnv
#SingleInstance Force
CoordMode, Mouse, Relative
Menu, Tray, NoStandard
Menu, Tray, Add,&Show InfoToolTip,Restart
Menu, Tray, Add,E&xit,Exit
OnMessage(0x404,"AHK_NotifyTrayIcon") ;Will pop up the ToolTip when you click on Tray Icon


Gosub, ReadIni
Hotkey, %Hotkey%,Restart
VarSetCapacity(xc, 20, 0), xc := Chr(20)

MainText=<a>Config</a>`t<a http://www.autohotkey.com/board/topic/41023-infotooltip/>Visit forum</a>`t<a>Hide</a>`t<a>Exit</a>
Sleep, 10 ;requiered, otherwise first tooltip will appear at wrong position

TT:=TT("P=1 ParseLinks CloseButton MaxWidth=300 OnClick=OnTTClick OnClose=OnTTClose" (UseBalloon?" Balloon":"") (BGColor!=""?" BackGround=" BGColor:"") (TextColor!=""?" Color=" TextColor:""))
TS:=TT("P=1 ParseLinks CloseButton MaxWidth=300 OnClick=OnTSClick OnClose=OnTSClose" (UseBalloon?" Balloon":"") (BGColor!=""?" BackGround=" BGColor:"") (TextColor!=""?" Color=" TextColor:""),"","InfoToolTip Config")
Restart:
Gosub, UpdateText
SetTimer, UpdateText,% UpdateTextTimer ? UpdateTextTimer : 500
SetTimer, UpdatePos, % UpdatePosTimer ? UpdatePosTimer : 50
Return ; end of auto-execute

#include TT.ahk

UpdateText:
wininfo:=""
MouseGetPos,,, WinId
If (TT.hWnd=WinId)
  Return
hIcon:=CreateIcon(RGBColor)
If Window {
  WinGetClass, class,ahk_id %WinId%
  WinGetTitle, title,ahk_id %WinId%
WinGetPos,WX,WY,WW,WH,ahk_id %WinId%
  wininfo.="Win:`t<a copy " title ">" title "</a>`n`t<a copy ahk_class " class ">ahk_class " class "</a>  <a copy ahk_id " WinId ">ahk_id " WinId "</a>`n"
          . "`tX, Y: <a copy " WX ", " WY "> " WX ", " WY "</a>  W, H:<a copy " WW ", " WH "> " WW ", " WH "</a>`n"
}
If Control {
  MouseGetPos,,,, ControlClass
  DllCall("GetCursorInfo", "Uint", &xc)
  yc := NumGet(xc,16), xc := NumGet(xc,12)
  ControlGet,ControlId,Hwnd,,%ControlClass%,ahk_id %WinId%
  ControlGetPos,CX,CY,CW,CH,%ControlClass%,ahk_id %WinId%
  wininfo.="Control:`t<a copy " controlClass ">" controlClass "</a>  <a copy " ControlId ">" ControlId "</a>`n`tPos: <a copy " CX ", " CY ">" CX ", " CY "</a>  Size: <a copy " CW ", " CH ">" CW ", " CH "</a>`n"
}
If Mouse {
  MouseGetPos, X, Y
  wininfo.="Mouse:`tScreen: <a copy " xc ", " yc ">" xc ", " yc "</a>  Win: <a copy " x ", " y ">" x ", " y "</a>`n"
}
If Color {
  wininfo.="Color:`tRGB: <a copy " RGBColor ">" RGBColor "</a>  BGR: <a copy " BGRColor ">" BGRColor "</a>`n"
  PixelGetColor,BGRColor,%x%,%y%
  PixelGetColor,RGBColor,%x%,%y%,RGB
}
If Time
  wininfo.="Time:`t<a copy " A_Hour ":" A_Min ":" A_Sec ">" A_Hour ":" A_Min ":" A_Sec "</a>`n"
wininfo.="`n"
If !(GetKeyState("CTRL","P") or GetKeyState("Alt","P") or GetKeyState("Shift","P"))
  TT.Show(wininfo . MainText,"","","InfoToolTip (Ctrl/Alt/Shift + Click to copy)",Color?hIcon:"")
Return

UpdatePos:
  If !(GetKeyState("CTRL","P") or GetKeyState("Alt","P") or GetKeyState("Shift","P"))
    TT.Show()
Return

Config:
  SetTimer, UpdatePos,Off
  SetTimer, UpdateText,Off
  TT.Close(),TS.Show(Settings,"","","InfoToolTip Settings")
Return

OnTSClick(TT,option){
  global
  opt:=SubStr(option,1,InStr(option,"_",1,0)-1)
  %opt%:=SubStr(option,InStr(option,"_",1,0)+1)
  SetTimer, UpdateSettings, -100
}
OnTSClose(TT){
  SetTimer,Restart,-100
}
OnTTClose(TT){
  SetTimer, UpdatePos,Off
  SetTimer, UpdateText,Off
}

UpdateSettings:
Loop,Parse,Options,|
  IniWrite,% %A_LoopField%,%A_ScriptFullPath%,Config,%A_LoopField%
Loop,Parse,AllItems,|
  IniWrite,% %A_LoopField%,%A_ScriptFullPath%,Items,%A_LoopField%
Gosub, ReadIni
Return


OnTTClick(TT,option){
  global
  If InStr(option,"copy "){
    Clipboard:= SubStr(option,6)
  } else if InStr(link:=option,"http://")
    Run iexplore.exe %link%
  else if (option="Config"){
    gosub,Config
    Return
  } else if IsLabel(label:=RegExReplace(link,"[^\w\.]","_"))
    SetTimer % label,-100
  If ExitOnClick
    ExitApp
  else if (option="hide" || HideOnClick){
    TT.Hide()
    SetTimer,UpdateText,Off
    SetTimer,UpdatePos,Off
  }
}

Exit:
  ExitApp
Return

ReadIni:
Settings=
inivars=Hotkey|UseBalloon|BGColor|TextColor|HideOnClick|ExitOnClick|UpdatePosTimer|UpdateTextTimer|Items
Loop,Parse,inivars,|
  IniRead,%A_LoopField%,%A_ScriptFullPath%,Config,%A_LoopField%,%A_Space%

AllItems=Window|Control|Mouse|Color|Time
Loop,Parse,AllItems,|
  IniRead,%A_LoopField%,%A_ScriptFullPath%,Items,%A_LoopField%,%A_Space%
Settings:="Information Items:`n"
Loop,Parse,AllItems,|
  Settings.= "`t" . (%A_LoopField% ? ("(On) - <a " . A_LoopField . "_0>Off</a>") : ("<a " . A_LoopField . "_1>On</a> - (Off)")) . "`t" . A_LoopField . "`n"
Options=UseBalloon|HideOnClick|ExitOnClick
Settings.="`nUser Settings:`n"
Loop,Parse,Options,|
  Settings.= "`t" . (%A_LoopField% ? ("-  (On) - <a " . A_LoopField . "_0>Off</a>") : ("<a " . A_LoopField . "_1>On</a> - (Off)")) . "`t`t" . A_LoopField . "`n"
Return

AHK_NotifyTrayIcon(wParam, lParam) {
   If (lparam = 0x201 or lparam = 0x202)
      SetTimer, Restart, -100
}

CreateIcon(backclr){
  static
  width := 16, height := 16
  if !(hdcScreen := DllCall("GetDC","uint",0))
    return
  VarSetCapacity(buf,40,0), NumPut(40,buf), NumPut(1,buf,12,"ushort")
  NumPut(16,buf,4), NumPut(16,buf,8), NumPut(32,buf,14,"ushort")

  ; Note that a compatible bitmap's format depends on the current display settings.
  ; Changing the display depth after creating the icon may cause colour loss.
  ;if hbm := DllCall("CreateCompatibleBitmap","uint",hdcScreen,"int",width,"int",height)

  if hbm := DllCall("CreateDIBSection","uint",hdcScreen,"uint",&buf,"uint",0
                ,"uint*",pBits,"uint",0,"uint",0)
  {
    if hdc := DllCall("CreateCompatibleDC","uint",hdcScreen)
    {
      ; Select the bitmap into a device context to draw on it.
      ; Note that the previous bitmap should always be reselected afterwards.
      if hbm_old := DllCall("SelectObject","uint",hdc,"uint",hbm)
        DllCall("SelectObject","uint",hdc,"uint",hbm_old)

      ; Since GDI doesn't support alpha-blending, we must manually set the
      ; pixels to our background colour. We must also set the alpha component
      ; of each bar pixel to 255, otherwise bars become mostly invisible.
      offset = 0
      Loop, %height% {
        Loop, %width% {
          px := NumGet(pBits+offset)
          NumPut(px ? 255<<24|px : backclr, pBits+offset)
          offset += 4
        }
      }

      VarSetCapacity(mask,64,0)
      hbm_mask := DllCall("CreateBitmap","int",width,"int",height,"uint",1,"uint",1,"uint",&mask)

      DllCall("DeleteDC","uint",hdc)
    }
  }
  DllCall("ReleaseDC","uint",0,"uint",hdcScreen)

  hicon_old := hicon

  VarSetCapacity(ii,20,0), NumPut(1,ii,0), NumPut(hbm,ii,16), NumPut(hbm_mask,ii,12)
  Return hicon := DllCall("CreateIconIndirect","uint",&ii)
}
