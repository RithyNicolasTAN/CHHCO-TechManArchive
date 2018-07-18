#include <Array.au3>
#include <File.au3>
#include "7Zip.au3"


$year=InputBox("Année","Année",@year)
$month=InputBox("Mois","Mois",@Mon)
if MsgBox(4,"Confirmation","Archiver le mois "&$year&"-"&$month&" ?")=7 then exit


$aFOLDER = _FileListToArray(@ScriptDir, "*", 2)

for $i=1 to $aFOLDER[0]
;~    for $i=1 to 1

   ConsoleWrite($afolder[$i]&@CRLF)
   $aFILES=_FileListToArray($afolder[$i],$afolder[$i]&"_"&$year&"-"&$month&"-*.jpg",1,1)
;~    _ArrayDisplay($aFILES)
if IsArray($aFILES) then
   if $aFILES[0]>9 then
	  _7ZipAdd(0,$afolder[$i]&"\"&$afolder[$i]&"_"&$year&"-"&$month&".zip",$afolder[$i]&"\"&$afolder[$i]&"_"&$year&"-"&$month&"-*.jpg",0,0)
	  		 FileDelete($afolder[$i]&"\"&$afolder[$i]&"_"&$year&"-"&$month&"-*.jpg")
			  EndIf
	  EndIf
;~    ConsoleWrite(
;~ $aFILES = _FileListToArray(@ScriptDir&"\"&$afolder[$i], "*.JPG", 1)

;~    for $j=1 to $aFILES[0]

;~ if $year=StringLeft(StringSplit($aFILES[$j],"_")[2],4) AND $month=StringMid(StringSplit($aFILES[$j],"_")[2],6,2) Then
;~ 	  ConsoleWrite($aFILES[$j]&@crlf)
;~ 	  EndIf
;~ 	  Next

   Next


Func _7ZipAdd2($a,$b,$c,$d,$e="",$f="",$g="")
   ConsoleWrite("_7ZipAdd("&$a&","&$b&","&$c&","&$d&","&$e&","&$f&","&$g&@crlf)
   EndFunc


   Func _MonthAdd($date,$addmonth)
	  Local $year,$month
	  $year=StringLeft($date,4)
	  $month=StringMid($date,6,2)
	  if stringleft($addmonth,1)="-" Then
		 		 for $i=-1 to $addmonth step -1
			$month=$month-1
			if $month=0 Then
			   $year=$year-1
			   $month=12
			   EndIf
			Next
	  Else
		 for $i=1 to $addmonth
			$month=$month+1
			if $month=13 Then
			   $year=$year+1
			   $month=1
			   EndIf
			Next
		 EndIf
		 Return $year&"-"&StringFormat("%02i",$month)
	  EndFunc
