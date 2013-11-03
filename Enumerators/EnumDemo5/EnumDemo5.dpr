program EnumDemo5;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  SysUtils,
  Classes;

var
  StrList: TStringList;
  StrListEnum: TStringsEnumerator;

begin
  StrList := TStringList.Create;
  try
    StrList.Add('str1');
    StrList.Add('str2');
    StrList.Add('str3');

    // ������� ������ Enumerator
    StrListEnum := StrList.GetEnumerator;
    try
      // � ����� ���������� ��� ��������
      while StrListEnum.MoveNext do
        Writeln(StrListEnum.Current);
    finally
      FreeAndNil(StrListEnum);
    end;

  finally
    FreeAndNil(StrList);
  end;

  Readln;
end.
