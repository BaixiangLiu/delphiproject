object RMTOP3F: TRMTOP3F
  Left = 256
  Top = 275
  AutoScroll = False
  Caption = '客户批发排行报表'
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
      Caption = '&Q 退出'
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
    Top = 0
    Width = 300
    Height = 181
    Caption = '查询条件'
    Color = 16755370
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -15
    Font.Name = '宋体'
    Font.Style = []
    ParentColor = False
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 1
    object Label1: TLabel
      Left = 190
      Top = 154
      Width = 52
      Height = 13
      Caption = '显示笔数'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 5
      Top = 79
      Width = 65
      Height = 13
      Caption = '最近交易日'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 178
      Top = 79
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
    object Label5: TLabel
      Left = 5
      Top = 26
      Width = 52
      Height = 13
      Caption = '客户编号'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 5
      Top = 52
      Width = 65
      Height = 13
      Caption = '已交易金额'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 178
      Top = 52
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
    object CN1: TSpinEdit
      Left = 255
      Top = 149
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
      TabOrder = 0
      Value = 10
    end
    object LB31: TJEdit
      Left = 75
      Top = 75
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
      _EditType = CDATE_EDIT
      _SHOWCAL = NONE
      _BADINPUT = True
      _LONGTIME = False
    end
    object LB32: TJEdit
      Left = 195
      Top = 75
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
    object LB21: TJEdit
      Left = 75
      Top = 48
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
      _EditType = INTEGER_EDIT
      _SHOWCAL = NONE
      _BADINPUT = True
      _LONGTIME = False
    end
    object LB22: TJEdit
      Left = 195
      Top = 48
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
    object LB11: JLOOKUPBOX
      Left = 75
      Top = 22
      Width = 221
      Height = 21
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
  end
  object QTOP3F: TQuery
    DatabaseName = 'MAIN'
    SQL.Strings = (
      'SELECT *'
      'FROM BCST '
      '')
    Left = 270
    Top = 5
    object QTOP3FBCENO: TStringField
      FieldName = 'BCENO'
      Origin = 'MAIN.BCST.BCENO'
      Size = 10
    end
    object QTOP3FBCNAM: TStringField
      FieldName = 'BCNAM'
      Origin = 'MAIN.BCST.BCNAM'
      Size = 40
    end
    object QTOP3FBCCNA: TStringField
      FieldName = 'BCCNA'
      Origin = 'MAIN.BCST.BCCNA'
      Size = 40
    end
    object QTOP3FBCSCN: TStringField
      FieldName = 'BCSCN'
      Origin = 'MAIN.BCST.BCSCN'
      Size = 3
    end
    object QTOP3FBCMN1: TStringField
      FieldName = 'BCMN1'
      Origin = 'MAIN.BCST.BCMN1'
      Size = 10
    end
    object QTOP3FBCMN2: TStringField
      FieldName = 'BCMN2'
      Origin = 'MAIN.BCST.BCMN2'
      Size = 10
    end
    object QTOP3FBCMN3: TStringField
      FieldName = 'BCMN3'
      Origin = 'MAIN.BCST.BCMN3'
      Size = 10
    end
    object QTOP3FBCTL1: TStringField
      FieldName = 'BCTL1'
      Origin = 'MAIN.BCST.BCTL1'
      Size = 15
    end
    object QTOP3FBCTL2: TStringField
      FieldName = 'BCTL2'
      Origin = 'MAIN.BCST.BCTL2'
      Size = 15
    end
    object QTOP3FBCFX1: TStringField
      FieldName = 'BCFX1'
      Origin = 'MAIN.BCST.BCFX1'
      Size = 15
    end
    object QTOP3FBCFX2: TStringField
      FieldName = 'BCFX2'
      Origin = 'MAIN.BCST.BCFX2'
      Size = 15
    end
    object QTOP3FBCAD1: TStringField
      FieldName = 'BCAD1'
      Origin = 'MAIN.BCST.BCAD1'
      Size = 50
    end
    object QTOP3FBCAD2: TStringField
      FieldName = 'BCAD2'
      Origin = 'MAIN.BCST.BCAD2'
      Size = 50
    end
    object QTOP3FBCZP1: TStringField
      FieldName = 'BCZP1'
      Origin = 'MAIN.BCST.BCZP1'
      Size = 5
    end
    object QTOP3FBCZP2: TStringField
      FieldName = 'BCZP2'
      Origin = 'MAIN.BCST.BCZP2'
      Size = 5
    end
    object QTOP3FBCTL9: TStringField
      FieldName = 'BCTL9'
      Origin = 'MAIN.BCST.BCTL9'
      Size = 15
    end
    object QTOP3FBCAD9: TStringField
      FieldName = 'BCAD9'
      Origin = 'MAIN.BCST.BCAD9'
      Size = 50
    end
    object QTOP3FBCZP9: TStringField
      FieldName = 'BCZP9'
      Origin = 'MAIN.BCST.BCZP9'
      Size = 5
    end
    object QTOP3FBCDIS: TFloatField
      FieldName = 'BCDIS'
      Origin = 'MAIN.BCST.BCDIS'
    end
    object QTOP3FBCTP1: TFloatField
      FieldName = 'BCTP1'
      Origin = 'MAIN.BCST.BCTP1'
    end
    object QTOP3FBCTP2: TFloatField
      FieldName = 'BCTP2'
      Origin = 'MAIN.BCST.BCTP2'
    end
    object QTOP3FBCTP5: TFloatField
      FieldName = 'BCTP5'
      Origin = 'MAIN.BCST.BCTP5'
    end
    object QTOP3FBCTP6: TFloatField
      FieldName = 'BCTP6'
      Origin = 'MAIN.BCST.BCTP6'
    end
    object QTOP3FBCTPN: TStringField
      FieldName = 'BCTPN'
      Origin = 'MAIN.BCST.BCTPN'
      Size = 30
    end
    object QTOP3FBCTTP: TStringField
      FieldName = 'BCTTP'
      Origin = 'MAIN.BCST.BCTTP'
      Size = 3
    end
    object QTOP3FBCTTD: TFloatField
      FieldName = 'BCTTD'
      Origin = 'MAIN.BCST.BCTTD'
    end
    object QTOP3FBCTEG: TStringField
      FieldName = 'BCTEG'
      Origin = 'MAIN.BCST.BCTEG'
      Size = 5
    end
    object QTOP3FBCTBK: TStringField
      FieldName = 'BCTBK'
      Origin = 'MAIN.BCST.BCTBK'
      Size = 3
    end
    object QTOP3FBCALT: TFloatField
      FieldName = 'BCALT'
      Origin = 'MAIN.BCST.BCALT'
    end
    object QTOP3FBCTDT: TDateTimeField
      FieldName = 'BCTDT'
      Origin = 'MAIN.BCST.BCTDT'
    end
    object QTOP3FBCDAT: TDateTimeField
      FieldName = 'BCDAT'
      Origin = 'MAIN.BCST.BCDAT'
    end
    object QTOP3FBCID1: TStringField
      FieldName = 'BCID1'
      Origin = 'MAIN.BCST.BCID1'
      Size = 10
    end
    object QTOP3FBCMRK: TMemoField
      FieldName = 'BCMRK'
      Origin = 'MAIN.BCST.BCMRK'
      BlobType = ftMemo
      Size = 1
    end
    object QTOP3FBNENO: TStringField
      FieldName = 'BNENO'
      Origin = 'MAIN.BCST.BNENO'
      Size = 10
    end
  end
end
