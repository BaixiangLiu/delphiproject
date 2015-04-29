object RMIVTTF: TRMIVTTF
  Left = 285
  Top = 129
  AutoScroll = False
  Caption = '库存盘点盈亏统计'
  ClientHeight = 188
  ClientWidth = 299
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
    Left = -3
    Top = 0
    Width = 300
    Height = 101
    Caption = '查询条件'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = '宋体'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      Left = 15
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
      Width = 100
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
    object LB31: TRadioGroup
      Left = 10
      Top = 50
      Width = 281
      Height = 45
      Caption = '盘点数量'
      Columns = 4
      ItemIndex = 3
      Items.Strings = (
        '盘盈'
        '盘亏'
        '正常'
        '全部')
      TabOrder = 2
    end
  end
  object ToolBar: TToolBar
    Left = 0
    Top = 152
    Width = 297
    Height = 36
    Align = alNone
    ButtonHeight = 30
    TabOrder = 1
    object ToolButton1: TToolButton
      Left = 0
      Top = 2
      Width = 9
      Caption = 'ToolButton1'
      ImageIndex = 0
      Style = tbsSeparator
    end
    object BTNPRE: TSpeedButton
      Left = 9
      Top = 2
      Width = 80
      Height = 30
      Cursor = crHandPoint
      Caption = '&W 预览'
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
    object BTNPRN: TSpeedButton
      Left = 109
      Top = 2
      Width = 80
      Height = 30
      Cursor = crHandPoint
      Caption = '&P 打印'
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
  object GroupBox2: TGroupBox
    Left = -3
    Top = 97
    Width = 300
    Height = 56
    Caption = '排列方式'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -15
    Font.Name = '宋体'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    object WK1: TComboBox
      Left = 25
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
        '条形码'
        '盘点量'
        '库存量'
        '盈亏量')
    end
  end
  object QUERYF: TQuery
    DatabaseName = 'DB_IVTT'
    SQL.Strings = (
      'SELECT *'
      'FROM IVTT')
    Left = 190
    Top = 93
    object QUERYF_COST: TIntegerField
      FieldKind = fkCalculated
      FieldName = '_COST'
      Calculated = True
    end
    object QUERYFITENO: TStringField
      FieldName = 'ITENO'
      Origin = 'DB_IVTT.IVTT.ITENO'
      Size = 12
    end
    object QUERYFBGENO: TStringField
      FieldName = 'BGENO'
      Origin = 'DB_IVTT.IVTT.BGENO'
    end
    object QUERYFITCNR: TFloatField
      FieldName = 'ITCNR'
      Origin = 'DB_IVTT.IVTT.ITCNR'
    end
    object QUERYFITCNV: TFloatField
      FieldName = 'ITCNV'
      Origin = 'DB_IVTT.IVTT.ITCNV'
    end
    object QUERYFITCNT: TFloatField
      FieldName = 'ITCNT'
      Origin = 'DB_IVTT.IVTT.ITCNT'
    end
    object QUERYFITDAT: TDateTimeField
      FieldName = 'ITDAT'
      Origin = 'DB_IVTT.IVTT.ITDAT'
    end
    object QUERYFITTME: TStringField
      FieldName = 'ITTME'
      Origin = 'DB_IVTT.IVTT.ITTME'
      Size = 5
    end
    object QUERYFITTRN: TBooleanField
      FieldName = 'ITTRN'
      Origin = 'DB_IVTT.IVTT.ITTRN'
    end
  end
  object Database: TDatabase
    AliasName = 'MICROIVTT'
    Connected = True
    DatabaseName = 'DB_IVTT'
    HandleShared = True
    LoginPrompt = False
    SessionName = 'Default'
    Left = 119
    Top = 93
  end
end
