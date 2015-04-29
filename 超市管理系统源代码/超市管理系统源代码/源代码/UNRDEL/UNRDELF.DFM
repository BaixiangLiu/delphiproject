object FMRDELF: TFMRDELF
  Left = 304
  Top = 189
  Width = 320
  Height = 395
  Caption = ' '
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 5
    Top = 40
    Width = 300
    Height = 201
    Caption = '查询条件'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object LB1: TLabel
      Left = 10
      Top = 25
      Width = 56
      Height = 16
      Caption = '报废单号'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object LB2: TLabel
      Left = 10
      Top = 50
      Width = 56
      Height = 16
      Caption = '产品编号'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 173
      Top = 24
      Width = 14
      Height = 16
      Caption = '至'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object LB5: TLabel
      Left = 10
      Top = 125
      Width = 56
      Height = 16
      Caption = '报废日期'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 173
      Top = 124
      Width = 14
      Height = 16
      Caption = '至'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object LB4: TLabel
      Left = 10
      Top = 100
      Width = 56
      Height = 16
      Caption = '申请人员'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object LB3: TLabel
      Left = 10
      Top = 75
      Width = 56
      Height = 16
      Caption = '报废原因'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object LB11: TJEdit
      Left = 70
      Top = 20
      Width = 100
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Digits = 1
      Max = 999999999
      _EditType = EDIT
    end
    object LB12: TJEdit
      Left = 190
      Top = 20
      Width = 100
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Digits = 1
      Max = 999999999
      _EditType = EDIT
    end
    object LB21: TJEdit
      Left = 70
      Top = 45
      Width = 220
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      Digits = 1
      Max = 999999999
      _EditType = EDIT
    end
    object LB51: TJEdit
      Left = 70
      Top = 120
      Width = 100
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      Digits = 1
      Max = 999999999
      _EditType = EDIT
    end
    object LB52: TJEdit
      Left = 190
      Top = 120
      Width = 100
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      Digits = 1
      Max = 999999999
      _EditType = EDIT
    end
    object LB41: JLOOKUPBOX
      Left = 70
      Top = 95
      Width = 220
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 20
      ParentFont = False
      TabOrder = 4
      _DatabaseName = 'MAIN'
      _TableName = 'BSUP'
      _Field_IDNO = 'BSENO'
      _Field_NAME = 'BSNAM'
      _EDIT_WIDTH = 80
      _CHANGE_QUERY = True
      _INSERT_RECORD = False
      _SHOW_MESSAGE = False
    end
    object LB31: JLOOKUPBOX
      Left = 70
      Top = 70
      Width = 220
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 20
      ParentFont = False
      TabOrder = 3
      _DatabaseName = 'MAIN'
      _TableName = 'SYSLST'
      _Field_IDNO = 'LSTID2'
      _Field_NAME = 'LSTNAM'
      _Field_KEY1 = 'LSTID1'
      _Field_KEY2 = 'RGETRGREA'
      _EDIT_WIDTH = 80
      _CHANGE_QUERY = True
      _INSERT_RECORD = True
      _INSERT_SYSLST = 'RGETRGREA'
      _SHOW_MESSAGE = True
    end
    object LB61: TRadioGroup
      Left = 5
      Top = 150
      Width = 286
      Height = 41
      Columns = 3
      Ctl3D = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemIndex = 0
      Items.Strings = (
        '未销档单据'
        '已销档单据'
        '全部单据')
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 7
    end
  end
  object GroupBox2: TGroupBox
    Left = 5
    Top = 245
    Width = 300
    Height = 121
    Caption = '排列顺序'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object Label4: TLabel
      Left = 15
      Top = 30
      Width = 42
      Height = 16
      Caption = '条件一'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 15
      Top = 55
      Width = 42
      Height = 16
      Caption = '条件二'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 15
      Top = 80
      Width = 42
      Height = 16
      Caption = '条件三'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object WHEREKEY1: TComboBox
      Left = 70
      Top = 25
      Width = 220
      Height = 24
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 16
      ParentFont = False
      TabOrder = 0
      OnExit = WHEREKEY1Exit
    end
    object WHEREKEY2: TComboBox
      Left = 70
      Top = 55
      Width = 220
      Height = 24
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 16
      ParentFont = False
      TabOrder = 1
      OnExit = WHEREKEY1Exit
    end
    object WHEREKEY3: TComboBox
      Left = 70
      Top = 85
      Width = 220
      Height = 24
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 16
      ParentFont = False
      TabOrder = 2
      OnExit = WHEREKEY1Exit
    end
  end
  object ToolBar: TToolBar
    Left = 0
    Top = 0
    Width = 312
    Height = 36
    ButtonHeight = 30
    TabOrder = 2
    object ToolButton1: TToolButton
      Left = 0
      Top = 2
      Width = 20
      Caption = 'ToolButton1'
      ImageIndex = 0
      Style = tbsSeparator
    end
    object BTNSER: TSpeedButton
      Left = 20
      Top = 2
      Width = 80
      Height = 30
      Cursor = crHandPoint
      Caption = '&F 查询'
      Flat = True
      OnClick = BTNSERClick
    end
    object ToolButton2: TToolButton
      Left = 100
      Top = 2
      Width = 20
      Caption = 'ToolButton2'
      ImageIndex = 1
      Style = tbsSeparator
    end
    object BTNCLR: TSpeedButton
      Left = 120
      Top = 2
      Width = 80
      Height = 30
      Cursor = crHandPoint
      Caption = '&C 清除'
      Flat = True
      OnClick = BTNCLRClick
    end
    object ToolButton3: TToolButton
      Left = 200
      Top = 2
      Width = 20
      Caption = 'ToolButton3'
      ImageIndex = 2
      Style = tbsSeparator
    end
    object BTNQUT: TSpeedButton
      Left = 220
      Top = 2
      Width = 80
      Height = 30
      Cursor = crHandPoint
      Caption = '&Q 结束'
      Flat = True
      OnClick = BTNQUTClick
    end
  end
end 
