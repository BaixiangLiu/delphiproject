object FMPOSN: TFMPOSN
  Left = 35
  Top = 118
  AutoScroll = False
  Caption = '��ϲ�Ʒ��Ϣ'
  ClientHeight = 383
  ClientWidth = 742
  Color = 15648684
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = '����'
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
    Top = 364
    Width = 742
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
    Width = 617
    Height = 364
    Align = alClient
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Caption = ' '
    Color = 16766935
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = '����'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 1
    object LBBGEN1: TLabel
      Left = 5
      Top = 4
      Width = 39
      Height = 13
      Caption = '��Ʒһ'
    end
    object LBBGEN2: TLabel
      Left = 5
      Top = 27
      Width = 39
      Height = 13
      Caption = '��Ʒ��'
    end
    object LBPNPR1: TLabel
      Left = 255
      Top = 8
      Width = 33
      Height = 13
      Caption = '�۸�1'
    end
    object LBPNPR2: TLabel
      Left = 255
      Top = 28
      Width = 33
      Height = 13
      Caption = '�۸�2'
    end
    object LBPNDT1: TLabel
      Left = 5
      Top = 48
      Width = 39
      Height = 13
      Caption = '��ʼ��'
    end
    object LBPNDT2: TLabel
      Left = 5
      Top = 68
      Width = 39
      Height = 13
      Caption = '������'
    end
    object LBPNDAT: TLabel
      Left = 5
      Top = 88
      Width = 39
      Height = 13
      Caption = '������'
    end
    object GroupBox1: TGroupBox
      Left = 393
      Top = 5
      Width = 220
      Height = 111
      Caption = '���ٲ�ѯ'
      Ctl3D = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = '����'
      Font.Style = []
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 7
      object LB1: TLabel
        Left = 4
        Top = 20
        Width = 60
        Height = 12
        Caption = '��Ʒ������'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = '����'
        Font.Style = []
        ParentFont = False
      end
      object LB2: TLabel
        Left = 4
        Top = 40
        Width = 60
        Height = 12
        Caption = '��  ʼ  ��'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = '����'
        Font.Style = []
        ParentFont = False
      end
      object LB3: TLabel
        Left = 4
        Top = 60
        Width = 60
        Height = 12
        Caption = '��  ��  ��'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = '����'
        Font.Style = []
        ParentFont = False
      end
      object Label7: TLabel
        Left = 133
        Top = 19
        Width = 13
        Height = 13
        Caption = '��'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = '����'
        Font.Style = []
        ParentFont = False
      end
      object Label9: TLabel
        Left = 133
        Top = 59
        Width = 13
        Height = 13
        Caption = '��'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = '����'
        Font.Style = []
        ParentFont = False
      end
      object Label1: TLabel
        Left = 133
        Top = 39
        Width = 13
        Height = 13
        Caption = '��'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = '����'
        Font.Style = []
        ParentFont = False
      end
      object LB11: TJEdit
        Left = 65
        Top = 15
        Width = 65
        Height = 19
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = '����'
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
        Top = 55
        Width = 65
        Height = 19
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = '����'
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
        Top = 15
        Width = 65
        Height = 19
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = '����'
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
        Top = 55
        Width = 65
        Height = 19
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = '����'
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
        Top = 35
        Width = 65
        Height = 19
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = '����'
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
        Top = 35
        Width = 65
        Height = 19
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = '����'
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
      object BTNSER: TBitBtn
        Left = 10
        Top = 76
        Width = 120
        Height = 30
        Cursor = crHandPoint
        Caption = 'F5 ��ѯ'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = '����'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        OnClick = BTNSERClick
        Spacing = 1
      end
      object BTNCLR: TBitBtn
        Left = 135
        Top = 76
        Width = 80
        Height = 30
        Cursor = crHandPoint
        Caption = '���'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = '����'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
        OnClick = BTNCLRClick
        Spacing = 1
      end
    end
    object PNPR1: TDBEdit
      Left = 295
      Top = 5
      Width = 60
      Height = 19
      DataField = 'PNPR1'
      DataSource = FMPOSND.DSPOSN
      TabOrder = 1
    end
    object PNPR2: TDBEdit
      Left = 295
      Top = 25
      Width = 60
      Height = 19
      DataField = 'PNPR2'
      DataSource = FMPOSND.DSPOSN
      TabOrder = 3
    end
    object BGEN2: JDBLOOKUPBOX
      Left = 45
      Top = 25
      Width = 200
      Height = 19
      DataField = 'BGEN2'
      DataSource = FMPOSND.DSPOSN
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
    object BGEN1: JDBLOOKUPBOX
      Left = 45
      Top = 5
      Width = 200
      Height = 19
      DataField = 'BGEN1'
      DataSource = FMPOSND.DSPOSN
      MaxLength = 20
      TabOrder = 0
      _DatabaseName = 'MAIN'
      _TableName = 'BGDS'
      _Field_IDNO = 'BGENO'
      _Field_NAME = 'BGNAM'
      _EDIT_WIDTH = 100
      _CHANGE_QUERY = True
      _INSERT_RECORD = False
      _SHOW_MESSAGE = False
    end
    object PNDT1: TJDBEdit
      Left = 45
      Top = 45
      Width = 80
      Height = 19
      DataField = 'PNDT1'
      DataSource = FMPOSND.DSPOSN
      TabOrder = 4
      _EditType = EDATE_EDIT
      _SHOWCAL = NONE
    end
    object PNDT2: TJDBEdit
      Left = 45
      Top = 65
      Width = 80
      Height = 19
      DataField = 'PNDT2'
      DataSource = FMPOSND.DSPOSN
      TabOrder = 5
      _EditType = EDATE_EDIT
      _SHOWCAL = NONE
    end
    object PNDAT: TJDBEdit
      Left = 45
      Top = 85
      Width = 80
      Height = 19
      DataField = 'PNDAT'
      DataSource = FMPOSND.DSPOSN
      TabOrder = 6
      _EditType = EDATE_EDIT
      _SHOWCAL = NONE
    end
    object DBGrid: TDBGrid
      Left = 1
      Top = 120
      Width = 611
      Height = 241
      DataSource = FMPOSND.DSPOSN
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = '����'
      Font.Style = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      ParentFont = False
      TabOrder = 8
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -13
      TitleFont.Name = '����'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'BGEN1'
          Title.Alignment = taCenter
          Title.Caption = '��Ʒ������1'
          Title.Color = clInfoBk
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = '_BGNAM1'
          Title.Alignment = taCenter
          Title.Caption = '��Ʒ����1'
          Title.Color = clInfoBk
          Width = 90
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'BGEN2'
          Title.Alignment = taCenter
          Title.Caption = '��Ʒ������2'
          Title.Color = clInfoBk
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = '_BGNAM2'
          Title.Alignment = taCenter
          Title.Caption = '��Ʒ����2'
          Title.Color = clInfoBk
          Width = 90
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PNPR1'
          Title.Alignment = taCenter
          Title.Caption = '�۸�1'
          Title.Color = clInfoBk
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PNPR2'
          Title.Alignment = taCenter
          Title.Caption = '�۸�2'
          Title.Color = clInfoBk
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PNDT1'
          Title.Alignment = taCenter
          Title.Caption = '��ʼ��'
          Title.Color = clInfoBk
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PNDT2'
          Title.Alignment = taCenter
          Title.Caption = '������'
          Title.Color = clInfoBk
          Width = 60
          Visible = True
        end>
    end
  end
  object Panel1: TPanel
    Left = 617
    Top = 0
    Width = 125
    Height = 364
    Align = alRight
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Caption = ' '
    Color = clBlack
    TabOrder = 2
    object BTNQUT: TBitBtn
      Left = 0
      Top = 310
      Width = 120
      Height = 50
      Cursor = crHandPoint
      Caption = 'Ctrl+Q ����'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = '����'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = BTNQUTClick
    end
    object BTNCAL: TBitBtn
      Left = 0
      Top = 150
      Width = 120
      Height = 50
      Cursor = crHandPoint
      Caption = 'F4 ȡ��'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = '����'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = BTNCALClick
      Spacing = 1
    end
    object BTNYES: TBitBtn
      Left = 0
      Top = 100
      Width = 120
      Height = 50
      Cursor = crHandPoint
      Caption = 'F3 ȷ��'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = '����'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = BTNYESClick
      Spacing = 1
    end
    object BTNDEL: TBitBtn
      Left = 0
      Top = 50
      Width = 120
      Height = 50
      Cursor = crHandPoint
      Caption = 'F2 ɾ��'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = '����'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = BTNDELClick
      Spacing = 1
    end
    object BTNINS: TBitBtn
      Left = 0
      Top = 0
      Width = 120
      Height = 50
      Cursor = crHandPoint
      Caption = 'F1 ����'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = '����'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = BTNINSClick
      Spacing = 1
    end
    object BTNPRN: TBitBtn
      Left = 0
      Top = 260
      Width = 120
      Height = 50
      Cursor = crHandPoint
      Caption = 'F8 ��ӡ'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = '����'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      OnClick = BTNPRNClick
      Spacing = 1
    end
    object BTNPRE: TBitBtn
      Left = 0
      Top = 210
      Width = 120
      Height = 50
      Cursor = crHandPoint
      Caption = 'F7 Ԥ��'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = '����'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      OnClick = BTNPRNClick
      Spacing = 1
    end
  end
  object MainMenu: TMainMenu
    Left = 556
    Top = 6
    object N1: TMenuItem
      Caption = '����'
      ShortCut = 112
      Visible = False
      OnClick = BTNINSClick
    end
    object N2: TMenuItem
      Caption = 'ɾ��'
      ShortCut = 113
      Visible = False
      OnClick = BTNDELClick
    end
    object N3: TMenuItem
      Caption = 'ȷ��'
      ShortCut = 114
      Visible = False
      OnClick = BTNYESClick
    end
    object N4: TMenuItem
      Caption = 'ȡ��'
      ShortCut = 115
      Visible = False
      OnClick = BTNCALClick
    end
    object N6: TMenuItem
      Caption = '��ѯ'
      ShortCut = 116
      Visible = False
      OnClick = BTNSERClick
    end
    object MENPRE: TMenuItem
      Caption = 'Ԥ��'
      ShortCut = 118
      Visible = False
      OnClick = BTNPRNClick
    end
    object MENPRN: TMenuItem
      Caption = '��ӡ'
      ShortCut = 119
      Visible = False
      OnClick = BTNPRNClick
    end
    object N5: TMenuItem
      Caption = '����'
      ShortCut = 16465
      Visible = False
      OnClick = BTNQUTClick
    end
  end
end
