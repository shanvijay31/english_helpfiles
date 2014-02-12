#include <GuiListBox.au3>
#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $hListBox

	; Create GUI
	GUICreate("List Box Get Text", 400, 296)
	$hListBox = GUICtrlCreateList("", 2, 2, 396, 296, BitOR($LBS_STANDARD, $LBS_EXTENDEDSEL))
	GUISetState(@SW_SHOW)

	; Add strings
	_GUICtrlListBox_BeginUpdate($hListBox)
	For $iI = 1 To 9
		_GUICtrlListBox_AddString($hListBox, StringFormat("%03d : Random string", Random(1, 100, 1)))
	Next
	_GUICtrlListBox_EndUpdate($hListBox)

	; Show item text
	MsgBox($MB_SYSTEMMODAL, "Information", "Item 5 Text: " & _GUICtrlListBox_GetText($hListBox, 4))

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
