object FMRPINR: TFMRPINR
  Left = 155
  Top = 142
  AutoScroll = False
  Caption = '采购单带入进货单'
  ClientHeight = 373
  ClientWidth = 642
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 0
    Top = 360
    Width = 358
    Height = 13
    Caption = '↑上面连按两下可单项带入进货单　　再按两下可确定或回复"已转"'
  end
  object Label2: TLabel
    Left = 520
    Top = 130
    Width = 120
    Height = 25
    AutoSize = False
    Caption = '↑上面连按两下可确定或注销单据'
    WordWrap = True
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 641
    Height = 126
    Ctl3D = False
    DataSource = FMRPIND.DSRPCHA
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    ParentCtl3D = False
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDrawColumnCell = DBGrid1DrawColumnCell
    OnDblClick = DBGrid1DblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'RH_OVERDAT'
        Title.Alignment = taCenter
        Title.Caption = '到期'
        Title.Color = clInfoBk
        Width = 32
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'RH_OVERINT'
        Title.Alignment = taCenter
        Title.Caption = '距今'
        Title.Color = clInfoBk
        Width = 32
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'RHENO'
        Title.Alignment = taCenter
        Title.Caption = '采购单号'
        Title.Color = clInfoBk
        Width = 85
        Visible = True
      end
      item
        Expanded = False
        FieldName = '_BSNAM'
        Title.Alignment = taCenter
        Title.Caption = '厂商名称'
        Title.Color = clInfoBk
        Width = 112
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'RHPDT'
        Title.Alignment = taCenter
        Title.Caption = '应交日期'
        Title.Color = clInfoBk
        Width = 55
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'RHSAT'
        Title.Alignment = taCenter
        Title.Caption = '采购状态'
        Title.Color = clInfoBk
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'RHPTD'
        Title.Alignment = taCenter
        Title.Caption = '采购日期'
        Title.Color = clInfoBk
        Width = 61
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'RHTRN'
        Title.Alignment = taCenter
        Title.Caption = '注销单据'
        Title.Color = clInfoBk
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'RHMRK'
        Title.Alignment = taCenter
        Title.Caption = '备　　注'
        Title.Color = clInfoBk
        Width = 117
        Visible = True
      end>
  end
  object DBGrid2: TDBGrid
    Left = 1
    Top = 127
    Width = 515
    Height = 229
    Ctl3D = False
    DataSource = FMRPIND.DSRPCHB
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
    ParentCtl3D = False
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDrawColumnCell = DBGrid2DrawColumnCell
    OnDblClick = DBGrid2DblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'RHTRN'
        Title.Alignment = taCenter
        Title.Caption = '已转'
        Title.Color = clInfoBk
        Width = 32
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BGENO'
        Title.Alignment = taCenter
        Title.Caption = '产品条形码'
        Title.Color = clInfoBk
        Width = 103
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BGNAM'
        Title.Alignment = taCenter
        Title.Caption = '产品名称'
        Title.Color = clInfoBk
        Width = 197
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'RHPCA'
        Title.Alignment = taCenter
        Title.Caption = '数量'
        Title.Color = clInfoBk
        Width = 29
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'RHCSI'
        Title.Alignment = taCenter
        Title.Caption = '单价'
        Title.Color = clInfoBk
        Width = 59
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'RHCST'
        Title.Alignment = taCenter
        Title.Caption = '总价'
        Title.Color = clInfoBk
        Width = 56
        Visible = True
      end>
  end
  object Panel5: TPanel
    Left = 515
    Top = 155
    Width = 125
    Height = 218
    Caption = ' '
    Color = clNavy
    TabOrder = 2
    object Gauge: TGauge
      Left = 40
      Top = 95
      Width = 81
      Height = 15
      ForeColor = clRed
      Progress = 0
    end
    object Label8: TLabel
      Left = 5
      Top = 95
      Width = 32
      Height = 15
      Caption = '进度'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -15
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
    end
    object BTNINA: TBitBtn
      Left = 0
      Top = 5
      Width = 125
      Height = 80
      Caption = '&A 全部入进货单'
      TabOrder = 0
      OnClick = BTNINAClick
    end
    object BTNQUT: TBitBtn
      Left = 0
      Top = 115
      Width = 125
      Height = 100
      Caption = '&Q 取消返回'
      TabOrder = 1
      OnClick = BTNQUTClick
    end
  end
end
