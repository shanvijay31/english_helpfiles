#include <GuiListBox.au3>
#include <GUIConstantsEx.au3>

Example()

Func Example()
	Local $aTabs[4] = [3, 100, 200, 300], $hListBox

	; Create GUI
	GUICreate("List Box Set Tab Stops", 400, 296)
	$hListBox = GUICtrlCreateList("", 2, 2, 396, 296, BitOR($LBS_STANDARD, $LBS_USETABSTOPS))
	GUISetState(@SW_SHOW)

	; Set tab stops
	_GUICtrlListBox_SetTabStops($hListBox, $aTabs)

	; Add tabbed string
	_GUICtrlListBox_AddString($hListBox, "Column 1" & @TAB & "Column 2" & @TAB & "Column 3")

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
