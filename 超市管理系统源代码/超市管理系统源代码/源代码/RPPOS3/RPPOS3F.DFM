object RMPOS3F: TRMPOS3F
  Left = 258
  Top = 197
  AutoScroll = False
  Caption = '会员消费记录明细表'
  ClientHeight = 196
  ClientWidth = 425
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
    Width = 305
    Height = 196
    Align = alClient
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
    object LB1: TLabel
      Left = 10
      Top = 50
      Width = 52
      Height = 13
      Caption = '会员编号'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 173
      Top = 49
      Width = 13
      Height = 13
      Caption = '至'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 10
      Top = 25
      Width = 52
      Height = 13
      Caption = '查询日期'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 173
      Top = 24
      Width = 13
      Height = 13
      Caption = '至'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
    end
    object LB2: TLabel
      Left = 10
      Top = 75
      Width = 52
      Height = 13
      Caption = '会员姓名'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 173
      Top = 74
      Width = 13
      Height = 13
      Caption = '至'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
    end
    object LB21: TJEdit
      Left = 70
      Top = 45
      Width = 100
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Digits = 1
      Max = 999999999
      _EditType = EDIT
      _SHOWCAL = NONE
      _BADINPUT = True
      _LONGTIME = False
    end
    object LB22: TJEdit
      Left = 190
      Top = 45
      Width = 100
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Digits = 1
      Max = 999999999
      _EditType = EDIT
      _SHOWCAL = NONE
      _BADINPUT = True
      _LONGTIME = False
    end
    object LB11: TJEdit
      Left = 70
      Top = 20
      Width = 100
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      Digits = 1
      Max = 999999999
      _EditType = CDATE_EDIT
      _SHOWCAL = NONE
      _BADINPUT = True
      _LONGTIME = False
    end
    object LB12: TJEdit
      Left = 190
      Top = 20
      Width = 100
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      Digits = 1
      Max = 999999999
      _EditType = CDATE_EDIT
      _SHOWCAL = NONE
      _BADINPUT = True
      _LONGTIME = False
    end
    object LB31: TJEdit
      Left = 70
      Top = 70
      Width = 100
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      Digits = 1
      Max = 999999999
      _EditType = EDIT
      _SHOWCAL = NONE
      _BADINPUT = True
      _LONGTIME = False
    end
    object LB32: TJEdit
      Left = 190
      Top = 70
      Width = 100
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      Digits = 1
      Max = 999999999
      _EditType = EDIT
      _SHOWCAL = NONE
      _BADINPUT = True
      _LONGTIME = False
    end
  end
  object Panel1: TPanel
    Left = 305
    Top = 0
    Width = 120
    Height = 196
    Align = alRight
    BevelOuter = bvNone
    BorderWidth = 1
    Color = clNavy
    TabOrder = 1
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
  end
  object QBMEM: TQuery
    DatabaseName = 'MAIN'
    SQL.Strings = (
      'SELECT * FROM POSA, BMEM'
      'WHERE POSA.BMENO = BMEM.BMENO')
    Left = 270
    Top = 5
    object QBMEMPAENO: TStringField
      FieldName = 'PAENO'
      Origin = 'MAIN.POSA.PAENO'
      Size = 12
    end
    object QBMEMPAIDE: TStringField
      FieldName = 'PAIDE'
      Origin = 'MAIN.POSA.PAIDE'
      Size = 3
    end
    object QBMEMBMENO: TStringField
      FieldName = 'BMENO'
      Origin = 'MAIN.POSA.BMENO'
      Size = 10
    end
    object QBMEMBNENO: TStringField
      FieldName = 'BNENO'
      Origin = 'MAIN.POSA.BNENO'
      Size = 10
    end
    object QBMEMPAIPN: TBooleanField
      FieldName = 'PAIPN'
      Origin = 'MAIN.POSA.PAIPN'
    end
    object QBMEMPAIVO: TStringField
      FieldName = 'PAIVO'
      Origin = 'MAIN.POSA.PAIVO'
      Size = 15
    end
    object QBMEMPACIV: TStringField
      FieldName = 'PACIV'
      Origin = 'MAIN.POSA.PACIV'
      Size = 8
    end
    object QBMEMPADAT: TDateTimeField
      FieldName = 'PADAT'
      Origin = 'MAIN.POSA.PADAT'
    end
    object QBMEMPATME: TStringField
      FieldName = 'PATME'
      Origin = 'MAIN.POSA.PATME'
      Size = 5
    end
    object QBMEMPACNT: TFloatField
      FieldName = 'PACNT'
      Origin = 'MAIN.POSA.PACNT'
    end
    object QBMEMPACOT: TFloatField
      FieldName = 'PACOT'
      Origin = 'MAIN.POSA.PACOT'
    end
    object QBMEMPACOG: TFloatField
      FieldName = 'PACOG'
      Origin = 'MAIN.POSA.PACOG'
    end
    object QBMEMPACNO: TStringField
      FieldName = 'PACNO'
      Origin = 'MAIN.POSA.PACNO'
    end
    object QBMEMPACDT: TDateTimeField
      FieldName = 'PACDT'
      Origin = 'MAIN.POSA.PACDT'
    end
    object QBMEMPACNA: TFloatField
      FieldName = 'PACNA'
      Origin = 'MAIN.POSA.PACNA'
    end
    object QBMEMPACKD: TStringField
      FieldName = 'PACKD'
      Origin = 'MAIN.POSA.PACKD'
      Size = 3
    end
    object QBMEMPGCOS: TFloatField
      FieldName = 'PGCOS'
      Origin = 'MAIN.POSA.PGCOS'
    end
    object QBMEMPABCK: TBooleanField
      FieldName = 'PABCK'
      Origin = 'MAIN.POSA.PABCK'
    end
    object QBMEMPABCN: TBooleanField
      FieldName = 'PABCN'
      Origin = 'MAIN.POSA.PABCN'
    end
    object QBMEMPACPD: TBooleanField
      FieldName = 'PACPD'
      Origin = 'MAIN.POSA.PACPD'
    end
    object QBMEMPAWEK: TStringField
      FieldName = 'PAWEK'
      Origin = 'MAIN.POSA.PAWEK'
      Size = 1
    end
    object QBMEMBMENO_1: TStringField
      FieldName = 'BMENO_1'
      Origin = 'MAIN.POSA.PAWEK'
      Size = 10
    end
    object QBMEMBMNAM: TStringField
      FieldName = 'BMNAM'
      Origin = 'MAIN.POSA.PAWEK'
      Size = 10
    end
    object QBMEMBMCNA: TStringField
      FieldName = 'BMCNA'
      Origin = 'MAIN.POSA.PAWEK'
      Size = 10
    end
    object QBMEMBMBTH: TDateTimeField
      FieldName = 'BMBTH'
      Origin = 'MAIN.POSA.PAWEK'
    end
    object QBMEMBMSEX: TStringField
      FieldName = 'BMSEX'
      Origin = 'MAIN.POSA.PAWEK'
      Size = 1
    end
    object QBMEMBMLVE: TFloatField
      FieldName = 'BMLVE'
      Origin = 'MAIN.POSA.PAWEK'
    end
    object QBMEMBMBYR: TFloatField
      FieldName = 'BMBYR'
      Origin = 'MAIN.POSA.PAWEK'
    end
    object QBMEMBMBTO: TFloatField
      FieldName = 'BMBTO'
      Origin = 'MAIN.POSA.PAWEK'
    end
    object QBMEMBMBPO: TFloatField
      FieldName = 'BMBPO'
      Origin = 'MAIN.POSA.PAWEK'
    end
    object QBMEMBMBTM: TFloatField
      FieldName = 'BMBTM'
      Origin = 'MAIN.POSA.PAWEK'
    end
    object QBMEMBMBDT: TDateTimeField
      FieldName = 'BMBDT'
      Origin = 'MAIN.POSA.PAWEK'
    end
    object QBMEMBMBYD: TDateTimeField
      FieldName = 'BMBYD'
      Origin = 'MAIN.POSA.PAWEK'
    end
    object QBMEMBMWPN: TStringField
      FieldName = 'BMWPN'
      Origin = 'MAIN.POSA.PAWEK'
      Size = 15
    end
    object QBMEMBMTL1: TStringField
      FieldName = 'BMTL1'
      Origin = 'MAIN.POSA.PAWEK'
      Size = 15
    end
    object QBMEMBMTL2: TStringField
      FieldName = 'BMTL2'
      Origin = 'MAIN.POSA.PAWEK'
      Size = 15
    end
    object QBMEMBMTL3: TStringField
      FieldName = 'BMTL3'
      Origin = 'MAIN.POSA.PAWEK'
      Size = 15
    end
    object QBMEMBMAD1: TStringField
      FieldName = 'BMAD1'
      Origin = 'MAIN.POSA.PAWEK'
      Size = 50
    end
    object QBMEMBMAD2: TStringField
      FieldName = 'BMAD2'
      Origin = 'MAIN.POSA.PAWEK'
      Size = 50
    end
    object QBMEMBMZP1: TStringField
      FieldName = 'BMZP1'
      Origin = 'MAIN.POSA.PAWEK'
      Size = 5
    end
    object QBMEMBMZP2: TStringField
      FieldName = 'BMZP2'
      Origin = 'MAIN.POSA.PAWEK'
      Size = 5
    end
    object QBMEMBMEML: TStringField
      FieldName = 'BMEML'
      Origin = 'MAIN.POSA.PAWEK'
      Size = 30
    end
    object QBMEMBMWWW: TStringField
      FieldName = 'BMWWW'
      Origin = 'MAIN.POSA.PAWEK'
      Size = 30
    end
    object QBMEMBMJND: TDateTimeField
      FieldName = 'BMJND'
      Origin = 'MAIN.POSA.PAWEK'
    end
    object QBMEMBMCRD: TDateTimeField
      FieldName = 'BMCRD'
      Origin = 'MAIN.POSA.PAWEK'
    end
    object QBMEMBMDAT: TDateTimeField
      FieldName = 'BMDAT'
      Origin = 'MAIN.POSA.PAWEK'
    end
    object QBMEMRBPST: TStringField
      FieldName = 'RBPST'
      Origin = 'MAIN.POSA.PAWEK'
      Size = 3
    end
    object QBMEMBMMRK: TMemoField
      FieldName = 'BMMRK'
      Origin = 'MAIN.POSA.PAWEK'
      BlobType = ftMemo
      Size = 1
    end
  end
end
