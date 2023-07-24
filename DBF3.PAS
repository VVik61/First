{
 **********************************************************************
 Модуль для работы с DBF-файлами измененного формата DBFIII,
 где в описании поля вставлены имена DBF-файлов-справочников для этого поля.
 Автор И.Н.Лозинский. 2001г(?)
 Примечания и некоторые поправки В.И.Воронов
 **********************************************************************
}

//{$V-,I-,N+}
{$H-}
Unit Dbf3;

interface
const MaxFileDbf=3;
      MaxField=128;
var Sign:array[1..MaxFileDbf] of byte;
    God:array[1..MaxFileDbf] of byte;
    Mes:array[1..MaxFileDbf] of byte;
    Dey:array[1..MaxFileDbf] of byte;

    Nzap:array[1..MaxFileDbf] of longint;
    dbfcont:array[1..MaxFileDbf] of longint;
    Hdsize,Rsize:array[1..MaxFileDbf] of word;
    NumField:array[1..MaxFileDbf] of byte;
    errz:word;
    Typ:array[1..MaxFileDbf,1..MaxField] of char;
    Ls,Sm:array[1..MaxFileDbf,1..MaxField] of word;
    ImPol:array[1..MaxFileDbf,1..MaxField] of string[10];
    UkPol:array[1..MaxFileDbf,1..MaxField] of string[8];
    RgPol:array[1..MaxFileDbf,1..MaxField] of byte;
    Dbfile:array[1..MaxFileDbf] of file;

    Nzap0:longint;
    dbfcont0:longint;
    Hdsize0,Rsize0:word;
    NumField0:byte;
    Typ0:array[1..255] of char;
    Ls0,Sm0:array[1..255] of word;
    ImPol0:array[1..255] of string[10];
    UkPol0:array[1..255] of string[8];
    RgPol0:array[1..255] of byte;
    Dbfile0:file;

function CharStr(Ch:Char;Len:Byte):String;
function PadCh(S:String;Ch:Char;Len:Byte):String;
{Открытие DBF-файла. s- путь к файлу (полный!). использовать UTF8ToConsole(  }
function  DbfOpen(n:byte;s:string):integer;
function  DbfOpenP(n:byte;s:string):integer;

{Проверка -файл DBFIII или DBF7. Ф-л должен быть открыт DbfOpen.}
function  DbfIden(n:byte;s:string):byte;
{=========================ЧТЕНИЕ из DBF=======Ф-л должен быть открыт DbfOpen.============}
{Чтение Строки из ф-ла с дескриптором n, по записи Zap, поля Field. }
function  DbfRead(n:byte;Zap:longint;Field:byte):string;
{Чтение Числа_real из ф-ла...}
function  DbfReadR(n:byte;Zap:longint;Field:byte;var Bad:boolean):real;
{Чтение Числа_integer из ф-ла...}
function  DbfReadI(n:byte;Zap:longint;Field:byte;Bad:integer):integer;
                     {ЗАПИСЬ в DBF}
procedure DbfWrite(n:byte;s:string;Zap:longint;Field:byte);
procedure DbfWriteR(n:byte;R:real;f:shortint;Zap:longint;Field:byte);
procedure DbfWriteI(n:byte;R:integer;Zap:longint;Field:byte);

{Закрытие DBF-файла.}
procedure DbfClose(n:byte);

function  DbfLocate(n:byte;s:string;Field:byte):longint;
function  DbfDelete(n:byte;Zap_n,Zap_k:longint):boolean;
function  DbfAppend(n:byte):boolean;

function  DbfZap(n:byte):boolean;

function  DbfGreate(n:byte;s:string):boolean;
function  DbfMetka(n:byte;Zap:longint;Metka:string):boolean;
function  DbfAktiv(n:byte;Zap:longint):boolean;

function  DbfSlovarO(n:byte;Field:byte):boolean;
function  DbfSlovarI(n:byte;Field:byte):boolean;



function  DbfIden0(s:string):byte;
function  DbfOpen0(s:string):integer;
function  DbfOpenP0(s:string):integer;
function  DbfRead0(Zap:longint;Field:integer):string;
function  DbfReadR0(Zap:longint;Field:integer;var Bad:boolean):real;
function  DbfReadI0(Zap:longint;Field,Bad:integer):integer;
procedure DbfWrite0(s:string;Zap:longint;Field:integer);
procedure DbfWriteR0(R:real;f:shortint;Zap:longint;Field:integer);
procedure DbfWriteI0(R:integer;Zap:longint;Field:integer);
procedure DbfClose0;
function  DbfLocate0(s:string;Field:integer):longint;
function  DbfDelete0(Zap_n,Zap_k:longint):boolean;
function  DbfAppend0:boolean;
function  DbfZap0:boolean;
function  DbfGreate0(s:string):boolean;
function  DbfMetka0(Zap:longint;Metka:string):boolean;
function  DbfAktiv0(Zap:longint):boolean;
function  DbfSlovarO0(Field:integer):boolean;
function  DbfSlovarI0(Field:integer):boolean;

implementation
uses Dos, sysutils,
  Dialogs;
  //,TpCrt,  TpString;
  var log10:real;

function CharStr(Ch:Char;Len:Byte):String;
        var  S:String;
      begin
      if Len=0 then  CharStr[0]:=#0  else
       begin
       S[0]:=Chr(Len);
       FillChar(S[1],Len,Ch);
       CharStr:=S;
       end;
      end;

function PadCh(S:String;Ch:Char;Len:Byte):String;
var  o:String;  SLen:Byte absolute S;
begin
 if Length(S)>=Len then
 PadCh:=S  else begin  o[0]:=Chr(Len);  Move(S[1],o[1],SLen);
 if SLen<255 then  FillChar(o[Succ(SLen)],Len-SLen,Ch);  PadCh:=o;
 end;
end;

function DbfIden(n:byte;s:string):byte;
var res:integer;
    i:byte;
begin
  DbfIden:=0;
  assign(Dbfile[n],s);
  reset(DbFile[n],1);
  res:=ioresult;
  if res=0 then begin
    blockread(Dbfile[n],i,1,errz);
    case i of
     3:DbfIden:=1;
     48:DbfIden:=2
    end
  end;
  close(DbFile[n]);
end;
function DbfOpen(n:byte;s:string):integer;
var res,n2,i:integer;
    buf:array[1..10] of char;
begin
  assign(Dbfile[n],s);
  reset(DbFile[n],1);
  res:=ioresult;
  if res=0 then begin
    //seek(Dbfile[n],2);
    //seek(Dbfile[n],1);
    blockread(Dbfile[n],Sign[n],1,errz);
    blockread(Dbfile[n],God[n],1,errz);
    blockread(Dbfile[n],Mes[n],1,errz);
    blockread(Dbfile[n],Dey[n],1,errz);
    //seek(Dbfile[n],4);
    blockread(Dbfile[n],Nzap[n],4,errz);
    blockread(Dbfile[n],Hdsize[n],2,errz);
    blockread(Dbfile[n],Rsize[n],2,errz);
    NumField[n]:=((Hdsize[n]-1) div 32)-1;
    n2:=1;
    for i:=1 to NumField[n] do begin
       seek(Dbfile[n],11+32*i);
       blockread(Dbfile[n],Typ[n,i],1,errz);
       seek(Dbfile[n],16+32*i);
       blockread(Dbfile[n],ls[n,i],2,errz);
       Sm[n,i]:=n2;
       n2:=n2+lo(Ls[n,i]);
       seek(Dbfile[n],32*i);
       blockread(Dbfile[n],buf,10,errz);
       Impol[n,i]:=buf
    end;
  end;
  DbfOpen:=res;
end;
function DbfOpenP(n:byte;s:string):integer;
var res,n2,i:integer;
    buf:array[1..10] of char;
begin
  assign(Dbfile[n],s);
  reset(DbFile[n],1);
  res:=ioresult;
  if res=0 then begin
    seek(Dbfile[n],4);
    blockread(Dbfile[n],Nzap[n],4,errz);
    blockread(Dbfile[n],Hdsize[n],2,errz);
    blockread(Dbfile[n],Rsize[n],2,errz);
    NumField[n]:=((Hdsize[n]-264) div 32)-1;
    n2:=1;
    for i:=1 to NumField[n] do begin
       seek(Dbfile[n],11+32*i);
       blockread(Dbfile[n],Typ[n,i],1,errz);
       seek(Dbfile[n],16+32*i);
       blockread(Dbfile[n],ls[n,i],2,errz);
       Sm[n,i]:=n2;
       n2:=n2+lo(Ls[n,i]);
       seek(Dbfile[n],32*i);
       blockread(Dbfile[n],buf,10,errz);
       Impol[n,i]:=buf
    end;
  end;
  DbfOpenP:=res;
end;

function DbfRead(n:byte;Zap:longint;Field:byte):string;
var s:string;
    pos:longint;
    lf:byte; //integer;
begin
  pos:=Hdsize[n]+Rsize[n]*(Zap-1)+Sm[n,Field];
  seek(Dbfile[n],pos);
  lf:=lo(Ls[n,Field]);
  blockread(Dbfile[n],s[1],lf,errz);
  s[0]:=chr(lf);
  DbfRead:=s;
end;
{$R-}
function DbfReadR(n:byte;Zap:longint;Field:byte;var Bad:boolean):real;
var s:string;
    pos:longint;
    lf:integer;
    r:real;
begin
  pos:=Hdsize[n]+Rsize[n]*(Zap-1)+Sm[n,Field];
  seek(Dbfile[n],pos);
  lf:=lo(Ls[n,Field]);
  blockread(Dbfile[n],s[1],lf,errz);
  s[0]:=chr(lf);
  s:=Trim(s);
  val(s,r,lf);
  Bad:=true;
  if lf=0 then DbfReadR:=r else begin DbfReadR:=0;Bad:=false end
end;
function DbfReadI(n:byte;Zap:longint;Field:byte;Bad:integer):integer;
var s:string;
    pos:longint;
    lf:integer;
    r:integer;
begin
  pos:=Hdsize[n]+Rsize[n]*(Zap-1)+Sm[n,Field];
  seek(Dbfile[n],pos);
  lf:=lo(Ls[n,Field]);
  blockread(Dbfile[n],s[1],lf,errz);
  s[0]:=chr(lf);
  s:=Trim(s);
  val(s,r,lf);
  if lf=0 then DbfReadI:=r else DbfReadI:=Bad
end;
{ЗАПИСЫВАЕТ s в Запись=Zap Поле=Field}
procedure DbfWrite(n:byte;s:string;Zap:longint;Field:byte);
var pos:longint;
    lf:integer;
begin
  pos:=Hdsize[n]+Rsize[n]*(Zap-1)+Sm[n,Field];
  seek(Dbfile[n],pos);
  lf:=lo(Ls[n,Field]);
  if length(s)<lf then repeat s:=s+' ' until length(s)=lf;
  blockwrite(Dbfile[n],s[1],lf,errz);
end;
procedure DbfWriteR(n:byte;R:real;f:shortint;Zap:longint;Field:byte);
var pos:longint;
    lf:integer;
    s:string;
    n0:real;
    m,d,f1,f2:byte;
begin
  pos:=Hdsize[n]+Rsize[n]*(Zap-1)+Sm[n,Field];
  seek(Dbfile[n],pos);
  lf:=lo(Ls[n,Field]);
  if f<0 then begin
   if f=-1 then f2:=hi(Ls[n,Field])
   else begin
    d:=0;
    if R<0 then begin d:=1;R:=abs(R) end;
    if R<10.0 then m:=0 else begin
       n0:=Int(R);
       m:=Trunc(ln(n0)/log10)
    end;
    f1:=2+m+d;
    if f1>=lf then f2:=0 else f2:=lf-(2+m+d)
   end
  end else f2:=f;
  str(R:lf:f2,s);
{  for m:=lf downto 1 do
   if s[m]='0' then delete(s,m,1) else Break;
  if length(s)<lf then repeat s:=' '+s until length(s)=lf;}
  blockwrite(Dbfile[n],s[1],lf,errz)
end;
procedure DbfWriteI(n:byte;R:integer;Zap:longint;Field:byte);
var pos:longint;
    lf:integer;
    s:string;
begin
  pos:=Hdsize[n]+Rsize[n]*(Zap-1)+Sm[n,Field];
  seek(Dbfile[n],pos);
  lf:=lo(Ls[n,Field]);
  str(R:lf,s);
  blockwrite(Dbfile[n],s[1],lf,errz)
end;

procedure DbfClose(n:byte);
begin
  Hdsize[n]:=0;
  Rsize[n]:=0;
  Nzap[n]:=0;
  NumField[n]:=0;
  close(Dbfile[n]);
end;

function DbfLocate(n:byte;s:string;Field:byte):longint;
var i,j:longint;
label exl;
begin
  j:=0;
  for i:=dbfcont[n] to Nzap[n] do begin
    if trim(s)=trim(DbfRead(n,i,Field)) then begin
      j:=i;
      goto exl;
    end;
  end;
exl: DbfLocate:=j;
     dbfcont[n]:=j+1;
end;

function DbfDelete(n:byte;Zap_n,Zap_k:longint):boolean;
label 9;
const rmem=24000;
type Buff=array[1..rmem] of char;
var flag:boolean;
    n0,m,i,k,l:longint;
    BufP:^Buff;
begin
  flag:=false;
  if ((Zap_n>Nzap[n])or(Zap_k>Nzap[n]))or((Zap_n<=0)or(Zap_k<=0)) then goto 9;
  if Zap_n>Zap_k then goto 9;
  k:=Zap_k-Zap_n+1;l:=k*Rsize[n];
  New(BufP);
  if Zap_k<Nzap[n] then
     for i:=Zap_k to Nzap[n]-1 do begin
         n0:=Hdsize[n]+1+i*Rsize[n];
         m:=n0-l;
         seek(DbFile[n],n0);
         blockread(DbFile[n],BufP^,Rsize[n],errz);
         seek(DbFile[n],m);
         blockwrite(DbFile[n],BufP^,Rsize[n],errz)
     end;
  Dispose(BufP);
  n0:=Hdsize[n]+Rsize[n]*(Nzap[n]-k);
  seek(DbFile[n],n0);
  Truncate(DbFile[n]);
  Nzap[n]:=Nzap[n]-k;
  seek(DbFile[n],4);
  blockwrite(DbFile[n],Nzap[n],4,errz);
  flag:=true;
9:DbfDelete:=flag
end;

function DbfAppend(n:byte):boolean;
const pust: char=' ';
      eoz : char=chr(26);
var n0,i:longint;
begin
  DbfAppend:=false;
  if Hdsize[n]>0 then begin
    i:=Rsize[n];
    n0:=i*Nzap[n];
    n0:=n0+Hdsize[n];
    seek(DbFile[n],n0);
    for i:=1 to Rsize[n] do
      blockwrite(DbFile[n],pust,1,errz);
    blockwrite(DbFile[n],eoz,1,errz);
    Nzap[n]:=Nzap[n]+1;n0:=Nzap[n];
    seek(DbFile[n],4);
    blockwrite(DbFile[n],n0,4,errz);
    DbfAppend:=true
  end
end;

function DbfZap(n:byte):boolean;
const  eoz : char=chr(26);
var n0:longint;
begin
  DbfZap:=false;
  if (Hdsize[n]>0)and(Nzap[n]>0) then begin
    seek(DbFile[n],Hdsize[n]);
    blockwrite(DbFile[n],eoz,1,errz);
    Truncate(DbFile[n]);
    Nzap[n]:=0;n0:=0;
    seek(DbFile[n],4);
    blockwrite(DbFile[n],n0,4,errz);
    DbfZap:=true
  end
end;
{вход: NumField;
       Ls[j],Typ[j],ImPol[j]
  j=1..NumField}
function  DbfGreate(n:byte;s:string):boolean;
  const s0=chr(0);
  var b:string[32];
      p:string[14];
      r:string[2];
      j:byte;
      f:Text;
begin
  DbfGreate:=false;
  p:=CharStr(s0,14);
  r:=chr(13)+chr(26);
  Nzap[n]:=0;
  HdSize[n]:=32+NumField[n]*32+1;
  RSize[n]:=1;
  for j:=1 to NumField[n] do RSize[n]:=RSize[n]+Ls[n,j];
  assign(Dbfile[n],s);rewrite(DbFile[n],1);
  b:=chr(3);b:=PadCh(b,s0,4);
  blockwrite(DbFile[n],b[1],4,errz);
  blockwrite(DbFile[n],Nzap[n],4,errz);
  blockwrite(DbFile[n],HdSize[n],2,errz);
  blockwrite(DbFile[n],RSize[n],2,errz);
  b:=CharStr(s0,20);
  blockwrite(DbFile[n],b[1],20,errz);
  for j:=1 to NumField[n] do begin
      b:=ImPol[n,j]+s0+Typ[n,j]+s0+s0+s0+s0;
      blockwrite(DbFile[n],b[1],16,errz);
      blockwrite(DbFile[n],Ls[n,j],2,errz);
      blockwrite(DbFile[n],p[1],14,errz)
  end;
  blockwrite(DbFile[n],r[1],2,errz);
{  DbfClose(1);}
  Close(Dbfile[n]);
  DbfGreate:=true
end;
function  DbfMetka(n:byte;Zap:longint;Metka:string):boolean;
var pos:longint;
begin
  DbfMetka:=false;
  if Zap<=Nzap[n] then begin
     pos:=Hdsize[n]+Rsize[n]*(Zap-1);
     seek(Dbfile[n],pos);
     blockwrite(Dbfile[n],Metka[1],1,errz);
     DbfMetka:=true
  end
end;
function  DbfAktiv(n:byte;Zap:longint):boolean;
var pos:longint;
    s:string;
begin
  DbfAktiv:=true;
  if Zap<=Nzap[n] then begin
     pos:=Hdsize[n]+Rsize[n]*(Zap-1);
     seek(Dbfile[n],pos);
     blockread(Dbfile[n],s[1],1,errz);
     if s[1]='*' then DbfAktiv:=false
  end
end;
function  DbfSlovarO(n:byte;Field:byte):boolean;
  var j:byte;
      pr:char;
begin
  if (Field>0)and(Field<=NumField[n]) then begin
   pr:=chr(32);
   UkPol[n,Field]:=PadCh(UkPol[n,Field],pr,8);
   pr:=chr(RgPol[n,Field]);
   seek(DbFile[n], 23+32*Field);
   blockwrite(DbFile[n],pr,1,errz);
   for j:=1 to 8 do blockwrite(DbFile[n],UkPol[n,Field,j],1,errz);

   DbfSlovarO:=true
  end else DbfSlovarO:=false
end;
Function DbfSlovarI(n:byte;Field:byte):boolean;
  var i:byte;
      sb:string;
      cb:char;
begin
  DbfSlovarI:=false;
  if (Field>0)and(Field<=NumField[n]) then begin
   seek(DbFile[n],24+32*Field-1);
   UkPol[n,Field]:='';
   blockread(DbFile[n],cb,1,errz);
   RgPol[n,Field]:=ord(cb);
   for i:=1 to 8 do begin
       blockread(DbFile[n],cb,1,errz);
       UkPol[n,Field]:=UkPol[n,Field]+cb
   end;
   if length(Trim(UkPol[n,Field]))>0 then DbfSlovarI:=true
  end
end;
{----------------------------------------}
function DbfIden0(s:string):byte;
var res:integer;
    i:byte;
begin
  DbfIden0:=0;
  assign(Dbfile0,s);
  reset(DbFile0,1);
  res:=ioresult;
  if res=0 then begin
    blockread(Dbfile0,i,1,errz);
    case i of
     3:DbfIden0:=1;
     48:DbfIden0:=2
    end
  end;
  close(DbFile0);
end;
function DbfOpen0(s:string):integer;
var res,n2,i:integer;
    buf:array[1..10] of char;
begin
  assign(Dbfile0,s);
  reset(DbFile0,1);
  res:=ioresult;
  if res=0 then begin
    seek(Dbfile0,4);
    blockread(Dbfile0,Nzap0,4,errz);
    blockread(Dbfile0,Hdsize0,2,errz);
    blockread(Dbfile0,Rsize0,2,errz);
    NumField0:=((Hdsize0-1) div 32)-1;
    n2:=1;
    for i:=1 to NumField0 do begin
       seek(Dbfile0,11+32*i);
       blockread(Dbfile0,Typ0[i],1,errz);
       seek(Dbfile0,16+32*i);
       blockread(Dbfile0,Ls0[i],2,errz);
       Sm0[i]:=n2;
       n2:=n2+lo(Ls0[i]);
       seek(Dbfile0,32*i);
       blockread(Dbfile0,buf,10,errz);
       Impol0[i]:=buf
    end;
  end;
  DbfOpen0:=res;
end;
function DbfOpenP0(s:string):integer;
var res,n2,i:integer;
    buf:array[1..10] of char;
begin
  assign(Dbfile0,s);
  reset(DbFile0,1);
  res:=ioresult;
  if res=0 then begin
    seek(Dbfile0,4);
    blockread(Dbfile0,Nzap0,4,errz);
    blockread(Dbfile0,Hdsize0,2,errz);
    blockread(Dbfile0,Rsize0,2,errz);
    NumField0:=((Hdsize0-264) div 32)-1;
    n2:=1;
    for i:=1 to NumField0 do begin
       seek(Dbfile0,11+32*i);
       blockread(Dbfile0,Typ0[i],1,errz);
       seek(Dbfile0,16+32*i);
       blockread(Dbfile0,Ls0[i],2,errz);
       Sm0[i]:=n2;
       n2:=n2+lo(Ls0[i]);
       seek(Dbfile0,32*i);
       blockread(Dbfile0,buf,10,errz);
       Impol0[i]:=buf
    end;
  end;
  DbfOpenP0:=res;
end;
function DbfRead0(Zap:longint;Field:integer):string;
var s:string;
    pos:longint;
    lf:integer;
begin
  pos:=Hdsize0+Rsize0*(Zap-1)+Sm0[Field];
  seek(Dbfile0,pos);
  lf:=lo(Ls0[Field]);
  blockread(Dbfile0,s[1],lf,errz);
  s[0]:=chr(lf);
  DbfRead0:=s;
end;
{$R-}
function DbfReadR0(Zap:longint;Field:integer;var Bad:boolean):real;
var s:string;
    pos:longint;
    lf:integer;
    r:real;
begin
  pos:=Hdsize0+Rsize0*(Zap-1)+Sm0[Field];
  seek(Dbfile0,pos);
  lf:=lo(Ls0[Field]);
  blockread(Dbfile0,s[1],lf,errz);
  s[0]:=chr(lf);
  s:=Trim(s);
  val(s,r,lf);
  Bad:=true;
  if lf=0 then DbfReadR0:=r else begin DbfReadR0:=0;Bad:=false end
end;
function DbfReadI0(Zap:longint;Field,Bad:integer):integer;
var s:string;
    pos:longint;
    lf:integer;
    r:integer;
begin
  pos:=Hdsize0+Rsize0*(Zap-1)+Sm0[Field];
  seek(Dbfile0,pos);
  lf:=lo(Ls0[Field]);
  blockread(Dbfile0,s[1],lf,errz);
  s[0]:=chr(lf);
  s:=Trim(s);
  val(s,r,lf);
  if lf=0 then DbfReadI0:=r else DbfReadI0:=Bad
end;
procedure DbfWrite0(s:string;Zap:longint;Field:integer);
var pos:longint;
    lf:integer;
begin
  pos:=Hdsize0+Rsize0*(Zap-1)+Sm0[Field];
  seek(Dbfile0,pos);
  lf:=lo(Ls0[Field]);
  if length(s)<lf then repeat s:=s+' ' until length(s)=lf;
  blockwrite(Dbfile0,s[1],lf,errz);
end;
procedure DbfWriteR0(R:real;f:shortint;Zap:longint;Field:integer);
var pos:longint;
    lf:integer;
    s:string;
    n0:real;
    m,d,f1,f2:byte;
begin
  pos:=Hdsize0+Rsize0*(Zap-1)+Sm0[Field];
  seek(Dbfile0,pos);
  lf:=lo(Ls0[Field]);
  if f<0 then begin
   d:=0;
   if R<0 then begin d:=1;R:=abs(R) end;
   if R<10.0 then m:=0 else begin
      n0:=Int(R);
      m:=Trunc(ln(n0)/log10)
   end;
   f1:=2+m+d;
   if f1>=lf then f2:=0 else f2:=lf-(2+m+d)
  end else f2:=f;
  str(R:lf:f2,s);
  blockwrite(Dbfile0,s[1],lf,errz)
end;
procedure DbfWriteI0(R:integer;Zap:longint;Field:integer);
var pos:longint;
    lf:integer;
    s:string;
begin
  pos:=Hdsize0+Rsize0*(Zap-1)+Sm0[Field];
  seek(Dbfile0,pos);
  lf:=lo(Ls0[Field]);
  str(R:lf,s);
  blockwrite(Dbfile0,s[1],lf,errz)
end;

procedure DbfClose0;
begin
  Hdsize0:=0;
  Rsize0:=0;
  Nzap0:=0;
  NumField0:=0;
  close(Dbfile0);
end;

function DbfLocate0(s:string;Field:integer):longint;
var i,j:longint;
label exl;
begin
  j:=0;
  for i:=dbfcont0 to Nzap0 do begin
    if trim(s)=trim(DbfRead0(i,Field)) then begin
      j:=i;
      goto exl;
    end;
  end;
exl: DbfLocate0:=j;
     dbfcont0:=j+1;
end;

function DbfDelete0(Zap_n,Zap_k:longint):boolean;
label 9;
const rmem=24000;
type Buff=array[1..rmem] of char;
var flag:boolean;
    n0,m,i,k,l:longint;
    BufP:^Buff;
begin
  flag:=false;
  if ((Zap_n>Nzap0)or(Zap_k>Nzap0))or((Zap_n<=0)or(Zap_k<=0)) then goto 9;
  if Zap_n>Zap_k then goto 9;
  k:=Zap_k-Zap_n+1;l:=k*Rsize0;
  New(BufP);
  if Zap_k<Nzap0 then
     for i:=Zap_k to Nzap0-1 do begin
         n0:=Hdsize0+1+i*Rsize0;
         m:=n0-l;
         seek(DbFile0,n0);
         blockread(DbFile0,BufP^,Rsize0,errz);
         seek(DbFile0,m);
         blockwrite(DbFile0,BufP^,Rsize0,errz)
     end;
  Dispose(BufP);
  n0:=Hdsize0+Rsize0*(Nzap0-k);
  seek(DbFile0,n0);
  Truncate(DbFile0);
  Nzap0:=Nzap0-k;
  seek(DbFile0,4);
  blockwrite(DbFile0,Nzap0,4,errz);
  flag:=true;
9:DbfDelete0:=flag
end;
function DbfAppend0:boolean;
const pust: char=' ';
      eoz : char=chr(26);
var n0,i:longint;
begin
  DbfAppend0:=false;
  if Hdsize0>0 then begin
    i:=Rsize0;
    n0:=i*Nzap0;
    n0:=n0+Hdsize0;
    seek(DbFile0,n0);
    for i:=1 to Rsize0 do
      blockwrite(DbFile0,pust,1,errz);
    blockwrite(DbFile0,eoz,1,errz);
    Nzap0:=Nzap0+1;n0:=Nzap0;
    seek(DbFile0,4);
    blockwrite(DbFile0,n0,4,errz);
    DbfAppend0:=true
  end
end;

function DbfZap0:boolean;
const  eoz : char=chr(26);
var n0:longint;
begin
  DbfZap0:=false;
  if (Hdsize0>0)and(Nzap0>0) then begin
    seek(DbFile0,Hdsize0);
    blockwrite(DbFile0,eoz,1,errz);
    Truncate(DbFile0);
    Nzap0:=0;n0:=0;
    seek(DbFile0,4);
    blockwrite(DbFile0,n0,4,errz);
    DbfZap0:=true
  end
end;
{вход: NumField;
       Ls[j],Typ[j],ImPol[j]
  j=1..NumField}
function  DbfGreate0(s:string):boolean;
  const s0=chr(0);
  var b:string[32];
      p:string[14];
      r:string[1];
      j:byte;
      f:Text;
begin
  DbfGreate0:=false;
  p:=CharStr(s0,14);
  r[1]:=chr(13);
  Nzap0:=0;
  HdSize0:=32+NumField0*32+1;
  RSize0:=1;
  for j:=1 to NumField0 do RSize0:=RSize0+Ls0[j];
  assign(Dbfile0,s);rewrite(DbFile0,1);
  b:=chr(3);b:=PadCh(b,s0,4);
  blockwrite(DbFile0,b[1],4,errz);
  blockwrite(DbFile0,Nzap0,4,errz);
  blockwrite(DbFile0,HdSize0,2,errz);
  blockwrite(DbFile0,RSize0,2,errz);
  b:=CharStr(s0,20);
  blockwrite(DbFile0,b[1],20,errz);
  for j:=1 to NumField0 do begin
      b:=ImPol0[j]+s0+Typ0[j]+s0+s0+s0+s0;
      blockwrite(DbFile0,b[1],16,errz);
      blockwrite(DbFile0,Ls0[j],2,errz);
      blockwrite(DbFile0,p[1],14,errz)
  end;
  blockwrite(DbFile0,r[1],1,errz);
  Close(Dbfile0);
  DbfGreate0:=true
end;
function  DbfMetka0(Zap:longint;Metka:string):boolean;
var pos:longint;
begin
  DbfMetka0:=false;
  if Zap<=Nzap0 then begin
     pos:=Hdsize0+Rsize0*(Zap-1);
     seek(Dbfile0,pos);
     blockwrite(Dbfile0,Metka[1],1,errz);
     DbfMetka0:=true
  end
end;
function  DbfAktiv0(Zap:longint):boolean;
var pos:longint;
    s:string;
begin
  DbfAktiv0:=true;
  if Zap<=Nzap0 then begin
     pos:=Hdsize0+Rsize0*(Zap-1);
     seek(Dbfile0,pos);
     blockread(Dbfile0,s[1],1,errz);
     if s[1]='*' then DbfAktiv0:=false
  end
end;
function  DbfSlovarO0(Field:integer):boolean;
  var j:byte;
      pr:char;
begin
  if (Field>0)and(Field<=NumField0) then begin
   pr:=chr(32);
   UkPol0[Field]:=PadCh(UkPol0[Field],pr,8);
   pr:=chr(RgPol0[Field]);
   seek(DbFile0,23+32*Field);
   blockwrite(DbFile0,pr,1,errz);
   for j:=1 to 8 do blockwrite(DbFile0,UkPol0[Field,j],1,errz);
   DbfSlovarO0:=true
  end else DbfSlovarO0:=false
end;
Function DbfSlovarI0(Field:integer):boolean;
  var i:byte;
      sb:string;
      cb:char;
begin
  DbfSlovarI0:=false;
  if (Field>0)and(Field<=NumField0) then begin
   seek(DbFile0,24+32*Field-1);
   UkPol0[Field]:='';
   blockread(DbFile0,cb,1,errz);
   RgPol0[Field]:=ord(cb);
   for i:=1 to 8 do begin
       blockread(DbFile0,cb,1,errz);
       UkPol0[Field]:=UkPol0[Field]+cb
   end;
   if length(Trim(UkPol0[Field]))>0 then DbfSlovarI0:=true
  end
end;
{$R+}
begin
 { Hdsize[1]:=0;Rsize[1]:=0;Nzap[1]:=0;NumField[1]:=0;dbfcont[1]:=1;
  Hdsize[2]:=0;Rsize[2]:=0;Nzap[2]:=0;NumField[2]:=0;dbfcont[2]:=1;
  Hdsize[3]:=0;Rsize[3]:=0;Nzap[3]:=0;NumField[3]:=0;dbfcont[3]:=1;}
  log10:=ln(10.0)
end.
