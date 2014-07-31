object frmhuiyi: Tfrmhuiyi
  Left = 226
  Top = 158
  Width = 603
  Height = 522
  Caption = ' '
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object Panel1: TPanel
    Left = 0
    Top = 65
    Width = 595
    Height = 428
    Align = alClient
    TabOrder = 0
    object Splitter1: TSplitter
      Left = 1
      Top = 249
      Width = 593
      Height = 2
      Cursor = crVSplit
      Align = alTop
    end
    object Panel4: TPanel
      Left = 1
      Top = 1
      Width = 593
      Height = 248
      Align = alTop
      TabOrder = 0
      object Panel2: TPanel
        Left = 488
        Top = 1
        Width = 104
        Height = 246
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 0
        object BitBtn1: TBitBtn
          Left = 16
          Top = 16
          Width = 75
          Height = 25
          Caption = #22686#21152
          TabOrder = 0
          OnClick = BitBtn1Click
        end
        object BitBtn3: TBitBtn
          Left = 16
          Top = 80
          Width = 75
          Height = 25
          Caption = #21462#28040
          TabOrder = 1
          OnClick = BitBtn3Click
        end
        object BitBtn6: TBitBtn
          Left = 16
          Top = 112
          Width = 75
          Height = 25
          Caption = #25490#24109
          TabOrder = 2
          OnClick = BitBtn6Click
        end
      end
      object dxDBGrid1: TdxDBGrid
        Left = 1
        Top = 1
        Width = 487
        Height = 246
        Bands = <
          item
          end>
        DefaultLayout = True
        HeaderPanelRowCount = 1
        KeyField = 'id'
        SummaryGroups = <>
        SummarySeparator = ', '
        Align = alClient
        TabOrder = 1
        DataSource = dmseat.ds_meeting
        Filter.Criteria = {00000000}
        LookAndFeel = lfFlat
        OptionsDB = [edgoCancelOnExit, edgoCanDelete, edgoCanInsert, edgoCanNavigation, edgoConfirmDelete, edgoLoadAllRecords, edgoUseBookmarks]
        OptionsView = [edgoBandHeaderWidth, edgoIndicator, edgoRowSelect, edgoUseBitmap]
        OnChangeNode = dxDBGrid1ChangeNode
        object dxDBGrid1Column1: TdxDBGridMaskColumn
          Caption = #20250#35758#21517#31216
          Width = 146
          BandIndex = 0
          RowIndex = 0
          FieldName = 'name'
        end
        object dxDBGrid1Column2: TdxDBGridMaskColumn
          Caption = #20250#35758#21517#31216#32553#20889
          Width = 82
          BandIndex = 0
          RowIndex = 0
          FieldName = 'name_py'
        end
        object dxDBGrid1Column7: TdxDBGridDateColumn
          Caption = #21484#24320#26085#26399
          BandIndex = 0
          RowIndex = 0
          FieldName = 'opendate'
        end
        object dxDBGrid1Column8: TdxDBGridTimeColumn
          Caption = #21484#24320#26102#38388
          BandIndex = 0
          RowIndex = 0
          FieldName = 'opentime'
        end
        object dxDBGrid1Column3: TdxDBGridMaskColumn
          Caption = #21442#21152#20250#35758#20154#25968
          Width = 78
          BandIndex = 0
          RowIndex = 0
          FieldName = 'capacity'
        end
        object dxDBGrid1Column4: TdxDBGridMaskColumn
          Caption = #39046#23548#20154#25968
          Width = 54
          BandIndex = 0
          RowIndex = 0
          FieldName = 'leader'
        end
        object dxDBGrid1Column5: TdxDBGridMaskColumn
          Caption = #20250#22330#23433#25490
          Width = 54
          BandIndex = 0
          RowIndex = 0
          FieldName = 'meetingroom'
        end
        object dxDBGrid1Column6: TdxDBGridMaskColumn
          Caption = #29366#24577
          Width = 47
          BandIndex = 0
          RowIndex = 0
          FieldName = 'status_ex'
        end
      end
    end
    object PageControl1: TPageControl
      Left = 1
      Top = 251
      Width = 593
      Height = 176
      ActivePage = TabSheet1
      Align = alClient
      TabIndex = 0
      TabOrder = 1
      OnChange = PageControl1Change
      object TabSheet1: TTabSheet
        Caption = #20250#35758#20449#24687
        object Panel6: TPanel
          Left = 0
          Top = 108
          Width = 585
          Height = 41
          Align = alBottom
          BevelOuter = bvLowered
          TabOrder = 0
          object BitBtn9: TBitBtn
            Left = 472
            Top = 8
            Width = 75
            Height = 25
            Caption = #20445#23384
            TabOrder = 0
            OnClick = BitBtn9Click
          end
        end
        object Panel7: TPanel
          Left = 0
          Top = 0
          Width = 585
          Height = 108
          Align = alClient
          BevelOuter = bvLowered
          TabOrder = 1
          object Label1: TLabel
            Left = 16
            Top = 16
            Width = 48
            Height = 12
            Caption = #20250#35758#21517#31216
          end
          object Label2: TLabel
            Left = 397
            Top = 16
            Width = 72
            Height = 12
            Caption = #20250#35758#21517#31216#32553#20889
          end
          object Label3: TLabel
            Left = 16
            Top = 48
            Width = 48
            Height = 12
            Caption = #21484#24320#26085#26399
          end
          object Label4: TLabel
            Left = 200
            Top = 48
            Width = 48
            Height = 12
            Caption = #21484#24320#26102#38388
          end
          object Label5: TLabel
            Left = 200
            Top = 80
            Width = 72
            Height = 12
            Caption = #21442#21152#20250#35758#20154#25968
          end
          object Label6: TLabel
            Left = 397
            Top = 80
            Width = 48
            Height = 12
            Caption = #39046#23548#20154#25968
          end
          object Label7: TLabel
            Left = 397
            Top = 48
            Width = 48
            Height = 12
            Caption = #20250#22330#23433#25490
          end
          object Label8: TLabel
            Left = 16
            Top = 80
            Width = 24
            Height = 12
            Caption = #29366#24577
          end
          object dxDBEdit1: TdxDBEdit
            Left = 80
            Top = 12
            Width = 305
            TabOrder = 0
            DataField = 'name'
            DataSource = dmseat.ds_meeting
          end
          object dxDBEdit2: TdxDBEdit
            Left = 485
            Top = 12
            Width = 89
            TabOrder = 1
            DataField = 'name_py'
            DataSource = dmseat.ds_meeting
          end
          object dxDBDateEdit1: TdxDBDateEdit
            Left = 80
            Top = 44
            Width = 89
            TabOrder = 2
            DataField = 'opendate'
            DataSource = dmseat.ds_meeting
          end
          object dxDBButtonEdit1: TdxDBButtonEdit
            Left = 485
            Top = 44
            Width = 89
            TabOrder = 3
            DataField = 'meetingroom'
            DataSource = dmseat.ds_meeting
            ReadOnly = True
            Buttons = <
              item
                Default = True
              end>
            OnButtonClick = dxDBButtonEdit1ButtonClick
            StoredValues = 64
            ExistButtons = True
          end
          object dxDBImageEdit1: TdxDBImageEdit
            Left = 80
            Top = 76
            Width = 89
            TabOrder = 4
            DataField = 'status_ex'
            DataSource = dmseat.ds_meeting
            OnChange = dxDBImageEdit1Change
          end
          object dxDBMaskEdit1: TdxDBMaskEdit
            Left = 263
            Top = 44
            Width = 121
            Style.BorderStyle = xbs3D
            Style.ButtonStyle = btsDefault
            TabOrder = 5
            DataField = 'opentime'
            DataSource = dmseat.ds_meeting
            EditMask = '!90:00;1;_'
            IgnoreMaskBlank = False
            StoredValues = 4
          end
          object dxDBSpinEdit1: TdxDBSpinEdit
            Left = 288
            Top = 76
            Width = 97
            TabOrder = 6
            DataField = 'capacity'
            DataSource = dmseat.ds_meeting
          end
          object dxDBSpinEdit2: TdxDBSpinEdit
            Left = 485
            Top = 76
            Width = 89
            TabOrder = 7
            DataField = 'leader'
            DataSource = dmseat.ds_meeting
          end
        end
      end
      object TabSheet2: TTabSheet
        Caption = #21442#20250#20154#21592
        ImageIndex = 1
        object dxDBGrid2: TdxDBGrid
          Left = 0
          Top = 0
          Width = 585
          Height = 108
          Bands = <
            item
            end>
          DefaultLayout = True
          HeaderPanelRowCount = 1
          KeyField = 'id'
          SummaryGroups = <>
          SummarySeparator = ', '
          Align = alClient
          TabOrder = 0
          DataSource = dmseat.ds_meeting_people
          Filter.Criteria = {00000000}
          LookAndFeel = lfFlat
          OptionsDB = [edgoCancelOnExit, edgoCanDelete, edgoCanInsert, edgoCanNavigation, edgoConfirmDelete, edgoLoadAllRecords, edgoUseBookmarks]
          OptionsView = [edgoBandHeaderWidth, edgoIndicator, edgoUseBitmap]
          OnChangeNode = dxDBGrid2ChangeNode
          object dxDBGrid2Column1: TdxDBGridMaskColumn
            Caption = #20154#21592#21517#31216
            Width = 100
            BandIndex = 0
            RowIndex = 0
            FieldName = 'peoplename'
          end
          object dxDBGrid2Column4: TdxDBGridMaskColumn
            Caption = #26174#31034#21517#31216
            Width = 79
            BandIndex = 0
            RowIndex = 0
            FieldName = 'displayname'
          end
          object dxDBGrid2Column2: TdxDBGridMaskColumn
            Caption = #29366#24577
            Width = 94
            BandIndex = 0
            RowIndex = 0
            FieldName = 'status_ex'
          end
          object dxDBGrid2Column3: TdxDBGridPickColumn
            Caption = #21306#22495
            Width = 126
            BandIndex = 0
            RowIndex = 0
            FieldName = 'area'
            Items.Strings = (
              #39046#23548#21306
              #26222#36890#21306)
            ImmediateDropDown = False
          end
        end
        object Panel5: TPanel
          Left = 0
          Top = 108
          Width = 585
          Height = 41
          Align = alBottom
          BevelOuter = bvLowered
          TabOrder = 1
          object BitBtn4: TBitBtn
            Left = 329
            Top = 9
            Width = 75
            Height = 25
            Caption = #22686#21152
            TabOrder = 0
            OnClick = BitBtn4Click
          end
          object BitBtn5: TBitBtn
            Left = 495
            Top = 8
            Width = 75
            Height = 25
            Caption = #21024#38500
            TabOrder = 1
            OnClick = BitBtn5Click
          end
          object BitBtn2: TBitBtn
            Left = 412
            Top = 9
            Width = 75
            Height = 25
            Caption = #20445#23384
            TabOrder = 2
            OnClick = BitBtn2Click
          end
          object BitBtn10: TBitBtn
            Left = 24
            Top = 8
            Width = 75
            Height = 25
            Caption = #25171#21360#24109#21345
            TabOrder = 3
            OnClick = BitBtn10Click
          end
        end
      end
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 595
    Height = 65
    Align = alTop
    TabOrder = 1
    object Label9: TLabel
      Left = 24
      Top = 16
      Width = 60
      Height = 12
      Caption = #20250#35758#21517#31216#65306
    end
    object Label10: TLabel
      Left = 24
      Top = 40
      Width = 60
      Height = 12
      Caption = #21484#24320#26085#26399#65306
    end
    object Label11: TLabel
      Left = 176
      Top = 38
      Width = 12
      Height = 12
      Caption = #33267
    end
    object Label12: TLabel
      Left = 224
      Top = 16
      Width = 36
      Height = 12
      Caption = #29366#24577#65306
    end
    object dxEdit1: TdxEdit
      Left = 88
      Top = 10
      Width = 121
      TabOrder = 0
    end
    object dxDateEdit1: TdxDateEdit
      Left = 88
      Top = 34
      Width = 81
      TabOrder = 1
      Date = -700000
    end
    object dxDateEdit2: TdxDateEdit
      Left = 192
      Top = 34
      Width = 81
      TabOrder = 2
      Date = -700000
    end
    object BitBtn7: TBitBtn
      Left = 416
      Top = 32
      Width = 75
      Height = 25
      Caption = #26597#35810
      TabOrder = 3
      OnClick = BitBtn7Click
    end
    object BitBtn8: TBitBtn
      Left = 504
      Top = 32
      Width = 75
      Height = 25
      Caption = #37325#26032#26597#35810
      TabOrder = 4
      OnClick = BitBtn8Click
    end
    object dxImageEdit1: TdxImageEdit
      Left = 280
      Top = 8
      Width = 121
      TabOrder = 5
    end
  end
  object RMReport1: TRMReport
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbPageSetup, pbExit, pbSaveToXLS]
    DefaultCopies = 0
    DefaultCollate = False
    SaveReportOptions.RegistryPath = 'ReportMachine\ReportSettings\'
    Left = 200
    Top = 208
    ReportData = {}
  end
  object RMDBDataSet1: TRMDBDataSet
    DataSet = dmseat.aq_meeting_people
    Left = 312
    Top = 192
  end
end
