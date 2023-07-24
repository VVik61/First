{**********************************************************************
 Форма для заполнения данных ПА исследования в ф-лы DBF-файлов измененного формата DBFIII,
 где в описании поля вставлены имена DBF-файлов-справочников для этого поля,
 используемых в DOS-Эпикризе. (DIAGPOSN.DBF и ZAKLUCHE.DBF)
 Автор В.И.Воронов 2023г
 **********************************************************************
}

unit FM_SetPAinDBFL;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ButtonPanel, ComCtrls,
  ExtCtrls, StdCtrls, LazUTF8, u_SelLetDBFL, //DM_setup,
  un_structura, Dbf3;

type

  { TfmSetDBFLPA }

  TfmSetDBFLPA = class(TForm)
    ButtonPanel1: TButtonPanel;
    cbxPARasxDz: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ledPARSX_TIP1: TLabeledEdit;
    ledPARSX_PRI3: TLabeledEdit;
    ledPARSX_PRI4: TLabeledEdit;
    ledPARSX_PRI5: TLabeledEdit;
    ledPARSX_PRI6: TLabeledEdit;
    ledPARSX_PRI7: TLabeledEdit;
    ledPARSX_TIP2: TLabeledEdit;
    ledPARSX_TIP3: TLabeledEdit;
    ledPARSX_TIP4: TLabeledEdit;
    ledPARSX_TIP5: TLabeledEdit;
    ledPARSX_TIP6: TLabeledEdit;
    ledPARSX_TIP7: TLabeledEdit;
    ledPARSX_PRI1: TLabeledEdit;
    ledPARSX_PRI2: TLabeledEdit;
    LEdPDzOsn10: TLabeledEdit;
    LEdPDzOsn11: TLabeledEdit;
    LEdPDzOsn12: TLabeledEdit;
    LEdPDzFon1: TLabeledEdit;
    LEdPDzFon2: TLabeledEdit;
    LEdPDzFon3: TLabeledEdit;
    LEdPDzFon4: TLabeledEdit;
    LEdPDzFon5: TLabeledEdit;
    LEdPDzFon6: TLabeledEdit;
    LEdPDzFon7: TLabeledEdit;
    LEdPDzOsn2: TLabeledEdit;
    LEdPDzFon8: TLabeledEdit;
    LEdPDzFon9: TLabeledEdit;
    LEdPDzFon10: TLabeledEdit;
    LEdPDzFon11: TLabeledEdit;
    LEdPDzFon12: TLabeledEdit;
    LEdPDzOsl1: TLabeledEdit;
    LEdPDzOsl2: TLabeledEdit;
    LEdPDzOsl3: TLabeledEdit;
    LEdPDzOsl4: TLabeledEdit;
    LEdPDzOsl5: TLabeledEdit;
    LEdPDzOsn3: TLabeledEdit;
    LEdPDzOsl6: TLabeledEdit;
    LEdPDzOsl7: TLabeledEdit;
    LEdPDzOsl8: TLabeledEdit;
    LEdPDzOsl9: TLabeledEdit;
    LEdPDzOsl10: TLabeledEdit;
    LEdPDzOsl11: TLabeledEdit;
    LEdPDzOsl12: TLabeledEdit;
    LEdPDzOsl13: TLabeledEdit;
    LEdPDzOsl14: TLabeledEdit;
    LEdPDzOsl15: TLabeledEdit;
    LEdPDzOsn4: TLabeledEdit;
    LEdPDzOsl16: TLabeledEdit;
    LEdPDzSop1: TLabeledEdit;
    LEdPAZAKL1: TLabeledEdit;
    LEdPAZAKL2: TLabeledEdit;
    LEdPAZAKL3: TLabeledEdit;
    LEdPDzSop2: TLabeledEdit;
    LEdPAZAKL4: TLabeledEdit;
    LEdPAZAKL5: TLabeledEdit;
    LEdPAZAKL6: TLabeledEdit;
    LEdPAZAKL7: TLabeledEdit;
    LEdPAZAKL8: TLabeledEdit;
    LEdPAZAKL9: TLabeledEdit;
    LEdPAZAKL10: TLabeledEdit;
    LEdPAZAKL11: TLabeledEdit;
    LEdPAZAKL12: TLabeledEdit;
    LEdPAZAKL13: TLabeledEdit;
    LEdPDzSop3: TLabeledEdit;
    LEdPAZAKL14: TLabeledEdit;
    LEdPAZAKL15: TLabeledEdit;
    LEdPAZAKL16: TLabeledEdit;
    LEdPDzSop4: TLabeledEdit;
    LEdPDzSop5: TLabeledEdit;
    LEdPDzSop6: TLabeledEdit;
    LEdPDzSop7: TLabeledEdit;
    LEdPDzSop8: TLabeledEdit;
    LEdPDzSop9: TLabeledEdit;
    LEdPDzOsn5: TLabeledEdit;
    LEdPDzSop10: TLabeledEdit;
    LEdPDzSop11: TLabeledEdit;
    LEdPDzSop12: TLabeledEdit;
    LEdPDzSop13: TLabeledEdit;
    LEdPDzSop14: TLabeledEdit;
    LEdPDzSop15: TLabeledEdit;
    LEdPDzSop16: TLabeledEdit;
    LEdPDzOsn6: TLabeledEdit;
    LEdPDzOsn7: TLabeledEdit;
    LEdPDzOsn8: TLabeledEdit;
    LEdPDzOsn9: TLabeledEdit;
    LEdPShOsn1: TLabeledEdit;
    LEdPShOsn10: TLabeledEdit;
    LEdPShOsn11: TLabeledEdit;
    LEdPShOsn12: TLabeledEdit;
    LEdPShFon1: TLabeledEdit;
    LEdPShFon2: TLabeledEdit;
    LEdPShFon3: TLabeledEdit;
    LEdPShFon4: TLabeledEdit;
    LEdPShFon5: TLabeledEdit;
    LEdPShFon6: TLabeledEdit;
    LEdPShFon7: TLabeledEdit;
    LEdPShOsn13: TLabeledEdit;
    LEdPShOsn14: TLabeledEdit;
    LEdPShOsn2: TLabeledEdit;
    LEdPShFon8: TLabeledEdit;
    LEdPShOsl1: TLabeledEdit;
    LEdPShOsl2: TLabeledEdit;
    LEdPShOsl3: TLabeledEdit;
    LEdPShOsl4: TLabeledEdit;
    LEdPShOsl5: TLabeledEdit;
    LEdPShOsl6: TLabeledEdit;
    LEdPShOsl7: TLabeledEdit;
    LEdPShOsl8: TLabeledEdit;
    LEdPShSop1: TLabeledEdit;
    LEdPShOsn3: TLabeledEdit;
    LEdPShSop2: TLabeledEdit;
    LEdPShSop3: TLabeledEdit;
    LEdPShSop4: TLabeledEdit;
    LEdPShSop5: TLabeledEdit;
    LEdPShSop6: TLabeledEdit;
    LEdPShSop7: TLabeledEdit;
    LEdPShSop8: TLabeledEdit;
    LEdPShOsn4: TLabeledEdit;
    LEdPDzOsn1: TLabeledEdit;
    LEdPShOsn5: TLabeledEdit;
    LEdPShOsn6: TLabeledEdit;
    LEdPShOsn7: TLabeledEdit;
    LEdPShOsn8: TLabeledEdit;
    LEdPShOsn9: TLabeledEdit;
    mmPADate: TMemo;
    dlgOpenPADate: TOpenDialog;
    PageControl1: TPageControl;
    Panel1: TPanel;
    ScrollBox1: TScrollBox;
    ScrollBox2: TScrollBox;
    Splitter1: TSplitter;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
     iZpLet: longint; {Номер строки умершего в записи}
  public
    LabeledEdits: Array[1..40] of TLabeledEdit;
     //Edits[k] :=TDBEdit(FindComponent(sNameEd +IntToStr(k)));
     //LabeledEdits[k] := TLabeledEdit(FindComponent(sNameEd +IntToStr(k)));
    //if Edits[k].Text ='' then  Edits[k].Text := '*';

  end;

{TODO: Доработать. Подключить механизм Драг-дроп для переноса из мемо по полям.}
{TODO: сделать ф-цию разбивки текста в мемо на кусочки различной длины. Преимущественно длиной 60 символов.}
var
  fmSetDBFLPA: TfmSetDBFLPA;

implementation

uses DM_setup, u_main;

{$R *.lfm}

{ TfmSetDBFLPA }
procedure TfmSetDBFLPA.FormCreate(Sender: TObject);
var s: string;
    y, k: integer;
begin
  with TFM_SelLetDBFL.Create(Application) do // Создание экземпляра формы.
    try
      //TestValue := InitialValue;     // Установка начального значения.
      ShowModal;      // Вывод формы на экран в модальном режиме.
      iZpLet:= fmMain.iZpLetal;
      //if ModalResult = mrOK then     // Если форма закрыта нажатием кнопки, подтверждающей изменения,
      //  iZpLet:= iZpLetal  //TestValue          // возвращаем изменённое значение.
      //else                           // Если форма закрыта любым другим способом, т.е. изменения отменены,
      //  iZpLet := 0; //InitialValue;      // возвращаем первоначальное значение.

    finally
      Free; // Уничтожение экземпляра формы и высвобождение ресурсов.

  end;
 if iZpLet <> -1 then begin
    s:= UTF8ToConsole(DM_S.sRabDir+ DM_S.namedbf[4]);
  if DbfOpen(1, s) <>0 then   Showmessage('Ошибка')
    else With DIAGPOSN do begin       //Showmessage(IntToStr(iZpLet)+'   '+s );
    R :=         Trim(DbfRead(1, iZpLet, 1));
    k:= 2;
    for y := 1 to 14 do begin
      LabeledEdits[y] := TLabeledEdit(FindComponent('LEdPShOsn' +IntToStr(y)));
      LabeledEdits[y].Text := ConsoleToUTF8(Trim(DbfRead(1, iZpLet, k)));
      k:= k+1;
    end;
    k:= 16;
    for y := 1 to 12 do begin
      LabeledEdits[y] := TLabeledEdit(FindComponent('LEdPDzOsn' +IntToStr(y)));
      LabeledEdits[y].Text := ConsoleToUTF8(Trim(DbfRead(1, iZpLet, k)));
      k:= k+1;
    end;
    k:= 28;
    for y := 1 to 8 do begin
      LabeledEdits[y] := TLabeledEdit(FindComponent('LEdPShFon' +IntToStr(y)));
      LabeledEdits[y].Text := ConsoleToUTF8(Trim(DbfRead(1, iZpLet, k)));
      k:= k+1;
    end;
    k:= 36;
    for y := 1 to 12 do begin
      LabeledEdits[y] := TLabeledEdit(FindComponent('LEdPDzFon' +IntToStr(y)));
      LabeledEdits[y].Text := ConsoleToUTF8(Trim(DbfRead(1, iZpLet, k)));
      k:= k+1;
    end;
    k:= 48;
    for y := 1 to 8 do begin
      LabeledEdits[y] := TLabeledEdit(FindComponent('LEdPShOsl' +IntToStr(y)));
      LabeledEdits[y].Text := ConsoleToUTF8(Trim(DbfRead(1, iZpLet, k)));
      k:= k+1;
    end;
    k:= 56;
    for y := 1 to 16 do begin
      LabeledEdits[y] := TLabeledEdit(FindComponent('LEdPDzOsl' +IntToStr(y)));
      LabeledEdits[y].Text := ConsoleToUTF8(Trim(DbfRead(1, iZpLet, k)));
      k:= k+1;
    end;
    k:= 72;
    for y := 1 to 8 do begin
      LabeledEdits[y] := TLabeledEdit(FindComponent('LEdPShSop' +IntToStr(y)));
      LabeledEdits[y].Text := ConsoleToUTF8(Trim(DbfRead(1, iZpLet, k)));
      k:= k+1;
    end;
    k:= 80;
    for y := 1 to 16 do begin
      LabeledEdits[y] := TLabeledEdit(FindComponent('LEdPDzSop' +IntToStr(y)));
      LabeledEdits[y].Text := ConsoleToUTF8(Trim(DbfRead(1, iZpLet, k)));
      k:= k+1;
    end;
  end;
   DbfClose(1);

  s:= UTF8ToConsole(DM_S.sRabDir+ DM_S.namedbf[5]);
  if DbfOpen(1, s) <>0 then   Showmessage('Ошибка')
    else With ZAKLUCHE do begin       //Showmessage(IntToStr(iZpLet)+'   '+s );
    R :=         Trim(DbfRead(1, iZpLet, 1));
    k:= 2;
    for y := 1 to 16 do begin
      LabeledEdits[y] := TLabeledEdit(FindComponent('LEdPAZAKL' +IntToStr(y)));
      LabeledEdits[y].Text := ConsoleToUTF8(Trim(DbfRead(1, iZpLet, k)));
      k:= k+1;
    end;    //Showmessage(ConsoleToUTF8(Trim(DbfRead(1, iZpLet, 18))));

    cbxPARasxDz.ItemIndex:= cbxPARasxDz.Items.IndexOf(ConsoleToUTF8(Trim(DbfRead(1, iZpLet, 18))));

    k:= 19;
    for y := 1 to 7 do begin
      LabeledEdits[y] := TLabeledEdit(FindComponent('ledPARSX_TIP' +IntToStr(y)));
      LabeledEdits[y].Text := ConsoleToUTF8(Trim(DbfRead(1, iZpLet, k)));
      k:= k+1;
    end;
    k:= 26;
    for y := 1 to 7 do begin
      LabeledEdits[y] := TLabeledEdit(FindComponent('ledPARSX_PRI' +IntToStr(y)));
      LabeledEdits[y].Text := ConsoleToUTF8(Trim(DbfRead(1, iZpLet, k)));
      k:= k+1;
    end;
   end;
   DbfClose(1);

  with dlgOpenPADate do begin
        Title  := 'Выбор файла (в кодировке Windows) с данными ПА исследования пац-та: '+fmMain.sFioLetal;
        Filter := 'Файл с данными ПА исследования *.txt|*.txt; *.doc|*.doc';
        InitiaLDir := DM_S.sLetTxtDir; //'e:\';
        if Execute then mmPADate.Lines.LoadFromFile(FileName);
        mmPADate.Lines.CommaText:= WinCPToUTF8(mmPADate.Lines.CommaText);
{TODO: Предусмотреть конвертацию WinCPToUTF8, UTF8ToWinCP, ConsoleToUTF8, UTF8ToConsole  }
  end;
 end;
end;

procedure TfmSetDBFLPA.FormClose(Sender: TObject; var CloseAction: TCloseAction
  );
var s: string;
    y, k: integer;
begin
 if iZpLet <> -1 then begin
  s:= UTF8ToConsole(DM_S.sRabDir+ DM_S.namedbf[4]);
  if DbfOpen(1, s) <>0 then   Showmessage('Ошибка')
    else With DIAGPOSN do begin       //Showmessage(IntToStr(iZpLet)+'   '+s );
   // R :=         Trim(DbfRead(1, iZpLet, 1));
    k:= 2;
    for y := 1 to 14 do begin
      LabeledEdits[y] := TLabeledEdit(FindComponent('LEdPShOsn' +IntToStr(y)));
      DbfWrite(1, UTF8ToConsole(LabeledEdits[y].Text),  iZpLet, k);
      k:= k+1;
    end;
    k:= 16;
    for y := 1 to 12 do begin
      LabeledEdits[y] := TLabeledEdit(FindComponent('LEdPDzOsn' +IntToStr(y)));
      DbfWrite(1, UTF8ToConsole(LabeledEdits[y].Text),  iZpLet, k);
      k:= k+1;
    end;
    k:= 28;
    for y := 1 to 8 do begin
      LabeledEdits[y] := TLabeledEdit(FindComponent('LEdPShFon' +IntToStr(y)));
      DbfWrite(1, UTF8ToConsole(LabeledEdits[y].Text),  iZpLet, k);
      k:= k+1;
    end;
    k:= 36;
    for y := 1 to 12 do begin
      LabeledEdits[y] := TLabeledEdit(FindComponent('LEdPDzFon' +IntToStr(y)));
      DbfWrite(1, UTF8ToConsole(LabeledEdits[y].Text),  iZpLet, k);
      k:= k+1;
    end;
    k:= 48;
    for y := 1 to 8 do begin
      LabeledEdits[y] := TLabeledEdit(FindComponent('LEdPShOsl' +IntToStr(y)));
      DbfWrite(1, UTF8ToConsole(LabeledEdits[y].Text),  iZpLet, k);
      k:= k+1;
    end;
    k:= 56;
    for y := 1 to 16 do begin
      LabeledEdits[y] := TLabeledEdit(FindComponent('LEdPDzOsl' +IntToStr(y)));
      DbfWrite(1, UTF8ToConsole(LabeledEdits[y].Text),  iZpLet, k);
      k:= k+1;
    end;
    k:= 72;
    for y := 1 to 8 do begin
      LabeledEdits[y] := TLabeledEdit(FindComponent('LEdPShSop' +IntToStr(y)));
      DbfWrite(1, UTF8ToConsole(LabeledEdits[y].Text),  iZpLet, k);
      k:= k+1;
    end;
    k:= 80;
    for y := 1 to 16 do begin
      LabeledEdits[y] := TLabeledEdit(FindComponent('LEdPDzSop' +IntToStr(y)));
      DbfWrite(1, UTF8ToConsole(LabeledEdits[y].Text),  iZpLet, k);
      k:= k+1;
    end;
  end;
   DbfClose(1);

     s:= UTF8ToConsole(DM_S.sRabDir+ DM_S.namedbf[5]);
  if DbfOpen(1, s) <>0 then   Showmessage('Ошибка')
    else With ZAKLUCHE do begin       //Showmessage(IntToStr(iZpLet)+'   '+s );
    //R :=         Trim(DbfRead(1, iZpLet, 1));
    k:= 2;
    for y := 1 to 16 do begin
      LabeledEdits[y] := TLabeledEdit(FindComponent('LEdPAZAKL' +IntToStr(y)));
      DbfWrite(1, UTF8ToConsole(LabeledEdits[y].Text),  iZpLet, k);
      k:= k+1;
    end;    //Showmessage(ConsoleToUTF8(Trim(DbfRead(1, iZpLet, 18))));

    DbfWrite(1, UTF8ToConsole(cbxPARasxDz.Items[cbxPARasxDz.ItemIndex]),  iZpLet, 18);

    //cbxPARasxDz.ItemIndex:= cbxPARasxDz.Items.IndexOf(ConsoleToUTF8(Trim(DbfRead(1, iZpLet, 18))));

    k:= 19;
    for y := 1 to 7 do begin
      LabeledEdits[y] := TLabeledEdit(FindComponent('ledPARSX_TIP' +IntToStr(y)));
      DbfWrite(1, UTF8ToConsole(LabeledEdits[y].Text),  iZpLet, k);
      k:= k+1;
    end;
    k:= 26;
    for y := 1 to 7 do begin
      LabeledEdits[y] := TLabeledEdit(FindComponent('ledPARSX_PRI' +IntToStr(y)));
      DbfWrite(1, UTF8ToConsole(LabeledEdits[y].Text),  iZpLet, k);
      k:= k+1;
    end;
   end;
   DbfClose(1);
 end;

end;

procedure TfmSetDBFLPA.FormActivate(Sender: TObject);
begin
   if iZpLet = -1 then close;
end;


end.

