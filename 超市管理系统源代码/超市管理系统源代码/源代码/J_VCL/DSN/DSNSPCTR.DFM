object InspectorFm: TInspectorFm
  Left = 253
  Top = 108
  Width = 230
  Height = 438
  Color = clBtnFace
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '宋体'
  Font.Style = []
  OldCreateOrder = True
  Scaled = False
  OnCreate = FormCreate
  OnDeactivate = Edit1Exit
  PixelsPerInch = 96
  TextHeight = 15
  object StringGrid1: TStringGrid
    Left = 0
    Top = 33
    Width = 222
    Height = 348
    Align = alClient
    Color = clBtnFace
    ColCount = 3
    FixedCols = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing]
    ScrollBars = ssVertical
    TabOrder = 0
    OnMouseDown = StringGrid1MouseDown
  end
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 222
    Height = 33
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Panel3'
    TabOrder = 1
    OnResize = Panel3Resize
    object ComboBox1: TComboBox
      Left = 5
      Top = 6
      Width = 173
      Height = 23
      Style = csDropDownList
      ImeName = '中文 (简体) - 微软拼音'
      ItemHeight = 15
      TabOrder = 0
      OnChange = ComboBox1Change
      OnDropDown = ComboBox1Change
    end
  end
  object Edit1: TEdit
    Left = -200
    Top = 240
    Width = 89
    Height = 26
    Font.Charset = SHIFTJIS_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = '宋体'
    Font.Style = []
    ImeName = '中文 (简体) - 微软拼音'
    ParentFont = False
    TabOrder = 2
    Text = 'Edit1'
    OnExit = Edit1Exit
  end
  object Panel2: TPanel
    Left = -96
    Top = 48
    Width = 25
    Height = 25
    Caption = '  '
    TabOrder = 3
    object SpeedButton1: TSpeedButton
      Left = 0
      Top = 0
      Width = 25
      Height = 25
      OnClick = SpeedButton1Click
    end
  end
  object ComboBox2: TComboBox
    Left = -200
    Top = 131
    Width = 81
    Height = 26
    Font.Charset = SHIFTJIS_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = '宋体'
    Font.Style = []
    ImeName = '中文 (简体) - 微软拼音'
    ItemHeight = 18
    ParentFont = False
    TabOrder = 4
    Text = 'ComboBox2'
    OnChange = ComboBox2Change
    OnExit = Edit1Exit
  end
  object Panel1: TPanel
    Left = 0
    Top = 381
    Width = 222
    Height = 30
    Align = alBottom
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 5
    Visible = False
    object HelpBtn: TBitBtn
      Left = 4
      Top = 4
      Width = 105
      Height = 25
      TabOrder = 0
      Kind = bkHelp
    end
  end
end