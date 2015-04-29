object FMBMANS: TFMBMANS
  Left = 295
  Top = 173
  AutoScroll = False
  Caption = '设置'
  ClientHeight = 319
  ClientWidth = 244
  Color = 14536927
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = '宋体'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object GroupBox1: TGroupBox
    Left = 2
    Top = 0
    Width = 240
    Height = 86
    Caption = '设置条件'
    Color = 10998526
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = '宋体'
    Font.Style = []
    ParentColor = False
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 0
    object LB_CON1: TLabel
      Left = 10
      Top = 20
      Width = 85
      Height = 13
      Caption = '预设排列顺序1'
    end
    object Label1: TLabel
      Left = 10
      Top = 45
      Width = 85
      Height = 13
      Caption = '预设排列顺序2'
    end
    object ED_1: TComboBox
      Left = 110
      Top = 15
      Width = 125
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
      Items.Strings = (
        '产品条形码'
        '产品编号'
        '产品名称')
    end
    object ED_2: TComboBox
      Left = 110
      Top = 40
      Width = 125
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 1
      Items.Strings = (
        '产品条形码'
        '产品编号'
        '产品名称')
    end
    object ED_3: TCheckBox
      Left = 10
      Top = 65
      Width = 111
      Height = 13
      Alignment = taLeftJustify
      Caption = '自动新增模式'
      TabOrder = 2
    end
  end
  object ToolBar: TToolBar
    Left = 0
    Top = 280
    Width = 241
    Height = 36
    Align = alNone
    ButtonHeight = 30
    Color = 16769220
    ParentColor = False
    TabOrder = 1
    object ToolButton1: TToolButton
      Left = 0
      Top = 2
      Width = 11
      Caption = 'ToolButton1'
      ImageIndex = 0
      Style = tbsSeparator
    end
    object BTNUPD: TSpeedButton
      Left = 11
      Top = 2
      Width = 120
      Height = 30
      Cursor = crHandPoint
      Caption = '&Y 更新'
      Flat = True
      OnClick = BTNUPDClick
    end
    object ToolButton2: TToolButton
      Left = 131
      Top = 2
      Width = 20
      Caption = 'ToolButton2'
      ImageIndex = 1
      Style = tbsSeparator
    end
    object BTNQUT: TSpeedButton
      Left = 151
      Top = 2
      Width = 85
      Height = 30
      Cursor = crHandPoint
      Caption = '&Q 取消'
      Flat = True
      OnClick = BTNQUTClick
    end
  end
  object GroupBox4: TGroupBox
    Left = 2
    Top = 88
    Width = 240
    Height = 193
    Caption = '新增时可以的复制字段'
    Color = 10998526
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = '宋体'
    Font.Style = []
    ParentColor = False
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 2
    object LBBGENO: TCheckBox
      Left = 7
      Top = 20
      Width = 75
      Height = 13
      Caption = '产品条码'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object LBBGNAM: TCheckBox
      Left = 7
      Top = 50
      Width = 75
      Height = 13
      Caption = '产品名称'
      TabOrder = 1
    end
    object LBBGKIN: TCheckBox
      Left = 7
      Top = 80
      Width = 75
      Height = 13
      Caption = '产品分类'
      TabOrder = 2
    end
    object LBBGPST: TCheckBox
      Left = 7
      Top = 125
      Width = 75
      Height = 13
      Caption = '标准价格'
      TabOrder = 3
    end
    object LBBGPVP: TCheckBox
      Left = 7
      Top = 155
      Width = 75
      Height = 13
      Caption = '贵宾价格'
      TabOrder = 4
    end
    object LBBGPMM: TCheckBox
      Left = 7
      Top = 140
      Width = 75
      Height = 13
      Caption = '会员价格'
      TabOrder = 5
    end
    object LBBGQTS: TCheckBox
      Left = 7
      Top = 110
      Width = 75
      Height = 13
      Caption = '安全存量'
      TabOrder = 6
    end
    object LBBGCOS: TCheckBox
      Left = 7
      Top = 95
      Width = 75
      Height = 13
      Caption = '预设成本'
      TabOrder = 7
    end
    object LBBSENO: TCheckBox
      Left = 7
      Top = 65
      Width = 75
      Height = 13
      Caption = '供 应 商'
      TabOrder = 8
    end
    object LBBGID1: TCheckBox
      Left = 7
      Top = 35
      Width = 75
      Height = 13
      Caption = '产品编号'
      TabOrder = 9
    end
    object LBBGCNA: TCheckBox
      Left = 87
      Top = 20
      Width = 75
      Height = 13
      Caption = '英文名称'
      TabOrder = 10
    end
    object LBBGSNA: TCheckBox
      Left = 87
      Top = 50
      Width = 75
      Height = 13
      Caption = '产品简称'
      TabOrder = 11
    end
    object LBBGSCN: TCheckBox
      Left = 87
      Top = 35
      Width = 75
      Height = 13
      Caption = '英文简称'
      TabOrder = 12
    end
    object LBBGSUM: TCheckBox
      Left = 87
      Top = 125
      Width = 75
      Height = 13
      Caption = '图文件'
      TabOrder = 13
    end
    object LBBGCSF: TCheckBox
      Left = 87
      Top = 65
      Width = 75
      Height = 13
      Caption = '期初成本'
      TabOrder = 14
    end
    object LBBGCSN: TCheckBox
      Left = 87
      Top = 80
      Width = 75
      Height = 13
      Caption = '目前成本'
      TabOrder = 15
    end
    object LBBGCSS: TCheckBox
      Left = 87
      Top = 140
      Width = 75
      Height = 13
      Caption = '标准成本'
      TabOrder = 16
    end
    object LBBGCSI: TCheckBox
      Left = 87
      Top = 155
      Width = 75
      Height = 13
      Caption = '进货单价'
      TabOrder = 17
    end
    object LBBGQTE: TCheckBox
      Left = 87
      Top = 95
      Width = 75
      Height = 13
      Caption = '经济批量'
      TabOrder = 18
    end
    object LBBGRUL: TCheckBox
      Left = 162
      Top = 20
      Width = 75
      Height = 13
      Caption = '产品类别'
      TabOrder = 19
    end
    object LBBGGAU: TCheckBox
      Left = 162
      Top = 35
      Width = 75
      Height = 13
      Caption = '产品规格'
      TabOrder = 20
    end
    object LBBGUNS: TCheckBox
      Left = 162
      Top = 50
      Width = 75
      Height = 13
      Caption = '库存单位'
      TabOrder = 21
    end
    object LBBGUNP: TCheckBox
      Left = 162
      Top = 65
      Width = 75
      Height = 13
      Caption = '包装单位'
      TabOrder = 22
    end
    object LBBGCLR: TCheckBox
      Left = 162
      Top = 110
      Width = 75
      Height = 13
      Caption = '产品颜色'
      TabOrder = 23
    end
    object LBBGCLH: TCheckBox
      Left = 162
      Top = 125
      Width = 75
      Height = 13
      Caption = '产品尺寸'
      TabOrder = 24
    end
    object LBBGCLW: TCheckBox
      Left = 87
      Top = 110
      Width = 75
      Height = 13
      Caption = '产品重量'
      TabOrder = 25
    end
    object LBBGUNW: TCheckBox
      Left = 162
      Top = 80
      Width = 75
      Height = 13
      Caption = '重量单位'
      TabOrder = 26
    end
    object LBBGUSE: TCheckBox
      Left = 162
      Top = 95
      Width = 75
      Height = 13
      Caption = '产品用途'
      TabOrder = 27
    end
    object LBBGMRK: TCheckBox
      Left = 162
      Top = 140
      Width = 75
      Height = 13
      Caption = '叙　　述'
      TabOrder = 28
    end
  end
end
