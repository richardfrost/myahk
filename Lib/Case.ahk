; Suite of tools for changing the case of the current selected text.
; [Used in Case.ahk]


;------------------------------
; "Smart Titles" RegEx function - short words keep lower-case 
; thanks to Gogo http://www.autohotkey.com/forum/post-495722.html
Needle =
(join ltrim comments         ; first (in the sentence) acronym (upper case $U3)
  (^|[.!?:;])\W*\K(([A-Z]{2,4})\b
                  |([\w']+))          ; any other first word   (title case $T4)
                                       ; not first small words (lower case $L5)
  |\b(?i)(a|an|and|as|at|but|by|for|from
  |if|in|nor|of|off|on|or|so|the|to|up|yet)\b 
  |\b(?-i)([A-Z]{2,4})\b                  ; not first acronym  (upper case $U6)
  |\b([\w']+)                               ; any other word   (title case $T7)
)


;------------------------------
; Clip() function
;http://www.autohotkey.com/forum/viewtopic.php?p=467710
Clip(Text="", Reselect="") {
   Static BackUpClip, Stored
   If (A_ThisLabel = "Clip")
      Return Stored := "", Clipboard := BackUpClip, BackUpClip := ""
   If Stored
      SetTimer, Clip, Off
   Else {
      Stored := True
      BackUpClip := ClipboardAll
   }
   Clipboard := ""
   If (Text = "") {
      Send, ^c
      ClipWait, 0.15
    If ERRORLEVEL {
    return
    }
   } Else {
      Clipboard := Text
      ClipWait, 3
      Send, ^v
   }
   SetTimer, Clip, -700
   If (Text = "")
      Return Clipboard
   Else If (ReSelect = True) or (Reselect and (StrLen(Text) < 3000)) {
      StringReplace, Text, Text, `r, , All
      Send, % "{Shift Down}{Left " StrLen(Text) "}{Shift Up}"
   }
   Return
   Clip:
   Return Clip()
}


;------------------------------
; TabsToSpaces function
; http://www.autohotkey.com/forum/viewtopic.php?p=495999
TabsToSpaces(Str, outEOL="`r`n", EOL="`n", Omit="`r"){ ;
  Loop Parse, Str, %EOL%, %Omit%             ;
  {                                          ;
     index := 0                              ; Used instead of A_Index
     Loop Parse, A_LoopField                 ;  since we can change it
     {                                       ;
             index++                         ; increment manually
             If (A_LoopField = A_Tab){       ;
                     Loop % 2-Mod(index, 2)  ;
                             r .= " "        ;
                     index := -1             ; it's aligned now,
             }                               ;  so next tab will be 2
             else    r .= A_LoopField        ;
     }                                       ;
     r .= outEOL                             ;
  }                                          ;
  StringTrimRight, r, r, % StrLen(outEOL)    ; remove trailing `r`n
  return r                                   ;
}                                            ;


;============================================================
; Case/String Conversion

UPPER:
  selection := Clip()
  StringUpper,selection,selection
  Clip( selection, False )
Return


LOWER:
  selection := Clip()
  StringLower,selection,selection
  Clip( selection, False )
Return


TITLE:
  Clip( RegExReplace(Clip(),Needle,"$U3$T4$L5$U6$T7"), False )
Return


SENTENCE:
  Clip( RegExReplace(Clip(),"(\w)([^?.:!]*)","$U1$L2"), False )
Return


INVERT:
  Clip( RegExReplace(Clip(),"([^a-z]+)|([^A-Z]+)","$L1$U2"), False )
Return


CAMEL_CASE:
  ; thanks to jpjazzy and Gogo http://www.autohotkey.com/forum/post-495722.html
  ; from phrase separated_by_or-to lowerCamelCase
  ; with customizable delimiters [ -_]
  string := Clip()
  Clip( RegExReplace(string, "(([A-Z]+)|(?i)((?<=[a-z])|[a-z])([a-z]*))[ _-]([a-z]|[A-Z]+)", "$L2$L3$4$T5"))
Return


NO_CAMEL_CASE:
  ; from camelCase to ALL_UPPER
  ; this not working, waiting on Gogo for RegEx version?
  ; Clip(RegExReplace(Clip(), "[a-z]\K[A-Z]", "_$U0"))  
  AutoTrim,Off
  StringCaseSense,On
  selection := Clip()
  lower=abcdefghijklmnopqrstuvwxyzaoa
  upper=ABCDEFGHIJKLMNOPQRSTUVWXYZAOA
  StringLen,length,selection
  iter:=0
  Loop,%length%
  {                                        ; translation notes
    StringLeft,char,selection,1            ; store leftmost char in %char% 
    StringGetPos,pos,lower,%char%          ; look in lower, return -1 if not
    pos+=1                                 ; add 1, 0 means not lowercase alpha
    If pos<>0                              ; if lowercase alpha
    StringMid,char,upper,%pos%,1         ;   convert %char% to uppercase 
    Else ;pos==0                           ; if not lowercase alpha
    {                                      ; 
    StringGetPos,pos,upper,%char%        ; look in upper, return -1 if not
    pos+=1                               ; 
    If pos<>0                            ; if uppercase alpha
    {                                    ; 
      StringMid,char,upper,%pos%,1       ; ? %char% already upper, why get it?
      If iter<>0                         ; don't lead with an underscore
      char=_%char%                     ; insert an underscore
    }                                    ; 
    }                                      ; 
    StringTrimLeft,selection,selection,1   ; remove the leftmost character
    selection=%selection%%char%            ; append %char% to end
    iter+=1                                ; iterate the loop counter and loop
  }
  Clip( selection, False )
Return


UNDERSCORES:
  selection := Clip()
  StringReplace, selection, selection, %A_Space%, _, 1
  Clip( selection, False )
Return


_2SPACES:
  selection := Clip()
  StringReplace, selection, selection, _, %A_Space%, 1
  Clip( selection, False )
Return


TAB2SPACES:
  ;Tabs2Spaces(Str, AlignNum=8, ... )
  ; Replace both 8's with the parameter's name. 
  ; MsgBox, Replace TABs with how many spaces?
  Clip(TabsToSpaces(clip()), False)
return


REVERSE:
  reverseSelection =
  selection := Clip()
  StringReplace, selection, selection, `r`n, % Chr(29), All
    
  Loop Parse, selection
    reverseSelection := A_LoopField . reverseSelection
  
  StringReplace, selection, reverseSelection, % Chr(29), `r`n, All
  clip( selection, False )
Return