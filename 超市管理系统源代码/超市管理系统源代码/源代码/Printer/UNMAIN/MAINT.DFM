object FMMAINT: TFMMAINT
  Left = 151
  Top = 144
  AutoScroll = False
  BorderIcons = []
  Caption = 
    '收款台数据传输 → 服务器  (Microsoft SQL Server实时联机,请勿使用' +
    ')'
  ClientHeight = 400
  ClientWidth = 609
  Color = 13876909
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = '新宋体'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object Gauge: TGauge
    Left = 305
    Top = 175
    Width = 140
    Height = 20
    ForeColor = clRed
    Progress = 0
  end
  object Label1: TLabel
    Left = 476
    Top = 56
    Width = 15
    Height = 15
    Caption = '～'
  end
  object Label2: TLabel
    Left = 476
    Top = 81
    Width = 15
    Height = 15
    Caption = '～'
  end
  object Label3: TLabel
    Left = 476
    Top = 106
    Width = 15
    Height = 15
    Caption = '～'
  end
  object Label4: TLabel
    Left = 546
    Top = 56
    Width = 45
    Height = 15
    Caption = '建档日'
  end
  object Label5: TLabel
    Left = 546
    Top = 81
    Width = 45
    Height = 15
    Caption = '建档日'
  end
  object Label6: TLabel
    Left = 546
    Top = 106
    Width = 45
    Height = 15
    Caption = '销售日'
  end
  object Label7: TLabel
    Left = 416
    Top = 126
    Width = 135
    Height = 15
    Caption = '日期空白为全部传输'
  end
  object BTNYES: TBitBtn
    Left = 300
    Top = 200
    Width = 150
    Height = 100
    Caption = '一次全部传输'
    Default = True
    TabOrder = 11
    OnClick = BTNYESClick
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object BTNNO: TBitBtn
    Left = 300
    Top = 300
    Width = 150
    Height = 100
    Caption = '取消退出'
    TabOrder = 12
    OnClick = BTNNOClick
    Kind = bkCancel
  end
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 300
    Height = 400
    Ctl3D = False
    ParentCtl3D = False
    ScrollBars = ssBoth
    TabOrder = 13
  end
  object CB_SYS: TCheckBox
    Left = 310
    Top = 5
    Width = 110
    Height = 17
    Caption = '检查系统设置'
    TabOrder = 0
  end
  object CB_BMAN: TCheckBox
    Left = 310
    Top = 30
    Width = 110
    Height = 17
    Caption = '检查人员设置'
    TabOrder = 1
  end
  object CB_BGDS: TCheckBox
    Left = 310
    Top = 55
    Width = 110
    Height = 17
    Caption = '检查新产品'
    TabOrder = 2
  end
  object CB_BMEM: TCheckBox
    Left = 310
    Top = 80
    Width = 110
    Height = 17
    Caption = '检查新会员'
    TabOrder = 5
  end
  object CB_POSA: TCheckBox
    Left = 310
    Top = 105
    Width = 110
    Height = 17
    Caption = '上载销售资料'
    TabOrder = 8
  end
  object BGDS_DAT1: TJEdit
    Left = 420
    Top = 53
    Width = 56
    Height = 21
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 3
    Digits = 1
    Max = 999999999
    _EditType = CDATE_EDIT
    _SHOWCAL = NONE
  end
  object BGDS_DAT2: TJEdit
    Left = 490
    Top = 53
    Width = 56
    Height = 21
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 4
    Digits = 1
    Max = 999999999
    _EditType = CDATE_EDIT
    _SHOWCAL = NONE
  end
  object BMEM_DAT1: TJEdit
    Left = 420
    Top = 78
    Width = 56
    Height = 21
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 6
    Digits = 1
    Max = 999999999
    _EditType = CDATE_EDIT
    _SHOWCAL = NONE
  end
  object BMEM_DAT2: TJEdit
    Left = 490
    Top = 78
    Width = 56
    Height = 21
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 7
    Digits = 1
    Max = 999999999
    _EditType = CDATE_EDIT
    _SHOWCAL = NONE
  end
  object POSA_DAT1: TJEdit
    Left = 420
    Top = 103
    Width = 56
    Height = 21
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 9
    Digits = 1
    Max = 999999999
    _EditType = CDATE_EDIT
    _SHOWCAL = NONE
  end
  object POSA_DAT2: TJEdit
    Left = 490
    Top = 103
    Width = 56
    Height = 21
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 10
    Digits = 1
    Max = 999999999
    _EditType = CDATE_EDIT
    _SHOWCAL = NONE
  end
  object DatabaseP: TDatabase
    AliasName = 'P'
    DatabaseName = 'MAINP'
    HandleShared = True
    LoginPrompt = False
    SessionName = 'Default'
    Left = 15
    Top = 50
  end
  object PUERY: TQuery
    DatabaseName = 'MAINP'
    Left = 130
    Top = 50
  end
  object PINS: TQuery
    DatabaseName = 'MAINP'
    Left = 75
    Top = 50
  end
  object QUERY1: TQuery
    DatabaseName = 'MAIN'
    Left = 70
    Top = 125
  end
  object QINS: TQuery
    DatabaseName = 'MAIN'
    Left = 15
    Top = 125
  end
  object QUERY2: TQuery
    DatabaseName = 'MAIN'
    Left = 130
    Top = 125
  end
end
