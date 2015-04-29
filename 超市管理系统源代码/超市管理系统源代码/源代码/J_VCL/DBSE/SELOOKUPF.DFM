object FMSELOOKUP: TFMSELOOKUP
  Left = 499
  Top = 75
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = '相关数据快速查询'
  ClientHeight = 461
  ClientWidth = 291
  Color = 12113393
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDefault
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 5
    Top = 36
    Width = 24
    Height = 16
    Caption = '编号'
  end
  object Label2: TLabel
    Left = 150
    Top = 36
    Width = 24
    Height = 16
    Caption = '名称'
  end
  object BTNSER1: TSpeedButton
    Left = 96
    Top = 32
    Width = 50
    Height = 24
    Cursor = crHandPoint
    AllowAllUp = True
    Caption = '&1 查询'
    Flat = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    OnClick = BTNSER1Click
  end
  object BTNSER2: TSpeedButton
    Left = 241
    Top = 32
    Width = 50
    Height = 24
    Cursor = crHandPoint
    AllowAllUp = True
    Caption = '&2 查询'
    Flat = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    OnClick = BTNSER2Click
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 60
    Width = 291
    Height = 400
    Ctl3D = False
    DataSource = DataSource1
    ImeName = '中文 (简体) - 智能 ABC'
    Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    ParentCtl3D = False
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -15
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Visible = False
    OnCellClick = DBGrid1CellClick
    OnKeyDown = DBGrid1KeyDown
    OnTitleClick = DBGrid2TitleClick
    Columns = <
      item
        Expanded = False
        Title.Alignment = taCenter
        Title.Caption = '相关编号'
        Title.Color = 9742846
        Width = 73
        Visible = True
      end
      item
        Expanded = False
        Title.Alignment = taCenter
        Title.Caption = '相关名称'
        Title.Color = 16694659
        Width = 191
        Visible = True
      end>
  end
  object ED_IDNO: TEdit
    Left = 35
    Top = 32
    Width = 60
    Height = 22
    Ctl3D = False
    ImeName = '中文 (简体) - 智能 ABC'
    ParentCtl3D = False
    TabOrder = 1
    OnKeyDown = ED_IDNOKeyDown
  end
  object ED_NAME: TEdit
    Left = 180
    Top = 32
    Width = 60
    Height = 22
    Ctl3D = False
    ImeName = '中文 (简体) - 智能 ABC'
    ParentCtl3D = False
    TabOrder = 2
    OnKeyDown = ED_NAMEKeyDown
  end
  object ToolBar: TToolBar
    Left = 0
    Top = 0
    Width = 291
    Height = 30
    ButtonHeight = 25
    Caption = 'ToolBar'
    Color = 16307921
    ParentColor = False
    TabOrder = 3
    object ToolButton1: TToolButton
      Left = 0
      Top = 2
      Width = 26
      Caption = 'ToolButton1'
      Style = tbsSeparator
    end
    object BTNSER: TSpeedButton
      Left = 26
      Top = 2
      Width = 120
      Height = 25
      Cursor = crHandPoint
      AllowAllUp = True
      Caption = '&C 清除'
      Flat = True
      OnClick = BTNSERClick
    end
    object BTNQUT: TSpeedButton
      Left = 146
      Top = 2
      Width = 120
      Height = 25
      Cursor = crHandPoint
      Caption = '&Q 取消'
      Flat = True
      OnClick = BTNQUTClick
    end
  end
  object QCHECK: TQuery
    Left = 15
    Top = 142
  end
  object DataSource1: TDataSource
    DataSet = QCHECK
    Left = 80
    Top = 145
  end
  object MainMenu1: TMainMenu
    Left = 160
    Top = 145
    object ESC: TMenuItem
      Caption = '取消ESC'
      ShortCut = 27
      Visible = False
      OnClick = ESCClick
    end
  end
end
