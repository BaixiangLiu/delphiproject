object FMBMAN: TFMBMAN
  Left = 152
  Top = 26
  AutoScroll = False
  Caption = '人事信息'
  ClientHeight = 495
  ClientWidth = 595
  Color = 15648684
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = '宋体'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object StatusBar: TStatusBar
    Left = 0
    Top = 476
    Width = 595
    Height = 19
    Panels = <
      item
        Alignment = taCenter
        Width = 120
      end
      item
        Width = 120
      end>
    SimplePanel = False
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 595
    Height = 476
    Align = alClient
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Caption = ' '
    Color = cl3DLight
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = '宋体'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 1
    object Page: TPageControl
      Left = 1
      Top = 0
      Width = 335
      Height = 450
      ActivePage = PAGE_A
      Style = tsFlatButtons
      TabOrder = 0
      TabWidth = 155
      object PAGE_A: TTabSheet
        Caption = '个人资料'
        object LBBNCNA: TLabel
          Left = 2
          Top = 48
          Width = 48
          Height = 12
          Caption = '英文姓名'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object LBBNBTH: TLabel
          Left = 165
          Top = 48
          Width = 48
          Height = 12
          Caption = '出生日期'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object LBBNCTY: TLabel
          Left = 165
          Top = 108
          Width = 48
          Height = 12
          Caption = '国    籍'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object LBBNROT: TLabel
          Left = 2
          Top = 108
          Width = 48
          Height = 12
          Caption = '籍    贯'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object LBBNIDN: TLabel
          Left = 2
          Top = 88
          Width = 48
          Height = 12
          Caption = '身份证号'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object LBBNPAS: TLabel
          Left = 165
          Top = 188
          Width = 48
          Height = 12
          Caption = '护照号码'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object LBBNLIV: TLabel
          Left = 2
          Top = 188
          Width = 48
          Height = 12
          Caption = '居留字号'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object LBBNSEX: TLabel
          Left = 2
          Top = 68
          Width = 48
          Height = 12
          Caption = '性　　别'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object LBBNBLD: TLabel
          Left = 165
          Top = 68
          Width = 48
          Height = 12
          Caption = '血　　型'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object LBBNSCS: TLabel
          Left = 2
          Top = 128
          Width = 48
          Height = 12
          Caption = '学历代号'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object LBBNSDP: TLabel
          Left = 165
          Top = 128
          Width = 48
          Height = 12
          Caption = '科别系所'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object LBBNCPL: TLabel
          Left = 165
          Top = 88
          Width = 48
          Height = 12
          Caption = '婚　　姻'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object LBBNSCH: TLabel
          Left = 2
          Top = 148
          Width = 48
          Height = 12
          Caption = '学校名称'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object LBBNHIS: TLabel
          Left = 2
          Top = 168
          Width = 48
          Height = 12
          Caption = '经    历'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object LBBNCMN: TLabel
          Left = 2
          Top = 223
          Width = 48
          Height = 12
          Caption = '联 络 人'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object LBBNREL: TLabel
          Left = 165
          Top = 223
          Width = 48
          Height = 12
          Caption = '关　　系'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object LBBNTL1: TLabel
          Left = 2
          Top = 243
          Width = 48
          Height = 12
          Caption = '联络电话'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object LBBNTL2: TLabel
          Left = 2
          Top = 313
          Width = 48
          Height = 12
          Caption = '户籍电话'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object LBBNTL3: TLabel
          Left = 2
          Top = 273
          Width = 48
          Height = 12
          Caption = '通讯电话'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object LBBNAD1: TLabel
          Left = 2
          Top = 293
          Width = 48
          Height = 12
          Caption = '通讯地址'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object LBBNVIC: TLabel
          Left = 2
          Top = 353
          Width = 48
          Height = 12
          Caption = '交通工具'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object LBBNVIN: TLabel
          Left = 165
          Top = 353
          Width = 48
          Height = 12
          Caption = '车牌号码'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object LBBNAD2: TLabel
          Left = 2
          Top = 333
          Width = 48
          Height = 12
          Caption = '户籍地址'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object LBBNZP2: TLabel
          Left = 165
          Top = 313
          Width = 72
          Height = 12
          Caption = '户籍邮政编码'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object LBBNZP1: TLabel
          Left = 165
          Top = 273
          Width = 72
          Height = 12
          Caption = '通讯邮政编码'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object Bevel1: TBevel
          Left = 0
          Top = 202
          Width = 336
          Height = 11
          Shape = bsBottomLine
        end
        object Bevel2: TBevel
          Left = 1
          Top = 255
          Width = 336
          Height = 11
          Shape = bsBottomLine
        end
        object LBBNENO: TLabel
          Left = 2
          Top = 8
          Width = 48
          Height = 12
          Caption = '员工编号'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object LBBNNAM: TLabel
          Left = 2
          Top = 28
          Width = 48
          Height = 12
          Caption = '中文姓名'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object LBBNPWD: TLabel
          Left = 165
          Top = 28
          Width = 48
          Height = 12
          Caption = '登录密码'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object LB_MAX: TLabel
          Left = 0
          Top = 399
          Width = 60
          Height = 15
          Caption = '最大编号'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -15
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
          Visible = False
        end
        object BNCNA: TJDBEdit
          Left = 56
          Top = 45
          Width = 100
          Height = 19
          DataField = 'BNCNA'
          ImeName = '中文 (简体) - 微软拼音'
          TabOrder = 3
          _EditType = EDIT
          _SHOWCAL = NONE
        end
        object BNBTH: TJDBEdit
          Left = 224
          Top = 45
          Width = 100
          Height = 19
          DataField = 'BNBTH'
          ImeName = '中文 (简体) - 微软拼音'
          TabOrder = 4
          _EditType = EDATE_EDIT
          _SHOWCAL = NONE
        end
        object BNROT: TJDBEdit
          Left = 56
          Top = 105
          Width = 100
          Height = 19
          DataField = 'BNROT'
          ImeName = '中文 (简体) - 微软拼音'
          TabOrder = 9
          _EditType = EDIT
          _SHOWCAL = NONE
        end
        object BNIDN: TJDBEdit
          Left = 56
          Top = 85
          Width = 100
          Height = 19
          DataField = 'BNIDN'
          ImeName = '中文 (简体) - 微软拼音'
          TabOrder = 7
          _EditType = EDIT
          _SHOWCAL = NONE
        end
        object BNPAS: TJDBEdit
          Left = 224
          Top = 185
          Width = 100
          Height = 19
          DataField = 'BNPAS'
          ImeName = '中文 (简体) - 微软拼音'
          TabOrder = 16
          _EditType = EDIT
          _SHOWCAL = NONE
        end
        object BNLIV: TJDBEdit
          Left = 56
          Top = 185
          Width = 100
          Height = 19
          DataField = 'BNLIV'
          ImeName = '中文 (简体) - 微软拼音'
          TabOrder = 15
          _EditType = EDIT
          _SHOWCAL = NONE
        end
        object BNSCH: TJDBEdit
          Left = 56
          Top = 145
          Width = 265
          Height = 19
          DataField = 'BNSCH'
          ImeName = '中文 (简体) - 微软拼音'
          TabOrder = 13
          _EditType = EDIT
          _SHOWCAL = NONE
        end
        object BNHIS: TJDBEdit
          Left = 56
          Top = 165
          Width = 265
          Height = 19
          DataField = 'BNHIS'
          ImeName = '中文 (简体) - 微软拼音'
          TabOrder = 14
          _EditType = EDIT
          _SHOWCAL = NONE
        end
        object BNSCS: JDBLOOKUPBOX
          Left = 56
          Top = 125
          Width = 100
          Height = 19
          DataField = 'BNSCS'
          ImeName = '中文 (简体) - 微软拼音'
          MaxLength = 20
          TabOrder = 11
          _DatabaseName = 'MAIN'
          _TableName = 'SYSLST'
          _Field_IDNO = 'LSTID2'
          _Field_NAME = 'LSTNAM'
          _Field_KEY1 = 'LSTID1'
          _Field_KEY2 = 'BMANBNSCS'
          _EDIT_WIDTH = 30
          _CHANGE_QUERY = True
          _INSERT_RECORD = True
          _INSERT_SYSLST = 'BMANBNSCS'
          _SHOW_MESSAGE = True
        end
        object BNCMN: TJDBEdit
          Left = 56
          Top = 220
          Width = 100
          Height = 19
          DataField = 'BNCMN'
          ImeName = '中文 (简体) - 微软拼音'
          TabOrder = 17
          _EditType = EDIT
          _SHOWCAL = NONE
        end
        object BNREL: TJDBEdit
          Left = 224
          Top = 220
          Width = 100
          Height = 19
          DataField = 'BNREL'
          ImeName = '中文 (简体) - 微软拼音'
          TabOrder = 18
          _EditType = EDIT
          _SHOWCAL = NONE
        end
        object BNTL1: TJDBEdit
          Left = 56
          Top = 240
          Width = 100
          Height = 19
          DataField = 'BNTL1'
          ImeName = '中文 (简体) - 微软拼音'
          TabOrder = 19
          _EditType = EDIT
          _SHOWCAL = NONE
        end
        object BNTL3: TJDBEdit
          Left = 56
          Top = 270
          Width = 100
          Height = 19
          DataField = 'BNTL3'
          ImeName = '中文 (简体) - 微软拼音'
          TabOrder = 20
          _EditType = EDIT
          _SHOWCAL = NONE
        end
        object BNAD1: TJDBEdit
          Left = 56
          Top = 290
          Width = 266
          Height = 19
          DataField = 'BNAD1'
          ImeName = '中文 (简体) - 微软拼音'
          TabOrder = 22
          _EditType = EDIT
          _SHOWCAL = NONE
        end
        object BNVIN: TJDBEdit
          Left = 222
          Top = 350
          Width = 100
          Height = 19
          DataField = 'BNVIN'
          ImeName = '中文 (简体) - 微软拼音'
          TabOrder = 27
          _EditType = EDIT
          _SHOWCAL = NONE
        end
        object BNAD2: TJDBEdit
          Left = 56
          Top = 330
          Width = 266
          Height = 19
          DataField = 'BNAD2'
          ImeName = '中文 (简体) - 微软拼音'
          TabOrder = 25
          _EditType = EDIT
          _SHOWCAL = NONE
        end
        object BNTL2: TJDBEdit
          Left = 56
          Top = 310
          Width = 100
          Height = 19
          DataField = 'BNTL2'
          ImeName = '中文 (简体) - 微软拼音'
          TabOrder = 23
          _EditType = EDIT
          _SHOWCAL = NONE
        end
        object BNZP2: TJDBEdit
          Left = 247
          Top = 310
          Width = 75
          Height = 19
          DataField = 'BNZP2'
          ImeName = '中文 (简体) - 微软拼音'
          TabOrder = 24
          _EditType = EDIT
          _SHOWCAL = NONE
        end
        object BNZP1: TJDBEdit
          Left = 247
          Top = 270
          Width = 75
          Height = 19
          DataField = 'BNZP1'
          ImeName = '中文 (简体) - 微软拼音'
          TabOrder = 21
          _EditType = EDIT
          _SHOWCAL = NONE
        end
        object BNENO: TJDBEdit
          Left = 56
          Top = 5
          Width = 100
          Height = 19
          DataField = 'BNENO'
          ImeName = '中文 (简体) - 微软拼音'
          TabOrder = 0
          _EditType = EDIT
          _SHOWCAL = NONE
        end
        object BNNAM: TJDBEdit
          Left = 56
          Top = 25
          Width = 100
          Height = 19
          DataField = 'BNNAM'
          ImeName = '中文 (简体) - 微软拼音'
          TabOrder = 1
          _EditType = EDIT
          _SHOWCAL = NONE
        end
        object BNSEX: SEDBLOOKUPBOX
          Left = 56
          Top = 65
          Width = 100
          Height = 19
          DataField = 'BNSEX'
          ImeName = '中文 (简体) - 微软拼音'
          MaxLength = 20
          TabOrder = 5
          _EditType = SEVARCHAR
          _DatabaseName = 'MAIN'
          _TableName = 'SYSLST'
          _Field_IDNO = 'B_SEX'
          _EDIT_WIDTH = 50
          _CHANGE_QUERY = True
          _INSERT_RECORD = True
          _SHOW_MESSAGE = True
        end
        object BNBLD: SEDBLOOKUPBOX
          Left = 224
          Top = 65
          Width = 100
          Height = 19
          DataField = 'BNBLD'
          ImeName = '中文 (简体) - 微软拼音'
          MaxLength = 20
          TabOrder = 6
          _EditType = SEVARCHAR
          _DatabaseName = 'MAIN'
          _TableName = 'SYSLST'
          _Field_IDNO = 'BMANBNBLD'
          _EDIT_WIDTH = 50
          _CHANGE_QUERY = True
          _INSERT_RECORD = True
          _SHOW_MESSAGE = True
        end
        object BNCPL: SEDBLOOKUPBOX
          Left = 224
          Top = 85
          Width = 100
          Height = 19
          DataField = 'BNCPL'
          ImeName = '中文 (简体) - 微软拼音'
          MaxLength = 20
          TabOrder = 8
          _EditType = SEVARCHAR
          _DatabaseName = 'MAIN'
          _TableName = 'SYSLST'
          _Field_IDNO = 'BMANBNCPL'
          _EDIT_WIDTH = 50
          _CHANGE_QUERY = True
          _INSERT_RECORD = True
          _SHOW_MESSAGE = True
        end
        object BNCTY: SEDBLOOKUPBOX
          Left = 224
          Top = 105
          Width = 100
          Height = 19
          DataField = 'BNCTY'
          ImeName = '中文 (简体) - 微软拼音'
          MaxLength = 20
          TabOrder = 10
          _EditType = SEVARCHAR
          _DatabaseName = 'MAIN'
          _TableName = 'SYSLST'
          _Field_IDNO = 'BMANBNCTY'
          _EDIT_WIDTH = 50
          _CHANGE_QUERY = True
          _INSERT_RECORD = True
          _SHOW_MESSAGE = True
        end
        object BNSDP: SEDBLOOKUPBOX
          Left = 224
          Top = 125
          Width = 100
          Height = 19
          DataField = 'BNSDP'
          ImeName = '中文 (简体) - 微软拼音'
          MaxLength = 20
          TabOrder = 12
          _EditType = SEVARCHAR
          _DatabaseName = 'MAIN'
          _TableName = 'SYSLST'
          _Field_IDNO = 'BMANBNSDP'
          _EDIT_WIDTH = 50
          _CHANGE_QUERY = True
          _INSERT_RECORD = True
          _SHOW_MESSAGE = True
        end
        object BNVIC: SEDBLOOKUPBOX
          Left = 56
          Top = 350
          Width = 100
          Height = 19
          DataField = 'BNVIC'
          ImeName = '中文 (简体) - 微软拼音'
          MaxLength = 20
          TabOrder = 26
          _EditType = SEVARCHAR
          _DatabaseName = 'MAIN'
          _TableName = 'SYSLST'
          _Field_IDNO = 'BMANBNVIC'
          _EDIT_WIDTH = 50
          _CHANGE_QUERY = True
          _INSERT_RECORD = True
          _SHOW_MESSAGE = True
        end
        object BNPWD: TEdit
          Left = 224
          Top = 25
          Width = 100
          Height = 19
          ImeName = '中文 (简体) - 微软拼音'
          TabOrder = 2
          OnKeyDown = BNPWDKeyDown
        end
        object BTNMSG: TBitBtn
          Left = 251
          Top = 395
          Width = 75
          Height = 25
          Caption = '信息'
          TabOrder = 28
          OnClick = BTNMSGClick
        end
      end
      object TabSheet6: TTabSheet
        Caption = '在职资料'
        object LBBNSEC: TLabel
          Left = 165
          Top = 88
          Width = 48
          Height = 12
          Caption = '发薪类别'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object LBBNCLS: TLabel
          Left = 0
          Top = 8
          Width = 48
          Height = 12
          Caption = '公    司'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object LBBNDPO: TLabel
          Left = 0
          Top = 88
          Width = 48
          Height = 12
          Caption = '扣缴单位'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object LBBNDPT: TLabel
          Left = 0
          Top = 48
          Width = 48
          Height = 12
          Caption = '绩效单位'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object LBBNLLC: TLabel
          Left = 165
          Top = 8
          Width = 48
          Height = 12
          Caption = '阶级代码'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object LBBNSVR: TLabel
          Left = 0
          Top = 68
          Width = 48
          Height = 12
          Caption = '服务单位'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object LBBNNUM: TLabel
          Left = 0
          Top = 28
          Width = 48
          Height = 12
          Caption = '出勤班别'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object LBBNLCC: TLabel
          Left = 165
          Top = 68
          Width = 48
          Height = 12
          Caption = '个人诚保'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object LBBNEPC: TLabel
          Left = 165
          Top = 28
          Width = 48
          Height = 12
          Caption = '职　　务'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object LBBNTIT: TLabel
          Left = 165
          Top = 48
          Width = 48
          Height = 12
          Caption = '职    称'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object LBBNGRC: TLabel
          Left = 0
          Top = 198
          Width = 48
          Height = 12
          Caption = '应征来源'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object LBBNC02: TLabel
          Left = 0
          Top = 118
          Width = 48
          Height = 12
          Caption = '任 用 日'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object LBBNFDY: TLabel
          Left = 0
          Top = 138
          Width = 48
          Height = 12
          Caption = '到职日期'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object LBBNEDY: TLabel
          Left = 165
          Top = 138
          Width = 48
          Height = 12
          Caption = '离职日期'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object LBBNHPS: TLabel
          Left = 0
          Top = 158
          Width = 48
          Height = 12
          Caption = '停薪留职'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object LBBNHPF: TLabel
          Left = 165
          Top = 158
          Width = 48
          Height = 12
          Caption = '复职日期'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object LBBNHPV: TLabel
          Left = 110
          Top = 178
          Width = 48
          Height = 12
          Caption = '累休天数'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object LBBNSPL: TLabel
          Left = 0
          Top = 178
          Width = 48
          Height = 12
          Caption = '特休天数'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object LBBNSPN: TLabel
          Left = 223
          Top = 178
          Width = 48
          Height = 12
          Caption = '前期未休'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object LBBNC03: TLabel
          Left = 0
          Top = 218
          Width = 48
          Height = 12
          Caption = '保 证 人'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object LBBNCHM: TLabel
          Left = 165
          Top = 198
          Width = 48
          Height = 12
          Caption = '离职原因'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object LBBNLV2: TLabel
          Left = 125
          Top = 238
          Width = 24
          Height = 12
          Caption = '职级'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object LBBNLV1: TLabel
          Left = 0
          Top = 238
          Width = 48
          Height = 12
          Caption = '职　　等'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object LBBNTB1: TLabel
          Left = 0
          Top = 288
          Width = 48
          Height = 12
          Caption = '团保加保'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object LBBNTB2: TLabel
          Left = 120
          Top = 288
          Width = 48
          Height = 12
          Caption = '团保退保'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object LBBNIF1: TLabel
          Left = 0
          Top = 308
          Width = 48
          Height = 12
          Caption = '劳保加保'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object LBBNIF2: TLabel
          Left = 120
          Top = 308
          Width = 48
          Height = 12
          Caption = '劳保退保'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object LBBNHI1: TLabel
          Left = 0
          Top = 328
          Width = 48
          Height = 12
          Caption = '健保加保'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object LBBNHI2: TLabel
          Left = 120
          Top = 328
          Width = 48
          Height = 12
          Caption = '健保退保'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object LBBNISM: TLabel
          Left = 240
          Top = 288
          Width = 36
          Height = 12
          Caption = '劳保额'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object LBBNHIM: TLabel
          Left = 240
          Top = 308
          Width = 36
          Height = 12
          Caption = '健保额'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object LBBNBNS: TLabel
          Left = 0
          Top = 348
          Width = 48
          Height = 12
          Caption = '银行名称'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object LBBNBNO: TLabel
          Left = 165
          Top = 348
          Width = 48
          Height = 12
          Caption = '银行帐号'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object LBBNHIN: TLabel
          Left = 225
          Top = 238
          Width = 24
          Height = 12
          Caption = '人数'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object LBBNHIX: TLabel
          Left = 165
          Top = 268
          Width = 48
          Height = 12
          Caption = '健保类别'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object LBBNTBX: TLabel
          Left = 0
          Top = 268
          Width = 48
          Height = 12
          Caption = '团保类别'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object LBBNSPP: TLabel
          Left = 225
          Top = 218
          Width = 48
          Height = 12
          Caption = '扶养人数'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object Bevel3: TBevel
          Left = -9
          Top = 100
          Width = 336
          Height = 11
          Shape = bsBottomLine
        end
        object Bevel4: TBevel
          Left = -9
          Top = 250
          Width = 336
          Height = 11
          Shape = bsBottomLine
        end
        object BNDPO: TJDBEdit
          Left = 55
          Top = 85
          Width = 100
          Height = 19
          DataField = 'BNDPO'
          ImeName = '中文 (简体) - 微软拼音'
          TabOrder = 8
          _EditType = EDIT
          _SHOWCAL = NONE
        end
        object BNDPT: TJDBEdit
          Left = 55
          Top = 45
          Width = 100
          Height = 19
          DataField = 'BNDPT'
          ImeName = '中文 (简体) - 微软拼音'
          TabOrder = 4
          _EditType = EDIT
          _SHOWCAL = NONE
        end
        object BNSVR: TJDBEdit
          Left = 55
          Top = 65
          Width = 100
          Height = 19
          DataField = 'BNSVR'
          ImeName = '中文 (简体) - 微软拼音'
          TabOrder = 6
          _EditType = EDIT
          _SHOWCAL = NONE
        end
        object BNNUM: TJDBEdit
          Left = 55
          Top = 25
          Width = 100
          Height = 19
          DataField = 'BNNUM'
          ImeName = '中文 (简体) - 微软拼音'
          TabOrder = 2
          _EditType = EDIT
          _SHOWCAL = NONE
        end
        object BNC02: TJDBEdit
          Left = 55
          Top = 115
          Width = 100
          Height = 19
          DataField = 'BNC02'
          ImeName = '中文 (简体) - 微软拼音'
          TabOrder = 10
          _EditType = EDATE_EDIT
          _SHOWCAL = NONE
        end
        object BNFDY: TJDBEdit
          Left = 55
          Top = 135
          Width = 100
          Height = 19
          DataField = 'BNFDY'
          ImeName = '中文 (简体) - 微软拼音'
          TabOrder = 11
          _EditType = EDATE_EDIT
          _SHOWCAL = NONE
        end
        object BNEDY: TJDBEdit
          Left = 220
          Top = 135
          Width = 100
          Height = 19
          DataField = 'BNEDY'
          ImeName = '中文 (简体) - 微软拼音'
          TabOrder = 12
          _EditType = EDATE_EDIT
          _SHOWCAL = NONE
        end
        object BNHPS: TJDBEdit
          Left = 55
          Top = 155
          Width = 100
          Height = 19
          DataField = 'BNHPS'
          ImeName = '中文 (简体) - 微软拼音'
          TabOrder = 13
          _EditType = EDIT
          _SHOWCAL = NONE
        end
        object BNHPF: TJDBEdit
          Left = 220
          Top = 155
          Width = 100
          Height = 19
          DataField = 'BNHPF'
          ImeName = '中文 (简体) - 微软拼音'
          TabOrder = 14
          _EditType = EDATE_EDIT
          _SHOWCAL = NONE
        end
        object BNHPV: TJDBEdit
          Left = 170
          Top = 175
          Width = 50
          Height = 19
          DataField = 'BNHPV'
          ImeName = '中文 (简体) - 微软拼音'
          TabOrder = 16
          _EditType = EDIT
          _SHOWCAL = NONE
        end
        object BNSPL: TJDBEdit
          Left = 55
          Top = 175
          Width = 50
          Height = 19
          DataField = 'BNSPL'
          ImeName = '中文 (简体) - 微软拼音'
          TabOrder = 15
          _EditType = EDIT
          _SHOWCAL = NONE
        end
        object BNSPN: TJDBEdit
          Left = 279
          Top = 175
          Width = 46
          Height = 19
          DataField = 'BNSPN'
          ImeName = '中文 (简体) - 微软拼音'
          TabOrder = 17
          _EditType = EDIT
          _SHOWCAL = NONE
        end
        object BNC03: TJDBEdit
          Left = 55
          Top = 215
          Width = 100
          Height = 19
          DataField = 'BNC03'
          ImeName = '中文 (简体) - 微软拼音'
          TabOrder = 20
          _EditType = EDIT
          _SHOWCAL = NONE
        end
        object BNCHM: TJDBEdit
          Left = 220
          Top = 195
          Width = 100
          Height = 19
          DataField = 'BNCHM'
          ImeName = '中文 (简体) - 微软拼音'
          TabOrder = 19
          _EditType = EDIT
          _SHOWCAL = NONE
        end
        object BNHBS: TDBCheckBox
          Left = 160
          Top = 216
          Width = 56
          Height = 17
          Alignment = taLeftJustify
          Caption = '要刷卡'
          DataField = 'BNHBS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
          TabOrder = 21
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
        object BNLV2: TJDBEdit
          Left = 160
          Top = 235
          Width = 60
          Height = 19
          DataField = 'BNLV2'
          ImeName = '中文 (简体) - 微软拼音'
          TabOrder = 24
          _EditType = EDIT
          _SHOWCAL = NONE
        end
        object BNLV1: TJDBEdit
          Left = 55
          Top = 235
          Width = 60
          Height = 19
          DataField = 'BNLV1'
          ImeName = '中文 (简体) - 微软拼音'
          TabOrder = 23
          _EditType = EDIT
          _SHOWCAL = NONE
        end
        object BNTB1: TJDBEdit
          Left = 55
          Top = 285
          Width = 60
          Height = 19
          DataField = 'BNTB1'
          ImeName = '中文 (简体) - 微软拼音'
          TabOrder = 28
          _EditType = EDIT
          _SHOWCAL = NONE
        end
        object BNTB2: TJDBEdit
          Left = 175
          Top = 285
          Width = 60
          Height = 19
          DataField = 'BNTB2'
          ImeName = '中文 (简体) - 微软拼音'
          TabOrder = 29
          _EditType = EDIT
          _SHOWCAL = NONE
        end
        object BNIF1: TJDBEdit
          Left = 55
          Top = 305
          Width = 60
          Height = 19
          DataField = 'BNIF1'
          ImeName = '中文 (简体) - 微软拼音'
          TabOrder = 31
          _EditType = EDIT
          _SHOWCAL = NONE
        end
        object BNIF2: TJDBEdit
          Left = 175
          Top = 305
          Width = 60
          Height = 19
          DataField = 'BNIF2'
          ImeName = '中文 (简体) - 微软拼音'
          TabOrder = 32
          _EditType = EDIT
          _SHOWCAL = NONE
        end
        object BNHI1: TJDBEdit
          Left = 55
          Top = 325
          Width = 60
          Height = 19
          DataField = 'BNHI1'
          ImeName = '中文 (简体) - 微软拼音'
          TabOrder = 34
          _EditType = EDIT
          _SHOWCAL = NONE
        end
        object BNHI2: TJDBEdit
          Left = 175
          Top = 325
          Width = 60
          Height = 19
          DataField = 'BNHI2'
          ImeName = '中文 (简体) - 微软拼音'
          TabOrder = 35
          _EditType = EDIT
          _SHOWCAL = NONE
        end
        object BNISM: TJDBEdit
          Left = 280
          Top = 285
          Width = 45
          Height = 19
          DataField = 'BNISM'
          ImeName = '中文 (简体) - 微软拼音'
          TabOrder = 30
          _EditType = EDIT
          _SHOWCAL = NONE
        end
        object BNHIM: TJDBEdit
          Left = 280
          Top = 305
          Width = 45
          Height = 19
          DataField = 'BNHIM'
          ImeName = '中文 (简体) - 微软拼音'
          TabOrder = 33
          _EditType = EDIT
          _SHOWCAL = NONE
        end
        object BNBNO: TJDBEdit
          Left = 220
          Top = 345
          Width = 100
          Height = 19
          DataField = 'BNBNO'
          ImeName = '中文 (简体) - 微软拼音'
          TabOrder = 37
          _EditType = EDIT
          _SHOWCAL = NONE
        end
        object BNHIN: TJDBEdit
          Left = 280
          Top = 235
          Width = 45
          Height = 19
          DataField = 'BNHIN'
          ImeName = '中文 (简体) - 微软拼音'
          TabOrder = 25
          _EditType = EDIT
          _SHOWCAL = NONE
        end
        object BNSPP: TJDBEdit
          Left = 280
          Top = 215
          Width = 45
          Height = 19
          DataField = 'BNSPP'
          ImeName = '中文 (简体) - 微软拼音'
          TabOrder = 22
          _EditType = EDIT
          _SHOWCAL = NONE
        end
        object BNBNS: SEDBLOOKUPBOX
          Left = 55
          Top = 345
          Width = 100
          Height = 19
          DataField = 'BNBNS'
          ImeName = '中文 (简体) - 微软拼音'
          MaxLength = 20
          TabOrder = 36
          _EditType = SEVARCHAR
          _DatabaseName = 'MAIN'
          _TableName = 'SYSLST'
          _Field_IDNO = 'BMANBNBNS'
          _EDIT_WIDTH = 50
          _CHANGE_QUERY = True
          _INSERT_RECORD = True
          _SHOW_MESSAGE = True
        end
        object BNCLS: SEDBLOOKUPBOX
          Left = 55
          Top = 5
          Width = 100
          Height = 19
          DataField = 'BNCLS'
          ImeName = '中文 (简体) - 微软拼音'
          MaxLength = 20
          TabOrder = 0
          _EditType = SEVARCHAR
          _DatabaseName = 'MAIN'
          _TableName = 'SYSLST'
          _Field_IDNO = 'BMANBNCLS'
          _EDIT_WIDTH = 50
          _CHANGE_QUERY = True
          _INSERT_RECORD = True
          _SHOW_MESSAGE = True
        end
        object BNLLC: SEDBLOOKUPBOX
          Left = 220
          Top = 5
          Width = 100
          Height = 19
          DataField = 'BNLLC'
          ImeName = '中文 (简体) - 微软拼音'
          MaxLength = 20
          TabOrder = 1
          _EditType = SEVARCHAR
          _DatabaseName = 'MAIN'
          _TableName = 'SYSLST'
          _Field_IDNO = 'BMANBNLLC'
          _EDIT_WIDTH = 50
          _CHANGE_QUERY = True
          _INSERT_RECORD = True
          _SHOW_MESSAGE = True
        end
        object BNEPC: SEDBLOOKUPBOX
          Left = 220
          Top = 25
          Width = 100
          Height = 19
          DataField = 'BNEPC'
          ImeName = '中文 (简体) - 微软拼音'
          MaxLength = 20
          TabOrder = 3
          _EditType = SEVARCHAR
          _DatabaseName = 'MAIN'
          _TableName = 'SYSLST'
          _Field_IDNO = 'BMANBNEPC'
          _EDIT_WIDTH = 50
          _CHANGE_QUERY = True
          _INSERT_RECORD = True
          _SHOW_MESSAGE = True
        end
        object BNTIT: SEDBLOOKUPBOX
          Left = 220
          Top = 45
          Width = 100
          Height = 19
          DataField = 'BNTIT'
          ImeName = '中文 (简体) - 微软拼音'
          MaxLength = 20
          TabOrder = 5
          _EditType = SEVARCHAR
          _DatabaseName = 'MAIN'
          _TableName = 'SYSLST'
          _Field_IDNO = 'BMANBNTIT'
          _EDIT_WIDTH = 50
          _CHANGE_QUERY = True
          _INSERT_RECORD = True
          _SHOW_MESSAGE = True
        end
        object BNLCC: SEDBLOOKUPBOX
          Left = 220
          Top = 65
          Width = 100
          Height = 19
          DataField = 'BNLCC'
          ImeName = '中文 (简体) - 微软拼音'
          MaxLength = 20
          TabOrder = 7
          _EditType = SEVARCHAR
          _DatabaseName = 'MAIN'
          _TableName = 'SYSLST'
          _Field_IDNO = 'BMANBNLCC'
          _EDIT_WIDTH = 50
          _CHANGE_QUERY = True
          _INSERT_RECORD = True
          _SHOW_MESSAGE = True
        end
        object BNSEC: SEDBLOOKUPBOX
          Left = 220
          Top = 85
          Width = 100
          Height = 19
          DataField = 'BNSEC'
          ImeName = '中文 (简体) - 微软拼音'
          MaxLength = 20
          TabOrder = 9
          _EditType = SEVARCHAR
          _DatabaseName = 'MAIN'
          _TableName = 'SYSLST'
          _Field_IDNO = 'BMANBNSEC'
          _EDIT_WIDTH = 50
          _CHANGE_QUERY = True
          _INSERT_RECORD = True
          _SHOW_MESSAGE = True
        end
        object BNGRC: SEDBLOOKUPBOX
          Left = 55
          Top = 195
          Width = 100
          Height = 19
          DataField = 'BNGRC'
          ImeName = '中文 (简体) - 微软拼音'
          MaxLength = 20
          TabOrder = 18
          _EditType = SEVARCHAR
          _DatabaseName = 'MAIN'
          _TableName = 'SYSLST'
          _Field_IDNO = 'BMANBNGRC'
          _EDIT_WIDTH = 50
          _CHANGE_QUERY = True
          _INSERT_RECORD = True
          _SHOW_MESSAGE = True
        end
        object BNHIX: SEDBLOOKUPBOX
          Left = 55
          Top = 265
          Width = 100
          Height = 19
          DataField = 'BNHIX'
          ImeName = '中文 (简体) - 微软拼音'
          MaxLength = 20
          TabOrder = 26
          _EditType = SEVARCHAR
          _DatabaseName = 'MAIN'
          _TableName = 'SYSLST'
          _Field_IDNO = 'BMANBNHIX'
          _EDIT_WIDTH = 50
          _CHANGE_QUERY = True
          _INSERT_RECORD = True
          _SHOW_MESSAGE = True
        end
        object BNTBX: SEDBLOOKUPBOX
          Left = 220
          Top = 265
          Width = 100
          Height = 19
          DataField = 'BNTBX'
          ImeName = '中文 (简体) - 微软拼音'
          MaxLength = 20
          TabOrder = 27
          _EditType = SEVARCHAR
          _DatabaseName = 'MAIN'
          _TableName = 'SYSLST'
          _Field_IDNO = 'BMANBNTBX'
          _EDIT_WIDTH = 50
          _CHANGE_QUERY = True
          _INSERT_RECORD = True
          _SHOW_MESSAGE = True
        end
      end
    end
    object DBGrid: TDBGrid
      Left = 367
      Top = 129
      Width = 220
      Height = 315
      ImeName = '中文 (简体) - 微软拼音'
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -13
      TitleFont.Name = '宋体'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'BNENO'
          Title.Alignment = taCenter
          Title.Caption = '员工编号'
          Title.Color = clInfoBk
          Width = 88
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'BNNAM'
          Title.Alignment = taCenter
          Title.Caption = '中文姓名'
          Title.Color = clInfoBk
          Width = 92
          Visible = True
        end>
    end
    object GroupBox1: TGroupBox
      Left = 367
      Top = 0
      Width = 220
      Height = 126
      Caption = '快速查询'
      Ctl3D = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = '宋体'
      Font.Style = []
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 2
      object LB1: TLabel
        Left = 7
        Top = 25
        Width = 52
        Height = 13
        Caption = '员工编号'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
      end
      object LB2: TLabel
        Left = 7
        Top = 45
        Width = 52
        Height = 13
        Caption = '中文姓名'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
      end
      object LB3: TLabel
        Left = 7
        Top = 65
        Width = 52
        Height = 13
        Caption = '英文姓名'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
      end
      object Label7: TLabel
        Left = 133
        Top = 24
        Width = 13
        Height = 13
        Caption = '至'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
      end
      object Label9: TLabel
        Left = 133
        Top = 64
        Width = 13
        Height = 13
        Caption = '至'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
      end
      object Label1: TLabel
        Left = 133
        Top = 44
        Width = 13
        Height = 13
        Caption = '至'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
      end
      object LB11: TJEdit
        Left = 65
        Top = 20
        Width = 65
        Height = 19
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = '宋体'
        Font.Style = []
        ImeName = '中文 (简体) - 微软拼音'
        ParentFont = False
        TabOrder = 0
        Digits = 1
        Max = 999999999
        _EditType = EDIT
        _SHOWCAL = NONE
        _BADINPUT = True
        _LONGTIME = False
      end
      object LB31: TJEdit
        Left = 65
        Top = 60
        Width = 65
        Height = 19
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = '宋体'
        Font.Style = []
        ImeName = '中文 (简体) - 微软拼音'
        ParentFont = False
        TabOrder = 4
        Digits = 1
        Max = 999999999
        _EditType = EDIT
        _SHOWCAL = NONE
        _BADINPUT = True
        _LONGTIME = False
      end
      object LB12: TJEdit
        Left = 150
        Top = 20
        Width = 65
        Height = 19
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = '宋体'
        Font.Style = []
        ImeName = '中文 (简体) - 微软拼音'
        ParentFont = False
        TabOrder = 1
        Digits = 1
        Max = 999999999
        _EditType = EDIT
        _SHOWCAL = NONE
        _BADINPUT = True
        _LONGTIME = False
      end
      object LB32: TJEdit
        Left = 150
        Top = 60
        Width = 65
        Height = 19
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = '宋体'
        Font.Style = []
        ImeName = '中文 (简体) - 微软拼音'
        ParentFont = False
        TabOrder = 5
        Digits = 1
        Max = 999999999
        _EditType = EDIT
        _SHOWCAL = NONE
        _BADINPUT = True
        _LONGTIME = False
      end
      object LB21: TJEdit
        Left = 65
        Top = 40
        Width = 65
        Height = 19
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = '宋体'
        Font.Style = []
        ImeName = '中文 (简体) - 微软拼音'
        ParentFont = False
        TabOrder = 2
        Digits = 1
        Max = 999999999
        _EditType = EDIT
        _SHOWCAL = NONE
        _BADINPUT = True
        _LONGTIME = False
      end
      object LB22: TJEdit
        Left = 150
        Top = 40
        Width = 65
        Height = 19
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = '宋体'
        Font.Style = []
        ImeName = '中文 (简体) - 微软拼音'
        ParentFont = False
        TabOrder = 3
        Digits = 1
        Max = 999999999
        _EditType = EDIT
        _SHOWCAL = NONE
        _BADINPUT = True
        _LONGTIME = False
      end
      object BTNSER: TBitBtn
        Left = 10
        Top = 86
        Width = 87
        Height = 30
        Cursor = crHandPoint
        Caption = 'F5 查询'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        OnClick = BTNSERClick
        Spacing = 1
      end
      object BTNCLR: TBitBtn
        Left = 135
        Top = 86
        Width = 80
        Height = 30
        Cursor = crHandPoint
        Caption = '清除'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
        OnClick = BTNCLRClick
        Spacing = 1
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 456
    Width = 593
    Height = 41
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Caption = ' '
    Color = cl3DLight
    TabOrder = 2
    object BTNQUT: TBitBtn
      Left = 515
      Top = 2
      Width = 73
      Height = 30
      Cursor = crHandPoint
      Caption = 'Ctrl+Q 结束'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = BTNQUTClick
    end
    object BTNCAL: TBitBtn
      Left = 195
      Top = 2
      Width = 60
      Height = 30
      Cursor = crHandPoint
      Caption = 'F4 取消'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = BTNCALClick
      Spacing = 1
    end
    object BTNYES: TBitBtn
      Left = 131
      Top = 2
      Width = 60
      Height = 30
      Cursor = crHandPoint
      Caption = 'F3 确定'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = BTNYESClick
      Spacing = 1
    end
    object BTNDEL: TBitBtn
      Left = 67
      Top = 2
      Width = 60
      Height = 30
      Cursor = crHandPoint
      Caption = 'F2 删除'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = BTNDELClick
      Spacing = 1
    end
    object BTNINS: TBitBtn
      Left = 3
      Top = 2
      Width = 60
      Height = 30
      Cursor = crHandPoint
      Caption = 'F1 新增'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = BTNINSClick
      Spacing = 1
    end
    object BTNPRN: TBitBtn
      Left = 451
      Top = 2
      Width = 60
      Height = 30
      Cursor = crHandPoint
      Caption = 'F8 打印'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      OnClick = BTNPRNClick
      Layout = blGlyphTop
      Spacing = 1
    end
    object BTNSET: TBitBtn
      Left = 323
      Top = 2
      Width = 60
      Height = 30
      Cursor = crHandPoint
      Caption = 'F7 设置'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      OnClick = BTNSETClick
      Spacing = 1
    end
    object BTNPRE: TBitBtn
      Left = 387
      Top = 2
      Width = 60
      Height = 30
      Cursor = crHandPoint
      Caption = 'F7 预览'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      OnClick = BTNPRNClick
      Layout = blGlyphTop
      Spacing = 1
    end
    object BTNPMS: TBitBtn
      Left = 259
      Top = 2
      Width = 60
      Height = 30
      Cursor = crHandPoint
      Caption = 'F9 权限'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
      OnClick = BTNPMSClick
      Spacing = 1
    end
  end
  object MainMenu: TMainMenu
    Left = 576
    Top = 6
    object N1: TMenuItem
      Caption = '新增'
      ShortCut = 112
      Visible = False
      OnClick = BTNINSClick
    end
    object N2: TMenuItem
      Caption = '删除'
      ShortCut = 113
      Visible = False
      OnClick = BTNDELClick
    end
    object N3: TMenuItem
      Caption = '确定'
      ShortCut = 114
      Visible = False
      OnClick = BTNYESClick
    end
    object N4: TMenuItem
      Caption = '取消'
      ShortCut = 115
      Visible = False
      OnClick = BTNCALClick
    end
    object N6: TMenuItem
      Caption = '查询'
      ShortCut = 116
      Visible = False
      OnClick = BTNSERClick
    end
    object MENPRE: TMenuItem
      Caption = '预览'
      ShortCut = 118
      Visible = False
      OnClick = BTNPRNClick
    end
    object MENPRN: TMenuItem
      Caption = '打印'
      ShortCut = 119
      Visible = False
      OnClick = BTNPRNClick
    end
    object N5: TMenuItem
      Caption = '结束'
      ShortCut = 16465
      Visible = False
      OnClick = BTNQUTClick
    end
    object N7: TMenuItem
      Caption = '权限'
      ShortCut = 120
      Visible = False
      OnClick = BTNPMSClick
    end
  end
end
