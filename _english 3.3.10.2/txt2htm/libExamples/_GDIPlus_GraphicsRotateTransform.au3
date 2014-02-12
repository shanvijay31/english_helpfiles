#include <Constants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <GDIPlus.au3>

Example()

Func Example()
	AutoItSetOption("GUIOnEventMode", 1)

	; X64 running support
	Local $sWow64 = ""
	If @AutoItX64 Then $sWow64 = "\Wow6432Node"

	;get AutoIt install dir
	Local $sRegPath = "HKLM\SOFTWARE" & $sWow64 & "\AutoIt v3\AutoIt"

	Local $sFile = RegRead($sRegPath, "InstallDir") & "\Examples\GUI\logo4.gif"
	If Not FileExists($sFile) Then
		MsgBox(BitOR($MB_SYSTEMMODAL, $MB_ICONHAND), "", $sFile & " not found!", 30)
		Exit
	EndIf

	Global $hGUI = GUICreate("GDI+", 800, 600)
	GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit")
	GUISetOnEvent($GUI_EVENT_SECONDARYDOWN, "_ResetGraphicsTransform")
	GUISetState(@SW_SHOW)

	_GDIPlus_Startup()
	Global $hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)
	Global $hBmp_Buffer = _GDIPlus_BitmapCreateFromGraphics(800, 600, $hGraphics)
	Global $hGfx_Buffer = _GDIPlus_ImageGetGraphicsContext($hBmp_Buffer)

	Global $hImage = _GDIPlus_ImageLoadFromFile($sFile)

	Global $iMouseX, $iMouseY

	GUIRegisterMsg($WM_LBUTTONDOWN, "WM_LBUTTONDOWN")
	GUIRegisterMsg($WM_MOUSEWHEEL, "WM_MOUSEWHEEL")
	GUIRegisterMsg($WM_MOUSEMOVE, "WM_MOUSEMOVE")
	GUISetState(@SW_SHOW)

	_Draw()

	While Sleep(10)
	WEnd
EndFunc   ;==>Example

Func _ResetGraphicsTransform()
	_GDIPlus_GraphicsResetTransform($hGfx_Buffer)
	_Draw()
EndFunc   ;==>_ResetGraphicsTransform

Func WM_LBUTTONDOWN($hWnd, $Msg, $wParam, $lParam)
	#forceref $hWnd, $Msg, $wParam

	$iMouseX = BitAND($lParam, 0x0000FFFF)
	$iMouseY = BitShift($lParam, 16)
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_LBUTTONDOWN

Func WM_MOUSEMOVE($hWnd, $Msg, $wParam, $lParam)
	#forceref $hWnd, $Msg

	Switch BitAND($wParam, 0x0000FFFF)
		Case 1
			Local $iX = BitAND($lParam, 0x0000FFFF)
			Local $iY = BitShift($lParam, 16)

			_GDIPlus_GraphicsTranslateTransform($hGfx_Buffer, $iX - $iMouseX, $iY - $iMouseY, True)

			$iMouseX = $iX
			$iMouseY = $iY

			_Draw()
	EndSwitch

	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_MOUSEMOVE

Func WM_MOUSEWHEEL($hWnd, $Msg, $wParam, $lParam)
	#forceref $hWnd, $Msg, $lParam

	Switch BitAND($wParam, 0x0000FFFF)
		Case 1
			Local $iAngle = -3
			If BitShift($wParam, 16) < 0 Then $iAngle = 3

			Local $aMousePos[2][2] = [[1]]
			$aMousePos[1][0] = $iMouseX
			$aMousePos[1][1] = $iMouseY
			_GDIPlus_GraphicsTransformPoints($hGfx_Buffer, $aMousePos)

			_GDIPlus_GraphicsTranslateTransform($hGfx_Buffer, $aMousePos[1][0], $aMousePos[1][1])
			_GDIPlus_GraphicsRotateTransform($hGfx_Buffer, $iAngle)
			_GDIPlus_GraphicsTranslateTransform($hGfx_Buffer, -$aMousePos[1][0], -$aMousePos[1][1])

		Case Else
			Local $aInfo = GUIGetCursorInfo($hGUI)
			Local $iScale = 1.1
			If BitShift($wParam, 16) < 0 Then $iScale = 0.9

			_GDIPlus_GraphicsTranslateTransform($hGfx_Buffer, -$aInfo[0], -$aInfo[1], True)
			_GDIPlus_GraphicsScaleTransform($hGfx_Buffer, $iScale, $iScale, True)
			_GDIPlus_GraphicsTranslateTransform($hGfx_Buffer, $aInfo[0], $aInfo[1], True)
	EndSwitch

	_Draw()
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_MOUSEWHEEL

Func _Draw()
	_GDIPlus_GraphicsClear($hGfx_Buffer, 0xFFFFFFFF)

	_GDIPlus_GraphicsDrawImage($hGfx_Buffer, $hImage, 316, 266)

	Local $hPen = _GDIPlus_PenCreate(0xFF0000FF)
	_GDIPlus_GraphicsDrawRect($hGfx_Buffer, 300, 250, 200, 100, $hPen)
	_GDIPlus_PenDispose($hPen)

	Local $hBrush = _GDIPlus_BrushCreateSolid(0xFF00007F)
	Local $hFormat = _GDIPlus_StringFormatCreate()
	_GDIPlus_StringFormatSetAlign($hFormat, 1)
	Local $hFamily = _GDIPlus_FontFamilyCreate("Arial")
	Local $hFont = _GDIPlus_FontCreate($hFamily, 24, 2)
	Local $tLayout = _GDIPlus_RectFCreate(0, 360, 800)
	_GDIPlus_GraphicsDrawStringEx($hGfx_Buffer, "AutoIt rulez!", $hFont, $tLayout, $hFormat, $hBrush)

	_GDIPlus_GraphicsDrawImage($hGraphics, $hBmp_Buffer, 0, 0)

	_GDIPlus_FontDispose($hFont)
	$hFont = _GDIPlus_FontCreate($hFamily, 10)
	_GDIPlus_StringFormatSetAlign($hFormat, 0)

	DllStructSetData($tLayout, "X", 10)
	DllStructSetData($tLayout, "Y", 10)
	_GDIPlus_GraphicsDrawStringEx($hGraphics, "left mousebutton = move graphic", $hFont, $tLayout, $hFormat, $hBrush)

	DllStructSetData($tLayout, "Y", 30)
	_GDIPlus_GraphicsDrawStringEx($hGraphics, "mousewheel = zoom graphic", $hFont, $tLayout, $hFormat, $hBrush)

	DllStructSetData($tLayout, "Y", 50)
	_GDIPlus_GraphicsDrawStringEx($hGraphics, "mousewheel + left mousebutton = rotate graphic", $hFont, $tLayout, $hFormat, $hBrush)

	DllStructSetData($tLayout, "Y", 70)
	_GDIPlus_GraphicsDrawStringEx($hGraphics, "right mousebutton = reset", $hFont, $tLayout, $hFormat, $hBrush)

	Local $hMatrix = _GDIPlus_MatrixCreate()
	_GDIPlus_GraphicsGetTransform($hGfx_Buffer, $hMatrix)
	Local $aMatrix_Values = _GDIPlus_MatrixGetElements($hMatrix)
	_GDIPlus_MatrixDispose($hMatrix)

	DllStructSetData($tLayout, "Y", 110)
	_GDIPlus_GraphicsDrawStringEx($hGraphics, "Matrix:", $hFont, $tLayout, $hFormat, $hBrush)
	DllStructSetData($tLayout, "X", 20)
	DllStructSetData($tLayout, "Y", 130)
	_GDIPlus_GraphicsDrawStringEx($hGraphics, StringFormat("%.2f  %.2f", $aMatrix_Values[0], $aMatrix_Values[1]), $hFont, $tLayout, $hFormat, $hBrush)
	DllStructSetData($tLayout, "Y", 150)
	_GDIPlus_GraphicsDrawStringEx($hGraphics, StringFormat("%.2f  %.2f", $aMatrix_Values[2], $aMatrix_Values[3]), $hFont, $tLayout, $hFormat, $hBrush)
	DllStructSetData($tLayout, "Y", 170)
	_GDIPlus_GraphicsDrawStringEx($hGraphics, StringFormat("%.2f  %.2f", $aMatrix_Values[4], $aMatrix_Values[5]), $hFont, $tLayout, $hFormat, $hBrush)

	_GDIPlus_FontDispose($hFont)
	_GDIPlus_FontFamilyDispose($hFamily)
	_GDIPlus_StringFormatDispose($hFormat)
	_GDIPlus_BrushDispose($hBrush)
EndFunc   ;==>_Draw

Func _Exit()
	_GDIPlus_ImageDispose($hImage)
	_GDIPlus_GraphicsDispose($hGfx_Buffer)
	_GDIPlus_BitmapDispose($hBmp_Buffer)
	_GDIPlus_GraphicsDispose($hGraphics)
	_GDIPlus_Shutdown()
	GUIDelete($hGUI)
	Exit
EndFunc   ;==>_Exit
