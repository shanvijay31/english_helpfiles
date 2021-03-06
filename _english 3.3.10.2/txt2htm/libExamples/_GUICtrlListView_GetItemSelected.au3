#include <GUIConstantsEx.au3>
#include <GuiListView.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $hListView

	GUICreate("ListView Get Item Selected", 400, 300)
	$hListView = GUICtrlCreateListView("", 2, 2, 394, 268)
	GUISetState(@SW_SHOW)

	; Add columns
	_GUICtrlListView_AddColumn($hListView, "Items", 100)

	; Add items
	_GUICtrlListView_AddItem($hListView, "Item 1")
	_GUICtrlListView_AddItem($hListView, "Item 2")
	_GUICtrlListView_AddItem($hListView, "Item 3")

	; Select item 2
	_GUICtrlListView_SetItemSelected($hListView, 1)
	MsgBox($MB_SYSTEMMODAL, "Information", "Item 2 Selected: " & _GUICtrlListView_GetItemSelected($hListView, 1))

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
