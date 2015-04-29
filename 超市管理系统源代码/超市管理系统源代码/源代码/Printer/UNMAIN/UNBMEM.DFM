object FMBMEM: TFMBMEM
  Left = 255
  Top = 246
  Width = 516
  Height = 193
  Caption = '会员快速新增'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ED_BMEM: TGroupBox
    Left = 3
    Top = 5
    Width = 500
    Height = 156
    Caption = '会员快速新增'
    Color = 16769738
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -32
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      Left = 15
      Top = 50
      Width = 160
      Height = 37
      Caption = '新会员编号'
    end
    object Label2: TLabel
      Left = 15
      Top = 100
      Width = 160
      Height = 37
      Caption = '新会员姓名'
    end
    object ED_BMENO: TJEdit
      Left = 185
      Top = 45
      Width = 300
      Height = 45
      TabOrder = 0
      OnKeyDown = ED_BMENOKeyDown
      Digits = 1
      Max = 999999999
      _EditType = EDIT
    end
    object ED_BMNAM: TJEdit
      Left = 185
      Top = 95
      Width = 300
      Height = 45
      TabOrder = 1
      OnKeyDown = ED_BMNAMKeyDown
      Digits = 1
      Max = 999999999
      _EditType = EDIT
    end
  end
  object MainMenu1: TMainMenu
    Left = 235
    Top = 15
    object ESC: TMenuItem
      Caption = '取消交易ESC'
      ShortCut = 27
      Visible = False
      OnClick = ESCClick
    end
  end
end
