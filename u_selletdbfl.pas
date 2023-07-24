{**********************************************************************
 Форма выборки пациентов с летальными исходами из DBF-файлов измененного формата DBFIII,
 где в описании поля вставлены имена DBF-файлов-справочников для этого поля,
 используемых в DOS-Эпикризе. Используется в форме FM_SetPAinDBFL.
 Автор В.И.Воронов 2023г
 **********************************************************************
}

unit u_SelLetDBFL;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, CheckLst, ExtCtrls;

type

  { TFM_SelLetDBFL }

  TFM_SelLetDBFL = class(TForm)
    CbxFioLetal: TCheckListBox;
    Panel1: TPanel;
    procedure CbxFioLetalDblClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
  private
  public
     //iZpLetal: longint; {Номер текущей записи умершего}
     //sFioLetal: string;
  end;

var
  FM_SelLetDBFL: TFM_SelLetDBFL;

implementation

uses DM_setup, LazUTF8, Dbf3,  u_main;

{$R *.lfm}

{ TFM_SelLetDBFL }

procedure TFM_SelLetDBFL.FormCreate(Sender: TObject);
var
   i: integer;
   fmt: string;
begin
  fmMain.iZpLetal := -1;
  fmMain.sFioLetal := '';
  CbxFioLetal.Items.Clear;
  //fmt:= '%0:-10s  %1:-42s %2:-4s  с %3:-12s по  %4:-12s';   {s:=Format(fmt,['This is a string']);Writeln(fmt:12,'=> ',s);}
  fmt:= '%0:-3s %1:-10s  %2:-42s %3:-4s  %4:-12s дата смерти-  %5:-12s';
 try
  With DM_S do begin   //Showmessage( sRabDir+ 'register.dbf');

  if DbfOpen(1, UTF8ToConsole(sRabDir+ 'register.dbf')) <>0 then begin Showmessage('Ошибка')
  end
  else begin
    for i := 1 to Nzap[1] do begin

      if (UTF8Trim(ConsoleToUTF8(DbfRead(1,i,5))) <> '*')
        and ((UTF8Trim(ConsoleToUTF8(DbfRead(1,i,12))) = 'УМЕР') or
            (UTF8Trim(ConsoleToUTF8(DbfRead(1,i,12))) = 'УМЕРЛА'))
      then begin

       CbxFioLetal.Items.Append(Format(fmt,
        [IntToStr(i), ConsoleToUTF8(DbfRead(1,i,1)), ConsoleToUTF8(DbfRead(1,i,5)),
         ConsoleToUTF8(DbfRead(1,i,6)),
         ConsoleToUTF8(DbfRead(1,i,8))+'.'+ConsoleToUTF8(DbfRead(1,i,9))+'.'+
         ConsoleToUTF8(DbfRead(1,i,10)),
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

procedure TFM_SelLetDBFL.CbxFioLetalDblClick(Sender: TObject);
begin
   fmMain.iZpLetal := StrToInt(Trim(copy(CbxFioLetal.Items[CbxFioLetal.Itemindex],1,3))); //CbxFioLetal.Itemindex+1;
   fmMain.sFioLetal := Trim(copy(CbxFioLetal.Items[CbxFioLetal.Itemindex],17, 75));
    //Showmessage(sFioLetal);
   //fmMain.iZp:= StrToInt(Trim(copy(CbxFioLetal.Items[CbxFioLetal.Itemindex],1,3))); //CbxFioLetal.Itemindex+1;
   //fmMain.sTekReg:= CbxFioLetal.Items[CbxFioLetal.Itemindex];
   //Showmessage('Выбрана строка= '+ IntToStr(iZpLetal)); // fmMain.sTekReg); //IntToStr(CbxFioLetal.Itemindex+1));
   //ModalResult := mrOK;
   close;
end;

procedure TFM_SelLetDBFL.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := MessageDlg( 'Выбран '+#13+fmMain.sFioLetal+#13+' Верно?', mtInformation, mbYesNo, 0) = mrYes;
end;


end.

