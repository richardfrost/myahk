;************************************************;
; Text Expansions (SQL: PostgreSQL)
;************************************************;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Hotstrings (Text-Expansion)
;
; Syntax :OPTIONS:TRIGGERTEXT::REPLACETEXT
;
; Options:
;  *  An ending character is not required to trigger hotstring (Run immediately)
;  ?  The hotstring will be triggered even if it is inside another word
;  B0 Automatic backspacing is disabled
;  C  Case sensitive
;  C1 Do not conform to typed case
;  O  Omit the ending character of auto-replace hotstrings (space/tab, etc)
;  R  Send the replacement text raw
;     #Hotstring EndChars -()[]{}:;'",.?!`n `t (This directive can be modified)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetTitleMatchMode Regex
#SingleInstance force
#NoTrayIcon
#Hotstring EndChars -()[]{}:;'",.?!`n `t

; Applications to allow text expansion in
GroupAdd, Applications, ^Query - ahk_class wxWindowClassNR
GroupAdd, Applications, \.sql\s ahk_class PX_WINDOW_CLASS

#IfWinActive ahk_group Applications
;;;;;;;;;;;;;;;;;;;
; SQL: PostgreSQL ;
;;;;;;;;;;;;;;;;;;;
:c:add::ADD
:c:all::ALL
:c:alter::ALTER
:c:and::AND
:c:as::AS
:c:asc::ASC
:cO*:avg(::AVG(){Left 1}
:c:between::BETWEEN
:c:constraint::CONSTRAINT
:cO*:count(::COUNT(){Left 1}
:c:create::CREATE
:c:database::DATABASE
:c:database::DATABASE
:c:delete::DELETE
:c:desc::DESC
:cO*:distinct(::DISTINCT(){Left 1}
:c:drop::DROP
:cO*:every(::EVERY(){Left 1}
:c:exists::EXISTS
:c:foreign key::FOREIGN KEY
:c:from::FROM
:c:full::FULL
:c:group by::GROUP BY
:c:having::HAVING
:c:ilike::ILIKE
:c:in::IN
:c:index::INDEX
:c:index::INDEX
:c:inner::INNER
:c:insert::INSERT
:c:into::INTO
:c:is::IS
:c:join::JOIN
:c:left::LEFT
:c:like::LIKE
:c:limit::LIMIT
:cO*:max(::MAX(){Left 1}
:cO*:min(::MIN(){Left 1}
:c:not::NOT
:c:null::NULL
:c:on::ON
:c:or::OR
:c:order by::ORDER BY
:c:primary key::PRIMARY KEY
:c:right::RIGHT
:c:select::SELECT
:c:set::SET
:cO*:sum(::SUM(){Left 1}
:c:table::TABLE
:c:table::TABLE
:c:top::TOP
:c:truncate::TRUNCATE
:c:union::UNION
:c:update::UPDATE
:c:view::VIEW
:c:where::WHERE
;;;;;;;;;;;;;;;;;;;
; SQL: PostgreSQL ;
;;;;;;;;;;;;;;;;;;;
#IfWinActive
