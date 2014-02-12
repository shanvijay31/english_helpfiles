#include <ColorConstants.au3>
#include <GUIConstantsEx.au3>

Example()

Func Example()
	; Create a GUI with various controls.
	Local $hGUI = GUICreate("Example", 300, 200)

	; Create a label control.
	Local $iLabel = GUICtrlCreateLabel("A string of text", 10, 10, 185, 17)
	Local $iClose = GUICtrlCreateButton("Close", 210, 170, 85, 25)

	; Set the color of the label control.
	GUICtrlSetColor($iLabel, $COLOR_RED)

	; Display the GUI.
	GUISetState(@SW_SHOW, $hGUI)

	; Loop until the user exits.
	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE, $iClose
				ExitLoop

		EndSwitch
	WEnd

	; Delete the previous GUI and all controls.
	GUIDelete($hGUI)
EndFunc   ;==>Example
