#include<Array.au3>
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
#include <FTPEx.au3>
$ftp=0

#Region ### CONFIGURATION
$apn="C:\DCIM\"
$op=""
$FTP=1
$ftpserv="192.168.17.129"
$ftpport=10021
$ftplogin="labo"
$ftpmdp="labo"
#EndRegion ### CONFIGURATION

#Region ### START Koda GUI section ### Form=C:\Users\tani01\Downloads\PortablesApps\Koda\Forms\IMG.kxf
$Form1 = GUICreate("Form1", 936, 655, 172, 86)
$Group1 = GUICtrlCreateGroup("Analyse : ", 8, 0, 921, 121)
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
$Label1 = GUICtrlCreateLabel("Date : ", 40, 16, 49, 20, BitOR($SS_RIGHT,$SS_CENTERIMAGE))
$List1 = GUICtrlCreateList("", 96, 48, 129, 80)
$Input1 = GUICtrlCreateInput("Input1", 96, 16, 145, 24)
$Label2 = GUICtrlCreateLabel("Methode : ", 16, 48, 76, 20, BitOR($SS_RIGHT,$SS_CENTERIMAGE))
$Label3 = GUICtrlCreateLabel("Numero lot : ", 280, 16, 91, 20, BitOR($SS_RIGHT,$SS_CENTERIMAGE))
$Label4 = GUICtrlCreateLabel("Expire le : ", 288, 48, 77, 20, BitOR($SS_RIGHT,$SS_CENTERIMAGE))
$Label5 = GUICtrlCreateLabel("MM/AAAA ou JJ/MM/AAAA", 280, 72, 188, 20, $SS_RIGHT)
$Input2 = GUICtrlCreateInput("Input2", 376, 16, 153, 24)
$Input3 = GUICtrlCreateInput("Input3", 376, 48, 153, 24)
$Radio1 = GUICtrlCreateRadio("CQI", 576, 16, 177, 25)
$Radio2 = GUICtrlCreateRadio("Patient : Numéro BioWin", 576, 48, 193, 25)
$Input4 = GUICtrlCreateInput("Input4", 768, 48, 153, 24)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group2 = GUICtrlCreateGroup("Image ", 8, 128, 921, 521)
$Pic1 = GUICtrlCreatePic("", 16, 144, 801, 497)
$Button1 = GUICtrlCreateButton("Précédent", 824, 144, 97, 33)
$Button2 = GUICtrlCreateButton("Suivant", 824, 184, 97, 33)
$Button3 = GUICtrlCreateButton("Valider", 824, 568, 97, 33)
$Button4 = GUICtrlCreateButton("Quitter", 824, 608, 97, 33)
$Button5 = GUICtrlCreateButton("Supprimer", 824, 368, 97, 33)
GUICtrlCreateGroup("", -99, -99, 1, 1)
#EndRegion ### END Koda GUI section ###

#Region ### Recupération FTP ###
SplashTextOn("Veuillez patientez", "Récupération des fichiers sur le téléphone en cours..."&@crlf&"Merci de patienter...",400,70)
Local $hOpen = _FTP_Open('MyFTP Control')
Local $hConn = _FTP_Connect($hOpen, $ftpserv, $ftplogin, $ftpmdp,1,$ftpport)
If @error Then
    MsgBox($MB_SYSTEMMODAL, '_FTP_Connect', 'ERROR=' & @error)
EndIf
Local $aFile = _FTP_ListToArray($hConn, 2)
for $i=1 to $aFile[0]
   $ret=_FTP_FileGet ($hConn, $aFile[$i], $apn& $aFile[$i], True)
   if $ret=1 Then _FTP_FileDelete ($hConn, $aFile[$i])
   Next
Local $iFtpc = _FTP_Close($hConn)
Local $iFtpo = _FTP_Close($hOpen)
SplashOff()
#EndRegion ### Recupération FTP ###

#Region ### GUI Initialization ###
Local  $aMyDate2, $aMyTime2
_DateTimeSplit(_NowCalcDate(), $aMyDate2, $aMyTime2)
$a2=stringRight($aMyDate2[1],2)
if $aMyDate2[2]<10 then
   $m2="0"&$aMyDate2[2]
Else
   $m2=$aMyDate2[2]
EndIf
if $aMyDate2[3]<10 then
   $d2="0"&$aMyDate2[3]
Else
   $d2=$aMyDate2[3]
EndIf


$ar_Array2 = _FileListToArray(@ScriptDir, "*", 2)


$meth=""
for $i=1 to UBound($ar_Array2,1)-1
   $meth = $meth & "|" & $ar_Array2[$i]
next
#EndRegion ### GUI Initialization ###






GUISetState(@SW_SHOW)

;~ Exit

$file=1
GUICtrlSetData ($Input1, _NowDate())
GUICtrlSetData ($Input2, "")
GUICtrlSetData ($Input3, "JJ/MM/AAAA")
GUICtrlSetData ($Input4, "2"&$a2&$m2&$d2&"-0000")
GUICtrlSetData ($List1,$meth)
GUICtrlSetState ($Radio1, $GUI_INDETERMINATE)
GUICtrlSetState ($Radio2, $GUI_INDETERMINATE)
$dosident=0
$meth2=""
While 1
GUICtrlSetState ($Button1, $GUI_DISABLE)
GUICtrlSetState ($Button2, $GUI_DISABLE)



$ar_Array = _FileListToArray ($apn, "*.jpg", 1, 1)

;~ _ArrayDisplay($ar_Array)
;~ $i=0
;~ While $i<UBound($ar_Array,1)

;~    if stringleft($ar_Array[$i],16)="C:\DCIM\IMPORTED" OR stringleft($ar_Array[$i],15)="C:\DCIM\DELETED" Then
;~ 	  _ArrayDelete ($ar_Array, $i )
;~    Else
;~ 	  $i=$i+1
;~ 	  EndIf

;~ WEnd

;~ _ArrayDisplay($ar_Array)
if UBound($ar_Array,1)<2 Then
	  MsgBox(0,"Absence d'images","Absence d'image à importer. Merci de vérifier la connexion. Le progamme va se fermer.")
	  Exit
	  EndIf
;~ _ArrayDisplay($ar_Array)

While 1
   GUICtrlSetState ($Button1, $GUI_DISABLE)
   GUICtrlSetState ($Button2, $GUI_DISABLE)
   GUICtrlSetState ($Button3, $GUI_ENABLE)
   GUICtrlSetState ($Button4, $GUI_ENABLE)
   GUICtrlSetState ($Button5, $GUI_ENABLE)
   GUICtrlSetImage ($Pic1,$ar_Array[$file])
   if $file>1 Then
	  GUICtrlSetState ($Button1, $GUI_ENABLE)
   EndIf
      if $file<UBound($ar_Array,1)-1 Then
	  GUICtrlSetState ($Button2, $GUI_ENABLE)
   EndIf

While 1
	$nMsg = GUIGetMsg()

$sel=GUICtrlRead($List1)
if $sel<>"" Then
    If $sel <> $meth2  Then
	   $dosident=0
;~ 	   MsgBox(1,"","dosiendet")
	   if $sel="GS" or $sel="RAI" Then
		  GUICtrlSetData ($Input2,StringReplace(_NowDate(),"/","-"))
		  GUICtrlSetData ($Input3,_NowDate())
	   Else
		  GUICtrlSetData ($Input2, "")
GUICtrlSetData ($Input3, "JJ/MM/AAAA")
		  EndIf
		  $meth2=$sel
EndIf
   EndIf


Switch $nMsg
		 Case  $Button1
		 $file=$file-1
		 ExitLoop (1)
		 Case  $Button2
		 $file=$file+1
		 ExitLoop (1)

	  Case  $Button3 ; Valider
		GUICtrlSetState ($Button5, $GUI_DISABLE)
		GUICtrlSetState ($Button3, $GUI_DISABLE)
		GUICtrlSetState ($Button4, $GUI_DISABLE)
			     GUICtrlSetState ($Button3, $GUI_DISABLE)
	     GUICtrlSetState ($Button4, $GUI_DISABLE)
		 $jour=GUICtrlRead($Input1) ; Date du jour
			  if StringRegExp($jour,"[0-3][0-9]/[0-1][0-9]/20[0-9][0-9]") Then
					  if StringLen($jour)=10 Then
				  $d=stringmid($jour,1,2)
				  $m=stringmid($jour,4,2)
				  $a=stringmid($jour,7,4)
				  if $a>2014 AND $a<2050 AND $m>0 AND $m<13 AND $d>0 and $d<32 Then

					 Else
					Msgbox (0,"Erreur","Date du jour incorrecte")
					 ExitLoop (1)
				  EndIf
				    Else
				Msgbox (0,"Erreur","Date du jour incorrectement remplie")
			ExitLoop (1)
		 EndIf
		 else
				Msgbox (0,"Erreur","Date du jour incorrectement remplie")
			ExitLoop (1)
		 EndIf

GUICtrlSetData ($Input2,StringReplace(GUICtrlRead($Input2),"/","-"))
		 if GUICtrlRead($Input2)="" Then ; Numéro de lot
			Msgbox (0,"Erreur","Numéro de lot non renseigné")
			ExitLoop (1)
		 EndIf

		 $exp=GUICtrlRead($Input3) ; Date de péremption
			  if StringRegExp($exp,"[0-3][0-9]/[0-1][0-9]/20[0-9][0-9]") OR StringRegExp($exp,"[0-1][0-9]/20[0-9][0-9]") Then
		  Else
				Msgbox (0,"Erreur","Date de péremption incorrectement remplie")
			ExitLoop (1)
		 EndIf
		 	  if StringLen($exp)=7 OR StringLen($exp)=10 Then
		  Else
				Msgbox (0,"Erreur","Date de péremption incorrectement remplie")
			ExitLoop (1)
		 EndIf
			if StringLen($exp)=7 Then
			   $d3=""
			   $dd3=31
			   $m3=stringmid($exp,1,2)
			   $a3=stringmid($exp,6,2)
				  EndIf
	  		if StringLen($exp)=10 Then
			   $d3=stringmid($exp,1,2)
			   $dd3=stringmid($exp,1,2)
			   $m3=stringmid($exp,4,2)
			   $a3=stringmid($exp,9,2)
			   	endif
;~ 			   if $dd3>=$d2 AND $m3>=$m2 AND $a3>=$a2 Then
;~ 			Else
;~ 				 Msgbox (0,"Erreur","Date de péremption dépassée")
;~ 							ExitLoop (1)
;~ 						 EndIf

		 if GUICtrlRead($List1)="" Then ; Méthode sélectionnée
			Msgbox (0,"Erreur","Methode non sélectionnée")
			ExitLoop (1)
			EndIf

		 if GUICtrlRead($Radio1)=4 AND GUICtrlRead($Radio2)=4 Then ; Type échantillon
			Msgbox (0,"Erreur","Type d'échantillon (CQI ou Patient) non sélectionné")
			ExitLoop (1)
		 EndIf

			if GUICtrlRead($Radio2)=1  Then ; Type échantillon
			$bw=GUICtrlRead($Input4)

			if StringLen($bw)=12 Then
			Else
			   Msgbox (0,"Erreur","Numéro BioWin Incorrect")
			ExitLoop (1)
		 endif
		 		    $a4=stringmid($bw,2,2)
			   $m4=stringmid($bw,4,2)
			   $j4=stringmid($bw,6,2)
			   $d4=stringmid($bw,9,4)
			if $a4>14 and $a4<21 and $m4>0 and $m4<13 and $j4>0 and $j4<32 and $d4>0 and $d4<999 Then
						Else
			   Msgbox (0,"Erreur","Numéro BioWin Incorrect")
			ExitLoop (1)

		 endif
else
			$bw="CQI"
		 EndIf

$op=StringReplace(StringUpper(InputBox ("Imporation par","Initiales du Technicien ou du biologiste",$op)),"/","-")
		 if $op="" Then
			  Msgbox (0,"Erreur","Initiales non saisies")
			ExitLoop (1)
		 EndIf

		 $ar_Array2 = _FileListToArrayEx (@ScriptDir&"\"&GUICtrlRead($List1), "*.jpg", 1, 0,0)
		 $nb=0

		 $name=GUICtrlRead($List1)&"_"&$a&"-"&$m&"-"&$d&"_"&GUICtrlRead($Input2)&"_"&StringReplace (GUICtrlRead($Input3),"/","-")&"_"&$bw&"_"&$op&"_"&"BIO"&"_"
		 $nam=GUICtrlRead($List1)&"_"&$a&"-"&$m&"-"&$d&"_"&GUICtrlRead($Input2)&"_"&StringReplace (GUICtrlRead($Input3),"/","-")&"_"&$bw

if $ar_Array2<>"" then
		 for $i=1 to $ar_Array2[0]

			if stringleft($ar_Array2[$i],stringlen($nam))=$nam Then
			   $name2=StringSplit($ar_Array2[$i],"_")
;~ 			   _ArrayDisplay($name2)
			   $nb=_Max(Number($nb),Number(stringleft($name2[8],stringlen($name2[8])-4)))
;~ 			   msgbox(1,"",stringleft($name2[$name2[0]],stringlen($name2[$name2[0]])-4))
			EndIf


		 Next
	  endif
;~ 	  msgbox(1,"",$dosident)
		 if $nb>1 and $dosident=0 Then
		 if MsgBox (4,"Continuer ?", "Une image existe déjà pour ce dossier. Importer cette nouvelle image ?")=$IDNO Then
				   ExitLoop(2)
				EndIf
			 EndIf

			 if $nb<10 Then
				$nb="0"&string($nb+1)
			 Else
				$nb=string($nb+1)
				EndIf


			 $txt=""


$txt1=0
$txt2=0
			if FileCopy($ar_Array[$file],@ScriptDir&"\"&GUICtrlRead($List1)&"\"&$name&$nb&".JPG",9)=1 Then
			   $txt1=1
			EndIf

						$name2=StringSplit ($ar_Array[$file], "\")
			if FileMove($ar_Array[$file],$apn&"\IMPORTED\"&$name2[$name2[0]],9)=1 Then
			   $txt2=1
			EndIf
			if $txt1=1 and $txt2=1 Then
			   $txt="Importation reussie"
			Else
			   $txt="IMPORTATION ECHOUEE, prévenir Mr TAN"
			   EndIf
		if MsgBox (4,"Continuer ?", $txt&@CRLF&"Importer une nouvelle image pour le même dossier ?")=$IDYES Then
$dosident=1
		   ExitLoop(2)
		Else
		   GUICtrlSetData ($Input1, _NowDate())
GUICtrlSetData ($Input2, "")
GUICtrlSetData ($Input3, "JJ/MM/AAAA")
GUICtrlSetData ($Input4, "2"&$a2&$m2&$d2&"-0000")
GUICtrlSetData ($List1,$meth)
GUICtrlSetState ($Radio1, $GUI_INDETERMINATE)
GUICtrlSetState ($Radio2, $GUI_INDETERMINATE)
		   exitloop(2)
		   EndIf







;~ 			$name=StringSplit ($ar_Array[$file], "\")
;~ 						FileMove($ar_Array[$file],@ScriptDir&"\"

;~ 						$apn&"\DELETED\"&$name[UBound($name,1)-1])
;~ 						$file=_max($file-1,1)
		 ExitLoop(2)
	  Case  $Button4
GUICtrlSetState ($Button5, $GUI_DISABLE)
		GUICtrlSetState ($Button3, $GUI_DISABLE)
		GUICtrlSetState ($Button4, $GUI_DISABLE)
		 if MsgBox(1,"Quitter ?","Etes-vous sur de vouloir quitter ?")=1 Then
			Exit
		 EndIf
		  GUICtrlSetState ($Button5, $GUI_ENABLE)
		GUICtrlSetState ($Button3, $GUI_ENABLE)
		GUICtrlSetState ($Button4, $GUI_ENABLE)
	  Case  $Button5
		 GUICtrlSetState ($Button5, $GUI_DISABLE)
		GUICtrlSetState ($Button3, $GUI_DISABLE)
		GUICtrlSetState ($Button4, $GUI_DISABLE)
		 if MsgBox(1,"Supprimer ?","Etes-vous sur de vouloir suprrimer cet élément ?")=1 Then


						$name=StringSplit ($ar_Array[$file], "\")
						FileMove($ar_Array[$file],$apn&"\DELETED\"&$name[UBound($name,1)-1],8)
						$file=_max($file-1,1)
			ExitLoop(2)
		 EndIf
	 GUICtrlSetState ($Button5, $GUI_ENABLE)
		GUICtrlSetState ($Button3, $GUI_ENABLE)
		GUICtrlSetState ($Button4, $GUI_ENABLE)
	   Case $GUI_EVENT_CLOSE
		  GUICtrlSetState ($Button5, $GUI_DISABLE)
		GUICtrlSetState ($Button3, $GUI_DISABLE)
		GUICtrlSetState ($Button4, $GUI_DISABLE)
				if MsgBox(1,"Quitter ?","Etes-vous sur de vouloir quitter ?")=1 Then
			Exit
		 EndIf
	 GUICtrlSetState ($Button5, $GUI_ENABLE)
		GUICtrlSetState ($Button3, $GUI_ENABLE)
		GUICtrlSetState ($Button4, $GUI_ENABLE)
	EndSwitch

 WEnd

 WEnd
 WEnd

