#include <String.au3>
#include <Array.au3>

Local $text = "one##two##three##four##five##six##seven##eight"
Local $aArray1 = _StringExplode($text, "##", 0)
_ArrayDisplay($aArray1, "StringExplode 0")

; DISPLAYED
; [0] = one
; [1] = two
; [2] = three
; [3] = four
; [4] = five
; [5] = six
; [6] = seven
; [7] = eight

Local $aArray2 = _StringExplode($text, "##", 4)
_ArrayDisplay($aArray2, "StringExplode 4")

; DISPLAYED
; [0] = one
; [1] = two
; [2] = three
; [3] = four
; [4] = five##six##seven##eight

Local $aArray3 = _StringExplode($text, "##", -3)
_ArrayDisplay($aArray3, "StringExplode -3")

; DISPLAYED
; [0] = one
; [1] = two
; [2] = three
; [3] = four
; [4] = five
