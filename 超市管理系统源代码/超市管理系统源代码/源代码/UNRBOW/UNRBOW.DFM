object FMRBOW: TFMRBOW
  Left = 130
  Top = 87
  AutoScroll = False
  Caption = '借还产品资料文件'
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
    Height = 138
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
    object LBRBENO: TLabel
      Left = 2
      Top = 4
      Width = 60
      Height = 15
      Caption = '借货单号'
    end
    object LBBGENO: TLabel
      Left = 2
      Top = 26
      Width = 60
      Height = 15
      Caption = '产品编号'
    end
    object LBRBCN1: TLabel
      Left = 2
      Top = 48
      Width = 60
      Height = 15
      Caption = '借用数量'
    end
    object LBRBCN2: TLabel
      Left = 2
      Top = 70
      Width = 60
      Height = 15
      Caption = '归还数量'
    end
    object LBRBPST: TLabel
      Left = 265
      Top = 4
      Width = 60
      Height = 15
      Caption = '库存位置'
    end
    object LBRBBCK: TLabel
      Left = 395
      Top = 70
      Width = 60
      Height = 15
      Caption = '是否销单'
    end
    object LBRBOUT: TLabel
      Left = 395
      Top = 48
      Width = 60
      Height = 15
      Caption = '是否保存'
    end
    object LBRBREA: TLabel
      Left = 2
      Top = 92
      Width = 60
      Height = 15
      Caption = '借用原因'
    end
    object LBRBDT1: TLabel
      Left = 140
      Top = 48
      Width = 60
      Height = 15
      Caption = '借用日期'
    end
    object LBRBTM1: TLabel
      Left = 295
      Top = 48
      Width = 30
      Height = 15
      Caption = '时间'
    end
    object LBRBDT2: TLabel
      Left = 140
      Top = 70
      Width = 60
      Height = 15
      Caption = '归还日期'
    end
    object LBRBTM2: TLabel
      Left = 295
      Top = 70
      Width = 30
      Height = 15
      Caption = '时间'
    end
    object LBBNENO: TLabel
      Left = 265
      Top = 92
      Width = 60
      Height = 15
      Caption = '申请人员'
    end
    object LBRBMRK: TLabel
      Left = 2
      Top = 114
      Width = 60
      Height = 15
      Caption = '借用备注'
    end
    object RBREA: JDBLOOKUPBOX
      Left = 65
      Top = 89
      Width = 154
      Height = 21
      DataField = 'RBREA'
      DataSource = FMRBOWD.DSRBOW
      MaxLength = 20
      TabOrder = 9
      _DatabaseName = 'MAIN'
      _TableName = 'SYSLST'
      _Field_IDNO = 'LSTID2'
      _Field_NAME = 'LSTNAM'
      _Field_KEY1 = 'LSTID1'
      _Field_KEY2 = 'RBOWRBREA'
      _EDIT_WIDTH = 30
      _CHANGE_QUERY = True
      _INSERT_RECORD = True
      _INSERT_SYSLST = 'RBOWRBREA'
      _SHOW_MESSAGE = True
    end
    object RBPST: JDBLOOKUPBOX
      Left = 325
      Top = 1
      Width = 155
      Height = 21
      DataField = 'RBPST'
      DataSource = FMRBOWD.DSRBOW
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
      Left = 325
      Top = 89
      Width = 155
      Height = 21
      DataField = 'BNENO'
      DataSource = FMRBOWD.DSRBOW
      MaxLength = 20
      TabOrder = 10
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
      Left = 65
      Top = 23
      Width = 416
      Height = 21
      DataField = 'BGENO'
      DataSource = FMRBOWD.DSRBOW
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
    object RBENO: TJDBEdit
      Left = 65
      Top = 1
      Width = 121
      Height = 21
      DataField = 'RBENO'
      DataSource = FMRBOWD.DSRBOW
      TabOrder = 0
      _EditType = EDIT
    end
    object RBCN1: TJDBEdit
      Left = 65
      Top = 45
      Width = 60
      Height = 21
      DataField = 'RBCN1'
      DataSource = FMRBOWD.DSRBOW
      TabOrder = 3
      _EditType = EDIT
    end
    object RBCN2: TJDBEdit
      Left = 65
      Top = 67
      Width = 60
      Height = 21
      DataField = 'RBCN2'
      DataSource = FMRBOWD.DSRBOW
      TabOrder = 6
      _EditType = EDIT
    end
    object RBDT1: TJDBEdit
      Left = 200
      Top = 45
      Width = 86
      Height = 21
      DataField = 'RBDT1'
      DataSource = FMRBOWD.DSRBOW
      TabOrder = 4
      _EditType = CDATE_EDIT
    end
    object RBTM1: TJDBEdit
      Left = 325
      Top = 45
      Width = 56
      Height = 21
      DataField = 'RBTM1'
      DataSource = FMRBOWD.DSRBOW
      TabOrder = 5
      _EditType = TIME_EDIT
    end
    object RBDT2: TJDBEdit
      Left = 200
      Top = 67
      Width = 86
      Height = 21
      DataField = 'RBDT2'
      DataSource = FMRBOWD.DSRBOW
      TabOrder = 7
      _EditType = CDATE_EDIT
    end
    object RBTM2: TJDBEdit
      Left = 325
      Top = 67
      Width = 56
      Height = 21
      DataField = 'RBTM2'
      DataSource = FMRBOWD.DSRBOW
      TabOrder = 8
      _EditType = TIME_EDIT
    end
    object RBMRK: TJDBEdit
      Left = 65
      Top = 111
      Width = 415
      Height = 21
      DataField = 'RBMRK'
      DataSource = FMRBOWD.DSRBOW
      TabOrder = 11
      _EditType = EDIT
    end
    object RBBCK: TDBCheckBox
      Left = 460
      Top = 69
      Width = 21
      Height = 17
      Caption = ' '
      DataField = 'RBBCK'
      DataSource = FMRBOWD.DSRBOW
      TabOrder = 12
      ValueChecked = 'True'
      ValueUnchecked = 'False'
    end
    object RBOUT: TDBCheckBox
      Left = 460
      Top = 47
      Width = 21
      Height = 17
      Caption = ' '
      DataField = 'RBOUT'
      DataSource = FMRBOWD.DSRBOW
      TabOrder = 13
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
      Top = 220
      Width = 100
      Height = 40
      Caption = '&O 本笔保存'
      TabOrder = 8
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 0
      Top = 260
      Width = 100
      Height = 40
      Caption = '&B 本笔销单'
      TabOrder = 9
      OnClick = BitBtn2Click
    end
  end
  object DBGrid1: TDBGrid
    Left = 102
    Top = 140
    Width = 669
    Height = 311
    DataSource = FMRBOWD.DSRBOW
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
        FieldName = 'RBENO'
        Title.Alignment = taCenter
        Title.Caption = '借货单号'
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
        FieldName = 'RBCN1'
        Title.Alignment = taCenter
        Title.Caption = '借用数量'
        Title.Color = clInfoBk
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'RBCN2'
        Title.Alignment = taCenter
        Title.Caption = '归还数量'
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
        FieldName = 'RBOUT'
        Title.Alignment = taCenter
        Title.Caption = '是否保存'
        Title.Color = clInfoBk
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'RBBCK'
        Title.Alignment = taCenter
        Title.Caption = '是否删除'
        Title.Color = clInfoBk
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'RBREA'
        Title.Alignment = taCenter
        Title.Caption = '借用原因'
        Title.Color = clInfoBk
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'RBDT1'
        Title.Alignment = taCenter
        Title.Caption = '借用日期'
        Title.Color = clInfoBk
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'RBTM1'
        Title.Alignment = taCenter
        Title.Caption = '借用时间'
        Title.Color = clInfoBk
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'RBDT2'
        Title.Alignment = taCenter
        Title.Caption = '归还货日期'
        Title.Color = clInfoBk
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'RBTM2'
        Title.Alignment = taCenter
        Title.Caption = '归还时间'
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
        FieldName = 'RBMRK'
        Title.Alignment = taCenter
        Title.Caption = '借用备注'
        Title.Color = clInfoBk
        Visible = True
      end>
  end
end 
