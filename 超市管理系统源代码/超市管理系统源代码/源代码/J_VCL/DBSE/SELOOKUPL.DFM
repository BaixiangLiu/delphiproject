object FMSELOOKUPL: TFMSELOOKUPL
  Left = 238
  Top = 158
  AutoScroll = False
  Caption = ' '
  ClientHeight = 319
  ClientWidth = 450
  Color = 10871806
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = '新宋体'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = True
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object LBTAEID: TLabel
    Left = 5
    Top = 30
    Width = 30
    Height = 15
    Caption = '编号'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = '新宋体'
    Font.Style = []
    ParentFont = False
  end
  object LBTAEMRK: TLabel
    Left = 260
    Top = 31
    Width = 30
    Height = 15
    Caption = '备注'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = '新宋体'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 95
    Top = 31
    Width = 30
    Height = 15
    Caption = '名称'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = '新宋体'
    Font.Style = []
    ParentFont = False
  end
  object BTNINS: TSpeedButton
    Left = 0
    Top = 0
    Width = 75
    Height = 25
    Cursor = crHandPoint
    AllowAllUp = True
    Caption = '&A 新增'
    OnClick = BTNINSClick
  end
  object BTNUPD: TSpeedButton
    Left = 75
    Top = 0
    Width = 75
    Height = 25
    Cursor = crHandPoint
    Caption = '&U 修改'
    OnClick = BTNUPDClick
  end
  object BTNDEL: TSpeedButton
    Left = 150
    Top = 0
    Width = 75
    Height = 25
    Cursor = crHandPoint
    Caption = '&D 删除'
    OnClick = BTNDELClick
  end
  object BTNYES: TSpeedButton
    Left = 225
    Top = 0
    Width = 75
    Height = 25
    Cursor = crHandPoint
    Caption = '&Y 确定'
    OnClick = BTNYESClick
  end
  object BTNCAL: TSpeedButton
    Left = 300
    Top = 0
    Width = 75
    Height = 25
    Cursor = crHandPoint
    Caption = '&C 取消'
    OnClick = BTNCALClick
  end
  object BTNQUT: TSpeedButton
    Left = 375
    Top = 0
    Width = 75
    Height = 25
    Cursor = crHandPoint
    Caption = '&Q 结束'
    OnClick = BTNQUTClick
  end
  object DBGrid1: TDBGrid
    Left = 2
    Top = 51
    Width = 445
    Height = 265
    Ctl3D = False
    DataSource = DSSYSLST
    ImeName = '中文 (简体) - 智能 ABC'
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    ParentCtl3D = False
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = '新宋体'
    TitleFont.Style = []
    Columns = <
      item
        Color = clWhite
        Expanded = False
        FieldName = 'LSTITM'
        Title.Alignment = taCenter
        Title.Caption = '编号'
        Title.Color = 9211135
        Width = 54
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'LSTNAM'
        Title.Alignment = taCenter
        Title.Caption = '名称'
        Title.Color = 16501680
        Width = 191
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'LSTMRK'
        Title.Alignment = taCenter
        Title.Caption = '备注'
        Title.Color = 14155007
        Width = 164
        Visible = True
      end>
  end
  object LSTITM: TDBEdit
    Left = 35
    Top = 28
    Width = 56
    Height = 21
    Ctl3D = False
    DataField = 'LSTITM'
    DataSource = DSSYSLST
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = '新宋体'
    Font.Style = []
    ImeName = '中文 (简体) - 智能 ABC'
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 1
  end
  object LSTNAM: TDBEdit
    Left = 125
    Top = 28
    Width = 131
    Height = 21
    Ctl3D = False
    DataField = 'LSTNAM'
    DataSource = DSSYSLST
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = '新宋体'
    Font.Style = []
    ImeName = '中文 (简体) - 智能 ABC'
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 2
  end
  object LSTMRK: TDBEdit
    Left = 290
    Top = 28
    Width = 156
    Height = 21
    Ctl3D = False
    DataField = 'LSTMRK'
    DataSource = DSSYSLST
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = '新宋体'
    Font.Style = []
    ImeName = '中文 (简体) - 智能 ABC'
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 3
  end
  object QSYSLST: TQuery
    CachedUpdates = True
    DatabaseName = 'MAIN'
    SQL.Strings = (
      'SELECT * FROM SYSLST')
    UpdateObject = USYSLST
    Left = 90
    Top = 200
    object QSYSLSTLSTENO: TStringField
      FieldName = 'LSTENO'
      Origin = 'MAIN.SYSLST.LSTENO'
      Size = 10
    end
    object QSYSLSTLSTITM: TStringField
      FieldName = 'LSTITM'
      Origin = 'MAIN.SYSLST.LSTITM'
      Size = 3
    end
    object QSYSLSTLSTNAM: TStringField
      FieldName = 'LSTNAM'
      Origin = 'MAIN.SYSLST.LSTNAM'
    end
    object QSYSLSTLSTMRK: TStringField
      FieldName = 'LSTMRK'
      Origin = 'MAIN.SYSLST.LSTMRK'
    end
  end
  object DSSYSLST: TDataSource
    DataSet = QSYSLST
    Left = 125
    Top = 200
  end
  object USYSLST: TUpdateSQL
    Left = 160
    Top = 200
  end
  object MainMenu1: TMainMenu
    Left = 330
    Top = 95
    object N1: TMenuItem
      Caption = '退出'
      ShortCut = 27
      Visible = False
      OnClick = N1Click
    end
  end
end
