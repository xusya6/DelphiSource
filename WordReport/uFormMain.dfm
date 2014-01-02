object Form1: TForm1
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Form1'
  ClientHeight = 326
  ClientWidth = 219
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object eFname: TLabeledEdit
    Left = 24
    Top = 37
    Width = 169
    Height = 21
    EditLabel.Width = 44
    EditLabel.Height = 13
    EditLabel.Caption = #1060#1072#1084#1080#1083#1080#1103
    TabOrder = 0
    Text = #1055#1077#1090#1088#1086#1074
  end
  object eName: TLabeledEdit
    Left = 24
    Top = 77
    Width = 169
    Height = 21
    EditLabel.Width = 19
    EditLabel.Height = 13
    EditLabel.Caption = #1048#1084#1103
    TabOrder = 1
    Text = #1055#1077#1090#1103
  end
  object bReport: TButton
    Left = 24
    Top = 288
    Width = 161
    Height = 25
    Caption = #1054#1090#1095#1105#1090
    TabOrder = 2
    OnClick = bReportClick
  end
  object RichEdit1: TRichEdit
    Left = 24
    Top = 128
    Width = 169
    Height = 137
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Lines.Strings = (
      'RichEdit1')
    ParentFont = False
    TabOrder = 3
  end
end
