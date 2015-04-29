object FMRDEL: TFMRDEL
  Left = 143
  Top = 94
  AutoScroll = False
  Caption = '报废资料文件'
  ClientHeight = 473
  ClientWidth = 772
  Color = 15648684
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = '新宋体'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = True
  Position = poScreenCenter
  Visible = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object Panel1: TPanel
    Left = 102
    Top = 1
    Width = 669
    Height = 95
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Caption = ' '
    Color = 10998526
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = '新宋体'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 1
    object LBRDENO: TLabel
      Left = 5
      Top = 4
      Width = 60
      Height = 15
      Caption = '报废单号'
    end
    object LBBGENO: TLabel
      Left = 5
      Top = 26
      Width = 60
      Height = 15
      Caption = '产品编号'
    end
    object LBRDCNT: TLabel
      Left = 365
      Top = 26
      Width = 30
      Height = 15
      Caption = '数量'
    end
    object LBRBPST: TLabel
      Left = 230
      Top = 4
      Width = 60
      Height = 15
      Caption = '库存位置'
    end
    object LBRDREA: TLabel
      Left = 5
      Top = 48
      Width = 60
      Height = 15
      Caption = '报废原因'
    end
    object LBRDDAT: TLabel
      Left = 230
      Top = 48
      Width = 60
      Height = 15
      Caption = '报废日期'
    end
    object LBRDTME: TLabel
      Left = 365
      Top = 48
      Width = 30
      Height = 15
      Caption = '时间'
    end
    object LBBNENO: TLabel
      Left = 5
      Top = 70
      Width = 60
      Height = 15
      Caption = '申请人员'
    end
    object LBRDMRK: TLabel
      Left = 230
      Top = 70
      Width = 60
      Height = 15
      Caption = '报废备注'
    end
    object LBRGOUT: TLabel
      Left = 470
      Top = 70
      Width = 60
      Height = 15
      Caption = '是否保存'
    end
    object RDREA: JDBLOOKUPBOX
      Left = 69
      Top = 45
      Width = 154
      Height = 21
      DataField = 'RDREA'
      DataSource = FMRDELD.DSRDEL
      MaxLength = 20
      TabOrder = 2
      _DatabaseName = 'MAIN'
      _TableName = 'SYSLST'
      _Field_IDNO = 'LSTID2'
      _Field_NAME = 'LSTNAM'
      _Field_KEY1 = 'LSTID1'
      _Field_KEY2 = 'RDELRDREA'
      _EDIT_WIDTH = 30
      _CHANGE_QUERY = True
      _INSERT_RECORD = True
      _INSERT_SYSLST = 'RDELRDREA'
      _SHOW_MESSAGE = True
    end
    object RBPST: JDBLOOKUPBOX
      Left = 309
      Top = 1
      Width = 150
      Height = 21
      DataField = 'RBPST'
      DataSource = FMRDELD.DSRDEL
      MaxLength = 20
      TabOrder = 0
      _DatabaseName = 'MAIN'
      _TableName = 'SYSLST'
      _Field_IDNO = 'LSTID2'
      _Field_NAME = 'LSTNAM'
      _Field_KEY1 = 'LSTID1'
      _Field_KEY2 = 'RBRNRBPST'
      _EDIT_WIDTH = 30
      _CHANGE_QUERY = True
      _INSERT_RECORD = True
      _INSERT_SYSLST = 'RBRNRBPST'
      _SHOW_MESSAGE = True
    end
    object BNENO: JDBLOOKUPBOX
      Left = 69
      Top = 67
      Width = 154
      Height = 21
      DataField = 'BNENO'
      DataSource = FMRDELD.DSRDEL
      MaxLength = 20
      TabOrder = 3
      _DatabaseName = 'MAIN'
      _TableName = 'BMAN'
      _Field_IDNO = 'BNENO'
      _Field_NAME = 'BNNAM'
      _EDIT_WIDTH = 60
      _CHANGE_QUERY = True
      _INSERT_RECORD = False
      _SHOW_MESSAGE = False
    end
    object BGENO: JDBLOOKUPBOX
      Left = 69
      Top = 23
      Width = 290
      Height = 21
      DataField = 'BGENO'
      DataSource = FMRDELD.DSRDEL
      MaxLength = 20
      TabOrder = 1
      _DatabaseName = 'MAIN'
      _TableName = 'BGDS'
      _Field_IDNO = 'BGENO'
      _Field_NAME = 'BGNAM'
      _EDIT_WIDTH = 100
      _CHANGE_QUERY = True
      _INSERT_RECORD = False
      _SHOW_MESSAGE = False
    end
    object RDENO: TJDBEdit
      Left = 69
      Top = 1
      Width = 121
      Height = 21
      DataField = 'RDENO'
      DataSource = FMRDELD.DSRDEL
      TabOrder = 4
      _EditType = EDIT
    end
    object RDCNT: TJDBEdit
      Left = 399
      Top = 23
      Width = 60
      Height = 21
      DataField = 'RDCNT'
      DataSource = FMRDELD.DSRDEL
      TabOrder = 5
      _EditType = EDIT
    end
    object RDDAT: TJDBEdit
      Left = 295
      Top = 45
      Width = 64
      Height = 21
      DataField = 'RDDAT'
      DataSource = FMRDELD.DSRDEL
      TabOrder = 6
      _EditType = CDATE_EDIT
    end
    object RDTME: TJDBEdit
      Left = 399
      Top = 45
      Width = 60
      Height = 21
      DataField = 'RDTME'
      DataSource = FMRDELD.DSRDEL
      TabOrder = 7
      _EditType = TIME_EDIT
    end
    object RDMRK: TJDBEdit
      Left = 295
      Top = 67
      Width = 165
      Height = 21
      DataField = 'RDMRK'
      DataSource = FMRDELD.DSRDEL
      TabOrder = 8
      _EditType = EDIT
    end
    object RDOUT: TDBCheckBox
      Left = 535
      Top = 69
      Width = 21
      Height = 17
      Caption = ' '
      DataField = 'RDOUT'
      DataSource = FMRDELD.DSRDEL
      TabOrder = 9
      ValueChecked = 'True'
      ValueUnchecked = 'False'
    end
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 454
    Width = 772
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
  object AREA_TOOL: TPanel
    Left = 0
    Top = 0
    Width = 100
    Height = 454
    Align = alLeft
    Caption = ' '
    Color = clNavy
    TabOrder = 2
    object BTNQUT: TBitBtn
      Left = 0
      Top = 410
      Width = 100
      Height = 40
      Caption = '&Q 结束'
      TabOrder = 0
      OnClick = BTNQUTClick
    end
    object BTNINS: TBitBtn
      Left = 0
      Top = 0
      Width = 100
      Height = 40
      Caption = '&A 新增'
      TabOrder = 1
      OnClick = BTNINSClick
    end
    object BTNUPD: TBitBtn
      Left = 0
      Top = 40
      Width = 100
      Height = 40
      Caption = '&U 修改'
      TabOrder = 2
      OnClick = BTNUPDClick
    end
    object BTNDEL: TBitBtn
      Left = 0
      Top = 80
      Width = 100
      Height = 40
      Caption = '&D 删除'
      TabOrder = 3
      OnClick = BTNDELClick
    end
    object BTNYES: TBitBtn
      Left = 0
      Top = 120
      Width = 100
      Height = 40
      Caption = '&Y 确定'
      TabOrder = 4
      OnClick = BTNYESClick
    end
    object BTNCAL: TBitBtn
      Left = 0
      Top = 160
      Width = 100
      Height = 40
      Caption = '&C 取消'
      TabOrder = 5
      OnClick = BTNCALClick
    end
    object BTNSER: TBitBtn
      Left = 0
      Top = 330
      Width = 100
      Height = 40
      Caption = '&F 查询'
      TabOrder = 6
      OnClick = BTNSERClick
    end
    object BTNPRN: TBitBtn
      Left = 0
      Top = 370
      Width = 100
      Height = 40
      Caption = '&P 打印'
      TabOrder = 7
      OnClick = BTNPRNClick
    end
    object BitBtn1: TBitBtn
      Left = 0
      Top = 290
      Width = 100
      Height = 40
      Caption = '&O 本笔保存'
      TabOrder = 8
      OnClick = BitBtn1Click
    end
  end
  object DBGrid1: TDBGrid
    Left = 102
    Top = 95
    Width = 669
    Height = 356
    DataSource = FMRDELD.DSRDEL
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -15
    TitleFont.Name = '新宋体'
    TitleFont.Style = []
    OnDrawColumnCell = DBGrid1DrawColumnCell
    Columns = <
      item
        Expanded = False
        FieldName = 'RDENO'
        Title.Alignment = taCenter
        Title.Caption = '报废单号'
        Title.Color = clInfoBk
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BGENO'
        Title.Alignment = taCenter
        Title.Caption = '产品编号'
        Title.Color = clInfoBk
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'RDCNT'
        Title.Alignment = taCenter
        Title.Caption = '数量'
        Title.Color = clInfoBk
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'RBPST'
        Title.Alignment = taCenter
        Title.Caption = '库存位置'
        Title.Color = clInfoBk
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'RDREA'
        Title.Alignment = taCenter
        Title.Caption = '报废原因'
        Title.Color = clInfoBk
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'RDDAT'
        Title.Alignment = taCenter
        Title.Caption = '报废日期'
        Title.Color = clInfoBk
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'RDTME'
        Title.Alignment = taCenter
        Title.Caption = '报废时间'
        Title.Color = clInfoBk
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BNENO'
        Title.Alignment = taCenter
        Title.Caption = '申请人员'
        Title.Color = clInfoBk
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'RDMRK'
        Title.Alignment = taCenter
        Title.Caption = '报废备注'
        Title.Color = clInfoBk
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'RDOUT'
        Title.Alignment = taCenter
        Title.Caption = '是否保存'
        Title.Color = clInfoBk
        Visible = True
      end>
  end
end 
