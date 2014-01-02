unit uFormMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,  ComObj, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls;

type
  TForm1 = class(TForm)
    eFname: TLabeledEdit;
    eName: TLabeledEdit;
    bReport: TButton;
    RichEdit1: TRichEdit;
    procedure bReportClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FNum: Word;

    procedure InsertRtf(const ARange: OleVariant);
    procedure ReplaceField(const ADocument: OleVariant);
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  RichEdit1.PlainText := False;
  RichEdit1.Lines.LoadFromFile(ExtractFilePath(Application.ExeName) + 'myrtf.rtf');
end;

procedure TForm1.InsertRtf(const ARange: OleVariant);
var
  FileName: string;
begin
  FileName := ExtractFilePath(Application.ExeName) + 'rtf_templeate.rtf';

  RichEdit1.Lines.SaveToFile(FileName);

  ARange.InsertFile(FileName := FileName, ConfirmConversions := False);
end;

procedure TForm1.ReplaceField(const ADocument: OleVariant);
var
  i: Integer;
  BookmarkName: string;
  Range: OleVariant;

  function CompareBm(ABmName: string; const AName: string): Boolean;
  var
    i: Integer;
  begin
    i := Pos('__', ABmName);
    if i > 0 then
      Delete(ABmName, i, Length(ABmName) - i + 1);

    Result := SameText(ABmName, AName);
  end;

begin
  for i := ADocument.Bookmarks.Count downto 1 do
  begin
    BookmarkName := ADocument.Bookmarks.Item(i).Name;
    Range := ADocument.Bookmarks.Item(i).Range;

    if CompareBm(BookmarkName, 'fname') then
      Range.Text := eFname.Text
    else
    if CompareBm(BookmarkName, 'name') then
      Range.Text := eName.Text
    else
    if CompareBm(BookmarkName, 'num') then
      Range.Text := IntToStr(FNum)
    else
    if CompareBm(BookmarkName, 'report') then
      InsertRtf(Range);
  end;
end;

procedure TForm1.bReportClick(Sender: TObject);
var
  TempleateFileName: string;
  WordApp, Document: OleVariant;
begin
  TempleateFileName := ExtractFilePath(Application.ExeName) + 'report.dot';


  try
    // Если Word уже запущен то получаем его интерфейс
    WordApp := GetActiveOleObject('Word.Application');
  except
    try
      // Если нет то запускаем
      WordApp := CreateOleObject('Word.Application');
    except
      on E: Exception do
      begin
        ShowMessage('Не удалось запустить Word!'#13#10 + E.Message);
        Exit;
      end;
    end;
  end;

  try
    Screen.Cursor := crHourGlass;

    // Создание нового документа на основе шаблона
    Document := WordApp.Documents.Add(Template := TempleateFileName, NewTemplate := False);

    // Заменяем поля
    ReplaceField(Document);

    // По умолчание окно Word скрыто, делаем его видимым с готовым отчетом
    WordApp.Visible := True;

  finally
    // Необходимо для удаления экземпляра Word.
    WordApp := Unassigned;

    Screen.Cursor := crDefault;
  end;

  Inc(FNum);
end;

end.
