object RMPOS5F: TRMPOS5F
  Left = 258
  Top = 197
  AutoScroll = False
  Caption = '会员消费计算报表'
  ClientHeight = 183
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
    Height = 183
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
    object Label1: TLabel
      Left = 15
      Top = 20
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
      Left = 178
      Top = 19
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
    object Label3: TLabel
      Left = 10
      Top = 149
      Width = 52
      Height = 13
      Caption = '排列方式'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 53
      Top = 70
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
    object Label4: TLabel
      Left = 20
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
    object LB11: TJEdit
      Left = 75
      Top = 15
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
      _EditType = CDATE_EDIT
      _SHOWCAL = NONE
      _BADINPUT = True
      _LONGTIME = False
    end
    object LB12: TJEdit
      Left = 195
      Top = 15
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
    object LB22: JLOOKUPBOX
      Left = 75
      Top = 67
      Width = 221
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = '宋体'
      Font.Style = []
      MaxLength = 20
      ParentFont = False
      TabOrder = 3
      _DatabaseName = 'MAIN'
      _TableName = 'BMEM'
      _Field_IDNO = 'BMENO'
      _Field_NAME = 'BMNAM'
      _EDIT_WIDTH = 80
      _CHANGE_QUERY = True
      _INSERT_RECORD = False
      _SHOW_MESSAGE = False
    end
    object LB21: JLOOKUPBOX
      Left = 75
      Top = 42
      Width = 221
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = '宋体'
      Font.Style = []
      MaxLength = 20
      ParentFont = False
      TabOrder = 2
      _DatabaseName = 'MAIN'
      _TableName = 'BMEM'
      _Field_IDNO = 'BMENO'
      _Field_NAME = 'BMNAM'
      _EDIT_WIDTH = 80
      _CHANGE_QUERY = True
      _INSERT_RECORD = False
      _SHOW_MESSAGE = False
    end
    object WK1: TComboBox
      Left = 75
      Top = 145
      Width = 221
      Height = 23
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = '宋体'
      Font.Style = []
      ItemHeight = 15
      ParentFont = False
      TabOrder = 4
      Items.Strings = (
        '数量'
        '单价'
        '总价')
    end
  end
  object Panel1: TPanel
    Left = 305
    Top = 0
    Width = 120
    Height = 183
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
  object QPOS5F: TQuery
    DatabaseName = 'MAIN'
    SQL.Strings = (
      'SELECT'
      'BMEM.BMNAM, POSA.BMENO,'
      'SUM(POSB.BGCNT) ,SUM(POSB.BGCOS) ,SUM(POSB.BGCOT)'
      'FROM POSA, POSB, BMEM'
      'WHERE POSA.BMENO = BMEM.BMENO'
      '  AND POSA.PAENO = POSB.PAENO'
      'GROUP BY POSA.BMENO,BMEM.BMNAM'
      'order by 1 DESC')
    Left = 270
    Top = 5
    object QPOS5FBMNAM: TStringField
      FieldName = 'BMNAM'
      Size = 10
    end
    object QPOS5FBMENO: TStringField
      FieldName = 'BMENO'
      Size = 10
    end
    object QPOS5FExpr1002: TFloatField
      FieldName = 'Expr1002'
    end
    object QPOS5FExpr1003: TFloatField
      FieldName = 'Expr1003'
    end
    object QPOS5FExpr1004: TFloatField
      FieldName = 'Expr1004'
    end
  end
end
