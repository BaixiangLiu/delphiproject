object frmMainGangWay: TfrmMainGangWay
  Left = 246
  Top = 136
  Width = 870
  Height = 500
  Caption = #22270#20070#39302#36890#36947#26426#20986#20837#35760#24405#26597#35810#24037#20855
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 14
  object StatusBar1: TStatusBar
    Left = 0
    Top = 454
    Width = 862
    Height = 19
    Panels = <
      item
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
  object gridResult: TRzDBGrid
    Left = 0
    Top = 121
    Width = 862
    Height = 333
    Align = alClient
    DataSource = OraDataSource1
    DefaultDrawing = True
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -14
    TitleFont.Name = #23435#20307
    TitleFont.Style = []
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 862
    Height = 121
    Align = alTop
    Caption = #21151#33021#25805#20316#21306
    TabOrder = 2
    object Label1: TLabel
      Left = 24
      Top = 32
      Width = 56
      Height = 14
      Caption = #24320#22987#26085#26399
    end
    object Label2: TLabel
      Left = 24
      Top = 64
      Width = 56
      Height = 14
      Caption = #32467#26463#26085#26399
    end
    object Label3: TLabel
      Left = 253
      Top = 32
      Width = 42
      Height = 14
      Caption = #36890#36947#26426
    end
    object Label4: TLabel
      Left = 267
      Top = 64
      Width = 28
      Height = 14
      Caption = #22995#21517
    end
    object btnQuery: TBitBtn
      Left = 28
      Top = 90
      Width = 89
      Height = 25
      Caption = '&S '#26597#35810
      TabOrder = 0
      OnClick = btnQueryClick
      Kind = bkAll
    end
    object dtBegin: TRzDateTimeEdit
      Left = 98
      Top = 27
      Width = 120
      Height = 22
      EditType = etDate
      TabOrder = 1
    end
    object dtEnd: TRzDateTimeEdit
      Left = 98
      Top = 56
      Width = 121
      Height = 22
      EditType = etDate
      TabOrder = 2
    end
    object cbDev: TRzComboBox
      Left = 309
      Top = 27
      Width = 145
      Height = 22
      Style = csDropDownList
      DragMode = dmAutomatic
      ItemHeight = 14
      TabOrder = 3
      Text = '-'
      Items.Strings = (
        '-'
        '59310'
        '59332'
        '59333'
        '59357'
        '59373'
        '59469')
      ItemIndex = 0
    end
    object edtName: TRzEdit
      Left = 309
      Top = 57
      Width = 145
      Height = 22
      TabOrder = 4
    end
    object btnReport: TBitBtn
      Left = 141
      Top = 89
      Width = 89
      Height = 25
      Caption = '&C '#32479#35745
      TabOrder = 5
      OnClick = btnReportClick
      Kind = bkIgnore
    end
    object btnExport: TBitBtn
      Left = 261
      Top = 88
      Width = 89
      Height = 25
      Caption = '&E '#23548#20986
      TabOrder = 6
      OnClick = btnExportClick
      Kind = bkRetry
    end
    object Memo1: TMemo
      Left = 480
      Top = 24
      Width = 185
      Height = 57
      TabOrder = 7
      Visible = False
    end
  end
  object OraSession1: TOraSession
    Options.Direct = True
    Username = 'ykt_cur'
    Password = 'kingstar'
    Server = '192.168.3.254:1521:hrxy'
    Left = 448
    Top = 208
  end
  object OraQuery1: TOraQuery
    Session = OraSession1
    FetchAll = True
    Left = 448
    Top = 256
  end
  object OraDataSource1: TOraDataSource
    DataSet = OraQuery1
    Left = 448
    Top = 304
  end
end
