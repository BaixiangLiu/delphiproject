object FMBMEM: TFMBMEM
  Left = 108
  Top = 36
  AutoScroll = False
  Caption = '会员信息'
  ClientHeight = 510
  ClientWidth = 566
  Color = 15648684
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = '宋体'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object StatusBar: TStatusBar
    Left = 0
    Top = 491
    Width = 566
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
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 566
    Height = 491
    Align = alClient
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Caption = ' '
    Color = clInactiveCaptionText
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = '宋体'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 1
    object LBBMCNA: TLabel
      Left = 175
      Top = 28
      Width = 52
      Height = 13
      Caption = '英文姓名'
    end
    object LBBMBTH: TLabel
      Left = 5
      Top = 58
      Width = 52
      Height = 13
      Caption = '生　　日'
    end
    object LBBMSEX: TLabel
      Left = 175
      Top = 58
      Width = 52
      Height = 13
      Caption = '性　　别'
    end
    object LBBMENO: TLabel
      Left = 5
      Top = 8
      Width = 52
      Height = 13
      Caption = '会员编号'
    end
    object LBBMNAM: TLabel
      Left = 5
      Top = 28
      Width = 52
      Height = 13
      Caption = '中文姓名'
    end
    object LBBMTL3: TLabel
      Left = 175
      Top = 98
      Width = 52
      Height = 13
      Caption = '公司电话'
    end
    object LBBMWPN: TLabel
      Left = 5
      Top = 78
      Width = 26
      Height = 13
      Caption = '手机'
    end
    object LBBMTL1: TLabel
      Left = 175
      Top = 78
      Width = 52
      Height = 13
      Caption = '现居电话'
    end
    object LBBMTL2: TLabel
      Left = 5
      Top = 98
      Width = 52
      Height = 13
      Caption = '永久电话'
    end
    object LBBMAD1: TLabel
      Left = 132
      Top = 118
      Width = 26
      Height = 13
      Caption = '地址'
    end
    object LBBMAD2: TLabel
      Left = 132
      Top = 138
      Width = 26
      Height = 13
      Caption = '地址'
    end
    object LBBMEML: TLabel
      Left = 5
      Top = 158
      Width = 42
      Height = 13
      Caption = 'E_Mail'
    end
    object LBBMWWW: TLabel
      Left = 5
      Top = 178
      Width = 52
      Height = 13
      Caption = '个人网址'
    end
    object LBBMZP1: TLabel
      Left = 5
      Top = 118
      Width = 78
      Height = 13
      Caption = '现居邮政编码'
    end
    object LBBMZP2: TLabel
      Left = 5
      Top = 138
      Width = 78
      Height = 13
      Caption = '永久邮政编码'
    end
    object LBBMJND: TLabel
      Left = 175
      Top = 248
      Width = 52
      Height = 13
      Caption = '入会日期'
    end
    object LBBMCRD: TLabel
      Left = 175
      Top = 268
      Width = 52
      Height = 13
      Caption = '发卡日期'
    end
    object LBBMDAT: TLabel
      Left = 175
      Top = 288
      Width = 53
      Height = 13
      Caption = '建 档 日'
    end
    object LBBMMRK: TLabel
      Left = 5
      Top = 356
      Width = 52
      Height = 13
      Caption = '叙　　述'
    end
    object LBBMLVE: TLabel
      Left = 5
      Top = 208
      Width = 52
      Height = 13
      Caption = '会员等级'
    end
    object LBBMBYR: TLabel
      Left = 5
      Top = 228
      Width = 52
      Height = 13
      Caption = '年消费额'
    end
    object LBBMBTO: TLabel
      Left = 5
      Top = 248
      Width = 52
      Height = 13
      Caption = '总消费额'
    end
    object LBBMBDT: TLabel
      Left = 175
      Top = 208
      Width = 65
      Height = 13
      Caption = '最近交易日'
    end
    object LBBMBYD: TLabel
      Left = 175
      Top = 228
      Width = 65
      Height = 13
      Caption = '清年消费日'
    end
    object LBBMBPO: TLabel
      Left = 5
      Top = 268
      Width = 52
      Height = 13
      Caption = '购买点数'
    end
    object LBBMBTM: TLabel
      Left = 5
      Top = 288
      Width = 52
      Height = 13
      Caption = '购买次数'
    end
    object LBRBPST: TLabel
      Left = 5
      Top = 308
      Width = 52
      Height = 13
      Caption = '建档店号'
    end
    object Bevel1: TBevel
      Left = 5
      Top = 40
      Width = 336
      Height = 11
      Shape = bsBottomLine
    end
    object Bevel2: TBevel
      Left = 5
      Top = 190
      Width = 336
      Height = 11
      Shape = bsBottomLine
    end
    object LB_MAX: TLabel
      Left = 0
      Top = 435
      Width = 60
      Height = 15
      Caption = '最大编号'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -15
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
    end
    object BMCNA: TJDBEdit
      Left = 230
      Top = 25
      Width = 110
      Height = 19
      DataField = 'BMCNA'
      DataSource = FMBMEMD.DSBMEM
      TabOrder = 2
      _EditType = EDIT
      _SHOWCAL = NONE
    end
    object BMENO: TJDBEdit
      Left = 60
      Top = 5
      Width = 110
      Height = 19
      DataField = 'BMENO'
      DataSource = FMBMEMD.DSBMEM
      TabOrder = 0
      _EditType = EDIT
      _SHOWCAL = NONE
    end
    object BMNAM: TJDBEdit
      Left = 60
      Top = 25
      Width = 110
      Height = 19
      DataField = 'BMNAM'
      DataSource = FMBMEMD.DSBMEM
      TabOrder = 1
      _EditType = EDIT
      _SHOWCAL = NONE
    end
    object BMBTH: TJDBEdit
      Left = 60
      Top = 55
      Width = 110
      Height = 19
      DataField = 'BMBTH'
      DataSource = FMBMEMD.DSBMEM
      TabOrder = 3
      _EditType = EDATE_EDIT
      _SHOWCAL = NONE
    end
    object BMTL3: TJDBEdit
      Left = 230
      Top = 95
      Width = 110
      Height = 19
      DataField = 'BMTL3'
      DataSource = FMBMEMD.DSBMEM
      TabOrder = 8
      _EditType = EDIT
      _SHOWCAL = NONE
    end
    object BMWPN: TJDBEdit
      Left = 60
      Top = 75
      Width = 110
      Height = 19
      DataField = 'BMWPN'
      DataSource = FMBMEMD.DSBMEM
      TabOrder = 5
      _EditType = EDIT
      _SHOWCAL = NONE
    end
    object BMTL1: TJDBEdit
      Left = 230
      Top = 75
      Width = 110
      Height = 19
      DataField = 'BMTL1'
      DataSource = FMBMEMD.DSBMEM
      TabOrder = 6
      _EditType = EDIT
      _SHOWCAL = NONE
    end
    object BMTL2: TJDBEdit
      Left = 60
      Top = 95
      Width = 110
      Height = 19
      DataField = 'BMTL2'
      DataSource = FMBMEMD.DSBMEM
      TabOrder = 7
      _EditType = EDIT
      _SHOWCAL = NONE
    end
    object BMAD1: TJDBEdit
      Left = 159
      Top = 115
      Width = 181
      Height = 19
      DataField = 'BMAD1'
      DataSource = FMBMEMD.DSBMEM
      TabOrder = 10
      _EditType = EDIT
      _SHOWCAL = NONE
    end
    object BMAD2: TJDBEdit
      Left = 159
      Top = 135
      Width = 181
      Height = 19
      DataField = 'BMAD2'
      DataSource = FMBMEMD.DSBMEM
      TabOrder = 12
      _EditType = EDIT
      _SHOWCAL = NONE
    end
    object BMEML: TJDBEdit
      Left = 60
      Top = 155
      Width = 280
      Height = 19
      DataField = 'BMEML'
      DataSource = FMBMEMD.DSBMEM
      TabOrder = 13
      _EditType = EDIT
      _SHOWCAL = NONE
    end
    object BMWWW: TJDBEdit
      Left = 60
      Top = 175
      Width = 280
      Height = 19
      DataField = 'BMWWW'
      DataSource = FMBMEMD.DSBMEM
      TabOrder = 14
      _EditType = EDIT
      _SHOWCAL = NONE
    end
    object BMZP1: TJDBEdit
      Left = 84
      Top = 115
      Width = 46
      Height = 19
      DataField = 'BMZP1'
      DataSource = FMBMEMD.DSBMEM
      TabOrder = 9
      _EditType = EDIT
      _SHOWCAL = NONE
    end
    object BMZP2: TJDBEdit
      Left = 84
      Top = 135
      Width = 46
      Height = 19
      DataField = 'BMZP2'
      DataSource = FMBMEMD.DSBMEM
      TabOrder = 11
      _EditType = EDIT
      _SHOWCAL = NONE
    end
    object BMLVE: TJDBEdit
      Left = 60
      Top = 205
      Width = 110
      Height = 19
      DataField = 'BMLVE'
      DataSource = FMBMEMD.DSBMEM
      TabOrder = 15
      _EditType = EDIT
      _SHOWCAL = NONE
    end
    object BMBYR: TJDBEdit
      Left = 60
      Top = 225
      Width = 110
      Height = 19
      DataField = 'BMBYR'
      DataSource = FMBMEMD.DSBMEM
      TabOrder = 16
      _EditType = EDIT
      _SHOWCAL = NONE
    end
    object BMBTO: TJDBEdit
      Left = 60
      Top = 245
      Width = 110
      Height = 19
      DataField = 'BMBTO'
      DataSource = FMBMEMD.DSBMEM
      TabOrder = 17
      _EditType = EDIT
      _SHOWCAL = NONE
    end
    object BMBPO: TJDBEdit
      Left = 60
      Top = 265
      Width = 110
      Height = 19
      DataField = 'BMBPO'
      DataSource = FMBMEMD.DSBMEM
      TabOrder = 18
      _EditType = EDIT
      _SHOWCAL = NONE
    end
    object BMBTM: TJDBEdit
      Left = 60
      Top = 285
      Width = 110
      Height = 19
      DataField = 'BMBTM'
      DataSource = FMBMEMD.DSBMEM
      TabOrder = 19
      _EditType = EDIT
      _SHOWCAL = NONE
    end
    object BMJND: TJDBEdit
      Left = 230
      Top = 245
      Width = 110
      Height = 19
      DataField = 'BMJND'
      DataSource = FMBMEMD.DSBMEM
      TabOrder = 23
      _EditType = EDATE_EDIT
      _SHOWCAL = NONE
    end
    object BMCRD: TJDBEdit
      Left = 230
      Top = 265
      Width = 110
      Height = 19
      DataField = 'BMCRD'
      DataSource = FMBMEMD.DSBMEM
      TabOrder = 24
      _EditType = EDATE_EDIT
      _SHOWCAL = NONE
    end
    object BMBDT: TJDBEdit
      Left = 230
      Top = 205
      Width = 110
      Height = 19
      DataField = 'BMBDT'
      DataSource = FMBMEMD.DSBMEM
      TabOrder = 21
      _EditType = EDATE_EDIT
      _SHOWCAL = NONE
    end
    object BMBYD: TJDBEdit
      Left = 230
      Top = 225
      Width = 110
      Height = 19
      DataField = 'BMBYD'
      DataSource = FMBMEMD.DSBMEM
      TabOrder = 22
      _EditType = EDATE_EDIT
      _SHOWCAL = NONE
    end
    object BMDAT: TJDBEdit
      Left = 230
      Top = 285
      Width = 110
      Height = 19
      DataField = 'BMDAT'
      DataSource = FMBMEMD.DSBMEM
      TabOrder = 25
      _EditType = EDATE_EDIT
      _SHOWCAL = NONE
    end
    object RBPST: TJDBEdit
      Left = 60
      Top = 305
      Width = 110
      Height = 19
      DataField = 'RBPST'
      DataSource = FMBMEMD.DSBMEM
      ReadOnly = True
      TabOrder = 20
      _EditType = CDATE_EDIT
      _SHOWCAL = NONE
    end
    object BMMRK: TDBMemo
      Left = 60
      Top = 325
      Width = 280
      Height = 75
      DataField = 'BMMRK'
      DataSource = FMBMEMD.DSBMEM
      TabOrder = 26
    end
    object BNSEX: SEDBLOOKUPBOX
      Left = 230
      Top = 55
      Width = 110
      Height = 19
      DataField = 'BMSEX'
      DataSource = FMBMEMD.DSBMEM
      MaxLength = 20
      TabOrder = 4
      _EditType = SEVARCHAR
      _DatabaseName = 'MAIN'
      _TableName = 'SYSLST'
      _Field_IDNO = 'B_SEX'
      _EDIT_WIDTH = 50
      _CHANGE_QUERY = True
      _INSERT_RECORD = True
      _SHOW_MESSAGE = True
    end
    object DBGrid: TDBGrid
      Left = 343
      Top = 240
      Width = 220
      Height = 194
      DataSource = FMBMEMD.DSBMEM
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 27
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -13
      TitleFont.Name = '宋体'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'BMENO'
          Title.Alignment = taCenter
          Title.Caption = '会员编号'
          Title.Color = clInfoBk
          Width = 96
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'BMNAM'
          Title.Alignment = taCenter
          Title.Caption = '中文姓名'
          Title.Color = clInfoBk
          Width = 88
          Visible = True
        end>
    end
    object GroupBox1: TGroupBox
      Left = 343
      Top = 6
      Width = 220
      Height = 216
      Caption = '快速查询'
      Ctl3D = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = '宋体'
      Font.Style = []
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 28
      object Label7: TLabel
        Left = 133
        Top = 24
        Width = 12
        Height = 12
        Caption = '至'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
      end
      object Label9: TLabel
        Left = 133
        Top = 64
        Width = 12
        Height = 12
        Caption = '至'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
      end
      object Label1: TLabel
        Left = 133
        Top = 44
        Width = 12
        Height = 12
        Caption = '至'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
      end
      object Label3: TLabel
        Left = 133
        Top = 84
        Width = 12
        Height = 12
        Caption = '至'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
      end
      object Label10: TLabel
        Left = 133
        Top = 104
        Width = 12
        Height = 12
        Caption = '至'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
      end
      object Label12: TLabel
        Left = 133
        Top = 124
        Width = 12
        Height = 12
        Caption = '至'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
      end
      object Label14: TLabel
        Left = 133
        Top = 144
        Width = 12
        Height = 12
        Caption = '至'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
      end
      object LB_CON1: TLabel
        Left = 10
        Top = 21
        Width = 48
        Height = 12
        Caption = '会员编号'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
      end
      object LB_CON2: TLabel
        Left = 10
        Top = 41
        Width = 48
        Height = 12
        Caption = '中文姓名'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
      end
      object LB_CON3: TLabel
        Left = 10
        Top = 61
        Width = 48
        Height = 12
        Caption = '会员电话'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
      end
      object LB_CON4: TLabel
        Left = 10
        Top = 81
        Width = 48
        Height = 12
        Caption = '会员地址'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
      end
      object LB_CON7: TLabel
        Left = 10
        Top = 141
        Width = 48
        Height = 12
        Caption = '发卡日期'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
      end
      object LB_CON8: TLabel
        Left = 5
        Top = 165
        Width = 60
        Height = 12
        Caption = '最近交易日'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
      end
      object LB_CON6: TLabel
        Left = 10
        Top = 121
        Width = 48
        Height = 12
        Caption = '入会日期'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
      end
      object LB_CON5: TLabel
        Left = 10
        Top = 101
        Width = 48
        Height = 12
        Caption = '会员等级'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
      end
      object Label2: TLabel
        Left = 138
        Top = 164
        Width = 12
        Height = 12
        Caption = '至'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
      end
      object LB11: TJEdit
        Left = 65
        Top = 20
        Width = 65
        Height = 19
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        Digits = 1
        Max = 999999999
        _EditType = EDIT
        _SHOWCAL = NONE
        _BADINPUT = True
        _LONGTIME = False
      end
      object LB31: TJEdit
        Left = 65
        Top = 60
        Width = 65
        Height = 19
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        Digits = 1
        Max = 999999999
        _EditType = EDIT
        _SHOWCAL = NONE
        _BADINPUT = True
        _LONGTIME = False
      end
      object LB12: TJEdit
        Left = 150
        Top = 20
        Width = 65
        Height = 19
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        Digits = 1
        Max = 999999999
        _EditType = EDIT
        _SHOWCAL = NONE
        _BADINPUT = True
        _LONGTIME = False
      end
      object LB32: TJEdit
        Left = 150
        Top = 60
        Width = 65
        Height = 19
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        Digits = 1
        Max = 999999999
        _EditType = EDIT
        _SHOWCAL = NONE
        _BADINPUT = True
        _LONGTIME = False
      end
      object LB21: TJEdit
        Left = 65
        Top = 40
        Width = 65
        Height = 19
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        Digits = 1
        Max = 999999999
        _EditType = EDIT
        _SHOWCAL = NONE
        _BADINPUT = True
        _LONGTIME = False
      end
      object LB22: TJEdit
        Left = 150
        Top = 40
        Width = 65
        Height = 19
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        Digits = 1
        Max = 999999999
        _EditType = EDIT
        _SHOWCAL = NONE
        _BADINPUT = True
        _LONGTIME = False
      end
      object LB41: TJEdit
        Left = 65
        Top = 80
        Width = 65
        Height = 19
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        Digits = 1
        Max = 999999999
        _EditType = EDIT
        _SHOWCAL = NONE
        _BADINPUT = True
        _LONGTIME = False
      end
      object LB42: TJEdit
        Left = 150
        Top = 80
        Width = 65
        Height = 19
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
        Digits = 1
        Max = 999999999
        _EditType = EDIT
        _SHOWCAL = NONE
        _BADINPUT = True
        _LONGTIME = False
      end
      object LB51: TJEdit
        Left = 65
        Top = 100
        Width = 65
        Height = 19
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
        TabOrder = 8
        Digits = 1
        Max = 999999999
        _EditType = EDIT
        _SHOWCAL = NONE
        _BADINPUT = True
        _LONGTIME = False
      end
      object LB52: TJEdit
        Left = 150
        Top = 100
        Width = 65
        Height = 19
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
        TabOrder = 9
        Digits = 1
        Max = 999999999
        _EditType = EDIT
        _SHOWCAL = NONE
        _BADINPUT = True
        _LONGTIME = False
      end
      object LB61: TJEdit
        Left = 65
        Top = 120
        Width = 65
        Height = 19
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
        TabOrder = 10
        Digits = 1
        Max = 999999999
        _EditType = EDIT
        _SHOWCAL = NONE
        _BADINPUT = True
        _LONGTIME = False
      end
      object LB62: TJEdit
        Left = 150
        Top = 120
        Width = 65
        Height = 19
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
        TabOrder = 11
        Digits = 1
        Max = 999999999
        _EditType = EDIT
        _SHOWCAL = NONE
        _BADINPUT = True
        _LONGTIME = False
      end
      object LB71: TJEdit
        Left = 65
        Top = 140
        Width = 65
        Height = 19
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
        TabOrder = 12
        Digits = 1
        Max = 999999999
        _EditType = EDIT
        _SHOWCAL = NONE
        _BADINPUT = True
        _LONGTIME = False
      end
      object LB72: TJEdit
        Left = 150
        Top = 140
        Width = 65
        Height = 19
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
        TabOrder = 13
        Digits = 1
        Max = 999999999
        _EditType = EDIT
        _SHOWCAL = NONE
        _BADINPUT = True
        _LONGTIME = False
      end
      object BTNSER: TBitBtn
        Left = 26
        Top = 181
        Width = 79
        Height = 30
        Cursor = crHandPoint
        Caption = 'F5 查询'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
        TabOrder = 16
        OnClick = BTNSERClick
        Spacing = 1
      end
      object BTNCLR: TBitBtn
        Left = 119
        Top = 181
        Width = 80
        Height = 30
        Cursor = crHandPoint
        Caption = '清除'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
        TabOrder = 17
        OnClick = BTNCLRClick
        Spacing = 1
      end
      object LB81: TJEdit
        Left = 75
        Top = 160
        Width = 61
        Height = 19
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
        TabOrder = 14
        Digits = 1
        Max = 999999999
        _EditType = EDIT
        _SHOWCAL = NONE
        _BADINPUT = True
        _LONGTIME = False
      end
      object LB82: TJEdit
        Left = 150
        Top = 160
        Width = 65
        Height = 19
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
        TabOrder = 15
        Digits = 1
        Max = 999999999
        _EditType = EDIT
        _SHOWCAL = NONE
        _BADINPUT = True
        _LONGTIME = False
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 448
    Width = 564
    Height = 41
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Caption = ' '
    Color = cl3DLight
    TabOrder = 2
    object BTNQUT: TBitBtn
      Left = 483
      Top = 2
      Width = 73
      Height = 30
      Cursor = crHandPoint
      Caption = 'Ctrl+Q 结束'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = BTNQUTClick
    end
    object BTNCAL: TBitBtn
      Left = 209
      Top = 2
      Width = 60
      Height = 30
      Cursor = crHandPoint
      Caption = 'F4 取消'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = BTNCALClick
      Spacing = 1
    end
    object BTNYES: TBitBtn
      Left = 140
      Top = 2
      Width = 60
      Height = 30
      Cursor = crHandPoint
      Caption = 'F3 确定'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = BTNYESClick
      Spacing = 1
    end
    object BTNDEL: TBitBtn
      Left = 72
      Top = 2
      Width = 60
      Height = 30
      Cursor = crHandPoint
      Caption = 'F2 删除'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = BTNDELClick
      Spacing = 1
    end
    object BTNINS: TBitBtn
      Left = 3
      Top = 2
      Width = 60
      Height = 30
      Cursor = crHandPoint
      Caption = 'F1 新增'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = BTNINSClick
      Spacing = 1
    end
    object BTNPRN: TBitBtn
      Left = 414
      Top = 2
      Width = 60
      Height = 30
      Cursor = crHandPoint
      Caption = 'F8 打印'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      OnClick = BTNPRNClick
      Layout = blGlyphTop
      Spacing = 1
    end
    object BTNSET: TBitBtn
      Left = 277
      Top = 2
      Width = 60
      Height = 30
      Cursor = crHandPoint
      Caption = 'F7 设置'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      OnClick = BTNSETClick
      Spacing = 1
    end
    object BTNPRE: TBitBtn
      Left = 346
      Top = 2
      Width = 60
      Height = 30
      Cursor = crHandPoint
      Caption = 'F7 预览'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      OnClick = BTNPRNClick
      Layout = blGlyphTop
      Spacing = 1
    end
  end
  object MainMenu: TMainMenu
    Left = 269
    Top = 398
    object N1: TMenuItem
      Caption = '新增'
      ShortCut = 112
      Visible = False
      OnClick = BTNINSClick
    end
    object N2: TMenuItem
      Caption = '删除'
      ShortCut = 113
      Visible = False
      OnClick = BTNDELClick
    end
    object N3: TMenuItem
      Caption = '确定'
      ShortCut = 114
      Visible = False
      OnClick = BTNYESClick
    end
    object N4: TMenuItem
      Caption = '取消'
      ShortCut = 115
      Visible = False
      OnClick = BTNCALClick
    end
    object N6: TMenuItem
      Caption = '查询'
      ShortCut = 116
      Visible = False
      OnClick = BTNSERClick
    end
    object MENPRE: TMenuItem
      Caption = '预览'
      ShortCut = 118
      Visible = False
      OnClick = BTNPRNClick
    end
    object MENPRN: TMenuItem
      Caption = '打印'
      ShortCut = 119
      Visible = False
      OnClick = BTNPRNClick
    end
    object N5: TMenuItem
      Caption = '结束'
      ShortCut = 16465
      Visible = False
      OnClick = BTNQUTClick
    end
  end
end
