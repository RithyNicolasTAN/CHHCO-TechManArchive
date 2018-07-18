#include <Array.au3>
#include <_FileListToArrayEx_v3.au3>
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <GUIListBox.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <Date.au3>
#include <Math.au3>
#include <File.au3>
#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>

#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <GUIListBox.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>

#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <GUIListBox.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#Region ### START Koda GUI section ### Form=c:\users\tani01\downloads\portablesapps\koda\forms\imgv.kxf
$Form1_1 = GUICreate("Form1", 936, 655, 162, 100)
$Group1 = GUICtrlCreateGroup("Analyse : ", 8, 0, 921, 129)
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
$Label1 = GUICtrlCreateLabel("Date : ", 280, 16, 49, 20, BitOR($SS_RIGHT,$SS_CENTERIMAGE))
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
$Label2 = GUICtrlCreateLabel("Methode : ", 16, 24, 76, 20, BitOR($SS_RIGHT,$SS_CENTERIMAGE))
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
$Label3 = GUICtrlCreateLabel("Numero lot : ", 280, 64, 91, 20, BitOR($SS_RIGHT,$SS_CENTERIMAGE))
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
$Label4 = GUICtrlCreateLabel("Expire le : ", 280, 88, 77, 20, BitOR($SS_RIGHT,$SS_CENTERIMAGE))
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
$Label5 = GUICtrlCreateLabel("", 376, 16, 100, 20, $SS_CENTERIMAGE)
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
$Label6 = GUICtrlCreateLabel("", 376, 64, 100, 20, $SS_CENTERIMAGE)
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
$Label7 = GUICtrlCreateLabel("", 376, 88, 100, 20, $SS_CENTERIMAGE)
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
$Label8 = GUICtrlCreateLabel("Dossier : ", 280, 40, 70, 20, BitOR($SS_RIGHT,$SS_CENTERIMAGE))
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
$List1 = GUICtrlCreateList("", 96, 16, 177, 102)
$Label9 = GUICtrlCreateLabel("", 376, 40, 100, 20)
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
;~ GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group2 = GUICtrlCreateGroup("Image", 240, 128, 689, 521)
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
$Pic1 = GUICtrlCreatePic("", 248, 152, 673, 449)
$Button4 = GUICtrlCreateButton("Quitter", 824, 608, 97, 33)
$Button5 = GUICtrlCreateButton("Supprimer", 248, 608, 97, 33)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group3 = GUICtrlCreateGroup("Dossiers ", 8, 128, 225, 521)
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
$List2 = GUICtrlCreateList("", 16, 152, 209, 486)
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###


$ar_Array2 = _FileListToArray(@ScriptDir, "*", 2)
$meth=""
for $i=1 to UBound($ar_Array2,1)-1
   $meth = $meth & "|" & $ar_Array2[$i]
next
GUICtrlSetData ($List1,$meth)

$meth2=""
$dos2=""
While 1

   $selection = GUICtrlRead($List1)
    If $selection <> $meth2 Then
     $meth2=$selection
$ar_Array = _FileListToArrayEx (@ScriptDir&"\"&$meth2, "*.jpg", 1, 0,0)
   if UBound($ar_Array,1)<1 Then
GUICtrlSetData ($List2,"")
Else
   $dos=""
   local $ar_dos[UBound($ar_Array,1)-1][2]
   _ArrayDelete($ar_Array, 0)
;~    _ArrayDisplay($ar_Array)
   _ArraySort ($ar_Array,1)
;~    _ArrayDisplay($ar_Array)
   for $i=0 to UBound($ar_Array,1)-1
	  $name=StringSplit($ar_Array[$i],"_")
;~ 	  _ArrayConcatenate($aArrayTarget, $aArraySource)
;~ 	  _ArrayDisplay($name)
if $i<9 Then
   $num="000"&String($i+1)
Elseif $i<99 Then
$num="00"&String($i+1)
Elseif $i<999 Then
$num="0"&String($i+1)
Else
   $num=string($i+1)
   EndIf
if $name[5]="CQI" Then
	  	  $dos = $dos&"|"&$num&". "&$name[5]&" du "&StringMid($name[2],9,2)&"/"&StringMid($name[2],6,2)&"/"&StringMid($name[2],1,4)&" ["&stringleft($name[8],stringlen($name[8])-4)&"]"
	   Else
		  $dos = $dos&"|"&$num&". "&$name[5]&" ["&stringleft($name[8],stringlen($name[8])-4)&"]"
		  EndIf
   Next
;~       msgbox(1,"",$dos)
GUICtrlSetData ($List2,$dos)
$dos2=""
   EndIf
EndIf


   $selection2 = GUICtrlRead($List2)
   if $selection2<>"" Then
    If $selection2 <> $dos2  Then
	   $meth3=StringSplit($selection2,".")
;~ 	   _ArrayDisplay ($meth3)
	   GUICtrlSetImage ($Pic1,@ScriptDir&"\"&$meth2&"\"&$ar_Array[$meth3[1]-1])
	   $name2=StringSplit($ar_Array[$meth3[1]-1],"_")
	  GUICtrlSetData ($Label5,StringMid($name2[2],9,2)&"/"&StringMid($name2[2],6,2)&"/"&StringMid($name2[2],1,4))
	  GUICtrlSetData ($Label6,$name2[3])
	  GUICtrlSetData ($Label7,$name2[4])
	  GUICtrlSetData ($Label9,$name2[5])
     $dos2=$selection2
EndIf
   EndIf


	$nMsg = GUIGetMsg()
	Switch $nMsg

	   	Case $Button5
if MsgBox(1,"Supprimer ?","Etes-vous sur de vouloir supprimer ?")=1 Then
   $meth3=StringSplit(GUICtrlRead($List2),".")
   FileMove(@ScriptDir&"\"&$meth2&"\"&$ar_Array[$meth3[1]-1],@ScriptDir&"\"&$meth2&"\DELETED\"&$ar_Array[$meth3[1]-1],8)
			$meth2=""
			$dos2=""
			EndIf
		 Case $Pic1
			ShellExecute(@ScriptDir&"\"&$meth2&"\"&$ar_Array[$meth3[1]-1])

	   	Case $Button4
				if MsgBox(1,"Quitter ?","Etes-vous sur de vouloir quitter ?")=1 Then
			Exit
			EndIf
	Case $GUI_EVENT_CLOSE
				if MsgBox(1,"Quitter ?","Etes-vous sur de vouloir quitter ?")=1 Then
			Exit
			EndIf
	EndSwitch
WEnd
