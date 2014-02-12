#include <MsgBoxConstants.au3>

Local $iCode = AscW("&szlig;")
MsgBox($MB_SYSTEMMODAL, "", "Unicode code for &szlig;: U+" & Hex($iCode, 6))
