object RMIVTAF: TRMIVTAF
  Left = 258
  Top = 197
  AutoScroll = False
  Caption = '盘点暂存资料明细表'
  ClientHeight = 179
  ClientWidth = 298
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '宋体'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 297
    Height = 51
    Caption = '查询条件'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = '宋体'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      Left = 7
      Top = 25
      Width = 60
      Height = 15
      Caption = '查询日期'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 178
      Top = 24
      Width = 15
      Height = 15
      Caption = '至'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
    end
    object LB21: TJEdit
      Left = 75
      Top = 20
      Width = 100
      Height = 23
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Digits = 1
      Max = 999999999
      _EditType = EDATE_EDIT
      _SHOWCAL = NONE
      _BADINPUT = False
      _LONGTIME = False
    end
    object LB22: TJEdit
      Left = 195
      Top = 20
      Width = 94
      Height = 23
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Digits = 1
      Max = 999999999
      _EditType = EDATE_EDIT
      _SHOWCAL = NONE
      _BADINPUT = False
      _LONGTIME = False
    end
  end
  object GroupBox2: TGroupBox
    Left = -8
    Top = 55
    Width = 305
    Height = 82
    Caption = '排列方式'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -15
    Font.Name = '宋体'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object WK1: TComboBox
      Left = 33
      Top = 20
      Width = 256
      Height = 23
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = '宋体'
      Font.Style = []
      ItemHeight = 15
      ParentFont = False
      TabOrder = 0
      Items.Strings = (
        '数量'
        '单价'
        '总价')
    end
    object WK2: TCheckBox
      Left = 33
      Top = 47
      Width = 256
      Height = 17
      Caption = '盘点数量为零不须打印'
      Color = clMenu
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = '宋体'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      TabOrder = 1
    end
  end
  object ToolBar: TToolBar
    Left = 1
    Top = 140
    Width = 296
    Height = 38
    Align = alNone
    ButtonHeight = 30
    TabOrder = 2
    object ToolButton1: TToolButton
      Left = 0
      Top = 2
      Width = 9
      Caption = 'ToolButton1'
      ImageIndex = 0
      Style = tbsSeparator
    end
    object BTNPRN: TSpeedButton
      Left = 9
      Top = 2
      Width = 80
      Height = 30
      Cursor = crHandPoint
      Caption = '&P 打印'
      Flat = True
      OnClick = BTNPREClick
    end
    object ToolButton2: TToolButton
      Left = 89
      Top = 2
      Width = 20
      Caption = 'ToolButton2'
      ImageIndex = 1
      Style = tbsSeparator
    end
    object BTNPRE: TSpeedButton
      Left = 109
      Top = 2
      Width = 80
      Height = 30
      Cursor = crHandPoint
      Caption = '&W 预览'
      Flat = True
      OnClick = BTNPREClick
    end
    object ToolButton3: TToolButton
      Left = 189
      Top = 2
      Width = 20
      Caption = 'ToolButton3'
      ImageIndex = 2
      Style = tbsSeparator
    end
    object BTNQUT: TSpeedButton
      Left = 209
      Top = 2
      Width = 80
      Height = 30
      Cursor = crHandPoint
      Caption = '&Q 结束'
      Flat = True
      OnClick = BTNQUTClick
    end
  end
  object QIVTAF: TQuery
    DatabaseName = 'DB_IVTT'
    SQL.Strings = (
      'SELECT *'
      'FROM IVTA')
    Left = 254
    Top = 109
    object QIVTAFBGENO: TStringField
      FieldName = 'BGENO'
      Origin = 'DB_IVTT.IVTA.BGENO'
    end
    object QIVTAFIACNT: TFloatField
      FieldName = 'IACNT'
      Origin = 'DB_IVTT.IVTA.IACNT'
    end
    object QIVTAFIADAT: TDateTimeField
      FieldName = 'IADAT'
      Origin = 'DB_IVTT.IVTA.IADAT'
    end
    object QIVTAFIATME: TStringField
      FieldName = 'IATME'
      Origin = 'DB_IVTT.IVTA.IATME'
      Size = 5
    end
  end
  object Database: TDatabase
    AliasName = 'MICROIVTT'
    Connected = True
    DatabaseName = 'DB_IVTT'
    HandleShared = True
    LoginPrompt = False
    SessionName = 'Default'
    Left = 215
    Top = 98
  end
end
