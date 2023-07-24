unit Un_AnsiOem;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, LazUTF8, Dialogs;

procedure ShowInAllCodir(s: string); {выводит s в разных кодировках}

function StrOemToAnsi(const S: String): String; {Преобразует s в DOS-кодировке в s Win-кодировкe (извратно, ч/з UTF8!) }

function StrAnsiToOem(const S: String): String; {Преобразует s в Win-кодировке в s DOS-кодировкe (извратно, ч/з UTF8!) }


implementation

procedure ShowInAllCodir(s: string);
begin
 Showmessage('UTF8ToConsole(s)= '+UTF8ToConsole(s)+#13+
 'ConsoleToUTF8(s)= '+ConsoleToUTF8(s)+#13+
 'UTF8ToWinCP(s)= '+UTF8ToWinCP(s)+#13+
 'WinCPToUTF8(s)= '+WinCPToUTF8(s));
end;

function StrOemToAnsi(const S: String): String;
begin
 result:= UTF8ToWinCP(ConsoleToUTF8(s));
end;

function StrAnsiToOem(const S: String): String;
begin
 result:= UTF8ToConsole(WinCPToUTF8(s));
end;


end.

