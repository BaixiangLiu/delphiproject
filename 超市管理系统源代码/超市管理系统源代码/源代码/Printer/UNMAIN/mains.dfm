object FMMAINS: TFMMAINS
  Left = 146
  Top = 122
  AutoScroll = False
  BorderIcons = []
  Caption = '�տ�̨����'
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
    Caption = 'ȷ������'
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
    Caption = 'ȡ���˳�'
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
    Font.Name = '������'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    TabWidth = 263
    object PAGE_A: TTabSheet
      Caption = '��������'
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
          Caption = '��Ա����'
        end
        object Label6: TLabel
          Left = 461
          Top = 282
          Width = 40
          Height = 15
          Caption = 'Ԫ/��'
        end
        object ED_AUTO_SHOWPOSA: TCheckBox
          Left = -1
          Top = 15
          Width = 171
          Height = 20
          Caption = '�����Զ������տ�̨'
          TabOrder = 0
        end
        object ED_PRN_PRINTING: TCheckBox
          Left = 10
          Top = 55
          Width = 150
          Height = 20
          Caption = 'Ԥ���ӡ��Ʊ '
          TabOrder = 2
        end
        object ED_PRN_ALWAYSON: TCheckBox
          Left = 10
          Top = 35
          Width = 150
          Height = 20
          Caption = 'ǿ�ȴ�ӡ��Ʊ '
          TabOrder = 1
        end
        object ED_PRN_CASHBOX: TCheckBox
          Left = 10
          Top = 75
          Width = 150
          Height = 20
          Caption = '�����Զ���Ǯ��'
          TabOrder = 3
        end
        object ED_CLEAR_INPUT: TCheckBox
          Left = 10
          Top = 95
          Width = 160
          Height = 20
          Caption = '�������������'
          TabOrder = 4
        end
        object ED_MINUSP: TCheckBox
          Left = 10
          Top = 115
          Width = 141
          Height = 20
          Caption = '�ܼƸ����ɽ���'
          TabOrder = 5
        end
        object ED_LAST_SUB: TCheckBox
          Left = 10
          Top = 215
          Width = 160
          Height = 20
          Caption = 'ȥβ�������ӡ'
          TabOrder = 10
        end
        object ED_AUTO_EAN13: TCheckBox
          Left = 10
          Top = 135
          Width = 160
          Height = 20
          Caption = '13����ֵ�Զ���λ'
          TabOrder = 6
        end
        object ED_ALL_CASHIN: TCheckBox
          Left = 10
          Top = 155
          Width = 160
          Height = 20
          Caption = 'ȫ��ʹ���ֽ����'
          TabOrder = 7
        end
        object ED_RE_INPUT: TCheckBox
          Left = 10
          Top = 175
          Width = 150
          Height = 20
          Caption = '�ظ�ˢ�Ƿ��Զ���'
          TabOrder = 8
        end
        object ED_AUTO_ROUND: TCheckBox
          Left = 10
          Top = 195
          Width = 150
          Height = 20
          Caption = 'С������������λ'
          TabOrder = 9
        end
        object ED_SHOW_BGCOT: TCheckBox
          Left = 170
          Top = 95
          Width = 150
          Height = 20
          Caption = '��ʾ������λ'
          TabOrder = 16
          Visible = False
        end
        object ED_CHECK_POSM: TCheckBox
          Left = 325
          Top = 135
          Width = 150
          Height = 20
          Caption = '����ؼ�Ʒ����'
          TabOrder = 26
        end
        object ED_CHECK_POSN: TCheckBox
          Left = 325
          Top = 155
          Width = 150
          Height = 20
          Caption = '��������������'
          TabOrder = 27
        end
        object ED_CHECK_POSO: TCheckBox
          Left = 325
          Top = 175
          Width = 150
          Height = 20
          Caption = '��������һ����'
          TabOrder = 28
          Visible = False
        end
        object ED_CHECK_BGQTN: TCheckBox
          Left = 325
          Top = 195
          Width = 150
          Height = 20
          Caption = '�����������'
          TabOrder = 29
        end
        object ED_CHECK_GIFT_NO: TCheckBox
          Left = 325
          Top = 215
          Width = 150
          Height = 20
          Caption = '�����ȯ�Ƿ��ظ�'
          TabOrder = 30
        end
        object ED_SHOW_WARN: TCheckBox
          Left = 170
          Top = 175
          Width = 150
          Height = 20
          Caption = 'ˢ������ʱҪ����'
          TabOrder = 20
        end
        object ED_SHOW_RUNLG: TCheckBox
          Left = 170
          Top = 155
          Width = 150
          Height = 20
          Caption = '��ʾ�����'
          TabOrder = 19
        end
        object ED_SHOW_BGCOS: TCheckBox
          Left = 170
          Top = 75
          Width = 145
          Height = 20
          Caption = '��ʾ�ɱ���'
          TabOrder = 15
        end
        object ED_SHOW_BGQTN: TCheckBox
          Left = 170
          Top = 55
          Width = 145
          Height = 20
          Caption = '��ʾ�����'
          TabOrder = 14
        end
        object ED_SHOW_BGDSN: TCheckBox
          Left = 170
          Top = 115
          Width = 145
          Height = 20
          Caption = '��ʾ��Ʒ��ϸ����'
          TabOrder = 17
        end
        object ED_SHOW_BMEMN: TCheckBox
          Left = 170
          Top = 135
          Width = 145
          Height = 20
          Caption = '��ʾ��Ա��ϸ����'
          TabOrder = 18
        end
        object ED_DISC_ALL: TCheckBox
          Left = 10
          Top = 235
          Width = 160
          Height = 20
          Caption = 'ÿ�ʶ�����'
          TabOrder = 11
        end
        object ED_SHOW_BGQTS: TCheckBox
          Left = 170
          Top = 35
          Width = 145
          Height = 20
          Caption = '��ʾ������'
          TabOrder = 13
        end
        object ED_SET_ACUS: TCheckBox
          Left = 324
          Top = 11
          Width = 185
          Height = 24
          Caption = '�Ƿ����������ͻ�����'
          TabOrder = 21
        end
        object ED_SET_CHG_PRICE: TCheckBox
          Left = 324
          Top = 71
          Width = 185
          Height = 24
          Caption = '�Ƿ��ֱ�Ӹ����ۼ�'
          TabOrder = 24
        end
        object ED_SET_INPUT_INV: TCheckBox
          Left = 324
          Top = 31
          Width = 185
          Height = 24
          Caption = '�Ƿ�������뷢Ʊ����'
          TabOrder = 22
        end
        object ED_SET_LOWCOS: TCheckBox
          Left = 308
          Top = 51
          Width = 199
          Height = 24
          Caption = '�Ƿ��ۼۿɵ���Ԥ��ɱ�'
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
          Caption = '���´��ڸ����ۼ�'
          TabOrder = 25
        end
        object ED_PRACTICE_MODE: TRadioGroup
          Left = 159
          Top = 215
          Width = 162
          Height = 80
          Caption = '��ϰģʽ'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -15
          Font.Name = '������'
          Font.Style = []
          ItemIndex = 0
          Items.Strings = (
            '�����̡���ӡ��Ʊ'
            '�����̡���ӡ��Ʊ'
            '�����̲���ӡ��Ʊ')
          ParentFont = False
          TabOrder = 31
        end
        object ED_SHOW_FUNCTION: TCheckBox
          Left = 170
          Top = 15
          Width = 145
          Height = 20
          Caption = '��ʾ���ܼ�'
          TabOrder = 12
        end
      end
    end
    object PAGE_B: TTabSheet
      Caption = '��Ʊ��ʽ����'
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
          Caption = '̧ͷ'
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
            Caption = '��һ��'
          end
          object Label27: TLabel
            Left = 85
            Top = 50
            Width = 48
            Height = 15
            Caption = '�ڶ���'
          end
          object Label28: TLabel
            Left = 10
            Top = 50
            Width = 32
            Height = 15
            Caption = '����'
          end
          object Label29: TLabel
            Left = 10
            Top = 25
            Width = 32
            Height = 15
            Caption = '����'
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
          Caption = '����'
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
            Caption = '��λ��'
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
            Caption = '��λ��'
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
            Caption = '��λ��'
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
            Caption = '��λ��'
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
            Caption = '���ո�'
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
            Caption = '���ո�'
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
            Caption = '���ո�'
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
              '������'
              '���'
              'Ʒ��'
              '���'
              '����'
              '����'
              'С��')
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
              '������'
              '���'
              'Ʒ��'
              '���'
              '����'
              '����'
              'С��')
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
              '������'
              '���'
              'Ʒ��'
              '���'
              '����'
              '����'
              'С��')
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
              '������'
              '���'
              'Ʒ��'
              '���'
              '����'
              '����'
              'С��')
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
          Caption = '��β'
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
            Caption = '��һ��'
          end
          object Label31: TLabel
            Left = 20
            Top = 48
            Width = 48
            Height = 15
            Caption = '�ڶ���'
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
          Caption = '��ӡӦ�ҽ��'
          TabOrder = 3
        end
        object IV_RP2: TCheckBox
          Left = 344
          Top = 225
          Width = 151
          Height = 20
          Caption = '��ӡ���ÿ���'
          TabOrder = 4
        end
        object IV_RP3: TCheckBox
          Left = 344
          Top = 245
          Width = 151
          Height = 20
          Caption = '��ӡ��ȯ��ϸ'
          TabOrder = 5
        end
      end
    end
  end
end
