program dbflsql;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, u_main, DM_setup, DM_FB, un_structura, FM_SetPAinDBFL, u_SelLetDBFL,
  PrntInW, dm_wbdf, un_resstring, uofficedll, Un_AnsiOem, Dbf3;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TDM_S, DM_S);
  Application.CreateForm(TfmMain, fmMain);
  Application.CreateForm(TD_FB, D_FB);
  Application.CreateForm(Tdm_wdbf, dm_wdbf);
  Application.Run;
end.

