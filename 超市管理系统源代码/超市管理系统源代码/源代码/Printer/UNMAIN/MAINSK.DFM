object FMMAINSK: TFMMAINSK
  Left = 179
  Top = 77
  AutoScroll = False
  BorderIcons = []
  Caption = '收款台设置'
  ClientHeight = 493
  ClientWidth = 500
  Color = 13876909
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 20
  object BitBtn1: TBitBtn
    Left = 0
    Top = 463
    Width = 250
    Height = 30
    Caption = '确定存盘'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = BitBtn1Click
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 250
    Top = 463
    Width = 250
    Height = 30
    Caption = '取消退出'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnClick = BitBtn2Click
    Kind = bkCancel
  end
  object GroupBox4: TGroupBox
    Left = 0
    Top = 0
    Width = 500
    Height = 341
    Caption = '收款台快速键 Hot Key'
    Color = 11664126
    ParentColor = False
    TabOrder = 0
    object Label13: TLabel
      Left = 350
      Top = 25
      Width = 97
      Height = 20
      Caption = 'ESC取消交易'
    end
    object Label14: TLabel
      Left = 100
      Top = 25
      Width = 151
      Height = 20
      Caption = 'CTRL+I输入发票号码'
    end
    object Label15: TLabel
      Left = 100
      Top = 45
      Width = 94
      Height = 20
      Caption = 'CTRL+Q结束'
    end
    object Label16: TLabel
      Left = 100
      Top = 65
      Width = 124
      Height = 20
      Caption = 'CTRL+P打印发票'
    end
    object Label17: TLabel
      Left = 100
      Top = 85
      Width = 126
      Height = 20
      Caption = 'CTRL+D设置打折'
    end
    object Label18: TLabel
      Left = 100
      Top = 105
      Width = 157
      Height = 20
      Caption = 'CTRL+A设置分析资料'
    end
    object Label1: TLabel
      Left = 350
      Top = 45
      Width = 51
      Height = 20
      Caption = 'F1结帐'
    end
    object Label2: TLabel
      Left = 350
      Top = 65
      Width = 67
      Height = 20
      Caption = 'F2开钱箱'
    end
    object Label3: TLabel
      Left = 350
      Top = 85
      Width = 131
      Height = 20
      Caption = 'F3输入信用卡资料'
    end
    object Label4: TLabel
      Left = 350
      Top = 105
      Width = 115
      Height = 20
      Caption = 'F4输入统一编号'
    end
    object Label5: TLabel
      Left = 350
      Top = 125
      Width = 67
      Height = 20
      Caption = 'F5改数量'
    end
    object Label6: TLabel
      Left = 350
      Top = 145
      Width = 67
      Height = 20
      Caption = 'F6选价格'
    end
    object Label7: TLabel
      Left = 350
      Top = 165
      Width = 83
      Height = 20
      Caption = 'F7修改会员'
    end
    object Label8: TLabel
      Left = 350
      Top = 185
      Width = 115
      Height = 20
      Caption = 'F8修改会员等级'
    end
    object Label9: TLabel
      Left = 350
      Top = 205
      Width = 131
      Height = 20
      Caption = 'F9存入或取回暂存'
    end
    object Label10: TLabel
      Left = 350
      Top = 225
      Width = 92
      Height = 20
      Caption = 'F10移动位置'
      Visible = False
    end
    object Label11: TLabel
      Left = 350
      Top = 245
      Width = 92
      Height = 20
      Caption = 'F11删除一笔'
    end
    object Label12: TLabel
      Left = 350
      Top = 265
      Width = 92
      Height = 20
      Caption = 'F12去除尾数'
    end
    object Label32: TLabel
      Left = 100
      Top = 125
      Width = 125
      Height = 20
      Caption = 'CTRL+B发票作废'
    end
    object Label33: TLabel
      Left = 100
      Top = 165
      Width = 125
      Height = 20
      Caption = 'CTRL+N新增产品'
    end
    object Label34: TLabel
      Left = 100
      Top = 185
      Width = 127
      Height = 20
      Caption = 'CTRL+M新增会员'
    end
    object Label35: TLabel
      Left = 100
      Top = 145
      Width = 125
      Height = 20
      Caption = 'CTRL+V产品退货'
    end
    object Label36: TLabel
      Left = 100
      Top = 205
      Width = 127
      Height = 20
      Caption = 'CTRL+G输入礼券'
    end
    object Label37: TLabel
      Left = 100
      Top = 225
      Width = 124
      Height = 20
      Caption = 'CTRL+Z输入单品'
    end
    object Label28: TLabel
      Left = 100
      Top = 245
      Width = 157
      Height = 20
      Caption = 'CTRL+C发票张数修改'
    end
    object Label29: TLabel
      Left = 100
      Top = 265
      Width = 125
      Height = 20
      Caption = 'CTRL+X重新登录'
    end
    object Label30: TLabel
      Left = 100
      Top = 285
      Width = 157
      Height = 20
      Caption = 'CTRL+S检查个人信息'
    end
    object Label31: TLabel
      Left = 100
      Top = 305
      Width = 156
      Height = 20
      Caption = 'CTRL+F输入多行礼券'
    end
    object C_ESC: TComboBox
      Left = 265
      Top = 25
      Width = 80
      Height = 21
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      Items.Strings = (
        'ESC'
        'F1'
        'F2'
        'F3'
        'F4'
        'F5'
        'F6'
        'F7'
        'F8'
        'F9'
        'F10'
        'F11'
        'F12'
        'CTRL+A'
        'CTRL+B'
        'CTRL+C'
        'CTRL+D'
        'CTRL+E'
        'CTRL+F'
        'CTRL+G'
        'CTRL+H'
        'CTRL+I'
        'CTRL+J'
        'CTRL+K'
        'CTRL+L'
        'CTRL+M'
        'CTRL+N'
        'CTRL+O'
        'CTRL+P'
        'CTRL+Q'
        'CTRL+R'
        'CTRL+S'
        'CTRL+T'
        'CTRL+U'
        'CTRL+V'
        'CTRL+W'
        'CTRL+X'
        'CTRL+Y'
        'CTRL+Z'
        'CTRL+F1'
        'CTRL+F2'
        'CTRL+F3'
        'CTRL+F4'
        'CTRL+F5'
        'CTRL+F6'
        'CTRL+F7'
        'CTRL+F8'
        'CTRL+F9'
        'CTRL+F10'
        'CTRL+F11'
        'CTRL+F12')
      ParentFont = False
      TabOrder = 15
    end
    object C_CTRLI: TComboBox
      Left = 15
      Top = 25
      Width = 80
      Height = 21
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      TabOrder = 0
    end
    object C_CTRLQ: TComboBox
      Left = 15
      Top = 45
      Width = 80
      Height = 21
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      TabOrder = 1
    end
    object C_CTRLP: TComboBox
      Left = 15
      Top = 65
      Width = 80
      Height = 21
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      TabOrder = 2
    end
    object C_CTRLD: TComboBox
      Left = 15
      Top = 85
      Width = 80
      Height = 21
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      TabOrder = 3
    end
    object C_CTRLA: TComboBox
      Left = 15
      Top = 105
      Width = 80
      Height = 21
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      TabOrder = 4
    end
    object C_F1: TComboBox
      Left = 265
      Top = 45
      Width = 80
      Height = 21
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      TabOrder = 16
    end
    object C_F2: TComboBox
      Left = 265
      Top = 65
      Width = 80
      Height = 21
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      TabOrder = 17
    end
    object C_F3: TComboBox
      Left = 265
      Top = 85
      Width = 80
      Height = 21
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      TabOrder = 18
    end
    object C_F4: TComboBox
      Left = 265
      Top = 105
      Width = 80
      Height = 21
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      TabOrder = 19
    end
    object C_F5: TComboBox
      Left = 265
      Top = 125
      Width = 80
      Height = 21
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      TabOrder = 20
    end
    object C_F6: TComboBox
      Left = 265
      Top = 145
      Width = 80
      Height = 21
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      TabOrder = 21
    end
    object C_F7: TComboBox
      Left = 265
      Top = 165
      Width = 80
      Height = 21
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      TabOrder = 22
    end
    object C_F8: TComboBox
      Left = 265
      Top = 185
      Width = 80
      Height = 21
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      TabOrder = 23
    end
    object C_F9: TComboBox
      Left = 265
      Top = 205
      Width = 80
      Height = 21
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      TabOrder = 24
    end
    object C_F10: TComboBox
      Left = 265
      Top = 225
      Width = 80
      Height = 21
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      TabOrder = 25
      Visible = False
    end
    object C_F11: TComboBox
      Left = 265
      Top = 245
      Width = 80
      Height = 21
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      TabOrder = 26
    end
    object C_F12: TComboBox
      Left = 265
      Top = 265
      Width = 80
      Height = 21
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      TabOrder = 27
    end
    object C_CTRLB: TComboBox
      Left = 15
      Top = 125
      Width = 80
      Height = 21
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      TabOrder = 5
    end
    object C_CTRLV: TComboBox
      Left = 15
      Top = 145
      Width = 80
      Height = 21
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      TabOrder = 6
    end
    object C_CTRLN: TComboBox
      Left = 15
      Top = 165
      Width = 80
      Height = 21
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      TabOrder = 7
    end
    object C_CTRLM: TComboBox
      Left = 15
      Top = 185
      Width = 80
      Height = 21
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      TabOrder = 8
    end
    object C_CTRLG: TComboBox
      Left = 15
      Top = 205
      Width = 80
      Height = 21
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      TabOrder = 9
    end
    object C_CTRLZ: TComboBox
      Left = 15
      Top = 225
      Width = 80
      Height = 21
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      TabOrder = 10
    end
    object C_CTRLC: TComboBox
      Left = 15
      Top = 245
      Width = 80
      Height = 21
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      TabOrder = 11
    end
    object C_CTRLX: TComboBox
      Left = 15
      Top = 265
      Width = 80
      Height = 21
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      TabOrder = 12
    end
    object C_CTRLS: TComboBox
      Left = 15
      Top = 285
      Width = 80
      Height = 21
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      TabOrder = 13
    end
    object C_CTRLF: TComboBox
      Left = 15
      Top = 305
      Width = 80
      Height = 21
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      TabOrder = 14
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 340
    Width = 500
    Height = 121
    Caption = '查询键'
    Color = 7783934
    Ctl3D = False
    ParentColor = False
    ParentCtl3D = False
    TabOrder = 1
    object Label62: TLabel
      Left = 100
      Top = 35
      Width = 121
      Height = 20
      Caption = 'CTRL+F5 用编号'
    end
    object Label19: TLabel
      Left = 100
      Top = 55
      Width = 121
      Height = 20
      Caption = 'CTRL+F6 用姓名'
    end
    object Label20: TLabel
      Left = 100
      Top = 75
      Width = 121
      Height = 20
      Caption = 'CTRL+F7 用电话'
    end
    object Label21: TLabel
      Left = 100
      Top = 95
      Width = 121
      Height = 20
      Caption = 'CTRL+F8 用地址'
    end
    object Label22: TLabel
      Left = 350
      Top = 30
      Width = 121
      Height = 20
      Caption = 'CTRL+F9 用编号'
    end
    object Label23: TLabel
      Left = 350
      Top = 50
      Width = 130
      Height = 20
      Caption = 'CTRL+F10 用名称'
    end
    object Label24: TLabel
      Left = 350
      Top = 70
      Width = 146
      Height = 20
      Caption = 'CTRL+F11 用厂商号'
    end
    object Label25: TLabel
      Left = 350
      Top = 90
      Width = 146
      Height = 20
      Caption = 'CTRL+F12 用分类号'
    end
    object Label26: TLabel
      Left = 23
      Top = 15
      Width = 64
      Height = 20
      Caption = '查询会员'
    end
    object Label27: TLabel
      Left = 273
      Top = 15
      Width = 64
      Height = 20
      Caption = '查询产品'
    end
    object C_CTRLF5: TComboBox
      Left = 15
      Top = 35
      Width = 80
      Height = 21
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      TabOrder = 0
    end
    object C_CTRLF6: TComboBox
      Left = 15
      Top = 55
      Width = 80
      Height = 21
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      TabOrder = 1
    end
    object C_CTRLF7: TComboBox
      Left = 15
      Top = 75
      Width = 80
      Height = 21
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      TabOrder = 2
    end
    object C_CTRLF8: TComboBox
      Left = 15
      Top = 95
      Width = 80
      Height = 21
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      TabOrder = 3
    end
    object C_CTRLF9: TComboBox
      Left = 265
      Top = 35
      Width = 80
      Height = 21
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      TabOrder = 4
    end
    object C_CTRLF10: TComboBox
      Left = 265
      Top = 55
      Width = 80
      Height = 21
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      TabOrder = 5
    end
    object C_CTRLF11: TComboBox
      Left = 265
      Top = 75
      Width = 80
      Height = 21
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      TabOrder = 6
    end
    object C_CTRLF12: TComboBox
      Left = 265
      Top = 95
      Width = 80
      Height = 21
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      TabOrder = 7
    end
  end
end 
