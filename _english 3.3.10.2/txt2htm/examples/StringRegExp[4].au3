#include <MsgBoxConstants.au3>

; Option 4, global return, php/preg_match_all() style
Local $aArray = StringRegExp('F1oF2oF3o', '(F.o)*?', 4)
Local $aMatch = 0
For $i = 0 To UBound($aArray) - 1
	$aMatch = $aArray[$i]
	For $j = 0 To UBound($aMatch) - 1
		MsgBox($MB_SYSTEMMODAL, "RegExp Test with Option 4 - " & $i & ',' & $j, $aMatch[$j])
	Next
Next
