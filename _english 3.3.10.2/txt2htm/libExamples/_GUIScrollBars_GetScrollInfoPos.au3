#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <StructureConstants.au3>
#include <GuiScrollBars.au3>

Global $iMemo

Example()

Func Example()
	Local $GUIMsg, $hGUI

	$hGUI = GUICreate("ScrollBar Example", 400, 400, -1, -1, BitOR($WS_MINIMIZEBOX, $WS_CAPTION, $WS_POPUP, $WS_SYSMENU, $WS_SIZEBOX))
	$iMemo = GUICtrlCreateEdit("", 2, 2, 380, 380, BitOR($WS_HSCROLL, $WS_VSCROLL))
	GUICtrlSetResizing($iMemo, $GUI_DOCKALL)
	GUICtrlSetFont($iMemo, 9, 400, 0, "Courier New")
	GUISetBkColor(0x88AABB)

	GUISetState(@SW_SHOW)

	_GUIScrollBars_Init($hGUI)

	MemoWrite("Horizontal" & @CRLF & "--------------------------------------")
	MemoWrite("nPage....: " & _GUIScrollBars_GetScrollInfoPage($hGUI, $SB_HORZ))
	MemoWrite("nPos.....: " & _GUIScrollBars_GetScrollInfoPos($hGUI, $SB_HORZ))
	MemoWrite("nMin.....: " & _GUIScrollBars_GetScrollInfoMin($hGUI, $SB_HORZ))
	MemoWrite("nMax.....: " & _GUIScrollBars_GetScrollInfoMax($hGUI, $SB_HORZ))
	MemoWrite("nTrackPos: " & _GUIScrollBars_GetScrollInfoTrackPos($hGUI, $SB_HORZ))

	MemoWrite(@CRLF & "Vertical" & @CRLF & "--------------------------------------")
	MemoWrite("nPage....: " & _GUIScrollBars_GetScrollInfoPage($hGUI, $SB_VERT))
	MemoWrite("nPos.....: " & _GUIScrollBars_GetScrollInfoPos($hGUI, $SB_VERT))
	MemoWrite("nMin.....: " & _GUIScrollBars_GetScrollInfoMin($hGUI, $SB_VERT))
	MemoWrite("nMax.....: " & _GUIScrollBars_GetScrollInfoMax($hGUI, $SB_VERT))
	MemoWrite("nTrackPos: " & _GUIScrollBars_GetScrollInfoTrackPos($hGUI, $SB_VERT))

	While 1
		$GUIMsg = GUIGetMsg()

		Switch $GUIMsg
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
