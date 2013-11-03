program EnumDemo9;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  SysUtils,
  Classes;

type
  TStringListEnumReverse = class
  strict private
    FStrList: TStringList;
    FCurrentIndex: Integer;

    function GetCurrent: string;
  public
    constructor Create(const AStrList: TStringList);

    function MoveNext: Boolean;

    function GetEnumerator: TStringListEnumReverse;

    property Current: string read GetCurrent;
  end;

  TStringListHelper = class helper for TStringList
    function Reverse: TStringListEnumReverse;
  end;

var
  StrList: TStringList;
  Str: string;

{ TStringListEnumReverse }

constructor TStringListEnumReverse.Create(const AStrList: TStringList);
begin
  FStrList := AStrList;
  FCurrentIndex := FStrList.Count;
end;

function TStringListEnumReverse.GetCurrent: string;
begin
  Result := FStrList[FCurrentIndex];
end;

function TStringListEnumReverse.GetEnumerator: TStringListEnumReverse;
begin
  Result := Self;
end;

function TStringListEnumReverse.MoveNext: Boolean;
begin
  Dec(FCurrentIndex);
  Result := FCurrentIndex >= 0;
end;

{ TStringListHelper }

function TStringListHelper.Reverse: TStringListEnumReverse;
begin
  Result := TStringListEnumReverse.Create(Self);
end;

begin
  StrList := TStringList.Create;
  try
    StrList.Add('str1');
    StrList.Add('str2');
    StrList.Add('str3');

    for Str in StrList.Reverse do
      Writeln(Str);
  finally
    FreeAndNil(StrList);
  end;

  Readln;
end.
