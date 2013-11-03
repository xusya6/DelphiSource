program EnumDemo1;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  SysUtils;

var
  c: Char;
  i: Integer;

  Str: string;
  IntArray: array of Integer;

begin

  Str := 'abcdef';

  // перебор символов в строке
  for c in Str do
    Write(c, ' ');

  Writeln;


  Randomize;

  SetLength(IntArray, 5);
  for i := Low(IntArray) to High(IntArray) do
    IntArray[i] := Random(100);

  // перебор элементов в массиве
  for i in IntArray do
    Write(i, ' ');

  Writeln;

  Readln;
end.
