program EnumDemo12;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  SysUtils,
  Classes;

type
  TEnumFibonacci = class
  strict private
    FData: array of Cardinal;
    FCurrentIndex: Integer;

    function GetCurrent: Cardinal;
  public
    constructor Create(const ANumElements: Word);

    function MoveNext: Boolean;

    function GetEnumerator: TEnumFibonacci;

    property Current: Cardinal read GetCurrent;
  end;

{ TEnumFibonacci }

constructor TEnumFibonacci.Create(const ANumElements: Word);
var
  i: Integer;
begin
  SetLength(FData, ANumElements);

  if ANumElements >= 1 then
    FData[0] := 1;
  if ANumElements >= 2 then
    FData[1] := 1;

  for i := 2 to ANumElements - 1 do
    FData[i] := FData[i - 1] + FData[i - 2];

  FCurrentIndex := -1;
end;

function TEnumFibonacci.GetCurrent: Cardinal;
begin
  Result := FData[FCurrentIndex];
end;

function TEnumFibonacci.GetEnumerator: TEnumFibonacci;
begin
  Result := Self;
end;

function TEnumFibonacci.MoveNext: Boolean;
begin
  Inc(FCurrentIndex);
  Result := FCurrentIndex <= High(FData);
end;

function FibEnum(const ANumElements: Word): TEnumFibonacci;
begin
  Result := TEnumFibonacci.Create(ANumElements);
end;

var
  n: Cardinal;

begin
  for n in FibEnum(10) do
    Write(n, ' ');

  Readln;
end.


