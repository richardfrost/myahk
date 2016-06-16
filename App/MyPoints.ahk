; MyPoints
Words = Adult,Aeroplane,Air,Aircraft Carrier,Airforce,Airport,Album,Alphabet,Apple,Arm,Army,Baby,Baby,Backpack,Balloon,Banana,Bank,Barbecue,Bathroom,Bathtub,Bed,Bed,Bee,Bible,Bible,Bird,Bomb,Book,Boss,Bottle,Bowl,Box,Boy,Brain,Bridge,Butterfly,Button,Cappuccino,Car,Car-race,Carpet,Carrot,Cave,Chair,Chess Board,Chief,Child,Chisel,Chocolates,Church,Church,Circle,Circus,Circus,Clock,Clown,Coffee,Coffee-shop,Comet,Compact Disc,Compass,Computer,Crystal,Cup,Cycle,Data Base,Desk,Diamond,Dress,Drill,Drink,Drum,Dung,Ears,Earth,Egg,Electricity,Elephant,Eraser,Explosive,Eyes,Family,Fan,Feather,Festival,Film,Finger,Fire,Floodlight,Flower,Foot,Fork,Freeway,Fruit,Fungus,Game,Garden,Gas,Gate,Gemstone,Girl,Gloves,God,Grapes,Guitar,Hammer,Hat,Hieroglyph,Highway,Horoscope,Horse,Hose,Ice,Ice-cream,Insect,Jet fighter,Junk,Kaleidoscope,Kitchen,Knife,Leather jacket,Leg,Library,Liquid,Magnet,Man,Map,Maze,Meat,Meteor,Microscope,Milk,Milkshake,Mist,Money $$$$,Monster,Mosquito,Mouth,Nail,Navy,Necklace,Needle,Onion,PaintBrush,Pants,Parachute,Passport,Pebble,Pendulum,Pepper,Perfume,Pillow,Plane,Planet,Pocket,Post-office,Potato,Printer,Prison,Pyramid,Radar,Rainbow,Record,Restaurant,Rifle,Ring,Robot,Rock,Rocket,Roof,Room,Rope,Saddle,Salt,Sandpaper,Sandwich,Satellite,School,Ship,Shoes,Shop,Shower,Signature,Skeleton,Slave,Snail,Software,Solid,Space Shuttle,Spectrum,Sphere,Spice,Spiral,Spoon,Sports-car,Spot Light,Square,Staircase,Star,Stomach,Sun,Sunglasses,Surveyor,Swimming Pool,Sword,Table,Tapestry,Teeth,Telescope,Television,Tennis racquet,Thermometer,Tiger,Toilet,Tongue,Torch,Torpedo,Train,Treadmill,Triangle,Tunnel,Typewriter,Umbrella,Vacuum,Vampire,Videotape,Vulture,Water,Weapon,Web,Wheelchair,Window,Woman,Worm,X-ray
StringSplit,WordArray,Words,`,
Count = 100
MyPointsUrl = https://www.mypoints.com/emp/u/mysearch.vm
Searches = 0
MinSleep = 5000
MaxSleep = 20000
SleepTime = 4500 ; Overridden if using random sleep times.

Sleep 3000

; Random Loop
loop, %Count%
{
	Random, RandomNumber,1,234
	random_word := WordArray%RandomNumber%

	; Activate Firefox if it isn't the active window
	IfWinNotActive, ahk_class MozillaWindowClass
		WinActivate, ahk_class MozillaWindowClass

	If WinActive("ahk_class MozillaWindowClass")
	{
		BlockInput On
		Send !d
		Sleep 50
		Send %MyPointsUrl%?q=%random_word%{Enter}
		Searches++ ; Keep track of how many searches have been performed

		Random, SleepTime, %MinSleep%, %MaxSleep% ; Comment out this line to disable random sleep times.

		; Show Information (This causes sleep, so comment out the sleep line at end of loop if using it.)
		WinGetPos,x,y,w,h,A 				; Get active window's width/heigth
		boxW:=220, boxH=38 ; Variables for TransparentWindow box size (224, 55)
		BlockInput Off
		TransparentWindow("#"Searches " - (" RandomNumber ") " random_word " - " SleepTime,SleepTime,12,"teal",0,0,x+w/2-boxW/2,y+h/2-boxH/2,boxW,boxH)
	}
	Else
	{
		MsgBox,4112,Error,Firefox is not the active window, exiting.`n`nSearches performed: %Searches%
		ExitApp
	}
}
MsgBox,4160,Searches,Number of searches performed: %Searches%
Return


; Control+Alt+Space to exit loop
^!SPACE::
MsgBox,4160,Searches,Exiting application at user's request.`n`nNumber of searches performed: %Searches%
ExitApp


; Transparent Window
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

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	; Return to previous active window
	Send !{ESC}
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	if (xCoord = 0 or yCoord = 0 or boxW = 0 or boxH = 0)
		Gui, Show, NoActivate
	else 	; Centers on Screen if no x,y coordinates provided.
		Gui, Show, % "x"xCoord "y"yCoord "w"boxW "h"boxH "NoActivate"

	Sleep %Time% ; 550 is a good amount of time
	Gui, Destroy
}
