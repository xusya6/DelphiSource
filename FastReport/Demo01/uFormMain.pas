unit uFormMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, frxClass;

type
  TForm1 = class(TForm)
    Button1: TButton;
    frxReport1: TfrxReport;
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
begin
  if frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName) + 'report.fr3') then
    frxReport1.ShowReport;
end;

end.
