{ **********************************************************************
 Модуль выбора переменных из рекордов (un_structura)
 для использования в WinEpi с использованием Firebird.
 Автор В.И.Воронов. 2023г
 **********************************************************************
}

unit Un_strfb;

{$mode ObjFPC}{$H+}

interface

uses un_structura;

Type
{Диагноз}
TDIAGS = record
 sTipDz: string;
 sShifr: string;
 sDz: string;
end;
TDZArray = array[1..50] of TDIAGS;

  {запись для АНАЛИЗОВ в таблицах}
TANTBL = record
 sPokazatel: string;  {sNPok    }
 sZnach:     string;  {sZnPok    ZNACHEN     D_CHAR40}
 sDataAn:    string;  {sPeriod   PERIOD_DATA D_CHAR17}
end;
 TANTBLArray = array[1..40] of TANTBL; {Уменьшено с 60 до 40, т.к. больше 40 табл.ан. в БД у одного б-ного не было}
{$REGION 'закомм... в unit un_structura Структура  RKLanDann' }
(* в unit un_structura {Структура }
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
*)
{$ENDREGION}

(*
type {запись для АНАЛИЗОВ в таблицах}
TANTBL = record
 sPokazatel: string;  {sNPok    }
 sZnach:     string;  {sZnPok    ZNACHEN     D_CHAR40}
 sDataAn:    string;  {sPeriod   PERIOD_DATA D_CHAR17}
end;
*)
TOBSL = record {запись для ИНСТРУМЕНТАЛЬНЫЕ ИССЛЕДОВАНИЯ в таблицах}
    sVidOBSL : String; {imyaissl : string[18]; //наименование обсл/консультации}
    sDATAOBSL: String; {sData : string[10]; //дата}
    sREZ_OBSL: String; {arOpis: array[1..6] of string[60];}
  end;
TOBSLArray = array[1..6] of TOBSL;
{$REGION 'закомм... в unit un_structura Структура  RIsslDann' }
(*
//ANAL_KON.DBF и //ANAL_SVI.DBF
    {Структура }
     RIsslDann= Record
	  imyaissl : string[18]; //наименование обсл/консультации
	  sData : string[10]; //дата
          arOpis: array[1..6] of string[60];
    end;
 -----Ниже в unit U_TypeRecRegPts;--
type {запись для Обследований}
  TR_OBSL = record
    icodOBSLED1  :   Integer;
    IDOBSLED1    :   Integer;
   	sVidOBSL1    :   String[30];
    sDATAOBSL1   :   String[10];
    sREZ_OBSL1   :   String;
    icodOBSLED2  :   Integer;
    IDOBSLED2    :   Integer;
	  sVidOBSL2    :   String[30];
    sDATAOBSL2   :   String[10];
    sREZ_OBSL2   :   String;
    icodOBSLED3  :   Integer;
    IDOBSLED3    :   Integer;
	  sVidOBSL3    :   String[30];
    sDATAOBSL3   :   String[10];
    sREZ_OBSL3   :   String;
    icodOBSLED4  :   Integer;
    IDOBSLED4    :   Integer;
	  sVidOBSL4    :   String;
    sDATAOBSL4   :   String[10];
    sREZ_OBSL4   :   String;
    icodOBSLED5  :   Integer;
    IDOBSLED5    :   Integer;
	  sVidOBSL5    :   String[30];
    sDATAOBSL5   :   String[10];
    sREZ_OBSL5   :   String;
    icodOBSLED6  :   Integer;
    IDOBSLED6    :   Integer;
	  sVidOBSL6    :   String[30];
    sDATAOBSL6   :   String[10];
    sREZ_OBSL6   :   String;
  end;
*)
{$ENDREGION}

TKONS = record {запись для КОНСУЛЬТАЦИИ в таблицах}
    sVidOBSL : String; {imyaissl : string[18]; //наименование обсл/консультации}
    sDATAOBSL: String; {sData : string[10]; //дата}
    sREZ_OBSL: String; {arOpis: array[1..6] of string[60];}
  end;
TKONSArray = array[1..6] of TKONS;
TREZLekArray = array[1..6] of String[60];

TANALTabArray = array[1..90] of un_structura.RKLanDann;


TFB_EpiW = record
    sFio_      : String;
    sFam       : String;
    sImia      : String;
    IDImia     : String;
    sOth       : String;
    IDOth      : String;
    sGR        : String;
    sPol_      : String;
    sNumIB     : String;
    sNOPer     : String;
    sDataBoln  : String;
    sOtkuda    : String;
    IDOtkuda    : String; //'15' из дома
    sDataOrit  : String;
    sVBL       : String;
    IDVBL       : String; //'4'  на лечении
    sKuda      : String;
    IDKuda      : String; //'0'
    sDataVip   : String;
    sIsxod_    : String;
    IDIsxod_    : String; //'1'
    sLPU       : String;
    IDLPU       : String; //'0'
    sStrana    : String;
    IDStrana    : String; //'643' РОССИЯ
    sRegion    : String;
    IDRegion    : String; //'46' Московская обл
    sPunkt     : String;
    IDPunkt     : String; //'0'
    sAdrMJ     : String;
    sAdres     : String;
    sRabota_   : String;
    IDRabota   : String;
    sGrInvalid : String;
    sInvalidT  : String;
    sInvalidV  : String;
    sInvalidSrok: String;
    sInvalidAll: String;  {Все для вставки в Word}
    s1RostvID  : String;
    ID1RostvID  : String; //''
    s1RostvFio : String;
    s1RostvAdr : String;
    s2RostvID  : String;
    ID2RostvID  : String; //''
    s2RostvFio : String;
    s2RostvAdr : String;
    sRodstvAll : String;
    DZArray    : TDZArray;
    sDzOsnALL  : String;
    sDzOsn     : String;  {для вставки в Word}
    sDzFon     : String;  {для вставки в Word}
    sDzOsl     : String;  {для вставки в Word}
    sDzSop     : String;  {для вставки в Word}
    sAnGz      : String;
    sAnZb      : String;
    sPsSt      : String;
    sSomS      : String;
    sNevS      : String;
    sRezusKr   : String;
    sGruppaKr  : String;
    sAnalObsh  : String;
    sAnalKr    : String;
    sAnalMO    : String;
    sAnalLu    : String;
    AllTabAnal : TANALTabArray;
    iAnK,iAnM,iAnL: byte;    //{кол-во табличных ОАК, мочи и ликвора для вставки в Word}
    OBSLArray  : TOBSLArray;
    sInstrumI  : String;  {Все для вставки в Word}
    KONSArray  : TKONSArray;
    sKonsult   : String;
    sLekM      : String;
    sLekNM     : String;
    sLekX      : String;
    REZLekArray: TREZLekArray;
    sRezLek    : String;
    sIT_sutki  : String; //n3ITSu
    sIT_chas   : String; //n2ITCh
    sIT_min    : String; //n2ITMi
    sPS_chas   : String; //n3PsSu
    sPS_sutki  : String; //n2PsCh
    sPS_min    : String; //n2PsMi
    sRecomend  : String;
    sComment   : String;
    sVR1       : String;
    IDVR1       : String; //'15' Вевербрант
    sVR2       : String;
    IDVR2       : String; //'1' Воронов
    sVR3       : String;
    IDVR3       : String; //'16' Гуц    '4' Марисов
    sZavORit   : String;
    IDZavORit   : String; //'0' Нельсон
end;

var
  FB_EpiW: TFB_EpiW;
  sTMP: String;
  m, n: integer;

implementation

initialization
sTMP:= '';
With FB_EpiW do begin
  sFio_      := '';
 sFam       := '';
 sImia      := '';
 IDImia     := '';
 sOth       := '';
 sGR        := '';
 sPol_      := '';
 sNumIB     := '';
 sNOPer     := '';
 sDataBoln  := '';
 sOtkuda    := '';
 IDOtkuda    := '15'; //из дома
 sDataOrit  := '';
 sVBL       := '';
 IDVBL      := '4';  //на лечении
 sKuda      := '';
 IDKuda      := '0';
 sDataVip   := '';
 sIsxod_    := '';
 IDIsxod_    := '1';
 sLPU       := '';
 IDLPU       := '0';
 sNOPer     := '';
 sStrana    := '';
 IDStrana    := '643'; //РОССИЯ
 sRegion    := '';
 IDRegion    := '46';  //Московская обл
 sPunkt     := '';
 IDPunkt     := '0';
 sAdrMJ     := '';
 sAdres     := '';
 sRabota_   := '';
 IDRabota   := '0';
 sGrInvalid := '';
 sInvalidT  := '';
 sInvalidV  := '';
 sInvalidSrok:= '';
 sInvalidAll:= '';
 s1RostvID  := '';
 ID1RostvID  := '';
 s1RostvFio := '';
 s1RostvAdr := '';
 s2RostvID  := '';
 ID2RostvID  := '';
 s2RostvFio := '';
 s2RostvAdr := '';
 sRodstvAll := '';
 for m := 1 to 50 do begin
   DZArray[m].sTipDz:= '*';
   DZArray[m].sShifr:= '*';
   DZArray[m].sDz:= '*';
 end;
 sDzOsnALL  := '';
 sDzOsn     := '';
 sDzFon     := '';
 sDzOsl     := '';
 sDzSop     := '';
 sAnGz      := '';
 sAnZb      := '';
 sPsSt      := '';
 sSomS      := '';
 sNevS      := '';
 sRezusKr   := '';
 sGruppaKr  := '';
 sAnalObsh  := '';
 sAnalKr    := '';
 sAnalMO    := '';
 sAnalLu    := '';
 iAnK       :=0;
 iAnM       :=0;
 iAnL       :=0;
 for m := 1 to 90 do begin
   AllTabAnal[m].sNPok:='*';
   AllTabAnal[m].sZnPok:='*';
   AllTabAnal[m].sPeriod:='*';
 end;
  for m := 1 to 6 do begin
   OBSLArray[m].sVidOBSL:= '*';
   OBSLArray[m].sDATAOBSL:= '*';
   OBSLArray[m].sREZ_OBSL:= '*';
 end;
 sInstrumI  := '';
 for m := 1 to 6 do begin
   KONSArray[m].sVidOBSL:= '*';
   KONSArray[m].sDATAOBSL:= '*';
   KONSArray[m].sREZ_OBSL:= '*';
 end;
 sKonsult   := '';
 sLekM      := '';
 sLekNM     := '';
 sLekX      := '';
 for m := 1 to 6 do REZLekArray[m]:= '*';
 sRezLek    := '';
 sIT_sutki  := '';
 sIT_chas   := '';
 sIT_min    := '';
 sPS_chas   := '';
 sPS_sutki  := '';
 sPS_min    := '';
 sRecomend  := '';
 sComment   := '';
 sVR1       := '';
 IDVR1       := '15'; //Вевербрант
 sVR2       := '';
 IDVR2       := '1';  //Воронов
 sVR3       := '';
 IDVR3       := '16'; //Гуц    '4' Марисов
 sZavORit   := '';
 IDZavORit   := '0';  //Нельсон
end;

(*
for m := 1 to 40 do
  with AnTablFB[m] do begin
      for n := 0 to 3 do
       begin
         sPokazatel := '*';
         sZnach  := '*';
         sDataAn := '*';
       end;
  end;
*)
end.

