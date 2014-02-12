#include <File.au3>
#include <Array.au3> ; Only required to display the arrays
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $sAutoItDir = StringLeft(@AutoItExe, StringInStr(@AutoItExe, "\", Default, -1))
	If StringRight($sAutoItDir, 5) = "beta\" Then
		$sAutoItDir = StringTrimRight($sAutoItDir, 5)
	EndIf
	ConsoleWrite($sAutoItDir & @CRLF)

	; A sorted list of all files and folders in the AutoIt installation
	Local $aArray = _FileListToArrayRec($sAutoItDir, "*", 0, 1, 1)
	ConsoleWrite("Error: " & @error & " - " & " Extended: " & @extended & @CRLF)
	_ArrayDisplay($aArray, "Sorted tree")

	; And now ignoring the "Include" folder
	$aArray = _FileListToArrayRec($sAutoItDir, "*||include", 0, 1, 1)
	_ArrayDisplay($aArray, "No 'Include' folder")

	; A sorted list of all but the .exe files in the \AutoIt3 folder
	$aArray = _FileListToArrayRec($sAutoItDir, "*|*.exe", 1, 0, 1)
	ConsoleWrite("Error: " & @error & " - " & " Extended: " & @extended & @CRLF)
	_ArrayDisplay($aArray, "Non .EXE files")

	; And here are the .exe files we left out last time
	$aArray = _FileListToArrayRec($sAutoItDir, "*.exe", 1)
	ConsoleWrite("Error: " & @error & " - " & " Extended: " & @extended & @CRLF)
	_ArrayDisplay($aArray, ".EXE Files")

	; A test for all folders and .exe files only throughout the folder tree, omitting folders beginning with I (Icons and Include)
	$aArray = _FileListToArrayRec($sAutoItDir, "*.exe||i*", 0, 1, 1)
	ConsoleWrite("Error: " & @error & " - " & " Extended: " & @extended & @CRLF)
	_ArrayDisplay($aArray, "Recur with filter")

	; Look for icon files - but exlude the "Icons" folder
	$aArray = _FileListToArrayRec($sAutoItDir, "*.ico||ic*", 1, 1, 1)
	If @error Then
		MsgBox($MB_SYSTEMMODAL, "Ooops!", "No ico files found")
	Else
		_ArrayDisplay($aArray, "Icon files not in 'Icons' folder")
	EndIf

	; And to show that the filter applies to files AND folders when not recursive
	$aArray = _FileListToArrayRec($sAutoItDir, "*.exe", 0, 0, 1)
	ConsoleWrite("Error: " & @error & " - " & " Extended: " & @extended & @CRLF)
	_ArrayDisplay($aArray, "Non-recur with filter")

	; The filter also applies to folders when recursively searching for folders
	$aArray = _FileListToArrayRec($sAutoItDir, "Icons", 2, 1, 1)
	ConsoleWrite("Error: " & @error & " - " & " Extended: " & @extended & @CRLF)
	_ArrayDisplay($aArray, "Folder recur with filter")

	; Note the exlude_folder parameter is ignored when looking for folders - "Icons" will be excluded but "Include" will still be there
	$aArray = _FileListToArrayRec($sAutoItDir, "*|ic*|i*", 2, 1, 1)
	_ArrayDisplay($aArray, "'Icons' out - 'Include' in")

	; The root of C:\Windows showing hidden/system folders
	$aArray = _FileListToArrayRec("C:\Windows\", "*", 2)
	ConsoleWrite("Error: " & @error & " - " & " Extended: " & @extended & @CRLF)
	_ArrayDisplay($aArray, "Show hidden folders")

	; The root of C:\Windows omitting hidden/system folders
	$aArray = _FileListToArrayRec("C:\Windows\", "*", 2 + 4 + 8)
	ConsoleWrite("Error: " & @error & " - " & " Extended: " & @extended & @CRLF)
	_ArrayDisplay($aArray, "Hide hidden folders")
EndFunc   ;==>Example
