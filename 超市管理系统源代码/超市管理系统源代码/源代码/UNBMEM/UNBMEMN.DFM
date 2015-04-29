object FMBMEMN: TFMBMEMN
  Left = 326
  Top = 409
  AutoScroll = False
  Caption = '会员资料查询        按ESC可以退出'
  ClientHeight = 401
  ClientWidth = 629
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = '新宋体'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object Panel: TPanel
    Left = 230
    Top = 0
    Width = 396
    Height = 400
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Caption = ' '
    Color = 10998526
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = '新宋体'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 1
    object LBBMCNA: TLabel
      Left = 2
      Top = 58
      Width = 80
      Height = 20
      Caption = '英文姓名'
    end
    object LBBMBTH: TLabel
      Left = 2
      Top = 85
      Width = 80
      Height = 20
      Caption = '生　　日'
    end
    object LBBMSEX: TLabel
      Left = 240
      Top = 85
      Width = 40
      Height = 20
      Caption = '性别'
    end
    object LBBMENO: TLabel
      Left = 2
      Top = 4
      Width = 80
      Height = 20
      Caption = '会员编号'
    end
    object LBBMNAM: TLabel
      Left = 2
      Top = 31
      Width = 80
      Height = 20
      Caption = '中文姓名'
    end
    object LBBMPGR: TLabel
      Left = 195
      Top = 112
      Width = 80
      Height = 20
      Caption = '公司电话'
    end
    object LBBMWPN: TLabel
      Left = 215
      Top = 139
      Width = 60
      Height = 20
      Caption = '手机'
    end
    object LBBMTL1: TLabel
      Left = 2
      Top = 112
      Width = 80
      Height = 20
      Caption = '现居电话'
    end
    object LBBMTL2: TLabel
      Left = 2
      Top = 139
      Width = 80
      Height = 20
      Caption = '永久电话'
    end
    object LBBMAD1: TLabel
      Left = 2
      Top = 168
      Width = 80
      Height = 20
      Caption = '现居地址'
    end
    object LBBMAD2: TLabel
      Left = 2
      Top = 197
      Width = 80
      Height = 20
      Caption = '永久地址'
    end
    object LBBMEML: TLabel
      Left = 2
      Top = 226
      Width = 55
      Height = 20
      Caption = 'E_Mail'
    end
    object LBBMJND: TLabel
      Left = 195
      Top = 260
      Width = 80
      Height = 20
      Caption = '入会日期'
    end
    object LBBMCRD: TLabel
      Left = 2
      Top = 341
      Width = 80
      Height = 20
      Caption = '发卡日期'
    end
    object LBBMMRK: TLabel
      Left = 2
      Top = 370
      Width = 80
      Height = 20
      Caption = '叙　　述'
    end
    object LBBMLVE: TLabel
      Left = 2
      Top = 260
      Width = 80
      Height = 20
      Caption = '会员等级'
    end
    object LBBMBYR: TLabel
      Left = 2
      Top = 287
      Width = 80
      Height = 20
      Caption = '年消费额'
    end
    object LBBMBTO: TLabel
      Left = 2
      Top = 314
      Width = 80
      Height = 20
      Caption = '总消费额'
    end
    object LBBMBDT: TLabel
      Left = 175
      Top = 341
      Width = 100
      Height = 20
      Caption = '最近交易日'
    end
    object LBBMBPO: TLabel
      Left = 195
      Top = 287
      Width = 80
      Height = 20
      Caption = '购买点数'
    end
    object LBBMBTM: TLabel
      Left = 195
      Top = 314
      Width = 80
      Height = 20
      Caption = '购买次数'
    end
    object BMCNA: TJDBEdit
      Left = 84
      Top = 55
      Width = 300
      Height = 26
      DataField = 'BMCNA'
      DataSource = DSBMEM
      ReadOnly = True
      TabOrder = 2
      _EditType = EDIT
      _SHOWCAL = NONE
    end
    object BMENO: TJDBEdit
      Left = 84
      Top = 1
      Width = 100
      Height = 26
      DataField = 'BMENO'
      DataSource = DSBMEM
      ReadOnly = True
      TabOrder = 0
      _EditType = EDIT
      _SHOWCAL = NONE
    end
    object BMNAM: TJDBEdit
      Left = 84
      Top = 28
      Width = 300
      Height = 26
      DataField = 'BMNAM'
      DataSource = DSBMEM
      ReadOnly = True
      TabOrder = 1
      _EditType = EDIT
      _SHOWCAL = NONE
    end
    object BMBTH: TJDBEdit
      Left = 84
      Top = 82
      Width = 66
      Height = 26
      DataField = 'BMBTH'
      DataSource = DSBMEM
      ReadOnly = True
      TabOrder = 3
      _EditType = CDATE_EDIT
      _SHOWCAL = NONE
    end
    object BMTL3: TJDBEdit
      Left = 279
      Top = 109
      Width = 105
      Height = 26
      DataField = 'BMTL3'
      DataSource = DSBMEM
      ReadOnly = True
      TabOrder = 6
      _EditType = EDIT
      _SHOWCAL = NONE
    end
    object BMWPN: TJDBEdit
      Left = 279
      Top = 136
      Width = 105
      Height = 26
      DataField = 'BMWPN'
      DataSource = DSBMEM
      ReadOnly = True
      TabOrder = 8
      _EditType = EDIT
      _SHOWCAL = NONE
    end
    object BMTL1: TJDBEdit
      Left = 84
      Top = 109
      Width = 105
      Height = 26
      DataField = 'BMTL1'
      DataSource = DSBMEM
      ReadOnly = True
      TabOrder = 5
      _EditType = EDIT
      _SHOWCAL = NONE
    end
    object BMTL2: TJDBEdit
      Left = 84
      Top = 136
      Width = 105
      Height = 26
      DataField = 'BMTL2'
      DataSource = DSBMEM
      ReadOnly = True
      TabOrder = 7
      _EditType = EDIT
      _SHOWCAL = NONE
    end
    object BMAD1: TJDBEdit
      Left = 84
      Top = 165
      Width = 300
      Height = 26
      DataField = 'BMAD1'
      DataSource = DSBMEM
      ReadOnly = True
      TabOrder = 9
      _EditType = EDIT
      _SHOWCAL = NONE
    end
    object BMAD2: TJDBEdit
      Left = 84
      Top = 194
      Width = 300
      Height = 26
      DataField = 'BMAD2'
      DataSource = DSBMEM
      ReadOnly = True
      TabOrder = 10
      _EditType = EDIT
      _SHOWCAL = NONE
    end
    object BMEML: TJDBEdit
      Left = 84
      Top = 223
      Width = 300
      Height = 26
      DataField = 'BMEML'
      DataSource = DSBMEM
      ReadOnly = True
      TabOrder = 11
      _EditType = EDIT
      _SHOWCAL = NONE
    end
    object BMMRK: TJDBEdit
      Left = 84
      Top = 367
      Width = 300
      Height = 26
      DataField = 'BMMRK'
      DataSource = DSBMEM
      ReadOnly = True
      TabOrder = 20
      _EditType = EDIT
      _SHOWCAL = NONE
    end
    object BMLVE: TJDBEdit
      Left = 84
      Top = 257
      Width = 90
      Height = 26
      DataField = 'BMLVE'
      DataSource = DSBMEM
      ReadOnly = True
      TabOrder = 12
      _EditType = EDIT
      _SHOWCAL = NONE
    end
    object BMBYR: TJDBEdit
      Left = 84
      Top = 284
      Width = 90
      Height = 26
      DataField = 'BMBYR'
      DataSource = DSBMEM
      ReadOnly = True
      TabOrder = 13
      _EditType = EDIT
      _SHOWCAL = NONE
    end
    object BMBTO: TJDBEdit
      Left = 84
      Top = 311
      Width = 90
      Height = 26
      DataField = 'BMBTO'
      DataSource = DSBMEM
      ReadOnly = True
      TabOrder = 14
      _EditType = EDIT
      _SHOWCAL = NONE
    end
    object BMBPO: TJDBEdit
      Left = 294
      Top = 284
      Width = 90
      Height = 26
      DataField = 'BMBPO'
      DataSource = DSBMEM
      ReadOnly = True
      TabOrder = 17
      _EditType = EDIT
      _SHOWCAL = NONE
    end
    object BMBTM: TJDBEdit
      Left = 294
      Top = 311
      Width = 90
      Height = 26
      DataField = 'BMBTM'
      DataSource = DSBMEM
      ReadOnly = True
      TabOrder = 18
      _EditType = EDIT
      _SHOWCAL = NONE
    end
    object BMJND: TJDBEdit
      Left = 294
      Top = 257
      Width = 90
      Height = 26
      DataField = 'BMJND'
      DataSource = DSBMEM
      ReadOnly = True
      TabOrder = 16
      _EditType = CDATE_EDIT
      _SHOWCAL = NONE
    end
    object BMCRD: TJDBEdit
      Left = 84
      Top = 338
      Width = 90
      Height = 26
      DataField = 'BMCRD'
      DataSource = DSBMEM
      ReadOnly = True
      TabOrder = 15
      _EditType = CDATE_EDIT
      _SHOWCAL = NONE
    end
    object BMBDT: TJDBEdit
      Left = 294
      Top = 338
      Width = 90
      Height = 26
      DataField = 'BMBDT'
      DataSource = DSBMEM
      ReadOnly = True
      TabOrder = 19
      _EditType = CDATE_EDIT
      _SHOWCAL = NONE
    end
    object BMSEX: JDBLOOKUPBOX
      Left = 284
      Top = 82
      Width = 100
      Height = 26
      DataField = 'BMSEX'
      DataSource = DSBMEM
      MaxLength = 20
      ReadOnly = True
      TabOrder = 4
      _DatabaseName = 'MAIN'
      _TableName = 'SYSLST'
      _Field_IDNO = 'LSTID2'
      _Field_NAME = 'LSTNAM'
      _Field_KEY1 = 'LSTID1'
      _Field_KEY2 = 'VAR_SEX'
      _EDIT_WIDTH = 30
      _CHANGE_QUERY = True
      _INSERT_RECORD = True
      _INSERT_SYSLST = 'VAR_SEX'
      _SHOW_MESSAGE = True
    end
  end
  object DBGrid: TDBGrid
    Left = 0
    Top = 0
    Width = 226
    Height = 400
    Ctl3D = False
    DataSource = DSBMEM
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = '新宋体'
    Font.Style = []
    Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -15
    TitleFont.Name = '新宋体'
    TitleFont.Style = []
    OnCellClick = DBGridCellClick
    OnKeyDown = DBGridKeyDown
    Columns = <
      item
        Expanded = False
        FieldName = 'BMENO'
        Title.Alignment = taCenter
        Title.Caption = '会员编号'
        Title.Color = clInfoBk
        Width = 93
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BMNAM'
        Title.Alignment = taCenter
        Title.Caption = '中文姓名'
        Title.Color = clInfoBk
        Width = 90
        Visible = True
      end>
  end
  object MainMenu1: TMainMenu
    Left = 150
    Top = 370
    object PREVIEW1: TMenuItem
      Caption = 'QUIT'
      ShortCut = 27
      Visible = False
      OnClick = BTNQUTClick
    end
    object SEARCH: TMenuItem
      Caption = 'SEARCH'
      ShortCut = 112
      Visible = False
    end
  end
  object DSBMEM: TDataSource
    DataSet = QBMEM
    Left = 90
    Top = 370
  end
  object QBMEM: TQuery
    CachedUpdates = True
    DatabaseName = 'MAIN'
    SQL.Strings = (
      'SELECT *'
      'FROM BMEM'
      'ORDER BY BMENO')
    Left = 30
    Top = 370
    object QBMEMBMENO: TStringField
      FieldName = 'BMENO'
      Origin = 'MAIN.BMEM.BMENO'
      Size = 10
    end
    object QBMEMBMNAM: TStringField
      FieldName = 'BMNAM'
      Origin = 'MAIN.BMEM.BMNAM'
      Size = 10
    end
    object QBMEMBMCNA: TStringField
      FieldName = 'BMCNA'
      Origin = 'MAIN.BMEM.BMCNA'
      Size = 10
    end
    object QBMEMBMBTH: TDateTimeField
      FieldName = 'BMBTH'
      Origin = 'MAIN.BMEM.BMBTH'
    end
    object QBMEMBMSEX: TStringField
      FieldName = 'BMSEX'
      Origin = 'MAIN.BMEM.BMSEX'
      Size = 1
    end
    object QBMEMBMLVE: TFloatField
      FieldName = 'BMLVE'
      Origin = 'MAIN.BMEM.BMLVE'
    end
    object QBMEMBMBYR: TFloatField
      FieldName = 'BMBYR'
      Origin = 'MAIN.BMEM.BMBYR'
    end
    object QBMEMBMBTO: TFloatField
      FieldName = 'BMBTO'
      Origin = 'MAIN.BMEM.BMBTO'
    end
    object QBMEMBMBPO: TFloatField
      FieldName = 'BMBPO'
      Origin = 'MAIN.BMEM.BMBPO'
    end
    object QBMEMBMBTM: TFloatField
      FieldName = 'BMBTM'
      Origin = 'MAIN.BMEM.BMBTM'
    end
    object QBMEMBMBDT: TDateTimeField
      FieldName = 'BMBDT'
      Origin = 'MAIN.BMEM.BMBDT'
    end
    object QBMEMBMBYD: TDateTimeField
      FieldName = 'BMBYD'
      Origin = 'MAIN.BMEM.BMBYD'
    end
    object QBMEMBMWPN: TStringField
      FieldName = 'BMWPN'
      Origin = 'MAIN.BMEM.BMWPN'
      Size = 15
    end
    object QBMEMBMTL1: TStringField
      FieldName = 'BMTL1'
      Origin = 'MAIN.BMEM.BMTL1'
      Size = 15
    end
    object QBMEMBMTL2: TStringField
      FieldName = 'BMTL2'
      Origin = 'MAIN.BMEM.BMTL2'
      Size = 15
    end
    object QBMEMBMTL3: TStringField
      FieldName = 'BMTL3'
      Origin = 'MAIN.BMEM.BMTL3'
      Size = 15
    end
    object QBMEMBMAD1: TStringField
      FieldName = 'BMAD1'
      Origin = 'MAIN.BMEM.BMAD1'
      Size = 50
    end
    object QBMEMBMAD2: TStringField
      FieldName = 'BMAD2'
      Origin = 'MAIN.BMEM.BMAD2'
      Size = 50
    end
    object QBMEMBMZP1: TStringField
      FieldName = 'BMZP1'
      Origin = 'MAIN.BMEM.BMZP1'
      Size = 5
    end
    object QBMEMBMZP2: TStringField
      FieldName = 'BMZP2'
      Origin = 'MAIN.BMEM.BMZP2'
      Size = 5
    end
    object QBMEMBMEML: TStringField
      FieldName = 'BMEML'
      Origin = 'MAIN.BMEM.BMEML'
      Size = 30
    end
    object QBMEMBMWWW: TStringField
      FieldName = 'BMWWW'
      Origin = 'MAIN.BMEM.BMWWW'
      Size = 30
    end
    object QBMEMBMJND: TDateTimeField
      FieldName = 'BMJND'
      Origin = 'MAIN.BMEM.BMJND'
    end
    object QBMEMBMCRD: TDateTimeField
      FieldName = 'BMCRD'
      Origin = 'MAIN.BMEM.BMCRD'
    end
    object QBMEMBMDAT: TDateTimeField
      FieldName = 'BMDAT'
      Origin = 'MAIN.BMEM.BMDAT'
    end
    object QBMEMRBPST: TStringField
      FieldName = 'RBPST'
      Origin = 'MAIN.BMEM.RBPST'
      Size = 3
    end
    object QBMEMBMMRK: TMemoField
      FieldName = 'BMMRK'
      Origin = 'MAIN.BMEM.BMMRK'
      BlobType = ftMemo
      Size = 1
    end
  end
end 
