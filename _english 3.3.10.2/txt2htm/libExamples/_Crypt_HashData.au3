#include <Constants.au3>
#include <Crypt.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <WinAPI.au3>
#include <WindowsConstants.au3>

Global $bAlgorithm = $CALG_SHA1, $iInputEdit = -1, $iOutputEdit = -1

Example()

Func Example()
	Local $hGUI = GUICreate("Realtime Hashing", 400, 320)
	$iInputEdit = GUICtrlCreateEdit("", 0, 0, 400, 150, $ES_WANTRETURN)
	$iOutputEdit = GUICtrlCreateEdit("", 0, 150, 400, 150, $ES_READONLY)
	Local $iCombo = GUICtrlCreateCombo("", 0, 300, 100, 20, $CBS_DROPDOWNLIST)
	GUICtrlSetData($iCombo, "MD2|MD4|MD5|SHA1", "SHA1")
	GUIRegisterMsg($WM_COMMAND, "WM_COMMAND")
	GUISetState(@SW_SHOW, $hGUI)

	_Crypt_Startup() ; To optimize performance start the crypt library.

	Local $bHash = 0, _
			$sRead = ""
	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop

			Case $iCombo ; Check when the combobox is selected and retrieve the correct algorithm.
				Switch GUICtrlRead($iCombo) ; Read the combobox selection.
					Case "MD2"
						$bAlgorithm = $CALG_MD2

					Case "MD4"
						$bAlgorithm = $CALG_MD4

					Case "MD5"
						$bAlgorithm = $CALG_MD5

					Case "SHA1"
						$bAlgorithm = $CALG_SHA1

				EndSwitch

				$sRead = GUICtrlRead($iInputEdit)
				If StringStripWS($sRead, $STR_STRIPALL) <> "" Then ; Check there is text available to hash.
					$bHash = _Crypt_HashData($sRead, $bAlgorithm) ; Create a hash of the text entered.
					GUICtrlSetData($iOutputEdit, $bHash) ; Set the output box with the hash data.
				EndIf
		EndSwitch
	WEnd

	GUIDelete($hGUI) ; Delete the previous GUI and all controls.
	_Crypt_Shutdown() ; Shutdown the crypt library.
EndFunc   ;==>Example

Func WM_COMMAND($hWnd, $iMsg, $wParam, $lParam)
	#forceref $hWnd, $iMsg, $lParam

	Switch _WinAPI_LoWord($wParam)
		Case $iInputEdit
			Switch _WinAPI_HiWord($wParam)
				Case $EN_CHANGE
					Local $bHash = _Crypt_HashData(GUICtrlRead($iInputEdit), $bAlgorithm) ; Create a hash of the text entered.
					GUICtrlSetData($iOutputEdit, $bHash) ; Set the output box with the hash data.
			EndSwitch
	EndSwitch
EndFunc   ;==>WM_COMMAND
