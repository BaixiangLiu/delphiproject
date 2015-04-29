object FMPSW: TFMPSW
  Left = 197
  Top = 130
  Width = 541
  Height = 360
  Caption = '密码设置'
  Color = 14086908
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
  object Label1: TLabel
    Left = 16
    Top = 49
    Width = 60
    Height = 15
    Caption = '员工编号'
  end
  object Label2: TLabel
    Left = 330
    Top = 49
    Width = 60
    Height = 15
    Caption = '密码代码'
  end
  object Label3: TLabel
    Left = 16
    Top = 74
    Width = 60
    Height = 15
    Caption = '修改日期'
  end
  object Label4: TLabel
    Left = 200
    Top = 74
    Width = 60
    Height = 15
    Caption = '登录日期'
  end
  object Label5: TLabel
    Left = 370
    Top = 74
    Width = 60
    Height = 15
    BiDiMode = bdLeftToRight
    Caption = '登录时间'
    ParentBiDiMode = False
  end
  object DBGrid1: TDBGrid
    Left = 5
    Top = 100
    Width = 523
    Height = 230
    DataSource = DSSYSPSW
    ImeName = '中文 (简体) - 智能 ABC'
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 5
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -15
    TitleFont.Name = '新宋体'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'BNENO'
        Title.Alignment = taCenter
        Title.Caption = '员工编号'
        Title.Color = clInfoBk
        Width = 81
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BNNAM'
        Title.Alignment = taCenter
        Title.Caption = '员工姓名'
        Title.Color = clInfoBk
        Width = 79
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PSWPSW2'
        Title.Alignment = taCenter
        Title.Caption = '密码代码'
        Title.Color = clInfoBk
        Width = 99
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PSWPSM'
        Title.Alignment = taCenter
        Title.Caption = '修改日期'
        Title.Color = clInfoBk
        Width = 79
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PSWLOG'
        Title.Alignment = taCenter
        Title.Caption = '登录日期'
        Title.Color = clInfoBk
        Width = 76
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PSWLOM'
        Title.Alignment = taCenter
        Title.Caption = '登录时间'
        Title.Color = clInfoBk
        Width = 67
        Visible = True
      end>
  end
  object ToolBar: TToolBar
    Left = 0
    Top = 0
    Width = 533
    Height = 36
    ButtonHeight = 30
    Color = 16769486
    ParentColor = False
    TabOrder = 6
    object ToolButton1: TToolButton
      Left = 0
      Top = 2
      Width = 46
      Caption = 'ToolButton1'
      ImageIndex = 0
      Style = tbsSeparator
    end
    object BTNINS: TSpeedButton
      Left = 46
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
      Left = 121
      Top = 2
      Width = 75
      Height = 30
      Cursor = crHandPoint
      Caption = '&U 修改'
      Flat = True
      OnClick = BTNUPDClick
    end
    object BTNDEL: TSpeedButton
      Left = 196
      Top = 2
      Width = 75
      Height = 30
      Cursor = crHandPoint
      Caption = '&D 删除'
      Flat = True
      OnClick = BTNDELClick
    end
    object BTNYES: TSpeedButton
      Left = 271
      Top = 2
      Width = 75
      Height = 30
      Cursor = crHandPoint
      Caption = '&Y 确定'
      Flat = True
      OnClick = BTNYESClick
    end
    object BTNCAL: TSpeedButton
      Left = 346
      Top = 2
      Width = 75
      Height = 30
      Cursor = crHandPoint
      Caption = '&C 取消'
      Flat = True
      OnClick = BTNCALClick
    end
    object BTNQUT: TSpeedButton
      Left = 421
      Top = 2
      Width = 75
      Height = 30
      Cursor = crHandPoint
      Caption = '&Q 退出'
      Flat = True
      OnClick = BTNQUTClick
    end
  end
  object PSWPSW: TEdit
    Left = 394
    Top = 45
    Width = 121
    Height = 23
    ImeName = '中文 (简体) - 智能 ABC'
    MaxLength = 10
    TabOrder = 1
  end
  object PSWPSM: TJDBEdit
    Left = 80
    Top = 70
    Width = 100
    Height = 23
    DataField = 'PSWPSM'
    DataSource = DSSYSPSW
    ImeName = '中文 (简体) - 智能 ABC'
    TabOrder = 2
    _EditType = CDATE_EDIT
    _SHOWCAL = NONE
  end
  object PSWLOG: TJDBEdit
    Left = 260
    Top = 70
    Width = 100
    Height = 23
    DataField = 'PSWLOG'
    DataSource = DSSYSPSW
    ImeName = '中文 (简体) - 智能 ABC'
    TabOrder = 3
    _EditType = CDATE_EDIT
    _SHOWCAL = NONE
  end
  object PSWLOM: TJDBEdit
    Left = 430
    Top = 70
    Width = 80
    Height = 23
    DataField = 'PSWLOM'
    DataSource = DSSYSPSW
    ImeName = '中文 (简体) - 智能 ABC'
    TabOrder = 4
    _EditType = EDIT
    _SHOWCAL = NONE
  end
  object BNENO: JDBLOOKUPBOX
    Left = 80
    Top = 45
    Width = 231
    Height = 23
    DataField = 'BNENO'
    DataSource = DSSYSPSW
    ImeName = '中文 (简体) - 智能 ABC'
    MaxLength = 20
    TabOrder = 0
    _DatabaseName = 'MAIN'
    _TableName = 'BMAN'
    _Field_IDNO = 'BNENO'
    _Field_NAME = 'BNNAM'
    _EDIT_WIDTH = 80
    _CHANGE_QUERY = True
    _INSERT_RECORD = False
    _SHOW_MESSAGE = False
  end
  object QSYSPSW: TQuery
    CachedUpdates = True
    OnCalcFields = QSYSPSWCalcFields
    DatabaseName = 'MAIN'
    SQL.Strings = (
      'SELECT * FROM SYSPSW')
    UpdateObject = USYSPSW
    Left = 335
    Top = 180
    object QSYSPSWBNENO: TStringField
      FieldName = 'BNENO'
      Origin = 'SYSPSW.BNENO'
      Size = 10
    end
    object QSYSPSWPSWPSW: TStringField
      FieldName = 'PSWPSW'
      Origin = 'SYSPSW.PSWPSW'
      Size = 10
    end
    object QSYSPSWPSWPSM: TDateTimeField
      FieldName = 'PSWPSM'
      Origin = 'SYSPSW.PSWPSM'
    end
    object QSYSPSWPSWLOG: TDateTimeField
      FieldName = 'PSWLOG'
      Origin = 'SYSPSW.PSWLOG'
    end
    object QSYSPSWPSWPSW2: TStringField
      FieldKind = fkCalculated
      FieldName = 'PSWPSW2'
      Calculated = True
    end
    object QSYSPSWBNNAM: TStringField
      FieldKind = fkLookup
      FieldName = 'BNNAM'
      LookupDataSet = QBMAN
      LookupKeyFields = 'BNENO'
      LookupResultField = 'BNNAM'
      KeyFields = 'BNENO'
      Lookup = True
    end
    object QSYSPSWPSWLOM: TStringField
      FieldName = 'PSWLOM'
      Origin = 'SYSPSW.PSWLOM'
      Size = 5
    end
  end
  object DSSYSPSW: TDataSource
    DataSet = QSYSPSW
    OnDataChange = DSSYSPSWDataChange
    Left = 370
    Top = 180
  end
  object USYSPSW: TUpdateSQL
    Left = 405
    Top = 180
  end
  object QBMAN: TQuery
    DatabaseName = 'MAIN'
    SQL.Strings = (
      'SELECT BNENO, BNNAM'
      'FROM BMAN'
      'ORDER BY BNENO')
    Left = 335
    Top = 210
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
    Left = 370
    Top = 210
  end
end
