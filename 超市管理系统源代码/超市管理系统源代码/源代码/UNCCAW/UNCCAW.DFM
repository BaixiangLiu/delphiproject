object FMCCAW: TFMCCAW
  Left = 159
  Top = 132
  AutoScroll = False
  Caption = '会员模彩抽奖作业'
  ClientHeight = 373
  ClientWidth = 592
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = '宋体'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 590
    Height = 370
    ActivePage = PAGE_A
    TabOrder = 0
    TabWidth = 280
    object PAGE_A: TTabSheet
      Caption = '摸彩抽奖'
      object Gauge: TGauge
        Left = 461
        Top = 240
        Width = 45
        Height = 47
        BorderStyle = bsNone
        ForeColor = clRed
        Kind = gkPie
        Progress = 0
      end
      object Label1: TLabel
        Left = 440
        Top = 155
        Width = 105
        Height = 15
        Caption = '请输入会员编号'
      end
      object LB_INSERT: TLabel
        Left = 415
        Top = 200
        Width = 150
        Height = 16
        AutoSize = False
        Color = 16503466
        ParentColor = False
      end
      object LB_CCAWCNT: TLabel
        Left = 415
        Top = 220
        Width = 150
        Height = 16
        AutoSize = False
        Color = 16503466
        ParentColor = False
      end
      object DBGRID_BMEM: TDBGrid
        Left = 0
        Top = 2
        Width = 581
        Height = 141
        Ctl3D = False
        DataSource = FMCCAWD.DSBMEM
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
        ParentCtl3D = False
        TabOrder = 0
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -15
        TitleFont.Name = '宋体'
        TitleFont.Style = []
        OnDblClick = DBGRID_BMEMDblClick
        Columns = <
          item
            Expanded = False
            FieldName = 'BMENO'
            Title.Alignment = taCenter
            Title.Caption = '会员编号'
            Title.Color = clInfoBk
            Width = 69
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'BMNAM'
            Title.Alignment = taCenter
            Title.Caption = '中文姓名'
            Title.Color = clInfoBk
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'BMBTH'
            Title.Alignment = taCenter
            Title.Caption = '生　　日'
            Title.Color = clInfoBk
            Width = 95
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'BMSEX'
            Title.Alignment = taCenter
            Title.Caption = '性别'
            Title.Color = clInfoBk
            Width = 33
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'BMLVE'
            Title.Alignment = taCenter
            Title.Caption = '等级'
            Title.Color = clInfoBk
            Width = 32
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'BMBYR'
            Title.Alignment = taCenter
            Title.Caption = '年消费额'
            Title.Color = clInfoBk
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'BMBTO'
            Title.Alignment = taCenter
            Title.Caption = '总消费额'
            Title.Color = clInfoBk
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'BMBDT'
            Title.Alignment = taCenter
            Title.Caption = '最近交易日'
            Title.Color = clInfoBk
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'BMJND'
            Title.Alignment = taCenter
            Title.Caption = '入会日期'
            Title.Color = clInfoBk
            Visible = True
          end>
      end
      object DBGRID_CCAW: TDBGrid
        Left = 1
        Top = 147
        Width = 395
        Height = 189
        Ctl3D = False
        DataSource = FMCCAWD.DSCCAW
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
        ParentCtl3D = False
        TabOrder = 1
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -15
        TitleFont.Name = '宋体'
        TitleFont.Style = []
        OnDrawColumnCell = DBGRID_CCAWDrawColumnCell
        Columns = <
          item
            Expanded = False
            FieldName = 'BMENO'
            Title.Alignment = taCenter
            Title.Caption = '会员编号'
            Title.Color = clInfoBk
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'BMNAM'
            Title.Alignment = taCenter
            Title.Caption = '中文姓名'
            Title.Color = clInfoBk
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CWGET'
            Title.Alignment = taCenter
            Title.Caption = '是否中奖'
            Title.Color = clInfoBk
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CWGDS'
            Title.Alignment = taCenter
            Title.Caption = '中奖奖品'
            Title.Color = clInfoBk
            Visible = True
          end>
      end
      object ED_BMENO: JLOOKUPBOX
        Left = 405
        Top = 170
        Width = 175
        Height = 21
        Ctl3D = False
        MaxLength = 20
        ParentCtl3D = False
        TabOrder = 2
        OnKeyDown = ED_BMENOKeyDown
        _DatabaseName = 'MAIN'
        _TableName = 'BMEM'
        _Field_IDNO = 'BMENO'
        _Field_NAME = 'BMNAM'
        _EDIT_WIDTH = 80
        _CHANGE_QUERY = True
        _INSERT_RECORD = False
        _SHOW_MESSAGE = False
      end
      object BTNRUN: TBitBtn
        Left = 405
        Top = 300
        Width = 76
        Height = 31
        Caption = '随机选取'
        TabOrder = 3
        OnClick = BTNRUNClick
      end
      object BitBtn2: TBitBtn
        Left = 485
        Top = 300
        Width = 96
        Height = 31
        Caption = '清除已选会员'
        TabOrder = 4
        OnClick = BitBtn2Click
      end
    end
    object PAGE_B: TTabSheet
      Caption = '抽签'
      ImageIndex = 1
      object Label2: TLabel
        Left = 295
        Top = 252
        Width = 126
        Height = 21
        Caption = '随机数最大值'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
      end
      object Label3: TLabel
        Left = 295
        Top = 297
        Width = 105
        Height = 21
        Caption = '重复运次数'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
      end
      object Gauge1: TGauge
        Left = 290
        Top = 230
        Width = 281
        Height = 12
        ForeColor = clRed
        Progress = 0
      end
      object LB_RANDOM: TStaticText
        Left = 30
        Top = -20
        Width = 544
        Height = 217
        Caption = '00000'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -213
        Font.Name = '宋体'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
      end
      object BTNRANDOM: TBitBtn
        Left = 5
        Top = 235
        Width = 271
        Height = 101
        Caption = '请按我!'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -48
        Font.Name = '宋体'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = BTNRANDOMClick
        Kind = bkAll
        Layout = blGlyphTop
      end
      object ED_MAX: TSpinEdit
        Left = 430
        Top = 245
        Width = 141
        Height = 42
        Ctl3D = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -32
        Font.Name = '宋体'
        Font.Style = []
        MaxLength = 5
        MaxValue = 99999
        MinValue = 0
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 1
        Value = 0
      end
      object ED_MAXCNT: TSpinEdit
        Left = 430
        Top = 290
        Width = 141
        Height = 42
        Ctl3D = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -32
        Font.Name = '宋体'
        Font.Style = []
        MaxLength = 5
        MaxValue = 99999
        MinValue = 0
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 3
        Value = 100
      end
    end
  end
end
