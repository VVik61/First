{
         ==========================================================
                                 LazLocalRU
         ==========================================================

                     Модуль для русификации приложения

         ==========================================================
         ======================  ngdream.ru  ======================
         ==========================================================
}

unit LazLocalRU;

{$mode ObjFPC}{$H+}

interface

uses
  SysUtils, LResources, Translations;

function TranslateUnitResourceStrings: boolean;

implementation

// Функция для локализации приложения
function TranslateUnitResourceStrings: boolean;
var
  r: TLResource;
  POFile: TPOFile;
  langfile: string;
begin
  langfile:='lclstrconsts.ru';
  r:=LazarusResources.Find(langfile,'PO');
  POFile:=TPOFile.Create;
  try
    POFile.ReadPOText(r.Value);
    Result:=Translations.TranslateUnitResourceStrings('lclstrconsts',POFile);
  finally
    FreeAndNil(POFile);
  end;
end;

initialization
{$I langfile_ru.lrs}

end.

