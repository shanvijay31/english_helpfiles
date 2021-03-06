#include <GUIConstantsEx.au3>

Example()

Func Example()
	GUICreate("My GUI group") ; will create a dialog box that when displayed is centered

	GUICtrlCreateGroup("Group 1", 190, 60, 90, 140)
	GUICtrlCreateRadio("Radio 1", 210, 90, 50, 20)
	GUICtrlCreateRadio("Radio 2", 210, 110, 60, 50)
	GUICtrlCreateGroup("", -99, -99, 1, 1) ;close group

	GUISetState(@SW_SHOW) ; will display an empty dialog box

	Local $iMsg = 0

	; Loop until the user exits.
	While 1
		$iMsg = GUIGetMsg()

		If $iMsg = $GUI_EVENT_CLOSE Then ExitLoop
	WEnd
EndFunc   ;==>Example
