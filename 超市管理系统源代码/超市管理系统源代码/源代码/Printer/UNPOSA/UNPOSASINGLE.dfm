object FMPOSASINGLE: TFMPOSASINGLE
  Left = 51
  Top = 84
  BorderIcons = []
  BorderStyle = bsToolWindow
  Caption = '单品键设置     退出 按 ESC'
  ClientHeight = 563
  ClientWidth = 592
  Color = 11659006
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -21
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 24
  object GRID: TStringGrid
    Left = 0
    Top = 60
    Width = 591
    Height = 502
    ColCount = 3
    Ctl3D = False
    DefaultColWidth = 30
    FixedColor = 5547518
    FixedCols = 0
    RowCount = 200
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goTabs, goRowSelect]
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 0
    OnKeyPress = GRIDKeyPress
    ColWidths = (
      102
      215
      249)
  end
  object ED_TXT: TEdit
    Left = 7
    Top = 2
    Width = 575
    Height = 54
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -43
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 1
  end
  object MainMenu1: TMainMenu
    Left = 410
    Top = 115
    object ESC1: TMenuItem
      Caption = '退出ESC'
      ShortCut = 27
      Visible = False
      OnClick = ESC1Click
    end
    object N1: TMenuItem
      Caption = '退出'
      ShortCut = 16465
      Visible = False
      OnClick = ESC1Click
    end
  end
end
