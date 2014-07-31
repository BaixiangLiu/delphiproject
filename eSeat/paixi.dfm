object frmpaixi: Tfrmpaixi
  Left = 169
  Top = 15
  Width = 762
  Height = 725
  Caption = #24109#20301#23433#25490
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel7: TPanel
    Left = 0
    Top = 0
    Width = 754
    Height = 655
    Align = alClient
    BevelOuter = bvNone
    Caption = 'Panel7'
    TabOrder = 0
    object Panel1: TPanel
      Left = 0
      Top = 0
      Width = 529
      Height = 655
      Align = alLeft
      TabOrder = 0
      object GroupBox1: TGroupBox
        Left = 8
        Top = 8
        Width = 513
        Height = 209
        Caption = #39046#23548#21306
        TabOrder = 0
      end
      object GroupBox2: TGroupBox
        Left = 8
        Top = 256
        Width = 513
        Height = 369
        Caption = #38750#39046#23548#21306
        TabOrder = 1
      end
    end
    object Panel2: TPanel
      Left = 529
      Top = 0
      Width = 225
      Height = 655
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 225
        Height = 249
        Align = alTop
        BevelOuter = bvNone
        BorderWidth = 7
        Color = clSilver
        TabOrder = 0
        object dxDBGrid1: TdxDBGrid
          Left = 7
          Top = 32
          Width = 211
          Height = 210
          Bands = <
            item
            end>
          DefaultLayout = True
          HeaderPanelRowCount = 1
          KeyField = 'peopleid'
          SummaryGroups = <>
          SummarySeparator = ', '
          Align = alClient
          DragMode = dmAutomatic
          TabOrder = 0
          OnDragOver = dxDBGrid1DragOver
          DataSource = dmseat.ds_leaderpeople
          Filter.Criteria = {00000000}
          LookAndFeel = lfFlat
          OptionsDB = [edgoCancelOnExit, edgoCanDelete, edgoCanInsert, edgoCanNavigation, edgoConfirmDelete, edgoLoadAllRecords, edgoUseBookmarks]
          OptionsView = [edgoBandHeaderWidth, edgoIndicator, edgoRowSelect, edgoUseBitmap]
          object dxDBGrid1Column1: TdxDBGridMaskColumn
            Caption = #21442#20250#20154#21592
            ReadOnly = True
            Width = 85
            BandIndex = 0
            RowIndex = 0
            FieldName = 'name'
          end
          object dxDBGrid1Column2: TdxDBGridMaskColumn
            Caption = #26174#31034#21517#31216
            ReadOnly = True
            Width = 84
            BandIndex = 0
            RowIndex = 0
            FieldName = 'displayname'
          end
          object dxDBGrid1Column3: TdxDBGridMaskColumn
            Visible = False
            BandIndex = 0
            RowIndex = 0
            FieldName = 'peopleid'
          end
        end
        object Panel4: TPanel
          Left = 7
          Top = 7
          Width = 211
          Height = 25
          Align = alTop
          BevelOuter = bvNone
          Caption = #39046#23548#21306#26410#23433#25490#24109#20301#21442#20250#20154#21592
          TabOrder = 1
        end
      end
      object Panel5: TPanel
        Left = 0
        Top = 249
        Width = 225
        Height = 406
        Align = alClient
        BevelOuter = bvNone
        BorderWidth = 7
        Color = clSilver
        TabOrder = 1
        object Panel6: TPanel
          Left = 7
          Top = 7
          Width = 211
          Height = 25
          Align = alTop
          BevelOuter = bvNone
          Caption = #26222#36890#21306#26410#23433#25490#24109#20301#21442#20250#20154#21592
          TabOrder = 0
        end
        object dxDBGrid2: TdxDBGrid
          Left = 7
          Top = 32
          Width = 211
          Height = 367
          Bands = <
            item
            end>
          DefaultLayout = True
          HeaderPanelRowCount = 1
          KeyField = 'peopleid'
          SummaryGroups = <>
          SummarySeparator = ', '
          Align = alClient
          DragMode = dmAutomatic
          TabOrder = 1
          DataSource = dmseat.ds_cancelpeople
          Filter.Criteria = {00000000}
          LookAndFeel = lfFlat
          OptionsDB = [edgoCancelOnExit, edgoCanDelete, edgoCanInsert, edgoCanNavigation, edgoConfirmDelete, edgoLoadAllRecords, edgoUseBookmarks]
          OptionsView = [edgoBandHeaderWidth, edgoIndicator, edgoRowSelect, edgoUseBitmap]
          object dxDBGrid2Column1: TdxDBGridMaskColumn
            Caption = #21442#20250#20154#21592
            ReadOnly = True
            Width = 99
            BandIndex = 0
            RowIndex = 0
            FieldName = 'name'
          end
          object dxDBGrid2Column2: TdxDBGridMaskColumn
            Caption = #26174#31034#21517#31216
            ReadOnly = True
            Width = 87
            BandIndex = 0
            RowIndex = 0
            FieldName = 'displayname'
          end
          object dxDBGrid2Column3: TdxDBGridMaskColumn
            Visible = False
            BandIndex = 0
            RowIndex = 0
            FieldName = 'peopleid'
          end
        end
      end
    end
  end
  object Panel8: TPanel
    Left = 0
    Top = 655
    Width = 754
    Height = 41
    Align = alBottom
    TabOrder = 1
    object BitBtn1: TBitBtn
      Left = 344
      Top = 8
      Width = 75
      Height = 25
      Caption = #25171#21360
      TabOrder = 0
      OnClick = BitBtn1Click
    end
  end
  object ExcelApplication1: TExcelApplication
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    AutoQuit = False
    Left = 112
    Top = 632
  end
  object ExcelWorkbook1: TExcelWorkbook
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    Left = 160
    Top = 640
  end
  object ExcelWorksheet1: TExcelWorksheet
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    Left = 208
    Top = 648
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = '.xls'
    Filter = '.xls|.xls'
    Left = 256
    Top = 640
  end
end
