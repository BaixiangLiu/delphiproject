object FMMAINS: TFMMAINS
  Left = 233
  Top = 87
  AutoScroll = False
  BorderIcons = []
  Caption = 'ϵͳ����'
  ClientHeight = 339
  ClientWidth = 568
  Color = clInactiveCaptionText
  Ctl3D = False
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = '����'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object BTNQUT: TBitBtn
    Left = 127
    Top = 309
    Width = 90
    Height = 30
    Caption = 'ȷ������'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = '����'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = BTNQUTClick
    Kind = bkOK
  end
  object BTNCAL: TBitBtn
    Left = 348
    Top = 308
    Width = 93
    Height = 30
    Caption = 'ȡ���뿪'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = '����'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = BTNCALClick
    Kind = bkCancel
  end
  object PAGE: TPageControl
    Left = 0
    Top = 0
    Width = 569
    Height = 305
    ActivePage = TabSheet2
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = '����'
    Font.Style = []
    ParentFont = False
    Style = tsFlatButtons
    TabOrder = 2
    TabWidth = 175
    object PAGE_A: TTabSheet
      Caption = '��������'
      object Label8: TLabel
        Left = 35
        Top = 9
        Width = 48
        Height = 12
        Caption = '����λ��'
      end
      object Label1: TLabel
        Left = 275
        Top = 84
        Width = 48
        Height = 12
        Caption = '��˾����'
      end
      object Label2: TLabel
        Left = 35
        Top = 34
        Width = 48
        Height = 12
        Caption = '��˾����'
      end
      object Label3: TLabel
        Left = 35
        Top = 109
        Width = 48
        Height = 12
        Caption = '��˾��ַ'
      end
      object Label4: TLabel
        Left = 35
        Top = 159
        Width = 18
        Height = 12
        Caption = 'WWW'
      end
      object Label7: TLabel
        Left = 35
        Top = 134
        Width = 36
        Height = 12
        Caption = 'E_MAIL'
      end
      object Label10: TLabel
        Left = 35
        Top = 84
        Width = 48
        Height = 12
        Caption = '��˾�绰'
      end
      object Label11: TLabel
        Left = 35
        Top = 59
        Width = 48
        Height = 12
        Caption = 'ͳһ���'
      end
      object LABEL111: TLabel
        Left = 13
        Top = 204
        Width = 60
        Height = 12
        Caption = '�����汳��'
      end
      object Label13: TLabel
        Left = 115
        Top = 204
        Width = 24
        Height = 12
        Caption = '�߶�'
      end
      object Label34: TLabel
        Left = 200
        Top = 204
        Width = 24
        Height = 12
        Caption = '����'
      end
      object Label37: TLabel
        Left = 7
        Top = 252
        Width = 72
        Height = 12
        Caption = '�����汳��ͼ'
      end
      object ED_CORP_NAME: TEdit
        Left = 105
        Top = 30
        Width = 380
        Height = 18
        ImeName = '���� (����) - ƴ���Ӽ�'
        TabOrder = 1
      end
      object ED_CORP_NO: TEdit
        Left = 105
        Top = 55
        Width = 380
        Height = 18
        ImeName = '���� (����) - ƴ���Ӽ�'
        TabOrder = 2
      end
      object ED_CORP_TEL: TEdit
        Left = 105
        Top = 80
        Width = 150
        Height = 18
        ImeName = '���� (����) - ƴ���Ӽ�'
        TabOrder = 3
      end
      object ED_CORP_FAX: TEdit
        Left = 335
        Top = 80
        Width = 150
        Height = 18
        ImeName = '���� (����) - ƴ���Ӽ�'
        TabOrder = 4
      end
      object ED_CORP_ADDR: TEdit
        Left = 105
        Top = 105
        Width = 380
        Height = 18
        ImeName = '���� (����) - ƴ���Ӽ�'
        TabOrder = 5
      end
      object ED_CORP_EMAIL: TEdit
        Left = 105
        Top = 130
        Width = 380
        Height = 18
        ImeName = '���� (����) - ƴ���Ӽ�'
        TabOrder = 6
      end
      object ED_CORP_WWW: TEdit
        Left = 105
        Top = 155
        Width = 380
        Height = 18
        ImeName = '���� (����) - ƴ���Ӽ�'
        TabOrder = 7
      end
      object ED_CORP_RBPST: SELOOKUPBOX
        Left = 105
        Top = 6
        Width = 150
        Height = 18
        ImeName = '���� (����) - ƴ���Ӽ�'
        MaxLength = 20
        TabOrder = 0
        _DatabaseName = 'MAIN'
        _TableName = 'SYSLST'
        _Field_IDNO = 'RBRNRBPST'
        _EDIT_WIDTH = 50
        _CHANGE_QUERY = True
        _INSERT_RECORD = True
        _SHOW_MESSAGE = False
      end
      object ED_SET_MAINCR: TPanel
        Left = 85
        Top = 201
        Width = 20
        Height = 20
        Caption = ' '
        TabOrder = 8
        OnClick = ED_SET_MAINCRClick
      end
      object ED_SET_MAINHT: TSpinEdit
        Left = 145
        Top = 199
        Width = 50
        Height = 21
        MaxValue = 0
        MinValue = 0
        TabOrder = 9
        Value = 0
      end
      object ED_SET_MAINCP: TEdit
        Left = 230
        Top = 201
        Width = 256
        Height = 18
        ImeName = '���� (����) - ƴ���Ӽ�'
        MaxLength = 40
        TabOrder = 10
      end
      object ED_SET_MAINBG: TEdit
        Left = 85
        Top = 249
        Width = 371
        Height = 18
        ImeName = '���� (����) - ƴ���Ӽ�'
        MaxLength = 40
        TabOrder = 11
        Text = 'QRBGDS.INI'
        OnDblClick = ED_SET_QRBGDSDblClick
      end
      object BTN_SET_MAINBG: TButton
        Left = 460
        Top = 247
        Width = 25
        Height = 25
        Caption = '...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 12
        OnClick = ED_SET_QRBGDSDblClick
      end
    end
    object PAGE_B: TTabSheet
      Caption = '��������1'
      ImageIndex = 1
      object Label9: TLabel
        Left = 210
        Top = 253
        Width = 72
        Height = 12
        Caption = '˰���������'
      end
      object Label12: TLabel
        Left = 370
        Top = 253
        Width = 6
        Height = 12
        Caption = '%'
      end
      object ED_SET_TAX: TSpinEdit
        Left = 305
        Top = 248
        Width = 60
        Height = 21
        MaxValue = 0
        MinValue = 0
        TabOrder = 0
        Value = 0
      end
      object ED_SET_LOGIN: TCheckBox
        Left = 210
        Top = 28
        Width = 200
        Height = 24
        Caption = '��������Ƿ��¼'
        TabOrder = 1
      end
      object GroupBox4: TGroupBox
        Left = 360
        Top = 15
        Width = 185
        Height = 151
        Caption = '�տ�̨����'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = '����'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        Visible = False
        object Label5: TLabel
          Left = 7
          Top = 122
          Width = 72
          Height = 12
          Caption = '��Ա��������'
        end
        object Label6: TLabel
          Left = 147
          Top = 122
          Width = 30
          Height = 12
          Caption = 'Ԫ/��'
        end
        object ED_SET_ACUS: TCheckBox
          Left = 10
          Top = 21
          Width = 200
          Height = 24
          Caption = '�Ƿ����������ͻ�����'
          TabOrder = 0
        end
        object ED_SET_BMBPO: TSpinEdit
          Left = 81
          Top = 117
          Width = 60
          Height = 21
          MaxValue = 0
          MinValue = 0
          TabOrder = 1
          Value = 0
        end
        object ED_POSA_F5: TCheckBox
          Left = 10
          Top = 41
          Width = 200
          Height = 24
          Caption = '�Ƿ��ֱ�Ӹ����ۼ�'
          TabOrder = 2
        end
        object ED_SET_PAIV: TCheckBox
          Left = 10
          Top = 61
          Width = 200
          Height = 24
          Caption = '�Ƿ�������뷢Ʊ����'
          TabOrder = 3
        end
        object ED_SET_PALS: TCheckBox
          Left = 10
          Top = 81
          Width = 200
          Height = 24
          Caption = '�Ƿ��ۼۿɵ���Ԥ��ɱ�'
          TabOrder = 4
        end
      end
      object GroupBox3: TGroupBox
        Left = 5
        Top = 10
        Width = 201
        Height = 261
        Caption = '�������ų�������'
        TabOrder = 2
        object Label14: TLabel
          Left = 15
          Top = 50
          Width = 84
          Height = 12
          Caption = '��Ʒ�����볤��'
        end
        object Label15: TLabel
          Left = 160
          Top = 50
          Width = 24
          Height = 12
          Caption = 'λ��'
        end
        object Label16: TLabel
          Left = 15
          Top = 100
          Width = 72
          Height = 12
          Caption = '���̱�ų���'
        end
        object Label17: TLabel
          Left = 160
          Top = 100
          Width = 24
          Height = 12
          Caption = 'λ��'
        end
        object Label28: TLabel
          Left = 15
          Top = 125
          Width = 72
          Height = 12
          Caption = '�ͻ���ų���'
        end
        object Label29: TLabel
          Left = 160
          Top = 125
          Width = 24
          Height = 12
          Caption = 'λ��'
        end
        object Label33: TLabel
          Left = 15
          Top = 75
          Width = 72
          Height = 12
          Caption = '��Ա��ų���'
        end
        object Label36: TLabel
          Left = 160
          Top = 75
          Width = 24
          Height = 12
          Caption = 'λ��'
        end
        object ED_SET_BGENO_LEN: TSpinEdit
          Left = 105
          Top = 45
          Width = 50
          Height = 21
          Ctl3D = False
          MaxValue = 20
          MinValue = 1
          ParentCtl3D = False
          TabOrder = 0
          Value = 20
        end
        object ED_SET_BSENO_LEN: TSpinEdit
          Left = 105
          Top = 95
          Width = 50
          Height = 21
          Ctl3D = False
          MaxValue = 10
          MinValue = 1
          ParentCtl3D = False
          TabOrder = 1
          Value = 10
        end
        object ED_SET_EAN13: TCheckBox
          Left = 15
          Top = 21
          Width = 166
          Height = 24
          Caption = '��Ʒ���ʹ��EAN13��'
          TabOrder = 2
          OnClick = ED_SET_EAN13Click
        end
        object ED_SET_BCENO_LEN: TSpinEdit
          Left = 105
          Top = 120
          Width = 50
          Height = 21
          Ctl3D = False
          MaxValue = 10
          MinValue = 1
          ParentCtl3D = False
          TabOrder = 3
          Value = 10
        end
        object ED_SET_BGENO_CHG: TCheckBox
          Left = 15
          Top = 148
          Width = 160
          Height = 24
          Caption = '�Ƿ�ɸ��Ĳ�Ʒ������'
          TabOrder = 4
        end
        object ED_SET_BMENO_CHG: TCheckBox
          Left = 15
          Top = 168
          Width = 160
          Height = 24
          Caption = '�Ƿ�ɸ��Ļ�Ա���'
          TabOrder = 5
        end
        object ED_SET_BSENO_CHG: TCheckBox
          Left = 15
          Top = 188
          Width = 160
          Height = 24
          Caption = '�Ƿ�ɸ��ĳ��̱��'
          TabOrder = 6
        end
        object ED_SET_BCENO_CHG: TCheckBox
          Left = 15
          Top = 208
          Width = 160
          Height = 24
          Caption = '�Ƿ�ɸ��Ŀͻ����'
          TabOrder = 7
        end
        object ED_SET_BNENO_CHG: TCheckBox
          Left = 15
          Top = 228
          Width = 160
          Height = 24
          Caption = '�Ƿ�ɸ���Ա�����'
          TabOrder = 8
        end
        object ED_SET_BMENO_LEN: TSpinEdit
          Left = 105
          Top = 70
          Width = 50
          Height = 21
          Ctl3D = False
          MaxValue = 10
          MinValue = 1
          ParentCtl3D = False
          TabOrder = 9
          Value = 10
        end
      end
      object ED_BARPRN: TRadioGroup
        Left = 210
        Top = 135
        Width = 141
        Height = 61
        Caption = '�����������'
        ItemIndex = 0
        Items.Strings = (
          'CLEVER'
          'ARGOX')
        TabOrder = 4
      end
      object ED_DBKIND: TRadioGroup
        Left = 210
        Top = 55
        Width = 141
        Height = 71
        Caption = '���ݿ�����'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = '����'
        Font.Style = []
        ItemIndex = 0
        Items.Strings = (
          'MS Access Driver'
          'MS SQL Sever')
        ParentFont = False
        TabOrder = 5
      end
    end
    object TabSheet2: TTabSheet
      Caption = '��������2'
      ImageIndex = 2
      object PageControl3: TPageControl
        Left = 0
        Top = 0
        Width = 501
        Height = 158
        ActivePage = RCIN_PAGE
        Style = tsButtons
        TabOrder = 0
        TabWidth = 240
        object RCIN_PAGE: TTabSheet
          Caption = '������ע'
          object Label18: TLabel
            Left = 10
            Top = 6
            Width = 54
            Height = 12
            Caption = '������ע1'
          end
          object Label19: TLabel
            Left = 10
            Top = 31
            Width = 54
            Height = 12
            Caption = '������ע2'
          end
          object Label20: TLabel
            Left = 10
            Top = 56
            Width = 54
            Height = 12
            Caption = '������ע3'
          end
          object Label21: TLabel
            Left = 10
            Top = 81
            Width = 54
            Height = 12
            Caption = '������ע4'
          end
          object Label22: TLabel
            Left = 10
            Top = 106
            Width = 54
            Height = 12
            Caption = '������ע5'
          end
          object ED_RIMEM1: TEdit
            Left = 85
            Top = 3
            Width = 400
            Height = 18
            ImeName = '���� (����) - ƴ���Ӽ�'
            MaxLength = 40
            TabOrder = 0
          end
          object ED_RIMEM2: TEdit
            Left = 85
            Top = 28
            Width = 400
            Height = 18
            ImeName = '���� (����) - ƴ���Ӽ�'
            MaxLength = 40
            TabOrder = 1
          end
          object ED_RIMEM3: TEdit
            Left = 85
            Top = 53
            Width = 400
            Height = 18
            ImeName = '���� (����) - ƴ���Ӽ�'
            MaxLength = 40
            TabOrder = 2
          end
          object ED_RIMEM4: TEdit
            Left = 85
            Top = 78
            Width = 400
            Height = 18
            ImeName = '���� (����) - ƴ���Ӽ�'
            MaxLength = 40
            TabOrder = 3
          end
          object ED_RIMEM5: TEdit
            Left = 85
            Top = 103
            Width = 400
            Height = 18
            ImeName = '���� (����) - ƴ���Ӽ�'
            MaxLength = 40
            TabOrder = 4
          end
        end
        object RCON_PAGE: TTabSheet
          Caption = '������ע'
          ImageIndex = 1
          object Label23: TLabel
            Left = 10
            Top = 6
            Width = 54
            Height = 12
            Caption = '������ע1'
          end
          object Label24: TLabel
            Left = 10
            Top = 31
            Width = 54
            Height = 12
            Caption = '������ע2'
          end
          object Label25: TLabel
            Left = 10
            Top = 56
            Width = 54
            Height = 12
            Caption = '������ע3'
          end
          object Label26: TLabel
            Left = 10
            Top = 81
            Width = 54
            Height = 12
            Caption = '������ע4'
          end
          object Label27: TLabel
            Left = 10
            Top = 106
            Width = 54
            Height = 12
            Caption = '������ע5'
          end
          object ED_ROMEM1: TEdit
            Left = 85
            Top = 3
            Width = 400
            Height = 18
            ImeName = '���� (����) - ƴ���Ӽ�'
            MaxLength = 40
            TabOrder = 0
          end
          object ED_ROMEM2: TEdit
            Left = 85
            Top = 28
            Width = 400
            Height = 18
            ImeName = '���� (����) - ƴ���Ӽ�'
            MaxLength = 40
            TabOrder = 1
          end
          object ED_ROMEM3: TEdit
            Left = 85
            Top = 53
            Width = 400
            Height = 18
            ImeName = '���� (����) - ƴ���Ӽ�'
            MaxLength = 40
            TabOrder = 2
          end
          object ED_ROMEM4: TEdit
            Left = 85
            Top = 78
            Width = 400
            Height = 18
            ImeName = '���� (����) - ƴ���Ӽ�'
            MaxLength = 40
            TabOrder = 3
          end
          object ED_ROMEM5: TEdit
            Left = 85
            Top = 103
            Width = 400
            Height = 18
            ImeName = '���� (����) - ƴ���Ӽ�'
            MaxLength = 40
            TabOrder = 4
          end
        end
      end
      object GroupBox2: TGroupBox
        Left = 0
        Top = 160
        Width = 496
        Height = 101
        Caption = '��ǩ�ļ�����'
        TabOrder = 1
        object Label30: TLabel
          Left = 22
          Top = 21
          Width = 72
          Height = 12
          Caption = '��Ʒ�����ļ�'
        end
        object Label31: TLabel
          Left = 22
          Top = 46
          Width = 72
          Height = 12
          Caption = '��Ա�����ļ�'
        end
        object Label32: TLabel
          Left = 22
          Top = 71
          Width = 72
          Height = 12
          Caption = '��Ա��ַ�ļ�'
        end
        object ED_SET_QRBGDS: TEdit
          Left = 100
          Top = 18
          Width = 340
          Height = 18
          ImeName = '���� (����) - ƴ���Ӽ�'
          MaxLength = 40
          TabOrder = 0
          Text = 'QRBGDS.INI'
          OnDblClick = ED_SET_QRBGDSDblClick
        end
        object ED_SET_QRBMEM: TEdit
          Left = 100
          Top = 43
          Width = 340
          Height = 18
          ImeName = '���� (����) - ƴ���Ӽ�'
          MaxLength = 40
          TabOrder = 1
          Text = 'QRBMEM.INI'
          OnDblClick = ED_SET_QRBGDSDblClick
        end
        object ED_SET_QRBMAD: TEdit
          Left = 100
          Top = 68
          Width = 340
          Height = 18
          ImeName = '���� (����) - ƴ���Ӽ�'
          MaxLength = 40
          TabOrder = 2
          Text = 'QRBMAD.INI'
          OnDblClick = ED_SET_QRBGDSDblClick
        end
        object BTN_QRBGDS: TButton
          Left = 445
          Top = 17
          Width = 25
          Height = 25
          Caption = '...'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 3
          OnClick = ED_SET_QRBGDSDblClick
        end
        object BTN_QRBMEM: TButton
          Left = 445
          Top = 42
          Width = 25
          Height = 25
          Caption = '...'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 4
          OnClick = ED_SET_QRBGDSDblClick
        end
        object BTN_QRBMAD: TButton
          Left = 445
          Top = 67
          Width = 25
          Height = 25
          Caption = '...'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 5
          OnClick = ED_SET_QRBGDSDblClick
        end
      end
    end
  end
  object MainMenu1: TMainMenu
    Left = 525
    Top = 242
    object N1: TMenuItem
      Caption = '��������'
      ShortCut = 40968
      Visible = False
    end
    object N2: TMenuItem
      Caption = '����-ʹ������'
      ShortCut = 32776
      Visible = False
    end
  end
  object OpenDialog: TOpenDialog
    InitialDir = '.'
    Title = '���ļ�'
    Left = 525
    Top = 274
  end
  object ColorDialog: TColorDialog
    Ctl3D = True
    Left = 499
    Top = 274
  end
  object OpenPictureDialog: TOpenPictureDialog
    Left = 489
    Top = 241
  end
end
