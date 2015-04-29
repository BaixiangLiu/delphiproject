object FMRGET: TFMRGET
  Left = 126
  Top = 89
  AutoScroll = False
  Caption = '领用资料文件'
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
    object LBRGENO: TLabel
      Left = 5
      Top = 4
      Width = 60
      Height = 15
      Caption = '领用单号'
    end
    object LBBGENO: TLabel
      Left = 5
      Top = 26
      Width = 60
      Height = 15
      Caption = '产品编号'
    end
    object LBRBPST: TLabel
      Left = 230
      Top = 4
      Width = 60
      Height = 15
      Caption = '库存位置'
    end
    object LBRGREA: TLabel
      Left = 5
      Top = 48
      Width = 60
      Height = 15
      Caption = '领用原因'
    end
    object LBRGDAT: TLabel
      Left = 230
      Top = 48
      Width = 60
      Height = 15
      Caption = '领用日期'
    end
    object LBRGTME: TLabel
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
    object LBRGMRK: TLabel
      Left = 230
      Top = 70
      Width = 60
      Height = 15
      Caption = '领用备注'
    end
    object LBRGCNT: TLabel
      Left = 365
      Top = 26
      Width = 30
      Height = 15
      Caption = '数量'
    end
    object LBRGOUT: TLabel
      Left = 450
      Top = 70
      Width = 60
      Height = 15
      Caption = '是否保存'
    end
    object RGREA: JDBLOOKUPBOX
      Left = 69
      Top = 45
      Width = 154
      Height = 21
      DataField = 'RGREA'
      DataSource = FMRGETD.DSRGET
      MaxLength = 20
      TabOrder = 4
      _DatabaseName = 'MAIN'
      _TableName = 'SYSLST'
      _Field_IDNO = 'LSTID2'
      _Field_NAME = 'LSTNAM'
      _Field_KEY1 = 'LSTID1'
      _Field_KEY2 = 'RGETRGREA'
      _EDIT_WIDTH = 30
      _CHANGE_QUERY = True
      _INSERT_RECORD = True
      _INSERT_SYSLST = 'RGETRGREA'
      _SHOW_MESSAGE = True
    end
    object RGENO: TJDBEdit
      Left = 69
      Top = 1
      Width = 150
      Height = 21
      DataField = 'RGENO'
      DataSource = FMRGETD.DSRGET
      TabOrder = 0
      _EditType = EDIT
    end
    object RGDAT: TJDBEdit
      Left = 294
      Top = 45
      Width = 66
      Height = 21
      DataField = 'RGDAT'
      DataSource = FMRGETD.DSRGET
      TabOrder = 5
      _EditType = CDATE_EDIT
    end
    object RGTME: TJDBEdit
      Left = 395
      Top = 45
      Width = 49
      Height = 21
      DataField = 'RGTME'
      DataSource = FMRGETD.DSRGET
      TabOrder = 6
      _EditType = TIME_EDIT
    end
    object RGMRK: TJDBEdit
      Left = 294
      Top = 67
      Width = 150
      Height = 21
      DataField = 'RGMRK'
      DataSource = FMRGETD.DSRGET
      TabOrder = 8
      _EditType = EDIT
    end
    object RBPST: JDBLOOKUPBOX
      Left = 294
      Top = 1
      Width = 150
      Height = 21
      DataField = 'RBPST'
      DataSource = FMRGETD.DSRGET
      MaxLength = 20
      TabOrder = 1
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
      DataSource = FMRGETD.DSRGET
      MaxLength = 20
      TabOrder = 7
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
      DataSource = FMRGETD.DSRGET
      MaxLength = 20
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
    object RGCNT: TJDBEdit
      Left = 395
      Top = 23
      Width = 46
      Height = 21
      DataField = 'RGCNT'
      DataSource = FMRGETD.DSRGET
      TabOrder = 3
      _EditType = EDIT
    end
    object RGOUT: TDBCheckBox
      Left = 515
      Top = 69
      Width = 21
      Height = 17
      Caption = ' '
      DataField = 'RGOUT'
      DataSource = FMRGETD.DSRGET
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
    DataSource = FMRGETD.DSRGET
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
        FieldName = 'RGENO'
        Title.Alignment = taCenter
        Title.Caption = '领用单号'
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
        FieldName = 'RBPST'
        Title.Alignment = taCenter
        Title.Caption = '库存位置'
        Title.Color = clInfoBk
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'RGREA'
        Title.Alignment = taCenter
        Title.Caption = '领用原因'
        Title.Color = clInfoBk
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'RGDAT'
        Title.Alignment = taCenter
        Title.Caption = '领用日期'
        Title.Color = clInfoBk
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'RGTME'
        Title.Alignment = taCenter
        Title.Caption = '领用时间'
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
        FieldName = 'RGMRK'
        Title.Alignment = taCenter
        Title.Caption = '领用备注'
        Title.Color = clInfoBk
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'RGCNT'
        Title.Alignment = taCenter
        Title.Caption = '数量'
        Title.Color = clInfoBk
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'RGOUT'
        Title.Alignment = taCenter
        Title.Caption = '是否保存'
        Title.Color = clInfoBk
        Visible = True
      end>
  end
end 
