object frmcxtj: Tfrmcxtj
  Left = 192
  Top = 111
  Width = 696
  Height = 480
  Caption = #26597#35810#32479#35745
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
  object dxPageControl1: TdxPageControl
    Left = 0
    Top = 118
    Width = 689
    Height = 317
    ActivePage = dxTabSheet1
    Align = alClient
    HideButtons = False
    HotTrack = False
    MultiLine = False
    OwnerDraw = False
    RaggedRight = False
    ScrollOpposite = False
    TabHeight = 0
    TabOrder = 0
    TabPosition = dxtpTop
    TabStop = True
    TabWidth = 0
    object dxTabSheet1: TdxTabSheet
      Caption = #20250#22330
      TabVisible = False
      object dxDBGrid1: TdxDBGrid
        Left = 0
        Top = 0
        Width = 689
        Height = 317
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
        DataSource = dmseat.ds_meetingroom
        Filter.Criteria = {00000000}
        LookAndFeel = lfFlat
        OptionsDB = [edgoCancelOnExit, edgoCanDelete, edgoCanInsert, edgoCanNavigation, edgoConfirmDelete, edgoLoadAllRecords, edgoUseBookmarks]
        OptionsView = [edgoBandHeaderWidth, edgoIndicator, edgoRowSelect, edgoUseBitmap]
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
    object dxTabSheet2: TdxTabSheet
      Caption = #20250#35758
      TabVisible = False
      object dxDBGrid3: TdxDBGrid
        Left = 0
        Top = 0
        Width = 689
        Height = 317
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
        OptionsView = [edgoBandHeaderWidth, edgoIndicator, edgoRowSelect, edgoUseBitmap]
        object dxDBGridMaskColumn1: TdxDBGridMaskColumn
          Caption = #20250#35758#21517#31216
          Width = 146
          BandIndex = 0
          RowIndex = 0
          FieldName = 'name'
        end
        object dxDBGridMaskColumn2: TdxDBGridMaskColumn
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
        object dxDBGridMaskColumn3: TdxDBGridMaskColumn
          Caption = #21442#21152#20250#35758#20154#25968
          Width = 78
          BandIndex = 0
          RowIndex = 0
          FieldName = 'capacity'
        end
        object dxDBGridMaskColumn4: TdxDBGridMaskColumn
          Caption = #39046#23548#20154#25968
          Width = 54
          BandIndex = 0
          RowIndex = 0
          FieldName = 'leader'
        end
        object dxDBGridMaskColumn5: TdxDBGridMaskColumn
          Caption = #20250#22330#23433#25490
          Width = 54
          BandIndex = 0
          RowIndex = 0
          FieldName = 'meetingroom'
        end
        object dxDBGridMaskColumn6: TdxDBGridMaskColumn
          Caption = #29366#24577
          Width = 47
          BandIndex = 0
          RowIndex = 0
          FieldName = 'status_ex'
        end
      end
    end
    object dxTabSheet3: TdxTabSheet
      Caption = #20154#21592
      TabVisible = False
      object dxDBGrid2: TdxDBGrid
        Left = 0
        Top = 0
        Width = 689
        Height = 317
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
        DataSource = dmseat.ds_meetingpeople
        Filter.Criteria = {00000000}
        LookAndFeel = lfFlat
        OptionsDB = [edgoCancelOnExit, edgoCanDelete, edgoCanInsert, edgoCanNavigation, edgoConfirmDelete, edgoLoadAllRecords, edgoUseBookmarks]
        OptionsView = [edgoBandHeaderWidth, edgoIndicator, edgoRowSelect, edgoUseBitmap]
        object dxDBGridMaskColumn7: TdxDBGridMaskColumn
          Caption = #20154#21592#21517#31216
          Width = 107
          BandIndex = 0
          RowIndex = 0
          FieldName = 'name'
        end
        object dxDBGridMaskColumn8: TdxDBGridMaskColumn
          Caption = #20154#21592#21517#31216#32553#20889
          Width = 78
          BandIndex = 0
          RowIndex = 0
          FieldName = 'name_py'
        end
        object dxDBGridMaskColumn9: TdxDBGridMaskColumn
          Caption = #32844#21153
          Width = 63
          BandIndex = 0
          RowIndex = 0
          FieldName = 'career'
        end
        object dxDBGridMaskColumn10: TdxDBGridMaskColumn
          Caption = #32844#32423
          Width = 70
          BandIndex = 0
          RowIndex = 0
          FieldName = 'grade'
        end
        object dxDBGridMaskColumn11: TdxDBGridMaskColumn
          Caption = #21442#21152#20250#35758#29366#24577
          Width = 78
          BandIndex = 0
          RowIndex = 0
          FieldName = 'status_ex'
        end
      end
    end
  end
  object dxPageControl2: TdxPageControl
    Left = 0
    Top = 0
    Width = 689
    Height = 89
    ActivePage = dxTabSheet6
    Align = alTop
    HideButtons = False
    HotTrack = False
    MultiLine = False
    OwnerDraw = False
    RaggedRight = False
    ScrollOpposite = False
    TabHeight = 0
    TabOrder = 1
    TabPosition = dxtpTop
    TabStop = True
    TabWidth = 0
    object dxTabSheet4: TdxTabSheet
      Caption = #20250#22330
      TabVisible = False
      object Label7: TLabel
        Left = 8
        Top = 32
        Width = 60
        Height = 12
        Caption = #20250#22330#21517#31216#65306
      end
      object Label8: TLabel
        Left = 8
        Top = 61
        Width = 60
        Height = 12
        Caption = #20250#22330#29366#24577#65306
      end
      object dxEdit2: TdxEdit
        Left = 72
        Top = 24
        Width = 121
        TabOrder = 0
      end
      object BitBtn5: TBitBtn
        Left = 400
        Top = 32
        Width = 75
        Height = 25
        Caption = #26597#35810
        TabOrder = 1
        OnClick = BitBtn5Click
      end
      object BitBtn6: TBitBtn
        Left = 496
        Top = 32
        Width = 75
        Height = 25
        Caption = #37325#26032#26597#35810
        TabOrder = 2
        OnClick = BitBtn6Click
      end
      object dxImageEdit2: TdxImageEdit
        Left = 72
        Top = 56
        Width = 121
        TabOrder = 3
      end
    end
    object dxTabSheet5: TdxTabSheet
      Caption = #20250#35758
      TabVisible = False
      object Label9: TLabel
        Left = 24
        Top = 30
        Width = 60
        Height = 12
        Caption = #20250#35758#21517#31216#65306
      end
      object Label10: TLabel
        Left = 24
        Top = 54
        Width = 60
        Height = 12
        Caption = #21484#24320#26085#26399#65306
      end
      object Label11: TLabel
        Left = 176
        Top = 52
        Width = 12
        Height = 12
        Caption = #33267
      end
      object Label1: TLabel
        Left = 240
        Top = 29
        Width = 60
        Height = 12
        Caption = #20250#35758#29366#24577#65306
      end
      object dxEdit1: TdxEdit
        Left = 88
        Top = 24
        Width = 121
        TabOrder = 0
      end
      object dxDateEdit1: TdxDateEdit
        Left = 88
        Top = 48
        Width = 81
        TabOrder = 1
        Date = -700000
      end
      object dxDateEdit2: TdxDateEdit
        Left = 192
        Top = 48
        Width = 81
        TabOrder = 2
        Date = -700000
      end
      object BitBtn7: TBitBtn
        Left = 488
        Top = 38
        Width = 75
        Height = 25
        Caption = #26597#35810
        TabOrder = 3
        OnClick = BitBtn7Click
      end
      object BitBtn8: TBitBtn
        Left = 584
        Top = 38
        Width = 75
        Height = 25
        Caption = #37325#26032#26597#35810
        TabOrder = 4
        OnClick = BitBtn8Click
      end
      object dxImageEdit3: TdxImageEdit
        Left = 304
        Top = 24
        Width = 121
        TabOrder = 5
      end
    end
    object dxTabSheet6: TdxTabSheet
      TabVisible = False
      object Label5: TLabel
        Left = 16
        Top = 37
        Width = 60
        Height = 12
        Caption = #20154#21592#21517#31216#65306
      end
      object Label6: TLabel
        Left = 16
        Top = 58
        Width = 36
        Height = 12
        Caption = #29366#24577#65306
      end
      object dxEdit3: TdxEdit
        Left = 80
        Top = 29
        Width = 121
        TabOrder = 0
      end
      object BitBtn3: TBitBtn
        Left = 328
        Top = 45
        Width = 75
        Height = 25
        Caption = #26597#35810
        TabOrder = 1
        OnClick = BitBtn3Click
      end
      object BitBtn4: TBitBtn
        Left = 432
        Top = 45
        Width = 75
        Height = 25
        Caption = #37325#26032#26597#35810
        TabOrder = 2
        OnClick = BitBtn4Click
      end
      object dxImageEdit1: TdxImageEdit
        Left = 80
        Top = 56
        Width = 121
        DragMode = dmAutomatic
        Style.ButtonTransparence = ebtAlways
        TabOrder = 3
      end
    end
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 89
    Width = 689
    Height = 29
    ButtonHeight = 246
    Caption = 'ToolBar1'
    TabOrder = 2
    Visible = False
    object ToolButton1: TToolButton
      Left = 0
      Top = 2
      ImageIndex = 0
    end
    object ToolButton2: TToolButton
      Left = 23
      Top = 2
      Caption = 'ToolButton2'
      ImageIndex = 1
    end
    object ToolButton3: TToolButton
      Left = 46
      Top = 2
      Width = 8
      Caption = 'ToolButton3'
      ImageIndex = 2
      Style = tbsSeparator
    end
    object ToolButton4: TToolButton
      Left = 54
      Top = 2
      Caption = #25171#21360
      ImageIndex = 2
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 689
    Height = 17
    Caption = #26597#35810#35774#32622
    TabOrder = 3
  end
end
