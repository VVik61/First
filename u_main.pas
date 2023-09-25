unit u_main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  ButtonPanel, ComCtrls, StdCtrls, StrUtils,
  LazUTF8, Dbf3, lrTDbfData, LCLType, dm_wbdf;

type

  { TfmMain }

  TfmMain = class(TForm)
    BtnSetPAD: TButton;
    Button3: TButton;
    ButtonPanel1: TButtonPanel;
    Label2: TLabel;
    CbxFio: TListBox;
    Panel1: TPanel;
    Panel2: TPanel;
    pb1: TProgressBar;
    rgOption: TRadioGroup;
    StatusBar1: TStatusBar;
    procedure BtnSetPADClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure CbxFioDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
   procedure SelFiofromDBFLin;     {Формирование списка для выбора б-х из DBF-Dos ф-лов}
   procedure SelFromDBFLToRecords; {выборка из DBF_Lin-файлов в рекорды (un_structura)}

  public
  (* namedbf: array[1..23] of string;  {Массив с названиями *.DBF-файлов}
     TmpDSQL: array[1..40] of string;  {Массив для составления SQL-запросов при переносе из DOS-DBF}
   //TmpSQL: array[1..40] of string;  {Массив SQL-запросов к БД FB}
     sLepiDir, sRabDir, sSQLDir //, sDatabaseName, sNAMEPROT
     : String;
  *)
   sTekReg: String[10]; {Текущий Reg-номер, типа 'P202300031'}
   iZp: longint; {Номер текущей записи}
   iZpLetal: longint; {Номер текущей записи умершего}
   sFioLetal: string; {ФИО и г.р. умершего}
   procedure PrintToWord; {Печать из БД в WORD'е}
   procedure ToSQLALL; {Формирование и запись в *.SQL-файлы для БД Firebird}
   procedure ToEWinDBF; {Перенос из DBF-DOS-файлов ЭПИКРИЗА в DBF-файлы Эпикриз-Win}
  end;

var
  fmMain: TfmMain;

implementation

uses DM_setup, un_structura, Un_strfb, PrntInW, DM_FB, FM_SetPAinDBFL;

{$R *.lfm}

{ TfmMain }

procedure TfmMain.Button3Click(Sender: TObject);
begin  //Showmessage(IntToStr(CbxFio.ItemIndex));
 if CbxFio.ItemIndex = -1 then begin
    Application.MessageBox('Не выбран пациент.', 'Внимание',MB_ICONINFORMATION);
    CbxFio.SetFocus;
    exit;
 end; //Showmessage(IntToStr(CbxFio.ItemIndex));
 iZp:= CbxFio.Itemindex+1; //Showmessage(IntToStr(iZp));
 SelFromDBFLToRecords;
 pb1.Position:=5;
 Application.ProcessMessages;
case rgOption.ItemIndex of
  0: PrintToWord;
  1: ToSQLALL;
  2: ToEWinDBF;
end;
pb1.Position:=100;
Application.ProcessMessages;
Application.MessageBox('Выполнено.', 'Внимание', 0); // MB_ICONINFORMATION);
pb1.Position:=0;
Application.ProcessMessages;
end;

procedure TfmMain.BtnSetPADClick(Sender: TObject);
begin
  try
   Hide;  //fmMain.Enabled:= false;
   with TfmSetDBFLPA.Create(Application) do  // TFM_SelLetDBFL.Create(Application) do // Создание экземпляра формы.
    try
      //TestValue := InitialValue;     // Установка начального значения.
      ShowModal;                     // Вывод формы на экран в модальном режиме.
    (*
      if ModalResult = mrOK then     // Если форма закрыта нажатием кнопки, подтверждающей изменения,
        iZpLetal  := fmMain.iZp //TestValue          // возвращаем изменённое значение.
      else                           // Если форма закрыта любым другим способом, т.е. изменения отменены,
        fmMain.iZp := 0; //InitialValue;      // возвращаем первоначальное значение.
    *)
    finally
      Free; // Уничтожение экземпляра формы и высвобождение ресурсов.
  end;
  finally
    fmMain.Visible:= true;     //.Enabled:= true;
  end;

end;

procedure TfmMain.CbxFioDblClick(Sender: TObject);
begin
  iZp:= CbxFio.Itemindex+1;
  SelFromDBFLToRecords;
end;

procedure TfmMain.FormCreate(Sender: TObject);
//var    i: integer;
begin
 SelFiofromDBFLin;
end;

procedure TfmMain.SelFiofromDBFLin; {Формирование списка для выбора б-х из DBF-Dos ф-лов}
var
   i: integer;
   fmt: string;
begin
  CbxFio.Items.Clear;   //fmt:= '%0:-10s  %1:-42s %2:-4s  с %3:-12s по  %4:-12s';   {s:=Format(fmt,['This is a string']);Writeln(fmt:12,'=> ',s);}
  fmt:= '%0:-10s  %1:-42s %2:-6s  %3:-12s  %4:-12s  %5:-12s';
 try
  With DM_S do begin
  if DbfOpen(1, UTF8ToConsole(sRabDir+ 'register.dbf')) <>0 then begin Showmessage('Ошибка')
  end
  else begin
    Panel2.Caption :=
      Format(fmt,
        ['  Регистр' , '| Фамилия, имя и отчество больного    |', 'Год рожд.',
         '|Поступил   ' , '|Результат   ', '|Дата выписки'
       ]);
    for i := 1 to Nzap[1] do begin
      if UTF8Trim(ConsoleToUTF8(DbfRead(1,i,5))) <> '*' then begin
       CbxFio.Items.Append(Format(fmt,
        [ConsoleToUTF8(DbfRead(1,i,1)), ConsoleToUTF8(DbfRead(1,i,5)),
         ConsoleToUTF8(DbfRead(1,i,6)),
         ConsoleToUTF8(DbfRead(1,i,8))+'.'+ConsoleToUTF8(DbfRead(1,i,9))+'.'+
         ConsoleToUTF8(DbfRead(1,i,10)),
         ConsoleToUTF8(DbfRead(1,i,12)),
         ConsoleToUTF8(DbfRead(1,i,13))+'.'+ConsoleToUTF8(DbfRead(1,i,14))+'.'+
         ConsoleToUTF8(DbfRead(1,i,15))
         ]));
      end;
    end;
  end;
  DbfClose(1);
 end;
 except on E: EInOutError do
    writeln('Ошибка открытия DBF-файла. Детали: ', E.Message);
 end;
end;

procedure TfmMain.SelFromDBFLToRecords; {выборка из DBF_Lin-файлов в рекорды (un_structura)}
var
  s: string;
begin
  inRegfDBF(s, iZp);
  inPEREMENAfDBF(s, iZp);
  inDIAGKOSNfDBF(s, iZp);
  inDIAGPOSNfDBF(s, iZp);
  inZAKLUCHEfDBF(s, iZp);
  inANAM_GZNfDBF(s, iZp);
  inANAM_ZBLfDBF(s, iZp);
  inPSIXISOSfDBF(s, iZp);
  inSOMATSOSfDBF(s, iZp);
  inNEVROSOSfDBF(s, iZp);
  inANAL_GIRfDBF(s, iZp);
  inANAL_KRVfDBF(s, iZp);
  inANAL_MCHfDBF(s, iZp);
  inANAL_LUMfDBF(s, iZp);
  inANAL_SVIfDBF(s, iZp);
  inANAL_KONfDBF(s, iZp);
  inLEKA_MEDfDBF(s, iZp);
  inLEKA_NMDfDBF(s, iZp);
  inLEKA_XIRfDBF(s, iZp);
  inLEKA_REZfDBF(s, iZp);
  inRECOMENDfDBF(s, iZp);
  inCOMMENTfDBF( s, iZp);
  inSPRfDBF (s, iZp);
  inAnalizTbl(OAK, OAM, ANLikv);  //Akr, Amo, Alu: rANALIZ);
end;

procedure TfmMain.ToSQLALL; {Формирование и запись в *.SQL-файлы для БД Firebird}
var
 C_FNAME, C_FNAME_A, sToAns {в ANSI}
 , idPats, IDPol
 ,  sTMPAo {общ_анализы}
 , sTMPID, sTMPTipAn {табл_анализы ID показателя и тип-ОАК, БиохАк, ОАМ, Ан_ликвора}
 , s1, s2
 : String;

 L: TStringList;
 tfOut: TextFile;
 i, d, m: integer;
begin   //Showmessage(sRabDir+ UTF8ToConsole(C_FNAME));  //A0ssignFile(tfOut, sRabDir+ UTF8ToConsole(C_FNAME));
{$REGION  'Подготовительные действия. Получение текущего рег, текущей записи. Формирование SQL-ф-лов для записи в них скриптов' }
 iZp := -1;
 iZp:= CbxFio.Itemindex+1;
 sTekReg := Copy(CbxFio.Items[CbxFio.Itemindex],1, 10);
 if iZp = -1 then exit;  //Showmessage('|'+Copy(CbxFio.Items[CbxFio.Itemindex],1, 10)+'|');

 C_FNAME := '';    C_FNAME_A := '';
 L := TStringList.Create;
  C_FNAME := DM_S.sSQLDir+sTekReg+'.sql';
 C_FNAME_A := DM_S.sSQLDir+sTekReg+'_a'+'.sql';
 L.SaveToFile(C_FNAME);
 L.Free;
{$ENDREGION}
 idPats:= ''; IDPol:= '';
 AssignFile(tfOut, UTF8ToConsole(C_FNAME));
 try
  append(tfOut);   //writeln(tfOut, sPats);   //writeln(tfOut, sRegF);

 With FB_EpiW do begin   //Showmessage('sAdrMJ= '+sAdrMJ+ '==' +);
{$REGION 'Запись в SQL Пациент и Регистер'}     //Showmessage('sImia= '+ConsoleToUTF8(sImia)+#13+ 'sOth= '+ConsoleToUTF8(sOth));
{TODO: При отсутствии в справочнике ИМЕНИ/Отчества - внести новые значения!!!}
    IDImia := D_FB.SelID('select codimia from sl_imia where imia = ', 'codimia', ConsoleToUTF8(sImia));
    IDOth := D_FB.SelID('select codoth from SL_OTH where oth = ', 'codoth', ConsoleToUTF8(sOth));
    idPats:= D_FB.SelIDPats(sFam, sGR, IDImia, IDOth);    //Showmessage('ID пац= '+ idPats);
    if ConsoleToUTF8(sPol_) = 'М' then  IDPol:= '1' else IDPol:= '2';
    if idPats = '0' then begin
     idPats := '!!!';
     writeln(tfOut, DM_S.TmpDSQL[1]+idPats+', '''+ConsoleToUTF8(sFam)+''', '+IDImia+', '+IDOth +', NULL, '''+sGR+ ''', '+IDPol+', 0, NULL);   --'+ConsoleToUTF8(sFio_));
 //1=INSERT INTO S_PATS (CODPATS, FAM, IDIM, IDOTH, DATA_RGD, GOD_RGD, POL, STAT, PATS_PRIM) VALUES (
//   'Гурей', 134, 75,  NULL, '1975', 1, 0, NULL);      --Гурей Сергей Геннадьевич
     writeln(tfOut,#13+'COMMIT WORK;');
    end;

     IDOtkuda := D_FB.SelID('select codotkuda from SL_OTKUDA where otkuda = ', 'codotkuda', ConsoleToUTF8(sOtkuda));
     IDKuda   := D_FB.SelID('select codkuda from SL_KUDA where kuda = ', 'codkuda', ConsoleToUTF8(sKuda));
     IDVBL    := D_FB.SelID('select codvbl from sl_vbl where vbl = ', 'codvbl', ConsoleToUTF8(sVBL));
     if IDVBL = '0' then IDLPU:= '0' else IDLPU:= '16';
     IDIsxod_ := D_FB.SelID('select codisxod from SL_ISXOD where isxod = ', 'codisxod', ConsoleToUTF8(sIsxod_));  {НЕ ИСПОЛЬЗУЮТСЯ!!!  sDlitO:= UTF8Trim(ConsoleToUTF8(Trim(DbfRead(1, iZp, 19))));//    sDlitB:= UTF8Trim(ConsoleToUTF8(Trim(DbfRead(1, iZp, 23))))}

//2=INSERT INTO REGISTER (CODREG, IDPATS, DATA_P, DATA_PB, DATA_V, IDISXOD, IDOTKUDA, IDKUDA, IDLPU, IDVIBL, IDZAVORIT) VALUES ('
                                         // ', 5127, date '23.06.2023', date '23.06.2023', NULL, 1, 15, 0, 0, 4, 0);     --Гурей Сергей Геннадьевич
     writeln(tfOut,#13+ DM_S.TmpDSQL[2]+sTekReg+''', '+ idPats+', date '''+sDataOrit+ ''', date ''' +sDataBoln+''', date ''' +sDataVip+''', '+IDIsxod_+', '+IDOtkuda+', '+IDKuda+', '+IDLPU+', '+IDVBL+', '+IDZavORit+');   --'+ConsoleToUTF8(sFio_));
     writeln(tfOut,#13+'COMMIT WORK;');

{$ENDREGION}

{$REGION 'Запись в SQL АДРЕС, РАБОТА, РОДСТВЕННИКИ'}
 writeln(tfOut, DM_S.TmpDSQL[3]+sTekReg+''', '+ IDStrana+', '''+IDRegion +''', 0, '+IDPunkt+', '''+ConsoleToUTF8(sAdrMJ)+''');   --'+ConsoleToUTF8(sAdres)+'');//  'P202300062', 643, '46', 0, 2, 'рп. Калининец, в/ч 11001');

 if Length(Trim(sRabota_)) >0  then begin
   if ConsoleToUTF8(sRabota_) = 'не работает' then    //Showmessage('ConsoleToUTF8(sRabota_) = не работает');
    writeln(tfOut, DM_S.TmpDSQL[4]+sTekReg+''', 1, NULL, NULL);   --'+ConsoleToUTF8(sRabota_));
   if ConsoleToUTF8(sRabota_) = 'пенсионер' then
    writeln(tfOut, DM_S.TmpDSQL[4]+sTekReg+''', 2, NULL, NULL);   --'+ConsoleToUTF8(sRabota_));
   if ConsoleToUTF8(sRabota_) = 'военный пенсионер' then
    writeln(tfOut, DM_S.TmpDSQL[4]+sTekReg+''', 3, NULL, NULL);   --'+ConsoleToUTF8(sRabota_));
   if ConsoleToUTF8(sRabota_) = 'ИЧП' then
    writeln(tfOut, DM_S.TmpDSQL[4]+sTekReg+''', 4, NULL, NULL);   --'+ConsoleToUTF8(sRabota_));
  if (ConsoleToUTF8(sRabota_) <> 'не работает') and
     (ConsoleToUTF8(sRabota_) <> 'пенсионер') and
     (ConsoleToUTF8(sRabota_) <> 'военный пенсионер') then {ИЧП встречается редко и написание часто разнится!}
   writeln(tfOut, DM_S.TmpDSQL[4]+sTekReg+''', 0,'''+ConsoleToUTF8(sRabota_)+''', NULL);   --НАДО провести разбор!!!  '+ConsoleToUTF8(sRabota_)); //INSERT INTO S_RABOTA (CODRABOTA, R_RABOTA, STAT_RAB, MESTO_R, IDRAB_DOLGN) VALUES (gen_id(GEN_RABOTA, 1), 'P202300049//', 1, NULL, NULL);
 end;
 //40=INSERT INTO S_INVALID (CODINVALID, R_INVALID, GR_INVAL, INVAL_T, INVAL_V, INVAL_SROK)  VALUES (gen_id(GEN_INVALID, 1), '
 //P202200052', 2, 0, 0, 'бессрочно');  --Савенков Илья Леонидович
 if Length(Trim(sInvalidV)) = 0  then sInvalidV:= '0';
 if Length(Trim(sGrInvalid)) >0  then
   writeln(tfOut, DM_S.TmpDSQL[40]+sTekReg+''', '+Trim(sGrInvalid)+', '+sInvalidT+', '+sInvalidV+', '''+ConsoleToUTF8(sInvalidSrok)+''');   --'+ ConsoleToUTF8(sFio_));

 if (Length(Trim(s1RostvFio)) > 0 ) and (s1RostvFio <>'*') then
  writeln(tfOut, DM_S.TmpDSQL[5]+sTekReg+''', '+ID1RostvID+', '''+ConsoleToUTF8(s1RostvFio)+''', '''+ConsoleToUTF8(s1RostvAdr)+''');');//INSERT INTO S_RODSTV_ALL (CODRODSTV_ALL, R_RODSTV_ALL, IDRODSTV_ALL, RODST_FAM, RODST_ADR) VALUES (gen_id(GEN_RODSTV_ALL, 1), 'P202300049//', 3, 'Заплико Ирина Павловна', 'Воскресенский р-он, тел. 8916-617-54-40');
 if (Length(Trim(s2RostvFio)) > 0 ) and (s2RostvFio <>'*') then
   writeln(tfOut, DM_S.TmpDSQL[5]+sTekReg+''', '+ID2RostvID+', '''+ConsoleToUTF8(s2RostvFio)+''', '''+ConsoleToUTF8(s2RostvAdr)+''');');
{$ENDREGION}

{$REGION 'Запись в SQL ДИАГНОЗОВ'}
for d := 1 to 50 do
  With DZArray[d] do
   if (Length(Trim(sDz)) > 0 ) and (sDz <>'*') then
     writeln(tfOut, DM_S.TmpDSQL[6]+sTekReg+''', '+ sTipDz+', '''+sShifr +''', '''+ConsoleToUTF8(sDz)+''');')
   else break;
{$ENDREGION}

{$REGION 'Запись в SQL Анамнезов и статусов'}
 if Length(Trim(sAnGz)) >0  then
  writeln(tfOut, DM_S.TmpDSQL[7]+sTekReg+''', '''+sAnGz+''');');

  writeln(tfOut, DM_S.TmpDSQL[8]+sTekReg+''', '''+sAnZb+''');');
  writeln(tfOut, DM_S.TmpDSQL[9]+sTekReg+''',  '''+sPsSt+''');');
  writeln(tfOut, DM_S.TmpDSQL[10]+sTekReg+''',  '''+sSomS+''');');
  writeln(tfOut, DM_S.TmpDSQL[11]+sTekReg+''', '''+sNevS+''');');
{$ENDREGION}

{$REGION 'Запись в SQL Строковых анализов'}
{TODO:  Группа и резус крови пока не отработаны!!! sGruppaKr }

sTMPAo:='';
 if Length(Trim(sAnalObsh)) =0  then sAnalObsh := 'NULL';
 if Length(Trim(sAnalKr)) =0    then sAnalKr := 'NULL';
 if Length(Trim(sAnalMO)) =0    then sAnalMO := 'NULL';
 if Length(Trim(sAnalLu)) =0    then sAnalLu := 'NULL';
 if (sAnalObsh = 'NULL') and (sAnalKr = 'NULL') and (sAnalMO = 'NULL') and (sAnalLu = 'NULL') = false then begin
    if sAnalObsh = 'NULL' then sTMPAo:= DM_S.TmpDSQL[12]+sTekReg+''', '+sAnalObsh
       else sTMPAo:= DM_S.TmpDSQL[12]+sTekReg+''', '''+sAnalObsh+'''';   //Showmessage('1 sTMPAo= '+sTMPAo);
    if sAnalKr = 'NULL' then sTMPAo:=  sTMPAo +', '+sAnalKr
          else sTMPAo:= sTMPAo+', '''+sAnalKr+'''';    //Showmessage('2 sTMPAo= '+sTMPAo);
    if sAnalMO = 'NULL' then sTMPAo:=  sTMPAo +', '+sAnalMO
          else sTMPAo:= sTMPAo+', '''+sAnalMO+'''';     //Showmessage('3 sTMPAo= '+sTMPAo);
    if sAnalLu = 'NULL' then sTMPAo:=  sTMPAo +', '+sAnalLu+');'
          else sTMPAo:= sTMPAo+', '''+sAnalLu+''');';    //Showmessage('4 sTMPAo= '+sTMPAo);
    writeln(tfOut, sTMPAo);
  end;
{$ENDREGION}

{$REGION 'Запись в SQL АНАЛИЗЫ табличные'}
//13=INSERT INTO S_ANALIZ (CODANALIZ, R_ANALIZ, ANALIZ_STAT, IDAN_POKAZ, ZNACHEN, PERIOD_DATA) VALUES (gen_id(gen_Anal_All,1), 'P202300017',
//0,  тип получать из справочника БД FB  //3, '94 - 105', 'За весь период');
 if Trim(AllTabAnal[1].sNPok) <> '*' then begin
   for m := 1 to 90 do begin
  sTMPID:= ''; sTMPTipAn:= '';
  if Trim(AllTabAnal[m].sNPok) = '*' then break;  //Showmessage('AllTabAnal[m]= |'+ConsoleToUTF8(AllTabAnal[m].sNPok)+'|');
  sTMPID:= D_FB.SelID('select id_an_pok from SL_AN_POK_DOS where an_pokaz_dos = ', 'id_an_pok', ConsoleToUTF8(AllTabAnal[m].sNPok));  //Showmessage('sTMPID= |'+ConsoleToUTF8(sTMPID)+'|');
  sTMPTipAn:= D_FB.SelID('select ID_STAT from SL_AN_POK_DOS where an_pokaz_dos = ', 'ID_STAT', ConsoleToUTF8(AllTabAnal[m].sNPok));  //Showmessage('sTMPTipAn= |'+ConsoleToUTF8(sTMPTipAn)+'|');
  writeln(tfOut, DM_S.TmpDSQL[13]+sTekReg+''', '+sTMPTipAn+', '+ sTMPID +', '''+ConsoleToUTF8(AllTabAnal[m].sZnPok)+''', '''+ConsoleToUTF8(AllTabAnal[m].sPeriod)+''');    --'+ConsoleToUTF8(AllTabAnal[m].sNPok)+'  '+ConsoleToUTF8(AllTabAnal[m].sZnPok)+'  '+ ConsoleToUTF8(AllTabAnal[m].sPeriod));
  end; {for m := 1 to 90 do}
 end; {Trim(AllTabAnal[1].sNPok) <> '*'}
{$ENDREGION}

{$REGION 'Запись в SQL ОБСЛЕДОВАНИЯ и КОСУЛЬТАЦИИ'}
//14=INSERT INTO S_OBSLED_ALL (CODOBSLED_ALL, R_OBSLED_ALL, IDOBSLED_ALL, DATAOBSL_KNS, REZ_OBSL_KNS) VALUES (gen_id (gen_OBSLED_All, 1), '
//P202300049', 46, date '24.05.2023', 'КТ-признаков ... ');
 if OBSLArray[1].sVidOBSL <> '*' then begin
  for m := 1 to 6 do begin
     With OBSLArray[m] do begin
      if sVidOBSL = '*' then break;
      sTMPID:= D_FB.SelID('select id_isslkons from SL_ISSLKONS_DOS where isslkons_dos = ', 'id_isslkons', ConsoleToUTF8(Trim(sVidOBSL)));      //Showmessage('sTMPID= |'+ConsoleToUTF8(sTMPID)+'|');
      writeln(tfOut, DM_S.TmpDSQL[14]+sTekReg+''', '+sTMPID+', date '''+ sDATAOBSL +''', '''+sREZ_OBSL+''');    --'+ConsoleToUTF8(sVidOBSL)+'  '+ConsoleToUTF8(sDATAOBSL)+'  '+ sREZ_OBSL);
     end;
 end;
end;

  if KONSArray[1].sVidOBSL <> '*' then begin
   for m := 1 to 6 do begin
      With KONSArray[m] do begin
       if sVidOBSL = '*' then break;
       sTMPID:= D_FB.SelID('select id_isslkons from SL_ISSLKONS_DOS where isslkons_dos = ', 'id_isslkons', ConsoleToUTF8(Trim(sVidOBSL)));      //Showmessage('sTMPID= |'+ConsoleToUTF8(sTMPID)+'|');
       writeln(tfOut, DM_S.TmpDSQL[14]+sTekReg+''', '+sTMPID+', date '''+ sDATAOBSL +''', '''+sREZ_OBSL+''');    --'+ConsoleToUTF8(sVidOBSL)+'  '+ConsoleToUTF8(sDATAOBSL)+'  '+ sREZ_OBSL);
      end;
  end;
 end;
{$ENDREGION}

{$REGION 'Запись в SQL ЛЕЧЕНИЕ (частичный разбор)'}
(*function IsWordPresent(const W: string;   const S: string;   const WordDelims: TSysCharSet ):Boolean;АргументыW -Слово для поиска   S-Строка для поиска WordDelims-Символы, используемые в качестве разделителей слов*) //if IsWordPresent('мочевого', sLekNM, [' ']) then Showmessage('ЕСТЬ == Катетеризация мочевого пузыря');
(*function AnsiContainsStr(  const AText: string;   const ASubText: string):Boolean;
Аргументы AText- Строка для поиска в ASubText- Подстрока, которую нужно искать*)  //if AnsiContainsStr(sLekNM, 'Катетеризация мочевого пузыря') then begin  //Showmessage('ЕСТЬ == Катетеризация мочевого пузыря');end;
 With D_FB do begin
 IBDS_RAB.SelectSQL.Text:= UTF8ToWinCP('select rubrlec from sl_rubrlec;');
 try
 IBTrAct.Active:= true;
 IBDS_RAB.Open;
 IBDS_RAB.First;
 While Not(IBDS_RAB.EOF) Do   Begin
   s1:= '';   s2 := '';
    if AnsiContainsStr(sLekM, IBDS_RAB.FieldByName('rubrlec').AsString) or
       AnsiContainsStr(sLekNM, IBDS_RAB.FieldByName('rubrlec').AsString) {В хир.лек нет простых(с точкой на конце рубрик)}
       then begin
      s1:= AnsiReverseString(IBDS_RAB.FieldByName('rubrlec').AsString);
      if s1[1] = '.' then begin
        sTMPID:= D_FB.SelID('select codrubrlec from sl_rubrlec where rubrlec = ', 'codrubrlec', IBDS_RAB.FieldByName('rubrlec').AsString);
//15=INSERT INTO S_LECEN (CODLECEN, R_LECEN, IDLECEN) VALUES (gen_id(gen_LECENIE, 1), '
        writeln(tfOut, DM_S.TmpDSQL[15]+sTekReg+''', '+sTMPID+ ');  --'+IBDS_RAB.FieldByName('rubrlec').AsString);
        {удалить из sLekM или sLekNM уже вставленное в SQL-скрипт} //function StringReplace(const S: WideString; const OldPattern: WideString; const NewPattern: WideString; Flags: TReplaceFlags):WideString;
        sLekM := StringReplace(sLekM, IBDS_RAB.FieldByName('rubrlec').AsString, '', []);
        sLekNM := StringReplace(sLekNM, IBDS_RAB.FieldByName('rubrlec').AsString, '', []);        //Showmessage('sTMPID= |'+ConsoleToUTF8(sTMPID)+'|');        //Showmessage(IBDS_RAB.FieldByName('rubrlec').AsString);
      end;
    end;
   s2 := Copy(IBDS_RAB.FieldByName('rubrlec').AsString,1, Length(IBDS_RAB.FieldByName('rubrlec').AsString)-1);
   if AnsiContainsStr(sLekM, s2) or AnsiContainsStr(sLekNM, s2) or AnsiContainsStr(sLekX, s2) then begin //Showmessage(s2);
    s1:= AnsiReverseString(IBDS_RAB.FieldByName('rubrlec').AsString);
      if s1[1] = ':' then begin
        sTMPID:= D_FB.SelID('select codrubrlec from sl_rubrlec where rubrlec = ', 'codrubrlec', IBDS_RAB.FieldByName('rubrlec').AsString);
        case StrToInt(sTMPID) of
         {$I 'sel_lecSQL.inc'} //в файле - действия по выборке -лечение
        end;
      end;
   end;
     IBDS_RAB.Next;
   End;
except
end;
IBDS_RAB.Close;
IBTrAct.Active:= false;
end;
{$ENDREGION}

{$REGION 'Запись в SQL РЕЗУЛЬТАТ ЛЕЧЕНИЯ'}
//31=INSERT INTO S_REZULTAT (CODREZULTAT, R_REZULTAT, IDREZULTAT) VALUES (gen_id(GEN_REZ_LEC_ALL, 1), '    // P202300050', 13);
 if Trim(REZLekArray[1]) <> '*' then begin
   for m := 1 to 6 do begin
    if Trim(REZLekArray[m]) = '*' then break;
    sTMPID:= D_FB.SelID('select codrez_lec from SL_REZ_LEC where rez_lec = ', 'codrez_lec', ConsoleToUTF8(Trim(REZLekArray[m])));
    writeln(tfOut, DM_S.TmpDSQL[31]+sTekReg+''', '+sTMPID+');    --'+ConsoleToUTF8(REZLekArray[m]));
    {удалить из sRecomend уже вставленное в SQL-скрипт}
    sRezLek := StringReplace(sRezLek, ConsoleToUTF8(Trim(REZLekArray[m])), '', []);
   end;

 end;
//30 INSERT INTO S_DLIT_LEC_PSIX (CODDLIT_LEC_PSIX, R_DLIT_LEC_PSIX, LEC_SUTKI, LEC_CHAS, LEC_MINUT, PSIX_SUTKI, PSIX_CHAS, PSIX_MINUT) VALUES (gen_id(GEN_REZ_DLIT_ITPS, 1), '
 //P202300054', '6', '5', '50', '4', '15', '50');
writeln(tfOut, DM_S.TmpDSQL[30]+sTekReg+''', '''+sIT_sutki+''', '''+sIT_chas+''', '''+sIT_min+''', '''+sPS_chas+''', '''+sPS_sutki+''', '''+sPS_min+''');');
{$ENDREGION}

{$REGION 'Запись в РЕКОМЕНДАЦИИ (частичный разбор)'}
 With D_FB do begin
 IBDS_RAB.SelectSQL.Text:= UTF8ToWinCP('select RECOMS from SL_RECOMS;');
 try
 IBTrAct.Active:= true;
 IBDS_RAB.Open;
 IBDS_RAB.First;
 While Not(IBDS_RAB.EOF) Do   Begin
    if AnsiContainsStr(sRecomend, IBDS_RAB.FieldByName('RECOMS').AsString) then begin
        sTMPID:= D_FB.SelID('select CODRECOMS from SL_RECOMS where RECOMS = ', 'CODRECOMS',
        IBDS_RAB.FieldByName('RECOMS').AsString);
//32=INSERT INTO S_RECOMEND (CODRECOMEND, R_RECOMEND, IDRECOMEND, RECOMEND_PRIM) VALUES (gen_id(GEN_RECOMS, 1), '
//P202300067', 3, NULL);
        writeln(tfOut, DM_S.TmpDSQL[32]+sTekReg+''', '+sTMPID+ ', NULL);  --'+IBDS_RAB.FieldByName('RECOMS').AsString);
        {удалить из sRecomend уже вставленное в SQL-скрипт}
        sRecomend := Trim(StringReplace(sRecomend, IBDS_RAB.FieldByName('RECOMS').AsString, '', []));
   if AnsiContainsStr(sRecomend, IBDS_RAB.FieldByName('RECOMS').AsString) then begin
        sTMPID:= D_FB.SelID('select CODRECOMS from SL_RECOMS where RECOMS like ', 'CODRECOMS',
        '%'+Copy(IBDS_RAB.FieldByName('RECOMS').AsString, 2, length(IBDS_RAB.FieldByName('RECOMS').AsString)-1)+'%');
        writeln(tfOut, DM_S.TmpDSQL[32]+sTekReg+''', '+sTMPID+ ', NULL);  --'+IBDS_RAB.FieldByName('RECOMS').AsString);
    end;  //Showmessage('sTMPID= |'+sRecomend+'|');        //Showmessage(IBDS_RAB.FieldByName('rubrlec').AsString);
    end;
     IBDS_RAB.Next;
   End;
 except
 end;
 IBDS_RAB.Close;
 IBTrAct.Active:= false;
 end;
{$ENDREGION}

{$REGION 'Запись в ПРИМЕЧАНИЯ (частичный разбор)'}
 With D_FB do begin
 IBDS_RAB.SelectSQL.Text:= UTF8ToWinCP('select COMMENTY from SL_COMMENTY;');
 try
 IBTrAct.Active:= true;
 IBDS_RAB.Open;
 IBDS_RAB.First;
 While Not(IBDS_RAB.EOF) Do   Begin
   s1:= '';   s2 := '';
    if AnsiContainsStr(sComment, IBDS_RAB.FieldByName('COMMENTY').AsString) then begin
        sTMPID:= D_FB.SelID('select CODCOMMENTY from SL_COMMENTY where COMMENTY = ', 'CODCOMMENTY',
        IBDS_RAB.FieldByName('COMMENTY').AsString);
        writeln(tfOut, DM_S.TmpDSQL[33]+sTekReg+''', '+sTMPID+ ', NULL);  --'+IBDS_RAB.FieldByName('COMMENTY').AsString);
        {удалить из sComment уже вставленное в SQL-скрипт}
        sComment := Trim(StringReplace(sComment, IBDS_RAB.FieldByName('COMMENTY').AsString, '', []));
   if AnsiContainsStr(sComment, IBDS_RAB.FieldByName('COMMENTY').AsString) then begin
        sTMPID:= D_FB.SelID('select CODCOMMENTY from SL_COMMENTY where RECOMS like ', 'CODCOMMENTY',
        '%'+Copy(IBDS_RAB.FieldByName('COMMENTY').AsString, 2, length(IBDS_RAB.FieldByName('COMMENTY').AsString)-1)+'%');
        writeln(tfOut, DM_S.TmpDSQL[33]+sTekReg+''', '+sTMPID+ ', NULL);  --'+IBDS_RAB.FieldByName('COMMENTY').AsString);
    end;   //Showmessage('sTMPID= |'+sComment+'|');
    end;
     IBDS_RAB.Next;
   End;
 except
 end;
 IBDS_RAB.Close;
 IBTrAct.Active:= false;
 end;
{$ENDREGION}

{$REGION 'Запись в SQL ВРАЧИ'}
//34=INSERT INTO S_VRACHI (CODVRACHI, R_VRACHI, IDVRACHI) VALUES (gen_id(gen_VRACHI_All, 1), '
writeln(tfOut, DM_S.TmpDSQL[34]+sTekReg+''', '+IDVR1+');');
writeln(tfOut, DM_S.TmpDSQL[34]+sTekReg+''', '+IDVR2+');');
writeln(tfOut, DM_S.TmpDSQL[34]+sTekReg+''', '+IDVR3+');');
//writeln(tfOut, DM_S.TmpDSQL[34]+sTekReg+''', '+IDZavORit+');'); //ЗавОРИТ -> REGISTER
{$ENDREGION}

 writeln(tfOut,#13+'COMMIT WORK;');

{$REGION 'Запись в SQL  данных, которые надо уточнять '}
 writeln(tfOut, '/*');
 writeln(tfOut, 'Медикам. лечение ='+ sLekM);
 writeln(tfOut, 'НЕМедикам. лечение ='+ sLekNM);
 writeln(tfOut, 'Хир. лечение ='+ sLekX);
 writeln(tfOut, 'Результат лечения = '+ sRezLek);
 writeln(tfOut, 'ИТ= '+ sIT_sutki+' '+sIT_chas+' '+sIT_min+' Дл. психоза= '+sPS_chas+' '+sPS_sutki+' '+sPS_min);
 writeln(tfOut, 'Рекомендации = '+ sRecomend);
 writeln(tfOut, 'Прим. = '+ sComment);
 writeln(tfOut, sVR1+' '+sVR2+' '+sVR3+' '+sZavORit);
 writeln(tfOut,'*/');
{$ENDREGION}

 end; {With FB_EpiW do}

 CloseFile(tfOut);
 //Showmessage('В SQL-файл записаны скрипты вставки данных для FB БД.');
except on E: EInOutError do
   writeln('Ошибка обработки файла. Детали: ', E.Message);
end;
(*//Showmessage
 Showmessage('|'+sADresFull+'|'+#13#13+
 '|'+sStrana+'|'+#13+
'|'+sRegion+'|'+#13+
'|'+sPnktMO+'|'+#13+
'|'+sMestoj+'|'+#13+
'|'+sRabota+'|'+#13+
'|'+sInvalGr+'|'+#13+
'|'+sInvalT1+'|'+#13+
'|'+sInvalT2+'|'+#13+
'|'+sRodst1+'|'+#13+
'|'+sRodst1FIO+'|'+#13+
'|'+sRodst1Adr+'|'+#13+
'|'+sRodst2+'|'+#13+
'|'+sRodst2FIO+'|'+#13+
'|'+sRodst3Adr+'|');
*)

{$REGION 'Запись данных SQL-файла в кодировке ANSI'}
 L := TStringList.Create;
 //end;
 L.LoadFromFile(C_FNAME); //Showmessage(C_FNAME);
 for i := 0 to Pred(L.Count) do
 begin
   sToAns := Utf8ToWinCP(L.Strings[i]);
   L.Strings[i] := sToAns;
 end;  //Showmessage('после '+ C_FNAME);
 L.SaveToFile(C_FNAME_A);
 L.Free;
{$ENDREGION}
end;

procedure TfmMain.ToEWinDBF; {Перенос из DBF-DOS-файлов ЭПИКРИЗА в DBF-файлы Эпикриз-Win}
var
  s: string;  //y: integer;
begin
  ClearFB_EpiW;
  iZp:= CbxFio.Itemindex+1 ;
  inRegfDBF(s, iZp);
  dm_wdbf.Cin_Register(REGIS.r);
  inPEREMENAfDBF(s, iZp);
  dm_wdbf.Cin_PEREMENA(PEREMENA.r);
  inDIAGKOSNfDBF(s, iZp);
  dm_wdbf.Cin_DIAGKOSN(DIAGKOSN.r);
  inDIAGPOSNfDBF(s, iZp);
  dm_wdbf.Cin_DIAGPOSN(DIAGPOSN.r);
  inZAKLUCHEfDBF(s, iZp);
  dm_wdbf.Cin_ZAKLUCHE(ZAKLUCHE.r);
  inANAM_GZNfDBF(s, iZp);
  dm_wdbf.Cin_ANAM_GZN(ANAM_GZN.r);
  inANAM_ZBLfDBF(s, iZp);
  dm_wdbf.Cin_ANAM_ZBL(ANAM_ZBL.r);
  inPSIXISOSfDBF(s, iZp);
  dm_wdbf.Cin_PSIXISOSfDBF(PSIXISOS.r);
  inSOMATSOSfDBF(s, iZp);
  dm_wdbf.Cin_SOMATSOSfDBF(SOMATSOS.r);
  inNEVROSOSfDBF(s, iZp);
  dm_wdbf.Cin_NEVROSOSfDBF(NEVROSOS.r);
  inANAL_GIRfDBF(s, iZp);
  dm_wdbf.Cin_ANAL_GIRfDBF(ANAL_GIR.r);

  inANAL_KRVfDBF(s, iZp);
  dm_wdbf.Cin_ANAL_KRVfDBF(OAK.r);
  inANAL_MCHfDBF(s, iZp);
  dm_wdbf.Cin_ANAL_MCHfDBF(OAM.r);
  inANAL_LUMfDBF(s, iZp);
  dm_wdbf.Cin_ANAL_LUMfDBF(ANLikv.r);
  inANAL_SVIfDBF(s, iZp);
  dm_wdbf.Cin_ANAL_SVIfDBF(ANAL_SVI.r);
  inANAL_KONfDBF(s, iZp);
  dm_wdbf.Cin_ANAL_KONfDBF(ANAL_KON.r);
  inLEKA_MEDfDBF(s, iZp);
  dm_wdbf.Cin_LEKA_MEDfDBF(LEKA_MED.r);
  inLEKA_NMDfDBF(s, iZp);
  dm_wdbf.Cin_LEKA_NMDfDBF(LEKA_NMD.r);
  inLEKA_XIRfDBF(s, iZp);
  dm_wdbf.Cin_LEKA_XIRfDBF(LEKA_XIR.r);
  inLEKA_REZfDBF(s, iZp);
  dm_wdbf.Cin_LEKA_REZfDBF(LEKA_REZ.r);
  inRECOMENDfDBF(s, iZp);
  dm_wdbf.Cin_RECOMENDfDBF(RECOMEND.r);
  inCOMMENTfDBF(s, iZp);
  dm_wdbf.Cin_COMMENTfDBF(COMMENT.r);
 //Showmessage('!==   ' +ANAM_GZN.r+' =  Ok!');
end;

procedure TfmMain.PrintToWord; {Печать из БД в WORD'е}
begin
  //CreateWord(true);
  FormatInWord; //(pb1.Position);
end;

end.

(*//Showmessage('|'+sSQLPats+'|');  Showmessage('|'+sSQLRegister+'|');
sTMPReg := DbfRead(1, iZp, 1);
if sTMPReg <> sTekReg then begin
   Showmessage('Ошибка текущего Рег_номера!');
   exit;
end;

 Showmessage('|'+sTMP+'|');
 Showmessage('|'+sFio+'|');
 Showmessage('|'+sFam+'|');
 Showmessage('|'+sImia+'|');
 Showmessage('|'+sOth+'|');
 Showmessage('|'+sGR+'|');
 Showmessage('|'+sDataOrit+'|');
 Showmessage('|'+sDataVip+'|');
 Showmessage('|'+sDataBoln+'|');
 Showmessage('|'+sOtkuda+'|');
 Showmessage('|'+sVBL+'|');
 Showmessage('|'+sKuda+'|');
 Showmessage('|'+sIsxod+'|');
 Showmessage('|'+sDlitO+'|');
 Showmessage('|'+sDlitB+'|');

  Showmessage(ConsoleToUTF8( //sLUCH+ ' '+ sDOC+ ' '+
               sD_NOMER+ ' '+
             '|'+sNumIB+'|'+#13+
             '|'+sFIO_+ '| |'+sGR+ '| |'+sPol_+'|'+#13+
             '|'+sFam+ '| |'+sImia+ '| |'+sOth+'|'+#13+
             '|'+sDataBoln+ ' PB-4 |'+
              sOtkuda+ '| |'+
              sDataOrit+ ' ORIT |'+
              sVBL+ '| |'+
              sKuda+ '| |'+
              sDataVip+ '| |'+
              sIsxod_+'|'
              ));
  Showmessage(ConsoleToUTF8(
   '|'+sStrana+ '|'+ '|'+sRegion+ '|'+  '|'+sPunkt + '|'+  '|'+sAdrMJ + '|'+#13+
    '|'+ sRabota_ + '| '+ sGrInvalid + '| |'+sInvalidT + '| |'+sInvalidV + '|'+#13+
    '1ROD=|'+s1RostvID +'| |'+s1RostvFio+'| |'+s1RostvAdr+'| '+#13+
   '2ROD=|'+s2RostvID +'| |'+s2RostvFio+'| |'+s2RostvAdr+'|'
   ));
  Showmessage(ConsoleToUTF8(
   '|'+sDzOsn+'|'+#13+#13+
   '|'+sDzFon+'|'+#13+#13+
   '|'+sDzOsl+'|'+#13+#13+
   '|'+sDzSop+'|'
   ));
  Showmessage('Ан_ЖЗН '+ '|'+sAnGz+'|');
  Showmessage('Ан_Заб '+ '|'+sAnZb+'|');
  Showmessage('Пс.  '+ '|'+sPsSt+'|');
  Showmessage('Сома. '+ '|'+sSomS+'|');
  Showmessage('Невр. '+ '|'+sNevS+'|');
  Showmessage('Групп-резус крови '+ '|'+sRezusKr+'|'+sGruppaKr+'|'+#13+
              'общ. Ан '+ '|'+sAnalObsh+'|'+#13+
              'ОАК '+ '|'+sAnalKr+'|'+#13+
              'ОАМ '+ '|'+sAnalMO+'|'+#13+
              'Ликв '+ '|'+sAnalLu+'|'
              );
 Showmessage(ConsoleToUTF8(
   '|'+KONSArray[j].sVidOBSL+'|'+#13+
   '|'+KONSArray[j].sDATAOBSL+'|'+#13+
   '|'+KONSArray[j].sREZ_OBSL+'|'
     ))
  Showmessage('Мед_Лек '+ '|'+sLekM+'|');
  Showmessage('НЕ мед_Лек '+ '|'+sLekNM+'|');
  Showmessage('Хирург.    '+ '|'+sLekX+'|');
  Showmessage('Результат '+ '|'+sRezLek+'|');
  Showmessage('Рекомедац '+ '|'+sRecomend+'|');
  Showmessage('Примечания '+ '|'+sComment+'|');
  Showmessage('Врачи '+ '|'+sVR1+'| |'+sVR2+'| |'+sVR3+'|  Зав.ОРИТ |'+sZavORit+'|');
 *)

