object FMMAIN: TFMMAIN
  Left = 100
  Top = 72
  Width = 700
  Height = 500
  Caption = '超市管理系统     前台收款结帐'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = MainMenu1
  OldCreateOrder = True
  Position = poScreenCenter
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Image_BG: TImage
    Left = 0
    Top = 0
    Width = 692
    Height = 454
    Align = alClient
    Center = True
  end
  object MainMenu1: TMainMenu
    AutoHotkeys = maManual
    Left = 55
    Top = 5
    object F1: TMenuItem
      Caption = 'F1~F4 进入收款台'
      ShortCut = 112
      OnClick = F1Click
    end
    object F1F43: TMenuItem
      Caption = 'F1~F4 进入收款台'
      ShortCut = 113
      Visible = False
    end
    object F1F42: TMenuItem
      Caption = 'F1~F4 进入收款台'
      ShortCut = 114
      Visible = False
    end
    object F1F41: TMenuItem
      Caption = 'F1~F4 进入收款台'
      ShortCut = 115
      Visible = False
    end
    object MNPMSG: TMenuItem
      Caption = 'F8 个人信息查看'
      ShortCut = 119
      Visible = False
    end
    object RPPOSD: TMenuItem
      Caption = 'F9 销售资料'
      ShortCut = 120
      Visible = False
      OnClick = RPPOSDClick
    end
    object TF101: TMenuItem
      Caption = 'F10 收款台数据传输'
      ShortCut = 121
      Visible = False
      OnClick = TF101Click
    end
    object A8: TMenuItem
      Caption = 'F10 发票作废'
      Visible = False
      OnClick = A8Click
    end
    object A9: TMenuItem
      Caption = 'F11 重新登录'
      ShortCut = 122
      Visible = False
      OnClick = A9Click
    end
    object N1: TMenuItem
      Caption = 'F12 系统功能 '
      ShortCut = 123
      object B1: TMenuItem
        Caption = '&S 系  统  设 置'
        OnClick = B1Click
      end
      object S1: TMenuItem
        Caption = '&K 快速键设置'
        OnClick = S1Click
      end
      object MNINVOICE: TMenuItem
        Caption = '&B 设置小票打印机'
        OnClick = MNINVOICEClick
      end
      object MNDSP: TMenuItem
        Caption = '&D 设置客显'
        OnClick = MNDSPClick
      end
      object M_INSERT_DATE: TMenuItem
        Caption = '&I 输入补登日期'
        Visible = False
        OnClick = M_INSERT_DATEClick
      end
    end
    object Q1: TMenuItem
      Caption = '退出CTRL+Q'
      ShortCut = 16465
      OnClick = Q1Click
    end
  end
end
