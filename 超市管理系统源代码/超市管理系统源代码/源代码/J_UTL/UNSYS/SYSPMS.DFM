object FMPMS: TFMPMS
  Left = 123
  Top = 107
  AutoScroll = False
  Caption = '权限设置'
  ClientHeight = 423
  ClientWidth = 642
  Color = 13232634
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'MS Sans Serif'
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
  TextHeight = 16
  object Page: TPageControl
    Left = 0
    Top = 0
    Width = 640
    Height = 421
    ActivePage = PAGE_A
    Style = tsFlatButtons
    TabOrder = 0
    TabWidth = 305
    OnChange = PageChange
    object PAGE_A: TTabSheet
      Caption = '权限总设置'
      object Label4: TLabel
        Left = 21
        Top = 374
        Width = 158
        Height = 15
        Caption = '按两下可以给予权限 →'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -15
        Font.Name = '新宋体'
        Font.Style = []
        ParentFont = False
      end
      object Label8: TLabel
        Left = 5
        Top = 287
        Width = 30
        Height = 15
        Caption = '进度'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -15
        Font.Name = '新宋体'
        Font.Style = []
        ParentFont = False
      end
      object Gauge: TGauge
        Left = 40
        Top = 287
        Width = 176
        Height = 15
        ForeColor = clRed
        Progress = 0
      end
      object DBGRID_BMAN: TDBGrid
        Left = 1
        Top = 5
        Width = 220
        Height = 276
        DataSource = DSBMAN
        ImeName = '中文 (简体) - 智能 ABC'
        Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -15
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        OnCellClick = DBGRID_BMANCellClick
        Columns = <
          item
            Expanded = False
            FieldName = 'BNENO'
            Title.Alignment = taCenter
            Title.Caption = '员工编号'
            Title.Color = clInfoBk
            Width = 89
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'BNNAM'
            Title.Alignment = taCenter
            Title.Caption = '中文姓名'
            Title.Color = clInfoBk
            Width = 104
            Visible = True
          end>
      end
      object DBGrid2: TDBGrid
        Left = 225
        Top = 205
        Width = 400
        Height = 182
        DataSource = DSSYSPMS
        ImeName = '中文 (简体) - 智能 ABC'
        Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -15
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        OnDrawColumnCell = DBGrid1DrawColumnCell
        OnDblClick = DBGrid1DblClick
        Columns = <
          item
            Expanded = False
            FieldName = 'PMSFUN'
            Title.Alignment = taCenter
            Title.Caption = '功能代码'
            Title.Color = 13295298
            Width = 111
            Visible = True
          end
          item
            Expanded = False
            FieldName = '_PMSFUN'
            Title.Alignment = taCenter
            Title.Caption = '功能名称'
            Title.Color = 13295298
            Width = 223
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'PMSPMS'
            Title.Alignment = taCenter
            Title.Caption = '权限'
            Title.Color = 13295298
            Visible = True
          end>
      end
      object GRID_SYSLST: TDBGrid
        Left = 225
        Top = 5
        Width = 400
        Height = 196
        DataSource = DSSYSPMSLST
        ImeName = '中文 (简体) - 智能 ABC'
        Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
        TabOrder = 2
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -15
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        OnCellClick = DBGRID_BMANCellClick
        Columns = <
          item
            Expanded = False
            FieldName = 'LSTID2'
            Title.Alignment = taCenter
            Title.Caption = '功能代码'
            Title.Color = 16766943
            Width = 93
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'LSTNAM'
            Title.Alignment = taCenter
            Title.Caption = '功能名称'
            Title.Color = 16766943
            Width = 276
            Visible = True
          end>
      end
      object BTNPMS: TBitBtn
        Left = 5
        Top = 305
        Width = 105
        Height = 30
        Caption = '产生权限功能'
        TabOrder = 3
        OnClick = BTNPMSClick
      end
      object BTNPMSA: TBitBtn
        Left = 5
        Top = 340
        Width = 105
        Height = 30
        Caption = '授予全部权限'
        TabOrder = 4
        OnClick = BTNPMSAClick
      end
      object BTNPMSD: TBitBtn
        Left = 110
        Top = 340
        Width = 105
        Height = 30
        Caption = '取消全部权限'
        TabOrder = 5
        OnClick = BTNPMSDClick
      end
      object BTNPMSC: TBitBtn
        Left = 110
        Top = 305
        Width = 105
        Height = 30
        Caption = '删除权限功能'
        TabOrder = 6
        OnClick = BTNPMSCClick
      end
    end
    object PAGE_B: TTabSheet
      Caption = '权限单一设置'
      ImageIndex = 1
      object Label1: TLabel
        Left = 10
        Top = 49
        Width = 48
        Height = 16
        Caption = '员工编号'
      end
      object Label3: TLabel
        Left = 10
        Top = 74
        Width = 48
        Height = 16
        Caption = '使用功能'
      end
      object Label2: TLabel
        Left = 456
        Top = 84
        Width = 108
        Height = 16
        Caption = '按两下可以给予权限'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object DBGrid1: TDBGrid
        Left = 0
        Top = 100
        Width = 631
        Height = 290
        DataSource = DSSYSPMS
        ImeName = '中文 (简体) - 智能 ABC'
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -15
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        OnDrawColumnCell = DBGrid1DrawColumnCell
        OnDblClick = DBGrid1DblClick
        Columns = <
          item
            Expanded = False
            FieldName = 'BNENO'
            Title.Alignment = taCenter
            Title.Caption = '员工编号'
            Title.Color = clInfoBk
            Width = 80
            Visible = True
          end
          item
            Expanded = False
            FieldName = '_BNNAM'
            Title.Alignment = taCenter
            Title.Caption = '员工姓名'
            Title.Color = clInfoBk
            Width = 82
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'PMSFUN'
            Title.Alignment = taCenter
            Title.Caption = '功能代码'
            Title.Color = clInfoBk
            Width = 86
            Visible = True
          end
          item
            Expanded = False
            FieldName = '_PMSFUN'
            Title.Alignment = taCenter
            Title.Caption = '功能名称'
            Title.Color = clInfoBk
            Width = 250
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'PMSPMS'
            Title.Alignment = taCenter
            Title.Caption = '权限'
            Title.Color = clInfoBk
            Visible = True
          end>
      end
      object ToolBar: TToolBar
        Left = 0
        Top = 0
        Width = 632
        Height = 36
        ButtonHeight = 30
        Caption = 'ToolBar'
        Color = 16703685
        ParentColor = False
        TabOrder = 1
        object ToolButton1: TToolButton
          Left = 0
          Top = 2
          Width = 51
          Caption = 'ToolButton1'
          ImageIndex = 0
          Style = tbsSeparator
        end
        object BTNINS: TSpeedButton
          Left = 51
          Top = 2
          Width = 75
          Height = 30
          Cursor = crHandPoint
          AllowAllUp = True
          Caption = '&A 新增'
          Flat = True
          OnClick = BTNINSClick
        end
        object BTNUPD: TSpeedButton
          Left = 126
          Top = 2
          Width = 75
          Height = 30
          Cursor = crHandPoint
          Caption = '&U 修改'
          Flat = True
          OnClick = BTNUPDClick
        end
        object BTNDEL: TSpeedButton
          Left = 201
          Top = 2
          Width = 75
          Height = 30
          Cursor = crHandPoint
          Caption = '&D 删除'
          Flat = True
          OnClick = BTNDELClick
        end
        object BTNYES: TSpeedButton
          Left = 276
          Top = 2
          Width = 75
          Height = 30
          Cursor = crHandPoint
          Caption = '&Y 确定'
          Flat = True
          OnClick = BTNYESClick
        end
        object BTNCAL: TSpeedButton
          Left = 351
          Top = 2
          Width = 75
          Height = 30
          Cursor = crHandPoint
          Caption = '&C 取消'
          Flat = True
          OnClick = BTNCALClick
        end
        object BTNSER: TSpeedButton
          Left = 426
          Top = 2
          Width = 75
          Height = 30
          Cursor = crHandPoint
          Caption = '&F 查询'
          Flat = True
          OnClick = BTNSERClick
        end
        object BTNQUT: TSpeedButton
          Left = 501
          Top = 2
          Width = 75
          Height = 30
          Cursor = crHandPoint
          Caption = '&Q 退出'
          Flat = True
          OnClick = BTNQUTClick
        end
      end
      object PMSPMS: TDBCheckBox
        Left = 430
        Top = 49
        Width = 97
        Height = 17
        Caption = '附加权限'
        DataField = 'PMSPMS'
        DataSource = DSSYSPMS
        TabOrder = 2
        ValueChecked = 'True'
        ValueUnchecked = 'False'
      end
      object PMSFUN: JDBLOOKUPBOX
        Left = 75
        Top = 71
        Width = 336
        Height = 24
        DataField = 'PMSFUN'
        DataSource = DSSYSPMS
        ImeName = '中文 (简体) - 智能 ABC'
        MaxLength = 20
        TabOrder = 3
        OnKeyDown = BNENOKeyDown
        _DatabaseName = 'MAIN'
        _TableName = 'SYSLST'
        _Field_IDNO = 'LSTID2'
        _Field_NAME = 'LSTNAM'
        _Field_KEY1 = 'LSTID1'
        _Field_KEY2 = 'SYSPMS'
        _EDIT_WIDTH = 80
        _CHANGE_QUERY = True
        _INSERT_RECORD = True
        _INSERT_SYSLST = 'SYSPMS'
        _SHOW_MESSAGE = True
      end
      object BNENO: JDBLOOKUPBOX
        Left = 75
        Top = 46
        Width = 336
        Height = 24
        DataField = 'BNENO'
        DataSource = DSSYSPMS
        ImeName = '中文 (简体) - 智能 ABC'
        MaxLength = 20
        TabOrder = 4
        OnKeyDown = BNENOKeyDown
        _DatabaseName = 'MAIN'
        _TableName = 'BMAN'
        _Field_IDNO = 'BNENO'
        _Field_NAME = 'BNNAM'
        _EDIT_WIDTH = 80
        _CHANGE_QUERY = True
        _INSERT_RECORD = False
        _SHOW_MESSAGE = False
      end
    end
  end
  object QSYSPMS: TQuery
    CachedUpdates = True
    DatabaseName = 'MAIN'
    SQL.Strings = (
      'SELECT * FROM SYSPMS')
    UpdateObject = USYSPMS
    Left = 365
    Top = 85
    object QSYSPMSBNENO: TStringField
      FieldName = 'BNENO'
      Origin = 'SYSPMS.BNENO'
      Size = 10
    end
    object QSYSPMSPMSFUN: TStringField
      FieldName = 'PMSFUN'
      Origin = 'SYSPMS.PMSFUN'
      Size = 10
    end
    object QSYSPMSPMSNAM: TStringField
      FieldName = 'PMSNAM'
      Origin = 'SYSPMS.PMSNAM'
      Size = 40
    end
    object QSYSPMSPMSPMS: TBooleanField
      FieldName = 'PMSPMS'
      Origin = 'SYSPMS.PMSPMS'
    end
    object QSYSPMS_PMSFUN: TStringField
      FieldKind = fkLookup
      FieldName = '_PMSFUN'
      LookupDataSet = QPMSFUN
      LookupKeyFields = 'LSTID2'
      LookupResultField = 'LSTNAM'
      KeyFields = 'PMSFUN'
      Size = 40
      Lookup = True
    end
    object QSYSPMS_BNNAM: TStringField
      FieldKind = fkLookup
      FieldName = '_BNNAM'
      LookupDataSet = QBMAN
      LookupKeyFields = 'BNENO'
      LookupResultField = 'BNNAM'
      KeyFields = 'BNENO'
      Lookup = True
    end
  end
  object DSSYSPMS: TDataSource
    DataSet = QSYSPMS
    Left = 430
    Top = 85
  end
  object USYSPMS: TUpdateSQL
    Left = 495
    Top = 85
  end
  object QBMAN: TQuery
    DatabaseName = 'MAIN'
    SQL.Strings = (
      'SELECT BNENO, BNNAM'
      'FROM BMAN'
      'ORDER BY BNENO')
    Left = 365
    Top = 145
    object QBMANBNENO: TStringField
      FieldName = 'BNENO'
      Origin = 'BMAN.BNENO'
      Size = 10
    end
    object QBMANBNNAM: TStringField
      FieldName = 'BNNAM'
      Origin = 'BMAN.BNNAM'
    end
  end
  object DSBMAN: TDataSource
    DataSet = QBMAN
    Left = 430
    Top = 145
  end
  object QPMSFUN: TQuery
    CachedUpdates = True
    DatabaseName = 'MAIN'
    SQL.Strings = (
      'SELECT *'
      'FROM SYSLST'
      'WHERE LSTID1 = '#39'SYSPMS'#39
      'ORDER BY LSTID2, LSTNAM')
    Left = 365
    Top = 205
    object QPMSFUNLSTID1: TStringField
      FieldName = 'LSTID1'
      Origin = 'SYSLST.LSTID1'
      Size = 10
    end
    object QPMSFUNLSTID2: TStringField
      FieldName = 'LSTID2'
      Origin = 'SYSLST.LSTID2'
      Size = 10
    end
    object QPMSFUNLSTNAM: TStringField
      FieldName = 'LSTNAM'
      Origin = 'SYSLST.LSTNAM'
      Size = 40
    end
    object QPMSFUNLSTMRK: TStringField
      FieldName = 'LSTMRK'
      Origin = 'SYSLST.LSTMRK'
      Size = 40
    end
  end
  object QSYSPMSLST: TQuery
    CachedUpdates = True
    DatabaseName = 'MAIN'
    SQL.Strings = (
      'SELECT * FROM SYSLST')
    Left = 370
    Top = 290
    object QSYSPMSLSTLSTID1: TStringField
      FieldName = 'LSTID1'
      Origin = 'SYSLST.LSTID1'
      Size = 10
    end
    object QSYSPMSLSTLSTID2: TStringField
      FieldName = 'LSTID2'
      Origin = 'SYSLST.LSTID2'
      Size = 10
    end
    object QSYSPMSLSTLSTNAM: TStringField
      FieldName = 'LSTNAM'
      Origin = 'SYSLST.LSTNAM'
      Size = 40
    end
    object QSYSPMSLSTLSTMRK: TStringField
      FieldName = 'LSTMRK'
      Origin = 'SYSLST.LSTMRK'
      Size = 40
    end
  end
  object DSSYSPMSLST: TDataSource
    DataSet = QSYSPMSLST
    Left = 459
    Top = 290
  end
  object QALLPMS: TQuery
    CachedUpdates = True
    DatabaseName = 'MAIN'
    SQL.Strings = (
      'SELECT * FROM SYSLST')
    Left = 370
    Top = 360
    object StringField1: TStringField
      FieldName = 'LSTID1'
      Origin = 'SYSLST.LSTID1'
      Size = 10
    end
    object StringField2: TStringField
      FieldName = 'LSTID2'
      Origin = 'SYSLST.LSTID2'
      Size = 10
    end
    object StringField3: TStringField
      FieldName = 'LSTNAM'
      Origin = 'SYSLST.LSTNAM'
      Size = 40
    end
    object StringField4: TStringField
      FieldName = 'LSTMRK'
      Origin = 'SYSLST.LSTMRK'
      Size = 40
    end
  end
end 
