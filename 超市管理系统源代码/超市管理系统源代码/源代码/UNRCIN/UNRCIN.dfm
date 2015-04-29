object FMRCIN: TFMRCIN
  Left = 117
  Top = 128
  AutoScroll = False
  Caption = '进货作业'
  ClientHeight = 427
  ClientWidth = 779
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
    Top = 0
    Width = 404
    Height = 217
    Ctl3D = False
    DataSource = FMRCIND.DSRCINB
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = '宋体'
    Font.Style = []
    ImeName = '中文 (简体) - 拼音加加'
    ParentCtl3D = False
    ParentFont = False
    PopupMenu = PopupMenuDBGRID
    TabOrder = 0
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
        FieldName = 'RIITM'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = '项次'
        Title.Color = clInfoBk
        Width = 56
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
        Width = 88
        Visible = True
      end
      item
        Expanded = False
        FieldName = '_BGNAM'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = '产品名称'
        Title.Color = clInfoBk
        Width = 69
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'RIUNP'
        Title.Alignment = taCenter
        Title.Caption = '计量单位'
        Title.Color = clInfoBk
        Visible = False
      end
      item
        Color = 14283263
        Expanded = False
        FieldName = 'RIGCV'
        Title.Alignment = taCenter
        Title.Caption = '发票数量'
        Title.Color = clInfoBk
        Visible = False
      end
      item
        Color = 14283263
        Expanded = False
        FieldName = 'RIGCN'
        Title.Alignment = taCenter
        Title.Caption = '数量'
        Title.Color = clInfoBk
        Width = 37
        Visible = True
      end
      item
        Color = 14283263
        Expanded = False
        FieldName = 'RIGCS'
        Title.Alignment = taCenter
        Title.Caption = '单价'
        Title.Color = clInfoBk
        Width = 65
        Visible = True
      end
      item
        Color = 14283263
        Expanded = False
        FieldName = 'RIGCT'
        Title.Alignment = taCenter
        Title.Caption = '总价'
        Title.Color = clInfoBk
        Width = 70
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'RBPST'
        Title.Alignment = taCenter
        Title.Caption = '库存位置'
        Title.Color = clInfoBk
        Visible = False
      end>
  end
  object BGENO: JLOOKUPBOX
    Left = 15
    Top = 193
    Width = 361
    Height = 21
    Ctl3D = False
    ImeName = '中文 (简体) - 拼音加加'
    MaxLength = 20
    ParentCtl3D = False
    TabOrder = 1
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
  object Panel2: TPanel
    Left = 0
    Top = 216
    Width = 777
    Height = 209
    BevelOuter = bvLowered
    Caption = ' '
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = '宋体'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 2
    object LBROAMT: TLabel
      Left = 403
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
      Left = 405
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
    object Label2: TLabel
      Left = 283
      Top = 2
      Width = 11
      Height = 183
      AutoSize = False
      Caption = '┌│││││││││├┤││││└'
      Transparent = True
      WordWrap = True
    end
    object Label3: TLabel
      Left = 403
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
      Left = 403
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
    object LBRIAMT: TLabel
      Left = 290
      Top = 155
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
    object LBRIENO: TLabel
      Left = 5
      Top = 8
      Width = 52
      Height = 13
      Caption = '进货单号'
    end
    object LBRITYP: TLabel
      Left = 165
      Top = 8
      Width = 52
      Height = 13
      Caption = '单据型号'
    end
    object LBBSENO: TLabel
      Left = 5
      Top = 48
      Width = 52
      Height = 13
      Caption = '厂商编号'
    end
    object LBRIIID: TLabel
      Left = 5
      Top = 28
      Width = 52
      Height = 13
      Caption = '采购单号'
    end
    object LBRIIAD: TLabel
      Left = 5
      Top = 68
      Width = 52
      Height = 13
      Caption = '发票地址'
    end
    object LBRIINO: TLabel
      Left = 5
      Top = 88
      Width = 52
      Height = 13
      Caption = '发票编号'
    end
    object LBRIDAT: TLabel
      Left = 165
      Top = 28
      Width = 52
      Height = 13
      Caption = '单据日期'
    end
    object LBBNENO: TLabel
      Left = 5
      Top = 148
      Width = 52
      Height = 13
      Caption = '经办人员'
    end
    object LBRIPAY: TLabel
      Left = 5
      Top = 108
      Width = 52
      Height = 13
      Caption = '付款方式'
    end
    object LBRIMRK: TLabel
      Left = 5
      Top = 168
      Width = 52
      Height = 13
      Caption = '备　　注'
    end
    object LBRIEXG: TLabel
      Left = 5
      Top = 128
      Width = 52
      Height = 13
      Caption = '币　　种'
    end
    object LBRIEXR: TLabel
      Left = 180
      Top = 128
      Width = 26
      Height = 13
      Caption = '汇率'
    end
    object LBRISA1: TLabel
      Left = 292
      Top = 8
      Width = 61
      Height = 13
      Caption = '费  用  1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clPurple
      Font.Height = -13
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
    end
    object LBRISA2: TLabel
      Left = 292
      Top = 28
      Width = 61
      Height = 13
      Caption = '费  用  2'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clPurple
      Font.Height = -13
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
    end
    object LBRISA3: TLabel
      Left = 292
      Top = 48
      Width = 61
      Height = 13
      Caption = '费  用  3'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clPurple
      Font.Height = -13
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
    end
    object LBRISA4: TLabel
      Left = 292
      Top = 68
      Width = 61
      Height = 13
      Caption = '费  用  4'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clPurple
      Font.Height = -13
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
    end
    object LBRISA5: TLabel
      Left = 292
      Top = 88
      Width = 61
      Height = 13
      Caption = '费  用  5'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clPurple
      Font.Height = -13
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
    end
    object LBRIAM1: TLabel
      Left = 292
      Top = 113
      Width = 52
      Height = 13
      Caption = '折让金额'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
    end
    object LBRIAM2: TLabel
      Left = 292
      Top = 133
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
    object LBRISNO: TLabel
      Left = 145
      Top = 88
      Width = 52
      Height = 13
      Caption = '厂商单号'
    end
    object ROAMT: TJDBEdit
      Left = 474
      Top = 86
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
      ImeName = '中文 (简体) - 拼音加加'
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 0
      _EditType = EDIT
      _SHOWCAL = NONE
    end
    object _RODM2: TEdit
      Left = 474
      Top = 42
      Width = 60
      Height = 19
      Anchors = [akRight, akBottom]
      Color = 15790320
      Ctl3D = False
      Enabled = False
      ImeName = '中文 (简体) - 拼音加加'
      ParentCtl3D = False
      TabOrder = 1
    end
    object _RODM1: TEdit
      Left = 474
      Top = 21
      Width = 60
      Height = 19
      Anchors = [akRight, akBottom]
      BiDiMode = bdRightToLeftReadingOnly
      Color = 15790320
      Ctl3D = False
      Enabled = False
      ImeName = '中文 (简体) - 拼音加加'
      ParentBiDiMode = False
      ParentCtl3D = False
      TabOrder = 2
    end
    object _ROAMD: TEdit
      Left = 474
      Top = 63
      Width = 60
      Height = 19
      Anchors = [akRight, akBottom]
      Color = 15790320
      Ctl3D = False
      Enabled = False
      ImeName = '中文 (简体) - 拼音加加'
      ParentCtl3D = False
      TabOrder = 3
    end
    object RIAMT: TJDBEdit
      Left = 345
      Top = 152
      Width = 51
      Height = 19
      Ctl3D = False
      DataField = 'RIAMT'
      DataSource = FMRCIND.DSRCIN
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = '宋体'
      Font.Style = []
      ImeName = '中文 (简体) - 拼音加加'
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 4
      _EditType = EDIT
      _SHOWCAL = NONE
    end
    object RIMRK: TDBMemo
      Left = 60
      Top = 165
      Width = 223
      Height = 42
      Ctl3D = False
      DataField = 'RIMRK'
      DataSource = FMRCIND.DSRCIN
      ImeName = '中文 (简体) - 拼音加加'
      ParentCtl3D = False
      TabOrder = 5
    end
    object RIENO: TJDBEdit
      Left = 60
      Top = 5
      Width = 101
      Height = 19
      Ctl3D = False
      DataField = 'RIENO'
      DataSource = FMRCIND.DSRCIN
      ImeName = '中文 (简体) - 拼音加加'
      ParentCtl3D = False
      TabOrder = 6
      _EditType = EDIT
      _SHOWCAL = NONE
    end
    object RITYP: TJDBEdit
      Left = 220
      Top = 5
      Width = 26
      Height = 19
      Ctl3D = False
      DataField = 'RITYP'
      DataSource = FMRCIND.DSRCIN
      ImeName = '中文 (简体) - 拼音加加'
      ParentCtl3D = False
      TabOrder = 7
      _EditType = EDIT
      _SHOWCAL = NONE
    end
    object RIIID: TJDBEdit
      Left = 60
      Top = 25
      Width = 101
      Height = 19
      Ctl3D = False
      DataField = 'RIIID'
      DataSource = FMRCIND.DSRCIN
      ImeName = '中文 (简体) - 拼音加加'
      ParentCtl3D = False
      TabOrder = 8
      _EditType = EDIT
      _SHOWCAL = NONE
    end
    object BSENO: JDBLOOKUPBOX
      Left = 60
      Top = 45
      Width = 218
      Height = 19
      Ctl3D = False
      DataField = 'BSENO'
      DataSource = FMRCIND.DSRCIN
      ImeName = '中文 (简体) - 拼音加加'
      MaxLength = 20
      ParentCtl3D = False
      TabOrder = 9
      _DatabaseName = 'MAIN'
      _TableName = 'BSUP'
      _Field_IDNO = 'BSENO'
      _Field_NAME = 'BSNAM'
      _EDIT_WIDTH = 80
      _CHANGE_QUERY = True
      _INSERT_RECORD = False
      _SHOW_MESSAGE = False
    end
    object RIIAD: TJDBEdit
      Left = 60
      Top = 65
      Width = 218
      Height = 19
      Ctl3D = False
      DataField = 'RIIAD'
      DataSource = FMRCIND.DSRCIN
      ImeName = '中文 (简体) - 拼音加加'
      ParentCtl3D = False
      TabOrder = 10
      _EditType = EDIT
      _SHOWCAL = NONE
    end
    object RIINO: TJDBEdit
      Left = 60
      Top = 85
      Width = 75
      Height = 19
      Ctl3D = False
      DataField = 'RIINO'
      DataSource = FMRCIND.DSRCIN
      ImeName = '中文 (简体) - 拼音加加'
      ParentCtl3D = False
      TabOrder = 11
      _EditType = EDIT
      _SHOWCAL = NONE
    end
    object RIDAT: TJDBEdit
      Left = 220
      Top = 25
      Width = 61
      Height = 19
      Ctl3D = False
      DataField = 'RIDAT'
      DataSource = FMRCIND.DSRCIN
      ImeName = '中文 (简体) - 拼音加加'
      ParentCtl3D = False
      TabOrder = 12
      _EditType = EDATE_EDIT
      _SHOWCAL = NONE
    end
    object RIEXR: TDBEdit
      Left = 210
      Top = 125
      Width = 62
      Height = 19
      Ctl3D = False
      DataField = 'RIEXR'
      DataSource = FMRCIND.DSRCIN
      ImeName = '中文 (简体) - 拼音加加'
      ParentCtl3D = False
      TabOrder = 13
    end
    object BNENO: JDBLOOKUPBOX
      Left = 60
      Top = 145
      Width = 116
      Height = 19
      Ctl3D = False
      DataField = 'BNENO'
      DataSource = FMRCIND.DSRCIN
      ImeName = '中文 (简体) - 拼音加加'
      MaxLength = 20
      ParentCtl3D = False
      TabOrder = 14
      _DatabaseName = 'MAIN'
      _TableName = 'BMAN'
      _Field_IDNO = 'BNENO'
      _Field_NAME = 'BNNAM'
      _EDIT_WIDTH = 80
      _CHANGE_QUERY = True
      _INSERT_RECORD = False
      _SHOW_MESSAGE = False
    end
    object RISA1: TJDBEdit
      Left = 346
      Top = 5
      Width = 50
      Height = 19
      Ctl3D = False
      DataField = 'RISA1'
      DataSource = FMRCIND.DSRCIN
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clPurple
      Font.Height = -13
      Font.Name = '宋体'
      Font.Style = []
      ImeName = '中文 (简体) - 拼音加加'
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 15
      _EditType = EDIT
      _SHOWCAL = NONE
    end
    object RISA2: TJDBEdit
      Left = 346
      Top = 25
      Width = 50
      Height = 19
      Ctl3D = False
      DataField = 'RISA2'
      DataSource = FMRCIND.DSRCIN
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clPurple
      Font.Height = -13
      Font.Name = '宋体'
      Font.Style = []
      ImeName = '中文 (简体) - 拼音加加'
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 16
      _EditType = EDIT
      _SHOWCAL = NONE
    end
    object RISA3: TJDBEdit
      Left = 346
      Top = 45
      Width = 50
      Height = 19
      Ctl3D = False
      DataField = 'RISA3'
      DataSource = FMRCIND.DSRCIN
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clPurple
      Font.Height = -13
      Font.Name = '宋体'
      Font.Style = []
      ImeName = '中文 (简体) - 拼音加加'
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 17
      _EditType = EDIT
      _SHOWCAL = NONE
    end
    object RISA4: TJDBEdit
      Left = 346
      Top = 65
      Width = 50
      Height = 19
      Ctl3D = False
      DataField = 'RISA4'
      DataSource = FMRCIND.DSRCIN
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clPurple
      Font.Height = -13
      Font.Name = '宋体'
      Font.Style = []
      ImeName = '中文 (简体) - 拼音加加'
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 18
      _EditType = EDIT
      _SHOWCAL = NONE
    end
    object RISA5: TJDBEdit
      Left = 346
      Top = 85
      Width = 50
      Height = 19
      Ctl3D = False
      DataField = 'RISA5'
      DataSource = FMRCIND.DSRCIN
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clPurple
      Font.Height = -13
      Font.Name = '宋体'
      Font.Style = []
      ImeName = '中文 (简体) - 拼音加加'
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 19
      _EditType = EDIT
      _SHOWCAL = NONE
    end
    object RIAM1: TJDBEdit
      Left = 346
      Top = 110
      Width = 50
      Height = 19
      Ctl3D = False
      DataField = 'RIAM1'
      DataSource = FMRCIND.DSRCIN
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = '宋体'
      Font.Style = []
      ImeName = '中文 (简体) - 拼音加加'
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 20
      _EditType = EDIT
      _SHOWCAL = NONE
    end
    object RIAM2: TJDBEdit
      Left = 346
      Top = 130
      Width = 50
      Height = 19
      Ctl3D = False
      DataField = 'RIAM2'
      DataSource = FMRCIND.DSRCIN
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = '宋体'
      Font.Style = []
      ImeName = '中文 (简体) - 拼音加加'
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 21
      _EditType = EDIT
      _SHOWCAL = NONE
    end
    object RISNO: TJDBEdit
      Left = 200
      Top = 85
      Width = 77
      Height = 19
      Ctl3D = False
      DataField = 'RISNO'
      DataSource = FMRCIND.DSRCIN
      ImeName = '中文 (简体) - 拼音加加'
      ParentCtl3D = False
      TabOrder = 22
      _EditType = EDIT
      _SHOWCAL = NONE
    end
    object RIPAY: SEDBLOOKUPBOX
      Left = 60
      Top = 105
      Width = 100
      Height = 19
      DataField = 'RIPAY'
      DataSource = FMRCIND.DSRCIN
      ImeName = '中文 (简体) - 拼音加加'
      MaxLength = 20
      TabOrder = 23
      _EditType = SEVARCHAR
      _DatabaseName = 'MAIN'
      _TableName = 'SYSLST'
      _Field_IDNO = 'RCINRIPAY'
      _EDIT_WIDTH = 50
      _CHANGE_QUERY = True
      _INSERT_RECORD = True
      _SHOW_MESSAGE = True
    end
    object RIEXG: SEDBLOOKUPBOX
      Left = 60
      Top = 125
      Width = 100
      Height = 19
      DataField = 'RIEXG'
      DataSource = FMRCIND.DSRCIN
      ImeName = '中文 (简体) - 拼音加加'
      MaxLength = 20
      TabOrder = 24
      _EditType = SEVARCHAR
      _DatabaseName = 'MAIN'
      _TableName = 'SYSLST'
      _Field_IDNO = 'RCINRIEXG'
      _EDIT_WIDTH = 50
      _CHANGE_QUERY = True
      _INSERT_RECORD = True
      _SHOW_MESSAGE = True
    end
    object Panel5: TPanel
      Left = 547
      Top = 0
      Width = 225
      Height = 201
      BevelOuter = bvNone
      BorderStyle = bsSingle
      Caption = ' '
      Color = clInactiveBorder
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 25
      object BTNSET: TBitBtn
        Left = 128
        Top = 81
        Width = 90
        Height = 30
        Caption = '&S 设置'
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -14
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        Visible = False
      end
      object BitBtn3: TBitBtn
        Left = 7
        Top = 160
        Width = 90
        Height = 30
        Caption = '&L 采购单带入'
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -14
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        Visible = False
      end
      object BTNINS: TBitBtn
        Left = 8
        Top = 7
        Width = 90
        Height = 30
        Caption = 'F1 新增'
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -14
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = BTNINSClick
      end
      object BTNYES: TBitBtn
        Left = 8
        Top = 84
        Width = 90
        Height = 30
        Caption = 'F3 存盘'
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -14
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnClick = BTNYESClick
      end
      object BTNCAL: TBitBtn
        Left = 8
        Top = 122
        Width = 90
        Height = 30
        Caption = 'F4 取消'
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -14
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnClick = BTNCALClick
      end
      object BTNQUT: TBitBtn
        Left = 128
        Top = 119
        Width = 90
        Height = 30
        Caption = 'Ctrl+Q 结束'
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -14
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        OnClick = BTNQUTClick
      end
      object BTNDEL: TBitBtn
        Left = 7
        Top = 45
        Width = 90
        Height = 30
        Caption = 'F2 删除'
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -14
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        OnClick = BTNDELClick
      end
      object BTNPRE: TBitBtn
        Left = 128
        Top = 6
        Width = 90
        Height = 30
        Cursor = crHandPoint
        Caption = 'F7 预览明细'
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -14
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
        OnClick = BTNPRNClick
        Spacing = 1
      end
      object BTNPRN: TBitBtn
        Left = 128
        Top = 44
        Width = 90
        Height = 30
        Cursor = crHandPoint
        Caption = 'F8 打印明细'
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -14
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
        TabOrder = 8
        OnClick = BTNPRNClick
        Spacing = 1
      end
    end
  end
  object GroupBox1: TGroupBox
    Left = 407
    Top = 0
    Width = 371
    Height = 96
    Caption = '快速查询'
    Color = clInfoBk
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = '宋体'
    Font.Style = []
    ParentColor = False
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 3
    object LB1: TLabel
      Left = 7
      Top = 18
      Width = 52
      Height = 13
      Caption = '进货单号'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
    end
    object LB2: TLabel
      Left = 7
      Top = 38
      Width = 52
      Height = 13
      Caption = '采购单号'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
    end
    object LB3: TLabel
      Left = 7
      Top = 78
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
    object Label9: TLabel
      Left = 133
      Top = 59
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
    object Label6: TLabel
      Left = 217
      Top = 18
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
    object Label10: TLabel
      Left = 7
      Top = 58
      Width = 52
      Height = 13
      Caption = '厂商单号'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
    end
    object Label11: TLabel
      Left = 133
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
    object Label12: TLabel
      Left = 217
      Top = 38
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
      ImeName = '中文 (简体) - 拼音加加'
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
      ImeName = '中文 (简体) - 拼音加加'
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
      ImeName = '中文 (简体) - 拼音加加'
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
      ImeName = '中文 (简体) - 拼音加加'
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
      ImeName = '中文 (简体) - 拼音加加'
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
      ImeName = '中文 (简体) - 拼音加加'
      ParentFont = False
      TabOrder = 3
      Digits = 1
      Max = 999999999
      _EditType = EDIT
      _SHOWCAL = NONE
      _BADINPUT = True
      _LONGTIME = False
    end
    object LB51: TJEdit
      Left = 275
      Top = 15
      Width = 65
      Height = 19
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = '宋体'
      Font.Style = []
      ImeName = '中文 (简体) - 拼音加加'
      ParentFont = False
      TabOrder = 6
      Digits = 1
      Max = 999999999
      _EditType = EDIT
      _SHOWCAL = NONE
      _BADINPUT = True
      _LONGTIME = False
    end
    object LB41: TJEdit
      Left = 65
      Top = 75
      Width = 65
      Height = 19
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = '宋体'
      Font.Style = []
      ImeName = '中文 (简体) - 拼音加加'
      ParentFont = False
      TabOrder = 7
      Digits = 1
      Max = 999999999
      _EditType = EDIT
      _SHOWCAL = NONE
      _BADINPUT = True
      _LONGTIME = False
    end
    object LB42: TJEdit
      Left = 150
      Top = 75
      Width = 65
      Height = 19
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = '宋体'
      Font.Style = []
      ImeName = '中文 (简体) - 拼音加加'
      ParentFont = False
      TabOrder = 8
      Digits = 1
      Max = 999999999
      _EditType = EDIT
      _SHOWCAL = NONE
      _BADINPUT = True
      _LONGTIME = False
    end
    object LB61: TJEdit
      Left = 275
      Top = 35
      Width = 65
      Height = 19
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = '宋体'
      Font.Style = []
      ImeName = '中文 (简体) - 拼音加加'
      ParentFont = False
      TabOrder = 9
      Digits = 1
      Max = 999999999
      _EditType = EDIT
      _SHOWCAL = NONE
      _BADINPUT = True
      _LONGTIME = False
    end
    object BTNSER: TBitBtn
      Left = 220
      Top = 63
      Width = 66
      Height = 30
      Cursor = crHandPoint
      Caption = 'F5 查询'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
      TabOrder = 10
      OnClick = BTNSERClick
      Spacing = 1
    end
    object BTNCLR: TBitBtn
      Left = 299
      Top = 63
      Width = 62
      Height = 30
      Cursor = crHandPoint
      Caption = '清除'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
      TabOrder = 11
      OnClick = BTNCLRClick
      Spacing = 1
    end
  end
  object DBGrid1: TDBGrid
    Left = 408
    Top = 98
    Width = 369
    Height = 116
    Ctl3D = False
    DataSource = FMRCIND.DSRCIN
    ImeName = '中文 (简体) - 拼音加加'
    ParentCtl3D = False
    TabOrder = 4
    TitleFont.Charset = GB2312_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -15
    TitleFont.Name = '宋体'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'RIENO'
        Title.Alignment = taCenter
        Title.Caption = '进货单号'
        Title.Color = clInfoBk
        Width = 88
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'RIDAT'
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
  object PopupMenuDBGRID: TPopupMenu
    Left = 439
    Top = 352
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
    Left = 349
    Top = 70
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
