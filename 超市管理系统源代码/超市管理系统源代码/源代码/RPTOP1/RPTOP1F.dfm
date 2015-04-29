object RMTOP1F: TRMTOP1F
  Left = 232
  Top = 271
  AutoScroll = False
  Caption = '产品销售排行报表'
  ClientHeight = 158
  ClientWidth = 301
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
    Left = 0
    Top = 125
    Width = 300
    Height = 33
    BevelOuter = bvNone
    BorderWidth = 1
    Color = clMenu
    TabOrder = 0
    object BTNPRN: TSpeedButton
      Left = 120
      Top = 5
      Width = 60
      Height = 25
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
      Left = 24
      Top = 6
      Width = 60
      Height = 25
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
      Left = 214
      Top = 5
      Width = 60
      Height = 25
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
    Top = 0
    Width = 300
    Height = 121
    Caption = '查询条件'
    Color = clActiveBorder
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
    object Label3: TLabel
      Left = 7
      Top = 85
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
    object Label4: TLabel
      Left = 7
      Top = 55
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
    object Label1: TLabel
      Left = 7
      Top = 26
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
      Top = 25
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
      Left = 75
      Top = 80
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
    object WK1: TComboBox
      Left = 75
      Top = 50
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
      TabOrder = 1
      Items.Strings = (
        '数量'
        '单价'
        '总价')
    end
    object LB11: TJEdit
      Left = 75
      Top = 21
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
    object LB12: TJEdit
      Left = 195
      Top = 21
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
  end
  object QTOP1F: TQuery
    DatabaseName = 'MAIN'
    SQL.Strings = (
      'SELECT TOP 2'
      'BGDS.BGENO, BGDS.BGNAM,'
      'SUM(POSB.BGCNT) ,SUM(POSB.BGCOS) ,SUM(POSB.BGCOT), BGDS.BGKIN'
      'FROM POSA, POSB, BGDS'
      'WHERE POSB.BGENO = BGDS.BGENO'
      '  AND POSA.PAENO = POSB.PAENO'
      'GROUP BY BGDS.BGENO, BGDS.BGNAM, BGDS.BGKIN'
      'order by 6 DESC'
      ''
      ''
      ' '
      ' ')
    Left = 186
    Top = 69
    object QTOP1FBGENO: TStringField
      FieldName = 'BGENO'
    end
    object QTOP1FBGNAM: TStringField
      FieldName = 'BGNAM'
      Size = 50
    end
    object QTOP1FBGKIN: TStringField
      FieldName = 'BGKIN'
      Size = 10
    end
    object QTOP1FExpr1002: TFloatField
      FieldName = 'Expr1002'
      Origin = 'MAIN.POSB.BGCNT'
    end
    object QTOP1FExpr1003: TFloatField
      FieldName = 'Expr1003'
      Origin = 'MAIN.POSB.BGCOS'
    end
    object QTOP1FExpr1004: TFloatField
      FieldName = 'Expr1004'
      Origin = 'MAIN.POSB.BGCOT'
    end
  end
end
