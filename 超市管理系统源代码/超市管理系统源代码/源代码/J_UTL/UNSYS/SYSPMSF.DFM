object FMPMSF: TFMPMSF
  Left = 268
  Top = 229
  Width = 320
  Height = 159
  Caption = ' '
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 5
    Top = 40
    Width = 300
    Height = 81
    Caption = '查询条件'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      Left = 10
      Top = 25
      Width = 48
      Height = 16
      Caption = '员工编号'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 10
      Top = 50
      Width = 48
      Height = 16
      Caption = '功能代码'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object LB_CON21: TEdit
      Left = 70
      Top = 45
      Width = 221
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ImeName = '中文 (简体) - 智能 ABC'
      ParentFont = False
      TabOrder = 1
    end
    object LB_CON11: JLOOKUPBOX
      Left = 70
      Top = 20
      Width = 221
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ImeName = '中文 (简体) - 智能 ABC'
      MaxLength = 20
      ParentFont = False
      TabOrder = 0
      _DatabaseName = 'MAIN'
      _TableName = 'BMAN'
      _Field_IDNO = 'BNENO'
      _Field_NAME = 'BNNAM'
      _EDIT_WIDTH = 80
      _CHANGE_QUERY = True
      _INSERT_RECORD = False
      _SHOW_MESSAGE = False
    end
  end
  object ToolBar: TToolBar
    Left = 0
    Top = 0
    Width = 312
    Height = 36
    ButtonHeight = 30
    TabOrder = 1
    object ToolButton1: TToolButton
      Left = 0
      Top = 2
      Width = 20
      Caption = 'ToolButton1'
      ImageIndex = 0
      Style = tbsSeparator
    end
    object BTNSER: TSpeedButton
      Left = 20
      Top = 2
      Width = 80
      Height = 30
      Cursor = crHandPoint
      Caption = '&F 查询'
      Flat = True
      OnClick = BTNSERClick
    end
    object ToolButton2: TToolButton
      Left = 100
      Top = 2
      Width = 20
      Caption = 'ToolButton2'
      ImageIndex = 1
      Style = tbsSeparator
    end
    object BTNCLR: TSpeedButton
      Left = 120
      Top = 2
      Width = 80
      Height = 30
      Cursor = crHandPoint
      Caption = '&C 清除'
      Flat = True
      OnClick = BTNCLRClick
    end
    object ToolButton3: TToolButton
      Left = 200
      Top = 2
      Width = 20
      Caption = 'ToolButton3'
      ImageIndex = 2
      Style = tbsSeparator
    end
    object BTNQUT: TSpeedButton
      Left = 220
      Top = 2
      Width = 80
      Height = 30
      Cursor = crHandPoint
      Caption = '&Q 退出'
      Flat = True
      OnClick = BTNQUTClick
    end
  end
end
