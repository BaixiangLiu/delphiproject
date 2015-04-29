object RMLOGF: TRMLOGF
  Left = 303
  Top = 305
  AutoScroll = False
  Caption = '使用者登录记录报表'
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
  object GroupBox3: TGroupBox
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
    object Label8: TLabel
      Left = 10
      Top = 23
      Width = 60
      Height = 15
      Caption = '收银位置'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 10
      Top = 48
      Width = 60
      Height = 15
      Caption = '使用人员'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 10
      Top = 73
      Width = 60
      Height = 15
      Caption = '登录日期'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 173
      Top = 73
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
    object Label4: TLabel
      Left = 10
      Top = 99
      Width = 60
      Height = 15
      Caption = '查询项目'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 10
      Top = 144
      Width = 60
      Height = 15
      Caption = '查询项目'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
    end
    object LB11: SELOOKUPBOX
      Left = 70
      Top = 20
      Width = 220
      Height = 21
      Ctl3D = False
      MaxLength = 20
      ParentCtl3D = False
      TabOrder = 0
      _DatabaseName = 'MAIN'
      _TableName = 'SYSLST'
      _Field_IDNO = 'POSAPAIDE'
      _EDIT_WIDTH = 80
      _CHANGE_QUERY = True
      _INSERT_RECORD = True
      _SHOW_MESSAGE = False
    end
    object LB21: JLOOKUPBOX
      Left = 70
      Top = 45
      Width = 220
      Height = 21
      Ctl3D = False
      MaxLength = 20
      ParentCtl3D = False
      TabOrder = 1
      _DatabaseName = 'MAIN'
      _TableName = 'BMAN'
      _Field_IDNO = 'BNENO'
      _Field_NAME = 'BNNAM'
      _EDIT_WIDTH = 80
      _CHANGE_QUERY = True
      _INSERT_RECORD = False
      _SHOW_MESSAGE = False
    end
    object LB31: TJEdit
      Left = 70
      Top = 70
      Width = 100
      Height = 21
      Ctl3D = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = '宋体'
      Font.Style = []
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 2
      Digits = 1
      Max = 999999999
      _EditType = INTEGER_EDIT
      _SHOWCAL = NONE
      _BADINPUT = True
      _LONGTIME = False
    end
    object LB32: TJEdit
      Left = 191
      Top = 69
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
    object LB91: TComboBox
      Left = 70
      Top = 95
      Width = 220
      Height = 23
      Ctl3D = False
      ItemHeight = 15
      ParentCtl3D = False
      TabOrder = 4
      Items.Strings = (
        '登入记录'
        '改密码记录'
        '改权限记录'
        '开钱柜记录'
        '发票作废记录'
        '发票退货记录'
        '备份资料记录')
    end
    object WK1: TComboBox
      Left = 70
      Top = 140
      Width = 220
      Height = 23
      Style = csDropDownList
      Ctl3D = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = '宋体'
      Font.Style = []
      ItemHeight = 15
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 5
      Items.Strings = (
        '收银位置'
        '使用人员'
        '登录日期')
    end
  end
  object QLOGF: TQuery
    DatabaseName = 'MAIN'
    SQL.Strings = (
      'SELECT *'
      'FROM  SYSLOG , BMAN'
      'WHERE SYSLOG.BNENO = BMAN.BNENO'
      ' ')
    Left = 320
    Top = 45
    object QLOGFSGENO: TStringField
      FieldName = 'SGENO'
      Origin = 'MAIN.SYSLOG.SGENO'
      Size = 15
    end
    object QLOGFSGKIN: TStringField
      FieldName = 'SGKIN'
      Origin = 'MAIN.SYSLOG.SGKIN'
      Size = 3
    end
    object QLOGFPAIDE: TStringField
      FieldName = 'PAIDE'
      Origin = 'MAIN.SYSLOG.PAIDE'
      Size = 3
    end
    object QLOGFBNENO: TStringField
      FieldName = 'BNENO'
      Origin = 'MAIN.SYSLOG.BNENO'
      Size = 10
    end
    object QLOGFSGDAT: TDateTimeField
      FieldName = 'SGDAT'
      Origin = 'MAIN.SYSLOG.SGDAT'
    end
    object QLOGFSGTME: TStringField
      FieldName = 'SGTME'
      Origin = 'MAIN.SYSLOG.SGTME'
      Size = 5
    end
    object QLOGFSGMRK: TStringField
      FieldName = 'SGMRK'
      Origin = 'MAIN.SYSLOG.SGMRK'
    end
    object QLOGFBNNAM: TStringField
      FieldName = 'BNNAM'
      Origin = 'MAIN.SYSLOG.SGMRK'
    end
  end
end
