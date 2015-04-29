object FMMAIN: TFMMAIN
  Left = 112
  Top = 109
  Width = 656
  Height = 452
  Caption = 'POS管理系统'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = MainMenu1
  OldCreateOrder = True
  Position = poScreenCenter
  WindowState = wsMaximized
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar: TStatusBar
    Left = 0
    Top = 387
    Width = 648
    Height = 19
    Panels = <>
    SimplePanel = False
  end
  object MainMenu1: TMainMenu
    Left = 305
    Top = 10
    object GO1: TMenuItem
      Caption = '执行执行执行执行执行执行'
      OnClick = GO1Click
    end
  end
end
