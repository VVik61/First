unit Un_setup;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, IniPropStorage;

implementation


begin

{$REGION 'Чтение из Ini-ф-ла'}
  with TIniPropStorage.Create(self) do begin //File.Create(ExtractFilePath(ParamStr(0))+'q.ini') do begin
   //With IniPS do begin
     IniFileName:= ExtractFilePath(ParamStr(0)) + ChangeFileExt( ExtractFileName(ParamStr(0)) ,'.ini');
     sLepiDir  := ReadString('sLepiDir', '');
     sRabDir   := ReadString('sRabDir', '');
     sSQLDir   := ReadString('sSQLDir', '');
     IniSection:= 'FDBF';
     for i:= 1 to 23 do namedbf[i]:=  ReadString(InttoStr(i), '');
     IniSection:= 'DOSTOSQL';
     for i:= 1 to 18 do TmpDSQL[i]:=  ReadString(InttoStr(i), '');

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
  for i:= 1 to 22 do CopyFile(sLepiDir+namedbf[i], sRabDir+ namedbf[i]);  //Showmessage(copy(sLepiDir,1, length(sLepiDir) -3)); // Pos('\dbf',sLepiDir)));
  CopyFile(copy(sLepiDir,1, length(sLepiDir)-4)+ namedbf[23], sRabDir+ namedbf[23], [cffOverwriteFile]);
  except on Exception do begin    //LblCopy.Caption:= 'NO';    //LblCopy.Color:= clRed;    //LblCopy.Visible:= true;
    Showmessage('Ошибка копирования *.DBF в рабочую директорию!'+#13+
       'Программа будет закрыта.');
    HALT;
    end;
  end;
{$ENDREGION}  //OpenRegister; //SetZvezInDBFLin(1); -проверка работы  SetZvezInDBFLin - запись в 1-е поле Reg, в остальные поля звездочек *
end;




end.

