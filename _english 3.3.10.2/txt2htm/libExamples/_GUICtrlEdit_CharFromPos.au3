#include <GuiEdit.au3>
#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $aCharPos[2], $hEdit

	; Create GUI
	GUICreate("Edit Char From Pos", 400, 300)
	$hEdit = GUICtrlCreateEdit("This is a test" & @CRLF & "Another Line", 2, 2, 394, 268)
	GUISetState(@SW_SHOW)

	_GUICtrlEdit_AppendText($hEdit, @CRLF & "Append to the end?")

	$aCharPos = _GUICtrlEdit_CharFromPos($hEdit, 100, 20)
	MsgBox($MB_SYSTEMMODAL, "Information", StringFormat("Char Nearsest Point: [%2d]", $aCharPos[0]) & @CRLF & _
			StringFormat("Line Nearest Point: [%2d]", $aCharPos[1]))

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
