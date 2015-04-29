object FMRCJN: TFMRCJN
  Left = 142
  Top = 328
  AutoScroll = False
  Caption = '进货退出作业'
  ClientHeight = 435
  ClientWidth = 772
  Color = 13883848
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = '宋体'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object DBGrid2: TDBGrid
    Left = 0
    Top = 233
    Width = 571
    Height = 202
    Align = alClient
    Ctl3D = False
    DataSource = FMRCJND.DSRCJNB
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = '宋体'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    PopupMenu = PopupMenuDBGRID
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = '宋体'
    TitleFont.Style = []
    OnColExit = DBGrid2ColExit
    OnEditButtonClick = DBGrid2EditButtonClick
    Columns = <
      item
        Expanded = False
        FieldName = 'RJITM'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = '项次'
        Title.Color = clInfoBk
        Width = 48
        Visible = True
      end
      item
        ButtonStyle = cbsEllipsis
        Color = 14283263
        Expanded = False
        FieldName = 'BGENO'
        Title.Alignment = taCenter
        Title.Caption = '产品条形码'
        Title.Color = clInfoBk
        Width = 141
        Visible = True
      end
      item
        Expanded = False
        FieldName = '_BGNAM'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = '产品名称'
        Title.Color = clInfoBk
        Width = 158
        Visible = True
      end
      item
        Color = 14283263
        Expanded = False
        FieldName = 'RJGCN'
        Title.Alignment = taCenter
        Title.Caption = '数量'
        Title.Color = clInfoBk
        Width = 37
        Visible = True
      end
      item
        Color = 14283263
        Expanded = False
        FieldName = 'RJGCS'
        Title.Alignment = taCenter
        Title.Caption = '单价'
        Title.Color = clInfoBk
        Width = 65
        Visible = True
      end
      item
        Color = 14283263
        Expanded = False
        FieldName = 'RJGCT'
        Title.Alignment = taCenter
        Title.Caption = '总价'
        Title.Color = clInfoBk
        Width = 70
        Visible = True
      end>
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 772
    Height = 233
    Align = alTop
    BevelOuter = bvLowered
    Caption = ' '
    Color = 14730690
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = '宋体'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 1
    object LBROAMT: TLabel
      Left = 507
      Top = 88
      Width = 66
      Height = 13
      Caption = '= 总计金额'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 517
      Top = 108
      Width = 52
      Height = 13
      Caption = '尚缺金额'
      Color = 10998526
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -13
      Font.Name = '宋体'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object Label3: TLabel
      Left = 507
      Top = 68
      Width = 66
      Height = 13
      Caption = '+ 产品小计'
      Color = 10998526
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -13
      Font.Name = '宋体'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object Label4: TLabel
      Left = 507
      Top = 48
      Width = 66
      Height = 13
      Caption = '+ 费用小计'
      Color = 10998526
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -13
      Font.Name = '宋体'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object LBRJAMT: TLabel
      Left = 290
      Top = 30
      Width = 52
      Height = 13
      Caption = '总计金额'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
    end
    object LBRJENO: TLabel
      Left = 5
      Top = 8
      Width = 52
      Height = 13
      Caption = '退出单号'
    end
    object LBBSENO: TLabel
      Left = 5
      Top = 28
      Width = 52
      Height = 13
      Caption = '厂商编号'
    end
    object LBRJDAT: TLabel
      Left = 165
      Top = 8
      Width = 52
      Height = 13
      Caption = '单据日期'
    end
    object LBBNENO: TLabel
      Left = 5
      Top = 48
      Width = 52
      Height = 13
      Caption = '经办人员'
    end
    object LBRJMRK: TLabel
      Left = 5
      Top = 68
      Width = 52
      Height = 13
      Caption = '备　　注'
    end
    object LBRJAM1: TLabel
      Left = 290
      Top = 8
      Width = 52
      Height = 13
      Caption = '已付金额'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
    end
    object ROAMT: TJDBEdit
      Left = 570
      Top = 85
      Width = 60
      Height = 19
      Color = 15790320
      Ctl3D = False
      DataField = 'ROAMT'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = '宋体'
      Font.Style = []
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 1
      _EditType = EDIT
      _SHOWCAL = NONE
    end
    object _RODM2: TEdit
      Left = 440
      Top = 37
      Width = 60
      Height = 19
      Anchors = [akRight, akBottom]
      Color = 15790320
      Ctl3D = False
      Enabled = False
      ParentCtl3D = False
      TabOrder = 2
    end
    object _RODM1: TEdit
      Left = 440
      Top = 17
      Width = 60
      Height = 19
      Anchors = [akRight, akBottom]
      BiDiMode = bdRightToLeftReadingOnly
      Color = 15790320
      Ctl3D = False
      Enabled = False
      ParentBiDiMode = False
      ParentCtl3D = False
      TabOrder = 3
    end
    object _ROAMD: TEdit
      Left = 440
      Top = 77
      Width = 60
      Height = 19
      Anchors = [akRight, akBottom]
      Color = 15790320
      Ctl3D = False
      Enabled = False
      ParentCtl3D = False
      TabOrder = 4
    end
    object RJAMT: TJDBEdit
      Left = 345
      Top = 27
      Width = 51
      Height = 19
      Ctl3D = False
      DataField = 'RJAMT'
      DataSource = FMRCJND.DSRCJN
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = '宋体'
      Font.Style = []
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 5
      _EditType = EDIT
      _SHOWCAL = NONE
    end
    object RJMRK: TDBMemo
      Left = 60
      Top = 65
      Width = 206
      Height = 66
      Ctl3D = False
      DataField = 'RJMRK'
      DataSource = FMRCJND.DSRCJN
      ParentCtl3D = False
      TabOrder = 6
    end
    object RJENO: TJDBEdit
      Left = 60
      Top = 5
      Width = 101
      Height = 19
      Ctl3D = False
      DataField = 'RJENO'
      DataSource = FMRCJND.DSRCJN
      ParentCtl3D = False
      TabOrder = 7
      _EditType = EDIT
      _SHOWCAL = NONE
    end
    object BSENO: JDBLOOKUPBOX
      Left = 60
      Top = 25
      Width = 216
      Height = 19
      Ctl3D = False
      DataField = 'BSENO'
      DataSource = FMRCJND.DSRCJN
      MaxLength = 20
      ParentCtl3D = False
      TabOrder = 8
      _DatabaseName = 'MAIN'
      _TableName = 'BSUP'
      _Field_IDNO = 'BSENO'
      _Field_NAME = 'BSNAM'
      _EDIT_WIDTH = 80
      _CHANGE_QUERY = True
      _INSERT_RECORD = False
      _SHOW_MESSAGE = False
    end
    object RJDAT: TJDBEdit
      Left = 220
      Top = 5
      Width = 61
      Height = 19
      Ctl3D = False
      DataField = 'RJDAT'
      DataSource = FMRCJND.DSRCJN
      ParentCtl3D = False
      TabOrder = 9
      _EditType = EDATE_EDIT
      _SHOWCAL = NONE
    end
    object BNENO: JDBLOOKUPBOX
      Left = 60
      Top = 45
      Width = 116
      Height = 19
      Ctl3D = False
      DataField = 'BNENO'
      DataSource = FMRCJND.DSRCJN
      MaxLength = 20
      ParentCtl3D = False
      TabOrder = 10
      _DatabaseName = 'MAIN'
      _TableName = 'BMAN'
      _Field_IDNO = 'BNENO'
      _Field_NAME = 'BNNAM'
      _EDIT_WIDTH = 80
      _CHANGE_QUERY = True
      _INSERT_RECORD = False
      _SHOW_MESSAGE = False
    end
    object RJAM1: TJDBEdit
      Left = 346
      Top = 5
      Width = 50
      Height = 19
      Ctl3D = False
      DataField = 'RJAM1'
      DataSource = FMRCJND.DSRCJN
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = '宋体'
      Font.Style = []
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 11
      _EditType = EDIT
      _SHOWCAL = NONE
    end
    object DBGrid1: TDBGrid
      Left = 400
      Top = 0
      Width = 371
      Height = 231
      Ctl3D = False
      DataSource = FMRCJND.DSRCJN
      ParentCtl3D = False
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -13
      TitleFont.Name = '宋体'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'RJENO'
          Title.Alignment = taCenter
          Title.Caption = '退出单号'
          Title.Color = clInfoBk
          Width = 88
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'RJDAT'
          Title.Alignment = taCenter
          Title.Caption = '单据日期'
          Title.Color = clInfoBk
          Width = 69
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'BSENO'
          Title.Alignment = taCenter
          Title.Caption = '客户名称'
          Title.Color = clInfoBk
          Width = 154
          Visible = True
        end>
    end
    object GroupBox1: TGroupBox
      Left = 5
      Top = 135
      Width = 391
      Height = 96
      Caption = '快速查询'
      Ctl3D = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = '宋体'
      Font.Style = []
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 12
      object LB1: TLabel
        Left = 7
        Top = 18
        Width = 52
        Height = 13
        Caption = '退出单号'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
      end
      object LB3: TLabel
        Left = 7
        Top = 38
        Width = 52
        Height = 13
        Caption = '单据日期'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
      end
      object Label7: TLabel
        Left = 133
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
      object Label6: TLabel
        Left = 7
        Top = 58
        Width = 52
        Height = 13
        Caption = '厂商编号'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
      end
      object Label11: TLabel
        Left = 133
        Top = 39
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
      object Label12: TLabel
        Left = 7
        Top = 78
        Width = 52
        Height = 13
        Caption = '经办人员'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
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
      object LB51: TJEdit
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
        TabOrder = 2
        Digits = 1
        Max = 999999999
        _EditType = EDIT
        _SHOWCAL = NONE
        _BADINPUT = True
        _LONGTIME = False
      end
      object LB41: TJEdit
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
        TabOrder = 3
        Digits = 1
        Max = 999999999
        _EditType = EDIT
        _SHOWCAL = NONE
        _BADINPUT = True
        _LONGTIME = False
      end
      object LB42: TJEdit
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
        TabOrder = 4
        Digits = 1
        Max = 999999999
        _EditType = EDIT
        _SHOWCAL = NONE
        _BADINPUT = True
        _LONGTIME = False
      end
      object LB61: TJEdit
        Left = 65
        Top = 75
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
      object BTNSER: TBitBtn
        Left = 220
        Top = 11
        Width = 80
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
        Left = 220
        Top = 41
        Width = 81
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
  end
  object Panel5: TPanel
    Left = 571
    Top = 233
    Width = 201
    Height = 202
    Align = alRight
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Caption = ' '
    Color = clNavy
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 0
    object BTNSET: TBitBtn
      Left = 100
      Top = 160
      Width = 100
      Height = 40
      Caption = '&S 设定'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      Visible = False
    end
    object BTNINS: TBitBtn
      Left = 0
      Top = 0
      Width = 100
      Height = 40
      Caption = 'F1 新增'
      TabOrder = 0
      OnClick = BTNINSClick
    end
    object BTNYES: TBitBtn
      Left = 0
      Top = 80
      Width = 100
      Height = 40
      Caption = 'F3 存盘'
      TabOrder = 1
      OnClick = BTNYESClick
    end
    object BTNCAL: TBitBtn
      Left = 0
      Top = 120
      Width = 100
      Height = 40
      Caption = 'F4 取消'
      TabOrder = 2
      OnClick = BTNCALClick
    end
    object BTNQUT: TBitBtn
      Left = 0
      Top = 160
      Width = 100
      Height = 40
      Caption = 'Ctrl+Q 结束'
      TabOrder = 4
      OnClick = BTNQUTClick
    end
    object BTNDEL: TBitBtn
      Left = 0
      Top = 40
      Width = 100
      Height = 40
      Caption = 'F2 删除'
      TabOrder = 5
      OnClick = BTNDELClick
    end
    object BTNPRE: TBitBtn
      Left = 100
      Top = 80
      Width = 100
      Height = 40
      Cursor = crHandPoint
      Caption = 'F7 预览明细'
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
    object BTNPRN: TBitBtn
      Left = 100
      Top = 120
      Width = 100
      Height = 40
      Cursor = crHandPoint
      Caption = 'F8 打印明细'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      OnClick = BTNPRNClick
      Spacing = 1
    end
  end
  object BGENO: JLOOKUPBOX
    Left = 95
    Top = 305
    Width = 361
    Height = 21
    Ctl3D = False
    MaxLength = 20
    ParentCtl3D = False
    TabOrder = 3
    Visible = False
    _DatabaseName = 'MAIN'
    _TableName = 'BGDS'
    _Field_IDNO = 'BGENO'
    _Field_NAME = 'BGNAM'
    _EDIT_WIDTH = 120
    _CHANGE_QUERY = True
    _INSERT_RECORD = False
    _SHOW_MESSAGE = False
  end
  object PopupMenuDBGRID: TPopupMenu
    Left = 365
    Top = 60
    object N1: TMenuItem
      Caption = '删除'
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = '取消'
      OnClick = N2Click
    end
  end
  object MainMenu: TMainMenu
    Left = 581
    Top = 6
    object MenuItem1: TMenuItem
      Caption = '新增'
      ShortCut = 112
      Visible = False
      OnClick = BTNINSClick
    end
    object MenuItem2: TMenuItem
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
