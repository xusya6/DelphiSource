program EnumDemo7;

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

    function GetCurrent: Integer;
  public
    constructor Create(const AIntArray: TIntArray);

    function MoveNext: Boolean;

    property Current: Integer read GetCurrent;
  end;

  TMyEnumeratorReverse = class
  strict private
    FData: TIntArray;
    FCurrentIndex: Integer;

    function GetCurrent: Integer;
  public
    constructor Create(const AIntArray: TIntArray);
    destructor Destroy; override;

    function MoveNext: Boolean;

    function GetEnumerator: TMyEnumeratorReverse;

    property Current: Integer read GetCurrent;
  end;

  TMyClass = class
  strict private
    FData: TIntArray;
  public
    constructor Create;

    function GetEnumerator: TMyEnumerator;
    function Reverse: TMyEnumeratorReverse;
  end;

{ TMyEnumeratorClass }

constructor TMyEnumerator.Create(const AIntArray: TIntArray);
begin
  FData := AIntArray;
  FCurrentIndex := -1;
end;

function TMyEnumerator.GetCurrent: Integer;
begin
  Result := FData[FCurrentIndex];
end;

function TMyEnumerator.MoveNext: Boolean;
begin
  Inc(FCurrentIndex);
  Result := FCurrentIndex <= High(FData);
end;

{ TMyClass }

constructor TMyClass.Create;
var
  i: Integer;
begin
  // Заполняем данными для теста
  SetLength(FData, 5);
  for i := Low(FData) to High(FData) do
    FData[i] := i * 10;
end;

function TMyClass.GetEnumerator: TMyEnumerator;
begin
  Result := TMyEnumerator.Create(FData);
end;

function TMyClass.Reverse: TMyEnumeratorReverse;
begin
  Writeln('TMyClass.Reverse');
  Result := TMyEnumeratorReverse.Create(FData);
end;

{ TMyEnumeratorReverse }

constructor TMyEnumeratorReverse.Create(const AIntArray: TIntArray);
begin
  Writeln('TMyEnumeratorReverse.Create');

  FData := AIntArray;
  FCurrentIndex := Length(FData);
end;

destructor TMyEnumeratorReverse.Destroy;
begin
  Writeln('TMyEnumeratorReverse.Destroy');

  inherited;
end;

function TMyEnumeratorReverse.GetCurrent: Integer;
begin
  Result := FData[FCurrentIndex];
end;

function TMyEnumeratorReverse.GetEnumerator: TMyEnumeratorReverse;
begin
  Writeln('TMyEnumeratorReverse.GetEnumerator');

  Result := Self;
end;

function TMyEnumeratorReverse.MoveNext: Boolean;
begin
  Dec(FCurrentIndex);
  Result := FCurrentIndex >= Low(FData);
end;

var
  i: Integer;
  MyObj: TMyClass;

begin
  MyObj := TMyClass.Create;
  try
    for i in MyObj.Reverse do
      Writeln('Writeln ', i);
  finally
    FreeAndNil(MyObj);
  end;

  Readln;
end.


