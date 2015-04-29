object RMPOS6F: TRMPOS6F
  Left = 224
  Top = 127
  AutoScroll = False
  Caption = '产品销售计算报表'
  ClientHeight = 313
  ClientWidth = 350
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
    Left = 1
    Top = 0
    Width = 345
    Height = 181
    Caption = '查询条件'
    Color = clActiveBorder
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
      Left = 40
      Top = 19
      Width = 48
      Height = 12
      Caption = '查询日期'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 201
      Top = 19
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
    object Label3: TLabel
      Left = 40
      Top = 69
      Width = 60
      Height = 12
      Caption = '产品条形码'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 40
      Top = 119
      Width = 48
      Height = 12
      Caption = '产品分类'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 40
      Top = 44
      Width = 60
      Height = 12
      Caption = '产品条形码'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 40
      Top = 94
      Width = 48
      Height = 12
      Caption = '产品名称'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 40
      Top = 144
      Width = 48
      Height = 12
      Caption = '厂商编号'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 15
      Top = 18
      Width = 21
      Height = 152
      AutoSize = False
      Caption = '↑├├├├├├├├└'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Label9: TLabel
      Left = 320
      Top = 14
      Width = 21
      Height = 167
      AutoSize = False
      Caption = '┐││││││││┤↓'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object LB11: TJEdit
      Left = 105
      Top = 15
      Width = 95
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
      Left = 215
      Top = 15
      Width = 95
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
    object LB51: JLOOKUPBOX
      Left = 105
      Top = 115
      Width = 205
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
      _TableName = 'SYSLST'
      _Field_IDNO = 'LSTID2'
      _Field_NAME = 'LSTNAM'
      _Field_KEY1 = 'LSTID1'
      _Field_KEY2 = 'BGDSBGKIN'
      _EDIT_WIDTH = 100
      _CHANGE_QUERY = True
      _INSERT_RECORD = True
      _INSERT_SYSLST = 'BGDSBGKIN'
      _SHOW_MESSAGE = True
    end
    object LB31: TJEdit
      Left = 105
      Top = 65
      Width = 205
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
    object LB21: JLOOKUPBOX
      Left = 105
      Top = 40
      Width = 205
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
      _TableName = 'BGDS'
      _Field_IDNO = 'BGENO'
      _Field_NAME = 'BGNAM'
      _EDIT_WIDTH = 100
      _CHANGE_QUERY = True
      _INSERT_RECORD = False
      _SHOW_MESSAGE = False
    end
    object LB41: TJEdit
      Left = 105
      Top = 90
      Width = 205
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
      _EditType = EDIT
      _SHOWCAL = NONE
      _BADINPUT = True
      _LONGTIME = False
    end
    object LB61: JLOOKUPBOX
      Left = 105
      Top = 140
      Width = 205
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = '宋体'
      Font.Style = []
      MaxLength = 20
      ParentFont = False
      TabOrder = 6
      _DatabaseName = 'MAIN'
      _TableName = 'BSUP'
      _Field_IDNO = 'BSENO'
      _Field_NAME = 'BSNAM'
      _EDIT_WIDTH = 100
      _CHANGE_QUERY = True
      _INSERT_RECORD = False
      _SHOW_MESSAGE = False
    end
  end
  object ToolBar: TToolBar
    Left = 0
    Top = 240
    Width = 345
    Height = 36
    Align = alNone
    ButtonHeight = 30
    TabOrder = 1
    object ToolButton1: TToolButton
      Left = 0
      Top = 2
      Width = 10
      Caption = 'ToolButton1'
      ImageIndex = 0
      Style = tbsSeparator
    end
    object BTNPRE: TSpeedButton
      Left = 10
      Top = 2
      Width = 87
      Height = 30
      Cursor = crHandPoint
      Caption = '&W 商品计算预览'
      Flat = True
      OnClick = BTNPREClick
    end
    object ToolButton2: TToolButton
      Left = 97
      Top = 2
      Width = 10
      Caption = 'ToolButton2'
      ImageIndex = 1
      Style = tbsSeparator
    end
    object BTNPRN: TSpeedButton
      Left = 107
      Top = 2
      Width = 120
      Height = 30
      Cursor = crHandPoint
      Caption = '&P 商品计算打印'
      Flat = True
      OnClick = BTNPREClick
    end
    object ToolButton3: TToolButton
      Left = 227
      Top = 2
      Width = 10
      Caption = 'ToolButton3'
      ImageIndex = 2
      Style = tbsSeparator
    end
    object BTNQUT: TSpeedButton
      Left = 237
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
    Left = 0
    Top = 183
    Width = 346
    Height = 56
    Caption = '排列方式'
    Color = clMenu
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -15
    Font.Name = '宋体'
    Font.Style = []
    ParentColor = False
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 2
    object WK1: TComboBox
      Left = 50
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
        '品名'
        '数量'
        '总价'
        '分类'
        '厂商'
        ' ')
    end
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 279
    Width = 348
    Height = 36
    Align = alNone
    ButtonHeight = 30
    Caption = 'ToolBar1'
    TabOrder = 3
    object ToolButton4: TToolButton
      Left = 0
      Top = 2
      Width = 41
      Caption = 'ToolButton1'
      ImageIndex = 0
      Style = tbsSeparator
    end
    object BTNPRE1: TSpeedButton
      Left = 41
      Top = 2
      Width = 83
      Height = 30
      Cursor = crHandPoint
      Caption = '&E 厂商计算预览'
      Flat = True
      OnClick = BTNPRE1Click
    end
    object ToolButton5: TToolButton
      Left = 124
      Top = 2
      Width = 64
      Caption = 'ToolButton5'
      ImageIndex = 1
      Style = tbsSeparator
    end
    object BTNPRN1: TSpeedButton
      Left = 188
      Top = 2
      Width = 99
      Height = 30
      Cursor = crHandPoint
      Caption = '&R 厂商计算打印'
      Flat = True
    end
    object ToolButton6: TToolButton
      Left = 287
      Top = 2
      Width = 8
      Caption = 'ToolButton6'
      ImageIndex = 2
      Style = tbsSeparator
    end
  end
  object QPOS6F: TQuery
    DatabaseName = 'MAIN'
    SQL.Strings = (
      'SELECT'
      'SUM(POSB.BGCNT) ,SUM(POSB.BGCOS) ,SUM(POSB.BGCOT),'
      'BGDS.BGNAM, POSB.BGENO,'
      
        'BGDS.BGPST, BGDS.BGPMM, BGDS.BGPVP, BGDS.BGKIN, BGDS.BGCOS, BGDS' +
        '.BSENO'
      'FROM POSA, POSB, BGDS'
      'WHERE POSB.BGENO = BGDS.BGENO'
      '  AND POSA.PAENO = POSB.PAENO'
      'GROUP BY POSB.BGENO,BGDS.BGNAM,'
      
        'BGDS.BGPST, BGDS.BGPMM, BGDS.BGPVP, BGDS.BGKIN, BGDS.BGCOS, BGDS' +
        '.BSENO'
      'order by 1 DESC'
      ' '
      ' ')
    Left = 226
    Top = 198
    object QPOS6FExpr1000: TFloatField
      FieldName = 'Expr1000'
    end
    object QPOS6FExpr1001: TFloatField
      FieldName = 'Expr1001'
    end
    object QPOS6FExpr1002: TFloatField
      FieldName = 'Expr1002'
    end
    object QPOS6FBGNAM: TStringField
      FieldName = 'BGNAM'
      Size = 50
    end
    object QPOS6FBGENO: TStringField
      FieldName = 'BGENO'
    end
    object QPOS6FBGPST: TFloatField
      FieldName = 'BGPST'
    end
    object QPOS6FBGPMM: TFloatField
      FieldName = 'BGPMM'
    end
    object QPOS6FBGPVP: TFloatField
      FieldName = 'BGPVP'
    end
    object QPOS6FBGKIN: TStringField
      FieldName = 'BGKIN'
      Size = 10
    end
    object QPOS6FBGCOS: TFloatField
      FieldName = 'BGCOS'
    end
    object QPOS6FBSENO: TStringField
      FieldName = 'BSENO'
      Size = 10
    end
  end
  object QPOS6F1: TQuery
    DatabaseName = 'MAIN'
    SQL.Strings = (
      'SELECT SUM(POSB.BGCOT), BGDS.BSENO'
      'FROM POSA, POSB, BGDS'
      'WHERE POSB.BGENO = BGDS.BGENO'
      '  AND POSA.PAENO = POSB.PAENO'
      'GROUP BY BGDS.BSENO'
      'order by 1 DESC'
      ' '
      ' ')
    Left = 159
    Top = 202
    object QPOS6F1Expr1000: TFloatField
      FieldName = 'Expr1000'
    end
    object QPOS6F1BSENO: TStringField
      FieldName = 'BSENO'
      Size = 10
    end
  end
end
