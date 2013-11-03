program EnumDemo3;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  SysUtils;

type
  TIntArray = array of Integer;

  TMyEnumeratorClass = class
  strict private
    FData: TIntArray;
    FCurrentIndex: Integer;

    function GetCurrent: Integer;
  public
    constructor Create(const AIntArray: TIntArray);

    function MoveNext: Boolean;

    property Current: Integer read GetCurrent;
  end;

  TMyClass = class
  strict private
    FData: TIntArray;
  public
    constructor Create;

    function GetEnumerator: TMyEnumeratorClass;
  end;

{ TMyEnumeratorClass }

constructor TMyEnumeratorClass.Create(const AIntArray: TIntArray);
begin
  FData := AIntArray;

  // Первоначально индекс равен -1, так как сначала будет
  // вызван MoveNext, а уже потом GetCurrent
  FCurrentIndex := -1;
end;

function TMyEnumeratorClass.GetCurrent: Integer;
begin
  Result := FData[FCurrentIndex];
end;

function TMyEnumeratorClass.MoveNext: Boolean;
begin
  // Метод должен выполнять два действия:
  //  1. Произвести переход к следующему элементу
  //  2. Вернуть True если элементы не кончились и False если кончились
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

function TMyClass.GetEnumerator: TMyEnumeratorClass;
begin
  // Объект класса перечислителя создается как и любой другой
  Result := TMyEnumeratorClass.Create(FData);
end;

var
  i: Integer;
  MyObj: TMyClass;

begin
  MyObj := TMyClass.Create;
  try
    for i in MyObj  do
      Write(i, ' ');
  finally
    FreeAndNil(MyObj);
  end;

  Readln;
end.
