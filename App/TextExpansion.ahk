;************************************************;
; Text Expansions (Personal)
;************************************************;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Hotstrings (Text-Expansion)
;
; Syntax :OPTIONS:TRIGGERTEXT::REPLACETEXT
;
; Options:
;  *	An ending character is not required to trigger hotstring (Run immediately)
;  ?	The hotstring will be triggered even if it is inside another word
;  B0	Automatic backspacing is disabled
;  C	Case sensitive
;  C1	Do not conform to typed case
;  O	Omit the ending character of auto-replace hotstrings (space/tab, etc)
;  R	Send the replacement text raw
;  		#Hotstring EndChars -()[]{}:;'",.?!`n `t (This directive can be modified)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
#SingleInstance force
#NoTrayIcon


;;;;;;;;;;;;;;;;;;;
; Generic
;;;;;;;;;;;;;;;;;;;
:oc:brb::Be right back!
:oc:brt::Be right there!
:oc:idk::I don't know.
:oc:ilu::I love you!
:oc:ilu2::I love you too!
:oc:np::No problem!
:oc:ty::Thank you!
:oc:thx::Thanks!
:oc:yw::You're welcome!
:oc:u2::You too!
:oc:lmk::Let me know if there is anything else I can do for you.


;;;;;;;;;;;;;;;;;;;
; Typo Corrections
;;;;;;;;;;;;;;;;;;;
:oc*:heeh::hehe

;;;;;;;;;;;;;;;;;;;
; Support Corrections
;;;;;;;;;;;;;;;;;;;
:oc:joinme::Go to http://join.me and click on 'start meeting'. This will download the application.