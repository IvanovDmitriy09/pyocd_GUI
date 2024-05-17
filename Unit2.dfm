object Form2: TForm2
  Left = 1081
  Top = 293
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1044#1086#1073#1072#1074#1080#1090#1100' target'
  ClientHeight = 169
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
    Height = 57
    Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' target '#1080#1079' '#1089#1077#1090#1080
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 27
      Width = 83
      Height = 13
      Caption = #1053#1072#1079#1074#1072#1085#1080#1077' target:'
    end
    object Button1: TButton
      Left = 222
      Top = 24
      Width = 75
      Height = 21
      Hint = #1047#1072#1075#1088#1091#1079#1080#1090#1100' target '#1080#1079' '#1089#1077#1090#1080
      Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = Button1Click
    end
    object Edit1: TEdit
      Left = 96
      Top = 24
      Width = 121
      Height = 21
      TabOrder = 1
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 72
    Width = 313
    Height = 89
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100' target '#1080#1079' '#1092#1072#1081#1083#1072
    TabOrder = 1
    object Label2: TLabel
      Left = 91
      Top = 28
      Width = 3
      Height = 13
    end
    object Button2: TButton
      Left = 8
      Top = 24
      Width = 73
      Height = 21
      Hint = #1042#1099#1073#1088#1072#1090#1100' '#1092#1072#1081#1083
      Caption = #1060#1072#1081#1083' *.pack'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 8
      Top = 56
      Width = 75
      Height = 21
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' target '#1080#1079' '#1092#1072#1081#1083#1072
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = Button3Click
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 216
    Top = 96
  end
  object AbUnZipper1: TAbUnZipper
    Left = 248
    Top = 96
  end
  object XMLDocument1: TXMLDocument
    Left = 184
    Top = 96
    DOMVendorDesc = 'MSXML'
  end
end
