object FMKCLR: TFMKCLR
  Left = 243
  Top = 154
  AutoScroll = False
  Caption = '历史数据处理'
  ClientHeight = 370
  ClientWidth = 551
  Color = 14334631
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '宋体'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 12
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 551
    Height = 331
    ActivePage = PAGE_A
    HotTrack = True
    MultiLine = True
    TabOrder = 0
    TabWidth = 180
    object PAGE_A: TTabSheet
      Caption = '调整基本资料'
      object GroupBox1: TGroupBox
        Left = 5
        Top = 0
        Width = 500
        Height = 56
        Caption = '调整产品标准价格'
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 0
        object Label7: TLabel
          Left = 15
          Top = 27
          Width = 174
          Height = 12
          Caption = '调整                        %'
        end
        object ED_BGPST: TJEdit
          Left = 51
          Top = 23
          Width = 60
          Height = 18
          TabOrder = 0
          Digits = 1
          Max = 999999999
          _EditType = INTEGER_EDIT
          _SHOWCAL = NONE
          _BADINPUT = False
          _LONGTIME = False
        end
        object BTNBGPST: TBitBtn
          Left = 135
          Top = 22
          Width = 120
          Height = 26
          Caption = '调整'
          TabOrder = 1
          OnClick = BTNBGPSTClick
        end
        object BTNBMBYR: TBitBtn
          Left = 270
          Top = 22
          Width = 120
          Height = 26
          Caption = '清除会员年度消费'
          TabOrder = 2
          OnClick = BTNBMBYRClick
        end
      end
      object GroupBox8: TGroupBox
        Left = 5
        Top = 60
        Width = 500
        Height = 56
        Caption = '调整产品会员价格'
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 1
        object Label8: TLabel
          Left = 15
          Top = 27
          Width = 174
          Height = 12
          Caption = '调整                        %'
        end
        object ED_BGPMM: TJEdit
          Left = 51
          Top = 22
          Width = 60
          Height = 18
          TabOrder = 0
          Digits = 1
          Max = 999999999
          _EditType = INTEGER_EDIT
          _SHOWCAL = NONE
          _BADINPUT = False
          _LONGTIME = False
        end
        object BTNBGPMM: TBitBtn
          Left = 135
          Top = 22
          Width = 120
          Height = 26
          Caption = '调整'
          TabOrder = 1
          OnClick = BTNBGPMMClick
        end
        object BTNBMBTM: TBitBtn
          Left = 270
          Top = 22
          Width = 120
          Height = 26
          Caption = '清除会员购买次数'
          TabOrder = 2
          OnClick = BTNBMBTMClick
        end
      end
      object GroupBox9: TGroupBox
        Left = 5
        Top = 120
        Width = 500
        Height = 56
        Caption = '调整产品贵宾价格'
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 2
        object Label9: TLabel
          Left = 15
          Top = 27
          Width = 174
          Height = 12
          Caption = '调整                        %'
        end
        object ED_BGPVP: TJEdit
          Left = 51
          Top = 22
          Width = 60
          Height = 18
          TabOrder = 0
          Digits = 1
          Max = 999999999
          _EditType = INTEGER_EDIT
          _SHOWCAL = NONE
          _BADINPUT = False
          _LONGTIME = False
        end
        object BTNBGPVP: TBitBtn
          Left = 135
          Top = 22
          Width = 120
          Height = 26
          Caption = '调整'
          TabOrder = 1
          OnClick = BTNBGPVPClick
        end
        object BTNBMBPO: TBitBtn
          Left = 270
          Top = 22
          Width = 120
          Height = 26
          Caption = '清除会员赚买点数'
          TabOrder = 2
          OnClick = BTNBMBPOClick
        end
      end
      object GroupBox16: TGroupBox
        Left = 5
        Top = 180
        Width = 500
        Height = 56
        Caption = '基本资料重整'
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 3
        object Label16: TLabel
          Left = 15
          Top = 27
          Width = 174
          Height = 12
          Caption = '调整                        %'
        end
        object Gauge: TGauge
          Left = 51
          Top = 22
          Width = 60
          Height = 22
          ForeColor = clRed
          Progress = 0
        end
        object BTNREBUILD: TButton
          Left = 135
          Top = 22
          Width = 120
          Height = 26
          Caption = '产品资料重整'
          TabOrder = 0
          OnClick = BTNREBUILDClick
        end
      end
    end
    object PABE_B: TTabSheet
      Caption = '删除基本资料'
      ImageIndex = 1
      object GroupBox2: TGroupBox
        Left = 5
        Top = 0
        Width = 261
        Height = 45
        Caption = '盘点表'
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 0
        object Label1: TLabel
          Left = 15
          Top = 20
          Width = 60
          Height = 12
          Caption = '请输入日期'
        end
        object BitBtn2: TBitBtn
          Left = 155
          Top = 16
          Width = 96
          Height = 24
          Caption = '删除日期以前'
          TabOrder = 0
          OnClick = BitBtn2Click
        end
        object ED_IVTA: TJEdit
          Left = 90
          Top = 16
          Width = 61
          Height = 18
          TabOrder = 1
          Digits = 1
          Max = 999999999
          _EditType = EDATE_EDIT
          _SHOWCAL = NONE
          _BADINPUT = False
          _LONGTIME = False
        end
      end
      object GroupBox3: TGroupBox
        Left = 5
        Top = 150
        Width = 261
        Height = 45
        Caption = '盘点保存'
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 1
        object Label2: TLabel
          Left = 15
          Top = 20
          Width = 60
          Height = 12
          Caption = '请输入日期'
        end
        object BitBtn3: TBitBtn
          Left = 155
          Top = 16
          Width = 96
          Height = 24
          Caption = '删除日期以前'
          TabOrder = 0
          OnClick = BitBtn3Click
        end
        object ED_IVTT: TJEdit
          Left = 90
          Top = 16
          Width = 61
          Height = 18
          TabOrder = 1
          Digits = 1
          Max = 999999999
          _EditType = EDATE_EDIT
          _SHOWCAL = NONE
          _BADINPUT = False
          _LONGTIME = False
        end
      end
      object GroupBox4: TGroupBox
        Left = 5
        Top = 50
        Width = 261
        Height = 45
        Caption = '快速入库记录文件'
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 2
        object Label3: TLabel
          Left = 15
          Top = 20
          Width = 60
          Height = 12
          Caption = '请输入日期'
        end
        object BitBtn4: TBitBtn
          Left = 155
          Top = 16
          Width = 96
          Height = 24
          Caption = '删除日期以前'
          TabOrder = 0
          OnClick = BitBtn4Click
        end
        object ED_RQKI: TJEdit
          Left = 90
          Top = 16
          Width = 61
          Height = 18
          TabOrder = 1
          Digits = 1
          Max = 999999999
          _EditType = EDATE_EDIT
          _SHOWCAL = NONE
          _BADINPUT = False
          _LONGTIME = False
        end
      end
      object GroupBox5: TGroupBox
        Left = 5
        Top = 200
        Width = 261
        Height = 45
        Caption = '快速出库记录文件'
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 3
        object Label4: TLabel
          Left = 15
          Top = 20
          Width = 60
          Height = 12
          Caption = '请输入日期'
        end
        object BitBtn5: TBitBtn
          Left = 155
          Top = 16
          Width = 96
          Height = 24
          Caption = '删除日期以前'
          TabOrder = 0
          OnClick = BitBtn5Click
        end
        object ED_RQKO: TJEdit
          Left = 90
          Top = 16
          Width = 61
          Height = 18
          TabOrder = 1
          Digits = 1
          Max = 999999999
          _EditType = EDATE_EDIT
          _SHOWCAL = NONE
          _BADINPUT = False
          _LONGTIME = False
        end
      end
      object GroupBox6: TGroupBox
        Left = 5
        Top = 100
        Width = 261
        Height = 45
        Caption = '总分店传输记录文件'
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 4
        object Label5: TLabel
          Left = 15
          Top = 20
          Width = 60
          Height = 12
          Caption = '请输入日期'
        end
        object BitBtn6: TBitBtn
          Left = 155
          Top = 16
          Width = 96
          Height = 24
          Caption = '删除日期以前'
          TabOrder = 0
          OnClick = BitBtn6Click
        end
        object ED_MTBA: TJEdit
          Left = 90
          Top = 16
          Width = 61
          Height = 18
          TabOrder = 1
          Digits = 1
          Max = 999999999
          _EditType = EDATE_EDIT
          _SHOWCAL = NONE
          _BADINPUT = False
          _LONGTIME = False
        end
      end
      object GroupBox7: TGroupBox
        Left = 5
        Top = 250
        Width = 261
        Height = 45
        Caption = '收款台销售记录文件'
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 5
        object Label6: TLabel
          Left = 15
          Top = 20
          Width = 60
          Height = 12
          Caption = '请输入日期'
        end
        object BitBtn7: TBitBtn
          Left = 155
          Top = 16
          Width = 96
          Height = 24
          Caption = '删除日期以前'
          TabOrder = 0
          OnClick = BitBtn7Click
        end
        object ED_POSA: TJEdit
          Left = 90
          Top = 16
          Width = 61
          Height = 18
          TabOrder = 1
          Digits = 1
          Max = 999999999
          _EditType = EDATE_EDIT
          _SHOWCAL = NONE
          _BADINPUT = False
          _LONGTIME = False
        end
      end
      object GroupBox10: TGroupBox
        Left = 275
        Top = 0
        Width = 261
        Height = 45
        Caption = '登入记录文件'
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 6
        object Label10: TLabel
          Left = 15
          Top = 20
          Width = 60
          Height = 12
          Caption = '请输入日期'
        end
        object BTNSYSLOGSLG: TBitBtn
          Left = 155
          Top = 16
          Width = 96
          Height = 24
          Caption = '删除日期以前'
          TabOrder = 0
          OnClick = BTNSYSLOGSLGClick
        end
        object ED_SYSLOGSLG: TJEdit
          Left = 90
          Top = 16
          Width = 61
          Height = 18
          TabOrder = 1
          Digits = 1
          Max = 999999999
          _EditType = EDATE_EDIT
          _SHOWCAL = NONE
          _BADINPUT = False
          _LONGTIME = False
        end
      end
      object GroupBox11: TGroupBox
        Left = 275
        Top = 50
        Width = 261
        Height = 45
        Caption = '改密码记录文件'
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 7
        object Label11: TLabel
          Left = 15
          Top = 20
          Width = 60
          Height = 12
          Caption = '请输入日期'
        end
        object BTNSYSLOGSPW: TBitBtn
          Left = 155
          Top = 16
          Width = 96
          Height = 24
          Caption = '删除日期以前'
          TabOrder = 0
          OnClick = BTNSYSLOGSLGClick
        end
        object ED_SYSLOGSPW: TJEdit
          Left = 90
          Top = 16
          Width = 61
          Height = 18
          TabOrder = 1
          Digits = 1
          Max = 999999999
          _EditType = EDATE_EDIT
          _SHOWCAL = NONE
          _BADINPUT = False
          _LONGTIME = False
        end
      end
      object GroupBox12: TGroupBox
        Left = 275
        Top = 100
        Width = 261
        Height = 45
        Caption = '改权限记录文件'
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 8
        object Label12: TLabel
          Left = 15
          Top = 20
          Width = 60
          Height = 12
          Caption = '请输入日期'
        end
        object BTNSYSLOGSPM: TBitBtn
          Left = 155
          Top = 16
          Width = 96
          Height = 24
          Caption = '删除日期以前'
          TabOrder = 0
          OnClick = BTNSYSLOGSLGClick
        end
        object ED_SYSLOGSPM: TJEdit
          Left = 90
          Top = 16
          Width = 61
          Height = 18
          TabOrder = 1
          Digits = 1
          Max = 999999999
          _EditType = EDATE_EDIT
          _SHOWCAL = NONE
          _BADINPUT = False
          _LONGTIME = False
        end
      end
      object GroupBox13: TGroupBox
        Left = 275
        Top = 150
        Width = 261
        Height = 45
        Caption = '开钱箱记录文件'
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 9
        object Label13: TLabel
          Left = 15
          Top = 20
          Width = 60
          Height = 12
          Caption = '请输入日期'
        end
        object BTNSYSLOGCBX: TBitBtn
          Left = 155
          Top = 16
          Width = 96
          Height = 24
          Caption = '删除日期以前'
          TabOrder = 0
          OnClick = BTNSYSLOGSLGClick
        end
        object ED_SYSLOGCBX: TJEdit
          Left = 90
          Top = 16
          Width = 61
          Height = 18
          TabOrder = 1
          Digits = 1
          Max = 999999999
          _EditType = EDATE_EDIT
          _SHOWCAL = NONE
          _BADINPUT = False
          _LONGTIME = False
        end
      end
      object GroupBox14: TGroupBox
        Left = 275
        Top = 200
        Width = 261
        Height = 45
        Caption = '备份资料记录文件'
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 10
        object Label14: TLabel
          Left = 15
          Top = 20
          Width = 60
          Height = 12
          Caption = '请输入日期'
        end
        object BTNSYSLOGBAK: TBitBtn
          Left = 155
          Top = 16
          Width = 96
          Height = 24
          Caption = '删除日期以前'
          TabOrder = 0
          OnClick = BTNSYSLOGSLGClick
        end
        object ED_SYSLOGBAK: TJEdit
          Left = 90
          Top = 16
          Width = 61
          Height = 18
          TabOrder = 1
          Digits = 1
          Max = 999999999
          _EditType = EDATE_EDIT
          _SHOWCAL = NONE
          _BADINPUT = False
          _LONGTIME = False
        end
      end
      object GroupBox15: TGroupBox
        Left = 275
        Top = 250
        Width = 261
        Height = 45
        Caption = '全部记录文件'
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 11
        object Label15: TLabel
          Left = 15
          Top = 20
          Width = 60
          Height = 12
          Caption = '请输入日期'
        end
        object BTNSYSLOGALL: TBitBtn
          Left = 155
          Top = 16
          Width = 96
          Height = 24
          Caption = '删除日期以前'
          TabOrder = 0
          OnClick = BTNSYSLOGSLGClick
        end
        object ED_SYSLOGALL: TJEdit
          Left = 90
          Top = 16
          Width = 61
          Height = 18
          TabOrder = 1
          Digits = 1
          Max = 999999999
          _EditType = EDATE_EDIT
          _SHOWCAL = NONE
          _BADINPUT = False
          _LONGTIME = False
        end
      end
    end
    object TabSheet1: TTabSheet
      Caption = '基本资料备份'
      ImageIndex = 3
    end
  end
  object BTNQUT: TBitBtn
    Left = 0
    Top = 330
    Width = 551
    Height = 41
    Caption = '结         束'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -32
    Font.Name = '新宋体'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = BTNQUTClick
  end
end
