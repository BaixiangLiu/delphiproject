object FMBMEMQ: TFMBMEMQ
  Left = 255
  Top = 246
  Width = 520
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
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ED_BMEM: TGroupBox
    Left = 0
    Top = 0
    Width = 512
    Height = 166
    Align = alClient
    Caption = '会员快速新增'
    Color = 14732988
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -32
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      Left = 15
      Top = 48
      Width = 200
      Height = 48
      Caption = '新会员编号'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -43
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 15
      Top = 103
      Width = 200
      Height = 48
      Caption = '新会员姓名'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -43
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object ED_BMENO: TJEdit
      Left = 220
      Top = 45
      Width = 285
      Height = 54
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -43
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnKeyDown = ED_BMENOKeyDown
      Digits = 1
      Max = 999999999
      _EditType = EDIT
      _SHOWCAL = NONE
      _BADINPUT = False
    end
    object ED_BMNAM: TJEdit
      Left = 220
      Top = 100
      Width = 285
      Height = 54
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -43
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnKeyDown = ED_BMNAMKeyDown
      Digits = 1
      Max = 999999999
      _EditType = EDIT
      _SHOWCAL = NONE
      _BADINPUT = False
    end
  end
  object MainMenu1: TMainMenu
    Left = 465
    object ESC: TMenuItem
      Caption = '取消交易ESC'
      ShortCut = 27
      Visible = False
      OnClick = ESCClick
    end
  end
end
