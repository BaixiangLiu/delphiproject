object FMMAINS: TFMMAINS
  Left = 146
  Top = 122
  AutoScroll = False
  BorderIcons = []
  Caption = '收款台设置'
  ClientHeight = 382
  ClientWidth = 530
  Color = 13876909
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object BTNQUT: TBitBtn
    Left = 15
    Top = 347
    Width = 250
    Height = 30
    Caption = '确定存盘'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = BTNQUTClick
    Kind = bkOK
  end
  object BTNCAL: TBitBtn
    Left = 265
    Top = 347
    Width = 250
    Height = 30
    Caption = '取消退出'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = BTNCALClick
    Kind = bkCancel
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 530
    Height = 346
    ActivePage = PAGE_A
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = '新宋体'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    TabWidth = 263
    object PAGE_A: TTabSheet
      Caption = '基本设置'
      object Panel2: TPanel
        Left = 5
        Top = 5
        Width = 511
        Height = 305
        BevelOuter = bvNone
        BorderStyle = bsSingle
        Caption = ' '
        Color = 14137510
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 0
        object Label1: TLabel
          Left = 330
          Top = 282
          Width = 64
          Height = 15
          Caption = '会员点数'
        end
        object Label6: TLabel
          Left = 461
          Top = 282
          Width = 40
          Height = 15
          Caption = '元/点'
        end
        object ED_AUTO_SHOWPOSA: TCheckBox
          Left = -1
          Top = 15
          Width = 171
          Height = 20
          Caption = '激活自动进入收款台'
          TabOrder = 0
        end
        object ED_PRN_PRINTING: TCheckBox
          Left = 10
          Top = 55
          Width = 150
          Height = 20
          Caption = '预设打印发票 '
          TabOrder = 2
        end
        object ED_PRN_ALWAYSON: TCheckBox
          Left = 10
          Top = 35
          Width = 150
          Height = 20
          Caption = '强迫打印发票 '
          TabOrder = 1
        end
        object ED_PRN_CASHBOX: TCheckBox
          Left = 10
          Top = 75
          Width = 150
          Height = 20
          Caption = '结帐自动打开钱箱'
          TabOrder = 3
        end
        object ED_CLEAR_INPUT: TCheckBox
          Left = 10
          Top = 95
          Width = 160
          Height = 20
          Caption = '输入后清除输入格'
          TabOrder = 4
        end
        object ED_MINUSP: TCheckBox
          Left = 10
          Top = 115
          Width = 141
          Height = 20
          Caption = '总计负数可结帐'
          TabOrder = 5
        end
        object ED_LAST_SUB: TCheckBox
          Left = 10
          Top = 215
          Width = 160
          Height = 20
          Caption = '去尾数另外打印'
          TabOrder = 10
        end
        object ED_AUTO_EAN13: TCheckBox
          Left = 10
          Top = 135
          Width = 160
          Height = 20
          Caption = '13码数值自动补位'
          TabOrder = 6
        end
        object ED_ALL_CASHIN: TCheckBox
          Left = 10
          Top = 155
          Width = 160
          Height = 20
          Caption = '全部使用现金结帐'
          TabOrder = 7
        end
        object ED_RE_INPUT: TCheckBox
          Left = 10
          Top = 175
          Width = 150
          Height = 20
          Caption = '重复刷是否自动加'
          TabOrder = 8
        end
        object ED_AUTO_ROUND: TCheckBox
          Left = 10
          Top = 195
          Width = 150
          Height = 20
          Caption = '小数点无条件进位'
          TabOrder = 9
        end
        object ED_SHOW_BGCOT: TCheckBox
          Left = 170
          Top = 95
          Width = 150
          Height = 20
          Caption = '显示其它价位'
          TabOrder = 16
          Visible = False
        end
        object ED_CHECK_POSM: TCheckBox
          Left = 325
          Top = 135
          Width = 150
          Height = 20
          Caption = '检查特价品资料'
          TabOrder = 26
        end
        object ED_CHECK_POSN: TCheckBox
          Left = 325
          Top = 155
          Width = 150
          Height = 20
          Caption = '检查组合销售资料'
          TabOrder = 27
        end
        object ED_CHECK_POSO: TCheckBox
          Left = 325
          Top = 175
          Width = 150
          Height = 20
          Caption = '检查买二送一资料'
          TabOrder = 28
          Visible = False
        end
        object ED_CHECK_BGQTN: TCheckBox
          Left = 325
          Top = 195
          Width = 150
          Height = 20
          Caption = '检查库存量资料'
          TabOrder = 29
        end
        object ED_CHECK_GIFT_NO: TCheckBox
          Left = 325
          Top = 215
          Width = 150
          Height = 20
          Caption = '检查礼券是否重复'
          TabOrder = 30
        end
        object ED_SHOW_WARN: TCheckBox
          Left = 170
          Top = 175
          Width = 150
          Height = 20
          Caption = '刷无资料时要警告'
          TabOrder = 20
        end
        object ED_SHOW_RUNLG: TCheckBox
          Left = 170
          Top = 155
          Width = 150
          Height = 20
          Caption = '显示跑马灯'
          TabOrder = 19
        end
        object ED_SHOW_BGCOS: TCheckBox
          Left = 170
          Top = 75
          Width = 145
          Height = 20
          Caption = '显示成本价'
          TabOrder = 15
        end
        object ED_SHOW_BGQTN: TCheckBox
          Left = 170
          Top = 55
          Width = 145
          Height = 20
          Caption = '显示库存量'
          TabOrder = 14
        end
        object ED_SHOW_BGDSN: TCheckBox
          Left = 170
          Top = 115
          Width = 145
          Height = 20
          Caption = '显示产品详细资料'
          TabOrder = 17
        end
        object ED_SHOW_BMEMN: TCheckBox
          Left = 170
          Top = 135
          Width = 145
          Height = 20
          Caption = '显示会员详细资料'
          TabOrder = 18
        end
        object ED_DISC_ALL: TCheckBox
          Left = 10
          Top = 235
          Width = 160
          Height = 20
          Caption = '每笔都打折'
          TabOrder = 11
        end
        object ED_SHOW_BGQTS: TCheckBox
          Left = 170
          Top = 35
          Width = 145
          Height = 20
          Caption = '显示安存量'
          TabOrder = 13
        end
        object ED_SET_ACUS: TCheckBox
          Left = 324
          Top = 11
          Width = 185
          Height = 24
          Caption = '是否输入流动客户分析'
          TabOrder = 21
        end
        object ED_SET_CHG_PRICE: TCheckBox
          Left = 324
          Top = 71
          Width = 185
          Height = 24
          Caption = '是否可直接更改售价'
          TabOrder = 24
        end
        object ED_SET_INPUT_INV: TCheckBox
          Left = 324
          Top = 31
          Width = 185
          Height = 24
          Caption = '是否必须输入发票号码'
          TabOrder = 22
        end
        object ED_SET_LOWCOS: TCheckBox
          Left = 308
          Top = 51
          Width = 199
          Height = 24
          Caption = '是否售价可低于预设成本'
          TabOrder = 23
        end
        object ED_SET_BMBPO: TSpinEdit
          Left = 396
          Top = 277
          Width = 60
          Height = 24
          MaxValue = 0
          MinValue = 0
          TabOrder = 32
          Value = 0
        end
        object ED_SET_WIN_PRICE: TCheckBox
          Left = 324
          Top = 91
          Width = 185
          Height = 24
          Caption = '开新窗口更改售价'
          TabOrder = 25
        end
        object ED_PRACTICE_MODE: TRadioGroup
          Left = 159
          Top = 215
          Width = 162
          Height = 80
          Caption = '练习模式'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -15
          Font.Name = '新宋体'
          Font.Style = []
          ItemIndex = 0
          Items.Strings = (
            '　存盘　打印发票'
            '不存盘　打印发票'
            '不存盘不打印发票')
          ParentFont = False
          TabOrder = 31
        end
        object ED_SHOW_FUNCTION: TCheckBox
          Left = 170
          Top = 15
          Width = 145
          Height = 20
          Caption = '显示功能键'
          TabOrder = 12
        end
      end
    end
    object PAGE_B: TTabSheet
      Caption = '发票格式设置'
      ImageIndex = 1
      object Panel1: TPanel
        Left = 5
        Top = 0
        Width = 511
        Height = 310
        BevelOuter = bvNone
        BorderStyle = bsSingle
        Caption = ' '
        Color = 8312318
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 0
        object GroupBox1: TGroupBox
          Left = 5
          Top = 5
          Width = 500
          Height = 80
          Caption = '抬头'
          Color = 11384474
          Ctl3D = False
          ParentColor = False
          ParentCtl3D = False
          TabOrder = 0
          object Label26: TLabel
            Left = 85
            Top = 25
            Width = 48
            Height = 15
            Caption = '第一行'
          end
          object Label27: TLabel
            Left = 85
            Top = 50
            Width = 48
            Height = 15
            Caption = '第二行'
          end
          object Label28: TLabel
            Left = 10
            Top = 50
            Width = 32
            Height = 15
            Caption = '空行'
          end
          object Label29: TLabel
            Left = 10
            Top = 25
            Width = 32
            Height = 15
            Caption = '空行'
          end
          object IV_TC1: TJEdit
            Left = 135
            Top = 22
            Width = 350
            Height = 21
            Ctl3D = False
            ParentCtl3D = False
            TabOrder = 0
            Digits = 1
            Max = 999999999
            _EditType = EDIT
            _SHOWCAL = NONE
            _BADINPUT = True
            _LONGTIME = False
          end
          object IV_TC2: TJEdit
            Left = 135
            Top = 47
            Width = 350
            Height = 21
            Ctl3D = False
            ParentCtl3D = False
            TabOrder = 1
            Digits = 1
            Max = 999999999
            _EditType = EDIT
            _SHOWCAL = NONE
            _BADINPUT = True
            _LONGTIME = False
          end
          object IV_TS1: TSpinEdit
            Left = 45
            Top = 20
            Width = 36
            Height = 24
            Ctl3D = False
            MaxValue = 0
            MinValue = 0
            ParentCtl3D = False
            TabOrder = 2
            Value = 0
          end
          object IV_TS2: TSpinEdit
            Left = 45
            Top = 45
            Width = 36
            Height = 24
            Ctl3D = False
            MaxValue = 0
            MinValue = 0
            ParentCtl3D = False
            TabOrder = 3
            Value = 0
          end
        end
        object GroupBox2: TGroupBox
          Left = 5
          Top = 87
          Width = 500
          Height = 110
          Caption = '内容'
          Color = 11790834
          Ctl3D = False
          ParentColor = False
          ParentCtl3D = False
          TabOrder = 1
          object Label19: TLabel
            Left = 60
            Top = 56
            Width = 36
            Height = 16
            Caption = '←位数'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -15
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label20: TLabel
            Left = 185
            Top = 56
            Width = 36
            Height = 16
            Caption = '←位数'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -15
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label21: TLabel
            Left = 310
            Top = 56
            Width = 36
            Height = 16
            Caption = '←位数'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -15
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label22: TLabel
            Left = 440
            Top = 56
            Width = 36
            Height = 16
            Caption = '←位数'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -15
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label23: TLabel
            Left = 115
            Top = 56
            Width = 12
            Height = 48
            Caption = '↑空格'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -15
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            WordWrap = True
          end
          object Label24: TLabel
            Left = 240
            Top = 56
            Width = 24
            Height = 32
            Caption = '↑空格'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -15
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            WordWrap = True
          end
          object Label25: TLabel
            Left = 365
            Top = 56
            Width = 12
            Height = 48
            Caption = '↑空格'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -15
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            WordWrap = True
          end
          object IV_CC1: TComboBox
            Left = 20
            Top = 25
            Width = 90
            Height = 23
            Ctl3D = False
            ItemHeight = 15
            ParentCtl3D = False
            TabOrder = 0
            Items.Strings = (
              ''
              '条形码'
              '编号'
              '品名'
              '类别'
              '数量'
              '单价'
              '小计')
          end
          object IV_CC2: TComboBox
            Left = 145
            Top = 25
            Width = 90
            Height = 23
            Ctl3D = False
            ItemHeight = 15
            ParentCtl3D = False
            TabOrder = 2
            Items.Strings = (
              ''
              '条形码'
              '编号'
              '品名'
              '类别'
              '数量'
              '单价'
              '小计')
          end
          object IV_CC3: TComboBox
            Left = 270
            Top = 25
            Width = 90
            Height = 23
            Ctl3D = False
            ItemHeight = 15
            ParentCtl3D = False
            TabOrder = 4
            Items.Strings = (
              ''
              '条形码'
              '编号'
              '品名'
              '类别'
              '数量'
              '单价'
              '小计')
          end
          object IV_CC4: TComboBox
            Left = 395
            Top = 25
            Width = 90
            Height = 23
            Ctl3D = False
            ItemHeight = 15
            ParentCtl3D = False
            TabOrder = 6
            Items.Strings = (
              ''
              '条形码'
              '编号'
              '品名'
              '类别'
              '数量'
              '单价'
              '小计')
          end
          object IV_CS1: TSpinEdit
            Left = 110
            Top = 25
            Width = 36
            Height = 24
            Ctl3D = False
            MaxValue = 0
            MinValue = 0
            ParentCtl3D = False
            TabOrder = 1
            Value = 0
          end
          object IV_CS2: TSpinEdit
            Left = 235
            Top = 25
            Width = 36
            Height = 24
            Ctl3D = False
            MaxValue = 0
            MinValue = 0
            ParentCtl3D = False
            TabOrder = 3
            Value = 0
          end
          object IV_CS3: TSpinEdit
            Left = 360
            Top = 25
            Width = 36
            Height = 24
            Ctl3D = False
            MaxValue = 0
            MinValue = 0
            ParentCtl3D = False
            TabOrder = 5
            Value = 0
          end
          object IV_CP1: TSpinEdit
            Left = 20
            Top = 55
            Width = 40
            Height = 24
            Ctl3D = False
            MaxValue = 0
            MinValue = 0
            ParentCtl3D = False
            TabOrder = 7
            Value = 0
          end
          object IV_CP2: TSpinEdit
            Left = 145
            Top = 55
            Width = 40
            Height = 24
            Ctl3D = False
            MaxValue = 0
            MinValue = 0
            ParentCtl3D = False
            TabOrder = 8
            Value = 0
          end
          object IV_CP3: TSpinEdit
            Left = 270
            Top = 55
            Width = 40
            Height = 24
            Ctl3D = False
            MaxValue = 0
            MinValue = 0
            ParentCtl3D = False
            TabOrder = 9
            Value = 0
          end
          object IV_CP4: TSpinEdit
            Left = 400
            Top = 55
            Width = 40
            Height = 24
            Ctl3D = False
            MaxValue = 0
            MinValue = 0
            ParentCtl3D = False
            TabOrder = 10
            Value = 0
          end
        end
        object GroupBox3: TGroupBox
          Left = 5
          Top = 199
          Width = 336
          Height = 106
          Caption = '结尾'
          Color = 13807278
          Ctl3D = False
          ParentColor = False
          ParentCtl3D = False
          TabOrder = 2
          object Label30: TLabel
            Left = 20
            Top = 24
            Width = 48
            Height = 15
            Caption = '第一行'
          end
          object Label31: TLabel
            Left = 20
            Top = 48
            Width = 48
            Height = 15
            Caption = '第二行'
          end
          object IV_EC1: TJEdit
            Left = 75
            Top = 20
            Width = 250
            Height = 21
            Ctl3D = False
            ParentCtl3D = False
            TabOrder = 0
            Digits = 1
            Max = 999999999
            _EditType = EDIT
            _SHOWCAL = NONE
            _BADINPUT = True
            _LONGTIME = False
          end
          object IV_EC2: TJEdit
            Left = 75
            Top = 45
            Width = 250
            Height = 21
            Ctl3D = False
            ParentCtl3D = False
            TabOrder = 1
            Digits = 1
            Max = 999999999
            _EditType = EDIT
            _SHOWCAL = NONE
            _BADINPUT = True
            _LONGTIME = False
          end
        end
        object IV_RP1: TCheckBox
          Left = 345
          Top = 205
          Width = 151
          Height = 20
          Caption = '打印应找金额'
          TabOrder = 3
        end
        object IV_RP2: TCheckBox
          Left = 344
          Top = 225
          Width = 151
          Height = 20
          Caption = '打印信用卡号'
          TabOrder = 4
        end
        object IV_RP3: TCheckBox
          Left = 344
          Top = 245
          Width = 151
          Height = 20
          Caption = '打印礼券明细'
          TabOrder = 5
        end
      end
    end
  end
end
