unit uFormMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Datasnap.DBClient, Vcl.StdCtrls,
  MidasLib;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    cdsMain: TClientDataSet;
    cdsMainID: TIntegerField;
    cdsMainname: TStringField;
    procedure FormCreate(Sender: TObject);
  private
    procedure FillDataSet;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

type
  TDataSetEnumerator = class
  private
    FDataSet: TDataSet;
    FCounter: Integer;
    function GetCurrent: Integer;
  public
    constructor Create(ADataSet: TDataSet);

    function MoveNext: Boolean;
    property Current: Integer read GetCurrent;
  end;

constructor TDataSetEnumerator.Create(ADataSet: TDataSet);
begin
  inherited Create;

  FDataSet := ADataSet;
  FCounter := -1;
end;

function TDataSetEnumerator.GetCurrent: Integer;
begin
  Result := FCounter;
end;

function TDataSetEnumerator.MoveNext: Boolean;
begin
  if FCounter < 0 then
  begin
    FDataSet.First;
    FCounter := 0;
  end
  else
  begin
    FDataSet.Next;
    Inc(FCounter);
  end;

  Result := not FDataSet.EoF;
end;

type
  TDataSetHelper = class helper for TDataSet
  public
    function GetEnumerator: TDataSetEnumerator;
  end;

function TDataSetHelper.GetEnumerator: TDataSetEnumerator;
begin
  Result := TDataSetEnumerator.Create(Self);
end;

procedure TForm1.FillDataSet;
begin
  cdsMain.CreateDataSet;

  cdsMain.Append;
  cdsMain.FieldByName('id').AsInteger  := 1;
  cdsMain.FieldByName('name').AsString := 'name1';
  cdsMain.Post;

  cdsMain.Append;
  cdsMain.FieldByName('id').AsInteger  := 2;
  cdsMain.FieldByName('name').AsString := 'name2';
  cdsMain.Post;

  cdsMain.Append;
  cdsMain.FieldByName('id').AsInteger  := 3;
  cdsMain.FieldByName('name').AsString := 'name3';
  cdsMain.Post;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  recNo: Integer;
begin
  FillDataSet;

  for recNo in cdsMain do
    Memo1.Lines.Add(Format('ID: %s NAME: %s',
      [ cdsMain.FieldByName('id').AsString,
        cdsMain.FieldByName('name').AsString
      ]));
end;

end.
