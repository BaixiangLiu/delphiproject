object FMMAIN: TFMMAIN
  Left = 100
  Top = 72
  Width = 700
  Height = 500
  Caption = '���й���ϵͳ     ǰ̨�տ����'
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
      Caption = 'F1~F4 �����տ�̨'
      ShortCut = 112
      OnClick = F1Click
    end
    object F1F43: TMenuItem
      Caption = 'F1~F4 �����տ�̨'
      ShortCut = 113
      Visible = False
    end
    object F1F42: TMenuItem
      Caption = 'F1~F4 �����տ�̨'
      ShortCut = 114
      Visible = False
    end
    object F1F41: TMenuItem
      Caption = 'F1~F4 �����տ�̨'
      ShortCut = 115
      Visible = False
    end
    object MNPMSG: TMenuItem
      Caption = 'F8 ������Ϣ�鿴'
      ShortCut = 119
      Visible = False
    end
    object RPPOSD: TMenuItem
      Caption = 'F9 ��������'
      ShortCut = 120
      Visible = False
      OnClick = RPPOSDClick
    end
    object TF101: TMenuItem
      Caption = 'F10 �տ�̨���ݴ���'
      ShortCut = 121
      Visible = False
      OnClick = TF101Click
    end
    object A8: TMenuItem
      Caption = 'F10 ��Ʊ����'
      Visible = False
      OnClick = A8Click
    end
    object A9: TMenuItem
      Caption = 'F11 ���µ�¼'
      ShortCut = 122
      Visible = False
      OnClick = A9Click
    end
    object N1: TMenuItem
      Caption = 'F12 ϵͳ���� '
      ShortCut = 123
      object B1: TMenuItem
        Caption = '&S ϵ  ͳ  �� ��'
        OnClick = B1Click
      end
      object S1: TMenuItem
        Caption = '&K ���ټ�����'
        OnClick = S1Click
      end
      object MNINVOICE: TMenuItem
        Caption = '&B ����СƱ��ӡ��'
        OnClick = MNINVOICEClick
      end
      object MNDSP: TMenuItem
        Caption = '&D ���ÿ���'
        OnClick = MNDSPClick
      end
      object M_INSERT_DATE: TMenuItem
        Caption = '&I ���벹������'
        Visible = False
        OnClick = M_INSERT_DATEClick
      end
    end
    object Q1: TMenuItem
      Caption = '�˳�CTRL+Q'
      ShortCut = 16465
      OnClick = Q1Click
    end
  end
end
