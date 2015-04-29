object FMPMSG: TFMPMSG
  Left = 178
  Top = 129
  BorderStyle = bsDialog
  Caption = '个人信息查看'
  ClientHeight = 500
  ClientWidth = 600
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 0
    Top = 465
    Width = 600
    Height = 35
    Align = alBottom
    Caption = '按 ESC 退出          可按上下键查询'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -32
    Font.Name = '新宋体'
    Font.Style = []
    ParentFont = False
  end
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 600
    Height = 460
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -27
    Font.Name = '新宋体'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnKeyDown = Memo1KeyDown
  end
  object MainMenu1: TMainMenu
    Left = 140
    Top = 30
    object EXIT1: TMenuItem
      Caption = 'EXIT'
      ShortCut = 27
      Visible = False
      OnClick = EXIT1Click
    end
  end
end
