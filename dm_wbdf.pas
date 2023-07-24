{
 **********************************************************************
 Модуль для переноса данных из структуры DBF-файлов измененного формата DBFIII,
 где в описании поля вставлены имена DBF-файлов-справочников для этого поля,
 используемых в DOS-Эпикризе. (И.Н.Лозинский. 2001г?)
 в DBF-файлы, используемые в Win-версии эпикриза.
 Автор В.И.Воронов 2023г
 **********************************************************************
}

unit dm_wbdf;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, dbf, LazUTF8, un_structura;

type

  { Tdm_wdbf }

  Tdm_wdbf = class(TDataModule)
    Dbf_Register: TDbf;
    Dbf_PEREMENA: TDbf;
    Dbf_ANAL_GIR: TDbf;
    Dbf_ANAL_KRV: TDbf;
    Dbf_ANAL_MCH: TDbf;
    Dbf_ANAL_LUM: TDbf;
    Dbf_ANAL_SVI: TDbf;
    Dbf_ANAL_KON: TDbf;
    Dbf_LEKA_MED: TDbf;
    Dbf_LEKA_NMD: TDbf;
    Dbf_LEKA_XIR: TDbf;
    Dbf_LEKA_REZ: TDbf;
    Dbf_DIAGKOSN: TDbf;
    Dbf_RECOMEND: TDbf;
    Dbf_COMMENT: TDbf;
    Dbf_DIAGPOSN: TDbf;
    Dbf_ZAKLUCHE: TDbf;
    Dbf_ANAM_GZN: TDbf;
    Dbf_ANAM_ZBL: TDbf;
    Dbf_PSIXISOS: TDbf;
    Dbf_SOMATSOS: TDbf;
    Dbf_NEVROSOS: TDbf;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);

  private

  public
   procedure Cin_Register(S: String); {s= номер записи =Register, куда переносятся данные}
   procedure Cin_PEREMENA(S: String);
   procedure Cin_DIAGKOSN(S: String);
   procedure Cin_DIAGPOSN(S: String);
   procedure Cin_ZAKLUCHE(S: String);
   procedure Cin_ANAM_GZN(S: String);
   procedure Cin_ANAM_ZBL(S: String);
   procedure Cin_PSIXISOSfDBF(S: String);
   procedure Cin_SOMATSOSfDBF(S: String);
   procedure Cin_NEVROSOSfDBF(S: String);
   procedure Cin_ANAL_GIRfDBF(S: String);
   procedure Cin_ANAL_KRVfDBF(S: String);
   procedure Cin_ANAL_MCHfDBF(S: String);
   procedure Cin_ANAL_LUMfDBF(S: String);
   procedure Cin_ANAL_SVIfDBF(S: String);
   procedure Cin_ANAL_KONfDBF(S: String);
   procedure Cin_LEKA_MEDfDBF(S: String);
   procedure Cin_LEKA_NMDfDBF(S: String);
   procedure Cin_LEKA_XIRfDBF(S: String);
   procedure Cin_LEKA_REZfDBF(S: String);
   procedure Cin_RECOMENDfDBF(S: String);
   procedure Cin_COMMENTfDBF(S: String);
  end;

var
  dm_wdbf: Tdm_wdbf;

implementation

uses forms, Dialogs, DM_setup;

{$R *.lfm}

{ Tdm_wdbf }



procedure Tdm_wdbf.DataModuleCreate(Sender: TObject);
begin
 Dbf_Register.FilePathFull:= UTF8ToConsole(DM_S.sFilePathFullWDBF);
 //Showmessage(UTF8ToConsole(DM_S.sFilePathFullWDBF));
 //Showmessage(UTF8ToConsole(DM_S.sFilePathWDBF));
 Dbf_Register.FilePath:=     UTF8ToConsole(DM_S.sFilePathWDBF);
 Dbf_PEREMENA.FilePathFull:= UTF8ToConsole(DM_S.sFilePathFullWDBF);
 Dbf_PEREMENA.FilePath:=     UTF8ToConsole(DM_S.sFilePathWDBF);
 Dbf_ANAL_GIR.FilePathFull:= UTF8ToConsole(DM_S.sFilePathFullWDBF);
 Dbf_ANAL_GIR.FilePath:=     UTF8ToConsole(DM_S.sFilePathWDBF);
 Dbf_ANAL_KRV.FilePathFull:= UTF8ToConsole(DM_S.sFilePathFullWDBF);
 Dbf_ANAL_KRV.FilePath:=     UTF8ToConsole(DM_S.sFilePathWDBF);
 Dbf_ANAL_MCH.FilePathFull:= UTF8ToConsole(DM_S.sFilePathFullWDBF);
 Dbf_ANAL_MCH.FilePath:=     UTF8ToConsole(DM_S.sFilePathWDBF);
 Dbf_ANAL_LUM.FilePathFull:= UTF8ToConsole(DM_S.sFilePathFullWDBF);
 Dbf_ANAL_LUM.FilePath:=     UTF8ToConsole(DM_S.sFilePathWDBF);
 Dbf_ANAL_SVI.FilePathFull:= UTF8ToConsole(DM_S.sFilePathFullWDBF);
 Dbf_ANAL_SVI.FilePath:=     UTF8ToConsole(DM_S.sFilePathWDBF);
 Dbf_ANAL_KON.FilePathFull:= UTF8ToConsole(DM_S.sFilePathFullWDBF);
 Dbf_ANAL_KON.FilePath:=     UTF8ToConsole(DM_S.sFilePathWDBF);
 Dbf_LEKA_MED.FilePathFull:= UTF8ToConsole(DM_S.sFilePathFullWDBF);
 Dbf_LEKA_MED.FilePath:=     UTF8ToConsole(DM_S.sFilePathWDBF);
 Dbf_LEKA_NMD.FilePathFull:= UTF8ToConsole(DM_S.sFilePathFullWDBF);
 Dbf_LEKA_NMD.FilePath:=     UTF8ToConsole(DM_S.sFilePathWDBF);
 Dbf_LEKA_XIR.FilePathFull:= UTF8ToConsole(DM_S.sFilePathFullWDBF);
 Dbf_LEKA_XIR.FilePath:=     UTF8ToConsole(DM_S.sFilePathWDBF);
 Dbf_LEKA_REZ.FilePathFull:= UTF8ToConsole(DM_S.sFilePathFullWDBF);
 Dbf_LEKA_REZ.FilePath:=     UTF8ToConsole(DM_S.sFilePathWDBF);
 Dbf_DIAGKOSN.FilePathFull:= UTF8ToConsole(DM_S.sFilePathFullWDBF);
 Dbf_DIAGKOSN.FilePath:=     UTF8ToConsole(DM_S.sFilePathWDBF);
 Dbf_RECOMEND.FilePathFull:= UTF8ToConsole(DM_S.sFilePathFullWDBF);
 Dbf_RECOMEND.FilePath:=     UTF8ToConsole(DM_S.sFilePathWDBF);
  Dbf_COMMENT.FilePathFull:= UTF8ToConsole(DM_S.sFilePathFullWDBF);
  Dbf_COMMENT.FilePath:=     UTF8ToConsole(DM_S.sFilePathWDBF);
 Dbf_DIAGPOSN.FilePathFull:= UTF8ToConsole(DM_S.sFilePathFullWDBF);
 Dbf_DIAGPOSN.FilePath:=     UTF8ToConsole(DM_S.sFilePathWDBF);
 Dbf_ZAKLUCHE.FilePathFull:= UTF8ToConsole(DM_S.sFilePathFullWDBF);
 Dbf_ZAKLUCHE.FilePath:=     UTF8ToConsole(DM_S.sFilePathWDBF);
 Dbf_ANAM_GZN.FilePathFull:= UTF8ToConsole(DM_S.sFilePathFullWDBF);
 Dbf_ANAM_GZN.FilePath:=     UTF8ToConsole(DM_S.sFilePathWDBF);
 Dbf_ANAM_ZBL.FilePathFull:= UTF8ToConsole(DM_S.sFilePathFullWDBF);
 Dbf_ANAM_ZBL.FilePath:=     UTF8ToConsole(DM_S.sFilePathWDBF);
 Dbf_PSIXISOS.FilePathFull:= UTF8ToConsole(DM_S.sFilePathFullWDBF);
 Dbf_PSIXISOS.FilePath:=     UTF8ToConsole(DM_S.sFilePathWDBF);
 Dbf_SOMATSOS.FilePathFull:= UTF8ToConsole(DM_S.sFilePathFullWDBF);
 Dbf_SOMATSOS.FilePath:=     UTF8ToConsole(DM_S.sFilePathWDBF);
 Dbf_NEVROSOS.FilePathFull:= UTF8ToConsole(DM_S.sFilePathFullWDBF);
 Dbf_NEVROSOS.FilePath:=     UTF8ToConsole(DM_S.sFilePathWDBF);
 try
  Dbf_Register.Open;
  Dbf_PEREMENA.Open;
  Dbf_ANAL_GIR.Open;
  Dbf_ANAL_KRV.Open;
  Dbf_ANAL_MCH.Open;
  Dbf_ANAL_LUM.Open;
  Dbf_ANAL_SVI.Open;
  Dbf_ANAL_KON.Open;
  Dbf_LEKA_MED.Open;
  Dbf_LEKA_NMD.Open;
  Dbf_LEKA_XIR.Open;
  Dbf_LEKA_REZ.Open;
  Dbf_DIAGKOSN.Open;
  Dbf_RECOMEND.Open;
   Dbf_COMMENT.Open;
  Dbf_DIAGPOSN.Open;
  Dbf_ZAKLUCHE.Open;
  Dbf_ANAM_GZN.Open;
  Dbf_ANAM_ZBL.Open;
  Dbf_PSIXISOS.Open;
  Dbf_SOMATSOS.Open;
  Dbf_NEVROSOS.Open;
 except  On  E: Exception do  begin
    Application .MessageBox(PChar('Не могу открыть БД! Программы будет закрыта.'), 'ВНИМАНИЕ', 0);
    Application.Terminate;
  end;
 end;
end;

procedure Tdm_wdbf.DataModuleDestroy(Sender: TObject);
begin
  try
 Dbf_Register.Close;
 Dbf_PEREMENA.Close;
 Dbf_ANAL_GIR.Close;
 Dbf_ANAL_KRV.Close;
 Dbf_ANAL_MCH.Close;
 Dbf_ANAL_LUM.Close;
 Dbf_ANAL_SVI.Close;
 Dbf_ANAL_KON.Close;
 Dbf_LEKA_MED.Close;
 Dbf_LEKA_NMD.Close;
 Dbf_LEKA_XIR.Close;
 Dbf_LEKA_REZ.Close;
 Dbf_DIAGKOSN.Close;
 Dbf_RECOMEND.Close;
 Dbf_COMMENT.Close;
 Dbf_DIAGPOSN.Close;
 Dbf_ZAKLUCHE.Close;
 Dbf_ANAM_GZN.Close;
 Dbf_ANAM_ZBL.Close;
 Dbf_PSIXISOS.Close;
 Dbf_SOMATSOS.Close;
 Dbf_NEVROSOS.Close;
 except
 end;
end;

procedure Tdm_wdbf.Cin_Register(S: String);
begin
  With REGIS, Dbf_Register do begin     //if  Dbf_Register.Locate('RKO', REGIS.r,[]) then  Dbf_Register.Edit
   try
   if  Locate('RKO', S,[]) then  Edit else Append;
     FieldByName('RKO').AsString:= r;
     FieldByName('LPU').AsString:= sLUCH;
     FieldByName('DOK_V').AsString:= sDOC;
     FieldByName('DOK_N').AsString:= sD_NOMER;
     FieldByName('FIO').AsString:= sFIO;
     FieldByName('GOD').AsInteger:= StrToInt(n4DATA_G);
     FieldByName('POL').AsString:= sPol;
     FieldByName('POST_D').AsInteger:= StrToInt(n2PostChislo);
     FieldByName('POST_M').AsInteger:= StrToInt(n2PostMes);
     FieldByName('POST_G').AsInteger:= StrToInt(n4PostGod);
     FieldByName('OTKUDA').AsString:= sPOST;
     FieldByName('VIBL_S').AsString:= sVIBIV;
     FieldByName('VIBL_D').AsInteger:= StrToInt(n2VipisChislo);
     FieldByName('VIBL_M').AsInteger:= StrToInt(n2VipisMes);
     FieldByName('VIBL_G').AsInteger:= StrToInt(n4VipisGod);
     FieldByName('KUDA').AsString:= sKuda1+ ' '+sKuda2;
     FieldByName('ISXOD').AsString:= sIsxod;

     try
      if (Length(Trim(n5DlitOtd)) = 0) or (n5DlitOtd = '*') then FieldByName('DLIT_OTD').AsInteger:= 0
       else FieldByName('DLIT_OTD').AsInteger:= StrToInt(n5DlitOtd);
      except On  E: Exception do FieldByName('DLIT_OTD').AsInteger:= 0;
     end;//FieldByName('DLIT_OTD').AsInteger:= StrToInt(n5DlitOtd);
     try
       if (Length(Trim(n2PostBChislo)) = 0) or (n2PostBChislo = '*') then FieldByName('POSTLPU_D').AsInteger:= 0
        else FieldByName('POSTLPU_D').AsInteger:= StrToInt(n2PostBChislo);
       except On  E: Exception do FieldByName('POSTLPU_D').AsInteger:= 0;
      end; //FieldByName('POSTLPU_D').AsInteger:= StrToInt(n2PostBChislo);
     try
       if (Length(Trim(n2PostBMes)) = 0) or (n2PostBMes = '*') then FieldByName('POSTLPU_M').AsInteger:= 0
        else FieldByName('POSTLPU_M').AsInteger:= StrToInt(n2PostBMes);
       except On  E: Exception do FieldByName('POSTLPU_M').AsInteger:= 0;
      end; //FieldByName('POSTLPU_M').AsInteger:= StrToInt(n2PostBMes);
     try
       if (Length(Trim(n4PostBGod)) = 0) or (n4PostBGod = '*') then FieldByName('POSTLPU_G').AsInteger:= 0
        else FieldByName('POSTLPU_G').AsInteger:= StrToInt(n4PostBGod);
       except On  E: Exception do FieldByName('POSTLPU_G').AsInteger:= 0;
      end; //FieldByName('POSTLPU_G').AsInteger:= StrToInt(n4PostBGod);
     try
       if (Length(Trim(n5DlitObsh)) = 0) or (n5DlitObsh = '*') then FieldByName('DLIT_LPU').AsInteger:= 0
        else FieldByName('DLIT_LPU').AsInteger:= StrToInt(n5DlitObsh);
       except On  E: Exception do FieldByName('DLIT_LPU').AsInteger:= 0;
      end; //FieldByName('DLIT_LPU').AsInteger:= StrToInt(n5DlitObsh);
     Post;
  except  On  E: Exception do Showmessage('ошибка с Dbf_Register');
  end;
 end;
end;

procedure Tdm_wdbf.Cin_PEREMENA(S: String);
begin
    With PEREMENA, Dbf_PEREMENA do begin
   try
   if  Locate('RKO', S,[]) then  Edit else Append;
     FieldByName('RKO').AsString:= r;
     FieldByName('ADRES_S').AsString:= sAdrStran;
     FieldByName('ADRES_R').AsString:= sAdrRegion;
     FieldByName('ADRES_P').AsString:= sAdrPunkt+' '+sAdrMGit;
     FieldByName('MESTO_R').AsString:= sRabota;
     try
      if (Length(Trim(n1Invalid)) = 0) or (n1Invalid = '*') then FieldByName('INVAL_G').AsInteger:= 0
       else FieldByName('INVAL_G').AsInteger:= StrToInt(n1Invalid);
      except On  E: Exception do FieldByName('INVAL_G').AsInteger:= 0;
     end;
     FieldByName('INVAL_T').AsString:= sInvalidTip;
     FieldByName('INVAL_V').AsString:= sInvalidVid;
     FieldByName('RODST_S01').AsString:= arRodstv[1].sRODs;
     FieldByName('RODST_F01').AsString:= arRodstv[1].sRODsFIO;
     FieldByName('RODST_A01').AsString:= arRodstv[1].sRODsADR;
     FieldByName('RODST_S02').AsString:= arRodstv[2].sRODs;
     FieldByName('RODST_F02').AsString:= arRodstv[2].sRODsFIO;
     FieldByName('RODST_A02').AsString:= arRodstv[2].sRODsADR;
     Post;
   except  On  E: Exception do Showmessage('ошибка с Dbf_PEREMENA');
   end;
  end;
end;

procedure Tdm_wdbf.Cin_DIAGKOSN(S: String);
begin
  With DIAGKOSN, Dbf_DIAGKOSN do begin
   try
    if  Locate('RKO', S,[]) then  Edit else Append;
    FieldByName('RKO').AsString:= r;
    FieldByName('SHFR_ESZ01').AsString:= arShE[1];
    FieldByName('SHFR_ESZ02').AsString:= arShE[2];
    FieldByName('SHFR_ESZ03').AsString:= arShE[3];
    FieldByName('SHFR_ESZ04').AsString:= arShE[4];
    FieldByName('SHFR_ESZ05').AsString:= arShE[5];
    FieldByName('SHFR_ESZ06').AsString:= arShE[6];
    FieldByName('SHFR_PAZ01').AsString:= arShA[1];
    FieldByName('SHFR_PAZ02').AsString:= arShA[2];
    FieldByName('SHFR_PAZ03').AsString:= arShA[3];
    FieldByName('SHFR_PAZ04').AsString:= arShA[4];
    FieldByName('SHFR_PAZ05').AsString:= arShA[5];
    FieldByName('SHFR_PAZ06').AsString:= arShA[6];
    FieldByName('DIAG_OSN01').AsString:= arDzOsn[1];
    FieldByName('DIAG_OSN02').AsString:= arDzOsn[2];
    FieldByName('DIAG_OSN03').AsString:= arDzOsn[3];
    FieldByName('DIAG_OSN04').AsString:= arDzOsn[4];
    FieldByName('DIAG_OSN05').AsString:= arDzOsn[5];
    FieldByName('DIAG_OSN06').AsString:= arDzOsn[6];
    FieldByName('DIAG_OSN07').AsString:= arDzOsn[7];
    FieldByName('DIAG_OSN08').AsString:= arDzOsn[8];
    FieldByName('DIAG_OSN09').AsString:= arDzOsn[9];
    FieldByName('DIAG_OSN10').AsString:= arDzOsn[10];
    FieldByName('DIAG_OSN11').AsString:= arDzOsn[11];
    FieldByName('DIAG_OSN12').AsString:= arDzOsn[12];
    FieldByName('DIAG_FON01').AsString:= arDzFon[1];
    FieldByName('DIAG_FON02').AsString:= arDzFon[2];
    FieldByName('DIAG_FON03').AsString:= arDzFon[3];
    FieldByName('DIAG_FON04').AsString:= arDzFon[4];
    FieldByName('DIAG_FON05').AsString:= arDzFon[5];
    FieldByName('DIAG_FON06').AsString:= arDzFon[6];
    FieldByName('DIAG_FON07').AsString:= arDzFon[7];
    FieldByName('DIAG_FON08').AsString:= arDzFon[8];
    FieldByName('DIAG_FON09').AsString:= arDzFon[9];
    FieldByName('DIAG_FON10').AsString:= arDzFon[10];
    FieldByName('DIAG_FON11').AsString:= arDzFon[11];
    FieldByName('DIAG_FON12').AsString:= arDzFon[12];
    FieldByName('DIAG_OSL01').AsString:= arDzOsl[1];
    FieldByName('DIAG_OSL02').AsString:= arDzOsl[2];
    FieldByName('DIAG_OSL03').AsString:= arDzOsl[3];
    FieldByName('DIAG_OSL04').AsString:= arDzOsl[4];
    FieldByName('DIAG_OSL05').AsString:= arDzOsl[5];
    FieldByName('DIAG_OSL06').AsString:= arDzOsl[6];
    FieldByName('DIAG_OSL07').AsString:= arDzOsl[7];
    FieldByName('DIAG_OSL08').AsString:= arDzOsl[8];
    FieldByName('DIAG_OSL09').AsString:= arDzOsl[9];
    FieldByName('DIAG_OSL10').AsString:= arDzOsl[10];
    FieldByName('DIAG_OSL11').AsString:= arDzOsl[11];
    FieldByName('DIAG_OSL12').AsString:= arDzOsl[12];
    FieldByName('DIAG_OSL13').AsString:= arDzOsl[13];
    FieldByName('DIAG_OSL14').AsString:= arDzOsl[14];
    FieldByName('DIAG_OSL15').AsString:= arDzOsl[15];
    FieldByName('DIAG_OSL16').AsString:= arDzOsl[16];
    FieldByName('DIAG_OSL17').AsString:= arDzOsl[17];
    FieldByName('DIAG_OSL18').AsString:= arDzOsl[18];
    FieldByName('DIAG_OSL19').AsString:= arDzOsl[19];
    FieldByName('DIAG_OSL20').AsString:= arDzOsl[20];
    FieldByName('DIAG_OSL21').AsString:= arDzOsl[21];
    FieldByName('DIAG_OSL22').AsString:= arDzOsl[22];
    FieldByName('DIAG_OSL23').AsString:= arDzOsl[23];
    FieldByName('DIAG_OSL24').AsString:= arDzOsl[24];
    FieldByName('DIAG_OSL25').AsString:= arDzOsl[25];
    FieldByName('DIAG_OSL26').AsString:= arDzOsl[26];
    FieldByName('DIAG_SOP01').AsString:= arDzSop[1];
    FieldByName('DIAG_SOP02').AsString:= arDzSop[2];
    FieldByName('DIAG_SOP03').AsString:= arDzSop[3];
    FieldByName('DIAG_SOP04').AsString:= arDzSop[4];
    FieldByName('DIAG_SOP05').AsString:= arDzSop[5];
    FieldByName('DIAG_SOP06').AsString:= arDzSop[6];
    FieldByName('DIAG_SOP07').AsString:= arDzSop[7];
    FieldByName('DIAG_SOP08').AsString:= arDzSop[8];
    FieldByName('DIAG_SOP09').AsString:= arDzSop[9];
    FieldByName('DIAG_SOP10').AsString:= arDzSop[10];
    FieldByName('DIAG_SOP11').AsString:= arDzSop[11];
    FieldByName('DIAG_SOP12').AsString:= arDzSop[12];
    FieldByName('DIAG_SOP13').AsString:= arDzSop[13];
    FieldByName('DIAG_SOP14').AsString:= arDzSop[14];
    FieldByName('DIAG_SOP15').AsString:= arDzSop[15];
    FieldByName('DIAG_SOP16').AsString:= arDzSop[16];
    Post;
  except  On  E: Exception do Showmessage('ошибка с Dbf_DIAGKOSN');
  end;
 end;
end;

procedure Tdm_wdbf.Cin_DIAGPOSN(S: String);
begin
 With DIAGPOSN, Dbf_DIAGPOSN do begin
  try
   if  Locate('RKO', S,[]) then  Edit else Append;
   FieldByName('RKO').AsString:= r;
   FieldByName('DIAG_OSN01').AsString:= arPDzOsn[1];
   FieldByName('DIAG_OSN02').AsString:= arPDzOsn[2];
   FieldByName('DIAG_OSN03').AsString:= arPDzOsn[3];
   FieldByName('DIAG_OSN04').AsString:= arPDzOsn[4];
   FieldByName('DIAG_OSN05').AsString:= arPDzOsn[5];
   FieldByName('DIAG_OSN06').AsString:= arPDzOsn[6];
   FieldByName('DIAG_OSN07').AsString:= arPDzOsn[7];
   FieldByName('DIAG_OSN08').AsString:= arPDzOsn[8];
   FieldByName('DIAG_OSN09').AsString:= arPDzOsn[9];
   FieldByName('DIAG_OSN10').AsString:= arPDzOsn[10];
   FieldByName('DIAG_OSN11').AsString:= arPDzOsn[11];
   FieldByName('DIAG_OSN12').AsString:= arPDzOsn[12];
   FieldByName('DIAG_FON01').AsString:= arPDzFon[1];
   FieldByName('DIAG_FON02').AsString:= arPDzFon[2];
   FieldByName('DIAG_FON03').AsString:= arPDzFon[3];
   FieldByName('DIAG_FON04').AsString:= arPDzFon[4];
   FieldByName('DIAG_FON05').AsString:= arPDzFon[5];
   FieldByName('DIAG_FON06').AsString:= arPDzFon[6];
   FieldByName('DIAG_FON07').AsString:= arPDzFon[7];
   FieldByName('DIAG_FON08').AsString:= arPDzFon[8];
   FieldByName('DIAG_FON09').AsString:= arPDzFon[9];
   FieldByName('DIAG_FON10').AsString:= arPDzFon[10];
   FieldByName('DIAG_FON11').AsString:= arPDzFon[11];
   FieldByName('DIAG_FON12').AsString:= arPDzFon[12];
   FieldByName('DIAG_OSL01').AsString:= arPDzOsl[1];
   FieldByName('DIAG_OSL02').AsString:= arPDzOsl[2];
   FieldByName('DIAG_OSL03').AsString:= arPDzOsl[3];
   FieldByName('DIAG_OSL04').AsString:= arPDzOsl[4];
   FieldByName('DIAG_OSL05').AsString:= arPDzOsl[5];
   FieldByName('DIAG_OSL06').AsString:= arPDzOsl[6];
   FieldByName('DIAG_OSL07').AsString:= arPDzOsl[7];
   FieldByName('DIAG_OSL08').AsString:= arPDzOsl[8];
   FieldByName('DIAG_OSL09').AsString:= arPDzOsl[9];
   FieldByName('DIAG_OSL10').AsString:= arPDzOsl[10];
   FieldByName('DIAG_OSL11').AsString:= arPDzOsl[11];
   FieldByName('DIAG_OSL12').AsString:= arPDzOsl[12];
   FieldByName('DIAG_OSL13').AsString:= arPDzOsl[13];
   FieldByName('DIAG_OSL14').AsString:= arPDzOsl[14];
   FieldByName('DIAG_OSL15').AsString:= arPDzOsl[15];
   FieldByName('DIAG_OSL16').AsString:= arPDzOsl[16];
   FieldByName('DIAG_SOP01').AsString:= arPDzSop[1];
   FieldByName('DIAG_SOP02').AsString:= arPDzSop[2];
   FieldByName('DIAG_SOP03').AsString:= arPDzSop[3];
   FieldByName('DIAG_SOP04').AsString:= arPDzSop[4];
   FieldByName('DIAG_SOP05').AsString:= arPDzSop[5];
   FieldByName('DIAG_SOP06').AsString:= arPDzSop[6];
   FieldByName('DIAG_SOP07').AsString:= arPDzSop[7];
   FieldByName('DIAG_SOP08').AsString:= arPDzSop[8];
   FieldByName('DIAG_SOP09').AsString:= arPDzSop[9];
   FieldByName('DIAG_SOP10').AsString:= arPDzSop[10];
   FieldByName('DIAG_SOP11').AsString:= arPDzSop[11];
   FieldByName('DIAG_SOP12').AsString:= arPDzSop[12];
   FieldByName('DIAG_SOP13').AsString:= arPDzSop[13];
   FieldByName('DIAG_SOP14').AsString:= arPDzSop[14];
   FieldByName('DIAG_SOP15').AsString:= arPDzSop[15];
   FieldByName('DIAG_SOP16').AsString:= arPDzSop[16];
   Post;
 except  On  E: Exception do Showmessage('ошибка с Dbf_DIAGPOSN');
 end;
end;
end;

procedure Tdm_wdbf.Cin_ZAKLUCHE(S: String);
begin
 With ZAKLUCHE, Dbf_ZAKLUCHE do begin
  try
   if  Locate('RKO', S,[]) then  Edit else Append;
   FieldByName('RKO').AsString:= r;
   FieldByName('ZAKL01').AsString:= arPAZAKL[1];
   FieldByName('ZAKL02').AsString:= arPAZAKL[2];
   FieldByName('ZAKL03').AsString:= arPAZAKL[3];
   FieldByName('ZAKL04').AsString:= arPAZAKL[4];
   FieldByName('ZAKL05').AsString:= arPAZAKL[5];
   FieldByName('ZAKL06').AsString:= arPAZAKL[6];
   FieldByName('ZAKL07').AsString:= arPAZAKL[7];
   FieldByName('ZAKL08').AsString:= arPAZAKL[8];
   FieldByName('ZAKL09').AsString:= arPAZAKL[9];
   FieldByName('ZAKL10').AsString:= arPAZAKL[10];
   FieldByName('ZAKL11').AsString:= arPAZAKL[11];
   FieldByName('ZAKL12').AsString:= arPAZAKL[12];
   FieldByName('ZAKL13').AsString:= arPAZAKL[13];
   FieldByName('ZAKL14').AsString:= arPAZAKL[14];
   FieldByName('ZAKL15').AsString:= arPAZAKL[15];
   FieldByName('ZAKL16').AsString:= arPAZAKL[16];
   FieldByName('RASX_KAT').AsString:= sRSX_KAT;
   FieldByName('RASX_TIP01').AsString:= arRSX_TIP[1];
   FieldByName('RASX_TIP02').AsString:= arRSX_TIP[2];
   FieldByName('RASX_TIP03').AsString:= arRSX_TIP[3];
   FieldByName('RASX_TIP04').AsString:= arRSX_TIP[4];
   FieldByName('RASX_TIP05').AsString:= arRSX_TIP[5];
   FieldByName('RASX_TIP06').AsString:= arRSX_TIP[6];
   FieldByName('RASX_TIP07').AsString:= arRSX_TIP[7];
   FieldByName('RASX_PRI01').AsString:= arRSX_PRI[1];
   FieldByName('RASX_PRI02').AsString:= arRSX_PRI[2];
   FieldByName('RASX_PRI03').AsString:= arRSX_PRI[3];
   FieldByName('RASX_PRI04').AsString:= arRSX_PRI[4];
   FieldByName('RASX_PRI05').AsString:= arRSX_PRI[5];
   FieldByName('RASX_PRI06').AsString:= arRSX_PRI[6];
   FieldByName('RASX_PRI07').AsString:= arRSX_PRI[7];
   FieldByName('RASX_PRI08').AsString:= arRSX_PRI[8];
   FieldByName('RASX_PRI09').AsString:= arRSX_PRI[9];
   FieldByName('RASX_PRI10').AsString:= arRSX_PRI[10];
   Post;
  except  On  E: Exception do Showmessage('ошибка с Dbf_ZAKLUCHE');
  end;
end;
end;

procedure Tdm_wdbf.Cin_ANAM_GZN(S: String);
var
 sTMP: string;
  y: integer;
begin
  With ANAM_GZN, Dbf_ANAM_GZN do begin
  try
   if  Locate('RKO', S,[]) then  Edit else Append;
   FieldByName('RKO').AsString:= r;
   if (arOpisGZN[1] = '*') or (Length(Trim(arOpisGZN[1])) =0) then FieldByName('AN_GZN').AsString:= '*'
    else begin
    sTMP :='';
    for y := 1 to 24 do
      if  Trim(arOpisGZN[y]) <> '*' then sTMP:= sTMP+ ' '+ Trim(arOpisGZN[y]);
    FieldByName('AN_GZN').AsString:=  delperenos(sTMP);
    end;
  Post;
  except On  E: Exception do Showmessage('ошибка с Dbf_ANAM_GZN');
  end;
 end;
end;

procedure Tdm_wdbf.Cin_ANAM_ZBL(S: String);
var
 sTMP: string;
  y: integer;
begin
  With ANAM_ZBL, Dbf_ANAM_ZBL do begin
  try
   if  Locate('RKO', S,[]) then  Edit else Append;
   FieldByName('RKO').AsString:= r;
   if (arOpisZBL[1] = '*') or (Length(Trim(arOpisZBL[1])) =0) then FieldByName('AN_ZBL').AsString:= '*'
    else begin
    sTMP :='';
    for y := 1 to 24 do
      if  Trim(arOpisZBL[y]) <> '*' then sTMP:= sTMP+ ' '+ Trim(arOpisZBL[y]);
    FieldByName('AN_ZBL').AsString:=  delperenos(sTMP);
    end;
  Post;
  except On  E: Exception do Showmessage('ошибка с Dbf_ANAM_ZBL');
  end;
 end;
end;

procedure Tdm_wdbf.Cin_PSIXISOSfDBF(S: String);
var
 sTMP: string;
  y: integer;
begin
  With PSIXISOS, Dbf_PSIXISOS do begin
  try
   if  Locate('RKO', S,[]) then  Edit else Append;
   FieldByName('RKO').AsString:= r;
   if (arOpisPSIX[1] = '*') or (Length(Trim(arOpisPSIX[1])) =0) then FieldByName('PSIX_SOS').AsString:= '*'
    else begin
    sTMP :='';
    for y := 1 to 48 do
      if  Trim(arOpisPSIX[y]) <> '*' then sTMP:= sTMP+ ' '+ Trim(arOpisPSIX[y]);
    FieldByName('PSIX_SOS').AsString:=  delperenos(sTMP);
    end;
  Post;
  except On  E: Exception do Showmessage('ошибка с Dbf_PSIXISOS');
  end;
 end;
end;

procedure Tdm_wdbf.Cin_SOMATSOSfDBF(S: String);
var
 sTMP: string;
  y: integer;
begin
  With SOMATSOS, Dbf_SOMATSOS do begin
  try
   if  Locate('RKO', S,[]) then  Edit else Append;
   FieldByName('RKO').AsString:= r;
   if (arOpisSOMA[1] = '*') or (Length(Trim(arOpisSOMA[1])) =0) then FieldByName('SOMA_SOS').AsString:= '*'
    else begin
    sTMP :='';
    for y := 1 to 48 do
      if  Trim(arOpisSOMA[y]) <> '*' then sTMP:= sTMP+ ' '+ Trim(arOpisSOMA[y]);
    FieldByName('SOMA_SOS').AsString:=  delperenos(sTMP);
    end;
  Post;
  except On  E: Exception do Showmessage('ошибка с Dbf_SOMATSOS');
  end;
 end;
end;

procedure Tdm_wdbf.Cin_NEVROSOSfDBF(S: String);
var
 sTMP: string;
  y: integer;
begin
  With NEVROSOS, Dbf_NEVROSOS do begin
  try
   if  Locate('RKO', S,[]) then  Edit else Append;
   FieldByName('RKO').AsString:= r;
   if (arOpisNEVR[1] = '*') or (Length(Trim(arOpisNEVR[1])) =0) then FieldByName('NEVR_SOS').AsString:= '*'
    else begin
    sTMP :='';
    for y := 1 to 40 do
      if  Trim(arOpisNEVR[y]) <> '*' then sTMP:= sTMP+ ' '+ Trim(arOpisNEVR[y]);
    FieldByName('NEVR_SOS').AsString:=  delperenos(sTMP);
    end;
  Post;
  except On  E: Exception do Showmessage('ошибка с Dbf_NEVROSOS');
  end;
 end;
end;

procedure Tdm_wdbf.Cin_ANAL_GIRfDBF(S: String);
begin
  With ANAL_GIR, Dbf_ANAL_GIR do begin
  try
   if  Locate('RKO', S,[]) then  Edit else Append;
   FieldByName('RKO').AsString:= r;
   FieldByName('GROUP').AsString:= arGRRezKr[1];
   FieldByName('FAKTOR').AsString:= arGRRezKr[2];
   FieldByName('ANAL_SP01').AsString:= arOpisProchAn[1];
   FieldByName('ANAL_SP02').AsString:= arOpisProchAn[2];
   FieldByName('ANAL_SP03').AsString:= arOpisProchAn[3];
   FieldByName('ANAL_SP04').AsString:= arOpisProchAn[4];
   FieldByName('ANAL_SP05').AsString:= arOpisProchAn[5];
   FieldByName('ANAL_SP06').AsString:= arOpisProchAn[6];
   FieldByName('ANAL_SP07').AsString:= arOpisProchAn[7];
   FieldByName('ANAL_SP08').AsString:= arOpisProchAn[8];
   FieldByName('ANAL_SP09').AsString:= arOpisProchAn[9];
   FieldByName('ANAL_SP10').AsString:= arOpisProchAn[10];
   FieldByName('ANAL_SP11').AsString:= arOpisProchAn[11];
   FieldByName('ANAL_SP12').AsString:= arOpisProchAn[12];
   FieldByName('ANAL_SP13').AsString:= arOpisProchAn[13];
   FieldByName('ANAL_SP14').AsString:= arOpisProchAn[14];
   FieldByName('ANAL_SP15').AsString:= arOpisProchAn[15];
   FieldByName('ANAL_SP16').AsString:= arOpisProchAn[16];
   FieldByName('ANAL_SP17').AsString:= arOpisProchAn[17];
   FieldByName('ANAL_SP18').AsString:= arOpisProchAn[18];
   Post;
  except On  E: Exception do Showmessage('ошибка с Dbf_ANAL_GIR');
  end;
 end;
end;

procedure Tdm_wdbf.Cin_ANAL_KRVfDBF(S: String);
begin
  With OAK, Dbf_ANAL_KRV do begin
  try
   if  Locate('RKO', S,[]) then  Edit else Append;
   FieldByName('RKO').AsString:= r;
   FieldByName('KRV_OP01').AsString:= arOpisAn[1];
   FieldByName('KRV_OP02').AsString:= arOpisAn[2];
   FieldByName('KRV_OP03').AsString:= arOpisAn[3];
   FieldByName('KRV_OP04').AsString:= arOpisAn[4];
   FieldByName('KRV_OP05').AsString:= arOpisAn[5];
   FieldByName('KRV_OP06').AsString:= arOpisAn[6];

   FieldByName('POK_N01').AsString:= arTablAn[1].sNPok;   //sNPok: string[25]; //наименование показате
   FieldByName('POK_Z01').AsString:= arTablAn[1].sZnPok;  //sZnPok: string[21]; //значение
   FieldByName('POK_D01').AsString:= arTablAn[1].sPeriod; //sPeriod: string[17]; //период/дата анализа
   FieldByName('POK_N02').AsString:= arTablAn[2].sNPok;
   FieldByName('POK_Z02').AsString:= arTablAn[2].sZnPok;
   FieldByName('POK_D02').AsString:= arTablAn[2].sPeriod;
   FieldByName('POK_N03').AsString:= arTablAn[3].sNPok;
   FieldByName('POK_Z03').AsString:= arTablAn[3].sZnPok;
   FieldByName('POK_D03').AsString:= arTablAn[3].sPeriod;
   FieldByName('POK_N04').AsString:= arTablAn[4].sNPok;
   FieldByName('POK_Z04').AsString:= arTablAn[4].sZnPok;
   FieldByName('POK_D04').AsString:= arTablAn[4].sPeriod;
   FieldByName('POK_N05').AsString:= arTablAn[5].sNPok;
   FieldByName('POK_Z05').AsString:= arTablAn[5].sZnPok;
   FieldByName('POK_D05').AsString:= arTablAn[5].sPeriod;
   FieldByName('POK_N06').AsString:= arTablAn[6].sNPok;
   FieldByName('POK_Z06').AsString:= arTablAn[6].sZnPok;
   FieldByName('POK_D06').AsString:= arTablAn[6].sPeriod;
   FieldByName('POK_N07').AsString:= arTablAn[7].sNPok;
   FieldByName('POK_Z07').AsString:= arTablAn[7].sZnPok;
   FieldByName('POK_D07').AsString:= arTablAn[7].sPeriod;
   FieldByName('POK_N08').AsString:= arTablAn[8].sNPok;
   FieldByName('POK_Z08').AsString:= arTablAn[8].sZnPok;
   FieldByName('POK_D08').AsString:= arTablAn[8].sPeriod;
   FieldByName('POK_N09').AsString:= arTablAn[9].sNPok;
   FieldByName('POK_Z09').AsString:= arTablAn[9].sZnPok;
   FieldByName('POK_D09').AsString:= arTablAn[9].sPeriod;
   FieldByName('POK_N10').AsString:= arTablAn[10].sNPok;
   FieldByName('POK_Z10').AsString:= arTablAn[10].sZnPok;
   FieldByName('POK_D10').AsString:= arTablAn[10].sPeriod;
   FieldByName('POK_N11').AsString:= arTablAn[11].sNPok;
   FieldByName('POK_Z11').AsString:= arTablAn[11].sZnPok;
   FieldByName('POK_D11').AsString:= arTablAn[11].sPeriod;
   FieldByName('POK_N12').AsString:= arTablAn[12].sNPok;
   FieldByName('POK_Z12').AsString:= arTablAn[12].sZnPok;
   FieldByName('POK_D12').AsString:= arTablAn[12].sPeriod;
   FieldByName('POK_N13').AsString:= arTablAn[13].sNPok;
   FieldByName('POK_Z13').AsString:= arTablAn[13].sZnPok;
   FieldByName('POK_D13').AsString:= arTablAn[13].sPeriod;
   FieldByName('POK_N14').AsString:= arTablAn[14].sNPok;
   FieldByName('POK_Z14').AsString:= arTablAn[14].sZnPok;
   FieldByName('POK_D14').AsString:= arTablAn[14].sPeriod;
   FieldByName('POK_N15').AsString:= arTablAn[15].sNPok;
   FieldByName('POK_Z15').AsString:= arTablAn[15].sZnPok;
   FieldByName('POK_D15').AsString:= arTablAn[15].sPeriod;
   FieldByName('POK_N16').AsString:= arTablAn[16].sNPok;
   FieldByName('POK_Z16').AsString:= arTablAn[16].sZnPok;
   FieldByName('POK_D16').AsString:= arTablAn[16].sPeriod;
   FieldByName('POK_N17').AsString:= arTablAn[17].sNPok;
   FieldByName('POK_Z17').AsString:= arTablAn[17].sZnPok;
   FieldByName('POK_D17').AsString:= arTablAn[17].sPeriod;
   FieldByName('POK_N18').AsString:= arTablAn[18].sNPok;
   FieldByName('POK_Z18').AsString:= arTablAn[18].sZnPok;
   FieldByName('POK_D18').AsString:= arTablAn[18].sPeriod;
   FieldByName('POK_N19').AsString:= arTablAn[19].sNPok;
   FieldByName('POK_Z19').AsString:= arTablAn[19].sZnPok;
   FieldByName('POK_D19').AsString:= arTablAn[19].sPeriod;
   FieldByName('POK_N20').AsString:= arTablAn[20].sNPok;
   FieldByName('POK_Z20').AsString:= arTablAn[20].sZnPok;
   FieldByName('POK_D20').AsString:= arTablAn[20].sPeriod;
   FieldByName('POK_N21').AsString:= arTablAn[21].sNPok;
   FieldByName('POK_Z21').AsString:= arTablAn[21].sZnPok;
   FieldByName('POK_D21').AsString:= arTablAn[21].sPeriod;
   FieldByName('POK_N22').AsString:= arTablAn[22].sNPok;
   FieldByName('POK_Z22').AsString:= arTablAn[22].sZnPok;
   FieldByName('POK_D22').AsString:= arTablAn[22].sPeriod;
   FieldByName('POK_N23').AsString:= arTablAn[23].sNPok;
   FieldByName('POK_Z23').AsString:= arTablAn[23].sZnPok;
   FieldByName('POK_D23').AsString:= arTablAn[23].sPeriod;
   FieldByName('POK_N24').AsString:= arTablAn[24].sNPok;
   FieldByName('POK_Z24').AsString:= arTablAn[24].sZnPok;
   FieldByName('POK_D24').AsString:= arTablAn[24].sPeriod;
   FieldByName('POK_N25').AsString:= arTablAn[25].sNPok;
   FieldByName('POK_Z25').AsString:= arTablAn[25].sZnPok;
   FieldByName('POK_D25').AsString:= arTablAn[25].sPeriod;
   FieldByName('POK_N26').AsString:= arTablAn[26].sNPok;
   FieldByName('POK_Z26').AsString:= arTablAn[26].sZnPok;
   FieldByName('POK_D26').AsString:= arTablAn[26].sPeriod;
   FieldByName('POK_N27').AsString:= arTablAn[27].sNPok;
   FieldByName('POK_Z27').AsString:= arTablAn[27].sZnPok;
   FieldByName('POK_D27').AsString:= arTablAn[27].sPeriod;
   FieldByName('POK_N28').AsString:= arTablAn[28].sNPok;
   FieldByName('POK_Z28').AsString:= arTablAn[28].sZnPok;
   FieldByName('POK_D28').AsString:= arTablAn[28].sPeriod;
   FieldByName('POK_N29').AsString:= arTablAn[29].sNPok;
   FieldByName('POK_Z29').AsString:= arTablAn[29].sZnPok;
   FieldByName('POK_D29').AsString:= arTablAn[29].sPeriod;
   FieldByName('POK_N30').AsString:= arTablAn[30].sNPok;
   FieldByName('POK_Z30').AsString:= arTablAn[30].sZnPok;
   FieldByName('POK_D30').AsString:= arTablAn[30].sPeriod;
   Post;
  except On  E: Exception do Showmessage('ошибка с Dbf_ANAL_KRV');
  end;
 end;
end;

procedure Tdm_wdbf.Cin_ANAL_MCHfDBF(S: String);
begin
  With OAM, Dbf_ANAL_MCH do begin
  try
   if  Locate('RKO', S,[]) then  Edit else Append;
   FieldByName('RKO').AsString:= r;
   FieldByName('MCH_OP01').AsString:= arOpisAn[1];
   FieldByName('MCH_OP02').AsString:= arOpisAn[2];
   FieldByName('MCH_OP03').AsString:= arOpisAn[3];
   FieldByName('MCH_OP04').AsString:= arOpisAn[4];
   FieldByName('MCH_OP05').AsString:= arOpisAn[5];
   FieldByName('MCH_OP06').AsString:= arOpisAn[6];

   FieldByName('POK_N01').AsString:= arTablAn[1].sNPok;   //sNPok: string[25]; //наименование показате
   FieldByName('POK_Z01').AsString:= arTablAn[1].sZnPok;  //sZnPok: string[21]; //значение
   FieldByName('POK_D01').AsString:= arTablAn[1].sPeriod; //sPeriod: string[17]; //период/дата анализа
   FieldByName('POK_N02').AsString:= arTablAn[2].sNPok;
   FieldByName('POK_Z02').AsString:= arTablAn[2].sZnPok;
   FieldByName('POK_D02').AsString:= arTablAn[2].sPeriod;
   FieldByName('POK_N03').AsString:= arTablAn[3].sNPok;
   FieldByName('POK_Z03').AsString:= arTablAn[3].sZnPok;
   FieldByName('POK_D03').AsString:= arTablAn[3].sPeriod;
   FieldByName('POK_N04').AsString:= arTablAn[4].sNPok;
   FieldByName('POK_Z04').AsString:= arTablAn[4].sZnPok;
   FieldByName('POK_D04').AsString:= arTablAn[4].sPeriod;
   FieldByName('POK_N05').AsString:= arTablAn[5].sNPok;
   FieldByName('POK_Z05').AsString:= arTablAn[5].sZnPok;
   FieldByName('POK_D05').AsString:= arTablAn[5].sPeriod;
   FieldByName('POK_N06').AsString:= arTablAn[6].sNPok;
   FieldByName('POK_Z06').AsString:= arTablAn[6].sZnPok;
   FieldByName('POK_D06').AsString:= arTablAn[6].sPeriod;
   FieldByName('POK_N07').AsString:= arTablAn[7].sNPok;
   FieldByName('POK_Z07').AsString:= arTablAn[7].sZnPok;
   FieldByName('POK_D07').AsString:= arTablAn[7].sPeriod;
   FieldByName('POK_N08').AsString:= arTablAn[8].sNPok;
   FieldByName('POK_Z08').AsString:= arTablAn[8].sZnPok;
   FieldByName('POK_D08').AsString:= arTablAn[8].sPeriod;
   FieldByName('POK_N09').AsString:= arTablAn[9].sNPok;
   FieldByName('POK_Z09').AsString:= arTablAn[9].sZnPok;
   FieldByName('POK_D09').AsString:= arTablAn[9].sPeriod;
   FieldByName('POK_N10').AsString:= arTablAn[10].sNPok;
   FieldByName('POK_Z10').AsString:= arTablAn[10].sZnPok;
   FieldByName('POK_D10').AsString:= arTablAn[10].sPeriod;
   FieldByName('POK_N11').AsString:= arTablAn[11].sNPok;
   FieldByName('POK_Z11').AsString:= arTablAn[11].sZnPok;
   FieldByName('POK_D11').AsString:= arTablAn[11].sPeriod;
   FieldByName('POK_N12').AsString:= arTablAn[12].sNPok;
   FieldByName('POK_Z12').AsString:= arTablAn[12].sZnPok;
   FieldByName('POK_D12').AsString:= arTablAn[12].sPeriod;
   FieldByName('POK_N13').AsString:= arTablAn[13].sNPok;
   FieldByName('POK_Z13').AsString:= arTablAn[13].sZnPok;
   FieldByName('POK_D13').AsString:= arTablAn[13].sPeriod;
   FieldByName('POK_N14').AsString:= arTablAn[14].sNPok;
   FieldByName('POK_Z14').AsString:= arTablAn[14].sZnPok;
   FieldByName('POK_D14').AsString:= arTablAn[14].sPeriod;
   FieldByName('POK_N15').AsString:= arTablAn[15].sNPok;
   FieldByName('POK_Z15').AsString:= arTablAn[15].sZnPok;
   FieldByName('POK_D15').AsString:= arTablAn[15].sPeriod;
   FieldByName('POK_N16').AsString:= arTablAn[16].sNPok;
   FieldByName('POK_Z16').AsString:= arTablAn[16].sZnPok;
   FieldByName('POK_D16').AsString:= arTablAn[16].sPeriod;
   FieldByName('POK_N17').AsString:= arTablAn[17].sNPok;
   FieldByName('POK_Z17').AsString:= arTablAn[17].sZnPok;
   FieldByName('POK_D17').AsString:= arTablAn[17].sPeriod;
   FieldByName('POK_N18').AsString:= arTablAn[18].sNPok;
   FieldByName('POK_Z18').AsString:= arTablAn[18].sZnPok;
   FieldByName('POK_D18').AsString:= arTablAn[18].sPeriod;
   FieldByName('POK_N19').AsString:= arTablAn[19].sNPok;
   FieldByName('POK_Z19').AsString:= arTablAn[19].sZnPok;
   FieldByName('POK_D19').AsString:= arTablAn[19].sPeriod;
   FieldByName('POK_N20').AsString:= arTablAn[20].sNPok;
   FieldByName('POK_Z20').AsString:= arTablAn[20].sZnPok;
   FieldByName('POK_D20').AsString:= arTablAn[20].sPeriod;
   FieldByName('POK_N21').AsString:= arTablAn[21].sNPok;
   FieldByName('POK_Z21').AsString:= arTablAn[21].sZnPok;
   FieldByName('POK_D21').AsString:= arTablAn[21].sPeriod;
   FieldByName('POK_N22').AsString:= arTablAn[22].sNPok;
   FieldByName('POK_Z22').AsString:= arTablAn[22].sZnPok;
   FieldByName('POK_D22').AsString:= arTablAn[22].sPeriod;
   FieldByName('POK_N23').AsString:= arTablAn[23].sNPok;
   FieldByName('POK_Z23').AsString:= arTablAn[23].sZnPok;
   FieldByName('POK_D23').AsString:= arTablAn[23].sPeriod;
   FieldByName('POK_N24').AsString:= arTablAn[24].sNPok;
   FieldByName('POK_Z24').AsString:= arTablAn[24].sZnPok;
   FieldByName('POK_D24').AsString:= arTablAn[24].sPeriod;
   FieldByName('POK_N25').AsString:= arTablAn[25].sNPok;
   FieldByName('POK_Z25').AsString:= arTablAn[25].sZnPok;
   FieldByName('POK_D25').AsString:= arTablAn[25].sPeriod;
   FieldByName('POK_N26').AsString:= arTablAn[26].sNPok;
   FieldByName('POK_Z26').AsString:= arTablAn[26].sZnPok;
   FieldByName('POK_D26').AsString:= arTablAn[26].sPeriod;
   FieldByName('POK_N27').AsString:= arTablAn[27].sNPok;
   FieldByName('POK_Z27').AsString:= arTablAn[27].sZnPok;
   FieldByName('POK_D27').AsString:= arTablAn[27].sPeriod;
   FieldByName('POK_N28').AsString:= arTablAn[28].sNPok;
   FieldByName('POK_Z28').AsString:= arTablAn[28].sZnPok;
   FieldByName('POK_D28').AsString:= arTablAn[28].sPeriod;
   FieldByName('POK_N29').AsString:= arTablAn[29].sNPok;
   FieldByName('POK_Z29').AsString:= arTablAn[29].sZnPok;
   FieldByName('POK_D29').AsString:= arTablAn[29].sPeriod;
   FieldByName('POK_N30').AsString:= arTablAn[30].sNPok;
   FieldByName('POK_Z30').AsString:= arTablAn[30].sZnPok;
   FieldByName('POK_D30').AsString:= arTablAn[30].sPeriod;
   Post;
  except On  E: Exception do Showmessage('ошибка с Dbf_ANAL_MCH');
  end;
 end;
end;

procedure Tdm_wdbf.Cin_ANAL_LUMfDBF(S: String);
begin
  With ANLikv, Dbf_ANAL_LUM do begin
  try
   if  Locate('RKO', S,[]) then  Edit else Append;
   FieldByName('RKO').AsString:= r;
   FieldByName('LUM_OP01').AsString:= arOpisAn[1];
   FieldByName('LUM_OP02').AsString:= arOpisAn[2];
   FieldByName('LUM_OP03').AsString:= arOpisAn[3];
   FieldByName('LUM_OP04').AsString:= arOpisAn[4];
   FieldByName('LUM_OP05').AsString:= arOpisAn[5];
   FieldByName('LUM_OP06').AsString:= arOpisAn[6];

   FieldByName('POK_N01').AsString:= arTablAn[1].sNPok;   //sNPok: string[25]; //наименование показате
   FieldByName('POK_Z01').AsString:= arTablAn[1].sZnPok;  //sZnPok: string[21]; //значение
   FieldByName('POK_D01').AsString:= arTablAn[1].sPeriod; //sPeriod: string[17]; //период/дата анализа
   FieldByName('POK_N02').AsString:= arTablAn[2].sNPok;
   FieldByName('POK_Z02').AsString:= arTablAn[2].sZnPok;
   FieldByName('POK_D02').AsString:= arTablAn[2].sPeriod;
   FieldByName('POK_N03').AsString:= arTablAn[3].sNPok;
   FieldByName('POK_Z03').AsString:= arTablAn[3].sZnPok;
   FieldByName('POK_D03').AsString:= arTablAn[3].sPeriod;
   FieldByName('POK_N04').AsString:= arTablAn[4].sNPok;
   FieldByName('POK_Z04').AsString:= arTablAn[4].sZnPok;
   FieldByName('POK_D04').AsString:= arTablAn[4].sPeriod;
   FieldByName('POK_N05').AsString:= arTablAn[5].sNPok;
   FieldByName('POK_Z05').AsString:= arTablAn[5].sZnPok;
   FieldByName('POK_D05').AsString:= arTablAn[5].sPeriod;
   FieldByName('POK_N06').AsString:= arTablAn[6].sNPok;
   FieldByName('POK_Z06').AsString:= arTablAn[6].sZnPok;
   FieldByName('POK_D06').AsString:= arTablAn[6].sPeriod;
   FieldByName('POK_N07').AsString:= arTablAn[7].sNPok;
   FieldByName('POK_Z07').AsString:= arTablAn[7].sZnPok;
   FieldByName('POK_D07').AsString:= arTablAn[7].sPeriod;
   FieldByName('POK_N08').AsString:= arTablAn[8].sNPok;
   FieldByName('POK_Z08').AsString:= arTablAn[8].sZnPok;
   FieldByName('POK_D08').AsString:= arTablAn[8].sPeriod;
   FieldByName('POK_N09').AsString:= arTablAn[9].sNPok;
   FieldByName('POK_Z09').AsString:= arTablAn[9].sZnPok;
   FieldByName('POK_D09').AsString:= arTablAn[9].sPeriod;
   FieldByName('POK_N10').AsString:= arTablAn[10].sNPok;
   FieldByName('POK_Z10').AsString:= arTablAn[10].sZnPok;
   FieldByName('POK_D10').AsString:= arTablAn[10].sPeriod;
   FieldByName('POK_N11').AsString:= arTablAn[11].sNPok;
   FieldByName('POK_Z11').AsString:= arTablAn[11].sZnPok;
   FieldByName('POK_D11').AsString:= arTablAn[11].sPeriod;
   FieldByName('POK_N12').AsString:= arTablAn[12].sNPok;
   FieldByName('POK_Z12').AsString:= arTablAn[12].sZnPok;
   FieldByName('POK_D12').AsString:= arTablAn[12].sPeriod;
   FieldByName('POK_N13').AsString:= arTablAn[13].sNPok;
   FieldByName('POK_Z13').AsString:= arTablAn[13].sZnPok;
   FieldByName('POK_D13').AsString:= arTablAn[13].sPeriod;
   FieldByName('POK_N14').AsString:= arTablAn[14].sNPok;
   FieldByName('POK_Z14').AsString:= arTablAn[14].sZnPok;
   FieldByName('POK_D14').AsString:= arTablAn[14].sPeriod;
   FieldByName('POK_N15').AsString:= arTablAn[15].sNPok;
   FieldByName('POK_Z15').AsString:= arTablAn[15].sZnPok;
   FieldByName('POK_D15').AsString:= arTablAn[15].sPeriod;
   FieldByName('POK_N16').AsString:= arTablAn[16].sNPok;
   FieldByName('POK_Z16').AsString:= arTablAn[16].sZnPok;
   FieldByName('POK_D16').AsString:= arTablAn[16].sPeriod;
   FieldByName('POK_N17').AsString:= arTablAn[17].sNPok;
   FieldByName('POK_Z17').AsString:= arTablAn[17].sZnPok;
   FieldByName('POK_D17').AsString:= arTablAn[17].sPeriod;
   FieldByName('POK_N18').AsString:= arTablAn[18].sNPok;
   FieldByName('POK_Z18').AsString:= arTablAn[18].sZnPok;
   FieldByName('POK_D18').AsString:= arTablAn[18].sPeriod;
   FieldByName('POK_N19').AsString:= arTablAn[19].sNPok;
   FieldByName('POK_Z19').AsString:= arTablAn[19].sZnPok;
   FieldByName('POK_D19').AsString:= arTablAn[19].sPeriod;
   FieldByName('POK_N20').AsString:= arTablAn[20].sNPok;
   FieldByName('POK_Z20').AsString:= arTablAn[20].sZnPok;
   FieldByName('POK_D20').AsString:= arTablAn[20].sPeriod;
   FieldByName('POK_N21').AsString:= arTablAn[21].sNPok;
   FieldByName('POK_Z21').AsString:= arTablAn[21].sZnPok;
   FieldByName('POK_D21').AsString:= arTablAn[21].sPeriod;
   FieldByName('POK_N22').AsString:= arTablAn[22].sNPok;
   FieldByName('POK_Z22').AsString:= arTablAn[22].sZnPok;
   FieldByName('POK_D22').AsString:= arTablAn[22].sPeriod;
   FieldByName('POK_N23').AsString:= arTablAn[23].sNPok;
   FieldByName('POK_Z23').AsString:= arTablAn[23].sZnPok;
   FieldByName('POK_D23').AsString:= arTablAn[23].sPeriod;
   FieldByName('POK_N24').AsString:= arTablAn[24].sNPok;
   FieldByName('POK_Z24').AsString:= arTablAn[24].sZnPok;
   FieldByName('POK_D24').AsString:= arTablAn[24].sPeriod;
   FieldByName('POK_N25').AsString:= arTablAn[25].sNPok;
   FieldByName('POK_Z25').AsString:= arTablAn[25].sZnPok;
   FieldByName('POK_D25').AsString:= arTablAn[25].sPeriod;
   FieldByName('POK_N26').AsString:= arTablAn[26].sNPok;
   FieldByName('POK_Z26').AsString:= arTablAn[26].sZnPok;
   FieldByName('POK_D26').AsString:= arTablAn[26].sPeriod;
   FieldByName('POK_N27').AsString:= arTablAn[27].sNPok;
   FieldByName('POK_Z27').AsString:= arTablAn[27].sZnPok;
   FieldByName('POK_D27').AsString:= arTablAn[27].sPeriod;
   FieldByName('POK_N28').AsString:= arTablAn[28].sNPok;
   FieldByName('POK_Z28').AsString:= arTablAn[28].sZnPok;
   FieldByName('POK_D28').AsString:= arTablAn[28].sPeriod;
   FieldByName('POK_N29').AsString:= arTablAn[29].sNPok;
   FieldByName('POK_Z29').AsString:= arTablAn[29].sZnPok;
   FieldByName('POK_D29').AsString:= arTablAn[29].sPeriod;
   FieldByName('POK_N30').AsString:= arTablAn[30].sNPok;
   FieldByName('POK_Z30').AsString:= arTablAn[30].sZnPok;
   FieldByName('POK_D30').AsString:= arTablAn[30].sPeriod;
   Post;
  except On  E: Exception do Showmessage('ошибка с Dbf_ANAL_LUM');
  end;
 end;
end;

procedure Tdm_wdbf.Cin_ANAL_SVIfDBF(S: String);
begin
  With ANAL_SVI, Dbf_ANAL_SVI do begin
  try
   if  Locate('RKO', S,[]) then  Edit else Append;
   FieldByName('RKO').AsString:= r;
   FieldByName('SVI_N01').AsString:=   arAN_KONSVI[1].imyaissl;
   FieldByName('SVI_D01').AsString:=   arAN_KONSVI[1].sData;
   FieldByName('SVI_R0101').AsString:= arAN_KONSVI[1].arOpis[1];
   FieldByName('SVI_R0102').AsString:= arAN_KONSVI[1].arOpis[2];
   FieldByName('SVI_R0103').AsString:= arAN_KONSVI[1].arOpis[3];
   FieldByName('SVI_R0104').AsString:= arAN_KONSVI[1].arOpis[4];
   FieldByName('SVI_R0105').AsString:= arAN_KONSVI[1].arOpis[5];
   FieldByName('SVI_R0106').AsString:= arAN_KONSVI[1].arOpis[6];
   FieldByName('SVI_N02').AsString:=   arAN_KONSVI[2].imyaissl;
   FieldByName('SVI_D02').AsString:=   arAN_KONSVI[2].sData;
   FieldByName('SVI_R0201').AsString:= arAN_KONSVI[2].arOpis[1];
   FieldByName('SVI_R0202').AsString:= arAN_KONSVI[2].arOpis[2];
   FieldByName('SVI_R0203').AsString:= arAN_KONSVI[2].arOpis[3];
   FieldByName('SVI_R0204').AsString:= arAN_KONSVI[2].arOpis[4];
   FieldByName('SVI_R0205').AsString:= arAN_KONSVI[2].arOpis[5];
   FieldByName('SVI_R0206').AsString:= arAN_KONSVI[2].arOpis[6];
   FieldByName('SVI_N03').AsString:=   arAN_KONSVI[3].imyaissl;
   FieldByName('SVI_D03').AsString:=   arAN_KONSVI[3].sData;
   FieldByName('SVI_R0301').AsString:= arAN_KONSVI[3].arOpis[1];
   FieldByName('SVI_R0302').AsString:= arAN_KONSVI[3].arOpis[2];
   FieldByName('SVI_R0303').AsString:= arAN_KONSVI[3].arOpis[3];
   FieldByName('SVI_R0304').AsString:= arAN_KONSVI[3].arOpis[4];
   FieldByName('SVI_R0305').AsString:= arAN_KONSVI[3].arOpis[5];
   FieldByName('SVI_R0306').AsString:= arAN_KONSVI[3].arOpis[6];
   FieldByName('SVI_N04').AsString:=   arAN_KONSVI[4].imyaissl;
   FieldByName('SVI_D04').AsString:=   arAN_KONSVI[4].sData;
   FieldByName('SVI_R0401').AsString:= arAN_KONSVI[4].arOpis[1];
   FieldByName('SVI_R0402').AsString:= arAN_KONSVI[4].arOpis[2];
   FieldByName('SVI_R0403').AsString:= arAN_KONSVI[4].arOpis[3];
   FieldByName('SVI_R0404').AsString:= arAN_KONSVI[4].arOpis[4];
   FieldByName('SVI_R0405').AsString:= arAN_KONSVI[4].arOpis[5];
   FieldByName('SVI_R0406').AsString:= arAN_KONSVI[4].arOpis[6];
   FieldByName('SVI_N05').AsString:=   arAN_KONSVI[5].imyaissl;
   FieldByName('SVI_D05').AsString:=   arAN_KONSVI[5].sData;
   FieldByName('SVI_R0501').AsString:= arAN_KONSVI[5].arOpis[1];
   FieldByName('SVI_R0502').AsString:= arAN_KONSVI[5].arOpis[2];
   FieldByName('SVI_R0503').AsString:= arAN_KONSVI[5].arOpis[3];
   FieldByName('SVI_R0504').AsString:= arAN_KONSVI[5].arOpis[4];
   FieldByName('SVI_R0505').AsString:= arAN_KONSVI[5].arOpis[5];
   FieldByName('SVI_R0506').AsString:= arAN_KONSVI[5].arOpis[6];
   FieldByName('SVI_N06').AsString:=   arAN_KONSVI[6].imyaissl;
   FieldByName('SVI_D06').AsString:=   arAN_KONSVI[6].sData;
   FieldByName('SVI_R0601').AsString:= arAN_KONSVI[6].arOpis[1];
   FieldByName('SVI_R0602').AsString:= arAN_KONSVI[6].arOpis[2];
   FieldByName('SVI_R0603').AsString:= arAN_KONSVI[6].arOpis[3];
   FieldByName('SVI_R0604').AsString:= arAN_KONSVI[6].arOpis[4];
   FieldByName('SVI_R0605').AsString:= arAN_KONSVI[6].arOpis[5];
   FieldByName('SVI_R0606').AsString:= arAN_KONSVI[6].arOpis[6];
   Post;
  except On  E: Exception do Showmessage('ошибка с Dbf_ANAL_SVI');
  end;
 end;
end;

procedure Tdm_wdbf.Cin_ANAL_KONfDBF(S: String);
begin
  With ANAL_KON, Dbf_ANAL_KON do begin
  try
   if  Locate('RKO', S,[]) then  Edit else Append;
   FieldByName('RKO').AsString:= r;
   FieldByName('KON_N01').AsString:=   arAN_KONSVI[1].imyaissl;
   FieldByName('KON_D01').AsString:=   arAN_KONSVI[1].sData;
   FieldByName('KON_R0101').AsString:= arAN_KONSVI[1].arOpis[1];
   FieldByName('KON_R0102').AsString:= arAN_KONSVI[1].arOpis[2];
   FieldByName('KON_R0103').AsString:= arAN_KONSVI[1].arOpis[3];
   FieldByName('KON_R0104').AsString:= arAN_KONSVI[1].arOpis[4];
   FieldByName('KON_R0105').AsString:= arAN_KONSVI[1].arOpis[5];
   FieldByName('KON_R0106').AsString:= arAN_KONSVI[1].arOpis[6];
   FieldByName('KON_N02').AsString:=   arAN_KONSVI[2].imyaissl;
   FieldByName('KON_D02').AsString:=   arAN_KONSVI[2].sData;
   FieldByName('KON_R0201').AsString:= arAN_KONSVI[2].arOpis[1];
   FieldByName('KON_R0202').AsString:= arAN_KONSVI[2].arOpis[2];
   FieldByName('KON_R0203').AsString:= arAN_KONSVI[2].arOpis[3];
   FieldByName('KON_R0204').AsString:= arAN_KONSVI[2].arOpis[4];
   FieldByName('KON_R0205').AsString:= arAN_KONSVI[2].arOpis[5];
   FieldByName('KON_R0206').AsString:= arAN_KONSVI[2].arOpis[6];
   FieldByName('KON_N03').AsString:=   arAN_KONSVI[3].imyaissl;
   FieldByName('KON_D03').AsString:=   arAN_KONSVI[3].sData;
   FieldByName('KON_R0301').AsString:= arAN_KONSVI[3].arOpis[1];
   FieldByName('KON_R0302').AsString:= arAN_KONSVI[3].arOpis[2];
   FieldByName('KON_R0303').AsString:= arAN_KONSVI[3].arOpis[3];
   FieldByName('KON_R0304').AsString:= arAN_KONSVI[3].arOpis[4];
   FieldByName('KON_R0305').AsString:= arAN_KONSVI[3].arOpis[5];
   FieldByName('KON_R0306').AsString:= arAN_KONSVI[3].arOpis[6];
   FieldByName('KON_N04').AsString:=   arAN_KONSVI[4].imyaissl;
   FieldByName('KON_D04').AsString:=   arAN_KONSVI[4].sData;
   FieldByName('KON_R0401').AsString:= arAN_KONSVI[4].arOpis[1];
   FieldByName('KON_R0402').AsString:= arAN_KONSVI[4].arOpis[2];
   FieldByName('KON_R0403').AsString:= arAN_KONSVI[4].arOpis[3];
   FieldByName('KON_R0404').AsString:= arAN_KONSVI[4].arOpis[4];
   FieldByName('KON_R0405').AsString:= arAN_KONSVI[4].arOpis[5];
   FieldByName('KON_R0406').AsString:= arAN_KONSVI[4].arOpis[6];
   FieldByName('KON_N05').AsString:=   arAN_KONSVI[5].imyaissl;
   FieldByName('KON_D05').AsString:=   arAN_KONSVI[5].sData;
   FieldByName('KON_R0501').AsString:= arAN_KONSVI[5].arOpis[1];
   FieldByName('KON_R0502').AsString:= arAN_KONSVI[5].arOpis[2];
   FieldByName('KON_R0503').AsString:= arAN_KONSVI[5].arOpis[3];
   FieldByName('KON_R0504').AsString:= arAN_KONSVI[5].arOpis[4];
   FieldByName('KON_R0505').AsString:= arAN_KONSVI[5].arOpis[5];
   FieldByName('KON_R0506').AsString:= arAN_KONSVI[5].arOpis[6];
   FieldByName('KON_N06').AsString:=   arAN_KONSVI[6].imyaissl;
   FieldByName('KON_D06').AsString:=   arAN_KONSVI[6].sData;
   FieldByName('KON_R0601').AsString:= arAN_KONSVI[6].arOpis[1];
   FieldByName('KON_R0602').AsString:= arAN_KONSVI[6].arOpis[2];
   FieldByName('KON_R0603').AsString:= arAN_KONSVI[6].arOpis[3];
   FieldByName('KON_R0604').AsString:= arAN_KONSVI[6].arOpis[4];
   FieldByName('KON_R0605').AsString:= arAN_KONSVI[6].arOpis[5];
   FieldByName('KON_R0606').AsString:= arAN_KONSVI[6].arOpis[6];
   Post;
  except On  E: Exception do Showmessage('ошибка с Dbf_ANAL_KON');
  end;
 end;
end;

procedure Tdm_wdbf.Cin_LEKA_MEDfDBF(S: String);
begin
  With LEKA_MED, Dbf_LEKA_MED do begin
  try
    if  Locate('RKO', S,[]) then  Edit else Append;
    FieldByName('RKO').AsString:= r;
    FieldByName('LECH_V01').AsString:= arLekM[1];
    FieldByName('LECH_V02').AsString:= arLekM[2];
    FieldByName('LECH_V03').AsString:= arLekM[3];
    FieldByName('LECH_V04').AsString:= arLekM[4];
    FieldByName('LECH_V05').AsString:= arLekM[5];
    FieldByName('LECH_V06').AsString:= arLekM[6];
    FieldByName('LECH_V07').AsString:= arLekM[7];
    FieldByName('LECH_V08').AsString:= arLekM[8];
    FieldByName('LECH_V09').AsString:= arLekM[9];
    FieldByName('LECH_V10').AsString:= arLekM[10];
    FieldByName('LECH_V11').AsString:= arLekM[11];
    FieldByName('LECH_V12').AsString:= arLekM[12];
    FieldByName('LECH_V13').AsString:= arLekM[13];
    FieldByName('LECH_V14').AsString:= arLekM[14];
    FieldByName('LECH_V15').AsString:= arLekM[15];
    FieldByName('LECH_V16').AsString:= arLekM[16];
    FieldByName('LECH_V17').AsString:= arLekM[17];
    FieldByName('LECH_V18').AsString:= arLekM[18];
    FieldByName('LECH_V19').AsString:= arLekM[19];
    FieldByName('LECH_V20').AsString:= arLekM[20];
    FieldByName('LECH_V21').AsString:= arLekM[21];
    FieldByName('LECH_V22').AsString:= arLekM[22];
    FieldByName('LECH_V23').AsString:= arLekM[23];
    FieldByName('LECH_V24').AsString:= arLekM[24];
    FieldByName('LECH_V25').AsString:= arLekM[25];
    FieldByName('LECH_V26').AsString:= arLekM[26];
    FieldByName('LECH_V27').AsString:= arLekM[27];
    FieldByName('LECH_V28').AsString:= arLekM[28];
    FieldByName('LECH_V29').AsString:= arLekM[29];
    FieldByName('LECH_V30').AsString:= arLekM[30];
   Post;
  except On  E: Exception do Showmessage('ошибка с Dbf_LEKA_MED');
  end;
 end;
end;

procedure Tdm_wdbf.Cin_LEKA_NMDfDBF(S: String);
begin
  With LEKA_NMD, Dbf_LEKA_NMD do begin
  try
    if  Locate('RKO', S,[]) then  Edit else Append;
    FieldByName('RKO').AsString:= r;
    FieldByName('LECH_V01').AsString:= arLekNX[1];
    FieldByName('LECH_V02').AsString:= arLekNX[2];
    FieldByName('LECH_V03').AsString:= arLekNX[3];
    FieldByName('LECH_V04').AsString:= arLekNX[4];
    FieldByName('LECH_V05').AsString:= arLekNX[5];
    FieldByName('LECH_V06').AsString:= arLekNX[6];
    FieldByName('LECH_V07').AsString:= arLekNX[7];
    FieldByName('LECH_V08').AsString:= arLekNX[8];
    FieldByName('LECH_V09').AsString:= arLekNX[9];
    FieldByName('LECH_V10').AsString:= arLekNX[10];
    FieldByName('LECH_V11').AsString:= arLekNX[11];
    FieldByName('LECH_V12').AsString:= arLekNX[12];
    FieldByName('LECH_V13').AsString:= arLekNX[13];
    FieldByName('LECH_V14').AsString:= arLekNX[14];
    FieldByName('LECH_V15').AsString:= arLekNX[15];
    FieldByName('LECH_V16').AsString:= arLekNX[16];
    FieldByName('LECH_V17').AsString:= arLekNX[17];
    FieldByName('LECH_V18').AsString:= arLekNX[18];
    FieldByName('LECH_V19').AsString:= arLekNX[19];
    FieldByName('LECH_V20').AsString:= arLekNX[20];
   Post;
  except On  E: Exception do Showmessage('ошибка с Dbf_LEKA_NMD');
  end;
 end;
end;

procedure Tdm_wdbf.Cin_LEKA_XIRfDBF(S: String);
begin
  With LEKA_XIR, Dbf_LEKA_XIR do begin
  try
    if  Locate('RKO', S,[]) then  Edit else Append;
    FieldByName('RKO').AsString:= r;
    FieldByName('LECH_V01').AsString:= arLekNX[1];
    FieldByName('LECH_V02').AsString:= arLekNX[2];
    FieldByName('LECH_V03').AsString:= arLekNX[3];
    FieldByName('LECH_V04').AsString:= arLekNX[4];
    FieldByName('LECH_V05').AsString:= arLekNX[5];
    FieldByName('LECH_V06').AsString:= arLekNX[6];
    FieldByName('LECH_V07').AsString:= arLekNX[7];
    FieldByName('LECH_V08').AsString:= arLekNX[8];
    FieldByName('LECH_V09').AsString:= arLekNX[9];
    FieldByName('LECH_V10').AsString:= arLekNX[10];
    FieldByName('LECH_V11').AsString:= arLekNX[11];
    FieldByName('LECH_V12').AsString:= arLekNX[12];
    FieldByName('LECH_V13').AsString:= arLekNX[13];
    FieldByName('LECH_V14').AsString:= arLekNX[14];
    FieldByName('LECH_V15').AsString:= arLekNX[15];
    FieldByName('LECH_V16').AsString:= arLekNX[16];
    FieldByName('LECH_V17').AsString:= arLekNX[17];
    FieldByName('LECH_V18').AsString:= arLekNX[18];
    FieldByName('LECH_V19').AsString:= arLekNX[19];
    FieldByName('LECH_V20').AsString:= arLekNX[20];
   Post;
  except On  E: Exception do Showmessage('ошибка с Dbf_LEKA_XIR');
  end;
 end;
end;

{TODO: Результаты - числовые разобраться }
procedure Tdm_wdbf.Cin_LEKA_REZfDBF(S: String);
begin
  With LEKA_REZ, Dbf_LEKA_REZ do begin
  try
    if  Locate('RKO', S,[]) then  Edit else Append;
    FieldByName('RKO').AsString:= r;
    FieldByName('LECH_R01').AsString:= arRezlek[1];
    FieldByName('LECH_R02').AsString:= arRezlek[2];
    FieldByName('LECH_R03').AsString:= arRezlek[3];
    FieldByName('LECH_R04').AsString:= arRezlek[4];
    FieldByName('LECH_R05').AsString:= arRezlek[5];
    FieldByName('LECH_R06').AsString:= arRezlek[6];

    FieldByName('INT_ND').AsInteger:=  0;
    FieldByName('INT_NF').AsInteger:=  0;
    FieldByName('INT_NG').AsInteger:=  0;
    FieldByName('INT_NH').AsInteger:=  0;
    FieldByName('INT_NM').AsInteger:=  0;
    FieldByName('INT_KD').AsInteger:=  0;
    FieldByName('INT_KF').AsInteger:=  0;
    FieldByName('INT_KG').AsInteger:=  0;
    FieldByName('INT_KH').AsInteger:=  0;
    FieldByName('INT_KM').AsInteger:=  0;

    try
     if (Length(Trim(n3ITSu)) = 0) or (n3ITSu = '*') then FieldByName('INT_S').AsInteger:= 0
      else FieldByName('INT_S').AsInteger:= StrToInt(n3ITSu);
     except On  E: Exception do FieldByName('INT_S').AsInteger:= 0;
    end;
     try
      if (Length(Trim(n2ITCh)) = 0) or (n2ITCh = '*') then FieldByName('INT_H').AsInteger:= 0
       else FieldByName('INT_H').AsInteger:= StrToInt(n2ITCh);
      except On  E: Exception do FieldByName('INT_H').AsInteger:= 0;
     end;
      try
       if (Length(Trim(n2ITMi)) = 0) or (n2ITMi = '*') then FieldByName('INT_M').AsInteger:= 0
        else FieldByName('INT_M').AsInteger:= StrToInt(n2ITMi);
       except On  E: Exception do FieldByName('INT_M').AsInteger:= 0;
      end;
    //FieldByName('INT_S').AsInteger:=   0;
    //FieldByName('INT_H').AsInteger:=   0;
    //FieldByName('INT_M').AsInteger:=   0;

    FieldByName('KUP_ND').AsInteger:=  0;
    FieldByName('KUP_NF').AsInteger:=  0;
    FieldByName('KUP_NG').AsInteger:=  0;
    FieldByName('KUP_NH').AsInteger:=  0;
    FieldByName('KUP_NM').AsInteger:=  0;
    FieldByName('KUP_KD').AsInteger:=  0;
    FieldByName('KUP_KF').AsInteger:=  0;
    FieldByName('KUP_KG').AsInteger:=  0;
    FieldByName('KUP_KH').AsInteger:=  0;
    FieldByName('KUP_KM').AsInteger:=  0;

    try
     if (Length(Trim(n3PsSu)) = 0) or (n3PsSu = '*') then FieldByName('KUP_S').AsInteger:= 0
      else FieldByName('KUP_S').AsInteger:= StrToInt(n3PsSu);
     except On  E: Exception do FieldByName('KUP_S').AsInteger:= 0;
    end;
     try
      if (Length(Trim(n2PsCh)) = 0) or (n2PsCh = '*') then FieldByName('KUP_H').AsInteger:= 0
       else FieldByName('KUP_H').AsInteger:= StrToInt(n2PsCh);
      except On  E: Exception do FieldByName('KUP_H').AsInteger:= 0;
     end;
      try
       if (Length(Trim(n2PsMi)) = 0) or (n2PsMi = '*') then FieldByName('KUP_M').AsInteger:= 0
        else FieldByName('KUP_M').AsInteger:= StrToInt(n2PsMi);
       except On  E: Exception do FieldByName('KUP_M').AsInteger:= 0;
      end;
    //FieldByName('KUP_S').AsInteger:=   0;
    //FieldByName('KUP_H').AsInteger:=   0;
    //FieldByName('KUP_M').AsInteger:=   0;
    Post;
  except On  E: Exception do Showmessage('ошибка с Dbf_LEKA_REZ');
   end;
  end;
 end;

procedure Tdm_wdbf.Cin_RECOMENDfDBF(S: String);
begin
  With RECOMEND, Dbf_RECOMEND do begin
  try
    if  Locate('RKO', S,[]) then  Edit else Append;
    FieldByName('RKO').AsString:= r;
    FieldByName('REKOM01').AsString:= arRecom[1];
    FieldByName('REKOM02').AsString:= arRecom[2];
    FieldByName('REKOM03').AsString:= arRecom[3];
    FieldByName('REKOM04').AsString:= arRecom[4];
    FieldByName('REKOM05').AsString:= arRecom[5];
    FieldByName('REKOM06').AsString:= arRecom[6];
    FieldByName('REKOM07').AsString:= arRecom[7];
    FieldByName('REKOM08').AsString:= arRecom[8];
    FieldByName('REKOM09').AsString:= arRecom[9];
    FieldByName('REKOM10').AsString:= arRecom[10];
    FieldByName('REKOM11').AsString:= arRecom[11];
    FieldByName('REKOM12').AsString:= arRecom[12];
    FieldByName('REKOM13').AsString:= arRecom[13];
    FieldByName('REKOM14').AsString:= arRecom[14];
    FieldByName('REKOM15').AsString:= arRecom[15];
    FieldByName('REKOM16').AsString:= arRecom[16];
    FieldByName('REKOM17').AsString:= arRecom[17];
    FieldByName('REKOM18').AsString:= arRecom[18];
    FieldByName('REKOM19').AsString:= arRecom[19];
    FieldByName('REKOM20').AsString:= arRecom[20];
    FieldByName('REKOM21').AsString:= arRecom[21];
    FieldByName('REKOM22').AsString:= arRecom[22];
    FieldByName('REKOM23').AsString:= arRecom[23];
    FieldByName('REKOM24').AsString:= arRecom[24];
    FieldByName('REKOM25').AsString:= arRecom[25];
    FieldByName('REKOM26').AsString:= arRecom[26];
    FieldByName('REKOM27').AsString:= arRecom[27];
    FieldByName('REKOM28').AsString:= arRecom[28];
    FieldByName('REKOM29').AsString:= arRecom[29];
    FieldByName('REKOM30').AsString:= arRecom[30];
    FieldByName('REKOM31').AsString:= arRecom[31];
    FieldByName('REKOM32').AsString:= arRecom[32];
    FieldByName('REKOM33').AsString:= arRecom[33];
    FieldByName('REKOM34').AsString:= arRecom[34];
    FieldByName('REKOM35').AsString:= arRecom[35];
    FieldByName('REKOM36').AsString:= arRecom[36];
    FieldByName('REKOM37').AsString:= arRecom[37];
    FieldByName('REKOM38').AsString:= arRecom[38];
    FieldByName('REKOM39').AsString:= arRecom[39];
    FieldByName('REKOM40').AsString:= arRecom[40];
    Post;
  except On  E: Exception do Showmessage('ошибка с Dbf_RECOMEND');
   end;
  end;
 end;

procedure Tdm_wdbf.Cin_COMMENTfDBF(S: String);
begin
  With COMMENT, Dbf_COMMENT do begin
  try
    if  Locate('RKO', S,[]) then  Edit else Append;
    FieldByName('RKO').AsString:= r;
    FieldByName('COMMN01').AsString:= arOpisCOM[1];
    FieldByName('COMMN02').AsString:= arOpisCOM[2];
    FieldByName('COMMN03').AsString:= arOpisCOM[3];
    FieldByName('COMMN04').AsString:= arOpisCOM[4];
    FieldByName('COMMN05').AsString:= arOpisCOM[5];
    FieldByName('COMMN06').AsString:= arOpisCOM[6];
    FieldByName('COMMN07').AsString:= arOpisCOM[7];
    FieldByName('COMMN08').AsString:= arOpisCOM[8];
    FieldByName('COMMN09').AsString:= arOpisCOM[9];
    FieldByName('COMMN10').AsString:= arOpisCOM[10];
    FieldByName('VRACH01').AsString:= arVRACH[1];
    FieldByName('VRACH02').AsString:= arVRACH[2];
    FieldByName('VRACH03').AsString:= arVRACH[3];
    FieldByName('VRACH04').AsString:= arVRACH[4];
    Post;
  except On  E: Exception do Showmessage('ошибка с Dbf_COMMENT');
   end;
  end;
 end;


end.

