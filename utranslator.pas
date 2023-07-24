unit uTranslator;

{**********************************************************************
Автор: Alexx2000 » 11.11.2007 00:53:54
из http://www.freepascal.ru/forum/viewtopic.php?f=5&t=2881#
**********************************************************************}

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LResources, GetText, Controls, typinfo, Translations;
type

{ TTranslator }

TTranslator = class(TAbstractTranslator)
private
  FFormClassName : String;
  FPOFile:TPOFile;
public
  constructor Create(POFileName:string);
  destructor Destroy;override;
  procedure TranslateStringProperty(Sender:TObject; const Instance: TPersistent; PropInfo: PPropInfo; var Content:string);override;
end;

var
  POFileName : String;

implementation
uses
  Forms, LCLProc;

{ TTranslator }

constructor TTranslator.Create(POFileName: string);
begin
  inherited Create;
  FPOFile := TPOFile.Create(POFileName);
end;

destructor TTranslator.Destroy;
begin
  FPOFile.Free;
  inherited Destroy;
end;

procedure TTranslator.TranslateStringProperty(Sender: TObject;
  const Instance: TPersistent; PropInfo: PPropInfo; var Content: string);
begin
  if Instance.InheritsFrom(TForm) then
    begin
      FFormClassName := Instance.ClassName;
      DebugLn(UpperCase(FFormClassName + '.'+PropInfo^.Name) + '=' + Content);
      Content := FPOFile.Translate(UpperCase(FFormClassName + '.' + PropInfo^.Name), Content);
    end
  else
    begin
      DebugLn(UpperCase(FFormClassName + '.'+Instance.GetNamePath + '.' + PropInfo^.Name) + '=' + Content);
      Content := FPOFile.Translate(UpperCase(FFormClassName + '.'+Instance.GetNamePath + '.'+ PropInfo^.Name), Content);
    end;
  // convert UTF8 to current local
  Content := UTF8ToSystemCharSet(Content);
end;

initialization
  POFileName := 'x:\Test\language\project1.ru.po'; // для примера
  // присваеваем свой Translator
  LRSTranslator := TTranslator.Create(POFileName);
  {
  Теперь при считывании текстовых Свойств обектов формы будет
вызываться метод TranslateStringProperty
  }
end.
