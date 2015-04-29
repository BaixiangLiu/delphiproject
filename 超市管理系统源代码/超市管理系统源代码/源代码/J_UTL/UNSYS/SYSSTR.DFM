object FMSTR: TFMSTR
  Left = 299
  Top = 65
  BorderStyle = bsToolWindow
  Caption = '常用字词管理'
  ClientHeight = 465
  ClientWidth = 292
  Color = 12113393
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GD_KIND: TStringGrid
    Left = 0
    Top = 25
    Width = 291
    Height = 440
    ColCount = 1
    DefaultColWidth = 30
    DefaultRowHeight = 18
    FixedColor = 16692355
    FixedCols = 0
    RowCount = 200
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goTabs]
    ParentFont = False
    TabOrder = 0
    OnDblClick = GD_KINDDblClick
    OnKeyDown = GD_KINDKeyDown
    ColWidths = (
      268)
  end
  object LOAD: TButton
    Left = 155
    Top = 0
    Width = 75
    Height = 25
    Caption = '←寻找字符串'
    TabOrder = 1
    OnClick = LOADClick
  end
  object Edit1: TEdit
    Left = 2
    Top = 1
    Width = 152
    Height = 21
    ImeName = '中文 (简体) - 智能 ABC'
    TabOrder = 2
  end
  object Button1: TButton
    Left = 230
    Top = 0
    Width = 60
    Height = 25
    Caption = '&Q 离开'
    TabOrder = 3
    OnClick = Button1Click
  end
end
