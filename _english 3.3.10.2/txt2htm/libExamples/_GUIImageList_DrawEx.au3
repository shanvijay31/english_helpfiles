#include <GUIConstantsEx.au3>
#include <WinAPI.au3>
#include <GuiImageList.au3>

Example()

Func Example()
	Local $hImage, $hGUI, $hDC

	$hGUI = GUICreate("ImageList DrawEx", 400, 300)
	GUISetState(@SW_SHOW)

	; Load images
	$hImage = _GUIImageList_Create(32, 24)
	_GUIImageList_Add($hImage, _WinAPI_CreateSolidBitmap($hGUI, 0xFF0000, 32, 24))
	_GUIImageList_Add($hImage, _WinAPI_CreateSolidBitmap($hGUI, 0x00FF00, 32, 24))
	_GUIImageList_Add($hImage, _WinAPI_CreateSolidBitmap($hGUI, 0x0000FF, 32, 24))

	; Draw images
	$hDC = _WinAPI_GetDC($hGUI)
	_GUIImageList_DrawEx($hImage, 0, $hDC, 4, 4)
	_GUIImageList_DrawEx($hImage, 1, $hDC, 40, 4)
	_GUIImageList_DrawEx($hImage, 2, $hDC, 76, 4)

	_WinAPI_ReleaseDC($hGUI, $hDC)

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
