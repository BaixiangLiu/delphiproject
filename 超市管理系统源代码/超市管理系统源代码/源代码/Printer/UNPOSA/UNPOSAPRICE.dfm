object FMPOSAPRICE: TFMPOSAPRICE
  Left = -30
  Top = 201
  BorderStyle = bsToolWindow
  Caption = '修改数量及价格'
  ClientHeight = 233
  ClientWidth = 779
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ED_CHANGE: TGroupBox
    Left = 0
    Top = 0
    Width = 779
    Height = 233
    Align = alClient
    Caption = '修改数量及价格'
    Color = 8400171
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -32
    Font.Name = '新宋体'
    Font.Style = []
    ParentColor = False
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 0
    object Label2: TLabel
      Left = 15
      Top = 50
      Width = 168
      Height = 48
      Caption = '数   量'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -48
      Font.Name = '新宋体'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Label3: TLabel
      Left = 220
      Top = 50
      Width = 216
      Height = 48
      Alignment = taCenter
      Caption = '单     价'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -48
      Font.Name = '新宋体'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Label1: TLabel
      Left = 500
      Top = 50
      Width = 288
      Height = 48
      Alignment = taCenter
      Caption = '总   金   额'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -48
      Font.Name = '新宋体'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object ED_CHANGE_QTY: TJEdit
      Left = 15
      Top = 100
      Width = 131
      Height = 126
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -120
      Font.Name = '新宋体'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = '0'
      OnKeyDown = ED_CHANGE_QTYKeyDown
      Digits = 0
      Max = 999999999
      _EditType = FLOAT_EDIT
      _SHOWCAL = NONE
      _BADINPUT = False
      _LONGTIME = False
    end
    object ED_CHANGE_SPRICE: TJEdit
      Left = 150
      Top = 100
      Width = 300
      Height = 126
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -120
      Font.Name = '新宋体'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Text = '0'
      OnKeyDown = ED_CHANGE_QTYKeyDown
      Digits = 0
      Max = 999999999
      _EditType = FLOAT_EDIT
      _SHOWCAL = NONE
      _BADINPUT = False
      _LONGTIME = False
    end
    object ED_CHANGE_TPRICE: TJEdit
      Left = 455
      Top = 100
      Width = 316
      Height = 126
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -120
      Font.Name = '新宋体'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      Text = '0'
      OnKeyDown = ED_CHANGE_QTYKeyDown
      Digits = 0
      Max = 999999999
      _EditType = FLOAT_EDIT
      _SHOWCAL = NONE
      _BADINPUT = False
      _LONGTIME = False
    end
  end
  object MainMenu1: TMainMenu
    Left = 420
    object ESC: TMenuItem
      Caption = '取消ESC'
      ShortCut = 27
      Visible = False
      OnClick = ESCClick
    end
  end
end
