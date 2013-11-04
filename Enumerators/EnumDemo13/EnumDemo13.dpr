program EnumDemo13;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  Generics.Collections, SysUtils;

type
  TUnivEnumerator<_DataType, _IteratorType> = class(TEnumerator<_DataType>)
  type
    TGetCurrent = function (const AIterator: _IteratorType): _DataType of object;
    TMoveNext   = function (var AIterator: _IteratorType): Boolean of object;

  strict private
    FGetCurrent : TGetCurrent;
    FMoveNext   : TMoveNext;
    FCurrentPos : _IteratorType;
    FStartPos   : _IteratorType;

  strict protected
    function DoGetCurrent: _DataType; override;
    function DoMoveNext: Boolean; override;
  public
    constructor Create(const AStartPos    : _IteratorType;
                       const AGetCurrent : TGetCurrent;
                       const AMoveNext   : TMoveNext);

    function GetEnumerator: TEnumerator<_DataType>;
  end;

{ TUnivEnumerator }

constructor TUnivEnumerator<_DataType, _IteratorType>.Create(const AStartPos: _IteratorType;
  const AGetCurrent: TGetCurrent; const AMoveNext: TMoveNext);
begin
  FStartPos   := AStartPos;
  FCurrentPos := FStartPos;
  FGetCurrent := AGetCurrent;
  FMoveNext   := AMoveNext;
end;

function TUnivEnumerator<_DataType, _IteratorType>.DoGetCurrent: _DataType;
begin
  Result := FGetCurrent(FCurrentPos)
end;

function TUnivEnumerator<_DataType, _IteratorType>.DoMoveNext: Boolean;
begin
  Result := FMoveNext(FCurrentPos);
end;

function TUnivEnumerator<_DataType, _IteratorType>.GetEnumerator: TEnumerator<_DataType>;
begin
  Result := Self;
end;

type
  TIntArray = array of Integer;

  TMyClass = class
  type
    TUnivEnumeratorSpec = TUnivEnumerator<Integer, Integer>;

  strict private
    FData: TIntArray;

    function EnumGetCurrent(const AIndex: Integer): Integer;
    function EnumMoveNext(var AIndex: Integer): Boolean;
    function EnumMoveNextReverse(var AIndex: Integer): Boolean;
  public
    constructor Create;

    function GetEnumerator: TUnivEnumeratorSpec;
    function Reverse: TUnivEnumeratorSpec;
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

function TMyClass.EnumGetCurrent(const AIndex: Integer): Integer;
begin
  Result := FData[AIndex];
end;

function TMyClass.EnumMoveNext(var AIndex: Integer): Boolean;
begin
  Inc(AIndex);
  Result := AIndex <= High(FData);
end;

function TMyClass.EnumMoveNextReverse(var AIndex: Integer): Boolean;
begin
  Dec(AIndex);
  Result := AIndex >= 0;
end;

function TMyClass.GetEnumerator: TUnivEnumeratorSpec;
begin
  Result := TUnivEnumeratorSpec.Create(-1, EnumGetCurrent, EnumMoveNext);
end;

function TMyClass.Reverse: TUnivEnumeratorSpec;
begin
  Result := TUnivEnumeratorSpec.Create(Length(FData), EnumGetCurrent, EnumMoveNextReverse);
end;

var
  MyObj: TMyClass;
  i: Integer;
begin
  MyObj := TMyClass.Create;
  try
    for i in MyObj do
      Write(i, ' ');

    Writeln;

    for i in MyObj.Reverse do
      Write(i, ' ');
  finally
    FreeAndNil(MyObj);
  end;

  Readln;
end.


