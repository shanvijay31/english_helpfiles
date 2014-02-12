#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>

Example()

Func Example()
	_GDIPlus_Startup() ;initialize GDI+
	Local Const $iWidth = 300, $iHeight = 300, $iBgColor = 0xFFE8FF ;$iBgColor format RRGGBB

	Local $hGUI = GUICreate("GDI+ example", $iWidth, $iHeight) ;create a test GUI
	GUISetBkColor($iBgColor, $hGUI) ;set GUI background color
	GUISetState(@SW_SHOW)

	Local $hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI) ;create a graphics object from a window handle
	Local $hBitmap = _GDIPlus_BitmapCreateFromMemory(BinGIFImage()) ;load binary saved GIF image and convert it to GDI+ bitmap format
	Local $iW = _GDIPlus_ImageGetWidth($hBitmap), $iH = _GDIPlus_ImageGetHeight($hBitmap)
	_GDIPlus_GraphicsDrawImage($hGraphics, $hBitmap, ($iWidth - $iW) / 2, ($iHeight - $iH) / 2) ;display image in GUI

	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	;cleanup GDI+ resources
	_GDIPlus_BitmapDispose($hBitmap)
	_GDIPlus_GraphicsDispose($hGraphics)
	_GDIPlus_Shutdown()
	GUIDelete($hGUI)
EndFunc   ;==>Example

Func BinGIFImage() ;test GIF image converted to a binary string
	Local _
			$BinGIFImage = '0x47494638396144004700F70000FFFFFF1831711C357D182D6D1C3982182D691C35791C3986CACACA1831751C3D9614246118316D14286914357D1835791C398A183575204192142D65C2C2C2BE9296142459203D92AEAAAEC69A9AB2B2B6BAB6B6CACACEBEAA41142D7520398A395D9618358614317DA29E9E1028751C3D8A0C2455797979A27D7918316941699ECEA2A23D4955101C4955595961656100041C86828214358E182861B6A23DEBEBEBBEBEBE142D71E7B2B220419EB28E8E10246D2D3959DFA6AA10245D8E8A8EA29641696969CAB241202D49082065C6C6CA0C1C516165556979927D61616186B2183179AAAAAAC6C6C2969296DBDBDF243D718A71712031591C3582DFAEAE8E7D86A2A6A6314579866969AA828214285D20316910246592928E1031860410353D5D92F3F3F328499A14399A14203D3539497D754986868E0C2059A28282E3E3E3081024AE9A3D967171454545355992494D61AE8A8E7175797D869ED7A2A26555554D4D51B69296DBD7D7394969928A4D555D65D7A6AA8A7D39142855CAA6AA203982EBCACE5D6569AE9A359E9E9E715959183161B6C2DF5186C22D4169928A55414965BABABE615971AE9E9E0C18394559755979AAEBE3DF31498A5179A22439694159A6313128A6964D9EAABEDFBABE314982514924081849495565A696396969610C287D4535352035719682867171557171694571A64D5D861C3D92D2BE41514141DBCACAEFB6BA49393D24459A315586394561082471C6B649614D55B6AA5D1C2D59BE969A3D49717D7959614949CAB2AE514139244186E3C6CAF3EFEB756935797965867D55595D4561758AFBBEC23D659A1C357161551CBAAA49413D456D798A7D8282617DA2141C35000C2820283D24418A79753DE3DFDB24395D9692695D6986283965B2B2B23559968A8279FBFBEF8692AEEFD74D516D96C6B6559A8E45353541A69E5D82615D967D79454531D2BE4D92864561869E14244D554D456D6555393D555D61613159A6B286867592B29E8A351C316DF7FBFBFFC6C665757D1C397D555D7DCECACA1C3979182D71BEC2CE4539206D611C866561FFFFFF21F904010000FF002C00000000440047000008FF00FF091C48B0A0C18308132A5CC8B0A1C38710233E74674CA2C58B08C5E4B8900F16C68F1651697C152011C8930E977DD3A6F100CA970BC5C9C92166D92431307316540149C2AB1CDE64EA1CFA2FDA87483968CE01878E684E246A7E591A9369DBBE664E5F669254E357264BD3BAE2819715243C0A3FAA90DA45CF519518562894FDA8A451851E3DA8E0C0DBA34D3D25733156A0A32990AFC281FED02115F862333AACE6593A24F550183EB71A5BAC42C7579843785A1D7A52435306249A1F12BB1567452B568134E10864184706478C5333248645C70A3E545A151BDE8A'
	$BinGIFImage &= '0F9F0C59C645D2BD70CE381D192A00C7419DCA0AE851A200669E905B1B1D59A264FFD171A7C29D3869B0544893663BF7834AD2E878A7AE1096FB5892D4D185FCC77B8555E8E0883AAEF0B2CA81AE8812C31F59CCF15F4255E013060241ACE2CA856E7451430DBBA0F6E0418CFC5243183570D0055C4F90D855261F1AC44D586AE0F1C4346AA8F1C41378C818A3832D0E840D1E1C144101214EFC10430C4E60C0880D08E063458F0229C10436D830614A21B75041051F59D47186154C6060857B1FCE51A413419CB0CB1F155470CB1F8EB473C20F3F10D2548F679C70423B31E0C301051B6CC008051CD810449A319C01A529EDB8C00C0708441A24A44D3212840B413003252EE198B2411191861AAA9056B4C303253D9E3204343130C108A8A246FF4A81065604F185212DBA13CB258F04E1043636C03A2A234CFCA0CC1A5FE4F3E03DB598334B1F6EC44008B0C2526003064E9832C4140494100D18DCF522432DDD74534D19A074C1C4061414E1AE0DD88C10831B054860EF0507BC919A0AD1C880CA37D598730509653033EDA0D6128BE6B6537C7081BD074CD258360294708135937821483B32D8F282BA1BD8400123D8101283324B8883CB14164B700104F69C52960A0F5C60732A1008E0413E071C50C60907DBB001B62E4C708F399E784080C33643207156BD9470EF070404208F008094F0801D203342EB093CC8608A397AA4B0440810A4F28A045364E3943153D82B412A5E3CD04002F6007240098604FF31ED06D83861C703105C318B10476CB1C726D5D4A3C0058038958FD46B07014A0A2CE0220001807C00010F3160808D152FC853C20121E4A20A382C60924C300AACDDF650F55CA1B602F5D4D2411FEB94620FE77B2F01C70818FCC043CF3D8B20CCEE8360E2F0BDBDE8D40C2EA9DC1B0D208B00B345289BEBBD770A273001C7143D0302880022E4314C1F1D4002814F1240103D4C9BBC7F2F014B7051C60D09189037F221488420187000F3018200F610C0120AE086580822040FB3D71440F01228340010AF78C5053E20007DF8410AFA08C0037EE73DADF9E0000448E10113688014A4C30709C89A4F2E20002D80EB24D780C11A5A6080541CC00033184201FF18C0800808200421F0DE01A7600F6EA590850C68413A182000089460028F58C31A6E884318E8900706F0C0AA0650800124E00182B84212CD470001B8F1776D34C00306E087474CE0015080C61A74C8459424E20BCEE045387CD0023F04A000050880084C910C35AED08D6E4CA1000C60802D68E11146B0052F44B10632F4112588384521508002657CA100FA2840031409095528220492A42424DD28823DB8800B8F20C328DB0087ACB4860A7480430306708D44DC2014B998C52C1E294B01E4037DA1D0830B88900E72E0E0388A220A12B290811564200EF220A6191251'
	$BinGIFImage &= '8A0ECC2219BF73A32C45100C458002141D580711E0E0CD1554801CA81A0A12DE91FF810CD4E116A318C004A4C1860E744008C110813A2949497B2842151DA0011086D18834446105B7408153908002D69021035018400358400321084118906428431F600045449406D2684414D8B18238A0603943B1863FB2F38524E0A2003358C0223CE10903A4F4014865E812842104894A610FEC18421AFC5108A750A20E3B8506341800542D34C0032260E94A2380D40788E00542D0831ED8C0834E7CA10EE4488237B2428946D022099C40A416B45080049075AC11202B4BDBF182048C420F7048072D0AA18BB9CEC50EC0E0C43576E003BE06E0AF728C4002361BD80878C00309F040256231047570E21E8808CC30E2818C3E9881053E48A45FCBBAD900FF6CF6B6B5D5470386800C7E78642E8860413FFAF00970B821B60CB02D529790800038D7B9B7752E5787C08974FC762E9740C627CEB10534F035B99BBD022E3C10007DDCE0B9CF256201A4A08E4E5C372B60E0871DCC30081E547688B6F5401E30510912546211E7452F03C8A88572E432302A4807170A60063BA0C102654CAE7E69908B2300C11301962E570B5060673C2230C630C1041A90026A5800C22918803E46E10920B08106A5B80111931B00F572D80816480788455C8009CCC0027C2D803C4A01840EB0E1C87990F18C67ACD774580057733184052640E519F821C80CA8C41ECC70641A80A312FA604098990CD47418410B08DEEB0C66A0852B237269C0B258041BCE710433B840C9649E409BAFA002CDC0020A50D0420BA6FCE61BC0810D89D8C10EE4B1641B4FC0022A482D734E01060BC416913758443B1AA0CA05AC79060D6840507D9082147C48056F28B53C183D80141862132088B5AC63FD069941E9D6B84E484000003B'
	Return Binary($BinGIFImage)
EndFunc   ;==>BinGIFImage
