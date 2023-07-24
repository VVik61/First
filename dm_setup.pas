{ **********************************************************************
 Модуль чтения различных переменных из *.ini-файла и
  КОПИРОВАНИЕ из директории DBF DOS-Эпикриза в рабочую дир-ю DBF_L
 Автор В.И.Воронов. 2023г
 **********************************************************************
}

unit DM_setup;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, IniPropStorage;

type

  { TDM_S }

  TDM_S = class(TDataModule)
    IniPS: TIniPropStorage;
    procedure DataModuleCreate(Sender: TObject);
    procedure IniPSRestoreProperties(Sender: TObject);
  private

  public
   var
    namedbf: array[1..23] of string;  {Массив с названиями *.DBF-файлов}
    TmpDSQL: array[1..40] of string;  {Массив для составления SQL-запросов при переносе из DOS-DBF}
    //TmpSQL: array[1..40] of string;  {Массив SQL-запросов к БД FB}
    sLepiDir, sRabDir, sSQLDir, sLetTxtDir, sShablon, sWDTemp, //sDatabaseName, sNAMEPROT
    sFilePathWDBF, sFilePathFullWDBF
     : String;
    //iPosPrB: integer;
  end;

var
  DM_S: TDM_S;

implementation

uses fileutil, Dialogs;

{$R *.lfm}

{ TDM_S }

procedure TDM_S.DataModuleCreate(Sender: TObject);
var
  i: integer;
begin
  //iPosPrB:=0;
 {$REGION 'Чтение из Ini-ф-ла'}
   With IniPS do begin
     IniFileName:= ExtractFilePath(ParamStr(0)) + ChangeFileExt( ExtractFileName(ParamStr(0)) ,'.ini');
     sLepiDir  := ReadString('sLepiDir', '');
     sRabDir   := ReadString('sRabDir', '');
     sSQLDir   := ReadString('sSQLDir', '');
     sLetTxtDir:= ReadString('DirLetalTxt', '');
     sShablon  := ReadString('DirShablon', '');
     sFilePathWDBF:= ReadString('sFilePathWDBF', '');
     sFilePathFullWDBF:= ReadString('sFilePathFullWDBF', '');
     sWDTemp:= ReadString('sWDTemp', '' );
     IniSection:= 'FDBF';
     for i:= 1 to 23 do namedbf[i]:=  ReadString(InttoStr(i), '');
     IniSection:= 'DOSTOSQL';
     for i:= 1 to 40 do TmpDSQL[i]:=  ReadString(InttoStr(i), '');

     //IniSection:= 'SQL_FB';
     //for i:= 1 to 23 do TmpSQL[i]:=  ReadString(InttoStr(i), '');

     //IniSection:= 'SQL_FB_TBSPR';
     //for i:= 1 to 101 do TmpSQLTSPR[i]:=  ReadString(InttoStr(i), '');
     //IniSection:= 'COSTY';  //[COSTY]
     //iCountDobZap := ReadInteger('iCountDobZap', 100);  //iCountDobZap=255
     //sVrach0 := ReadString('sVrach0',  ''); //ConsoleToUTF8('Марисов'));
     //sVrach1  := ReadString('sVrach1',  ''); //ConsoleToUTF8('Вевербрант'));
     //sVrach2  := ReadString('sVrach2',  ''); //ConsoleToUTF8('Гуц'));
     //sVrach3  := ReadString('sVrach3',  ''); //ConsoleToUTF8('Марисов'));
     //sZavORIT := ReadString('sZavORIT', ''); //ConsoleToUTF8('Нельсон'));

   end; {IniPS}    //Showmessage(namedbf[1]+#13+namedbf[11]+#13+namedbf[23]);
{$ENDREGION}

{$REGION 'КОПИРОВАНИЕ из директории DBF DOS-Эпикриза в рабочую дир-ю DBF_L'}
  try
  //With fmMain do begin
  for i:= 1 to 22 do CopyFile( sLepiDir+namedbf[i], sRabDir+ namedbf[i]);  //Showmessage(copy(sLepiDir,1, length(sLepiDir) -3)); // Pos('\dbf',sLepiDir)));
  CopyFile(copy(sLepiDir,1, length(sLepiDir)-4)+ namedbf[23], sRabDir+ namedbf[23], [cffOverwriteFile]);
  //end;
  except on Exception do begin    //LblCopy.Caption:= 'NO';    //LblCopy.Color:= clRed;    //LblCopy.Visible:= true;
    Showmessage('Ошибка копирования *.DBF в рабочую директорию!'+#13+
       'Программа будет закрыта.');
    HALT;
    end;
  end;
{$ENDREGION}
end;

procedure TDM_S.IniPSRestoreProperties(Sender: TObject);
begin

end;


end.

