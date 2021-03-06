#include <GUIConstantsEx.au3>
#include <GuiButton.au3>
#include <WindowsConstants.au3>

Global $iMemo

Example()

Func Example()
	Local $rdo, $rdo2, $chk

	GUICreate("Buttons", 400, 400)
	$iMemo = GUICtrlCreateEdit("", 119, 10, 276, 374, $WS_VSCROLL)
	GUICtrlSetFont($iMemo, 9, 400, 0, "Courier New")

	$rdo = GUICtrlCreateRadio("Radio1", 10, 10, 90, 50)

	$rdo2 = GUICtrlCreateRadio("Radio2", 10, 60, 90, 50)
	_GUICtrlButton_SetCheck($rdo2)
	_GUICtrlButton_SetFocus($rdo2) ; set focus, shows this doesn't affect _GUICtrlButton_GetCheck

	$chk = GUICtrlCreateCheckbox("Check1", 10, 120, 90, 50, BitOR($BS_AUTO3STATE, $BS_NOTIFY))
	_GUICtrlButton_SetCheck($chk, $BST_INDETERMINATE)

	GUISetState(@SW_SHOW)

	MemoWrite("$rdo checked status.: " & @CRLF & @TAB & _ExplainCheckState(_GUICtrlButton_GetCheck($rdo)) & @CRLF)
	MemoWrite("$rdo2 checked status: " & @CRLF & @TAB & _ExplainCheckState(_GUICtrlButton_GetCheck($rdo2)) & @CRLF)
	MemoWrite("$chk checked status.: " & @CRLF & @TAB & _ExplainCheckState(_GUICtrlButton_GetCheck($chk)) & @CRLF)

	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop
		EndSwitch
	WEnd

	Exit
EndFunc   ;==>Example

; Write a line to the memo control
Func MemoWrite($sMessage)
	GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
EndFunc   ;==>MemoWrite

Func _ExplainCheckState($iState)
	Switch $iState
		Case $BST_CHECKED
			Return "Button is checked."
		Case $BST_INDETERMINATE
			Return "Button is grayed, indicating an indeterminate state (applies only if the button has the $BS_3STATE or $BS_AUTO3STATE style)."
		Case $BST_UNCHECKED
			Return "Button is cleared"
	EndSwitch
EndFunc   ;==>_ExplainCheckState
