object frmhuichang: Tfrmhuichang
  Left = 258
  Top = 134
  Width = 626
  Height = 513
  Caption = #20250#22330#31649#29702
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
    Top = 41
    Width = 618
    Height = 443
    Align = alClient
    TabOrder = 0
    object Splitter1: TSplitter
      Left = 1
      Top = 265
      Width = 616
      Height = 2
      Cursor = crVSplit
      Align = alTop
    end
    object Panel4: TPanel
      Left = 1
      Top = 1
      Width = 616
      Height = 264
      Align = alTop
      TabOrder = 0
      object Panel2: TPanel
        Left = 511
        Top = 1
        Width = 104
        Height = 262
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
          Caption = #31105#29992
          TabOrder = 1
          OnClick = BitBtn3Click
        end
        object BitBtn4: TBitBtn
          Left = 16
          Top = 112
          Width = 75
          Height = 25
          Caption = #21551#29992
          TabOrder = 2
          OnClick = BitBtn4Click
        end
      end
      object dxDBGrid1: TdxDBGrid
        Left = 1
        Top = 1
        Width = 510
        Height = 262
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
        DataSource = dmseat.ds_meetingroom
        Filter.Criteria = {00000000}
        LookAndFeel = lfFlat
        OptionsDB = [edgoCancelOnExit, edgoCanDelete, edgoCanInsert, edgoCanNavigation, edgoConfirmDelete, edgoLoadAllRecords, edgoUseBookmarks]
        OptionsView = [edgoBandHeaderWidth, edgoIndicator, edgoRowSelect, edgoUseBitmap]
        OnChangeNode = dxDBGrid1ChangeNode
        object dxDBGrid1Column1: TdxDBGridMaskColumn
          Caption = #20250#22330#21517#31216
          Width = 95
          BandIndex = 0
          RowIndex = 0
          FieldName = 'name'
        end
        object dxDBGrid1Column3: TdxDBGridMaskColumn
          Caption = #20250#22330#21517#31216#32553#20889
          Width = 80
          BandIndex = 0
          RowIndex = 0
          FieldName = 'name_py'
        end
        object dxDBGrid1Column6: TdxDBGridMaskColumn
          Caption = #25152#22788#22320#28857
          Width = 100
          BandIndex = 0
          RowIndex = 0
          FieldName = 'address'
        end
        object dxDBGrid1Column2: TdxDBGridMaskColumn
          Caption = #20250#22330#23481#37327
          Width = 54
          BandIndex = 0
          RowIndex = 0
          FieldName = 'capacity'
        end
        object dxDBGrid1Column4: TdxDBGridMaskColumn
          Caption = #39046#23548#21306#23481#37327
          Width = 66
          BandIndex = 0
          RowIndex = 0
          FieldName = 'leader'
        end
        object dxDBGrid1Column5: TdxDBGridMaskColumn
          Caption = #29366#24577
          MinWidth = 16
          Width = 66
          BandIndex = 0
          RowIndex = 0
          FieldName = 'status_ex'
        end
      end
    end
    object PageControl1: TPageControl
      Left = 1
      Top = 267
      Width = 616
      Height = 175
      ActivePage = TabSheet3
      Align = alClient
      TabIndex = 1
      TabOrder = 1
      OnChange = PageControl1Change
      object TabSheet1: TTabSheet
        Caption = #20250#22330#20449#24687
        object Panel5: TPanel
          Left = 0
          Top = 106
          Width = 608
          Height = 42
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 0
          object BitBtn7: TBitBtn
            Left = 504
            Top = 8
            Width = 75
            Height = 25
            Caption = #20445#23384
            TabOrder = 0
            OnClick = BitBtn7Click
          end
        end
        object Panel6: TPanel
          Left = 0
          Top = 0
          Width = 608
          Height = 106
          Align = alClient
          BevelOuter = bvLowered
          TabOrder = 1
          object Label1: TLabel
            Left = 16
            Top = 12
            Width = 48
            Height = 12
            Caption = #20250#22330#21517#31216
          end
          object Label2: TLabel
            Left = 369
            Top = 12
            Width = 72
            Height = 12
            Caption = #20250#22330#21517#31216#32553#20889
          end
          object Label3: TLabel
            Left = 16
            Top = 44
            Width = 48
            Height = 12
            Caption = #25152#22788#22320#28857
          end
          object Label4: TLabel
            Left = 16
            Top = 76
            Width = 48
            Height = 12
            Caption = #20250#22330#23481#37327
          end
          object Label5: TLabel
            Left = 169
            Top = 76
            Width = 60
            Height = 12
            Caption = #39046#23548#21306#23481#37327
          end
          object Label6: TLabel
            Left = 369
            Top = 76
            Width = 48
            Height = 12
            Caption = #20250#22330#29366#24577
          end
          object dxDBEdit1: TdxDBEdit
            Left = 72
            Top = 8
            Width = 281
            TabOrder = 0
            DataField = 'name'
            DataSource = dmseat.ds_meetingroom
          end
          object dxDBEdit2: TdxDBEdit
            Left = 457
            Top = 8
            Width = 121
            TabOrder = 1
            DataField = 'name_py'
            DataSource = dmseat.ds_meetingroom
          end
          object dxDBEdit3: TdxDBEdit
            Left = 72
            Top = 40
            Width = 505
            TabOrder = 2
            DataField = 'address'
            DataSource = dmseat.ds_meetingroom
          end
          object dxDBImageEdit1: TdxDBImageEdit
            Left = 457
            Top = 72
            Width = 121
            TabOrder = 3
            DataField = 'status_ex'
            DataSource = dmseat.ds_meetingroom
            OnChange = dxDBImageEdit1Change
          end
          object dxDBSpinEdit1: TdxDBSpinEdit
            Left = 72
            Top = 72
            Width = 81
            TabOrder = 4
            DataField = 'capacity'
            DataSource = dmseat.ds_meetingroom
          end
          object dxDBSpinEdit2: TdxDBSpinEdit
            Left = 240
            Top = 72
            Width = 113
            TabOrder = 5
            DataField = 'leader'
            DataSource = dmseat.ds_meetingroom
          end
        end
      end
      object TabSheet3: TTabSheet
        Caption = #20250#22330#23433#25490
        ImageIndex = 2
        object dxDBGrid3: TdxDBGrid
          Left = 0
          Top = 0
          Width = 608
          Height = 107
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
          DataSource = dmseat.ds_room_table
          Filter.Criteria = {00000000}
          LookAndFeel = lfFlat
          OptionsDB = [edgoCancelOnExit, edgoCanDelete, edgoCanInsert, edgoCanNavigation, edgoConfirmDelete, edgoLoadAllRecords, edgoUseBookmarks]
          OnChangeNode = dxDBGrid3ChangeNode
          object dxDBGrid3Column1: TdxDBGridMaskColumn
            Caption = #26700#21495
            Width = 48
            BandIndex = 0
            RowIndex = 0
            FieldName = 'table_id'
          end
          object dxDBGrid3Column2: TdxDBGridImageColumn
            Alignment = taLeftJustify
            Caption = #20250#35758#26700#31867#22411
            MaxLength = 2
            MinWidth = 16
            Width = 88
            BandIndex = 0
            RowIndex = 0
            OnChange = dxDBGrid3Column2Change
            FieldName = 'tabletype'
            ShowButtonStyle = sbAlways
            DropDownWidth = 2
            ImageIndexes.Strings = (
              '0')
            ShowDescription = True
            OnCloseUp = dxDBGrid3Column2CloseUp
          end
          object dxDBGrid3Column3: TdxDBGridSpinColumn
            Caption = #20154#25968
            Width = 69
            BandIndex = 0
            RowIndex = 0
            FieldName = 'peoplecount'
          end
          object dxDBGrid3Column4: TdxDBGridPickColumn
            Caption = #21306#22495
            Width = 96
            BandIndex = 0
            RowIndex = 0
            FieldName = 'area'
            Items.Strings = (
              #39046#23548#21306
              #26222#36890#21306)
          end
        end
        object Panel7: TPanel
          Left = 0
          Top = 107
          Width = 608
          Height = 41
          Align = alBottom
          BevelInner = bvSpace
          BevelOuter = bvLowered
          TabOrder = 1
          object BitBtn2: TBitBtn
            Left = 352
            Top = 8
            Width = 75
            Height = 25
            Caption = #22686#21152
            TabOrder = 0
            OnClick = BitBtn2Click
          end
          object BitBtn8: TBitBtn
            Left = 516
            Top = 8
            Width = 75
            Height = 25
            Caption = #21024#38500
            TabOrder = 1
            OnClick = BitBtn8Click
          end
          object BitBtn9: TBitBtn
            Left = 434
            Top = 8
            Width = 75
            Height = 25
            Caption = #20445#23384
            TabOrder = 2
            OnClick = BitBtn9Click
          end
          object dxDBCheckEdit1: TdxDBCheckEdit
            Left = 24
            Top = 8
            Width = 121
            TabOrder = 3
            OnClick = dxDBCheckEdit1Click
            Caption = #23436#25104#20250#22330#23433#25490
            DataField = 'iscomplete'
            DataSource = dmseat.ds_meetingroom
            ValueChecked = 'True'
            ValueUnchecked = 'False'
            NullStyle = nsUnchecked
          end
        end
      end
      object TabSheet2: TTabSheet
        Caption = #30456#20851#20250#35758
        ImageIndex = 1
        object dxDBGrid2: TdxDBGrid
          Left = 0
          Top = 0
          Width = 608
          Height = 148
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
          DataSource = dmseat.ds_meeting
          Filter.Criteria = {00000000}
          LookAndFeel = lfFlat
          OptionsDB = [edgoCancelOnExit, edgoCanDelete, edgoCanInsert, edgoCanNavigation, edgoConfirmDelete, edgoLoadAllRecords, edgoUseBookmarks]
          OptionsView = [edgoBandHeaderWidth, edgoIndicator, edgoUseBitmap]
          object dxDBGrid2Column1: TdxDBGridMaskColumn
            Caption = #20250#35758#21517#31216
            Width = 100
            BandIndex = 0
            RowIndex = 0
            FieldName = 'name'
          end
          object dxDBGrid2Column3: TdxDBGridDateColumn
            Caption = #21484#24320#26085#26399
            BandIndex = 0
            RowIndex = 0
            FieldName = 'opendate'
          end
          object dxDBGrid2Column2: TdxDBGridMaskColumn
            Caption = #21484#24320#26102#38388
            Width = 103
            BandIndex = 0
            RowIndex = 0
            FieldName = 'opentime'
          end
        end
      end
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 618
    Height = 41
    Align = alTop
    TabOrder = 1
    object Label7: TLabel
      Left = 8
      Top = 16
      Width = 60
      Height = 12
      Caption = #20250#22330#21517#31216#65306
    end
    object Label8: TLabel
      Left = 216
      Top = 13
      Width = 60
      Height = 12
      Caption = #20250#22330#29366#24577#65306
    end
    object dxEdit1: TdxEdit
      Left = 72
      Top = 9
      Width = 121
      TabOrder = 0
    end
    object BitBtn5: TBitBtn
      Left = 432
      Top = 8
      Width = 75
      Height = 25
      Caption = #26597#35810
      TabOrder = 1
      OnClick = BitBtn5Click
    end
    object BitBtn6: TBitBtn
      Left = 520
      Top = 8
      Width = 75
      Height = 25
      Caption = #37325#26032#26597#35810
      TabOrder = 2
      OnClick = BitBtn6Click
    end
    object dxImageEdit1: TdxImageEdit
      Left = 288
      Top = 8
      Width = 121
      TabOrder = 3
    end
  end
end
