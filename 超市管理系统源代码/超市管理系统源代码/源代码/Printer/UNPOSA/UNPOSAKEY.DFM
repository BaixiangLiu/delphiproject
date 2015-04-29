object FMPOSAKEY: TFMPOSAKEY
  Left = 243
  Top = 199
  BorderStyle = bsDialog
  Caption = '按键设置'
  ClientHeight = 386
  ClientWidth = 618
  Color = 13430011
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -20
  Font.Name = 'Arial'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 23
  object CTRL_I: TPanel
    Left = 210
    Top = 30
    Width = 200
    Height = 24
    Alignment = taLeftJustify
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Caption = 'CTRL+I 输入发票号码'
    Color = 15655888
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Courier New'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 3
  end
  object CTRL_Q: TPanel
    Left = 415
    Top = 5
    Width = 200
    Height = 24
    Alignment = taLeftJustify
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Caption = 'CTRL+Q 退出'
    Color = clWhite
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Courier New'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 4
  end
  object CTRL_P: TPanel
    Left = 210
    Top = 55
    Width = 200
    Height = 24
    Alignment = taLeftJustify
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Caption = 'CTRL+P 打印发票'
    Color = 15655888
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Courier New'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 5
  end
  object CTRL_A: TPanel
    Left = 415
    Top = 305
    Width = 200
    Height = 24
    Alignment = taLeftJustify
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Caption = 'CTRL+A 设置分析资料'
    Color = clWhite
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Courier New'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 6
    Visible = False
  end
  object CTRL_B: TPanel
    Left = 210
    Top = 80
    Width = 200
    Height = 24
    Alignment = taLeftJustify
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Caption = 'CTRL+B 发票作废'
    Color = 15655888
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Courier New'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 19
    Visible = False
  end
  object CTRL_N: TPanel
    Left = 210
    Top = 130
    Width = 200
    Height = 24
    Alignment = taLeftJustify
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Caption = 'CTRL+N 新增产品'
    Color = 15655888
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Courier New'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 20
  end
  object CTRL_M: TPanel
    Left = 210
    Top = 155
    Width = 200
    Height = 24
    Alignment = taLeftJustify
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Caption = 'CTRL+M 新增会员'
    Color = 15655888
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Courier New'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 21
  end
  object CTRL_V: TPanel
    Left = 210
    Top = 105
    Width = 200
    Height = 24
    Alignment = taLeftJustify
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Caption = 'CTRL+V 产品退货'
    Color = 15655888
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Courier New'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 22
    Visible = False
  end
  object CTRL_Z: TPanel
    Left = 210
    Top = 180
    Width = 200
    Height = 24
    Alignment = taLeftJustify
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Caption = 'CTRL+Z 输入单品'
    Color = 15655888
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Courier New'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 23
  end
  object CTRL_C: TPanel
    Left = 210
    Top = 205
    Width = 200
    Height = 24
    Alignment = taLeftJustify
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Caption = 'CTRL+C 发票张数修改'
    Color = 15655888
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Courier New'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 24
  end
  object CTRL_X: TPanel
    Left = 210
    Top = 230
    Width = 200
    Height = 24
    Alignment = taLeftJustify
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Caption = 'CTRL+X 重新登录'
    Color = 15655888
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Courier New'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 25
  end
  object CTRL_S: TPanel
    Left = 210
    Top = 255
    Width = 200
    Height = 24
    Alignment = taLeftJustify
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Caption = 'CTRL+S 检查个人信息'
    Color = 15655888
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Courier New'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 26
  end
  object CTRL_F5: TPanel
    Left = 415
    Top = 80
    Width = 200
    Height = 24
    Alignment = taLeftJustify
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Caption = 'CTRL+F5 用编号'
    Color = 16705279
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Courier New'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 27
  end
  object CTRL_F6: TPanel
    Left = 415
    Top = 105
    Width = 200
    Height = 24
    Alignment = taLeftJustify
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Caption = 'CTRL+F6 用姓名'
    Color = 16705279
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Courier New'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 28
  end
  object CTRL_F7: TPanel
    Left = 415
    Top = 130
    Width = 200
    Height = 24
    Alignment = taLeftJustify
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Caption = 'CTRL+F7 用电话'
    Color = 16705279
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Courier New'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 29
  end
  object CTRL_F8: TPanel
    Left = 415
    Top = 155
    Width = 200
    Height = 24
    Alignment = taLeftJustify
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Caption = 'CTRL+F8 用地址'
    Color = 16705279
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Courier New'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 30
  end
  object CTRL_F9: TPanel
    Left = 415
    Top = 205
    Width = 200
    Height = 24
    Alignment = taLeftJustify
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Caption = 'CTRL+F9 用编号'
    Color = 16771026
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Courier New'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 31
  end
  object CTRL_10: TPanel
    Left = 415
    Top = 230
    Width = 200
    Height = 24
    Alignment = taLeftJustify
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Caption = 'CTRL+F10 用名称'
    Color = 16771026
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Courier New'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 32
  end
  object CTRL_11: TPanel
    Left = 415
    Top = 255
    Width = 200
    Height = 24
    Alignment = taLeftJustify
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Caption = 'CTRL+F11 用厂商号'
    Color = 16771026
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Courier New'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 33
  end
  object CTRL_12: TPanel
    Left = 415
    Top = 280
    Width = 200
    Height = 24
    Alignment = taLeftJustify
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Caption = 'CTRL+F12 用分类号'
    Color = 16771026
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Courier New'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 34
  end
  object Label26: TPanel
    Left = 415
    Top = 55
    Width = 200
    Height = 24
    Alignment = taLeftJustify
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Caption = '查询会员'
    Color = 16705279
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Courier New'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 35
  end
  object CTRL_L: TPanel
    Left = 210
    Top = 5
    Width = 200
    Height = 24
    Alignment = taLeftJustify
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Caption = 'CTRL+L 总计去尾数'
    Color = 15655888
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Courier New'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 36
  end
  object Label27: TPanel
    Left = 415
    Top = 180
    Width = 200
    Height = 24
    Alignment = taLeftJustify
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Caption = '查询产品'
    Color = 16771026
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Courier New'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 37
  end
  object BTNQUT: TBitBtn
    Left = 190
    Top = 333
    Width = 250
    Height = 50
    Caption = '确定 ESC '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = BTNQUTClick
    OnKeyDown = BTNQUTKeyDown
    Kind = bkOK
  end
  object BTNCAL: TBitBtn
    Left = 595
    Top = 353
    Width = 250
    Height = 50
    Caption = '取消退出'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    Visible = False
    OnClick = BTNCALClick
    Kind = bkCancel
  end
  object Panel1: TPanel
    Left = 210
    Top = 280
    Width = 200
    Height = 24
    Alignment = taLeftJustify
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Caption = 'CTRL+H 查看快速键'
    Color = 15655888
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Courier New'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 38
  end
  object F_ESC: TPanel
    Left = 5
    Top = 5
    Width = 200
    Height = 24
    Alignment = taLeftJustify
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Caption = 'ESC 取消交易'
    Color = 15527379
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Courier New'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 2
  end
  object F_F1: TPanel
    Left = 5
    Top = 30
    Width = 200
    Height = 24
    Alignment = taLeftJustify
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Caption = 'F1 结帐'
    Color = 15527379
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Courier New'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 7
  end
  object F_F2: TPanel
    Left = 5
    Top = 55
    Width = 200
    Height = 24
    Alignment = taLeftJustify
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Caption = 'F2 开钱箱'
    Color = 15527379
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Courier New'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 8
  end
  object F_F3: TPanel
    Left = 5
    Top = 80
    Width = 200
    Height = 24
    Alignment = taLeftJustify
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Caption = 'F3 更改数量'
    Color = 15527379
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Courier New'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 9
  end
  object F_F4: TPanel
    Left = 5
    Top = 105
    Width = 200
    Height = 24
    Alignment = taLeftJustify
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Caption = 'F4 更改金额'
    Color = 15527379
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Courier New'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 10
  end
  object F_F5: TPanel
    Left = 5
    Top = 130
    Width = 200
    Height = 24
    Alignment = taLeftJustify
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Caption = 'F5 输入信用卡'
    Color = 15527379
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Courier New'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 11
  end
  object F_F6: TPanel
    Left = 5
    Top = 155
    Width = 200
    Height = 24
    Alignment = taLeftJustify
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Caption = 'F6 输入礼券'
    Color = 15527379
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Courier New'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 12
  end
  object F_F7: TPanel
    Left = 5
    Top = 180
    Width = 200
    Height = 24
    Alignment = taLeftJustify
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Caption = 'F7 输入统一编号'
    Color = 15527379
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Courier New'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 13
  end
  object F_F8: TPanel
    Left = 5
    Top = 205
    Width = 200
    Height = 24
    Alignment = taLeftJustify
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Caption = 'F8 输入会员'
    Color = 15527379
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Courier New'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 14
  end
  object F_F9: TPanel
    Left = 5
    Top = 230
    Width = 200
    Height = 24
    Alignment = taLeftJustify
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Caption = 'F9 输入折扣'
    Color = 15527379
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Courier New'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 15
  end
  object F_F10: TPanel
    Left = 5
    Top = 255
    Width = 200
    Height = 24
    Alignment = taLeftJustify
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Caption = 'F10 设置打折'
    Color = 15527379
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Courier New'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 16
  end
  object F_F11: TPanel
    Left = 5
    Top = 280
    Width = 200
    Height = 24
    Alignment = taLeftJustify
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Caption = 'F11存入取回暂存'
    Color = 15527379
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Courier New'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 17
  end
  object F_F12: TPanel
    Left = 5
    Top = 305
    Width = 200
    Height = 24
    Alignment = taLeftJustify
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Caption = 'F12 删除一笔'
    Color = 15527379
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Courier New'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 18
  end
  object MainMenu1: TMainMenu
    Left = 585
    object ESC: TMenuItem
      AutoHotkeys = maAutomatic
      AutoLineReduction = maAutomatic
      Caption = '取消交易ESC'
      ShortCut = 27
      Visible = False
      OnClick = BTNCALClick
    end
  end
end
