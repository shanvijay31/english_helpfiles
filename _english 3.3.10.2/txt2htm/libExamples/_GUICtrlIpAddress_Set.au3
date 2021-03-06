#include <GUIConstantsEx.au3>
#include <GuiIPAddress.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $hgui, $hIPAddress

	$hgui = GUICreate("IP Address Control Set (String) Example", 400, 300)
	$hIPAddress = _GUICtrlIpAddress_Create($hgui, 10, 10)
	GUISetState(@SW_SHOW)

	_GUICtrlIpAddress_Set($hIPAddress, "24.168.2.128")

	MsgBox($MB_SYSTEMMODAL, "Information", "IP Address: " & _GUICtrlIpAddress_Get($hIPAddress))

	; Wait for user to close GUI
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
EndFunc   ;==>Example
