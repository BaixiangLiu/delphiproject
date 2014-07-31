object frm_param: Tfrm_param
  Left = 361
  Top = 233
  Width = 334
  Height = 447
  Caption = #21442#25968#35774#32622
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 326
    Height = 377
    ActivePage = TabSheet1
    Align = alClient
    MultiLine = True
    TabIndex = 0
    TabOrder = 0
    OnChange = PageControl1Change
    object TabSheet1: TTabSheet
      Caption = #32844#32423
      object dxDBGrid1: TdxDBGrid
        Left = 0
        Top = 0
        Width = 318
        Height = 349
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
        DataSource = dmseat.ds_param
        Filter.Criteria = {00000000}
        LookAndFeel = lfFlat
        OptionsDB = [edgoCancelOnExit, edgoCanDelete, edgoCanInsert, edgoCanNavigation, edgoConfirmDelete, edgoLoadAllRecords, edgoUseBookmarks]
        OnChangeNode = dxDBGrid1ChangeNode
        object dxDBGrid1Column1: TdxDBGridMaskColumn
          Caption = #32844#32423#32534#30721
          Width = 142
          BandIndex = 0
          RowIndex = 0
          FieldName = 'param_id'
        end
        object dxDBGrid1Column2: TdxDBGridMaskColumn
          Caption = #32844#32423#21517#31216
          BandIndex = 0
          RowIndex = 0
          FieldName = 'param_name'
        end
        object dxDBGrid1Column3: TdxDBGridMaskColumn
          Caption = #22791#27880
          BandIndex = 0
          RowIndex = 0
          FieldName = 'remarks'
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = #32844#20301
      ImageIndex = 1
      object dxDBGrid2: TdxDBGrid
        Left = 0
        Top = 0
        Width = 318
        Height = 349
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
        DataSource = dmseat.ds_param
        Filter.Criteria = {00000000}
        LookAndFeel = lfFlat
        OptionsDB = [edgoCancelOnExit, edgoCanDelete, edgoCanInsert, edgoCanNavigation, edgoConfirmDelete, edgoLoadAllRecords, edgoUseBookmarks]
        OnChangeNode = dxDBGrid1ChangeNode
        object dxDBGridMaskColumn1: TdxDBGridMaskColumn
          Caption = #32844#20301#32534#30721
          Width = 142
          BandIndex = 0
          RowIndex = 0
          FieldName = 'param_id'
        end
        object dxDBGridMaskColumn2: TdxDBGridMaskColumn
          Caption = #32844#20301#21517#31216
          BandIndex = 0
          RowIndex = 0
          FieldName = 'param_name'
        end
        object dxDBGrid2Column3: TdxDBGridMaskColumn
          Caption = #22791#27880
          BandIndex = 0
          RowIndex = 0
          FieldName = 'remarks'
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = #20250#35758#26700#31867#22411
      ImageIndex = 2
      object dxDBGrid3: TdxDBGrid
        Left = 0
        Top = 0
        Width = 318
        Height = 349
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
        DataSource = dmseat.ds_param
        Filter.Criteria = {00000000}
        LookAndFeel = lfFlat
        OptionsDB = [edgoCancelOnExit, edgoCanDelete, edgoCanInsert, edgoCanNavigation, edgoConfirmDelete, edgoLoadAllRecords, edgoUseBookmarks]
        OnChangeNode = dxDBGrid1ChangeNode
        object dxDBGridMaskColumn3: TdxDBGridMaskColumn
          Caption = #20250#35758#26700#32534#30721
          Width = 142
          BandIndex = 0
          RowIndex = 0
          FieldName = 'param_id'
        end
        object dxDBGridMaskColumn4: TdxDBGridMaskColumn
          Caption = #20250#35758#26700#21517#31216
          BandIndex = 0
          RowIndex = 0
          FieldName = 'param_name'
        end
        object dxDBGrid3Column3: TdxDBGridMaskColumn
          Caption = #22791#27880
          BandIndex = 0
          RowIndex = 0
          FieldName = 'remarks'
        end
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 377
    Width = 326
    Height = 41
    Align = alBottom
    TabOrder = 1
    object BitBtn1: TBitBtn
      Left = 64
      Top = 8
      Width = 75
      Height = 25
      Caption = #22686#21152
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 232
      Top = 8
      Width = 75
      Height = 25
      Caption = #21024#38500
      TabOrder = 1
      OnClick = BitBtn2Click
    end
    object BitBtn3: TBitBtn
      Left = 152
      Top = 8
      Width = 75
      Height = 25
      Caption = #20445#23384
      TabOrder = 2
      OnClick = BitBtn3Click
    end
  end
end
