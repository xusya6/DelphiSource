program EnumDemo8;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  SysUtils;

type
  TIntArray = array of Integer;

  TMyEnumerator = class
  strict private
    FData: TIntArray;
    FCurrentIndex: Integer;
    FMin: Integer;

    function GetCurrent: Integer;
  public
    constructor Create(const AIntArray: TIntArray; const AMin: Integer);
    function GetEnumerator: TMyEnumerator;

    function MoveNext: Boolean;
    property Current: Integer read GetCurrent;
  end;

  TMyClass = class
  strict private
    FData: TIntArray;
  public
    constructor Create;

    function GetMyEnumerator(const AMin: Integer): TMyEnumerator;
  end;

{ TMyEnumerator }

constructor TMyEnumerator.Create(const AIntArray: TIntArray; const AMin: Integer);
begin
  FData := AIntArray;
  FMin := AMin;

  FCurrentIndex := -1;
end;

function TMyEnumerator.GetCurrent: Integer;
begin
  Result := FData[FCurrentIndex];
end;

function TMyEnumerator.GetEnumerator: TMyEnumerator;
begin
  Result := Self;
end;

function TMyEnumerator.MoveNext: Boolean;
begin
  repeat
    Inc(FCurrentIndex);
    Result := FCurrentIndex <= High(FData);

    if not Result then
      Exit;

    if FData[FCurrentIndex] >= FMin then
      Exit
    else
      Continue;
  until False;
end;

{ TMyClass }

constructor TMyClass.Create;
var
  i: Integer;
begin
  // Заполняем данными для теста
  SetLength(FData, 6);
  FData[0] := 1;
  FData[1] := 8;
  FData[2] := 3;
  FData[3] := 5;
  FData[4] := 10;
  FData[5] := 2;
end;

function TMyClass.GetMyEnumerator(const AMin: Integer): TMyEnumerator;
begin
  Result := TMyEnumerator.Create(FData, AMin);
end;

var
  i: Integer;
  MyObj: TMyClass;

begin
  MyObj := TMyClass.Create;
  try
    for i in MyObj.GetMyEnumerator(5) do
      Write(i, ' ');
  finally
    FreeAndNil(MyObj);
  end;

  Readln;
end.



