object FMLBDSL: TFMLBDSL
  Left = 426
  Top = 167
  Width = 308
  Height = 354
  Caption = ' '
  Color = 16237796
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '����'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object PageControl1: TPageControl
    Left = 5
    Top = 5
    Width = 286
    Height = 286
    ActivePage = PAGE_A_LB
    Style = tsFlatButtons
    TabOrder = 0
    TabWidth = 85
    object PAGE_A_LB: TTabSheet
      Caption = 'һ������'
      object Label1: TLabel
        Left = 0
        Top = 9
        Width = 48
        Height = 12
        Caption = '�ֶ�����'
      end
      object Label2: TLabel
        Left = 0
        Top = 34
        Width = 48
        Height = 12
        Caption = '�ߡ�����'
      end
      object Label3: TLabel
        Left = 0
        Top = 59
        Width = 48
        Height = 12
        Caption = '������'
      end
      object Label4: TLabel
        Left = 145
        Top = 34
        Width = 36
        Height = 12
        Caption = '��߽�'
      end
      object Label5: TLabel
        Left = 145
        Top = 59
        Width = 36
        Height = 12
        Caption = '�ϱ߽�'
      end
      object Label20: TLabel
        Left = 259
        Top = 20
        Width = 16
        Height = 66
        AutoSize = False
        Caption = '������΢��'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8939008
        Font.Height = -12
        Font.Name = '������'
        Font.Style = []
        ParentFont = False
        WordWrap = True
      end
      object Label21: TLabel
        Left = 0
        Top = 211
        Width = 281
        Height = 20
        Cursor = crHandPoint
        Alignment = taCenter
        AutoSize = False
        Caption = '��������������˵����������������'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8939008
        Font.Height = -15
        Font.Name = '������'
        Font.Style = [fsUnderline]
        ParentFont = False
        Layout = tlCenter
        WordWrap = True
        OnClick = Label21Click
      end
      object ED_NAME: TEdit
        Left = 70
        Top = 5
        Width = 181
        Height = 18
        Color = 15395562
        Ctl3D = False
        ParentCtl3D = False
        ReadOnly = True
        TabOrder = 0
      end
      object ED_HEIGHT: TSpinEdit
        Left = 70
        Top = 30
        Width = 60
        Height = 21
        Color = 15395562
        Ctl3D = False
        MaxValue = 0
        MinValue = 0
        ParentCtl3D = False
        ReadOnly = True
        TabOrder = 1
        Value = 0
      end
      object ED_WIDTH: TSpinEdit
        Left = 70
        Top = 55
        Width = 60
        Height = 21
        Color = 15395562
        Ctl3D = False
        MaxValue = 0
        MinValue = 0
        ParentCtl3D = False
        ReadOnly = True
        TabOrder = 2
        Value = 0
      end
      object ED_LEFT: TSpinEdit
        Left = 195
        Top = 30
        Width = 60
        Height = 21
        Ctl3D = False
        MaxValue = 0
        MinValue = 0
        ParentCtl3D = False
        TabOrder = 3
        Value = 0
      end
      object ED_TOP: TSpinEdit
        Left = 195
        Top = 55
        Width = 60
        Height = 21
        Ctl3D = False
        MaxValue = 0
        MinValue = 0
        ParentCtl3D = False
        TabOrder = 4
        Value = 0
      end
      object ED_PRINT_STYLE1: TPanel
        Left = 0
        Top = 90
        Width = 265
        Height = 29
        Caption = ' '
        Color = 8644350
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 5
        object Label6: TLabel
          Left = 5
          Top = 6
          Width = 48
          Height = 12
          Caption = '�ֶ�����'
        end
        object ED_CAPTION: TEdit
          Left = 105
          Top = 2
          Width = 150
          Height = 18
          TabOrder = 0
        end
      end
      object ED_PRINT_STYLE2: TPanel
        Left = 0
        Top = 120
        Width = 265
        Height = 61
        Caption = ' '
        Color = 8644350
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 6
        object Label8: TLabel
          Left = 5
          Top = 9
          Width = 60
          Height = 12
          Caption = '���ݱ�����'
        end
        object Label15: TLabel
          Left = 5
          Top = 36
          Width = 72
          Height = 12
          Caption = '������λ����'
        end
        object ED_FIELD_NAME: TComboBox
          Left = 105
          Top = 30
          Width = 150
          Height = 20
          Ctl3D = False
          ItemHeight = 12
          ParentCtl3D = False
          TabOrder = 0
        end
        object ED_TABLE_NAME: TComboBox
          Left = 105
          Top = 2
          Width = 150
          Height = 20
          Ctl3D = False
          ItemHeight = 12
          ParentCtl3D = False
          TabOrder = 1
          OnChange = ED_TABLE_NAMEChange
        end
      end
      object ED_PRINT_STYLE3: TPanel
        Left = 0
        Top = 182
        Width = 265
        Height = 29
        Caption = ' '
        Color = 8644350
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 7
        object Label17: TLabel
          Left = 5
          Top = 6
          Width = 72
          Height = 12
          Caption = '���������ֶ�'
        end
        object ED_SYSLST: TEdit
          Left = 105
          Top = 2
          Width = 150
          Height = 18
          TabOrder = 0
        end
      end
    end
    object PAGE_B: TTabSheet
      Caption = '��������'
      ImageIndex = 1
      object Label7: TLabel
        Left = 0
        Top = 9
        Width = 48
        Height = 12
        Caption = '�֡�����'
      end
      object Label13: TLabel
        Left = 0
        Top = 84
        Width = 48
        Height = 12
        Caption = '����һ��'
      end
      object Label14: TLabel
        Left = 130
        Top = 89
        Width = 143
        Height = 17
        AutoSize = False
        Caption = ' �������2, ������һ��'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        WordWrap = True
      end
      object Label18: TLabel
        Left = 0
        Top = 34
        Width = 72
        Height = 12
        Caption = '��ȷŴ����'
      end
      object Label19: TLabel
        Left = 0
        Top = 59
        Width = 72
        Height = 12
        Caption = '�߶ȷŴ����'
      end
      object Label11: TLabel
        Left = 0
        Top = 109
        Width = 48
        Height = 12
        Caption = '��ת�Ƕ�'
      end
      object Label23: TLabel
        Left = 167
        Top = 44
        Width = 69
        Height = 37
        AutoSize = False
        Caption = '�������������Ŵ���'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        WordWrap = True
      end
      object Label26: TLabel
        Left = 130
        Top = 109
        Width = 131
        Height = 17
        AutoSize = False
        Caption = '��CLEVER'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        WordWrap = True
      end
      object ED_LB_FONT_STYLE: TComboBox
        Left = 70
        Top = 5
        Width = 96
        Height = 20
        Style = csDropDownList
        Ctl3D = False
        DropDownCount = 10
        ItemHeight = 12
        ParentCtl3D = False
        TabOrder = 0
        Items.Strings = (
          '1'
          '2'
          '3'
          '4'
          '5'
          '6'
          '7'
          '8'
          '9'
          'TST24.BF2')
      end
      object ED_LB_SUBTEXT: TSpinEdit
        Left = 70
        Top = 80
        Width = 60
        Height = 21
        Ctl3D = False
        MaxValue = 0
        MinValue = 0
        ParentCtl3D = False
        TabOrder = 1
        Value = -1
      end
      object ED_LB_ZOOM_W: TSpinEdit
        Left = 105
        Top = 30
        Width = 60
        Height = 21
        Ctl3D = False
        MaxValue = 0
        MinValue = 0
        ParentCtl3D = False
        TabOrder = 2
        Value = 0
      end
      object ED_LB_ZOOM_H: TSpinEdit
        Left = 105
        Top = 55
        Width = 60
        Height = 21
        Ctl3D = False
        MaxValue = 0
        MinValue = 0
        ParentCtl3D = False
        TabOrder = 3
        Value = 0
      end
      object ED_LB_ROTAT: TSpinEdit
        Left = 70
        Top = 105
        Width = 60
        Height = 21
        Ctl3D = False
        MaxValue = 0
        MinValue = 0
        ParentCtl3D = False
        TabOrder = 4
        Value = 0
      end
      object GroupBox1: TGroupBox
        Left = 0
        Top = 135
        Width = 276
        Height = 116
        Caption = '����˵��'
        TabOrder = 5
        object Label22: TLabel
          Left = 5
          Top = 24
          Width = 266
          Height = 33
          AutoSize = False
          Caption = 'CLEVER  ������ѡTST24.BF2���壬�����������'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          WordWrap = True
        end
        object Label25: TLabel
          Left = 5
          Top = 52
          Width = 266
          Height = 22
          AutoSize = False
          Caption = 'ARGOX   ������ѡ 7 �����壬�����������'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          WordWrap = True
        end
      end
    end
    object PAGE_C: TTabSheet
      Caption = '����������'
      ImageIndex = 2
      object Label9: TLabel
        Left = 0
        Top = 9
        Width = 60
        Height = 12
        Caption = '������߶�'
      end
      object Label10: TLabel
        Left = 0
        Top = 34
        Width = 60
        Height = 12
        Caption = '��������'
      end
      object Label12: TLabel
        Left = 0
        Top = 59
        Width = 60
        Height = 12
        Caption = '������Ƕ�'
      end
      object Label16: TLabel
        Left = 0
        Top = 84
        Width = 60
        Height = 12
        Caption = '����������'
      end
      object ED_BC_HEIGHT: TSpinEdit
        Left = 70
        Top = 5
        Width = 60
        Height = 21
        Ctl3D = False
        MaxValue = 0
        MinValue = 0
        ParentCtl3D = False
        TabOrder = 0
        Value = 0
      end
      object ED_BC_WIDTH: TSpinEdit
        Left = 70
        Top = 30
        Width = 60
        Height = 21
        Ctl3D = False
        MaxValue = 0
        MinValue = 0
        ParentCtl3D = False
        TabOrder = 1
        Value = 0
      end
      object ED_BC_ROTAT: TSpinEdit
        Left = 70
        Top = 55
        Width = 60
        Height = 21
        Ctl3D = False
        MaxValue = 0
        MinValue = 0
        ParentCtl3D = False
        TabOrder = 2
        Value = 0
      end
      object ED_BC_CODE_KIND: TComboBox
        Left = 70
        Top = 80
        Width = 111
        Height = 20
        Style = csDropDownList
        Ctl3D = False
        ItemHeight = 12
        ParentCtl3D = False
        TabOrder = 3
        Items.Strings = (
          'CODE 39'
          'CODE 93'
          'CODE 128'
          'EAN13')
      end
      object ED_BC_HUMAN: TRadioGroup
        Left = 0
        Top = 110
        Width = 181
        Height = 71
        Caption = '��ӡ��ʽ'
        Ctl3D = False
        ItemIndex = 0
        Items.Strings = (
          '�������·���ӡ����'
          '�������·�ӡ����')
        ParentCtl3D = False
        TabOrder = 4
      end
      object Memo1: TMemo
        Left = 0
        Top = 185
        Width = 136
        Height = 61
        BorderStyle = bsNone
        Color = 16237796
        Ctl3D = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -13
        Font.Name = '������'
        Font.Style = []
        Lines.Strings = (
          'CODE39   ���'
          'CODE93   �еȡ���'
          'CODE128 ���    '
          'EAN13     ֻ�ʺ�13'
          '����')
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 5
      end
    end
  end
  object X_SET_OK: TButton
    Left = 10
    Top = 295
    Width = 85
    Height = 30
    Caption = '����'
    TabOrder = 1
    OnClick = X_SET_OKClick
  end
  object X_SET_CANCEL: TButton
    Left = 105
    Top = 295
    Width = 85
    Height = 30
    Caption = 'ȡ��'
    TabOrder = 2
    OnClick = X_SET_CANCELClick
  end
  object X_SET_DEL: TButton
    Left = 200
    Top = 295
    Width = 85
    Height = 30
    Caption = 'ɾ��'
    TabOrder = 3
    OnClick = X_SET_DELClick
  end
end
