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
  private

  public
   var
    namedbf: array[1..23] of string;  {Массив с названиями *.DBF-файлов}
    TmpDSQL: array[1..40] of string;  {Массив для составления SQL-запросов при переносе из DOS-DBF}
    //TmpSQL: array[1..40] of string;  {Массив SQL-запросов к БД FB}
    sLepiDir, sRabDir, sSQLDir, sLetTxtDir, sShablon, sWDTemp,  
    sLepiWinDir, sFilePathFULLWDBF, sRabDirWDBF,
    sDatabaseName, sFBCLPath
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
  L : TStringList;
  s : string;
begin
{$REGION 'Чтение из Ini-ф-ла'}
   With IniPS do begin
     IniFileName:= ExtractFilePath(ParamStr(0)) + ChangeFileExt( ExtractFileName(ParamStr(0)) ,'.ini');
     sLepiDir  := ReadString('sLepiDir', ''); {c:\Lepi\DBF\}
     sRabDir   := ReadString('sRabDir', '');  {e:\E:\DbftosqlFB\DBF_L\}
     sLepiWinDir := ReadString('sLepiWinDir', ''); {дома =D:\Epi_win\Baza\DBF\   в ОРИТ= E:\Epi_win\Baza\DBF\}       //Showmessage('sLepiWinDir= '+sLepiWinDir);
     sRabDirWDBF := ReadString('sRabDirWDBF', ''); {E:\DbftosqlFB\SQL_W\}
     sSQLDir   := ReadString('sSQLDir', '');  {E:\DbftosqlFB\SQL_L\}
     sLetTxtDir:= ReadString('DirLetalTxt', ''); {E:\DbftosqlFB\Let_txt\}
     sShablon  := ReadString('DirShablon', '');  {E:\DbftosqlFB\Templates\}
     sFilePathFULLWDBF:= ReadString('sFilePathFULLWDBF', '');     //sFilePathFullWDBF:= ReadString('sFilePathFullWDBF', '');     Showmessage('sFilePathFULLWDBF= '+ sFilePathFULLWDBF);
     sDatabaseName:= ReadString('sDatabaseName', '');
     sFBCLPath:=ReadString('sFBCLPath', '');

     sWDTemp:= ReadString('sWDTemp', '' );
     IniSection:= 'FDBF';
     for i:= 1 to 23 do namedbf[i]:=  ReadString(InttoStr(i), '');
     IniSection:= 'DOSTOSQL';
     for i:= 1 to 40 do TmpDSQL[i]:=  ReadString(InttoStr(i), '');
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

{$REGION 'Копирование из директории DBF Win-Эпикриза в рабочую дир-ю DBF_W''}
  L := TStringList.Create;
  try
    FindAllFiles(L, sLepiWinDir, '*.*', False); // True, если нужно искать и во всех подпапках
    for s in L do CopyFile( s, sRabDirWDBF+ExtractFileName(s));     //Showmessage(sFilePathWDBF+ExtractFileName(s));
  finally
   L.Free;
  end;
{$ENDREGION}
end;

end.

