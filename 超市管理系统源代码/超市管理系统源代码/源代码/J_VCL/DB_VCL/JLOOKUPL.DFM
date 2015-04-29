object FMLOOKUPL: TFMLOOKUPL
  Left = 183
  Top = 116
  AutoScroll = False
  Caption = ' '
  ClientHeight = 303
  ClientWidth = 544
  Color = 14467283
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
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
  TextHeight = 15
  object LBTAEID: TLabel
    Left = 5
    Top = 9
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
    Left = 255
    Top = 9
    Width = 30
    Height = 15
    Caption = '备注'
  end
  object Label2: TLabel
    Left = 120
    Top = 9
    Width = 30
    Height = 15
    Caption = '名称'
  end
  object BTNINS: TSpeedButton
    Left = 443
    Top = 2
    Width = 100
    Height = 50
    Cursor = crHandPoint
    AllowAllUp = True
    Caption = '&A 新增'
    OnClick = BTNINSClick
  end
  object BTNUPD: TSpeedButton
    Left = 443
    Top = 52
    Width = 100
    Height = 50
    Cursor = crHandPoint
    Caption = '&U 修改'
    OnClick = BTNUPDClick
  end
  object BTNDEL: TSpeedButton
    Left = 443
    Top = 102
    Width = 100
    Height = 50
    Cursor = crHandPoint
    Caption = '&D 删除'
    OnClick = BTNDELClick
  end
  object BTNYES: TSpeedButton
    Left = 443
    Top = 152
    Width = 100
    Height = 50
    Cursor = crHandPoint
    Caption = '&Y 确定'
    OnClick = BTNYESClick
  end
  object BTNCAL: TSpeedButton
    Left = 443
    Top = 202
    Width = 100
    Height = 50
    Cursor = crHandPoint
    Caption = '&C 取消'
    OnClick = BTNCALClick
  end
  object BTNQUT: TSpeedButton
    Left = 443
    Top = 252
    Width = 100
    Height = 50
    Cursor = crHandPoint
    Caption = '&Q 结束'
    OnClick = BTNQUTClick
  end
  object DBGrid1: TDBGrid
    Left = 1
    Top = 30
    Width = 440
    Height = 272
    Ctl3D = False
    DataSource = DSSYSLST
    ImeName = '中文 (简体) - 智能 ABC'
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    ParentCtl3D = False
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -15
    TitleFont.Name = '新宋体'
    TitleFont.Style = []
    Columns = <
      item
        Color = clWhite
        Expanded = False
        FieldName = 'LSTID2'
        Title.Alignment = taCenter
        Title.Caption = '编号'
        Title.Color = 14469295
        Width = 99
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'LSTNAM'
        Title.Alignment = taCenter
        Title.Caption = '名称'
        Title.Color = 11403000
        Width = 167
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'LSTMRK'
        Title.Alignment = taCenter
        Title.Caption = '备注'
        Title.Color = 9609427
        Width = 134
        Visible = True
      end>
  end
  object LSTID2: TDBEdit
    Left = 35
    Top = 5
    Width = 80
    Height = 21
    Ctl3D = False
    DataField = 'LSTID2'
    DataSource = DSSYSLST
    ImeName = '中文 (简体) - 智能 ABC'
    ParentCtl3D = False
    TabOrder = 1
  end
  object LSTNAM: TDBEdit
    Left = 150
    Top = 5
    Width = 100
    Height = 21
    Ctl3D = False
    DataField = 'LSTNAM'
    DataSource = DSSYSLST
    ImeName = '中文 (简体) - 智能 ABC'
    ParentCtl3D = False
    TabOrder = 2
  end
  object LSTMRK: TDBEdit
    Left = 285
    Top = 5
    Width = 151
    Height = 21
    Ctl3D = False
    DataField = 'LSTMRK'
    DataSource = DSSYSLST
    ImeName = '中文 (简体) - 智能 ABC'
    ParentCtl3D = False
    TabOrder = 3
  end
  object QSYSLST: TQuery
    CachedUpdates = True
    DatabaseName = 'MAIN'
    SQL.Strings = (
      'SELECT * FROM SYSLST')
    UpdateObject = USYSLST
    Left = 85
    Top = 170
    object QSYSLSTLSTID1: TStringField
      FieldName = 'LSTID1'
      Origin = 'SYSLST.LSTID1'
      Size = 10
    end
    object QSYSLSTLSTID2: TStringField
      FieldName = 'LSTID2'
      Origin = 'SYSLST.LSTID2'
      Size = 10
    end
    object QSYSLSTLSTNAM: TStringField
      FieldName = 'LSTNAM'
      Origin = 'SYSLST.LSTNAM'
      Size = 40
    end
    object QSYSLSTLSTMRK: TStringField
      FieldName = 'LSTMRK'
      Origin = 'SYSLST.LSTMRK'
      Size = 40
    end
  end
  object DSSYSLST: TDataSource
    DataSet = QSYSLST
    Left = 120
    Top = 170
  end
  object USYSLST: TUpdateSQL
    Left = 155
    Top = 170
  end
  object MainMenu1: TMainMenu
    Left = 325
    Top = 65
    object N1: TMenuItem
      Caption = '退出'
      ShortCut = 27
      Visible = False
      OnClick = N1Click
    end
  end
end
