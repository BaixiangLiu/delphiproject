object FMPOSM: TFMPOSM
  Left = 75
  Top = 113
  AutoScroll = False
  Caption = '特价信息'
  ClientHeight = 383
  ClientWidth = 692
  Color = 15648684
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = '宋体'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object StatusBar: TStatusBar
    Left = 0
    Top = 364
    Width = 692
    Height = 19
    Panels = <
      item
        Alignment = taCenter
        Width = 120
      end
      item
        Width = 120
      end>
    SimplePanel = False
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 567
    Height = 364
    Align = alClient
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Caption = ' '
    Color = 16766935
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = '宋体'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 1
    object LBBGENO: TLabel
      Left = 1
      Top = 8
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
    object LBPMPRI: TLabel
      Left = 3
      Top = 28
      Width = 48
      Height = 12
      Caption = '特惠价格'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
    end
    object LBPMDT1: TLabel
      Left = 2
      Top = 48
      Width = 48
      Height = 12
      Caption = '起 始 日'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
    end
    object LBPMDT2: TLabel
      Left = 2
      Top = 68
      Width = 48
      Height = 12
      Caption = '结 束 日'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
    end
    object LBPNDAT: TLabel
      Left = 2
      Top = 91
      Width = 48
      Height = 12
      Caption = '建 档 日'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
    end
    object GroupBox1: TGroupBox
      Left = 343
      Top = 0
      Width = 220
      Height = 111
      Caption = '快速查询'
      Ctl3D = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = '宋体'
      Font.Style = []
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 5
      object LB1: TLabel
        Left = 3
        Top = 20
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
      object LB2: TLabel
        Left = 3
        Top = 40
        Width = 60
        Height = 12
        Caption = '起  始  日'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
      end
      object LB3: TLabel
        Left = 3
        Top = 60
        Width = 60
        Height = 12
        Caption = '结  束  日'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
      end
      object Label7: TLabel
        Left = 133
        Top = 19
        Width = 12
        Height = 12
        Caption = '至'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
      end
      object Label9: TLabel
        Left = 133
        Top = 59
        Width = 12
        Height = 12
        Caption = '至'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
      end
      object Label1: TLabel
        Left = 133
        Top = 39
        Width = 12
        Height = 12
        Caption = '至'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
      end
      object LB11: TJEdit
        Left = 65
        Top = 15
        Width = 65
        Height = 19
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
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
      object LB31: TJEdit
        Left = 65
        Top = 55
        Width = 65
        Height = 19
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
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
      object LB12: TJEdit
        Left = 150
        Top = 15
        Width = 65
        Height = 19
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
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
      object LB32: TJEdit
        Left = 150
        Top = 55
        Width = 65
        Height = 19
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        Digits = 1
        Max = 999999999
        _EditType = EDIT
        _SHOWCAL = NONE
        _BADINPUT = True
        _LONGTIME = False
      end
      object LB21: TJEdit
        Left = 65
        Top = 35
        Width = 65
        Height = 19
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
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
      object LB22: TJEdit
        Left = 150
        Top = 35
        Width = 65
        Height = 19
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
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
      object BTNSER: TBitBtn
        Left = 10
        Top = 76
        Width = 120
        Height = 30
        Cursor = crHandPoint
        Caption = 'F5 查询'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        OnClick = BTNSERClick
        Spacing = 1
      end
      object BTNCLR: TBitBtn
        Left = 135
        Top = 76
        Width = 80
        Height = 30
        Cursor = crHandPoint
        Caption = '清除'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
        OnClick = BTNCLRClick
        Spacing = 1
      end
    end
    object PMPRI: TDBEdit
      Left = 60
      Top = 25
      Width = 100
      Height = 19
      DataField = 'PMPRI'
      DataSource = FMPOSMD.DSPOSM
      TabOrder = 1
    end
    object PMDT1: TJDBEdit
      Left = 60
      Top = 45
      Width = 100
      Height = 19
      DataField = 'PMDT1'
      DataSource = FMPOSMD.DSPOSM
      TabOrder = 2
      _EditType = EDATE_EDIT
      _SHOWCAL = NONE
    end
    object PMDT2: TJDBEdit
      Left = 60
      Top = 65
      Width = 100
      Height = 19
      DataField = 'PMDT2'
      DataSource = FMPOSMD.DSPOSM
      TabOrder = 3
      _EditType = EDATE_EDIT
      _SHOWCAL = NONE
    end
    object BGENO: JDBLOOKUPBOX
      Left = 60
      Top = 5
      Width = 280
      Height = 19
      DataField = 'BGENO'
      DataSource = FMPOSMD.DSPOSM
      MaxLength = 20
      TabOrder = 0
      _DatabaseName = 'MAIN'
      _TableName = 'BGDS'
      _Field_IDNO = 'BGENO'
      _Field_NAME = 'BGNAM'
      _EDIT_WIDTH = 100
      _CHANGE_QUERY = True
      _INSERT_RECORD = False
      _SHOW_MESSAGE = False
    end
    object DBGrid: TDBGrid
      Left = 1
      Top = 115
      Width = 561
      Height = 246
      DataSource = FMPOSMD.DSPOSM
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 6
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -13
      TitleFont.Name = '宋体'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'BGENO'
          Title.Alignment = taCenter
          Title.Caption = '产品条形码'
          Title.Color = clInfoBk
          Width = 149
          Visible = True
        end
        item
          Expanded = False
          FieldName = '_BGNAM'
          Title.Alignment = taCenter
          Title.Caption = '产品名称'
          Title.Color = clInfoBk
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PMPRI'
          Title.Alignment = taCenter
          Title.Caption = '特惠价格'
          Title.Color = clInfoBk
          Width = 69
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PMDT1'
          Title.Alignment = taCenter
          Title.Caption = '起始日'
          Title.Color = clInfoBk
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PMDT2'
          Title.Alignment = taCenter
          Title.Caption = '结束日'
          Title.Color = clInfoBk
          Width = 77
          Visible = True
        end>
    end
    object PMDAT: TJDBEdit
      Left = 60
      Top = 87
      Width = 100
      Height = 19
      DataField = 'PMDAT'
      DataSource = FMPOSMD.DSPOSM
      TabOrder = 4
      _EditType = EDATE_EDIT
      _SHOWCAL = NONE
    end
  end
  object Panel1: TPanel
    Left = 567
    Top = 0
    Width = 125
    Height = 364
    Align = alRight
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Caption = ' '
    Color = clBlack
    TabOrder = 2
    object BTNQUT: TBitBtn
      Left = 0
      Top = 310
      Width = 120
      Height = 50
      Cursor = crHandPoint
      Caption = 'Ctrl+Q 结束'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = BTNQUTClick
    end
    object BTNCAL: TBitBtn
      Left = 0
      Top = 150
      Width = 120
      Height = 50
      Cursor = crHandPoint
      Caption = 'F4 取消'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = BTNCALClick
      Spacing = 1
    end
    object BTNYES: TBitBtn
      Left = 0
      Top = 100
      Width = 120
      Height = 50
      Cursor = crHandPoint
      Caption = 'F3 确定'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = BTNYESClick
      Spacing = 1
    end
    object BTNDEL: TBitBtn
      Left = 0
      Top = 50
      Width = 120
      Height = 50
      Cursor = crHandPoint
      Caption = 'F2 删除'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = BTNDELClick
      Spacing = 1
    end
    object BTNINS: TBitBtn
      Left = 0
      Top = 0
      Width = 120
      Height = 50
      Cursor = crHandPoint
      Caption = 'F1 新增'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = BTNINSClick
      Spacing = 1
    end
    object BTNPRN: TBitBtn
      Left = 0
      Top = 260
      Width = 120
      Height = 50
      Cursor = crHandPoint
      Caption = 'F8 打印'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      OnClick = BTNPRNClick
      Spacing = 1
    end
    object BTNPRE: TBitBtn
      Left = 0
      Top = 210
      Width = 120
      Height = 50
      Cursor = crHandPoint
      Caption = 'F7 预览'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      OnClick = BTNPRNClick
      Spacing = 1
    end
  end
  object MainMenu: TMainMenu
    Left = 576
    Top = 6
    object N1: TMenuItem
      Caption = '新增'
      ShortCut = 112
      Visible = False
      OnClick = BTNINSClick
    end
    object N2: TMenuItem
      Caption = '删除'
      ShortCut = 113
      Visible = False
      OnClick = BTNDELClick
    end
    object N3: TMenuItem
      Caption = '确定'
      ShortCut = 114
      Visible = False
      OnClick = BTNYESClick
    end
    object N4: TMenuItem
      Caption = '取消'
      ShortCut = 115
      Visible = False
      OnClick = BTNCALClick
    end
    object N6: TMenuItem
      Caption = '查询'
      ShortCut = 116
      Visible = False
      OnClick = BTNSERClick
    end
    object MENPRE: TMenuItem
      Caption = '预览'
      ShortCut = 118
      Visible = False
      OnClick = BTNPRNClick
    end
    object MENPRN: TMenuItem
      Caption = '打印'
      ShortCut = 119
      Visible = False
      OnClick = BTNPRNClick
    end
    object N5: TMenuItem
      Caption = '结束'
      ShortCut = 16465
      Visible = False
      OnClick = BTNQUTClick
    end
  end
end
