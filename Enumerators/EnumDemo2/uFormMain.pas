unit uFormMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  Comp: TComponent;
  Str: string;
  StrList: TStringList;

begin
  for Comp in Self do
    Memo1.Lines.Add(Comp.Name);

  Memo1.Lines.Add('');

  StrList := TStringList.Create;
  try
    StrList.Add('first');
    StrList.Add('second');

    for Str in StrList do
      Memo1.Lines.Add(Str);

  finally
    FreeAndNil(StrList);
  end;
end;

end.
