object frmrenyuan: Tfrmrenyuan
  Left = 271
  Top = 186
  Width = 595
  Height = 485
  Caption = #20154#21592#31649#29702
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
    Width = 587
    Height = 391
    Align = alClient
    TabOrder = 0
    object Splitter1: TSplitter
      Left = 1
      Top = 249
      Width = 585
      Height = 2
      Cursor = crVSplit
      Align = alTop
    end
    object Panel4: TPanel
      Left = 1
      Top = 1
      Width = 585
      Height = 248
      Align = alTop
      TabOrder = 0
      object Panel2: TPanel
        Left = 480
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
      end
      object dxDBGrid1: TdxDBGrid
        Left = 1
        Top = 1
        Width = 479
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
        DataSource = dmseat.ds_meetingpeople
        Filter.Criteria = {00000000}
        LookAndFeel = lfFlat
        OptionsDB = [edgoCancelOnExit, edgoCanDelete, edgoCanInsert, edgoCanNavigation, edgoConfirmDelete, edgoLoadAllRecords, edgoUseBookmarks]
        OptionsView = [edgoBandHeaderWidth, edgoIndicator, edgoRowSelect, edgoUseBitmap]
        OnChangeNode = dxDBGrid1ChangeNode
        object dxDBGrid1Column1: TdxDBGridMaskColumn
          Caption = #20154#21592#21517#31216
          Width = 107
          BandIndex = 0
          RowIndex = 0
          FieldName = 'name'
        end
        object dxDBGrid1Column2: TdxDBGridMaskColumn
          Caption = #20154#21592#21517#31216#32553#20889
          Width = 78
          BandIndex = 0
          RowIndex = 0
          FieldName = 'name_py'
        end
        object dxDBGrid1Column3: TdxDBGridMaskColumn
          Caption = #32844#21153
          Width = 63
          BandIndex = 0
          RowIndex = 0
          FieldName = 'careername'
        end
        object dxDBGrid1Column4: TdxDBGridMaskColumn
          Caption = #32844#32423
          Width = 70
          BandIndex = 0
          RowIndex = 0
          FieldName = 'gradename'
        end
        object dxDBGrid1Column5: TdxDBGridMaskColumn
          Caption = #21442#21152#20250#35758#29366#24577
          Width = 78
          BandIndex = 0
          RowIndex = 0
          FieldName = 'status_ex'
        end
      end
    end
    object PageControl1: TPageControl
      Left = 1
      Top = 251
      Width = 585
      Height = 139
      ActivePage = TabSheet1
      Align = alClient
      TabIndex = 0
      TabOrder = 1
      object TabSheet1: TTabSheet
        Caption = #20154#21592#20449#24687
        object Panel5: TPanel
          Left = 0
          Top = 74
          Width = 577
          Height = 38
          Align = alBottom
          TabOrder = 0
          object BitBtn2: TBitBtn
            Left = 448
            Top = 8
            Width = 75
            Height = 25
            Caption = #20445#23384
            TabOrder = 0
            OnClick = BitBtn2Click
          end
        end
        object Panel6: TPanel
          Left = 0
          Top = 0
          Width = 577
          Height = 74
          Align = alClient
          BevelOuter = bvLowered
          TabOrder = 1
          object Label1: TLabel
            Left = 16
            Top = 16
            Width = 48
            Height = 12
            Caption = #20154#21592#21517#31216
          end
          object Label2: TLabel
            Left = 344
            Top = 16
            Width = 72
            Height = 12
            Caption = #20154#21592#21517#31216#32553#20889
          end
          object Label3: TLabel
            Left = 16
            Top = 48
            Width = 24
            Height = 12
            Caption = #32844#21153
          end
          object Label4: TLabel
            Left = 200
            Top = 48
            Width = 24
            Height = 12
            Caption = #32844#32423
          end
          object Label8: TLabel
            Left = 344
            Top = 48
            Width = 24
            Height = 12
            Caption = #29366#24577
          end
          object dxDBEdit1: TdxDBEdit
            Left = 80
            Top = 12
            Width = 249
            TabOrder = 0
            DataField = 'name'
            DataSource = dmseat.ds_meetingpeople
          end
          object dxDBEdit2: TdxDBEdit
            Left = 432
            Top = 12
            Width = 121
            TabOrder = 1
            DataField = 'name_py'
            DataSource = dmseat.ds_meetingpeople
          end
          object dxDBImageEdit1: TdxDBImageEdit
            Left = 432
            Top = 44
            Width = 121
            TabOrder = 2
            DataField = 'status_ex'
            DataSource = dmseat.ds_meetingpeople
            OnChange = dxDBImageEdit1Change
          end
          object dxDBImageEdit2: TdxDBImageEdit
            Left = 80
            Top = 44
            Width = 97
            TabOrder = 3
            DataField = 'careername'
            DataSource = dmseat.ds_meetingpeople
            OnChange = dxDBImageEdit2Change
          end
          object dxDBImageEdit3: TdxDBImageEdit
            Left = 240
            Top = 44
            Width = 89
            TabOrder = 4
            DataField = 'gradename'
            DataSource = dmseat.ds_meetingpeople
            OnChange = dxDBImageEdit3Change
          end
        end
      end
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 587
    Height = 65
    Align = alTop
    TabOrder = 1
    object Label5: TLabel
      Left = 16
      Top = 16
      Width = 60
      Height = 12
      Caption = #20154#21592#21517#31216#65306
    end
    object Label6: TLabel
      Left = 16
      Top = 37
      Width = 36
      Height = 12
      Caption = #29366#24577#65306
    end
    object dxEdit1: TdxEdit
      Left = 80
      Top = 8
      Width = 121
      TabOrder = 0
    end
    object BitBtn3: TBitBtn
      Left = 328
      Top = 24
      Width = 75
      Height = 25
      Caption = #26597#35810
      TabOrder = 1
      OnClick = BitBtn3Click
    end
    object BitBtn4: TBitBtn
      Left = 432
      Top = 24
      Width = 75
      Height = 25
      Caption = #37325#26032#26597#35810
      TabOrder = 2
      OnClick = BitBtn4Click
    end
    object dxImageEdit1: TdxImageEdit
      Left = 80
      Top = 32
      Width = 121
      TabOrder = 3
    end
  end
end
