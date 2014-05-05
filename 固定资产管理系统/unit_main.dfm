object frm_main: Tfrm_main
  Left = 170
  Top = 154
  Width = 804
  Height = 491
  Caption = #19977#25152#22266#23450#36164#20135#31649#29702#31995#32479
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #26999#20307'_GB2312'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object CoolBar1: TCoolBar
    Left = 0
    Top = 0
    Width = 796
    Height = 57
    Bands = <
      item
        Control = ToolBar1
        ImageIndex = -1
        MinHeight = 43
        Width = 792
      end>
    object ToolBar1: TToolBar
      Left = 9
      Top = 0
      Width = 779
      Height = 43
      AutoSize = True
      ButtonHeight = 39
      ButtonWidth = 84
      Caption = 'ToolBar1'
      TabOrder = 0
      object Button1: TButton
        Left = 0
        Top = 2
        Width = 75
        Height = 39
        Caption = #30331#35760'(&C)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = Button1Click
      end
      object Button2: TButton
        Left = 75
        Top = 2
        Width = 75
        Height = 39
        Caption = #27983#35272'(&B)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnClick = Button2Click
      end
      object Button3: TButton
        Left = 150
        Top = 2
        Width = 75
        Height = 39
        Caption = #26597#35810'(&S)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnClick = Button3Click
      end
      object Button4: TButton
        Left = 225
        Top = 2
        Width = 75
        Height = 39
        Caption = #32479#35745'(&T)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        OnClick = Button4Click
      end
      object Button5: TButton
        Left = 300
        Top = 2
        Width = 75
        Height = 39
        Caption = #25253#34920'(&R)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        OnClick = Button5Click
      end
      object Button6: TButton
        Left = 375
        Top = 2
        Width = 75
        Height = 39
        Caption = #36864#20986'(&X)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        OnClick = Button6Click
      end
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 411
    Width = 793
    Height = 34
    Align = alNone
    Panels = <
      item
        Text = '  '#29256#26435':'#20013#22269#26680#21160#21147#30740#31350#35774#35745#38498#19977#25152
        Width = 200
      end
      item
        Width = 200
      end
      item
        Width = 200
      end
      item
        Width = 50
      end>
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 56
    Width = 793
    Height = 329
    DataSource = DataSource1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #26999#20307'_GB2312'
    Font.Style = []
    ImeMode = imClose
    ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
    ParentFont = False
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = #21326#25991#20013#23435
    TitleFont.Style = []
  end
  object DBNavigator1: TDBNavigator
    Left = 0
    Top = 384
    Width = 790
    Height = 25
    DataSource = DataSource1
    TabOrder = 3
  end
  object MainMenu1: TMainMenu
    Left = 32
    Top = 104
    object f1: TMenuItem
      Caption = #25991#20214'(&F)'
      object N1: TMenuItem
        Caption = #20445#23384#20462#25913
        OnClick = N1Click
      end
      object N10: TMenuItem
        Caption = #25968#25454#24211#20445#23384
        OnClick = N10Click
      end
      object X1: TMenuItem
        Caption = #36864#20986'(&X)'
        OnClick = X1Click
      end
    end
    object I1: TMenuItem
      Caption = #30331#35760'(&I)'
      object N2: TMenuItem
        Caption = #26032#22686#36164#20135
        OnClick = N2Click
      end
      object N9: TMenuItem
        Caption = #36164#20135#31649#29702
        OnClick = N9Click
      end
    end
    object V1: TMenuItem
      Caption = #27983#35272'(&V)'
      object N3: TMenuItem
        Caption = #20840#37096#27983#35272
        OnClick = N3Click
      end
    end
    object S1: TMenuItem
      Caption = #26597#35810'(&S)'
      object N5: TMenuItem
        Caption = #26465#20214#26597#35810
        OnClick = N5Click
      end
      object N6: TMenuItem
        Caption = #33258#30001#26597#35810
        OnClick = N6Click
      end
    end
    object I2: TMenuItem
      Caption = #32479#35745'(I)'
      object N7: TMenuItem
        Caption = #24635#36164#20135#32479#35745
        OnClick = N7Click
      end
    end
    object N4: TMenuItem
      Caption = #25253#34920'(&R)'
      object N8: TMenuItem
        Caption = #36164#20135#26126#26224#34920
        OnClick = N8Click
      end
    end
  end
  object timer_update: TTimer
    Enabled = False
    OnTimer = timer_updateTimer
    Left = 32
    Top = 136
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 500
    OnTimer = Timer1Timer
    Left = 32
    Top = 200
  end
  object ADOConnection1: TADOConnection
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 32
    Top = 224
  end
  object ADOTable1: TADOTable
    Connection = ADOConnection1
    CursorType = ctStatic
    TableName = 'capital'
    Left = 32
    Top = 256
  end
  object DataSource1: TDataSource
    DataSet = ADOTable1
    Left = 32
    Top = 280
  end
  object SaveDialog1: TSaveDialog
    Filter = '*.mdb|mdb'
    Left = 32
    Top = 168
  end
end
