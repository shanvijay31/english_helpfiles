#include <Word.au3>
#include <MsgBoxConstants.au3>

; Create application object
Global $oWord = _Word_Create()
If @error <> 0 Then Exit MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocLinkAdd Example", _
		"Error creating a new Word application object." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
; Open test.doc read-only
Global $oDoc = _Word_DocOpen($oWord, @ScriptDir & "\Extras\Test.doc", Default, Default, True)
If @error <> 0 Then Exit MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocLinkAdd Example", _
		"Error opening '.\Extras\Test.doc'." & @CRLF & "@error = " & @error & ", @extended = " & @extended)

; *****************************************************************************
; Make the fourth word of the document a link to the AutoIt homepage
; *****************************************************************************
Global $oRange = _Word_DocRangeSet($oDoc, -1, $wdWord, 3, $wdWord, 1)
_Word_DocLinkAdd($oDoc, $oRange, "http://www.autoitscript.com")
If @error <> 0 Then Exit MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocLinkAdd Example", _
		"Error adding a link to the document." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocLinkAdd Example", "Word 4 of the document is now a link to the AutoIt homepage.")
