program EnumDemo4;

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
    destructor Destroy; override;

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

  // ������������� ������ ����� -1, ��� ��� ������� �����
  // ������ MoveNext, � ��� ����� GetCurrent
  FCurrentIndex := -1;

  Writeln('TMyEnumeratorClass.Create');
end;

destructor TMyEnumeratorClass.Destroy;
begin
  Writeln('TMyEnumeratorClass.Destroy');
  inherited;
end;

function TMyEnumeratorClass.GetCurrent: Integer;
begin
  Result := FData[FCurrentIndex];
  Writeln('TMyEnumeratorClass.GetCurrent');
end;

function TMyEnumeratorClass.MoveNext: Boolean;
begin
  // ����� ������ ��������� ��� ��������:
  //  1. ���������� ������� � ���������� ��������
  //  2. ������� True ���� �������� �� ��������� � False ���� ���������
  Inc(FCurrentIndex);
  Result := FCurrentIndex <= High(FData);

  Writeln('TMyEnumeratorClass.MoveNext');
end;

{ TMyClass }

constructor TMyClass.Create;
var
  i: Integer;
begin
  // ��������� ������� ��� �����
  SetLength(FData, 3);
  for i := Low(FData) to High(FData) do
    FData[i] := i * 10;
end;

function TMyClass.GetEnumerator: TMyEnumeratorClass;
begin
  // ������ ������ ������������� ��������� ��� � ����� ������
  Result := TMyEnumeratorClass.Create(FData);
end;

var
  i: Integer;
  MyObj: TMyClass;

begin
  MyObj := TMyClass.Create;
  try
    for i in MyObj  do
      Writeln('Writeln ', i);
  finally
    FreeAndNil(MyObj);
  end;

  Readln;
end.

