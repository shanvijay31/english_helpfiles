#include <WinAPISys.au3>
#include <Array.au3>

Local $Data = _WinAPI_EnumPageFiles()

_ArrayDisplay($Data, '_WinAPI_EnumPageFiles')
