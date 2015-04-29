object FMLST: TFMLST
  Left = 201
  Top = 111
  AutoScroll = False
  Caption = ' '
  ClientHeight = 473
  ClientWidth = 537
  Color = 10871806
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = '新宋体'
  Font.Style = []
  FormStyle = fsMDIChild
  Menu = MainMenu1
  OldCreateOrder = True
  Position = poScreenCenter
  Visible = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object LBTAEID: TLabel
    Left = 60
    Top = 45
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
    Left = 60
    Top = 72
    Width = 30
    Height = 15
    Caption = '备注'
  end
  object Label2: TLabel
    Left = 270
    Top = 45
    Width = 30
    Height = 15
    Caption = '名称'
  end
  object Image2: TImage
    Left = 482
    Top = 45
    Width = 40
    Height = 40
    AutoSize = True
    Picture.Data = {
      0954474946496D61676547494638396128002800B30000FFFFFFFFF000F87858
      DE73ED3FBFFF0000000000000000000000000000000000000000000000000000
      0000000000000021FF0B4E45545343415045322E300301F87F0021F904090F00
      03002C000000002800280000049C70C849ABBD38EBCDBBFF60288E64699E68AA
      AE6C7B0630EC4E7061DB721BD840DFE3AC9D6FF80BA8840081722928A684CAC2
      52DA2C1851500155AB04589F852437DAFD62C36266D37B3D138766F76DCE8B97
      9005827E4F40DB453B7D797C7C367D6D8083733E737A7F213B86847B37882435
      0093046C9677685E3C4E4774A49D9792828382A690A4AE402FAF74AC8031B6B7
      33B9BABBBCBDBEBF21110021F904090F0003002C000000002800280000049A70
      C849ABBD38EBCDBBFF60288E64699E68AAAE6C7B06302CC92C5CDCB75D046B70
      0340E04D20D8A57CC1A4B0C87B1500C428316844F988856856206C3AB1DA29A0
      FA2D86B963AF09298D52D56B9C5298B3DE08049CFE1D17E6F180796379702048
      7E8180057864233E7B747A8D243E89813B344E40895D354F747C2A3A9069A292
      A7754EA88B8CA971AB7A859431B4B52EB7B8B9BABBBCBD29110021F904090F00
      03002C000000002800280000049C70C849ABBD38EBCDBBFF60288E64699E68AA
      AE6C7B0630EC4E7061DB721BD840DFE3AC9D6FF80BA8840081722928A684CAC2
      52DA2C1851500155AB04589F852437DAFD62C36266D37B3D138766F76DCE8B97
      9005827E4F40DB453B7D797C7C367D6D8083733E737A7F213B86847B37882435
      0093046C9677685E3C4E4774A49D9792828382A690A4AE402FAF74AC8031B6B7
      33B9BABBBCBDBEBF21110021F904090F0003002C000000002800280000049B70
      C849ABBD38EBCDBBFF60288E64699E68AAAE6C2B068104CF6E5014F0ADC3AB2D
      08378050788BA57C85A1926844D986BFE80F803B2601BF42540B6C9A9E58E036
      EB2D81B3E3AE152A9D564FB6E0925A745EE9BA1B81503717F8547B827C805465
      20367B7F8382776F2471798E79872F398C838F76428C4C3D93439A9B44923C56
      92A8A223918DA9AA2FAEA52A33B4B5952EB8B9BABBBCBDBE2311003B}
    Transparent = True
  end
  object ToolBar: TToolBar
    Left = 0
    Top = 0
    Width = 537
    Height = 36
    ButtonHeight = 30
    Color = 15719100
    ParentColor = False
    TabOrder = 3
    Wrapable = False
    object ToolButton1: TToolButton
      Left = 0
      Top = 2
      Width = 8
      Caption = 'ToolButton1'
      ImageIndex = 0
      Style = tbsSeparator
    end
    object BTNINS: TSpeedButton
      Left = 8
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
      Left = 83
      Top = 2
      Width = 75
      Height = 30
      Cursor = crHandPoint
      Caption = '&U 修改'
      Flat = True
      OnClick = BTNUPDClick
    end
    object BTNDEL: TSpeedButton
      Left = 158
      Top = 2
      Width = 75
      Height = 30
      Cursor = crHandPoint
      Caption = '&D 删除'
      Flat = True
      OnClick = BTNDELClick
    end
    object BTNYES: TSpeedButton
      Left = 233
      Top = 2
      Width = 75
      Height = 30
      Cursor = crHandPoint
      Caption = '&Y 确定'
      Flat = True
      OnClick = BTNYESClick
    end
    object BTNCAL: TSpeedButton
      Left = 308
      Top = 2
      Width = 75
      Height = 30
      Cursor = crHandPoint
      Caption = '&C 取消'
      Flat = True
      OnClick = BTNCALClick
    end
    object BTNPRN: TSpeedButton
      Left = 383
      Top = 2
      Width = 75
      Height = 30
      Cursor = crHandPoint
      Caption = '&P 打印'
      Flat = True
      OnClick = BTNPRNClick
    end
    object BTNQUT: TSpeedButton
      Left = 458
      Top = 2
      Width = 75
      Height = 30
      Cursor = crHandPoint
      Caption = '&Q 退出'
      Flat = True
      OnClick = BTNQUTClick
    end
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 454
    Width = 537
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
  object DBGrid1: TDBGrid
    Left = 0
    Top = 90
    Width = 535
    Height = 363
    DataSource = DSSYSLST
    ImeName = '中文 (简体) - 智能 ABC '
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 5
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -15
    TitleFont.Name = '新宋体'
    TitleFont.Style = []
    OnDrawColumnCell = DBGrid1DrawColumnCell
    Columns = <
      item
        Color = clWhite
        Expanded = False
        FieldName = 'LSTID2'
        Title.Alignment = taCenter
        Title.Caption = '编号'
        Title.Color = 9211135
        Width = 99
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'LSTNAM'
        Title.Alignment = taCenter
        Title.Caption = '名称'
        Title.Color = 16501680
        Width = 204
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'LSTMRK'
        Title.Alignment = taCenter
        Title.Caption = '备注'
        Title.Color = 14155007
        Width = 193
        Visible = True
      end>
  end
  object LSTID2: TJDBEdit
    Left = 95
    Top = 40
    Width = 160
    Height = 23
    DataField = 'LSTID2'
    DataSource = DSSYSLST
    ImeName = '中文 (简体) - 智能 ABC '
    TabOrder = 0
    _EditType = EDIT
    _SHOWCAL = NONE
  end
  object LSTNAM: TJDBEdit
    Left = 305
    Top = 40
    Width = 160
    Height = 23
    DataField = 'LSTNAM'
    DataSource = DSSYSLST
    ImeName = '中文 (简体) - 智能 ABC '
    TabOrder = 1
    _EditType = EDIT
    _SHOWCAL = NONE
  end
  object LSTMRK: TJDBEdit
    Left = 95
    Top = 65
    Width = 371
    Height = 23
    DataField = 'LSTMRK'
    DataSource = DSSYSLST
    ImeName = '中文 (简体) - 智能 ABC '
    TabOrder = 2
    _EditType = EDIT
    _SHOWCAL = NONE
  end
  object QSYSLST: TQuery
    CachedUpdates = True
    DatabaseName = 'MAIN'
    SQL.Strings = (
      'SELECT * FROM SYSLST')
    UpdateObject = USYSLST
    Left = 400
    Top = 295
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
    Left = 435
    Top = 295
  end
  object USYSLST: TUpdateSQL
    Left = 470
    Top = 295
  end
  object MainMenu1: TMainMenu
    Left = 475
    Top = 170
    object ABCD1: TMenuItem
      Caption = 'ABCD'
      Visible = False
    end
  end
end
