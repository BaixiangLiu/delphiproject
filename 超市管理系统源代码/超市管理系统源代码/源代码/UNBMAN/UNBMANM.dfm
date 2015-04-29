object FMBMANM: TFMBMANM
  Left = 175
  Top = 19
  BorderStyle = bsDialog
  Caption = '权限设置'
  ClientHeight = 467
  ClientWidth = 520
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = '宋体'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 521
    Height = 466
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Caption = ' '
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 0
    object BNENO: TLabel
      Left = 10
      Top = 8
      Width = 64
      Height = 20
      AutoSize = False
      Caption = '员工编号'
    end
    object BNNAM: TLabel
      Left = 80
      Top = 8
      Width = 64
      Height = 16
      Caption = '员工姓名'
    end
    object GroupBox1: TGroupBox
      Left = 190
      Top = 30
      Width = 70
      Height = 140
      Caption = '人事表'
      TabOrder = 0
      object ED_BMAN_OPEN: TCheckBox
        Left = 5
        Top = 20
        Width = 56
        Height = 17
        Caption = '打开'
        TabOrder = 0
      end
      object ED_BMAN_INS: TCheckBox
        Left = 5
        Top = 40
        Width = 56
        Height = 17
        Caption = '新增'
        TabOrder = 1
      end
      object ED_BMAN_UPD: TCheckBox
        Left = 5
        Top = 60
        Width = 56
        Height = 17
        Caption = '修改'
        TabOrder = 2
      end
      object ED_BMAN_DEL: TCheckBox
        Left = 5
        Top = 80
        Width = 56
        Height = 17
        Caption = '删除'
        TabOrder = 3
      end
      object ED_BMAN_SEA: TCheckBox
        Left = 5
        Top = 100
        Width = 56
        Height = 17
        Caption = '查询'
        TabOrder = 4
      end
      object ED_BMAN_PRN: TCheckBox
        Left = 5
        Top = 120
        Width = 56
        Height = 17
        Caption = '打印'
        TabOrder = 5
      end
    end
    object GroupBox2: TGroupBox
      Left = 190
      Top = 175
      Width = 70
      Height = 140
      Caption = '会员表'
      TabOrder = 1
      object ED_BMEM_OPEN: TCheckBox
        Left = 5
        Top = 20
        Width = 56
        Height = 17
        Caption = '打开'
        TabOrder = 0
      end
      object ED_BMEM_INS: TCheckBox
        Left = 5
        Top = 40
        Width = 56
        Height = 17
        Caption = '新增'
        TabOrder = 1
      end
      object ED_BMEM_UPD: TCheckBox
        Left = 5
        Top = 60
        Width = 56
        Height = 17
        Caption = '修改'
        TabOrder = 2
      end
      object ED_BMEM_DEL: TCheckBox
        Left = 5
        Top = 80
        Width = 56
        Height = 17
        Caption = '删除'
        TabOrder = 3
      end
      object ED_BMEM_SEA: TCheckBox
        Left = 5
        Top = 100
        Width = 56
        Height = 17
        Caption = '查询'
        TabOrder = 4
      end
      object ED_BMEM_PRN: TCheckBox
        Left = 5
        Top = 120
        Width = 56
        Height = 17
        Caption = '打印'
        TabOrder = 5
      end
    end
    object GroupBox3: TGroupBox
      Left = 115
      Top = 30
      Width = 70
      Height = 147
      Caption = '产品文件'
      TabOrder = 2
      object ED_BGDS_OPEN: TCheckBox
        Left = 5
        Top = 20
        Width = 56
        Height = 17
        Caption = '打开'
        TabOrder = 0
      end
      object ED_BGDS_INS: TCheckBox
        Left = 5
        Top = 40
        Width = 56
        Height = 17
        Caption = '新增'
        TabOrder = 1
      end
      object ED_BGDS_UPD: TCheckBox
        Left = 5
        Top = 60
        Width = 56
        Height = 17
        Caption = '修改'
        TabOrder = 2
      end
      object ED_BGDS_DEL: TCheckBox
        Left = 5
        Top = 80
        Width = 56
        Height = 17
        Caption = '删除'
        TabOrder = 3
      end
      object ED_BGDS_SEA: TCheckBox
        Left = 5
        Top = 100
        Width = 56
        Height = 17
        Caption = '查询'
        TabOrder = 4
      end
      object ED_BGDS_PRN: TCheckBox
        Left = 5
        Top = 120
        Width = 56
        Height = 17
        Caption = '打印'
        TabOrder = 5
      end
    end
    object GroupBox4: TGroupBox
      Left = 265
      Top = 30
      Width = 70
      Height = 140
      Caption = '厂商表'
      TabOrder = 3
      object ED_BSUP_OPEN: TCheckBox
        Left = 5
        Top = 20
        Width = 56
        Height = 17
        Caption = '打开'
        TabOrder = 0
      end
      object ED_BSUP_INS: TCheckBox
        Left = 5
        Top = 40
        Width = 56
        Height = 17
        Caption = '新增'
        TabOrder = 1
      end
      object ED_BSUP_UPD: TCheckBox
        Left = 5
        Top = 60
        Width = 56
        Height = 17
        Caption = '修改'
        TabOrder = 2
      end
      object ED_BSUP_DEL: TCheckBox
        Left = 5
        Top = 80
        Width = 56
        Height = 17
        Caption = '删除'
        TabOrder = 3
      end
      object ED_BSUP_SEA: TCheckBox
        Left = 5
        Top = 100
        Width = 56
        Height = 17
        Caption = '查询'
        TabOrder = 4
      end
      object ED_BSUP_PRN: TCheckBox
        Left = 5
        Top = 120
        Width = 56
        Height = 17
        Caption = '打印'
        TabOrder = 5
      end
    end
    object GroupBox5: TGroupBox
      Left = 265
      Top = 175
      Width = 70
      Height = 140
      Caption = '客户表'
      TabOrder = 4
      object ED_BCST_OPEN: TCheckBox
        Left = 5
        Top = 20
        Width = 56
        Height = 17
        Caption = '打开'
        TabOrder = 0
      end
      object ED_BCST_INS: TCheckBox
        Left = 5
        Top = 40
        Width = 56
        Height = 17
        Caption = '新增'
        TabOrder = 1
      end
      object ED_BCST_UPD: TCheckBox
        Left = 5
        Top = 60
        Width = 56
        Height = 17
        Caption = '修改'
        TabOrder = 2
      end
      object ED_BCST_DEL: TCheckBox
        Left = 5
        Top = 80
        Width = 56
        Height = 17
        Caption = '删除'
        TabOrder = 3
      end
      object ED_BCST_SEA: TCheckBox
        Left = 5
        Top = 100
        Width = 56
        Height = 17
        Caption = '查询'
        TabOrder = 4
      end
      object ED_BCST_PRN: TCheckBox
        Left = 5
        Top = 120
        Width = 56
        Height = 17
        Caption = '打印'
        TabOrder = 5
      end
    end
    object GroupBox6: TGroupBox
      Left = 10
      Top = 30
      Width = 100
      Height = 211
      Caption = '主系统'
      TabOrder = 5
      object ED_SYS_POS: TCheckBox
        Left = 5
        Top = 20
        Width = 90
        Height = 17
        Caption = '前台激活'
        TabOrder = 0
      end
      object ED_SYS_POSA: TCheckBox
        Left = 5
        Top = 40
        Width = 90
        Height = 17
        Caption = '后台激活'
        TabOrder = 1
      end
      object ED_SET_MAINS: TCheckBox
        Left = 5
        Top = 75
        Width = 90
        Height = 17
        Caption = '系统设置'
        TabOrder = 2
      end
      object ED_SET_HARD: TCheckBox
        Left = 5
        Top = 150
        Width = 90
        Height = 17
        Caption = '硬件设置'
        TabOrder = 3
      end
      object ED_SET_PMS: TCheckBox
        Left = 5
        Top = 95
        Width = 90
        Height = 17
        Caption = '权限设置'
        TabOrder = 4
      end
      object ED_SET_PASSWD: TCheckBox
        Left = 5
        Top = 115
        Width = 90
        Height = 17
        Caption = '密码设置'
        TabOrder = 5
      end
      object ED_SET_LABEL: TCheckBox
        Left = 5
        Top = 170
        Width = 90
        Height = 17
        Caption = '标签排版'
        TabOrder = 6
      end
    end
    object GroupBox7: TGroupBox
      Left = 190
      Top = 320
      Width = 70
      Height = 140
      Caption = '特价表'
      TabOrder = 6
      object ED_POSM_OPEN: TCheckBox
        Left = 5
        Top = 20
        Width = 56
        Height = 17
        Caption = '打开'
        TabOrder = 0
      end
      object ED_POSM_INS: TCheckBox
        Left = 5
        Top = 40
        Width = 56
        Height = 17
        Caption = '新增'
        TabOrder = 1
      end
      object ED_POSM_UPD: TCheckBox
        Left = 5
        Top = 60
        Width = 56
        Height = 17
        Caption = '修改'
        TabOrder = 2
      end
      object ED_POSM_DEL: TCheckBox
        Left = 5
        Top = 80
        Width = 56
        Height = 17
        Caption = '删除'
        TabOrder = 3
      end
      object ED_POSM_SEA: TCheckBox
        Left = 5
        Top = 100
        Width = 56
        Height = 17
        Caption = '查询'
        TabOrder = 4
      end
      object ED_POSM_PRN: TCheckBox
        Left = 5
        Top = 120
        Width = 56
        Height = 17
        Caption = '打印'
        TabOrder = 5
      end
    end
    object GroupBox8: TGroupBox
      Left = 265
      Top = 320
      Width = 70
      Height = 140
      Caption = '组合文件'
      TabOrder = 7
      object ED_POSN_OPEN: TCheckBox
        Left = 5
        Top = 20
        Width = 56
        Height = 17
        Caption = '打开'
        TabOrder = 0
      end
      object ED_POSN_INS: TCheckBox
        Left = 5
        Top = 40
        Width = 56
        Height = 17
        Caption = '新增'
        TabOrder = 1
      end
      object ED_POSN_UPD: TCheckBox
        Left = 5
        Top = 60
        Width = 56
        Height = 17
        Caption = '修改'
        TabOrder = 2
      end
      object ED_POSN_DEL: TCheckBox
        Left = 5
        Top = 80
        Width = 56
        Height = 17
        Caption = '删除'
        TabOrder = 3
      end
      object ED_POSN_SEA: TCheckBox
        Left = 5
        Top = 100
        Width = 56
        Height = 17
        Caption = '查询'
        TabOrder = 4
      end
      object ED_POSN_PRN: TCheckBox
        Left = 5
        Top = 120
        Width = 56
        Height = 17
        Caption = '打印'
        TabOrder = 5
      end
    end
    object GroupBox9: TGroupBox
      Left = 345
      Top = 30
      Width = 80
      Height = 140
      Caption = '进货表'
      TabOrder = 8
      object ED_RCIN_OPEN: TCheckBox
        Left = 5
        Top = 20
        Width = 56
        Height = 17
        Caption = '打开'
        TabOrder = 0
      end
      object ED_RCIN_INS: TCheckBox
        Left = 5
        Top = 40
        Width = 56
        Height = 17
        Caption = '新增'
        TabOrder = 1
      end
      object ED_RCIN_UPD: TCheckBox
        Left = 5
        Top = 60
        Width = 56
        Height = 17
        Caption = '修改'
        TabOrder = 2
      end
      object ED_RCIN_DEL: TCheckBox
        Left = 5
        Top = 80
        Width = 56
        Height = 17
        Caption = '删除'
        TabOrder = 3
      end
      object ED_RCIN_SEA: TCheckBox
        Left = 5
        Top = 100
        Width = 56
        Height = 17
        Caption = '查询'
        TabOrder = 4
      end
      object ED_RCIN_PRN: TCheckBox
        Left = 5
        Top = 120
        Width = 56
        Height = 17
        Caption = '打印'
        TabOrder = 5
      end
    end
    object GroupBox10: TGroupBox
      Left = 430
      Top = 30
      Width = 80
      Height = 140
      Caption = '进货退出'
      TabOrder = 9
      object ED_RCJN_OPEN: TCheckBox
        Left = 5
        Top = 20
        Width = 56
        Height = 17
        Caption = '打开'
        TabOrder = 0
      end
      object ED_RCJN_INS: TCheckBox
        Left = 5
        Top = 40
        Width = 56
        Height = 17
        Caption = '新增'
        TabOrder = 1
      end
      object ED_RCJN_UPD: TCheckBox
        Left = 5
        Top = 60
        Width = 56
        Height = 17
        Caption = '修改'
        TabOrder = 2
      end
      object ED_RCJN_DEL: TCheckBox
        Left = 5
        Top = 80
        Width = 56
        Height = 17
        Caption = '删除'
        TabOrder = 3
      end
      object ED_RCJN_SEA: TCheckBox
        Left = 5
        Top = 100
        Width = 56
        Height = 17
        Caption = '查询'
        TabOrder = 4
      end
      object ED_RCJN_PRN: TCheckBox
        Left = 5
        Top = 120
        Width = 56
        Height = 17
        Caption = '打印'
        TabOrder = 5
      end
    end
    object GroupBox11: TGroupBox
      Left = 345
      Top = 175
      Width = 166
      Height = 285
      Caption = '报表'
      TabOrder = 10
      object ED_RPT_POSD: TCheckBox
        Left = 5
        Top = 20
        Width = 160
        Height = 17
        Caption = '柜台销售日报表'
        TabOrder = 0
      end
      object ED_RPT_POS1: TCheckBox
        Left = 5
        Top = 40
        Width = 160
        Height = 17
        Caption = '销售记录明细表'
        TabOrder = 1
      end
      object ED_RPT_POS2: TCheckBox
        Left = 5
        Top = 60
        Width = 160
        Height = 17
        Caption = '发票记录明细表'
        TabOrder = 2
      end
      object ED_RPT_POS3: TCheckBox
        Left = 5
        Top = 80
        Width = 160
        Height = 17
        Caption = '会员消费明细表'
        TabOrder = 3
      end
      object ED_RPT_POS5: TCheckBox
        Left = 5
        Top = 100
        Width = 160
        Height = 17
        Caption = '会员消费计算报表'
        TabOrder = 4
      end
      object ED_RPT_POS6: TCheckBox
        Left = 5
        Top = 120
        Width = 160
        Height = 17
        Caption = '产品销售计算报表'
        TabOrder = 5
      end
      object ED_RPT_POS7: TCheckBox
        Left = 5
        Top = 140
        Width = 160
        Height = 17
        Caption = '礼券刷卡明细表'
        TabOrder = 6
      end
      object ED_RPT_TOP1: TCheckBox
        Left = 5
        Top = 160
        Width = 160
        Height = 17
        Caption = '产品销售排行'
        TabOrder = 7
      end
      object ED_RPT_TOP2: TCheckBox
        Left = 5
        Top = 180
        Width = 160
        Height = 17
        Caption = '会员消费排行'
        TabOrder = 8
      end
      object ED_RPT_TOP3: TCheckBox
        Left = 5
        Top = 200
        Width = 160
        Height = 17
        Caption = '客户批发排行'
        TabOrder = 9
      end
      object ED_RPT_POS667: TCheckBox
        Left = 5
        Top = 243
        Width = 160
        Height = 17
        Caption = '产品销售统计表'
        TabOrder = 10
        Visible = False
      end
      object ED_RPT_LOG: TCheckBox
        Left = 5
        Top = 219
        Width = 160
        Height = 17
        Caption = '使用者使用记录'
        TabOrder = 11
      end
    end
    object BitBtn1: TBitBtn
      Left = 17
      Top = 301
      Width = 56
      Height = 25
      Caption = '全　选'
      TabOrder = 11
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 81
      Top = 301
      Width = 57
      Height = 25
      Caption = '全不选'
      TabOrder = 12
      OnClick = BitBtn2Click
    end
    object BTNQUT: TBitBtn
      Left = 16
      Top = 342
      Width = 120
      Height = 30
      Caption = '确定存盘'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
      TabOrder = 13
      OnClick = BTNQUTClick
      Kind = bkOK
    end
    object BTNCAL: TBitBtn
      Left = 16
      Top = 386
      Width = 120
      Height = 30
      Caption = '取消退出'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
      TabOrder = 14
      OnClick = BTNCALClick
      Kind = bkCancel
    end
    object GroupBox12: TGroupBox
      Left = 112
      Top = 182
      Width = 73
      Height = 99
      Caption = '盘点'
      TabOrder = 15
      Visible = False
      object ED_IVTX_OPEN: TCheckBox
        Left = 5
        Top = 20
        Width = 56
        Height = 17
        Caption = '打开'
        TabOrder = 0
      end
    end
  end
end
