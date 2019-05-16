#SingleInstance, Force
#Persistent
#Include TransSplashText.ahk


TooltipDelay := 1000

WaterDelay := 15000
;;;;;10min - 5 water
;;;;;31min - 13 water
;;;;;49 min - 20 water
;;;;;60 min - 25 water
;;;;;256 min - 100 water

FoodDelay := WaterDelay*2


WaterButton := "8"
FoodButton := "9"

Debug := false

w := Debug ? 1100 : 800
Enabled := true
GuiN := 99
GoSub, ToggleFn

LastDrink := A_Now
LastEat := A_Now
LastTest := A_Now

DrinkTime := LastDrink
EatTime := LastEat

Loop{
	if (DrinkTime<=0)
	{	
		if (Enabled && WinActive("ahk_class UnrealWindow"))
			GoSub, Drink
	}
	else
	{
		DrinkTime := LastDrink
		EnvSub, DrinkTime, %A_Now%, seconds 
		DrinkTime := WaterDelay + DrinkTime

		DrinkTimeM := DrinkTime/60
		DrinkTimeS := round("0" substr(DrinkTimeM, InStr(DrinkTimeM, "."))*60,0)
		DrinkTimeM := substr(DrinkTimeM, 1, InStr(DrinkTimeM, ".")-1)

		DrinkTimeDisp := DrinkTimeM "m " DrinkTimeS "s"
	}

	if (EatTime<=0)
	{	
		if (Enabled && WinActive("ahk_class UnrealWindow"))
			GoSub, Eat
	}
	else
	{
		EatTime := LastEat
		EnvSub, EatTime, %A_Now%, seconds
		EatTime := FoodDelay + EatTime

		EatTimeM := EatTime/60
		EatTimeS := round("0" substr(EatTimeM, InStr(EatTimeM, "."))*60,0)
		EatTimeM := substr(EatTimeM, 1, InStr(EatTimeM, ".")-1)

		EatTimeDisp := EatTimeM "m " EatTimeS "s"
	}
	
	
	if (Debug){
		TestTime := LastTest
		EnvSub, TestTime, %A_Now%, seconds
		
		TestTimeM := TestTime/60
		TestTimeS := round("0" substr(TestTimeM, InStr(TestTimeM, "."))*60,0)
		TestTimeM := substr(TestTimeM, 2, InStr(TestTimeM, ".")-2)
		
		TestTimeDisp := " (" TestTimeM "m " TestTimeS "s)"
	}
	

	GoSub, UpdateGUI
	
	
	Sleep TooltipDelay
}

return

Eat:
	Send {%FoodButton%}
	LastEat := A_Now
return

Drink:
	Send {%WaterButton%}
	LastDrink := A_Now
return


F9::
	LastEat := A_Now
	LastDrink := A_Now
	LastTest := A_Now
return


F11::
	Enabled := Enabled ? False : True
	GoSub, ToggleFn
return

ToggleFn:
	Gui, %GuiN%:Destroy
	EnabledText := Enabled ? "ON" : "OFF"
	TransSplashText_On(GuiN,"F11:", EnabledText, "Auto (Food: " EatTimeDisp ") (Water: " DrinkTimeDisp ") (F9: Reset)" TestTimeDisp, hwndText, hwndTextS,,"White","Black",,0,0,w)
return


UpdateGUI:
	TransSplashText_Update("Auto (Food: " EatTimeDisp ") (Water: " DrinkTimeDisp ") (F9: Reset)" TestTimeDisp,hwndText,hwndTextS)
return
