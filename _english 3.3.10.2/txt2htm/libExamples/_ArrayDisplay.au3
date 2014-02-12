
#include <Array.au3>

Example()

Func Example()

	; Create 1D array to display
	Local $aArray_1D[5] = ["Item 0", "Item 1", "A longer Item 2 to show column expansion", "Item 3", "Item 4"]

	_ArrayDisplay($aArray_1D, "1D display")
	_ArrayDisplay($aArray_1D, "1D display transposed", Default, 1)

	; Create 2D array to display
	Local $aArray_2D[75][25]
	For $i = 0 To UBound($aArray_2D) - 1
		For $j = 0 To UBound($aArray_2D, 2) - 1
			$aArray_2D[$i][$j] = "Item " & StringFormat("%02i", $i) & StringFormat("%02i", $j)
		Next
	Next

	_ArrayDisplay($aArray_2D, "2D display")
	_ArrayDisplay($aArray_2D, "2D display transposed", Default, 1)

	$aArray_2D[5][5] = "A longer item to show column expansion"
	_ArrayDisplay($aArray_2D, "Expanded column - custom titles - alternate line color", Default, Default, Default, "AA|BB|CC|DD|EE|FF|GG|HH|II|JJ", Default, 0xDDFFDD)

	$aArray_2D[5][5] = "Column alignment set to right"
	_ArrayDisplay($aArray_2D, "Range set - right align - copy column width - user function", "3:7|4:9", 2, 15, Default, Default, Default, "_UserFunc")

	; Create non-array variable to force error - MsgBox displayed as $iFlags set
	Local $vVar = 0
	_ArrayDisplay($vVar, "MsgBox on Error", Default, 8)

EndFunc   ;==>Example

; Note that the User function MUST have TWO parameters even if you do not intend to use them
Func _UserFunc($aArray_2D, $aSelected)

	; But if you do not use a parameter do this to prevent an Au3Check warning
	#forceref $aArray_2D

	_ArrayDisplay($aSelected, "Selected cols")

EndFunc   ;==>_UserFunc
