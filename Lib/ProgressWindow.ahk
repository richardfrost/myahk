; Function to display a progress bar with a message
; [Used in ]


ProgressWindow(Message, Time)
{
  ;Example: Progress, b w200, My SubText, My MainText, My Title
  ;Progress, b w150, , Loading AHK, ; Progress Bar: Default, Background: Default, Text: Default.

  Progress, b CBDefault CT008000 CW000000 w150, , %Message%, ; Progress Bar: Default, Background: Black Text: Green.
  Progress, 100 ; Set the position of the bar to 100%.
  Sleep %Time%
  Progress, Off
}