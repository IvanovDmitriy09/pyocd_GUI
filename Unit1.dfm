object Form1: TForm1
  Left = 313
  Top = 165
  Width = 976
  Height = 515
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
  object Label1: TLabel
    Left = 344
    Top = 115
    Width = 41
    Height = 13
  end
  object Label2: TLabel
    Left = 128
    Top = 83
    Width = 47
    Height = 13
    Caption = #1072#1076#1088#1077#1089': 0x'
  end
  object Label3: TLabel
    Left = 248
    Top = 83
    Width = 87
    Height = 13
    Caption = #1082#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1073#1072#1081#1090':'
  end
  object Label4: TLabel
    Left = 128
    Top = 115
    Width = 47
    Height = 13
    Caption = #1072#1076#1088#1077#1089': 0x'
  end
  object Button1: TButton
    Left = 16
    Top = 80
    Width = 89
    Height = 25
    Caption = #1055#1088#1086#1095#1080#1090#1072#1090#1100' Flash'
    Enabled = False
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 16
    Top = 144
    Width = 89
    Height = 25
    Caption = #1054#1095#1080#1089#1090#1080#1090#1100' Flash'
    Enabled = False
    TabOrder = 1
    OnClick = Button2Click
  end
  object Memo1: TMemo
    Left = 16
    Top = 176
    Width = 505
    Height = 289
    Lines.Strings = (
      'Memo1')
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object StringGrid1: TStringGrid
    Left = 528
    Top = 176
    Width = 417
    Height = 289
    ColCount = 17
    Ctl3D = True
    DefaultColWidth = 20
    DefaultRowHeight = 20
    RowCount = 2
    ParentCtl3D = False
    TabOrder = 3
  end
  object Edit1: TEdit
    Left = 176
    Top = 80
    Width = 65
    Height = 21
    MaxLength = 8
    TabOrder = 4
    Text = '0'
    OnKeyPress = Edit1KeyPress
  end
  object Edit2: TEdit
    Left = 336
    Top = 80
    Width = 57
    Height = 21
    MaxLength = 7
    TabOrder = 5
    Text = '64'
    OnKeyPress = Edit2KeyPress
  end
  object Edit3: TEdit
    Left = 16
    Top = 48
    Width = 121
    Height = 21
    TabOrder = 6
    Text = 'nRF52832_xxAA'
  end
  object Button3: TButton
    Left = 16
    Top = 16
    Width = 57
    Height = 25
    Caption = #1054#1073#1085#1086#1074#1080#1090#1100
    TabOrder = 7
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 16
    Top = 112
    Width = 89
    Height = 25
    Caption = #1047#1072#1087#1080#1089#1072#1090#1100' Flash'
    Enabled = False
    TabOrder = 8
    OnClick = Button4Click
  end
  object ComboBox1: TComboBox
    Left = 80
    Top = 16
    Width = 305
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 9
    OnChange = ComboBox1Change
  end
  object Button5: TButton
    Left = 248
    Top = 112
    Width = 89
    Height = 25
    Caption = #1054#1090#1082#1088#1099#1090#1100
    Enabled = False
    TabOrder = 10
    OnClick = Button5Click
  end
  object Edit4: TEdit
    Left = 176
    Top = 112
    Width = 65
    Height = 21
    MaxLength = 8
    TabOrder = 11
    Text = '0'
    OnKeyPress = Edit4KeyPress
  end
  object OpenDialog1: TOpenDialog
    Left = 912
    Top = 40
  end
  object SaveDialog1: TSaveDialog
    Left = 944
    Top = 40
  end
  object XPManifest1: TXPManifest
    Left = 880
    Top = 40
  end
end
