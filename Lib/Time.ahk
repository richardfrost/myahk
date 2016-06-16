; Time.ahk
; Functions for dealing with Time


; Examples to keep track of how long something has been running.
; Example 1:
;StartTime := A_TickCount
;Sleep, 3350
;ElapsedTime := A_TickCount - StartTime
;MsgBox % FormatSeconds(ElapsedTime//1000)

; Example 2:
;START_TIME := A_Now
;Sleep 3350
;EnvSub, CALC_RUNTIME, 2
;CALC_RUNTIME -= 2
;EnvSub, ELAPSED_TIME, %START_TIME%, seconds
;MsgBox % FormatSeconds(ELAPSED_TIME)


; Convert the specified number of seconds to hh:mm:ss format.
FormatSeconds(NumberOfSeconds)
{
    time = 19990101  ; *Midnight* of an arbitrary date.
    time += %NumberOfSeconds%, seconds
    FormatTime, mmss, %time%, mm:ss
    return NumberOfSeconds//3600 ":" mmss  ; This method is used to support more than 24 hours worth of sections.
}