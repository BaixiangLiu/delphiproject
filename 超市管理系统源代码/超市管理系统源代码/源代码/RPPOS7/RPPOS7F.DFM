object RMPOS7F: TRMPOS7F
  Left = 259
  Top = 175
  AutoScroll = False
  Caption = '礼券刷卡报表'
  ClientHeight = 256
  ClientWidth = 423
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '宋体'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 300
    Height = 196
    Caption = '查询条件'
    Color = 16755370
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -15
    Font.Name = '宋体'
    Font.Style = []
    ParentColor = False
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      Left = 15
      Top = 19
      Width = 48
      Height = 16
      Caption = '消费日期'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 178
      Top = 19
      Width = 12
      Height = 16
      Caption = '至'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 15
      Top = 119
      Width = 48
      Height = 16
      Caption = '销售编号'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 15
      Top = 69
      Width = 48
      Height = 16
      Caption = '收款员号'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 15
      Top = 44
      Width = 48
      Height = 16
      Caption = '到期日期'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 178
      Top = 44
      Width = 12
      Height = 16
      Caption = '至'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 15
      Top = 144
      Width = 48
      Height = 16
      Caption = '礼券号码'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
    end
    object Label9: TLabel
      Left = 15
      Top = 94
      Width = 48
      Height = 16
      Caption = '会员编号'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 15
      Top = 169
      Width = 48
      Height = 16
      Caption = '刷卡号码'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
    end
    object LB11: TJEdit
      Left = 75
      Top = 15
      Width = 100
      Height = 22
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Digits = 1
      Max = 999999999
      _EditType = CDATE_EDIT
      _SHOWCAL = NONE
      _BADINPUT = True
      _LONGTIME = False
    end
    object LB12: TJEdit
      Left = 196
      Top = 15
      Width = 100
      Height = 22
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Digits = 1
      Max = 999999999
      _EditType = CDATE_EDIT
      _SHOWCAL = NONE
      _BADINPUT = True
      _LONGTIME = False
    end
    object LB31: JLOOKUPBOX
      Left = 75
      Top = 65
      Width = 221
      Height = 22
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = '宋体'
      Font.Style = []
      MaxLength = 20
      ParentFont = False
      TabOrder = 4
      _DatabaseName = 'MAIN'
      _TableName = 'BMAN'
      _Field_IDNO = 'BNENO'
      _Field_NAME = 'BNNAM'
      _EDIT_WIDTH = 100
      _CHANGE_QUERY = True
      _INSERT_RECORD = False
      _SHOW_MESSAGE = False
    end
    object LB51: TJEdit
      Left = 75
      Top = 115
      Width = 221
      Height = 22
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      Digits = 1
      Max = 999999999
      _EditType = EDIT
      _SHOWCAL = NONE
      _BADINPUT = True
      _LONGTIME = False
    end
    object LB61: TJEdit
      Left = 75
      Top = 140
      Width = 221
      Height = 22
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      Digits = 1
      Max = 999999999
      _EditType = EDIT
      _SHOWCAL = NONE
      _BADINPUT = True
      _LONGTIME = False
    end
    object LB21: TJEdit
      Left = 75
      Top = 40
      Width = 100
      Height = 22
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      Digits = 1
      Max = 999999999
      _EditType = CDATE_EDIT
      _SHOWCAL = NONE
      _BADINPUT = True
      _LONGTIME = False
    end
    object LB22: TJEdit
      Left = 196
      Top = 40
      Width = 100
      Height = 22
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      Digits = 1
      Max = 999999999
      _EditType = CDATE_EDIT
      _SHOWCAL = NONE
      _BADINPUT = True
      _LONGTIME = False
    end
    object LB41: JLOOKUPBOX
      Left = 75
      Top = 90
      Width = 221
      Height = 22
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = '宋体'
      Font.Style = []
      MaxLength = 20
      ParentFont = False
      TabOrder = 5
      _DatabaseName = 'MAIN'
      _TableName = 'BMEM'
      _Field_IDNO = 'BMENO'
      _Field_NAME = 'BMNAM'
      _EDIT_WIDTH = 100
      _CHANGE_QUERY = True
      _INSERT_RECORD = False
      _SHOW_MESSAGE = False
    end
    object LB71: TJEdit
      Left = 74
      Top = 165
      Width = 221
      Height = 22
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
      Digits = 1
      Max = 999999999
      _EditType = EDIT
      _SHOWCAL = NONE
      _BADINPUT = True
      _LONGTIME = False
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 200
    Width = 300
    Height = 56
    Caption = '排列方式'
    Color = 16755370
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -15
    Font.Name = '宋体'
    Font.Style = []
    ParentColor = False
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 1
    object WK1: TComboBox
      Left = 25
      Top = 20
      Width = 256
      Height = 24
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = '宋体'
      Font.Style = []
      ItemHeight = 16
      ParentFont = False
      TabOrder = 0
      Items.Strings = (
        '消费日期'
        '到期日期'
        '收款员号'
        '会员编号'
        '销售编号'
        '礼券号码'
        '刷卡号码'
        '')
    end
  end
  object Panel1: TPanel
    Left = 303
    Top = 0
    Width = 120
    Height = 256
    Align = alRight
    BevelOuter = bvNone
    BorderWidth = 1
    Color = clNavy
    TabOrder = 2
    object BTNPRN: TSpeedButton
      Left = 0
      Top = 62
      Width = 120
      Height = 60
      Cursor = crHandPoint
      Caption = '&P 打印'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
      OnClick = BTNPREClick
    end
    object BTNPRE: TSpeedButton
      Left = 0
      Top = 2
      Width = 120
      Height = 60
      Cursor = crHandPoint
      Caption = '&W 预览'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
      OnClick = BTNPREClick
    end
    object BTNQUT: TSpeedButton
      Left = 0
      Top = 122
      Width = 120
      Height = 60
      Cursor = crHandPoint
      Caption = '&Q 结束'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
      OnClick = BTNQUTClick
    end
    object CB1: TCheckBox
      Left = 10
      Top = 190
      Width = 97
      Height = 17
      Caption = '不打印礼券资料'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -15
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
  end
  object QUERYF: TQuery
    DatabaseName = 'MAIN'
    SQL.Strings = (
      'SELECT * FROM POSA')
    Left = 270
    Top = 5
    object QUERYFPAENO: TStringField
      FieldName = 'PAENO'
      Origin = 'MAIN.POSA.PAENO'
      Size = 12
    end
    object QUERYFPAIDE: TStringField
      FieldName = 'PAIDE'
      Origin = 'MAIN.POSA.PAIDE'
      Size = 3
    end
    object QUERYFBMENO: TStringField
      FieldName = 'BMENO'
      Origin = 'MAIN.POSA.BMENO'
      Size = 10
    end
    object QUERYFBNENO: TStringField
      FieldName = 'BNENO'
      Origin = 'MAIN.POSA.BNENO'
      Size = 10
    end
    object QUERYFPAIPN: TBooleanField
      FieldName = 'PAIPN'
      Origin = 'MAIN.POSA.PAIPN'
    end
    object QUERYFPAIVO: TStringField
      FieldName = 'PAIVO'
      Origin = 'MAIN.POSA.PAIVO'
      Size = 15
    end
    object QUERYFPACIV: TStringField
      FieldName = 'PACIV'
      Origin = 'MAIN.POSA.PACIV'
      Size = 8
    end
    object QUERYFPADAT: TDateTimeField
      FieldName = 'PADAT'
      Origin = 'MAIN.POSA.PADAT'
    end
    object QUERYFPATME: TStringField
      FieldName = 'PATME'
      Origin = 'MAIN.POSA.PATME'
      Size = 5
    end
    object QUERYFPACNT: TFloatField
      FieldName = 'PACNT'
      Origin = 'MAIN.POSA.PACNT'
    end
    object QUERYFPACOT: TFloatField
      FieldName = 'PACOT'
      Origin = 'MAIN.POSA.PACOT'
    end
    object QUERYFPACOG: TFloatField
      FieldName = 'PACOG'
      Origin = 'MAIN.POSA.PACOG'
    end
    object QUERYFPACNO: TStringField
      FieldName = 'PACNO'
      Origin = 'MAIN.POSA.PACNO'
    end
    object QUERYFPACDT: TDateTimeField
      FieldName = 'PACDT'
      Origin = 'MAIN.POSA.PACDT'
    end
    object QUERYFPACNA: TFloatField
      FieldName = 'PACNA'
      Origin = 'MAIN.POSA.PACNA'
    end
    object QUERYFPACKD: TStringField
      FieldName = 'PACKD'
      Origin = 'MAIN.POSA.PACKD'
      Size = 3
    end
    object QUERYFPGCOS: TFloatField
      FieldName = 'PGCOS'
      Origin = 'MAIN.POSA.PGCOS'
    end
    object QUERYFPABCK: TBooleanField
      FieldName = 'PABCK'
      Origin = 'MAIN.POSA.PABCK'
    end
    object QUERYFPABCN: TBooleanField
      FieldName = 'PABCN'
      Origin = 'MAIN.POSA.PABCN'
    end
    object QUERYFPACPD: TBooleanField
      FieldName = 'PACPD'
      Origin = 'MAIN.POSA.PACPD'
    end
    object QUERYFPAWEK: TStringField
      FieldName = 'PAWEK'
      Origin = 'MAIN.POSA.PAWEK'
      Size = 1
    end
  end
end
