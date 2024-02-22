object Form1: TForm1
  Left = 405
  Top = 180
  Width = 1155
  Height = 506
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 72
    Top = 72
    Width = 89
    Height = 25
    Caption = #1055#1088#1086#1095#1080#1090#1072#1090#1100' Flash'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 200
    Top = 72
    Width = 75
    Height = 25
    Caption = 'Button2'
    TabOrder = 1
  end
  object Memo1: TMemo
    Left = 8
    Top = 112
    Width = 505
    Height = 289
    Lines.Strings = (
      'Memo1')
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object StringGrid1: TStringGrid
    Left = 536
    Top = 112
    Width = 417
    Height = 289
    ColCount = 17
    DefaultColWidth = 20
    DefaultRowHeight = 20
    RowCount = 6
    TabOrder = 3
  end
  object Edit1: TEdit
    Left = 664
    Top = 80
    Width = 65
    Height = 21
    MaxLength = 8
    TabOrder = 4
    Text = '0'
    OnKeyPress = Edit1KeyPress
  end
  object Edit2: TEdit
    Left = 768
    Top = 80
    Width = 57
    Height = 21
    MaxLength = 7
    TabOrder = 5
    Text = '64'
    OnKeyPress = Edit2KeyPress
  end
  object Edit3: TEdit
    Left = 832
    Top = 80
    Width = 121
    Height = 21
    TabOrder = 6
    Text = 'nRF52832_xxAA'
  end
  object OpenDialog1: TOpenDialog
    Left = 912
    Top = 40
  end
  object SaveDialog1: TSaveDialog
    Left = 944
    Top = 40
  end
end
