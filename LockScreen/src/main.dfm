object frmmain: Tfrmmain
  Left = 595
  Top = 311
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #20445#25252#35270#21147#19987#29992#36719#20214' V1.0'
  ClientHeight = 106
  ClientWidth = 366
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel
    Left = 4
    Top = 17
    Width = 28
    Height = 14
    Caption = #27599#38548
  end
  object Label2: TLabel
    Left = 108
    Top = 17
    Width = 119
    Height = 14
    Caption = #20998#38047#25552#37266' (30-120)'
  end
  object CheckBox1: TCheckBox
    Left = 4
    Top = 65
    Width = 117
    Height = 33
    Caption = #38656#35201#22768#38899#25552#37266
    TabOrder = 0
  end
  object CheckBox2: TCheckBox
    Left = 4
    Top = 43
    Width = 125
    Height = 25
    Caption = #38656#35201#38145#23631
    TabOrder = 1
  end
  object Button2: TButton
    Left = 264
    Top = 11
    Width = 97
    Height = 23
    Caption = #20445#23384#35774#32622
    TabOrder = 2
    OnClick = Button2Click
  end
  object SpinEdit1: TSpinEdit
    Left = 38
    Top = 13
    Width = 65
    Height = 23
    MaxValue = 120
    MinValue = 1
    TabOrder = 3
    Value = 1
    OnKeyPress = SpinEdit1KeyPress
  end
  object Button3: TButton
    Left = 264
    Top = 77
    Width = 97
    Height = 23
    Caption = #36864#20986
    TabOrder = 4
    OnClick = Button3Click
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 144
    Top = 48
  end
  object Timer2: TTimer
    Enabled = False
    OnTimer = Timer2Timer
    Left = 208
    Top = 48
  end
  object PopupMenu1: TPopupMenu
    Left = 104
    Top = 40
    object N1: TMenuItem
      Caption = #25171#24320
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = #36864#20986
      OnClick = N2Click
    end
  end
end
