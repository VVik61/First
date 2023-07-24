{ **********************************************************************
 Модуль форматирования, вывода в Word из DBF-файлов измененного формата DBFIII,
 где в описании поля вставлены имена DBF-файлов-справочников для этого поля,
 используемых в DOS-Эпикризе. (И.Н.Лозинский. 2001г(?))
 Автор В.И.Воронов. 2023г
 **********************************************************************
}

unit PrntInW;

{$mode ObjFPC}{$H+}

interface

uses
  SysUtils , Registry, ComObj, LazUTF8, Dialogs
  , Un_AnsiOem, uofficedll, un_resstring;

function IsWordInstalled: Boolean;

function CreateWord(const Visible: boolean): boolean;

function SelTemplats:  string; {Выбор шаблона}

procedure FormatInWord; //(var iPosPrB: integer);

function FindSelectTxt(const FindText:WideString):boolean;

{Замена в рабочем мемо фамилий врачей на их ФИО}
function Vrach(const sVr : String) : String;

procedure Zamena(FindText, ReplaceText:WideString);

var
 WB, MyRange: variant;
 boolPol, boolPerevod, boolLetal: boolean;

implementation

uses forms, Un_strfb, DM_setup, u_main ;

function IsWordInstalled: Boolean;
var
 Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CLASSES_ROOT;
    Result := Reg.KeyExists('Word.Application');
  finally
   Reg.Free;
  end;
end;

{$REGION '  Выбор шаблона '}
function SelTemplats: string;
begin
 With FB_EpiW do begin
  boolPol:= (ConsoleToUTF8(sPol_) = 'М') OR (ConsoleToUTF8(sPol_) = 'м') or (sPol_ = 'M');
  boolPerevod:= (ConsoleToUTF8(sVBL) = Trim('ПЕРЕВЕДЕН'))  Or (ConsoleToUTF8(sVBL) = Trim('ПЕРЕВЕДЕНА'));
  boolLetal := false;
  //if (boolPol = true) and (ConsoleToUTF8(sVBL) = Trim('УМЕР')) then   boolLetal := true;
  //if (boolPol = false) and (ConsoleToUTF8(sVBL) = Trim('УМЕРЛА')) then   boolLetal := true;
  boolLetal:= (ConsoleToUTF8(sVBL) = Trim('УМЕР')) Or (ConsoleToUTF8(sVBL) = Trim('УМЕРЛА'));
  if (boolPol = true) and (boolPerevod = true) then begin
     Result := rsDokPerevod; //sDokPerevod;
     exit;
  end;

  if (boolPol = false) and (boolPerevod = true) then begin
     Result := rsDokPerevod_f; //sDokPerevod_f;
     exit;
  end;

  if (boolPol = true) and (boolPerevod = false) then begin
     if boolLetal = false then Result := rsDokVip //sDokVip
       else Result :=  rsDokLetal; //sDokLetal;
     exit;
  end;

  if (boolPol = false) and (boolPerevod = false) then begin
     if boolLetal = false then Result := rsDokVip_f //sDokVip_f
       else Result :=  rsDokLetal_f; //sDokLetal_f;
     exit;
  end;
  //if boolPol = true then Showmessage('Myж') else Showmessage('Жен');
  //if boolPerevod = true then Showmessage('ПЕРЕВОД') else Showmessage('ВЫПИСКА');
  //if boolLetal = true then Showmessage('СМЕРТЕЛЬНЫЙ')  else Showmessage('ЖИВ');
  Result := '';
 end;
end;
{$ENDREGION}

{$REGION 'Замена в рабочем мемо фамилий врачей на их ФИО'}
function Vrach(const sVr : String) : String;
 begin
  With FB_EpiW do begin
      if sVr = '*' then result:= '';
      if sVr = 'Воронов' then result:= 'В. И. Воронов';
      if sVr = 'Себелев' then result:= 'Я. А. Себелев';
      if sVr = 'Струков' then result:= 'Ю. Я. Струков';
      if sVr = 'Марисов' then result:= 'М. Л. Марисов';
      if sVr = 'Нельсон' then result:= 'А. И. Нельсон';
      if sVr = 'Вевербрант' then result:= 'А. С. Вевербрант';
      if sVr = 'Гуц' then result:= 'А. И. Гуц';
     end;
 end;
{$ENDREGION}

function CreateWord(const Visible: boolean): boolean;
begin
  result := true;
  WB := CreateOleObject('Word.Application');
  WB.Visible:= Visible;
end;

procedure FormatInWord; //(var iPosPrB: integer);
var
 y, k:byte;
begin
 Application.ProcessMessages;
 fmMain.pb1.Position:=1;
 if CreateWord(false) then begin {открыть Word, но не отображать его на экране}
  With FB_EpiW do begin  //Showmessage(DM_S.sSQLDir+SelTemplats);
  WB.Documents.Add(DM_S.sShablon+SelTemplats); //Showmessage(DM_S.sWDTemp+ConsoleToUTF8(sFam)+'.docx');
  // SetWordVisible(WB,true);
   //WB.ActiveDocument.SaveAS(DM_S.sWDTemp+ConsoleToUTF8(sFam)+'.docx');
  if boolPerevod then Zamena(rsNumDOC,  ConsoleToUTF8(sNOPer))
                 else Zamena(rsNumDOC,  ConsoleToUTF8(sNumIB));
{$REGION ' Паспортная часть, адрес, работа-инвалидность-родственники'}
     Zamena(rsFIO,  ConsoleToUTF8(sFio_));
     Zamena(rsGDR,       sGR);
  if boolPerevod = false then Zamena(rsDATA_POST_B, ConsoleToUTF8(sDataBoln));
     Zamena(rsDATA_POST, sDataOrit);
     Zamena(rsPostIs,  ConsoleToUTF8(sOtkuda));
     Zamena(rsDATA_VIP,  sDataVip);
     Zamena(rsKuda,     ConsoleToUTF8(sKuda));

  if boolPerevod = false then begin
         if Length(Trim(sAdrMJ)) > 0 then sAdres := sAdrMJ;
         if Length(Trim(sPunkt)) > 0 then sAdres := sPunkt+', '+sAdres;
         if Length(Trim(sRegion)) > 0 then sAdres :=  sRegion+', '+sAdres;
         if ConsoleToUTF8(sStrana) <> 'Россия' then sAdres := sStrana+', '+sAdres;

         if (sAdres = '*') or (Length(Trim(sAdres)) = 0) then sAdres := UTF8ToConsole(' неизвестен.');
         Zamena(rsADRES, ConsoleToUTF8(sAdres));
         if (sRabota_ = '*') or (Length(Trim(sRabota_)) = 0) then
             sRabota_ := UTF8ToConsole(' неизвестно.');
         Zamena(rsRABOTA, ConsoleToUTF8(sRabota_));         //Showmessage('sGrInvalid = '+ sGrInvalid);
         if (sGrInvalid = '*') or (Length(Trim(sGrInvalid)) = 0) then begin
            Zamena(UTF8ToConsole('ИНВАЛИД:'),'');
            Zamena(rsINVALID, '');
            WB.Selection.delete;
          end else
          Zamena(rsINVALID, sInvalidAll);
         if Length(Trim(sRodstvAll)) > 0  then  Zamena(rsRODSTV, ConsoleToUTF8(sRodstvAll))
           else Zamena('РОДСТВЕННИКИ: ###RODSTV@', '');
  end;
{$ENDREGION}
{$REGION ' Диагнозы. надо доработать = скобки и т.п.'}
  Zamena(rsDsKlin, ConsoleToUTF8(sDzOsnALL));
 if Length(Trim(sDzFon)) > 0 then   Zamena(rsDsFon,  ConsoleToUTF8(sDzFon))
 else begin Zamena(UTF8ToConsole('Фоновое заболевание:')+#13+rsDsFon, '');
  WB.Selection.delete;
 end;

  if Length(Trim(sDzOsl)) > 0 then   Zamena(rsDsOsl,  ConsoleToUTF8(sDzOsl))
 else begin Zamena(UTF8ToConsole('Осложнения:')+#13+rsDsOsl, '');
    WB.Selection.delete;
 end;

  if Length(Trim(sDzSop)) > 0 then   Zamena(rsDsSop,  ConsoleToUTF8(sDzSop))
 else begin Zamena(UTF8ToConsole('Сопутствующее заболевание:')+#13+rsDsSop, '');
  WB.Selection.delete;
 end;
{$ENDREGION}

{$REGION ' Анамнезы-статусы'}
    if UTF8Length(UTF8Trim(sAnGz)) > 0 then Zamena(rsAnGzn, sAnGz)
      else begin       //if FindSelectTxt(UTF8ToConsole('АНАМНЕЗ ЖИЗНИ')) then //Showmessage('!');
        Zamena(UTF8ToConsole('АНАМНЕЗ ЖИЗНИ'), '');
        WB.Selection.delete;
        Zamena(rsAnGzn,'') ;
        WB.Selection.delete;
        GotoUp(1, WB);
        WB.Selection.delete;
      end;
     Zamena(rsAnZab, sAnZb);
     Zamena(rsStatPs, sPsSt);
     Zamena(rsStatSom, sSomS);
     Zamena(rsStatNev, sNevS);
{$ENDREGION}

  fmMain.pb1.Position:=10;
{$REGION 'Анализы'}
   if Length(Trim(ConsoleToUTF8(sRezusKr+' '+sGruppaKr))) = 0 then begin
        Zamena(rsAnLabGrKrovi, '');
        WB.Selection.delete;
   end
   else
     Zamena(rsAnLabGrKrovi, ConsoleToUTF8(sRezusKr+' '+sGruppaKr));
   if Length(Trim(ConsoleToUTF8(sAnalObsh))) > 0 then Zamena(rsAnLabOb, sAnalObsh)
   else begin
     Zamena(rsAnLabOb, '');
     WB.Selection.delete;
   end;
   Application.ProcessMessages;
   if Length(Trim(ConsoleToUTF8(sAnalKr))) > 0 then Zamena(rsAnLabK0, sAnalKr)
   else begin
     Zamena(rsAnLabK0, '');
     WB.Selection.delete;
   end;   //Zamena('###AnLabK0@', sAnalKr);

   Zamena(rsAnLabK, '');
   WB.Selection.delete;
   k:=0;   //Showmessage('iAnK= '+IntToStr(iAnK));
  if iAnK>0 then begin
   CreateTable(3,iAnK,WB); {создаем таблицу 3 колонки 2 строки (остальные строки добавлятся в процессе формир. автоматически)}
   FontBold(true,WB);
   FontItalic(false,WB);
   AddText(UTF8ToWinCP(rsPokalLab), WB);
   SetColWidth(160,WB);
   GotoRight(1,WB);
   FontBold(true,WB);
   FontItalic(false,WB);
   AddText(UTF8ToWinCP(rsZnakPokLab), WB);
   SetColWidth(160,WB);
   GotoRight(1,WB);
   FontBold(true,WB);
   FontItalic(false,WB);
   AddText(UTF8ToWinCP(rsPeriodLab),WB);
   FontBold(false,WB);
   FontItalic(false,WB);
   for y := 1 to iAnK-1 do begin
          GotoRight(1,WB);
          FontBold(false,WB);
          FontItalic(false,WB);
          AddText(StrOemToAnsi(FB_EpiW.AllTabAnal[y].sNPok),WB);
          GotoRight(1,WB);
          FontBold(false,WB);
          FontItalic(false,WB);
          AddText(StrOemToAnsi(FB_EpiW.AllTabAnal[y].sZnPok),WB);
          GotoRight(1,WB);
          FontBold(false,WB);
          FontItalic(false,WB);
          AddText(StrOemToAnsi(FB_EpiW.AllTabAnal[y].sPeriod),WB);
   end;
   ExitTable(WB);
  end;
   fmMain.pb1.Position:=30;
  Application.ProcessMessages;
  if Length(Trim(ConsoleToUTF8(sAnalKr))) > 0 then Zamena(rsAnLabM0, sAnalMO)
  else begin
    Zamena(rsAnLabM0, '');
    WB.Selection.delete;
  end;   //Zamena('###AnLabK0@', sAnalKr);
  Zamena(rsAnLabM, '');
  WB.Selection.delete;
  if iAnM>0 then begin
   CreateTable(3,iAnM,WB);
   FontBold(true,WB);
   FontItalic(false,WB);
   AddText(UTF8ToWinCP(rsPokalLab),WB);
   SetColWidth(160,WB);
   GotoRight(1,WB);
   FontBold(true,WB);
   FontItalic(false,WB);
   AddText(UTF8ToWinCP(rsZnakPokLab),WB);
   SetColWidth(160,WB);
   GotoRight(1,WB);
   FontBold(true,WB);
   FontItalic(false,WB);
   AddText(UTF8ToWinCP(rsPeriodLab), WB);
   FontBold(false,WB);
   if iAnK=0 then k:=1 else k:=iAnK;
   for y := k to k+iAnM-2 do begin
          GotoRight(1,WB);
          FontBold(false,WB);
          FontItalic(false,WB);
          AddText(StrOemToAnsi(FB_EpiW.AllTabAnal[y].sNPok),WB);
          GotoRight(1,WB);
          FontBold(false,WB);
          FontItalic(false,WB);
          AddText(StrOemToAnsi(FB_EpiW.AllTabAnal[y].sZnPok),WB);
          GotoRight(1,WB);
          FontBold(false,WB);
          FontItalic(false,WB);
          AddText(StrOemToAnsi(FB_EpiW.AllTabAnal[y].sPeriod),WB);
   end;
   ExitTable(WB);
  end;

  if (iAnL = 0) and (Length(Trim(ConsoleToUTF8(sAnalLu))) = 0) then begin    //Showmessage('iAnL= '+IntToStr(iAnL));    //Showmessage('sAnalLu= '+'|'+ConsoleToUTF8(sAnalLu)+'|');
    Zamena(UTF8ToConsole(rsAnLikvor), '');
    WB.Selection.delete;
    Zamena(rsAnLabL0, '');
    WB.Selection.delete;
    Zamena(rsAnLabL, '');
    WB.Selection.delete;
   end
   else begin
    if Length(Trim(ConsoleToUTF8(sAnalLu))) > 0 then Zamena(rsAnLabL0, sAnalLu)
     else begin
     Zamena(rsAnLabL0, '');
     WB.Selection.delete;
     end;
     Zamena(rsAnLabL, '');
     WB.Selection.delete;
     if iAnL>0 then begin
     CreateTable(3,iAnL,WB);
     FontBold(true,WB);
     FontItalic(false,WB);
     AddText(UTF8ToWinCP(rsPokalLab),WB);
     SetColWidth(160,WB);
     GotoRight(1,WB);
     FontBold(true,WB);
     FontItalic(false,WB);
     AddText(UTF8ToWinCP(rsZnakPokLab),WB);
     SetColWidth(160,WB);
     GotoRight(1,WB);
     FontBold(true,WB);
     FontItalic(false,WB);
     AddText(UTF8ToWinCP(rsPeriodLab),WB);
     FontBold(false,WB);
{ #todo : Выражения (iAnK+iAnM)-1 и  (iAnK+iAnM+iAnL-3) преобразовать}
     for y := (iAnK+iAnM)-1 to (iAnK+iAnM+iAnL-3) do begin
          GotoRight(1,WB);
          FontBold(false,WB);
          FontItalic(false,WB);
          AddText(StrOemToAnsi(FB_EpiW.AllTabAnal[y].sNPok),WB);
          GotoRight(1,WB);
          FontBold(false,WB);
          FontItalic(false,WB);
          AddText(StrOemToAnsi(FB_EpiW.AllTabAnal[y].sZnPok),WB);
          GotoRight(1,WB);
          FontBold(false,WB);
          FontItalic(false,WB);
          AddText(StrOemToAnsi(FB_EpiW.AllTabAnal[y].sPeriod),WB);
     end;
      ExitTable(WB);
    end;
  end;

{$ENDREGION}
Application.ProcessMessages;
fmMain.pb1.Position:=50;
Application.ProcessMessages;

{$REGION 'Инструментальные исследования и консультации'}
   if Length(Trim(ConsoleToUTF8(sInstrumI))) =  0 then begin
        Zamena(UTF8ToConsole(rsInstrumITit), '');
        WB.Selection.delete;
        Zamena(rsInstrI, '');
        WB.Selection.delete;
   end
   else Zamena(rsInstrI, sInstrumI);

   if Length(Trim(ConsoleToUTF8(sKonsult))) =  0 then begin
          Zamena(UTF8ToConsole(rsKonsultTit), '');
          WB.Selection.delete;
          Zamena(rsKonsult, sKonsult);
          WB.Selection.delete;
    end else Zamena(rsKonsult, sKonsult);
{$ENDREGION}

fmMain.pb1.Position:=60;
Application.ProcessMessages;

{$REGION 'Лечение'}
   if Length(Trim(ConsoleToUTF8(sLekM))) >  0 then Zamena(rsLehM,  sLekM)
   else begin
           //Showmessage('sLekM='+ sLekM);
          Zamena(UTF8ToConsole('ЛЕЧЕНИЕ – медикаментозное'), '');
          WB.Selection.delete;
          Zamena(rsLehM,  '');
          WB.Selection.delete;
    end;
   //GotoUp(2, WB);
   if Length(Trim(ConsoleToUTF8(sLekNM))) >  0 then Zamena(rsLehNM, sLekNM)
   else begin
          Zamena(UTF8ToConsole('ЛЕЧЕНИЕ – немедикаментозное'), '');
          WB.Selection.delete;
          Zamena(rsLehNM, '');
          WB.Selection.delete;
    end;
   //GotoUp(2, WB);
   if Length(Trim(sLekX)) =  0 then begin
          Zamena(rsLehX,  '');
          WB.Selection.delete;
          GotoUp(1, WB);
          AddParagraph(WB);
          GotoUp(1, WB);
          Zamena(UTF8ToConsole('ЛЕЧЕНИЕ'), '');
          WB.Selection.delete;
          Zamena(UTF8ToConsole('хирургическое'), '');
          WB.Selection.delete;
          GotoUp(1, WB);
          Zamena('–', '');
          WB.Selection.delete;
    end else Zamena(rsLehX,  sLekX);

    //Zamena(UTF8ToConsole('ЛЕЧЕНИЕ – хирургическое'), '');
    //WB.Selection.delete;

{$ENDREGION}

fmMain.pb1.Position:=80;
Application.ProcessMessages;

{$REGION 'Результат лечения, рекомедации и примечания'}

    if Length(Trim(ConsoleToUTF8(sRezLek))) =  0 then begin
           Zamena(UTF8ToConsole('РЕЗУЛЬТАТ ЛЕЧЕНИЯ'), '');
           WB.Selection.delete;
           Zamena(rsRez, sRezLek);
           WB.Selection.delete;
    end else Zamena(rsRez, sRezLek);
    AddParagraph(WB);
    if Length(Trim(ConsoleToUTF8(sRecomend))) =  0 then begin
           Zamena(UTF8ToConsole('РЕКОМЕНДАЦИИ ПРИ ВЫПИСКЕ'), '');
           WB.Selection.delete;
           Zamena(rsRecom,  '');
           WB.Selection.delete;
     end else Zamena(rsRecom, sRecomend);
     AddParagraph(WB);

   if Length(Trim(ConsoleToUTF8(sComment))) =  0 then begin
          Zamena(UTF8ToConsole('ПРИМЕЧАНИЯ'), '');
          WB.Selection.delete;
          Zamena(rsPrim, '');
          WB.Selection.delete;
    end else Zamena(rsPrim, sComment);
{$ENDREGION}

{$REGION 'Врачи'}
    Zamena(rsVrach1, Vrach(sVR1));
   if Length(Trim(ConsoleToUTF8(sVR2))) >  0 then Zamena(rsVrach2, Vrach(sVR2))
     else begin
      Zamena(rsVrach2, '');
      WB.Selection.delete;
     end;
    if Length(Trim(ConsoleToUTF8(sVR3))) >  0 then Zamena(rsVrach3, Vrach(sVR3))
      else begin
       Zamena(rsVrach3, '');
       WB.Selection.delete;
      end;
    Zamena(rsVrach4, Vrach(sZavORit));
{$ENDREGION}

   GotoUp(200, WB);
   SetWordVisible(WB,true);
   WB.ActiveDocument.SaveAS(DM_S.sWDTemp+ConsoleToUTF8(sFam)+'.docx');
 end; {With FB_EpiW}
 end; {if CreateWord}
end;

function FindSelectTxt(const FindText: WideString): boolean;
begin
  WB.Selection.Find.MatchSoundsLike := False;
  WB.Selection.Find.MatchAllWordForms := False;
  WB.Selection.Find.MatchWholeWord := False;
  WB.Selection.Find.Format := False;
  WB.Selection.Find.Forward := True;
  WB.Selection.Find.ClearFormatting;
  WB.Selection.Find.Text:=FindText;
  result := WB.Selection.Find.Execute;
end;

procedure Zamena(FindText, ReplaceText: WideString);
begin
  if FindSelectTxt(FindText) then begin
         WB.Selection.InsertBefore(ReplaceText);
         FindSelectTxt(FindText);
         WB.Selection := '';
  end;
end;



{TODO:  определить действия, если Ворд не установлен. }
initialization

if IsWordInstalled = false then
  ShowMessage('НЕТ MS Word.');

end.

//Ниже всяческие заметки по воводу автоматизации в Word'е  и старые куски кода
(*
//https://webdelphi.ru/2010/02/microsoft-word-v-delphi/
uses ComObj;
var Word: variant;
[...]
procedure CreateWord(const Visible: boolean);
begin
  Word:=CreateOleObject('Word.Application');
  Word.Visible:=Visible;
end;


Чтобы создать новый документ необходимо выполнить метод Add у коллекции Documents, т.е.:
[...]
Word.Documents.Add
[...]
и после этой операции уже начинать работать с документам обращаясь к нему по индексу или имени в коллекции. Также, можно создать новый документ по шаблону (.dot).
 Для этого необходимо выполнить тот же метод Add, но с одним входным параметром — путем к файлу-шаблону:

[...]
Word.Documents.Add(TamplatePath:string);
[...]


Чтобы получить список всех открытых в данный момент документов Word можно воспользоваться следующим листингом:

[...]
var List: TStringList;
    i: integer;
begin
  List:=TStringList.Create;
  for i:=1 to Word.Documents.Count do
    List.Add(Word.Documents.Item(i).Name);
end;
[...]

Обратите внимание, что нумерация начинается с 1, а не с нуля. Чтобы активировать
любой документ из коллекции для работы, необходимо выполнить метод Activate:

Word.Documents.Item(index).Activate
где index — номер документа в коллекции.


Теперь можно приступать к записи и чтению документа. Для работы с текстов в документе Word,
как и в Excel для работы с ячейками таблицы, определен объект Range.
Именно методы этого объекта и дают нам возможность работы с текстом.
Для начала рассмотрим работу двух основных методов: InsertBefore и InsertAfter.

Как следует из название — первый метод вставляет текст в начало содержимого Range,
а второй — в конец. При этом сам объект Range может содержать как весть документ (Document)
так и какую-либо его часть. Например, в следующем листинге я вставлю строку
в начало документа и затем методом InsertAfter буду добавлять несколько строк текста в конец документа:

[...]
Word.ActiveDocument.Range.InsertBefore('Hello World');
Word.ActiveDocument.Range.InsertAfter('текст после Hello World');
Word.ActiveDocument.Range.InsertAfter('окончание строки в документа');
[...]
При выполнении этих трех операции Range содержал весь документ.

Если работать со всем документом неудобно, а необходимо, например
выделить фрагмент с 50 по 100 символ и работать с ним,
то можно воспользоваться функцией Range, которая вернет нам необходимый объект Range:

var MyRange: variant;
begin
  MyRange:=WordActiveDocument.Range(50,100);
  MyRange.InsertBefore('Привет');//всё, что было после 50-го символа сдвинулось вправо
end;
Это что касается записи текста. Решение обратной задачи — чтения текста из документа ещё проще. Достаточно воспользоваться свойством Text у объекта Range:

[...]
ShowMessage(Word.ActiveDocument.Range.Text) //весь текст в документе
[...]
Также для чтения документа можно воспользоваться коллекцией документа Words (слова). За слово принимается непрерывный набор символов — цифр и букв, который оканчивается пробелом.

Перечисляются слова документа точно также как и при работе с коллекцией документов, т.е. первое слово имеет индекс 1 последнее — Word.Count.

[...]
  ShowMessage(Word.ActiveDocument.Words.Item(Word.ActiveDocument.Words.Count).Text)
[...]
В данном случае я вывел на экран последнее слово в документе.

Очевидно, что приведенный выше способ работы с документам хорош в случае, когда требуется создать относительно простой документ Word и не требуется лишний раз рассчитывать фрагменты текста, правильно вставлять таблицы и т.д. Если же необходимо работать с документами, которые имеют сложное содержание, например текст в перемежку с рисунками, таблицами, а сам текст выводится различными шрифтами, то, на мой взгляд наиболее удобно использовать второй способ работы с Word в Delphi — просто заменить текст в уже заранее заготовленном документа.



{Открытие готового документа и замена текста.}
var FilePath: string;
[...]
  Word.Documents.Open(FilePath)
[...]
Метод Open можно вызывать с несколькими аргументами:
?	FileName: string — путь и имя файла;
?	ConfirmConversions: boolean — False — не открывать диалоговое окно «Преобразование файла» при открытии файла, формат которого не соответствует формату Word (doc или docx)
?	ReadOnly:boolean — True — открыть документ в режиме «Только для чтения»
?	AddToRecentFiles: boolean — True, чтобы добавить документ в список недавно открытых документов.
?	PasswordDocument: string — пароль для открытия документа
?	PasswordTemplate: string — пароль для открытия шаблона
?	Revert : boolean — True, чтобы вернуться к сохраненному документу, если этот документ открывается повторно.
?	WritePasswordDocument: string — пароль для сохранения измененного документа в файле
?	WritePasswordTemplate:string — пароль для сохранения изменений в шаблоне
?	Format:integer — формат открываемого документа.
Обязательным параметром метода Open является только FileName, остальные — могут отсутствовать. Если же Вам необходимо воспользоваться несколькими параметрами, то их необходимо явно указывать при вызове метода, например:
[...]
  Word.Documents.Open(FileName:=FilePath, ReadOnly:=true)
[...]
В этом случае документ открывается в режиме «Только для чтения». При таком способе вызова (с явным указанием аргументов) положение аргументов может быть произвольным.
Что касается последнего аргумента — Format, то он может принимать  целочисленные значения (применительно к версиям Microsoft Word 2007 и выше) от 0 до 13. При этом, для того, чтобы открыть «родные» вордовские документы (doc) достаточно использовать значения 0 или 6.



function FindAndReplace(const FindText,ReplaceText:string):boolean;
  const wdReplaceAll = 2;
begin
  Word.Selection.Find.MatchSoundsLike := False;
  Word.Selection.Find.MatchAllWordForms := False;
  Word.Selection.Find.MatchWholeWord := False;
  Word.Selection.Find.Format := False;
  Word.Selection.Find.Forward := True;
  Word.Selection.Find.ClearFormatting;
  Word.Selection.Find.Text:=FindText;
  Word.Selection.Find.Replacement.Text:=ReplaceText;
  FindAndReplace:=Word.Selection.Find.Execute(Replace:=wdReplaceAll);
end;



С ДРУГОГО САЙТА

//https://d-nik.pro/programmirovanie/programmirovanie-na-delphi/145-delphi-i-word-sozdanie-redaktirovanie-otkrytie-dokumenta-word-v-delphi
Обработка документов Word в Delphi. Примеры
Как уже упоминалось, для взаимодействия с COM-сервером Word нам в первую очередь нужно подключить модуль ComObj. Поэтому не забудьте в uses дописать ComObj.

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, ComObj; // подключаем модуль ComObj
Также, нужно объявить глобальную переменную типа OleVariant.

var
  Form1: TForm1;
  Word:OleVariant; // объявляем переменную для доступа к объекту MS Word
Как создать документ Word
procedure TForm1.Button1Click(Sender: TObject);
begin
  Word:=CreateOleObject('Word.Application'); // создаём приложение Word
  Word.Visible:=True; // делаем приложение видимым
  Word.Documents.Add(EmptyParam,EmptyParam,EmptyParam,EmptyParam); // создаём документ Word
end;
Как открыть документ Word
procedure TForm1.Button1Click(Sender: TObject);
begin
  Word:=CreateOleObject('Word.Application'); // создаём приложение Word
  Word.Documents.Open('D:\\test.docx'); // открываем файл
  Word.Visible:=True; // делаем приложение видимым
  Word:=Unassigned; //Значение Unassigned показывает, что переменная является нетронутой, т.е. переменной еще не присвоено значение. Оно автоматически устанавливается в качестве начального значения любой переменной с типом Variant.
end;
Как записать текст в документ Word
procedure TForm1.Button1Click(Sender: TObject);
var
  s:String; // объявляем переменную в которой будет храниться нужный нам текст
begin
  s:='Этот текст мы записываем в документ Word';
  Word:=CreateOleObject('Word.Application'); // создаём приложение Word
  Word.Visible:=True; // делаем приложение видимым
  Word.Documents.Add(EmptyParam, EmptyParam, EmptyParam, EmptyParam); // создаём документ Word
  Word.ActiveDocument.Range.InsertAfter(s); // записывает содержимое переменной s в документ Word
end;
Как закрыть документ Word
procedure TForm1.Button2Click(Sender: TObject);
begin
  Word.Quit; // выход из Word
  Word:=UnAssigned; // очищаем память от объекта Application
end;
Как закрыть Word с сохранением изменений
procedure TForm1.Button2Click(Sender: TObject);
begin
  Word.ActiveDocument.Close(True);
end;




Sub delVoidParagraphs()
'Удаление пустых абзацев в выделенном фрагменте
With Selection.Find
   .ClearFormatting
   .Replacement.ClearFormatting
   .Text = "^0013{2;}"
   .Replacement.Text = "^p"
   .MatchWildcards = True
   .Format = False
   .Forward = True
   If Selection.Type = wdSelectionIP Then
      .Wrap = wdFindContinue
   Else
      .Wrap = wdFindStop
   End If
   .Execute Replace:=wdReplaceAll
End With
Selection.Collapse direction:=wdCollapseStart
End Sub

function FindSelectTxt(const FindText: WideString): boolean;
begin
  WB.Selection.Find.MatchSoundsLike := False;
  WB.Selection.Find.MatchAllWordForms := False;
  WB.Selection.Find.MatchWholeWord := False;
  WB.Selection.Find.Format := False;
  WB.Selection.Find.Forward := True;
  WB.Selection.Find.ClearFormatting;
  WB.Selection.Find.Text:="^0013{2;}";
  result := WB.Selection.Find.Execute;
end;

procedure Zamena(FindText, ReplaceText: WideString);
begin
  if FindSelectTxt(FindText) then begin
         WB.Selection.InsertBefore(ReplaceText);
         FindSelectTxt(FindText);
         WB.Selection := '';
  end;
end;

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


{ДИАГНОЗ }

{Удаление скобок  из диагноза в рабочем мемо}
procedure TFmPrintDosToWin.DelMemoSkobkiDs;
var
  k1, k2:  integer;
//  sTemp: String;
begin
 WaiteKursor;
 with mmRab1 do
 begin
 Text :=sZamena;
 k1 := pos('{',Text);
 k2 := pos('}',Text);
 while (k1>0) and (k2>0) do
  begin
    SelStart := k1-1;
    SelLength := K2+1-SelStart;
    SelText := '';
    k1 := pos('{',Text);
    k2 := pos('}',Text);
  end;// while
 sZamena := Text;
 end;//with mmRab1
 ProgBarPlus1_DefCursor;
end;

{Удаление скобок [ и  ]  из основного диагноза в документе WORD}
procedure TFmPrintDosToWin.SkobkiOsmDs;
var
  boolNaiden : boolean;
  iStars, iEnds : integer;
begin
  WaiteKursor;
  boolNaiden := true;
  WB.Selection.Start :=0;
  WB.Selection.End :=0;
  WB.Selection.Find.Forward :=  true;
  WB.Selection.Find.Text := '[';
  boolNaiden := not WB.Selection.Find.Execute;
  if boolNaiden = true then  exit;  //begin  ShowMessage('Не найдено- '+sFi);   exit;    end;
  iStars := WB.Selection.start;

  WB.Selection.Start :=0;
  WB.Selection.End :=0;
  WB.Selection.Find.Forward :=  true;
  WB.Selection.Find.Text := ']';
  boolNaiden := not WB.Selection.Find.Execute;
  iEnds :=  WB.Selection.End;
  WB.Selection.SetRange(iStars,iEnds);
  WB.Selection.Text :='';

  WB.Selection.Start :=0;
  WB.Selection.End :=0;
  WB.Selection.Find.Forward :=  true;
  WB.Selection.Find.Text := '[';
  boolNaiden := not WB.Selection.Find.Execute;
  if boolNaiden = true then  exit;  //begin  ShowMessage('Не найдено- '+sFi);   exit;    end;
  iStars := WB.Selection.start;

  WB.Selection.Start :=0;
  WB.Selection.End :=0;
  WB.Selection.Find.Forward :=  true;
  WB.Selection.Find.Text := ']';
  boolNaiden := not WB.Selection.Find.Execute;
  iEnds :=  WB.Selection.End;
  WB.Selection.SetRange(iStars,iEnds);
  if WB.Selection.Font.Italic = 1 then exit;

  WB.Selection.Font.Italic := 1;

  WB.Selection.Start :=0;
  WB.Selection.End :=0;
  WB.Selection.Find.Forward :=  true;
  WB.Selection.Find.Text := '[';
   boolNaiden := not WB.Selection.Find.Execute;
  iStars := WB.Selection.start;
  iEnds := iStars+1;
  WB.Selection.SetRange(iStars,iEnds);
  WB.Selection.Text :='';

  WB.Selection.Start :=0;
  WB.Selection.End :=0;
  WB.Selection.Find.Forward :=  true;
  WB.Selection.Find.Text := ']';
   boolNaiden := not WB.Selection.Find.Execute;
  iStars := WB.Selection.start;
  iEnds := iStars+1;
  WB.Selection.SetRange(iStars,iEnds);
  WB.Selection.Text :=''+#13;
  ///ДУБЛЬ

  WB.Selection.Start :=0;
  WB.Selection.End :=0;
  WB.Selection.Find.Forward :=  true;
  WB.Selection.Find.Text := '[';
  boolNaiden := not WB.Selection.Find.Execute;
  if boolNaiden = true then  exit;  //begin  ShowMessage('Не найдено- '+sFi);   exit;    end;
  iStars := WB.Selection.start;

  WB.Selection.Start :=0;
  WB.Selection.End :=0;
  WB.Selection.Find.Forward :=  true;
  WB.Selection.Find.Text := ']';
  boolNaiden := not WB.Selection.Find.Execute;
  iEnds :=  WB.Selection.End;
  WB.Selection.SetRange(iStars,iEnds);
  WB.Selection.Text :='';

  WB.Selection.Start :=0;
  WB.Selection.End :=0;
  WB.Selection.Find.Forward :=  true;
  WB.Selection.Find.Text := '[';
  boolNaiden := not WB.Selection.Find.Execute;
  if boolNaiden = true then  exit;  //begin  ShowMessage('Не найдено- '+sFi);   exit;    end;
  iStars := WB.Selection.start;

  WB.Selection.Start :=0;
  WB.Selection.End :=0;
  WB.Selection.Find.Forward :=  true;
  WB.Selection.Find.Text := ']';
  boolNaiden := not WB.Selection.Find.Execute;
  iEnds :=  WB.Selection.End;
  WB.Selection.SetRange(iStars,iEnds);
  if WB.Selection.Font.Italic = 1 then exit;

  WB.Selection.Font.Italic := 1;

  WB.Selection.Start :=0;
  WB.Selection.End :=0;
  WB.Selection.Find.Forward :=  true;
  WB.Selection.Find.Text := '[';
   boolNaiden := not WB.Selection.Find.Execute;
  iStars := WB.Selection.start;
  iEnds := iStars+1;
  WB.Selection.SetRange(iStars,iEnds);
  WB.Selection.Text :='';

  WB.Selection.Start :=0;
  WB.Selection.End :=0;
  WB.Selection.Find.Forward :=  true;
  WB.Selection.Find.Text := ']';
   boolNaiden := not WB.Selection.Find.Execute;
  iStars := WB.Selection.start;
  iEnds := iStars+1;
  WB.Selection.SetRange(iStars,iEnds);
  WB.Selection.Text :='';
  ProgBarPlus1_DefCursor;
end;



procedure TFmPrintDosToWin.OsnovDs;
var
  Local_yy: Byte;
begin
  with mmRab.Lines do
  begin
    sZamena := '';
    for Local_yy := 51 to 62 do
       if Trim(mmRab.Lines.Strings[Local_yy]) <> '*' then
               sZamena := sZamena + ' ' + Trim(mmRab.Lines.Strings[Local_yy]);
    mmRab1.Text := sZamena;
    DelvMemoTire;
    sZamena := Trim(mmRab1.Text);
    mmRab1.Text := sZamena;
    DelMemoSkobkiDs;
    sZamena := Trim(mmRab1.Text); //    ShowMessage(sZamena);
    Zamena(sZamena, '###DsKlin@');
    SkobkiOsmDs;
//    Application.ProcessMessages;
//    ProgressBar1.Position := ProgressBar1.Position + 1;
  end;
end;

================================================
procedure TFmPrintDosToWin.LabKML_Pokaz(iStart, iStop: Integer; sMetka: string);
var
  z: Integer;
begin
  with mmRab.Lines do
  begin
    sZamena :='';
//    Trim(Strings[iStart]) + ''#9'' + Trim(Strings[(iStart+1)]) + ''#9'' + Trim(Strings[(iStart+2)]) + ''#13'';
    z := iStart;
    Repeat
     if (Trim(Strings[z]) <>'*')= True then
        sZamena :=sZamena+  Trim(Strings[z]) + ''#9'' + Trim(Strings[(z+1)]) + ''#9'' + Trim(Strings[(z+2)]) + ''#13'';
     z := z+3;
    until z > iStop;
    sZamena := 'Показатель' + ''#9'' + 'З н а ч е н и е' + ''#9'' + 'Период болезни' + ''#13'' +sZamena;
//    ShowMessage(sZamena);
    Zamena(sZamena, sMetka);
    try
      WB.Selection.ConvertToTable(
         #9,
         EmptyParam,
         3,
         EmptyParam, EmptyParam, EmptyParam,  EmptyParam, EmptyParam,
         EmptyParam, EmptyParam,  EmptyParam, EmptyParam, EmptyParam,
         true);
    except
       on EAbort do
       begin
       //Abort; //          begin         ShowMessage('Не удалось!');     end;
             if Trim(sFileNameTxt) = '*' then
                    WB.ActiveDocument.SaveAS(sTempDir+'error.doc')
                 else
                  begin
                    sFileNameTxt := sTempDir + sFileNameTxt;
                    WB.ActiveDocument.SaveAS(sFileNameTxt+'.doc');
                        end;
         ShowMessage('Документ содержит ошибки!!!! ');
         WB.Visible := true;
       end;
    end;
  end;
end;
*)

