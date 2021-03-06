#include <WinAPISys.au3>
#include <WindowsConstants.au3>
#include <GDIPlus.au3>
#include <Misc.au3>

_GDIPlus_Startup()
Local $hImage = _GDIPlus_ImageLoadFromFile(@ScriptDir & '\Extras\Exclamation.png')
Local $hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), _GDIPlus_ImageGetWidth($hImage), _GDIPlus_ImageGetHeight($hImage), -1, -1, $WS_POPUPWINDOW, BitOR($WS_EX_LAYERED, $WS_EX_TOPMOST))
Local $hBitmap = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImage)
_GDIPlus_ImageDispose($hImage)
_GDIPlus_Shutdown()
GUISetState(@SW_SHOW)

Local $Opacity = 0, $Step = 3
Do
	_WinAPI_UpdateLayeredWindowEx($hForm, -1, -1, $hBitmap, $Opacity)
	$Opacity += $Step
	If ($Opacity = 0) Or ($Opacity = 255) Then
		$Step = -$Step
		Sleep(500)
	EndIf
	Sleep(10)
Until _IsPressed('1B')

_WinAPI_DeleteObject($hBitmap)
