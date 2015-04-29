object FRCOLLECT: TFRCOLLECT
  Left = 332
  Top = 135
  AutoScroll = False
  Caption = '盘点机控制设置'
  ClientHeight = 386
  ClientWidth = 319
  Color = clMenu
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '宋体'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 316
    Height = 351
    ActivePage = PAGE_A
    Style = tsFlatButtons
    TabOrder = 0
    TabWidth = 145
    object PAGE_A: TTabSheet
      Caption = '参数设置'
      object Label2: TLabel
        Left = 160
        Top = 104
        Width = 42
        Height = 12
        Caption = 'Address'
        Layout = tlCenter
      end
      object Label11: TLabel
        Left = 160
        Top = 15
        Width = 48
        Height = 12
        Caption = 'Time out'
      end
      object Label1: TLabel
        Left = 160
        Top = 45
        Width = 54
        Height = 12
        Caption = 'ESC delay'
      end
      object Label3: TLabel
        Left = 160
        Top = 75
        Width = 54
        Height = 12
        Caption = 'NAK delay'
      end
      object Label4: TLabel
        Left = 160
        Top = 192
        Width = 48
        Height = 12
        Caption = '目标文件'
        Layout = tlCenter
      end
      object Label5: TLabel
        Left = 160
        Top = 167
        Width = 36
        Height = 12
        Caption = '源文件'
        Layout = tlCenter
      end
      object ED_PORT: TRadioGroup
        Left = 0
        Top = 0
        Width = 76
        Height = 100
        Caption = '连接口'
        Ctl3D = False
        ItemIndex = 1
        Items.Strings = (
          'COM1'
          'COM2'
          'COM3'
          'COM4')
        ParentCtl3D = False
        TabOrder = 1
      end
      object ED_POWERSAVING: TCheckBox
        Left = 160
        Top = 139
        Width = 76
        Height = 17
        Alignment = taLeftJustify
        Caption = '节电模式'
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 0
      end
      object ED_ADDRESS: TMaskEdit
        Left = 230
        Top = 100
        Width = 50
        Height = 21
        Ctl3D = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = '宋体'
        Font.Style = []
        MaxLength = 1
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 2
        Text = 'A'
      end
      object ED_TIMEOUT: TSpinEdit
        Left = 230
        Top = 10
        Width = 50
        Height = 21
        Ctl3D = False
        MaxValue = 0
        MinValue = 0
        ParentCtl3D = False
        TabOrder = 3
        Value = 400
      end
      object ED_BAUDRATE: TRadioGroup
        Left = 85
        Top = 0
        Width = 71
        Height = 220
        BiDiMode = bdLeftToRight
        Caption = '传输速率'
        Ctl3D = False
        ItemIndex = 6
        Items.Strings = (
          '110'
          '300'
          '600'
          '1200'
          '2400'
          '4800'
          '9600'
          '19200'
          '38400'
          '57600')
        ParentBiDiMode = False
        ParentCtl3D = False
        TabOrder = 4
      end
      object ED_DATABIT: TRadioGroup
        Left = 0
        Top = 105
        Width = 76
        Height = 55
        BiDiMode = bdLeftToRight
        Caption = '数据位'
        Ctl3D = False
        ItemIndex = 1
        Items.Strings = (
          '7'
          '8')
        ParentBiDiMode = False
        ParentCtl3D = False
        TabOrder = 5
      end
      object ED_STOPBIT: TRadioGroup
        Left = 0
        Top = 165
        Width = 76
        Height = 55
        BiDiMode = bdLeftToRight
        Caption = '停止位'
        Ctl3D = False
        ItemIndex = 0
        Items.Strings = (
          '1'
          '2')
        ParentBiDiMode = False
        ParentCtl3D = False
        TabOrder = 6
      end
      object ED_PARITY: TRadioGroup
        Left = 0
        Top = 225
        Width = 156
        Height = 90
        BiDiMode = bdLeftToRight
        Caption = '校验位'
        Ctl3D = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = '宋体'
        Font.Style = []
        ItemIndex = 0
        Items.Strings = (
          'None   无'
          'Odd     奇校验位'
          'Even    偶校验位')
        ParentBiDiMode = False
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 7
      end
      object ED_LOGFILE: TRadioGroup
        Left = 160
        Top = 225
        Width = 145
        Height = 91
        BiDiMode = bdLeftToRight
        Caption = '记录文件'
        Ctl3D = False
        ItemIndex = 1
        Items.Strings = (
          'No     不记录'
          'Append  添加'
          'New File 新文件')
        ParentBiDiMode = False
        ParentCtl3D = False
        TabOrder = 8
      end
      object ED_ESCDELAY: TSpinEdit
        Left = 230
        Top = 40
        Width = 50
        Height = 21
        Ctl3D = False
        MaxValue = 0
        MinValue = 0
        ParentCtl3D = False
        TabOrder = 9
        Value = 10
      end
      object ED_NAKDELAY: TSpinEdit
        Left = 230
        Top = 70
        Width = 50
        Height = 21
        Ctl3D = False
        MaxValue = 0
        MinValue = 0
        ParentCtl3D = False
        TabOrder = 10
        Value = 30
      end
      object ED_FORMNAME: TMaskEdit
        Left = 215
        Top = 188
        Width = 90
        Height = 18
        Ctl3D = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = '宋体'
        Font.Style = []
        MaxLength = 20
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 11
        Text = 'FORM.DAT'
      end
      object ED_SOURCENAME: TMaskEdit
        Left = 215
        Top = 163
        Width = 90
        Height = 18
        Ctl3D = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = '宋体'
        Font.Style = []
        MaxLength = 20
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 12
        Text = 'FORM.DAT'
      end
    end
    object TabSheet2: TTabSheet
      Caption = '测试'
      object P_TEST_WARM_START: TBitBtn
        Left = 83
        Top = -1
        Width = 60
        Height = 25
        Caption = '热启动'
        TabOrder = 0
        OnClick = P_TEST_WARM_STARTClick
      end
      object BitBtn2: TBitBtn
        Left = 0
        Top = 0
        Width = 60
        Height = 25
        Caption = '冷启动'
        TabOrder = 1
        OnClick = BitBtn2Click
      end
      object BitBtn3: TBitBtn
        Left = 165
        Top = 0
        Width = 60
        Height = 25
        Caption = '上传文件1'
        TabOrder = 2
        OnClick = BitBtn3Click
      end
      object BitBtn4: TBitBtn
        Left = 248
        Top = 0
        Width = 60
        Height = 25
        Caption = '上传文件2'
        TabOrder = 3
        Visible = False
        OnClick = BitBtn4Click
      end
      object GroupBox1: TGroupBox
        Left = 0
        Top = 32
        Width = 308
        Height = 290
        Caption = '传送内容'
        TabOrder = 4
        object Memo: TMemo
          Left = 2
          Top = 14
          Width = 304
          Height = 274
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
          ScrollBars = ssVertical
          TabOrder = 0
        end
      end
    end
  end
  object BTNQUT: TBitBtn
    Left = 37
    Top = 353
    Width = 100
    Height = 30
    Caption = ' &Y 保存设置'
    TabOrder = 1
    OnClick = BTNQUTClick
    Kind = bkOK
  end
  object BTNESC: TBitBtn
    Left = 183
    Top = 353
    Width = 100
    Height = 30
    Caption = '&C 取消设置'
    TabOrder = 2
    OnClick = BTNESCClick
    Kind = bkCancel
  end
  object MainMenu: TMainMenu
    Left = 286
    Top = 31
    object N5: TMenuItem
      Caption = '取消'
      ShortCut = 27
      Visible = False
      OnClick = BTNESCClick
    end
  end
end
