{ **********************************************************************
 Модуль данных для работы с FBird-файлами.
 Для работы с Эпикризе.
 Автор В.И.Воронов. 2023г
 **********************************************************************
}

unit DM_FB;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, LazUTF8, Dialogs, ExtCtrls, IBDatabase,
  IBCustomDataSet;

type

  { TD_FB }

  TD_FB = class(TDataModule)
    IBDS_RAB: TIBDataSet;
    IBDS: TIBDataSet;
    IBDB: TIBDatabase;
    IBTrAct: TIBTransaction;
    IBTrActDS: TIBTransaction;
    dlgOpenBD: TOpenDialog;
    IBTrActDS_RAB: TIBTransaction;
    TrayIcon1: TTrayIcon;
    procedure DataModuleCreate(Sender: TObject);
    function SelID(sSQL, CodID, varID: string): string;  {Получение ID(в виде ЧИСЛА как строки, т.е. ID ='1') из справочника }
    function SelIDPats(const sF, sG, siIm, siOt: string): string;
    procedure TrayIcon1Click(Sender: TObject);
  private

  public

  end;

var
  D_FB: TD_FB;

implementation

uses forms, DM_setup; // u_main;

{$R *.lfm}

{ TD_FB }

procedure TD_FB.DataModuleCreate(Sender: TObject);
begin
  With IBDB, DM_S do begin
     DatabaseName := sDatabaseName;
     FirebirdLibraryPathName:=  sFBCLPath;


(*
  With IBDB, DM_S.IniPS do begin
    IniSection:= 'Directory';
    DatabaseName:= ConsoleToUTF8(ReadString('sDatabaseName', ''));
    FirebirdLibraryPathName:= ConsoleToUTF8(ReadString('FBCLPath', ''));    //Showmessage(IBDB.DatabaseName+#13+ FirebirdLibraryPathName);
     { ЗДЕСЬ ДИАЛОГ выбора БД и FB_библиотеки_FBклиентаDLL}
      if Length(Trim(DatabaseName)) = 0  then
         begin
           with dlgOpenBD do
            begin
              Filter := 'Файл БД Firebird *.fdb|*.fdb';
              InitiaLDir := ReadString('DirDB', 'E:\');
              if Execute then DatabaseName := FileName;
            end;
         end;
       if Length(Trim(FirebirdLibraryPathName)) = 0  then
         begin
           with dlgOpenBD do
            begin
              Filter := 'Файл клиенской библитеки для Firebird *.dll|*.dll';
              //InitiaLDir := '';
              InitiaLDir := ReadString('DirClienFB', 'C:\');
              if Execute then FirebirdLibraryPathName := FileName;
            end;
         end;
 *)
    try
      Connected:= True;
    except on E: Exception do begin
      Application .MessageBox(PChar('Не могу открыть БД! Программы будет закрыта.'), 'ВНИМАНИЕ', 0); // MB_OK); // ShowMessage('Не могу открыть БД! Программы будет закрыта.');
      Application.Terminate;
     end;
    end;
  end;
  //SelID('select codimia from sl_imia where imia = ', 'codimia', 'Антон');
end;

function TD_FB.SelID(sSQL, CodID, varID: string): string;
begin
  result := '!';
  IBDS.SelectSQL.Text:= UTF8ToWinCP(sSQL+''''+varID+''';');  //Showmessage(WinCPToUTF8(IBDS.SelectSQL.Text));
  try
   IBTrActDS.Active:= true;
   IBDS.Open;
   result := IntToStr(IBDS.FieldByName('' +CodID+ '').AsInteger);   //Showmessage(result);
  except
  end;
  IBDS.Close;
  IBTrActDS.Active:= false;
end;

function TD_FB.SelIDPats(const sF, sG, siIm, siOt: string): string;
var
  sSQL: string;
begin
  result := '!';
  sSQL:= 'select codpats from S_PATS where fam = '''+ConsoletoUTF8(sF)+ ''' and god_rgd = '+ sG+' and idim = '+ siIm+ ' and idoth = '+siOt+' ;';   //Showmessage('sSQL= '+ WinCPToUTF8(sSQL));
  IBDS.SelectSQL.Text:= UTF8ToWinCP(sSQL);  //Showmessage(WinCPToUTF8(IBDS.SelectSQL.Text));
  try
   IBTrActDS.Active:= true;
   IBDS.Open;
   result := IntToStr(IBDS.FieldByName('codpats').AsInteger);   //Showmessage(result);
  except
  end;
  IBDS.Close;
  IBTrActDS.Active:= false;
end;

procedure TD_FB.TrayIcon1Click(Sender: TObject);
begin

end;

end.

