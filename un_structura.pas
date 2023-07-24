{
 **********************************************************************
 Модуль описания структуры DBF-файлов измененного формата DBFIII,
 где в описании поля вставлены имена DBF-файлов-справочников для этого поля,
 используемых в DOS-Эпикризе.
 Автор И.Н.Лозинский. 2001г(?)
 Примечания и некоторые поправки В.И.Воронов
 **********************************************************************
}

unit un_structura;

{$mode ObjFPC}{$H+}

interface

Type
  sReg= string[10];
(* Неиспользуемые типы
  Nuneric1 = 0..3;   {0- нет инвалидности; 1-2-3- группы инвалидности}
  Nuneric2 = 0..99;
  Nuneric3 = 0..999;
  Nuneric4 = 0..9999;
  Nuneric5 = 0..99999;
*)
{TODO: В inLEKA_REZfDBF не перенесены длительности ИТ и ПС }
{TODO: В inRegfDBF ЧИСЛА длительности заменены на Строковые}
{TODO: В inPEREMENAfDBF ЧИСЛО группа инвалидности заменено на Строковое}

//ANAL_GIR.DBF
    rANAL_GIR=Record
     r: sReg;
      arGRRezKr: array [1..2] of string[17];
      arOpisProchAn: array [1..18] of string[60];
    end;

//ANAL_KON.DBF и //ANAL_SVI.DBF
    {Структура }
     RIsslDann= Record
	  imyaissl : string[18]; //наименование обсл/консультации
	  sData : string[10]; //дата
      arOpis: array[1..6] of string[60];
    end;
	
    rKONSVI=Record
     r: sReg;
     arAN_KONSVI:  array[1..6] of RIsslDann; {Структура }
    end;
	
//ANAL_KRV.DBF //ANAL_LUM.DBF//ANAL_MCH.DBF
     {Структура }
	   RKLanDann= Record
	    sNPok: string[25]; //наименование показателя
	    sZnPok: string[21]; //значение
	    sPeriod: string[17]; //период/дата анализа
    end; {Структура }
	
    rANALIZ=Record
      r: sReg;
      arOpisAn: array [1..6] of string[60]; //описательные
      arTablAn: array [1..30] of RKLanDann; {Структура }  
    end;	

//ANAM_GZN.DBF
   rANAM_GZN=Record
     r: sReg;
     arOpisGZN: array [1..24] of string[60];
   end;

//ANAM_ZBL.DBF
   rANAM_ZBL=Record
     r: sReg;
     sKATAANA: string[60]; //KATAANA
     arOpisZBL: array [1..40] of string[60];
   end;

//NEVROSOS.DBF
   rNEVROSOS=Record
     r: sReg;
     arOpisNEVR: array [1..40] of string[60]; //SOST01 - SOST40
   end;

//SOMATSOS.DBF
   rSOMATSOS=Record
     r: sReg;
     arOpisSOMA: array [1..48] of string[60]; //SOST01 - SOST48
    end;

//PSIXISOS.DBF
   rPSIXISOS=Record
     r: sReg;
     arOpisPSIX: array [1..48] of string[60]; //SOST01 - SOST48
   end;

//COMMENT.DBF
   rCOMMENT=Record
     r: sReg;
     arOpisCOM: array [1..10] of string[60]; //описания COM01 - COM10
     arVRACH: array [1..4] of string[22]; // VRACH1 VRACH2 VRACH3 ZAVOTD
   end;


//DIAGKOSN.DBF
   rDIAGKOSN=Record
     r: sReg;
     arShE: array [1..6] of string[10]; //шифр PRE01- PRE06
     arShA: array [1..6] of string[10]; //шифр PRA01- PRA06
     arDzOsn: array [1..12] of string[60]; //основное DIAGO01 - DIAGO12
     arDzFon: array [1..12] of string[60]; //фоновое  DIAGF01 - DIAGF12
     arDzOsl: array [1..26] of string[60]; //осложнений  DIAGOSL01 - DIAGOSL26
     arDzSop: array [1..16] of string[60]; //сопутствующих  DIAGSOP01 - DIAGSOP16
   end;

//DIAGPOSN.DBF
   rDIAGPOSN=Record
    r: sReg;
    arPShOsn: array [1..14] of string[10]; //шифр основ ПА диагноза SHOSNP01 - SHOSNP02    //SHOSNS01 - SHOSNS12
    arPDzOsn: array [1..12] of string[60]; //основное DIAGOSNP01 - DIAGOSNP06   //DIAGOSNS01 - DIAGOSNS06
    arPShFon: array [1..8] of string[10]; //шифр SHFONP01 - SHFONP02   SHFONS01- SHFONS06
    arPDzFon: array [1..12] of string[60]; //фоновое  DIAGFONP01 - DIAGFONP06   //DIAGFONS01 - DIAGFONS06
    arPShOsl: array [1..8] of string[10]; //шифр SHOSLP01 - SHOSLP02   SHOSLS01- SHOSLS06
    arPDzOsl: array [1..16] of string[60]; //осложнений  DIAGOSLS01 - DIAGOSLS10  DIAGOSLP01 - DIAGOSLP06
    arPShSop: array [1..8] of string[10]; //шифр SHSOPP01 - SHSOPP02   SHSOPS01- SHSOPS06
    arPDzSop: array [1..16] of string[60]; //сопутствующих  DIAGSOPS01 - DIAGSOPS10   DIAGSOPP01 - DIAGSOPP06
   end;

//LEKA_MED.DBF
   rLEKA_MED=Record
    r: sReg;
    arLekM: array [1..30] of string[60]; //LEKA01101-LEKA0130
   end;

//LEKA_NMD.DBF //LEKA_XIR.DBF {объединены, т.к. похожи}
   rLEKA_NX=Record
    r: sReg;
    arLekNX: array [1..20] of string[60]; //LEKA02101-LEKA0220
   end;
{   //LEKA_XIR.DBF   r!!!=Record          r: sReg; 	    : array [1..20] of string[60]; //LEKA0301-LEKA0320   end;}

//LEKA_REZ.DBF
   rLEKA_REZ=Record
    r: sReg;
    arRezlek: array [1..6] of string[60]; //LEKA0401-LEKA0406
    n3ITSu: string[3];//Nuneric3;	//DL_TS  Nuneric3;
    n2ITCh: string[2];//Nuneric2;	//DL_TC  Nuneric2
    n2ITMi: string[2];//Nuneric2;	//DL_TM  Nuneric2
    n3PsSu: string[3];//Nuneric3;	//DL_PS  Nuneric3
    n2PsCh: string[2];//Nuneric2;	//DL_PC  Nuneric2
    n2PsMi: string[2];//Nuneric2;	//DL_PM  Nuneric2
   end;

//PEREMENA.DBF
       {Структура }
     RRodstv= Record
      sRODs:    string[12]; //ROD1_S   Мать Муж жена
      sRODsFIO: string[42]; //ROD1_F   ФИО
      sRODsADR: string[55]; //ROD1_A   Адрес или телефон
    end;

   rPEREMENA=Record
    r: sReg;
    sAdrStran:  string[20]; //MESTOJ_S
    sAdrRegion: string[28]; //MESTOJ_R
    sAdrPunkt:  string[30]; //MESTOJ_P
    sAdrMGit:   string[48]; //MESTOJ
    sRabota  :  string[49]; //MESTOR
    n1Invalid:  string[1];  //Nuneric1; //Nuneric1   INV_G
    sInvalidTip: string[28]; //INV_T1
    sInvalidVid: string[20]; //INV_T2
    arRodstv:  array[1..2] of RRodstv; {Структура }
   end;

//RECOMEND.DBF
    rRECOMEND=Record
      r: sReg;
	  arRecom: array [1..40] of string[60]; //RECO01 - RECO40
    end;

//REGISTER.DBF
   rREGISTER=Record
     r: sReg;
     sLUCH:        string[62];   //LUCH
     sDOC:         string[43];   //DOCUMENT
     sD_NOMER:     string[6];    //D_NOMER
     sFIO:         string[42];   //FIO
     n4DATA_G:     string[4];      //n4DATA_G:     Nuneric4;	 //Nuneric4      DATA_G
     sPol:         string[1];    //POL
     n2PostChislo: string[2];     //n2PostChislo: Nuneric2;	 //Nuneric2      DPS_V
     n2PostMes:    string[2];     //n2PostMes:    Nuneric2;	 //Nuneric2      DPS_M
     n4PostGod:    string[4];     //n4PostGod:    Nuneric4;	 //Nuneric4      DPS_G
     sPOST:        string[32];   //POST
     sVIBIV:       string[15];   //VIBIV
     n2VipisChislo: string[2];     //n2VipisChislo: Nuneric2;	 //Nuneric2      DVS_V
     n2VipisMes:    string[2];     //n2VipisMes:    Nuneric2;	 //Nuneric2      DVS_M
     n4VipisGod:    string[4];     //n4VipisGod:    Nuneric4;	 //Nuneric4      DVS_G
     sKuda1:        string[32];  //KUDA1
     sKuda2:        string[32];  //KUDA2
     sIsxod:        string[17];  //ISXOD
     n5DlitOtd:     string[5];     //n5DlitOtd:	    Nuneric5;	 //Nuneric5      DLLO
     n2PostBChislo: string[2];     //n2PostBChislo: Nuneric2;	 //Nuneric2      POSTB_V
     n2PostBMes:    string[2];     //n2PostBMes:    Nuneric2;	 //Nuneric2      POSTB_M
     n4PostBGod:    string[4];     //n4PostBGod:    Nuneric4;	 //Nuneric4      POSTB_G
     n5DlitObsh:    string[5];     //n5DlitObsh:    Nuneric5;    //Nuneric5      DLLB
   end;

//SPR.DBF
 rSPR=Record
   sNAMEPROT: string[30]; //NAMEPROT   ФИО=16симв+пробел+UJL_H(4cbvd)+ ..... на 30м месте ':' или '1' какое поступление
                                 //Киселев Дми Вал 1977         :
   sSTR_TYPE: string[20]; //STR_TYPE    'Эпикриз'
   sSTATUS:   string[64]; //STATUS
   n2KEY:     string[2]; //Nuneric2;		//Nuneric2    KEYNUMB   1   дескрипторы DBF-ф-лов?
   arKEYS:    array [1..5] of string[60]; //KEY1 - KEY5   в KEY1 вначале пишется REG типа 'P202100118'
 end;

//ZAKLUCHE.DBF
 rZAKLUCHE=Record
  r: sReg;
  arPAZAKL:  array [1..16] of string[60]; //ZAKL01 - ZAKL16
  sRSX_KAT:  string[26];  //RSX_KAT
  arRSX_TIP: array [1..7] of string[60]; //RSX_TIP01 - RSX_TIP07
  arRSX_PRI: array [1..10] of string[60]; //RSX_PRI01 - RSX_PRI10
 end;

var
  REGIS:    rREGISTER;
  SPR:      rSPR;
  ANAL_GIR: rANAL_GIR;
  ANAL_KON, ANAL_SVI: rKONSVI;
  ANAM_GZN: rANAM_GZN;
  ANAM_ZBL: rANAM_ZBL;
  NEVROSOS: rNEVROSOS;
  SOMATSOS: rSOMATSOS;
  PSIXISOS: rPSIXISOS;
  DIAGKOSN: rDIAGKOSN;
  DIAGPOSN: rDIAGPOSN;
  LEKA_MED: rLEKA_MED;
  LEKA_NMD, LEKA_XIR: rLEKA_NX;
  LEKA_REZ: rLEKA_REZ;
  PEREMENA: rPEREMENA;
  COMMENT: rCOMMENT;
  OAK, OAM, ANLikv: rANALIZ;
  RECOMEND: rRECOMEND;
  ZAKLUCHE: rZAKLUCHE;

function delperenos(var sText: string):string;  {Удаление из мемо-текста переносов и множественных пробелов}
function selSHFromDz(sText: string):string;  {Выборка из диагноза ШИФРА диагноза}
procedure selDzOsn(const sText: string; var sSH9, sSH10, sDzBezSh, sDzRez: string);   {Формирование ОСНОВНОГО диагноза - удаление Ш_МКБ9, Ш_МКБ10 - перед текстом, удаление переносов.}
procedure selDzProh(const sText: string; var sDzRez: string); {заменяет шифры в фигурных скобках на ~~}
procedure selDzProh2(const sText: string; var sDzRez: string); {заменяет шифры в КВАДРАТНЫХ скобках на ~~ только не для ОСНОВНОГО д-за}
function selfromDz(sText: string):string;  {Выборка части диагноза до ~~ из всего диагноза (типа Гематурия посткатетеризационная.~~Острая пневмония.~~)}

procedure  inRegfDBF(var sPutDBF: string; iz: longint);
procedure  inPEREMENAfDBF(var sPutDBF: string; iz: longint);
procedure  inDIAGKOSNfDBF(var sPutDBF: string; iz: longint);
procedure  inDIAGPOSNfDBF(var sPutDBF: string; iz: longint);
procedure  inZAKLUCHEfDBF(var sPutDBF: string; iz: longint);
procedure  inANAM_GZNfDBF(var sPutDBF: string; iz: longint);
procedure  inANAM_ZBLfDBF(var sPutDBF: string; iz: longint);
procedure  inPSIXISOSfDBF(var sPutDBF: string; iz: longint);
procedure  inSOMATSOSfDBF(var sPutDBF: string; iz: longint);
procedure  inNEVROSOSfDBF(var sPutDBF: string; iz: longint);
procedure  inANAL_GIRfDBF(var sPutDBF: string; iz: longint);
procedure  inANAL_KRVfDBF(var sPutDBF: string; iz: longint);
procedure  inANAL_MCHfDBF(var sPutDBF: string; iz: longint);
procedure  inANAL_LUMfDBF(var sPutDBF: string; iz: longint);
procedure  inANAL_SVIfDBF(var sPutDBF: string; iz: longint);
procedure  inANAL_KONfDBF(var sPutDBF: string; iz: longint);
procedure  inLEKA_MEDfDBF(var sPutDBF: string; iz: longint);
procedure  inLEKA_NMDfDBF(var sPutDBF: string; iz: longint);
procedure  inLEKA_XIRfDBF(var sPutDBF: string; iz: longint);
procedure  inLEKA_REZfDBF(var sPutDBF: string; iz: longint);
procedure  inRECOMENDfDBF(var sPutDBF: string; iz: longint);
procedure  inCOMMENTfDBF(var sPutDBF: string; iz: longint);
procedure  inSPRfDBF(var sPutDBF: string; iz: longint);
procedure  ClearAnalizTbl; {очистить данные Анализы табличные ОАК, ОАМ, Анализ ликвора}
procedure  inAnalizTbl(Akr, Amo, Alu: rANALIZ); //OAK, OAM, ANLikv, AllTabAnal: rANALIZ;

function  selIdVrac(const sText: string): string;

implementation

uses SysUtils, DM_setup, LazUTF8, StrUtils, Dbf3, DM_FB, Un_strfb, Dialogs;

function delperenos(var sText: string): string;  {Удаление из мемо-текста переносов и множественных пробелов}
begin
   //sText:= ConsoleToUTF8(Trim(sText));
   sText:=  AnsiReplaceText(sText,'- ','');
   sText:=  AnsiReplaceText(sText,'  ',' ');
   sText:=  AnsiReplaceText(sText,'  ',' ');
   Result:=  AnsiReplaceText(sText,'  ',' ');
end;

function selSHFromDz(sText: string): string;
var
  iNach, iCon: integer;
begin
  result := '';
  iNach := UTF8Pos('[', ConsoleToUTF8(sText), 1);
  iCon := UTF8Pos(']', ConsoleToUTF8(sText), 1);  //Showmessage(IntToStr(iNach)+' '+IntToStr(iCon)+#13+    sTMP+' ----  '+ ConsoleToUTF8(sTMP));
  if (iCon > iNach) and (iCon>0) and (iNach>0) then
  result:= Copy(sText, iNach, (iCon-iNach)+1);
end;

procedure selDzOsn(const sText: string; var sSH9, sSH10, sDzBezSh, sDzRez: string);
var    sDzTmp: string;
begin
    sDzTmp:= '';
    sDzBezSh:= '';
    sDzTmp:= sText;
    sSH9 := selSHFromDz(sDzTmp);   // Showmessage(ConsoleToUTF8(sTMP));
    sDzTmp:=  AnsiReplaceText(sDzTmp, sSH9,'');
    sSH10 := selSHFromDz(sDzTmp);
    sDzTmp:= Trim(Copy(sDzTmp,1, pos(sSH10,sDzTmp,1)-2));
    sSH10 := Trim(Copy(sSH10,2, length(sSH10)-2));
    sDzTmp:=  delperenos(sDzTmp);    //Showmessage('1= |'+ConsoleToUTF8(sDzTmp)+'|');    //Showmessage('rez='+ConsoleToUTF8(sShifrDz+' '+sDzTmp));
    sDzBezSh:= sDzTmp;
    sDzRez:= sSH10+' '+sDzTmp;    //result:= sShifrDz+' '+ AnsiReplaceText(sText, sShifrDz,#13);
end;

procedure selDzProh(const sText: string; var sDzRez: string); {заменяет шифры в фигурных скобках на ~~}
var
  iNach, iCon: integer;
  sFind: String;
begin
  sFind:= '';
  sDzRez:= sText;
  iNach := UTF8Pos('{', ConsoleToUTF8(sDzRez), 1);
  iCon := UTF8Pos('}', ConsoleToUTF8(sDzRez), 1);
{В операторе while … do выход из цикла происходит тогда, когда условие станет ложным,
  а в операторе repeat … until – когда условие станет истинным.}
  While (iCon > iNach) and (iCon>0) and (iNach>0) do begin
    sFind:= Copy(sDzRez, iNach, (iCon-iNach)+1);    //Showmessage(IntToStr(iNach)+' '+IntToStr(iCon)+#13+    sFind+' ----  '+ ConsoleToUTF8(sFind));
    if Length(Trim(sFind))> 0 then sDzRez:= AnsiReplaceText(sDzRez, sFind,'~~') else break;
    iNach := UTF8Pos('{', ConsoleToUTF8(sDzRez), 1);
    iCon := UTF8Pos('}', ConsoleToUTF8(sDzRez), 1);    //Showmessage('sDzRez=  |'+ ConsoleToUTF8(sDzRez)+'|');
  end;
end;

procedure selDzProh2(const sText: string; var sDzRez: string); {заменяет шифры в КВАДРАТНЫХ скобках на ~~ только не для ОСНОВНОГО д-за}
var
  iNach, iCon: integer;
  sFind: String;
begin
  sFind:= '';
  sDzRez:= sText;
  iNach := UTF8Pos('[', ConsoleToUTF8(sDzRez), 1);
  iCon := UTF8Pos(']', ConsoleToUTF8(sDzRez), 1);
{В операторе while … do выход из цикла происходит тогда, когда условие станет ложным,
  а в операторе repeat … until – когда условие станет истинным.}
  While (iCon > iNach) and (iCon>0) and (iNach>0) do begin
    sFind:= Copy(sDzRez, iNach, (iCon-iNach)+1);    //Showmessage(IntToStr(iNach)+' '+IntToStr(iCon)+#13+    sFind+' ----  '+ ConsoleToUTF8(sFind));
    if Length(Trim(sFind))> 0 then sDzRez:= AnsiReplaceText(sDzRez, sFind,'~~') else break;
    iNach := UTF8Pos('[', ConsoleToUTF8(sDzRez), 1);
    iCon := UTF8Pos(']', ConsoleToUTF8(sDzRez), 1);    //Showmessage('sDzRez=  |'+ ConsoleToUTF8(sDzRez)+'|');
  end;
end;

function selfromDz(sText: string): string; {Выборка части диагноза до ~~ из всего диагноза (типа Гематурия посткатетеризационная.~~Острая пневмония.~~)}
var
  iNach: integer;
begin
  result := '';
  iNach:= UTF8Pos('~~', ConsoleToUTF8(sText), 1);
  if iNach = 0 then exit
  else begin
   result := Copy(sText,1, iNach-1);
   //Showmessage(ConsoleToUTF8(result));
  end;
end;

procedure  inRegfDBF(var sPutDBF: string; iz: longint);
var
    k, k1: integer;
begin
  sPutDBF := UTF8ToConsole(DM_S.sRabDir+ DM_S.namedbf[1]);  //if DbfOpen(1,  UTF8ToConsole(DM_S.sRabDir+ DM_S.namedbf[1])) <>0 then   Showmessage('Ошибка')
  if DbfOpen(1, sPutDBF) <>0 then   Showmessage('Ошибка')
  else
   With REGIS, FB_EpiW do begin
    R := Trim(DbfRead(1, iZ, 1));
    sLUCH:=          Trim(DbfRead(1, iZ, 2));
    sDOC:=           Trim(DbfRead(1, iZ, 3));
    sD_NOMER:=       Trim(DbfRead(1, iZ, 4));
    sFIO:=           Trim(DbfRead(1, iZ, 5));
    n4DATA_G:=       Trim(DbfRead(1, iZ, 6));
    sPol:=           Trim(DbfRead(1, iZ, 7));
    n2PostChislo:=   Trim(DbfRead(1, iZ, 8));
    n2PostMes:=      Trim(DbfRead(1, iZ, 9));
    n4PostGod:=      Trim(DbfRead(1, iZ, 10));
    sPOST:=          Trim(DbfRead(1, iZ, 11));
    sVIBIV:=         Trim(DbfRead(1, iZ, 12));
    n2VipisChislo:=  Trim(DbfRead(1, iZ, 13));
    n2VipisMes:=     Trim(DbfRead(1, iZ, 14));
    n4VipisGod:=     Trim(DbfRead(1, iZ, 15));
    sKuda1:=         Trim(DbfRead(1, iZ, 16));
    sKuda2:=         Trim(DbfRead(1, iZ, 17));
    sIsxod:=         Trim(DbfRead(1, iZ, 18));
    n5DlitOtd:=      Trim(DbfRead(1, iZ, 19));
    n2PostBChislo:=  Trim(DbfRead(1, iZ, 20));
    n2PostBMes:=     Trim(DbfRead(1, iZ, 21));
    n4PostBGod:=     Trim(DbfRead(1, iZ, 22));
    n5DlitObsh:=     Trim(DbfRead(1, iZ, 23));

    sNumIB:= sDOC;
    sNOPer:= sD_NOMER;
    sFio_ := sFIO;
    sGR   := n4DATA_G;
    sPol_     :=  sPol;
    sDataBoln := n2PostBChislo+'.'+n2PostBMes+'.'+n4PostBGod;
    sOtkuda   := sPOST;
    sDataOrit := n2PostChislo+'.'+n2PostMes+'.'+n4PostGod;
    sVBL      := sVIBIV;
    sKuda:= sKuda1;
    if UTF8Trim(sKuda2) <> '*' then sKuda:= sKuda+ ' '+ sKuda2;
    sKuda:= Trim(sKuda);
    sDataVip  := n2VipisChislo+'.'+n2VipisMes+'.'+n4VipisGod;
    sIsxod_   := sIsxod;
     k:= Pos(' ' ,sFio_);
    sFam := Copy(sFio_,1,k-1);
    sTMP := Copy(sFio_,k+1,40);
    k1:= Pos(' ',sTMP);
    sImia := Copy(sTMP,1,k1-1);
    sOth := Copy(sTMP,k1+1, 40);
    if ConsoleToUTF8(Trim(sNumIB)) = 'ПЕРЕВОДНОЙ ЭПИКРИЗ' then sNumIB :='' else begin
      // 'ВЫПИСКА ИЗ ИСТОРИИ БОЛЕЗНИ N~280н23'
    k:= Pos('N~',sNumIB);
    if k > 0 then sNumIB := Copy(sNumIB,k+2,15) else sNumIB:= '';
    end;
(*//Showmessage
   Showmessage(ConsoleToUTF8( sLUCH+ ' '+ sDOC+ ' '+ sD_NOMER+ ' '+ sFIO+ ' '+
                n4DATA_G+ ' '+
                sPol+ ' '+
                n2PostChislo+ ' '+
                n2PostMes+ ' '+
                n4PostGod+ ' '+
                sPOST+ ' '+
                sVIBIV+ ' '+
                n2VipisChislo+ ' '+
                n2VipisMes+ ' '+
                n4VipisGod+ ' '+
                sKuda1+ ' '+
                sKuda2+ ' '+
                sIsxod + ' '+
                n5DlitOtd+ ' '+
                n2PostBChislo+ ' '+
                n2PostBMes+ ' '+
                n4PostBGod+ ' '+
                n5DlitObsh
                ));
*)
   end; //Showmessage(ConsoleToUTF8(sFio_));
   DbfClose(1);
end;

procedure  inPEREMENAfDBF(var sPutDBF: string; iz: longint);

begin
  sPutDBF := UTF8ToConsole(DM_S.sRabDir+ DM_S.namedbf[2]);
  if DbfOpen(1, sPutDBF) <>0 then   Showmessage('Ошибка')
  else With PEREMENA, FB_EpiW do begin
    R :=         Trim(DbfRead(1, iZ, 1));
    sAdrStran:=  Trim(DbfRead(1, iZ, 2)); //MESTOJ_S
    sAdrRegion:= Trim(DbfRead(1, iZ, 3)); //MESTOJ_R
    sAdrPunkt:=  Trim(DbfRead(1, iZ, 4)); //MESTOJ_P
    sAdrMGit:=   Trim(DbfRead(1, iZ, 5)); //MESTOJ

   if ConsoleToUTF8(sAdrStran) <> 'Россия' then begin
    IDStrana:= D_FB.SelID('select codstrana from SL_STRANA where name_stran_pismo = ', 'codstrana', ConsoleToUTF8(sAdrStran));
    //Showmessage('Страна = '+ConsoleToUTF8(sAdrStran)+#13+                'IDStrana= '+ IDStrana);
    IDRegion:= 'NULL, 2';
    IDPunkt:=  'NULL';  //498, NULL, 2, NULL, ''); Молдавия
   end
   else begin
    IDStrana:= '643';
    if ConsoleToUTF8(sAdrRegion) = 'Московская обл.' then begin
     IDRegion:= '46';
     if (ConsoleToUTF8(sAdrPunkt) = 'г. Наро-Фоминск') or
        (ConsoleToUTF8(sAdrPunkt) = 'г. Наро-Фоминск,') then IDPunkt:= '1'; //г. Наро-Фоминск 1
     if (ConsoleToUTF8(sAdrPunkt) = 'Наро-Фоминский р-он') or
        (ConsoleToUTF8(sAdrPunkt) = 'Наро-Фоминский р-он,') then IDPunkt:= '2'; //      //Наро-Фоминский р-он 2
     if (ConsoleToUTF8(sAdrPunkt) = 'г. Одинцово') or
        (ConsoleToUTF8(sAdrPunkt) = 'г. Одинцово,') then IDPunkt:= '3'; //г. Одинцово 3
     if (ConsoleToUTF8(sAdrPunkt) = 'Одинцовский р-он') or
        (ConsoleToUTF8(sAdrPunkt) = 'Одинцовский р-он,') then IDPunkt:= '4'; //Одинцовский р-он, Одинцовский р-он 4
    end;

    if ConsoleToUTF8(sAdrRegion) = 'г. Москва' then begin  //'45', 1, NULL, 'ул.Семеновская набережная, д.3/1, корп.5, кв. 103');
     IDRegion:= '45, 1';
     IDPunkt:=  'NULL';
    end;
   end;

    sRabota:=    Trim(DbfRead(1, iZ, 6)); //MESTOR
    n1Invalid:=   Trim(DbfRead(1, iZ, 7)); //Nuneric1; //Nuneric1   INV_G
    sInvalidTip:= Trim(DbfRead(1, iZ, 8)); //INV_T1
    sInvalidVid:= Trim(DbfRead(1, iZ, 9)); //INV_T2
    arRodstv[1].sRODs    := Trim(DbfRead(1, iZ, 10));
    arRodstv[1].sRODsFIO := Trim(DbfRead(1, iZ, 11));
    arRodstv[1].sRODsADR := Trim(DbfRead(1, iZ, 12));
    arRodstv[2].sRODs    := Trim(DbfRead(1, iZ, 13));
    arRodstv[2].sRODsFIO := Trim(DbfRead(1, iZ, 14));
    arRodstv[2].sRODsADR := Trim(DbfRead(1, iZ, 15));
    sStrana:= sAdrStran;

{TODO: Выборку ID , если иностранец-нероссиянин}
    sRegion:= sAdrRegion;
    sPunkt:= sAdrPunkt;
    sPunkt:= Copy(sPunkt,1, (Length(sPunkt)-1) );
    IDPunkt:= sPunkt;
{TODO: Убрать запятую в конце пункта в Адресе}
    //Showmessage('sPunkt= '+sPunkt+'| === |' +ConsoleToUTF8(Copy(sPunkt,1, (Length(sPunkt)-1) ))+'|');

    try
     IDPunkt:= D_FB.SelID('select codpunkt from sl_punkt where punkt = ', 'codpunkt', ConsoleToUTF8(IDPunkt));
    except on Exception do IDPunkt:='!';
    end;

    //Showmessage('IDPunkt= |'+IDPunkt+'|');
    sAdrMJ:= sAdrMGit;
    sAdres := sStrana+' '+sRegion+' '+sPunkt+' '+sAdrMJ;

    if Trim(sRabota) = '*' then sRabota_:= '' else  sRabota_:= sRabota;
(*//Showmessage
    Showmessage('группа инвал.-----n1Invalid= |'+n1Invalid+'|'+#13+
                'тип    инвал.-----sInvalidTip= |'+ConsoleToUTF8(sInvalidTip)+'|'+#13+
                'вид    инвал.-----sInvalidVid= |'+ConsoleToUTF8(sInvalidVid)+'|');
*)
    if Trim(n1Invalid) <> '*' then begin
    sGrInvalid:= n1Invalid;
    if ConsoleToUTF8(sInvalidTip) = 'По психическому заболеванию' then sInvalidT:= '0' else sInvalidT:= '1'; {0=По психическому заболеванию  1=По соматическому заболеванию}

    if ConsoleToUTF8(sInvalidVid) = 'бессрочно' then sInvalidSrok := sInvalidVid else sInvalidSrok := 'NULL';

    sInvalidAll:= sGrInvalid+UTF8ToConsole('-й группы, ') +ConsoleToUTF8(sInvalidTip)+', '+ConsoleToUTF8(sInvalidVid);

    if (ConsoleToUTF8(sInvalidVid) <> 'ВОВ (войны)') or
       (ConsoleToUTF8(sInvalidVid) = 'Трудовое увечье') or
       (ConsoleToUTF8(sInvalidVid) = 'С детства') then sInvalidVid := '0' else begin
       if ConsoleToUTF8(sInvalidVid) = 'ВОВ (войны)' then sInvalidVid := '3';
       if ConsoleToUTF8(sInvalidVid) = 'Трудовое увечье' then sInvalidVid := '2';
       if ConsoleToUTF8(sInvalidVid) = 'С детства' then sInvalidVid := '1';
    end;

    end;
    //sInvalidAll:=   {Все для вставки в Word}

    s1RostvID:=  arRodstv[1].sRODs;
    ID1RostvID:= s1RostvID;
    try
     ID1RostvID:= D_FB.SelID('select codrodstv from sl_rodstv where rodstv = ', 'codrodstv', ConsoleToUTF8(ID1RostvID));
    except on Exception do ID1RostvID:='!';
    end;    //Showmessage('ID1RostvID= |'+ID1RostvID+'|');

    s1RostvFio:= arRodstv[1].sRODsFIO;
    s1RostvAdr:= arRodstv[1].sRODsADR;
    s2RostvID:=  arRodstv[2].sRODs;
    ID2RostvID:= s2RostvID;
    try
     ID2RostvID:= D_FB.SelID('select codrodstv from sl_rodstv where rodstv = ', 'codrodstv', ConsoleToUTF8(ID2RostvID));
    except on Exception do ID2RostvID:='!';
    end;

    s2RostvFio:= arRodstv[2].sRODsFIO;
    s2RostvAdr:= arRodstv[2].sRODsADR; //sRodstvAll := s1RostvID  +' '+s1RostvFio +' '+s1RostvAdr +' '+s2RostvID  +' '+s2RostvFio +' '+s2RostvAdr;
    if s2RostvID <> '*' then  sRodstvAll := #13+ s2RostvID  +' '+s2RostvFio +' '+s2RostvAdr;
    if s1RostvID <> '*' then  sRodstvAll := s1RostvID  +' '+s1RostvFio +' '+s1RostvAdr +sRodstvAll
       else sRodstvAll := '';
  end;
  DbfClose(1);
end;

procedure  inDIAGKOSNfDBF(var sPutDBF: string; iz: longint);
var
  y, k, m, d, j: integer;  //sShifrDz,iLenDzO
  sDzO1, sDzOsnBezSh: string; //, sDzO2, sDzO3
begin
  {Очистить. На всякий случай!}
 With FB_EpiW do begin
  for m := 1 to 50 do begin
    DZArray[m].sTipDz:= '*';
    DZArray[m].sShifr:= '*';
    DZArray[m].sDz:= '*';
  end;
  sDzOsnALL := '';
 end;
  sPutDBF := UTF8ToConsole(DM_S.sRabDir+ DM_S.namedbf[3]);
  if DbfOpen(1, sPutDBF) <>0 then   Showmessage('Ошибка')
  else With DIAGKOSN, FB_EpiW do begin
{$REGION 'Считывание диагнозов из DBF_L'}
   R :=         Trim(DbfRead(1, iZ, 1));
    k:= 2;
    sTMP :='';
    for y := 1 to 6 do begin  {шифры E}
      arShE[y] := Trim(DbfRead(1, iZ, k)); //arShE: array [1..6] of string[10]; //шифр PRE01- PRE06
      k:= k+1;
    end;
    k:= 8;
    for y := 1 to 6 do begin {шифры A}
      arShA[y] := Trim(DbfRead(1, iZ, k)); //arShA: array [1..6] of string[10]; //шифр PRA01- PRA06
      k:= k+1;
    end;
    k:= 14;
    for y := 1 to 12 do begin {Основной ДЗ}
      arDzOsn[y] := Trim(DbfRead(1, iZ, k)); //arDzOsn: array [1..12] of string[60]; //основное DIAGO01 - DIAGO12
      k:= k+1;
    end;
    k:= 26;
    for y := 1 to 12 do begin {Фоновое заб-е}
      arDzFon[y] := Trim(DbfRead(1, iZ, k)); //arDzFon: array [1..12] of string[60]; //фоновое  DIAGF01 - DIAGF12
      k:= k+1;
    end;
    k:= 38;
    for y := 1 to 26 do begin {ДЗ осложнений}
      arDzOsl[y] := Trim(DbfRead(1, iZ, k)); //arDzOsl: array [1..26] of string[60]; //осложнений  DIAGOSL01 - DIAGOSL26
      k:= k+1;
    end;
    k:= 64;
    for y := 1 to 16 do begin  {ДЗ сопутствующих}
      arDzSop[y] := Trim(DbfRead(1, iZ, k)); //arDzSop: array [1..16] of string[60]; //сопутствующих  DIAGSOP01 - DIAGSOP16
      k:= k+1;
    end;
{$ENDREGION}

{$REGION 'выборка диагнозов по типам без удаления скобок'}
    sTMP :='';
    for y := 1 to 12 do if Trim(arDzOsn[y]) <> '*' then sTMP := sTMP+' '+Trim(arDzOsn[y]);
    sDzOsn := Trim(sTMP);
    sTMP :='';
    for y := 1 to 12 do if Trim(arDzFon[y]) <> '*' then sTMP := sTMP+' '+Trim(arDzFon[y]); {фоновые}
    sDzFon := Trim(sTMP);
    sTMP :='';
    for y := 1 to 26 do if Trim(arDzOsl[y]) <> '*' then sTMP := sTMP+' '+Trim(arDzOsl[y]); {осложнения}
    sDzOsl:= Trim(sTMP);
    sTMP :='';
    for y := 1 to 16 do if Trim(arDzSop[y]) <> '*' then sTMP := sTMP+' '+Trim(arDzSop[y]); {сопутствующие}
    sDzSop:= Trim(sTMP);
{$ENDREGION}
(* //Showmessage
Showmessage('sDzOsn= '+'|'+ConsoleToUTF8(sDzOsn)+'|'+#13+
            'sDzFon= '+'|'+ConsoleToUTF8(sDzFon)+'|'+#13+
            'sDzOsl= '+'|'+ConsoleToUTF8(sDzOsl)+'|'+#13+
            'sDzSop= '+'|'+ConsoleToUTF8(sDzSop)+'|'
          );

*)
{$REGION 'Замена Шифров МКБ-9 (в фигурных скобках) и Шифров МКБ-10(кроме основного д-за) в диагнозах на ~~'}
sTMP:='';
 selDzProh(sDzOsn, sTMP);
 sDzOsn := sTMP;

 sTMP:='';
 if Length(Trim(sDzFon))> 0 then begin
     selDzProh(sDzFon, sTMP);     sDzFon:= sTMP;
     selDzProh2(sDzFon, sTMP);    sDzFon:= sTMP;     //Showmessage('sDzFon= '+'|'+ConsoleToUTF8(sDzFon)+'|');
 end;

 sTMP:='';
 if Length(Trim(sDzOsl))> 0 then begin
      selDzProh(sDzOsl, sTMP);      sDzOsl:= sTMP;
      selDzProh2(sDzOsl, sTMP);      sDzOsl:= sTMP;      //Showmessage('sDzOsl= '+'|'+ConsoleToUTF8(sDzOsl)+'|');
 end;

 sTMP:='';
 if Length(Trim(sDzSop))> 0 then begin
     selDzProh(sDzSop, sTMP);     sDzSop:= sTMP;
     selDzProh2(sDzSop, sTMP);    sDzSop:= sTMP; //Showmessage('sDzSop= '+'|'+ConsoleToUTF8(sDzSop)+'|');
 end;
{$ENDREGION}
(* //Showmessage
 Showmessage('sDzOsn= '+'|'+ConsoleToUTF8(sDzOsn)+'|'+#13+
             'sDzFon= '+'|'+ConsoleToUTF8(sDzFon)+'|'+#13+
             'sDzOsl= '+'|'+ConsoleToUTF8(sDzOsl)+'|'+#13+
             'sDzSop= '+'|'+ConsoleToUTF8(sDzSop)+'|'
           );
*)

    j:=0;
    sDzOsn:= delperenos(sDzOsn);
    for d := 1 to 50 do begin
      With DZArray[d] do begin
          sTipDz:= '0'; sTMP:=''; sDzO1:=''; sDzOsnBezSh:='';
          selDzOsn(sDzOsn, sTMP, sShifr, sDzOsnBezSh, sDzO1);
          if d = 1 then sDzOsnALL := sDzO1
           else sDzOsnALL := sDzOsnALL+#13+sDzO1;
(* //Showmessage
          Showmessage('sDzOsn= |'+ConsoleToUTF8(sDzOsn)+'|'+#13+
                      'sDzO1=  |'+ConsoleToUTF8(sDzO1)+' |'+#13+
                       'sDzOsnALL= |'+ConsoleToUTF8(sDzOsnALL)+'|');
          Showmessage('d= '+IntToStr(d)+#13+
                      'sTipDz= |'+sTipDz+'|'#13+
                      'sDzOsn= '+'|'+ConsoleToUTF8(sDzOsn)+'|'+#13+
                      'TMP= '+'|'+ConsoleToUTF8(sTMP)+'|'+#13+
                      'sShifr= '+'|'+ConsoleToUTF8(sShifr)+'|'+#13+
                      'sDzOsnBezSh= '+'|'+ConsoleToUTF8(sDzOsnBezSh)+'|'+#13+
                      'sDzO1= '+'|'+ConsoleToUTF8(sDzO1)+'|'
                        );
*)
          sDzOsn:=  AnsiReplaceText(sDzOsn, sTMP,'');
          sDzOsn:=  AnsiReplaceText(sDzOsn, sShifr,'');
          sDzOsn:=  AnsiReplaceText(sDzOsn, '[]','');
          sDzOsn:=  AnsiReplaceText(sDzOsn,  sDzOsnBezSh,'');
          sDzOsn:= Trim(sDzOsn);          //Showmessage('2раз++sDzOsn= '+'|'+ConsoleToUTF8(sDzOsn)+'|');
          sDz:= sDzOsnBezSh;

      if (Length(Trim(selSHFromDz(sDzOsn))) = 0) and   {в основном диагнозе уже нет шифров в квадратных скобках}
         (UTF8Pos('~~', ConsoleToUTF8(sDzOsn), 1) > 0) {если в основном диагнозе есть ~~  надо их удалить! }
         then begin
          sTMP:='';
          sTMP:= Copy(sDzOsn,1, Length(sDzOsn)-2);
          sShifr:= 'NULL';
          sDz:= Trim(sTMP);
          //Showmessage('в Осн_д нет шифров... sDz= '+'|'+ConsoleToUTF8(sDz)+'|'+#13+
          //            'sTMP= |'+ConsoleToUTF8(sTMP)+'|');

          sDzOsn:=  AnsiReplaceText(sDzOsn,  sTMP,'');
          sDzOsn:=  AnsiReplaceText(sDzOsn,  '~~','');

      if Length(Trim(sDzOsn)) = 0 then begin
          j:= d+2;
          break;
       end;
     end;
(* {внизу - ситуация, когда вообще нет никаких шифров после диагноза!}
     if (UTF8Pos('~~', ConsoleToUTF8(sDzOsn), 1) = 0) and (UTF8Pos('[', ConsoleToUTF8(sDzOsn), 1) = 0) then begin
         sShifr:= 'NULL';
         sDz:= Trim(sDzOsn);   //Showmessage('3раз++sDzOsn= '+'|'+ConsoleToUTF8(sDz)+'|');
         Showmessage('только ~~ sDz= '+'|'+ConsoleToUTF8(sDz)+'|'+#13+
                      'sDzOsn= |'+ConsoleToUTF8(sDzOsn)+'|');

     end;
*)

      if Length(Trim(sDzOsn)) = 0 then begin
(* //Showmessage
       Showmessage('Length(Trim(sDzOsn)) = 0 sDzOsn= |'+ConsoleToUTF8(sDzOsn)+'|'+#13+
                    'sDz= |'+ConsoleToUTF8(sDz)+'|'+#13+
                    'sTMP= |'+ConsoleToUTF8(sTMP)+'|');
*)
          j:= d+1;
          break;
       end;
      end; {With DZArray[d] do begin  Основной Дз}
    end; {for d := 1 to 50 do Основной Дз}      //Showmessage('j= '+IntToStr(j));



//ФОНОВЫЕ
  if Length(Trim(sDzFon)) > 0 then begin  //Showmessage('До преобразований sDzFon= '+'|'+ConsoleToUTF8(sDzFon)+'|');
  sDzFon:=  AnsiReplaceText(sDzFon,  '~~ ~~','~~');  //Showmessage('ПОСЛЕ преобразований sDzFon= '+'|'+ConsoleToUTF8(sDzFon)+'|');
  sDzFon:= delperenos(sDzFon);
  sTMP:= Trim(sDzFon);  //Showmessage('j= '+IntToStr(j));
  for d := j to 50 do begin   //Showmessage('Фон d= '+IntToStr(d));
   With DZArray[d] do begin
      sTipDz:= '1';
      sShifr:= 'NULL';

      sDz:= Trim(selfromDz(sTMP));      //if sDz <> '~' then begin        //Showmessage('sDz= '+'|'+ConsoleToUTF8(sDz)+'|');        //Showmessage('sTMP= '+'|'+ConsoleToUTF8(sTMP)+'|');
       sTMP:= Copy(sTMP, (Length(sDz)+4), (Length(sTMP)-(Length(sDz)+2) ) );
       sTMP:= Trim(sTMP);        //Showmessage('2-е sTMP= '+'|'+ConsoleToUTF8(sTMP)+'|');
      if Length(Trim(sTMP)) > 0 then //Showmessage('d= '+IntToStr(d))
      else begin
      j := d+1;      //Showmessage('j= '+IntToStr(j));
      break;
      end;
    end; {With DZArray[d] do begin --фоновые}
   end; {for d := j to 50   --фоновые}
  end; {if Length(Trim(sDzFon)) > 0 }

//ОСЛОЖНЕНИЯ
     if Length(Trim(sDzOsl)) > 0 then begin
     sDzOsl:= delperenos(sDzOsl);
     sTMP:= Trim(sDzOsl);     //Showmessage('Осложненния j= '+IntToStr(j));
     for d := j to 50 do begin      //Showmessage('Осложненния d= '+IntToStr(d));
      With DZArray[d] do begin
         sTipDz:= '2';
         sShifr:= 'NULL';
         sDz:= Trim(selfromDz(sTMP));         //if sDz <> '~' then begin          //         Showmessage('Осложненния==d= '+IntToStr(d)+#13+                     'Осложненния sDz= '+'|'+ConsoleToUTF8(sDz)+'|');         Showmessage('Осложненния sTMP= '+'|'+ConsoleToUTF8(sTMP)+'|');
          sTMP:= Copy(sTMP, (Length(sDz)+4), (Length(sTMP)-(Length(sDz)+2) ) );
          sTMP:= Trim(sTMP);          //Showmessage('Осложненния 2-е sTMP= '+'|'+ConsoleToUTF8(sTMP)+'|');
         if Length(Trim(sTMP)) > 0 then //Showmessage('Осложненния if Length(Trim(sTMP)) > 0==d= '+IntToStr(d))
         else begin
         j := d+1;         //Showmessage('Осложненния j= '+IntToStr(j));
         break;
         end;
       end; {With DZArray[d] do begin --Осложненния}
      end; {for d := j to 50   --Осложненния}
     end; {if Length(Trim(sDzOsl)) > 0 }

//Сопутствующие
         if Length(Trim(sDzSop)) > 0 then begin
         sDzSop:= delperenos(sDzSop);
         sTMP:= Trim(sDzSop);         //Showmessage('Сопутствующие j= '+IntToStr(j));
         for d := j to 50 do begin          //Showmessage('Сопутствующие d= '+IntToStr(d));
          With DZArray[d] do begin
             sTipDz:= '3';
             sShifr:= 'NULL';

             sDz:= Trim(selfromDz(sTMP));
             //if sDz <> '~' then begin              Showmessage('Сопутствующие sDz= '+'|'+ConsoleToUTF8(sDz)+'|');              Showmessage('Сопутствующие sTMP= '+'|'+ConsoleToUTF8(sTMP)+'|');
              sTMP:= Copy(sTMP, (Length(sDz)+4), (Length(sTMP)-(Length(sDz)+2) ) );
              sTMP:= Trim(sTMP);              //Showmessage('Сопутствующие 2-е sTMP= '+'|'+ConsoleToUTF8(sTMP)+'|');
             if Length(Trim(sTMP)) > 0 then //Showmessage('Сопутствующие if Length(Trim(sTMP)) > 0==d= '+IntToStr(d))
             else begin
             j := d+1;             //Showmessage('Сопутствующие j= '+IntToStr(j));
             break;
             end;
           end; {With DZArray[d] do begin --Сопутствующие}
          end; {for d := j to 50   --Сопутствующие}
         end; {if Length(Trim(sDzSop)) > 0 }
(* //Showmessage
   for d := 1 to 50 do begin
      With DZArray[d] do begin
       if sDz = '*' then break;

       Showmessage('Из DZArray[d]!!!'+#13#13+
                   'd= '+IntToStr(d)+#13+
                   'sTipDz= |'+sTipDz+'|'#13+
                   'sShifr= '+'|'+ConsoleToUTF8(sShifr)+'|'+#13+
                   'sDz= '+'|'+ConsoleToUTF8(sDz)+'|'
                   );

      end; {With DZArray[d] do begin}
   end; {for d := j to 50 }
*)
(*//Showmessage
Showmessage('sDzOsn= '+'|'+ConsoleToUTF8(sDzOsn)+'|'+#13+
                  'sDzO1= '+'|'+ConsoleToUTF8(sDzO1)+'|'+#13#13+
                  'sDzFon= '+'|'+ConsoleToUTF8(sDzFon)+'|'+#13+
                  'sDzOsl= '+'|'+ConsoleToUTF8(sDzOsl)+'|'+#13+
                  'sDzSop= '+'|'+ConsoleToUTF8(sDzSop)+'|'
                );
*)
   sDzFon:=  AnsiReplaceText(sDzFon, '~~', '');
   sDzOsl:=  AnsiReplaceText(sDzOsl, '~~', '');
   sDzSop:=  AnsiReplaceText(sDzSop, '~~', '');
  end; //With DIAGKOSN, FB_EpiW do
  DbfClose(1);
end;

procedure  inDIAGPOSNfDBF(var sPutDBF: string; iz: longint);
var
  y, k: integer;
begin
  sPutDBF := UTF8ToConsole(DM_S.sRabDir+ DM_S.namedbf[3]);
  //Showmessage(sPutDBF);
  if DbfOpen(1, sPutDBF) <>0 then   Showmessage('Ошибка')
  else With DIAGPOSN, FB_EpiW do begin
    R :=         Trim(DbfRead(1, iZ, 1));
    k:= 2;
    for y := 1 to 14 do begin
      arPShOsn[y] := Trim(DbfRead(1, iZ, k)); //arPShOsn: array [1..12] of string[10]; //шифр основ ПА диагноза SHOSNP01 - SHOSNP02    //SHOSNS01 - SHOSNS12
      k:= k+1;
    end;
    k:= 15;
    for y := 1 to 12 do begin
      arPDzOsn[y] := Trim(DbfRead(1, iZ, k)); //arPDzOsn: array [1..12] of string[60]; //основное DIAGOSNP01 - DIAGOSNP06   //DIAGOSNS01 - DIAGOSNS06
      k:= k+1;
    end;
    k:= 27;
    for y := 1 to 8 do begin
      arPShFon[y] := Trim(DbfRead(1, iZ, k)); //arPShFon: array [1..8] of string[10]; //шифр SHFONP01 - SHFONP02   SHFONS01- SHFONS06
      k:= k+1;
    end;
    k:= 35;
    for y := 1 to 12 do begin
      arPDzFon[y] := Trim(DbfRead(1, iZ, k)); //arPDzFon: array [1..12] of string[60]; //фоновое  DIAGFONP01 - DIAGFONP06   //DIAGFONS01 - DIAGFONS06
      k:= k+1;
    end;
    k:= 47;
    for y := 1 to 8 do begin
      arPShOsl[y] := Trim(DbfRead(1, iZ, k)); //arPShOsl: array [1..8] of string[10]; //шифр SHOSLP01 - SHOSLP02   SHOSLS01- SHOSLS06
      k:= k+1;
    end;
    k:= 55;
    for y := 1 to 16 do begin
      arPDzOsl[y] := Trim(DbfRead(1, iZ, k)); //arPDzOsl: array [1..16] of string[60]; //осложнений  DIAGOSLS01 - DIAGOSLS10  DIAGOSLP01 - DIAGOSLP06
      k:= k+1;
    end;
    k:= 71;
    for y := 1 to 8 do begin
      arPShSop[y] := Trim(DbfRead(1, iZ, k)); //arPShSop: array [1..12] of string[10]; //шифр SHSOPP01 - SHSOPP02   SHSOPS01- SHSOPS06
      k:= k+1;
    end;

    k:= 83;
    for y := 1 to 16 do begin
      arPDzSop[y] := Trim(DbfRead(1, iZ, k)); //arPDzSop: array [1..16] of string[60]; //сопутствующих  DIAGSOPS01 - DIAGSOPS10   DIAGSOPP01 - DIAGSOPP06
      k:= k+1;
    end;
  end;
  DbfClose(1);
end;

procedure  inZAKLUCHEfDBF(var sPutDBF: string; iz: longint);
var
  y, k: integer;
begin
  sPutDBF := UTF8ToConsole(DM_S.sRabDir+ DM_S.namedbf[5]);

  if DbfOpen(1, sPutDBF) <>0 then   Showmessage('Ошибка')
  else With ZAKLUCHE, FB_EpiW do begin
    R :=         Trim(DbfRead(1, iZ, 1));
    k:= 2;
    for y := 1 to 16 do begin
      arPAZAKL[y] := Trim(DbfRead(1, iZ, k)); //arPAZAKL:  array [1..40] of string[60]; //ZAKL01 - ZAKL16
      k:= k+1;
    end;
    sRSX_KAT := Trim(DbfRead(1, iZ, 18)); //sRSX_KAT:  string[26];  //RSX_KAT

    k:= 19;
    for y := 1 to 7 do begin
      arRSX_TIP[y] := Trim(DbfRead(1, iZ, k)); //arRSX_TIP: array [1..7] of string[60]; //RSX_TIP01 - RSX_TIP07
      k:= k+1;
    end;
    k:= 26;
    for y := 1 to 10 do begin
      arRSX_PRI[y] := Trim(DbfRead(1, iZ, k)); //arRSX_PRI: array [1..10] of string[60]; //RSX_PRI01 - RSX_PRI10
      k:= k+1;
    end;
  end;
  DbfClose(1);
end;

procedure  inANAM_GZNfDBF(var sPutDBF: string; iz: longint);
var
  y, k: integer;
  sTMP: string;
begin
  sPutDBF := UTF8ToConsole(DM_S.sRabDir+ DM_S.namedbf[6]);
  if DbfOpen(1, sPutDBF) <>0 then   Showmessage('Ошибка')
  else With ANAM_GZN, FB_EpiW  do begin
    R :=         Trim(DbfRead(1, iZ, 1));
    k:=2;
    for y := 1 to 24 do begin
     arOpisGZN[y]:= Trim(DbfRead(1, iZ, k)); //arOpisGZN: array [1..24] of string[60];
     k:= k+1;
    end;
    sTMP :='';
    for y := 1 to 24 do
      if  Trim(arOpisGZN[y]) <> '*' then
      sTMP:= sTMP+ ' '+ Trim(arOpisGZN[y]);
    sAnGz:= ConsoleToUTF8(Trim(sTMP));
    sAnGz:= delperenos(sAnGz);
  end;
  DbfClose(1);
end;

procedure  inANAM_ZBLfDBF(var sPutDBF: string; iz: longint);
var
  y, k: integer;
  sTMP: string;
begin
  sPutDBF := UTF8ToConsole(DM_S.sRabDir+ DM_S.namedbf[7]);
  if DbfOpen(1, sPutDBF) <>0 then   Showmessage('Ошибка')
  else With ANAM_ZBL, FB_EpiW do begin
    R :=         Trim(DbfRead(1, iZ, 1));
    sKATAANA :=  Trim(DbfRead(1, iZ, 2));
    k:=3;
    for y := 1 to 40 do begin
     arOpisZBL[y]:= Trim(DbfRead(1, iZ, k)); //arOpisZBL: array [1..40] of string[60];
     k:= k+1;
    end;
    sTMP :='';
    for y := 1 to 40 do
      if  Trim(arOpisZBL[y]) <> '*' then
       sTMP:= sTMP+ ' '+ Trim(arOpisZBL[y]);
    sAnZb:= ConsoleToUTF8(Trim(sTMP));
    sAnZb:= delperenos(sAnZb);
  end;
  DbfClose(1);
end;

procedure  inPSIXISOSfDBF(var sPutDBF: string; iz: longint);
var
  y, k: integer;
  sTMP: string;
begin
  sPutDBF := UTF8ToConsole(DM_S.sRabDir+ DM_S.namedbf[8]);
  if DbfOpen(1, sPutDBF) <>0 then   Showmessage('Ошибка')
  else With PSIXISOS, FB_EpiW do begin
    R :=         Trim(DbfRead(1, iZ, 1));
    k:=2;
    for y := 1 to 48 do begin
     arOpisPSIX[y]:= Trim(DbfRead(1, iZ, k)); //arOpisPSIX: array [1..48] of string[60]; //SOST01 - SOST48
     k:= k+1;
    end;
    sTMP :='';
    for y := 1 to 48 do
      if  Trim(arOpisPSIX[y]) <> '*' then
      sTMP:= sTMP+ ' '+ Trim(arOpisPSIX[y]);
    sPsSt:= ConsoleToUTF8(Trim(sTMP));
    sPsSt:= delperenos(sPsSt);
  end;
  DbfClose(1);
end;

procedure  inSOMATSOSfDBF(var sPutDBF: string; iz: longint);
var
  y, k: integer;
  sTMP: string;
begin
  sPutDBF := UTF8ToConsole(DM_S.sRabDir+ DM_S.namedbf[9]);
  if DbfOpen(1, sPutDBF) <>0 then   Showmessage('Ошибка')
  else With SOMATSOS, FB_EpiW do begin
    R :=         Trim(DbfRead(1, iZ, 1));
    k:=2;
    for y := 1 to 48 do begin
     arOpisSOMA[y]:= Trim(DbfRead(1, iZ, k)); //arOpisSOMA: array [1..48] of string[60]; //SOST01 - SOST48
     k:= k+1;
    end;
    sTMP :='';
    for y := 1 to 48 do
      if  Trim(arOpisSOMA[y]) <> '*' then
      sTMP:= sTMP+ ' '+ Trim(arOpisSOMA[y]);
    sSomS:= ConsoleToUTF8(Trim(sTMP));
    sSomS:= delperenos(sSomS);
  end;
  DbfClose(1);
end;

procedure  inNEVROSOSfDBF(var sPutDBF: string; iz: longint);
var
  y, k: integer;
begin
  sPutDBF := UTF8ToConsole(DM_S.sRabDir+ DM_S.namedbf[10]);
  if DbfOpen(1, sPutDBF) <>0 then   Showmessage('Ошибка')
  else With NEVROSOS, FB_EpiW do begin
    R :=         Trim(DbfRead(1, iZ, 1));
    k:=2;
    for y := 1 to 40 do begin
     arOpisNEVR[y]:= Trim(DbfRead(1, iZ, k)); //arOpisNEVR: array [1..40] of string[60]; //SOST01 - SOST40
     k:= k+1;
    end;
    sTMP :='';
    for y := 1 to 40 do
      if  Trim(arOpisNEVR[y]) <> '*' then
      sTMP:= sTMP+ ' '+ Trim(arOpisNEVR[y]);
    sNevS:= ConsoleToUTF8(Trim(sTMP));
    sNevS:= delperenos(sNevS);
  end;
  DbfClose(1);
end;

procedure  inANAL_GIRfDBF(var sPutDBF: string; iz: longint);
var
  y, k: integer;
begin
  sPutDBF := UTF8ToConsole(DM_S.sRabDir+ DM_S.namedbf[11]);
  if DbfOpen(1, sPutDBF) <>0 then   Showmessage('Ошибка')
  else With ANAL_GIR, FB_EpiW do begin
    sGruppaKr:='';  sAnalObsh:='';
    R :=         Trim(DbfRead(1, iZ, 1));
    k:=2;
    for y := 1 to 2 do begin
     arGRRezKr[y]:= Trim(DbfRead(1, iZ, k)); //arGRRezKr: array [1..2] of string[17];
     k:= k+1;
    end;
    if (arGRRezKr[1] <> '*') and  (arGRRezKr[2] <> '*') then sGruppaKr := arGRRezKr[1] +', '+arGRRezKr[2];
    k:=4;
    for y := 1 to 18 do begin
     arOpisProchAn[y]:= Trim(DbfRead(1, iZ, k)); //arOpisProchAn: array [1..18] of string[60];
     if arOpisProchAn[y] = '*' then break else
      sAnalObsh := sAnalObsh +' '+ arOpisProchAn[y];
     k:= k+1;
    end;
    sAnalObsh:= ConsoleToUTF8(Trim(sAnalObsh));
    sAnalObsh:= delperenos(sAnalObsh);    //Showmessage('sAnalObsh= '+ sAnalObsh);
  end;
  DbfClose(1);
end;

procedure  inANAL_KRVfDBF(var sPutDBF: string; iz: longint);
var
  y, k: integer;
begin
  sPutDBF := UTF8ToConsole(DM_S.sRabDir+ DM_S.namedbf[12]);
  if DbfOpen(1, sPutDBF) <>0 then   Showmessage('Ошибка')
  else With OAK, FB_EpiW do begin
   sAnalKr := '';
    R :=         Trim(DbfRead(1, iZ, 1));
    k:=2;
    for y := 1 to 6 do begin
     arOpisAn[y]:= Trim(DbfRead(1, iZ, k)); //arOpisAn: array [1..6] of string[60]; //описательные
    if arOpisAn[y] = '*' then break else
      sAnalKr := sAnalKr +' '+ arOpisAn[y];
     k:= k+1;
    end;
    sAnalKr:= ConsoleToUTF8(Trim(sAnalKr));
    sAnalKr:= delperenos(sAnalKr);    //Showmessage('sAnalKr= '+ sAnalKr);
    k:=8;
    //sTabAnWordK:='';
    for y := 1 to 30 do begin //arTablAn: array [1..30] of RKLanDann; {Структура }
     arTablAn[y].sNPok:= Trim(DbfRead(1, iZ, k));     //sNPok: string[25]; //наименование показателя
     arTablAn[y].sZnPok:= Trim(DbfRead(1, iZ, k+1));  //sZnPok: string[21]; //значение
     arTablAn[y].sPeriod:= Trim(DbfRead(1, iZ, k+2)); //sPeriod: string[17]; //период/дата анализа
     k:= k+3;
    end;
  end;
  DbfClose(1);
end;

procedure  inANAL_MCHfDBF(var sPutDBF: string; iz: longint);
var
  y, k: integer;
begin
  sPutDBF := UTF8ToConsole(DM_S.sRabDir+ DM_S.namedbf[13]);
  if DbfOpen(1, sPutDBF) <>0 then   Showmessage('Ошибка')
  else With OAM, FB_EpiW  do begin
    sAnalMO:= '';
    R :=         Trim(DbfRead(1, iZ, 1));
    k:=2;
    for y := 1 to 6 do begin
     arOpisAn[y]:= Trim(DbfRead(1, iZ, k)); //arOpisAn: array [1..6] of string[60]; //описательные
     if arOpisAn[y] = '*' then break else
      sAnalMO := sAnalMO +' '+ arOpisAn[y];
     k:= k+1;
    end;
    sAnalMO:= ConsoleToUTF8(Trim(sAnalMO));
    sAnalMO:= delperenos(sAnalMO);    //Showmessage('sAnalMO= '+ sAnalMO);
    k:=8;
    for y := 1 to 30 do begin //arTablAn: array [1..30] of RKLanDann; {Структура }
     arTablAn[y].sNPok:= Trim(DbfRead(1, iZ, k));     //sNPok: string[25]; //наименование показателя
     arTablAn[y].sZnPok:= Trim(DbfRead(1, iZ, k+1));  //sZnPok: string[21]; //значение
     arTablAn[y].sPeriod:= Trim(DbfRead(1, iZ, k+2)); //sPeriod: string[17]; //период/дата анализа
     k:= k+3;
    end;
  end;
  DbfClose(1);
end;

procedure  inANAL_LUMfDBF(var sPutDBF: string; iz: longint);
var
  y, k: integer;
begin
  sPutDBF := UTF8ToConsole(DM_S.sRabDir+ DM_S.namedbf[14]);
  if DbfOpen(1, sPutDBF) <>0 then   Showmessage('Ошибка')
  else With ANLikv, FB_EpiW  do begin
    sAnalLu:='';
    R :=         Trim(DbfRead(1, iZ, 1));
    k:=2;
    for y := 1 to 6 do begin
     arOpisAn[y]:= Trim(DbfRead(1, iZ, k)); //arOpisAn: array [1..6] of string[60]; //описательные
    if arOpisAn[y] = '*' then break else
      sAnalLu := sAnalLu +' '+ arOpisAn[y];
     k:= k+1;
    end;
    sAnalLu:= ConsoleToUTF8(Trim(sAnalLu));
    sAnalLu:= delperenos(sAnalLu);
    k:=8;
    for y := 1 to 30 do begin //arTablAn: array [1..30] of RKLanDann; {Структура }
     arTablAn[y].sNPok:= Trim(DbfRead(1, iZ, k));     //sNPok: string[25]; //наименование показателя
     arTablAn[y].sZnPok:= Trim(DbfRead(1, iZ, k+1));  //sZnPok: string[21]; //значение
     arTablAn[y].sPeriod:= Trim(DbfRead(1, iZ, k+2)); //sPeriod: string[17]; //период/дата анализа
     k:= k+3;
    end;
  end;
  DbfClose(1);
end;

procedure  inANAL_SVIfDBF(var sPutDBF: string; iz: longint);
var
  y, k: integer;
  sALL: string;
begin
  sALL:='';  sTMP:= '';
  sPutDBF := UTF8ToConsole(DM_S.sRabDir+ DM_S.namedbf[15]);
  if DbfOpen(1, sPutDBF) <>0 then   Showmessage('Ошибка')
  else With ANAL_SVI, FB_EpiW  do begin
   if Trim(DbfRead(1, iZ, 2)) <> '*'  then  begin
   sInstrumI  := ''; {FB_EpiW}
   R :=  Trim(DbfRead(1, iZ, 1));
    k:=2;   //OBSLArray[y].sVidOBSL  OBSLArray[y].sDATAOBSL OBSLArray[y].sREZ_OBSL
    for y := 1 to 6 do begin
      With OBSLArray[y] do begin       //Showmessage('sTMP= '+ ConsoleToUTF8(Trim(sTMP)) );
       sTMP:= '';

       if Trim(DbfRead(1, iZ, k)) = '*'  then  break;
         arAN_KONSVI[y].imyaissl:= Trim(DbfRead(1, iZ, k));
         sVidOBSL:= arAN_KONSVI[y].imyaissl; //OBSLArray[y].         //Showmessage('Trim(DbfRead(1, iZ, k))= '+  ConsoleToUTF8 (DbfRead(1, iZ, k) ) );
         arAN_KONSVI[y].sData:= Trim(DbfRead(1, iZ, k+1));
         sDATAOBSL:= arAN_KONSVI[y].sData; //OBSLArray[y].         //Showmessage('Trim(DbfRead(1, iZ, k+1))= '+ Trim(DbfRead(1, iZ, k+1)));
         sTMP:= Trim(DbfRead(1, iZ, k+2));         //Showmessage('Trim(DbfRead(1, iZ, k+2))= '+ ConsoleToUTF8(DbfRead(1, iZ, k+2)) );
         if Trim(DbfRead(1, iZ, k+3)) <> '*' then sTMP:= sTMP+' '+Trim(DbfRead(1, iZ, k+3));         //Showmessage('Trim(DbfRead(1, iZ, k+3))= '+ ConsoleToUTF8(DbfRead(1, iZ, k+3)) );
         if Trim(DbfRead(1, iZ, k+4)) <> '*' then sTMP:= sTMP+' '+Trim(DbfRead(1, iZ, k+4));         //Showmessage('Trim(DbfRead(1, iZ, k+4))= '+ ConsoleToUTF8(DbfRead(1, iZ, k+4)) );
         if Trim(DbfRead(1, iZ, k+5)) <> '*' then sTMP:= sTMP+' '+Trim(DbfRead(1, iZ, k+5));         //Showmessage('Trim(DbfRead(1, iZ, k+5))= '+ ConsoleToUTF8(DbfRead(1, iZ, k+5)) );
         if Trim(DbfRead(1, iZ, k+6)) <> '*' then sTMP:= sTMP+' '+Trim(DbfRead(1, iZ, k+6));         //Showmessage('Trim(DbfRead(1, iZ, k+6))= '+ ConsoleToUTF8(DbfRead(1, iZ, k+6)) );
         sREZ_OBSL := Trim(sTMP);
         sREZ_OBSL := delperenos(sTMP);
         sREZ_OBSL :=  ConsoleToUTF8(sREZ_OBSL);
(*//Showmessage
         Showmessage('y= '+ intToStr(y)+#13+
                      'sVidOBSL= |' +ConsoleToUTF8(sVidOBSL)+'|'+#13+
                      'sDATAOBSL= |' +sDATAOBSL+'|'+#13+
                      'sREZ_OBSL= |' +sREZ_OBSL+'|'
                     );
*)
         sALL:= ConsoleToUTF8(sVidOBSL)+ ' от ' + sDATAOBSL+ 'г. ' +sREZ_OBSL+#13;         //Showmessage('sALL= |' +Trim(sALL)+'|' );
        case y of
          1: k:= 10;
          2: k:= 18;
          3: k:= 26;
          4: k:= 34;
          5: k:= 42;
          6: k:= 50;
        end;        //Showmessage('k= '+ intToStr(k));
    sInstrumI := sInstrumI+sALL;
   //if OBSLArray[y].sVidOBSL <> '*' then sALL:= sALL + OBSLArray[y].sVidOBSL+ ' от ' + OBSLArray[y].sDATAOBSL+ 'г. ' +OBSLArray[y].sREZ_OBSL+#13;
      end; {With OBSLArray[y]}
   end; {for y := 1 to 6 do}
   end; {if Trim(DbfRead(1, iZ, 2)) = '*'}   //Showmessage('sInstrumI= |' +Trim(sInstrumI)+'|' );
  end; {With ANAL_SVI, FB_EpiW }
  DbfClose(1);
end;

procedure  inANAL_KONfDBF(var sPutDBF: string; iz: longint);
var
  y, k: integer;
  sALL: string;
begin
  sALL:='';  sTMP:= '';
  sPutDBF := UTF8ToConsole(DM_S.sRabDir+ DM_S.namedbf[16]);
  if DbfOpen(1, sPutDBF) <>0 then   Showmessage('Ошибка')
  else With ANAL_KON, FB_EpiW  do begin
   if Trim(DbfRead(1, iZ, 2)) <> '*'  then  begin
   sKonsult  := ''; {FB_EpiW}
   R :=  Trim(DbfRead(1, iZ, 1));
    k:=2;   //KONSArray[y].sVidOBSL  KONSArray[y].sDATAOBSL KONSArray[y].sREZ_OBSL
    for y := 1 to 6 do begin
      With KONSArray[y] do begin       //Showmessage('sTMP= '+ ConsoleToUTF8(Trim(sTMP)) );
       sTMP:= '';

       if Trim(DbfRead(1, iZ, k)) = '*'  then  break;
         arAN_KONSVI[y].imyaissl:= Trim(DbfRead(1, iZ, k));
         sVidOBSL:= arAN_KONSVI[y].imyaissl; //KONSArray[y].         //Showmessage('Trim(DbfRead(1, iZ, k))= '+  ConsoleToUTF8 (DbfRead(1, iZ, k) ) );
         arAN_KONSVI[y].sData:= Trim(DbfRead(1, iZ, k+1));
         sDATAOBSL:= arAN_KONSVI[y].sData; //KONSArray[y].         //Showmessage('Trim(DbfRead(1, iZ, k+1))= '+ Trim(DbfRead(1, iZ, k+1)));
         sTMP:= Trim(DbfRead(1, iZ, k+2));         //Showmessage('Trim(DbfRead(1, iZ, k+2))= '+ ConsoleToUTF8(DbfRead(1, iZ, k+2)) );
         if Trim(DbfRead(1, iZ, k+3)) <> '*' then sTMP:= sTMP+' '+Trim(DbfRead(1, iZ, k+3));         //Showmessage('Trim(DbfRead(1, iZ, k+3))= '+ ConsoleToUTF8(DbfRead(1, iZ, k+3)) );
         if Trim(DbfRead(1, iZ, k+4)) <> '*' then sTMP:= sTMP+' '+Trim(DbfRead(1, iZ, k+4));         //Showmessage('Trim(DbfRead(1, iZ, k+4))= '+ ConsoleToUTF8(DbfRead(1, iZ, k+4)) );
         if Trim(DbfRead(1, iZ, k+5)) <> '*' then sTMP:= sTMP+' '+Trim(DbfRead(1, iZ, k+5));         //Showmessage('Trim(DbfRead(1, iZ, k+5))= '+ ConsoleToUTF8(DbfRead(1, iZ, k+5)) );
         if Trim(DbfRead(1, iZ, k+6)) <> '*' then sTMP:= sTMP+' '+Trim(DbfRead(1, iZ, k+6));         //Showmessage('Trim(DbfRead(1, iZ, k+6))= '+ ConsoleToUTF8(DbfRead(1, iZ, k+6)) );
         sREZ_OBSL := Trim(sTMP);
         sREZ_OBSL := delperenos(sTMP);
         sREZ_OBSL :=  ConsoleToUTF8(sREZ_OBSL);
(*//Showmessage
         Showmessage('y= '+ intToStr(y)+#13+
                      'sVidOBSL= |' +ConsoleToUTF8(sVidOBSL)+'|'+#13+
                      'sDATAOBSL= |' +sDATAOBSL+'|'+#13+
                      'sREZ_OBSL= |' +sREZ_OBSL+'|'
                     );
*)
         sALL:= ConsoleToUTF8(sVidOBSL)+ ' от ' + sDATAOBSL+ 'г. ' +sREZ_OBSL+#13;         //Showmessage('sALL= |' +Trim(sALL)+'|' );
        case y of
          1: k:= 10;
          2: k:= 18;
          3: k:= 26;
          4: k:= 34;
          5: k:= 42;
          6: k:= 50;
        end;        //Showmessage('k= '+ intToStr(k));
    sKonsult := sKonsult+sALL;
   //if KONSArray[y].sVidOBSL <> '*' then sALL:= sALL + KONSArray[y].sVidOBSL+ ' от ' + KONSArray[y].sDATAOBSL+ 'г. ' +KONSArray[y].sREZ_OBSL+#13;
      end; {With KONSArray[y]}
   end; {for y := 1 to 6 do}
   end; {if Trim(DbfRead(1, iZ, 2)) = '*'}   //Showmessage('sKonsult= |' +Trim(sKonsult)+'|' );
  end; {With ANAL_SVI, FB_EpiW }
  DbfClose(1);
end;


procedure  inLEKA_MEDfDBF(var sPutDBF: string; iz: longint);
var
  y, k: integer;
begin
  sPutDBF := UTF8ToConsole(DM_S.sRabDir+ DM_S.namedbf[17]);
  if DbfOpen(1, sPutDBF) <>0 then   Showmessage('Ошибка')
  else With LEKA_MED, FB_EpiW do begin
    R :=         Trim(DbfRead(1, iZ, 1));
    k:=2;
    for y := 1 to 30 do begin
     arLekM[y]:= Trim(DbfRead(1, iZ, k)); //arLekM: array [1..30] of string[60]; //LEKA01101-LEKA0130
     k:= k+1;
    end;
    sTMP :='';
    With LEKA_MED do begin
     for y := 1 to 30 do
      if  Trim(arLekM[y]) <> '*' then
      sTMP:= sTMP+ ' '+ Trim(arLekM[y]);
    end;
    sLekM:= ConsoleToUTF8(Trim(sTMP));
    sLekM:= delperenos(sLekM);
    //Showmessage('sLekM= '+sLekM);
  end;
  DbfClose(1);
end;

procedure  inLEKA_NMDfDBF(var sPutDBF: string; iz: longint);
var
  y, k: integer;
begin
  sPutDBF := UTF8ToConsole(DM_S.sRabDir+ DM_S.namedbf[18]);
  if DbfOpen(1, sPutDBF) <>0 then   Showmessage('Ошибка')
  else With LEKA_NMD, FB_EpiW do begin
    R :=         Trim(DbfRead(1, iZ, 1));
    k:=2;
    for y := 1 to 20 do begin
     arLekNX[y]:= Trim(DbfRead(1, iZ, k)); //arLekNX: array [1..20] of string[60]; //LEKA02101-LEKA0220
     k:= k+1;
    end;
    sTMP :='';
    With LEKA_NMD do begin
     for y := 1 to 20 do
      if  Trim(arLekNX[y]) <> '*' then
      sTMP:= sTMP+ ' '+ Trim(arLekNX[y]);
    end;
    sLekNM:= ConsoleToUTF8(Trim(sTMP));
    sLekNM:= delperenos(sLekNM);
    //Showmessage('sLekNM= '+sLekNM);
  end;
  DbfClose(1);
end;

procedure  inLEKA_XIRfDBF(var sPutDBF: string; iz: longint);
var
  y, k: integer;
begin
  sPutDBF := UTF8ToConsole(DM_S.sRabDir+ DM_S.namedbf[19]);
  if DbfOpen(1, sPutDBF) <>0 then   Showmessage('Ошибка')
  else With LEKA_XIR, FB_EpiW do begin
    R :=         Trim(DbfRead(1, iZ, 1));
    k:=2;
    for y := 1 to 20 do begin
     arLekNX[y]:= Trim(DbfRead(1, iZ, k)); //arLekNX: array [1..20] of string[60]; //LEKA02101-LEKA0220
     k:= k+1;
    end;
    sTMP :='';
    With LEKA_XIR do begin
     for y := 1 to 20 do
      if  Trim(arLekNX[y]) <> '*' then
      sTMP:= sTMP+ ' '+ Trim(arLekNX[y]);
    end;
    sLekX:= ConsoleToUTF8(Trim(sTMP));
    sLekX:= delperenos(sLekX);
    //Showmessage('sLekX= '+sLekX);
  end;
  DbfClose(1);
end;

procedure  inLEKA_REZfDBF(var sPutDBF: string; iz: longint);
var
  y, k: integer;
begin
  sPutDBF := UTF8ToConsole(DM_S.sRabDir+ DM_S.namedbf[20]);
  if DbfOpen(1, sPutDBF) <>0 then   Showmessage('Ошибка')
  else With LEKA_REZ, FB_EpiW  do begin
    R :=         Trim(DbfRead(1, iZ, 1));
    k:=2;
    for y := 1 to 6 do begin
     arRezlek[y]:= Trim(DbfRead(1, iZ, k)); //arRezlek: array [1..20] of string[60]; //LEKA0401-LEKA0406
     REZLekArray[y]:= arRezlek[y];
     k:= k+1;
    end;
    sTMP :='';
    With LEKA_REZ do begin
     for y := 1 to 6 do
      if  Trim(arRezlek[y]) <> '*' then
       sTMP:= sTMP+ ' '+ Trim(arRezlek[y]);
    end;
    sRezLek:= ConsoleToUTF8(Trim(sTMP));
    sRezLek:= delperenos(sRezLek);

     n3ITSu:= Trim(DbfRead(1, iZ, 8));  //n3ITSu: Nuneric3;	//DL_TS  Nuneric3;
     n2ITCh:= Trim(DbfRead(1, iZ, 9));  //n2ITCh: Nuneric2;	//DL_TC  Nuneric2
     n2ITMi:= Trim(DbfRead(1, iZ, 10));  //n2ITMi: Nuneric2;	//DL_TM  Nuneric2
     n3PsSu:= Trim(DbfRead(1, iZ, 11));  //n3PsSu: Nuneric3;	//DL_PS  Nuneric3
     n2PsCh:= Trim(DbfRead(1, iZ, 12));  //n2PsCh: Nuneric2;	//DL_PC  Nuneric2
     n2PsMi:= Trim(DbfRead(1, iZ, 13));  //n2PsMi: Nuneric2;	//DL_PM  Nuneric2
     sIT_sutki  := n3ITSu;
     sIT_chas   := n2ITCh;
     sIT_min    := n2ITMi;
     sPS_chas   := n3PsSu;
     sPS_sutki  := n2PsCh;
     sPS_min    := n2PsMi;
  end;
  DbfClose(1);


end;


procedure  inRECOMENDfDBF(var sPutDBF: string; iz: longint);
var
  y, k: integer;
begin
  sPutDBF := UTF8ToConsole(DM_S.sRabDir+ DM_S.namedbf[21]);
  if DbfOpen(1, sPutDBF) <>0 then   Showmessage('Ошибка')
  else With RECOMEND, FB_EpiW do begin
    R :=         Trim(DbfRead(1, iZ, 1));
    k:=2;
    for y := 1 to 40 do begin
     arRecom[y]:= Trim(DbfRead(1, iZ, k)); //arRecom: array [1..40] of string[60]; //RECO01 - RECO40
     k:= k+1;
    end;
    sTMP :='';
    With RECOMEND do begin
     for y := 1 to 40 do
      if  Trim(arRecom[y]) <> '*' then
      sTMP:= sTMP+ ' '+ Trim(arRecom[y]);
    end;
    sRecomend:= ConsoleToUTF8(Trim(sTMP));
    sRecomend:= delperenos(sRecomend);
  end;
  DbfClose(1);
end;

procedure  inCOMMENTfDBF(var sPutDBF: string; iz: longint);
var
  y, k: integer;
begin
  sPutDBF := UTF8ToConsole(DM_S.sRabDir+ DM_S.namedbf[22]);
  if DbfOpen(1, sPutDBF) <>0 then   Showmessage('Ошибка')
  else With COMMENT, FB_EpiW do begin
    R :=         Trim(DbfRead(1, iZ, 1));
    k:=2;
    for y := 1 to 10 do begin
     arOpisCOM[y]:= Trim(DbfRead(1, iZ, k)); //arOpisCOM: array [1..10] of string[60]; //описания COM01 - COM10
     k:= k+1;
    end;
    k:= 12;
    for y := 1 to 4 do begin
     arVRACH[y]:= Trim(DbfRead(1, iZ, k)); //arVRACH: array [1..4] of string[22]; // VRACH1 VRACH2 VRACH3 ZAVOTD
     k:= k+1;
    end;
       sTMP :='';
    With COMMENT do begin
     for y := 1 to 10 do begin
      if  Trim(arOpisCOM[y]) <> '*' then
      sTMP:= sTMP+ ' '+ Trim(arOpisCOM[y]);

     sComment:= ConsoleToUTF8(Trim(sTMP));
     sComment:= delperenos(sComment);
    end;
    sVR1:= ConsoleToUTF8(arVRACH[1]);
    sVR2:= ConsoleToUTF8(arVRACH[2]);
    sVR3:= ConsoleToUTF8(arVRACH[3]);
    sZavORit:= ConsoleToUTF8(arVRACH[4]);
    end;

   IDVR1:=  selIdVrac(sVR1);
   IDVR2:=  selIdVrac(sVR2);
   IDVR3:=  selIdVrac(sVR3);
   IDZavORit:=selIdVrac(sZavORit);
  end;
  DbfClose(1);
end;

procedure  inSPRfDBF(var sPutDBF: string; iz: longint);
var
  y, k: integer;
begin
  sPutDBF := UTF8ToConsole(DM_S.sRabDir+ DM_S.namedbf[23]);
  if DbfOpen(1, sPutDBF) <>0 then   Showmessage('Ошибка')
  else With SPR, FB_EpiW do begin
    sNAMEPROT := Trim(DbfRead(1, iZ, 1)); //sNAMEPROT: string[30]; //NAMEPROT   ФИО=16симв+пробел+UJL_H(4cbvd)+ ..... на 30м месте ':' или '1' какое поступление
                                          ////Киселев Дми Вал 1977         :

    sSTR_TYPE := Trim(DbfRead(1, iZ, 2)); //sSTR_TYPE: string[20]; //STR_TYPE    'Эпикриз'
    sSTATUS   := Trim(DbfRead(1, iZ, 3)); //sSTATUS:   string[64]; //STATUS
    n2KEY     := ' 1'; //Trim(DbfRead(1, iZ, 4)); //??????? n2KEY:     Nuneric2;		//Nuneric2    KEYNUMB   1   дескрипторы DBF-ф-лов?
    k:=5;
    for y := 1 to 5 do begin
     arKEYS[y]:= Trim(DbfRead(1, iZ, k)); //arKEYS:    array [1..5] of string[60]; /KEY1 - KEY5   в KEY1 вначале пишется REG типа 'P202100118'
     k:= k+1;
    end;
  end;
  DbfClose(1);
end;

procedure ClearAnalizTbl;
var
  y: integer;
begin
  FB_EpiW.iAnK:= 0; FB_EpiW.iAnM:= 0; FB_EpiW.iAnL:= 0;
  for y := 1 to 90 do begin
    With FB_EpiW.AllTabAnal[y] do begin
       sNPok:= '*';  // sNPok: string[25]; //наименование показателя
       sZnPok:= '*';
       sPeriod:= '*';
    end;
  end;
end;

procedure inAnalizTbl(Akr, Amo, Alu: rANALIZ);
var
  y, m, lu: integer;
  sPeriodTmp: string;
begin
  ClearAnalizTbl;
  m:=1; lu:=1; sPeriodTmp:='';
  if Akr.arTablAn[1].sNPok <> '*' then begin
   for y := 1 to 90 do begin
     FB_EpiW.AllTabAnal[y].sNPok := Akr.arTablAn[y].sNPok;
     FB_EpiW.AllTabAnal[y].sZnPok := Akr.arTablAn[y].sZnPok;
     if Akr.arTablAn[1].sPeriod <> '-,,-' then sPeriodTmp := Akr.arTablAn[1].sPeriod;
     if Akr.arTablAn[y].sPeriod = '-,,-' then Akr.arTablAn[y].sPeriod:=  sPeriodTmp
      else sPeriodTmp := Akr.arTablAn[y].sPeriod;     //Showmessage('кровь период = '+ Akr.arTablAn[y].sPeriod );
     FB_EpiW.AllTabAnal[y].sPeriod := Akr.arTablAn[y].sPeriod;
     if Akr.arTablAn[y].sNPok = '*' then begin
       FB_EpiW.iAnK:= y;
       m:= FB_EpiW.iAnK;       //Showmessage('кровь iAnK= '+ IntToStr(FB_EpiW.iAnK));
      break;
     end;
   end;
  end;   //Showmessage('кровь break');
  sPeriodTmp:='';
  if Amo.arTablAn[1].sNPok <> '*' then begin
   for y := 1 to 90 do begin
     FB_EpiW.AllTabAnal[m].sNPok := Amo.arTablAn[y].sNPok;
     FB_EpiW.AllTabAnal[m].sZnPok := Amo.arTablAn[y].sZnPok;
     if Amo.arTablAn[1].sPeriod <> '-,,-' then sPeriodTmp := Amo.arTablAn[1].sPeriod;
     if Amo.arTablAn[y].sPeriod = '-,,-' then Amo.arTablAn[y].sPeriod:=  sPeriodTmp
      else sPeriodTmp := Amo.arTablAn[y].sPeriod;
     FB_EpiW.AllTabAnal[m].sPeriod := Amo.arTablAn[y].sPeriod;
     if Amo.arTablAn[y].sNPok = '*' then begin
         FB_EpiW.iAnM:= y;
         lu:= FB_EpiW.iAnK+FB_EpiW.iAnM-1;         //Showmessage('моча iAnM= '+ IntToStr(FB_EpiW.iAnM));
       break;
     end;
   m:= m+1;
   end;
  end;  //Showmessage('моча break');
  sPeriodTmp:='';
  if Alu.arTablAn[1].sNPok <> '*' then begin
   for y := 1 to 90 do begin     //Showmessage('1 ликвор z= '+ IntToStr(z));
     FB_EpiW.AllTabAnal[lu].sNPok := Alu.arTablAn[y].sNPok;
     FB_EpiW.AllTabAnal[lu].sZnPok := Alu.arTablAn[y].sZnPok;
     if Alu.arTablAn[1].sPeriod <> '-,,-' then sPeriodTmp := Alu.arTablAn[1].sPeriod;
     if Alu.arTablAn[y].sPeriod = '-,,-' then Alu.arTablAn[y].sPeriod:=  sPeriodTmp
      else sPeriodTmp := Alu.arTablAn[y].sPeriod;
     FB_EpiW.AllTabAnal[lu].sPeriod := Alu.arTablAn[y].sPeriod;
     if Alu.arTablAn[y].sNPok = '*' then begin
       FB_EpiW.iAnL:= y;       //Showmessage('ликвор iAnL= '+ IntToStr(FB_EpiW.iAnL));
       break;
     end;
     lu:= lu+1;
   end;
  end;  //Showmessage('ликвор break');
(* //Showmessage
  for y := 1 to 90 do begin
     With FB_EpiW.AllTabAnal[y] do begin
       if sNPok ='*' then break;
       Showmessage('sNPok= '+  ConsoleToUTF8(sNPok)+#13+
       'sZnPok= '+  ConsoleToUTF8(sZnPok)+#13+
       'sPeriod= '+  ConsoleToUTF8(sPeriod)
       );

     end;
   end;
*)
end;

function selIdVrac(const sText: string): string;
begin
  result := '';
  if sText = 'Нельсон' then begin  result := '0';  exit;  end;
  if sText = 'Воронов' then begin  result := '1';  exit;  end;
  if sText = 'Марисов' then begin  result := '4';  exit;  end;
  if sText = 'Вевербрант' then begin  result := '15';  exit;  end;
  if sText = 'Гуц' then begin  result := '16';  exit;  end;
  //if sText = '' then begin  result := '';  exit;  end;
end;

end.

