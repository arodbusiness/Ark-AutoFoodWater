#SingleInstance, Force
#Persistent
#Include TransSplashText.ahk

Delay := 3000
TooltipDelay := 2500

WaterButton := 8
FoodButton := 8


Enabled := true
GoSub, UpdateGUI

Loop{
	if (Enabled){
		;;X := 0.392*A_ScreenWidth
		;;Y := 0.635*A_ScreenHeight
		;;PixelGetColor, Color, %X%, %Y%
		;;B := Color >> 16 & 0xFF, G := Color >> 8 & 0xFF, R := Color & 0xFF

		

		GuiN := 97
		
		
		X := 0.85*A_ScreenWidth
		Y := 0.805*A_ScreenHeight
		
		
		Xstart := 1881
		Xend := 1896
		
		
		Ystart := 873
		Yend := 882
		
		File := "Water.txt"
		RunWait, %A_ScriptDir%\Capture2Text\Capture2Text_CLI.exe --debug --screen-rect "%Xstart% %Ystart% %Xend% %Yend%" -o %File%,,Hide
		FileCopy, Capture2Text\debug_enhanced.png, Water.png, 1		;;Copy Debug Image File for each

		if FileExist(File){
			FileRead, WaterText, %File%
			WaterText := FixNumberText(WaterText)
			WaterCurrent := WaterText
		}
		
		
		;;if (G<60 && B<80 && WinActive("ahk_class UnrealWindow"))
		if (WaterCurrent<4 && WaterCurrent!="" && WinActive("ahk_class UnrealWindow") && Enabled){
			TransSplashText_On(GuiN,,,"(" WaterCurrent ") Thirsty",,"4488FF","Black",,X,Y)
			Send {%WaterButton%}
		}
		else
		{
			TransSplashText_On(GuiN,,,"(" WaterCurrent ") Not Thirsty",,"4488FF","Black",,X,Y)
		}
		Sleep, TooltipDelay
		Gui, %GuiN%:Destroy		
		
		
		

		Ystart := 927
		Yend := 936
		
		File := "Food.txt"
		RunWait, %A_ScriptDir%\Capture2Text\Capture2Text_CLI.exe --debug --screen-rect "%Xstart% %Ystart% %Xend% %Yend%" -o %File%,,Hide
		FileCopy, Capture2Text\debug_enhanced.png, Food.png, 1		;;Copy Debug Image File for each

		if FileExist(File){
			FileRead, FoodText, %File%
			FoodText := FixNumberText(FoodText)
			FoodCurrent := FoodText
		}
		
		

		
		Sleep 2500
		
		;;X := 0.392*A_ScreenWidth
		;;Y := 0.594*A_ScreenHeight
		;;PixelGetColor, Color, %X%, %Y%
		;;B := Color >> 16 & 0xFF, G := Color >> 8 & 0xFF, R := Color & 0xFF


		GuiN := 98
		Y := 0.85*A_ScreenHeight

		
		;;if (G<60 && B<80 && WinActive("ahk_class UnrealWindow"))
		if (FoodCurrent<4 && FoodCurrent!="" && WinActive("ahk_class UnrealWindow") && Enabled){
			TransSplashText_On(GuiN,,,"(" FoodCurrent ") Hungry",,"44FF88","Black",,X,Y)
			Send {%FoodButton%}
		}
		else
		{
			TransSplashText_On(GuiN,,,"(" FoodCurrent ") Not Hungry",,"44FF88","Black",,X,Y)
		}
		Sleep, TooltipDelay
		Gui, %GuiN%:Destroy
		
	}
	Sleep Delay
}

return



CheckInv(){

	if (A_ScreenWidth>=1920){
		;;;;;;1920x1080
		X := 0.438*A_ScreenWidth
		Y := 0.026*A_ScreenHeight
	}
	else
	{
		;;;;;;1680x1050
		X := 0.440*A_ScreenWidth
		Y := 0.08*A_ScreenHeight
	}
	
	
	PixelGetColor, Color, %X%, %Y%
	B := Color >> 16 & 0xFF, G := Color >> 8 & 0xFF, R := Color & 0xFF
	
	if (R<165 && G>220 && B>240 && WinActive("ahk_class UnrealWindow")){
		RetVal := true
		X := 0.396*A_ScreenWidth
		Y := 0.110*A_ScreenHeight
		PixelGetColor, Color, %X%, %Y%
		B := Color >> 16 & 0xFF, G := Color >> 8 & 0xFF, R := Color & 0xFF
		if (R<50 && G<120 && B<255){
			;;MouseGetPos , MouseX, MouseY
			;;MouseClick, Left, X, Y, 2, 0
			;;MouseMove, MouseX, MouseY, 0
		}
	}
	else
		RetVal := false
			
	Sleep 500
	return RetVal
}


F11::
	if (Enabled)
		Enabled := False
	else
		Enabled := True
	GoSub, UpdateGUI
return


UpdateGUI:
	Gui, 99:Destroy
	if (Enabled)
		EnabledText := "ON"
	else
		EnabledText := "OFF"
	TransSplashText_On(99,"F11:", EnabledText, "Auto Food/Water",,"White","Black",,0,0)
return



FixNumberText(TextVar){
	TextVar := RegexReplace(TextVar, "i)o|u", "0")
	TextVar := RegexReplace(TextVar, "i)\]|\||i|t", "1")
	TextVar := RegexReplace(TextVar, "i)s", "5")
	TextVar := RegexReplace(TextVar, "i)a", "8")
	
	TextVar := RegexReplace(TextVar, "i)\r|\n|l|\||‘|€|\‘|‘|\'|'|’|:|;|»|,|_|\.|w")
	
	return TextVar
}

	
	
	
	
