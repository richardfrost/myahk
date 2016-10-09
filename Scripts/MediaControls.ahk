;************************************************;
; Media Controls
;
; Instructions:
;   Function Keys:
;     Win+F9  Mute
;     Win+F10 Previous
;     Win+F11 Play/Pause
;     Win+F12 Next
;
;   Cursor Keys:
;     Win+Insert Mute
;     Win+PgUp   Volume Up
;     Win+PgDn   Volume Down
;     Win+Delete Previous
;     Win+Home   Play/Pause
;     Win+End    Next
;************************************************;
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.

; Function Keys
#F9::Send {Volume_Mute}
#F10::Send {Media_Prev}
#F11::Send {Media_Play_Pause}
#F12::Send {Media_Next}

; Cursor Keys
#PgUp::Send {Volume_Up}
#PgDn::Send {Volume_Down}
#Insert::Send {Volume_Mute}
#Delete::Send {Media_Prev}
#Home::Send {Media_Play_Pause}
#End::Send {Media_Next}
