;************************************************;
; Inserts today's current date.
; Credit: Richard
;
; Instructions: Press CTRL+; to insert MM/DD/YYYY
; or CTRL+SHIFT+; to insert the date's long form.
;************************************************;
#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.


; Insert date (MM/DD/YYYY)
^;::
  FormatTime, CurrentDate,, ShortDate
  SendInput %CurrentDate%
Return


; Insert Long Date (includes weekday)
+^;::
  FormatTime, CurrentDate,, LongDate
  SendInput %CurrentDate%
return


; Insert Time and Date
!;::
  FormatTime, CurrentDate, 
  SendInput %CurrentDate%
return


; Date/Time Variables:
;A_YYYY Current 4-digit year (e.g. 2004). Synonymous with A_Year. Note: To retrieve a formatted time or date appropriate for your locale and language, use "FormatTime, OutputVar" (time and long date) or "FormatTime, OutputVar,, LongDate" (retrieves long-format date). 
;A_MM Current 2-digit month (01-12). Synonymous with A_Mon. 
;A_DD Current 2-digit day of the month (01-31). Synonymous with A_MDay. 
;A_MMMM Current month's full name in the current user's language, e.g. July 
;A_MMM Current month's abbreviation in the current user's language, e.g. Jul 
;A_DDDD Current day of the week's full name in the current user's language, e.g. Sunday 
;A_DDD Current day of the week's 3-letter abbreviation in the current user's language, e.g. Sun 
;A_WDay Current 1-digit day of the week (1-7). 1 is Sunday in all locales. 
;A_YDay Current day of the year (1-366). The value is not zero-padded, e.g. 9 is retrieved, not 009. To retrieve a zero-padded value, use the following: FormatTime, OutputVar, , YDay0 
;A_YWeek Current year and week number (e.g. 200453) according to ISO 8601. To separate the year from the week, use StringLeft, Year, A_YWeek, 4 and StringRight, Week, A_YWeek, 2. Precise definition of A_YWeek: If the week containing January 1st has four or more days in the new year, it is considered week 1. Otherwise, it is the last week of the previous year, and the next week is week 1. 
;A_Hour Current 2-digit hour (00-23) in 24-hour time (for example, 17 is 5pm). To retrieve 12-hour time as well as an AM/PM indicator, follow this example: FormatTime, OutputVar, , h:mm:ss tt 
;A_Min Current 2-digit minute (00-59). 
;
;A_Sec Current 2-digit second (00-59). 
;A_MSec Current 3-digit millisecond (000-999). To remove the leading zeros, follow this example: Milliseconds := A_MSec + 0 
;A_Now The current local time in YYYYMMDDHH24MISS format. Note: Date and time math can be performed with EnvAdd and EnvSub. Also, FormatTime can format the date and/or time according to your locale or preferences. 
;A_NowUTC The current Coordinated Universal Time (UTC) in YYYYMMDDHH24MISS format. UTC is essentially the same as Greenwich Mean Time (GMT). 
;A_TickCount The number of milliseconds since the computer was rebooted. By storing A_TickCount in a variable, elapsed time can later be measured by subtracting that variable from the latest A_TickCount value. For example: 