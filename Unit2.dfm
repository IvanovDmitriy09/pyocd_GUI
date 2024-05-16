object Form2: TForm2
  Left = 1095
  Top = 304
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1044#1086#1073#1072#1074#1080#1090#1100' target'
  ClientHeight = 234
  ClientWidth = 329
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 313
    Height = 73
    Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' target '#1080#1079' '#1089#1077#1090#1080
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 35
      Width = 83
      Height = 13
      Caption = #1053#1072#1079#1074#1072#1085#1080#1077' target:'
    end
    object Button1: TButton
      Left = 222
      Top = 32
      Width = 75
      Height = 21
      Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100
      TabOrder = 0
      OnClick = Button1Click
    end
    object Edit1: TEdit
      Left = 96
      Top = 32
      Width = 121
      Height = 21
      TabOrder = 1
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 88
    Width = 313
    Height = 97
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100' target '#1083#1086#1082#1072#1083#1100#1085#1086
    TabOrder = 1
    object Label2: TLabel
      Left = 88
      Top = 28
      Width = 3
      Height = 13
    end
    object Label3: TLabel
      Left = 88
      Top = 62
      Width = 3
      Height = 13
    end
    object Button2: TButton
      Left = 8
      Top = 24
      Width = 73
      Height = 21
      Caption = #1060#1072#1081#1083' *.pack'
      TabOrder = 0
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 8
      Top = 56
      Width = 75
      Height = 25
      Caption = #1060#1072#1081#1083' *.pdsc'
      TabOrder = 1
      OnClick = Button3Click
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 120
    Top = 192
  end
end
