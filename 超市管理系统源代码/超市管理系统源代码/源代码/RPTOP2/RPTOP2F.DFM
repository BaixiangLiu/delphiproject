object RMTOP2F: TRMTOP2F
  Left = 250
  Top = 234
  AutoScroll = False
  Caption = '会员消费排行报表'
  ClientHeight = 182
  ClientWidth = 422
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
  object Panel1: TPanel
    Left = 302
    Top = 0
    Width = 120
    Height = 182
    Align = alRight
    BevelOuter = bvNone
    BorderWidth = 1
    Color = clNavy
    TabOrder = 0
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
  object GroupBox2: TGroupBox
    Left = 0
    Top = 1
    Width = 300
    Height = 177
    Caption = '查询条件'
    Color = 16755370
    Ctl3D = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -12
    Font.Name = '宋体'
    Font.Style = []
    ParentColor = False
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 1
    object Label4: TLabel
      Left = 10
      Top = 141
      Width = 48
      Height = 12
      Caption = '排列方式'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 190
      Top = 141
      Width = 48
      Height = 12
      Caption = '显示笔数'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 5
      Top = 99
      Width = 60
      Height = 12
      Caption = '最近交易日'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 178
      Top = 99
      Width = 12
      Height = 12
      Caption = '至'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
    end
    object Label9: TLabel
      Left = 15
      Top = 21
      Width = 48
      Height = 12
      Caption = '会员编号'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 15
      Top = 47
      Width = 48
      Height = 12
      Caption = '年消费额'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 178
      Top = 47
      Width = 12
      Height = 12
      Caption = '至'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 15
      Top = 73
      Width = 48
      Height = 12
      Caption = '总消费额'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
    end
    object Label10: TLabel
      Left = 178
      Top = 73
      Width = 12
      Height = 12
      Caption = '至'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
    end
    object WK1: TComboBox
      Left = 75
      Top = 137
      Width = 100
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
        '年消费'
        '总消费')
    end
    object CN1: TSpinEdit
      Left = 255
      Top = 135
      Width = 41
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = '宋体'
      Font.Style = []
      MaxValue = 0
      MinValue = 0
      ParentFont = False
      TabOrder = 1
      Value = 10
    end
    object LB41: TJEdit
      Left = 75
      Top = 95
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
      _EditType = CDATE_EDIT
      _SHOWCAL = NONE
      _BADINPUT = True
      _LONGTIME = False
    end
    object LB42: TJEdit
      Left = 195
      Top = 95
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
      _EditType = CDATE_EDIT
      _SHOWCAL = NONE
      _BADINPUT = True
      _LONGTIME = False
    end
    object LB21: TJEdit
      Left = 75
      Top = 43
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
      _EditType = INTEGER_EDIT
      _SHOWCAL = NONE
      _BADINPUT = True
      _LONGTIME = False
    end
    object LB22: TJEdit
      Left = 195
      Top = 43
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
      _EditType = INTEGER_EDIT
      _SHOWCAL = NONE
      _BADINPUT = True
      _LONGTIME = False
    end
    object LB31: TJEdit
      Left = 75
      Top = 69
      Width = 100
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      Digits = 1
      Max = 999999999
      _EditType = INTEGER_EDIT
      _SHOWCAL = NONE
      _BADINPUT = True
      _LONGTIME = False
    end
    object LB32: TJEdit
      Left = 195
      Top = 69
      Width = 100
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      Digits = 1
      Max = 999999999
      _EditType = INTEGER_EDIT
      _SHOWCAL = NONE
      _BADINPUT = True
      _LONGTIME = False
    end
    object LB11: JLOOKUPBOX
      Left = 75
      Top = 17
      Width = 221
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = '宋体'
      Font.Style = []
      MaxLength = 20
      ParentFont = False
      TabOrder = 8
      _DatabaseName = 'MAIN'
      _TableName = 'BMEM'
      _Field_IDNO = 'BMENO'
      _Field_NAME = 'BMNAM'
      _EDIT_WIDTH = 100
      _CHANGE_QUERY = True
      _INSERT_RECORD = False
      _SHOW_MESSAGE = False
    end
  end
  object QTOP2F: TQuery
    DatabaseName = 'MAIN'
    SQL.Strings = (
      'SELECT *'
      'FROM BMEM'
      'order by BMBTO DESC')
    Left = 270
    Top = 5
    object QTOP2FBMENO: TStringField
      FieldName = 'BMENO'
      Origin = 'MAIN.BMEM.BMENO'
      Size = 10
    end
    object QTOP2FBMNAM: TStringField
      FieldName = 'BMNAM'
      Origin = 'MAIN.BMEM.BMNAM'
      Size = 10
    end
    object QTOP2FBMCNA: TStringField
      FieldName = 'BMCNA'
      Origin = 'MAIN.BMEM.BMCNA'
      Size = 10
    end
    object QTOP2FBMBTH: TDateTimeField
      FieldName = 'BMBTH'
      Origin = 'MAIN.BMEM.BMBTH'
    end
    object QTOP2FBMSEX: TStringField
      FieldName = 'BMSEX'
      Origin = 'MAIN.BMEM.BMSEX'
      Size = 1
    end
    object QTOP2FBMLVE: TFloatField
      FieldName = 'BMLVE'
      Origin = 'MAIN.BMEM.BMLVE'
    end
    object QTOP2FBMBYR: TFloatField
      FieldName = 'BMBYR'
      Origin = 'MAIN.BMEM.BMBYR'
    end
    object QTOP2FBMBTO: TFloatField
      FieldName = 'BMBTO'
      Origin = 'MAIN.BMEM.BMBTO'
    end
    object QTOP2FBMBPO: TFloatField
      FieldName = 'BMBPO'
      Origin = 'MAIN.BMEM.BMBPO'
    end
    object QTOP2FBMBTM: TFloatField
      FieldName = 'BMBTM'
      Origin = 'MAIN.BMEM.BMBTM'
    end
    object QTOP2FBMBDT: TDateTimeField
      FieldName = 'BMBDT'
      Origin = 'MAIN.BMEM.BMBDT'
    end
    object QTOP2FBMBYD: TDateTimeField
      FieldName = 'BMBYD'
      Origin = 'MAIN.BMEM.BMBYD'
    end
    object QTOP2FBMWPN: TStringField
      FieldName = 'BMWPN'
      Origin = 'MAIN.BMEM.BMWPN'
      Size = 15
    end
    object QTOP2FBMTL1: TStringField
      FieldName = 'BMTL1'
      Origin = 'MAIN.BMEM.BMTL1'
      Size = 15
    end
    object QTOP2FBMTL2: TStringField
      FieldName = 'BMTL2'
      Origin = 'MAIN.BMEM.BMTL2'
      Size = 15
    end
    object QTOP2FBMTL3: TStringField
      FieldName = 'BMTL3'
      Origin = 'MAIN.BMEM.BMTL3'
      Size = 15
    end
    object QTOP2FBMAD1: TStringField
      FieldName = 'BMAD1'
      Origin = 'MAIN.BMEM.BMAD1'
      Size = 50
    end
    object QTOP2FBMAD2: TStringField
      FieldName = 'BMAD2'
      Origin = 'MAIN.BMEM.BMAD2'
      Size = 50
    end
    object QTOP2FBMZP1: TStringField
      FieldName = 'BMZP1'
      Origin = 'MAIN.BMEM.BMZP1'
      Size = 5
    end
    object QTOP2FBMZP2: TStringField
      FieldName = 'BMZP2'
      Origin = 'MAIN.BMEM.BMZP2'
      Size = 5
    end
    object QTOP2FBMEML: TStringField
      FieldName = 'BMEML'
      Origin = 'MAIN.BMEM.BMEML'
      Size = 30
    end
    object QTOP2FBMWWW: TStringField
      FieldName = 'BMWWW'
      Origin = 'MAIN.BMEM.BMWWW'
      Size = 30
    end
    object QTOP2FBMJND: TDateTimeField
      FieldName = 'BMJND'
      Origin = 'MAIN.BMEM.BMJND'
    end
    object QTOP2FBMCRD: TDateTimeField
      FieldName = 'BMCRD'
      Origin = 'MAIN.BMEM.BMCRD'
    end
    object QTOP2FBMDAT: TDateTimeField
      FieldName = 'BMDAT'
      Origin = 'MAIN.BMEM.BMDAT'
    end
    object QTOP2FRBPST: TStringField
      FieldName = 'RBPST'
      Origin = 'MAIN.BMEM.RBPST'
      Size = 3
    end
    object QTOP2FBMMRK: TMemoField
      FieldName = 'BMMRK'
      Origin = 'MAIN.BMEM.BMMRK'
      BlobType = ftMemo
      Size = 1
    end
  end
end
