#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=Icons\NDR_Text.ico
#AutoIt3Wrapper_Res_Comment=NDR-Text Viewer.
#AutoIt3Wrapper_Res_Description=NDR-Text Viewer.
#AutoIt3Wrapper_Res_Fileversion=1.0.0.3
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=y
#AutoIt3Wrapper_Res_LegalCopyright=2017 Conrad Zelck - Norddeutscher Rundfunk
#AutoIt3Wrapper_Res_Language=1031
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <GUIConstantsEx.au3>
#include <EditConstants.au3>
#include <ButtonConstants.au3>
#include <TrayCox.au3> ; source: https://github.com/SimpelMe/TrayCox

HotKeySet("{NUMPADADD}", "_Plus")
HotKeySet("{NUMPADSUB}", "_Minus")

Local $sURL = "http://www.ndr.de/public/teletext/100_01.htm"
Local $oIE = ObjCreate("Shell.Explorer.2")
If @Compiled Then
	RegWrite("HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_BROWSER_EMULATION", @ScriptName, "REG_DWORD", 11001) ; webpages are displayed in IE11 edge mode, instead of IE7 default
Else
	RegWrite("HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_BROWSER_EMULATION", "AutoIt3.exe", "REG_DWORD", 11001)
	RegWrite("HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_BROWSER_EMULATION", "autoit3_x64.exe", "REG_DWORD", 11001)
EndIf
GUICreate("NDR Text", 492, 621)
GUICtrlCreateObj($oIE, 0, 0, 513, 594)
Local $idLabel_Number = GUICtrlCreateInput("100", 2, 594, 60, 25, $ES_CENTER)
GUICtrlSetFont(-1, 14)
GUICtrlSetLimit(-1, 3)
GUICtrlSetState(-1, $GUI_FOCUS)
Local $idButton_OK = GUICtrlCreateButton("OK", 64, 594, 60, 25, $BS_DEFPUSHBUTTON)
GUICtrlSetFont(-1, 14)
$oIE.navigate($sURL)
Sleep(500)
GUISetState(@SW_SHOW) ;Show GUI

While 1
	$iMsg = GUIGetMsg()
	Switch $iMsg
		Case $GUI_EVENT_CLOSE
			ExitLoop
		Case $idButton_OK
			If GUICtrlRead($idLabel_Number) >= 100 And GUICtrlRead($idLabel_Number) < 900 Then
				$oIE.navigate("http://www.ndr.de/public/teletext/" & GUICtrlRead($idLabel_Number) & "_01.htm")
			EndIf
			GUICtrlSetState($idLabel_Number, $GUI_FOCUS)
	EndSwitch
WEnd
HotKeySet("{NUMPADADD}")
HotKeySet("{NUMPADSUB}")
If Not @Compiled Then
	RegDelete("HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_BROWSER_EMULATION", "AutoIt3.exe")
	RegDelete("HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_BROWSER_EMULATION", "autoit3_x64.exe")
EndIf
GUIDelete()

Func _Plus()
	Local $iNumber = Number(GUICtrlRead($idLabel_Number)) + 1
	GUICtrlSetData($idLabel_Number, $iNumber)
	$oIE.navigate("http://www.ndr.de/public/teletext/" & GUICtrlRead($idLabel_Number) & "_01.htm")
	GUICtrlSetState($idLabel_Number, $GUI_FOCUS)
EndFunc

Func _Minus()
	Local $iNumber = Number(GUICtrlRead($idLabel_Number)) - 1
	GUICtrlSetData($idLabel_Number, $iNumber)
	$oIE.navigate("http://www.ndr.de/public/teletext/" & GUICtrlRead($idLabel_Number) & "_01.htm")
	GUICtrlSetState($idLabel_Number, $GUI_FOCUS)
EndFunc