object Form1: TForm1
  Left = 386
  Top = 240
  AutoScroll = False
  Caption = 'Form1'
  ClientHeight = 384
  ClientWidth = 615
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 16
  object Bevel1: TBevel
    Left = -16
    Top = 16
    Width = 785
    Height = 9
    Shape = bsTopLine
  end
  object Label2: TLabel
    Left = 16
    Top = 8
    Width = 40
    Height = 16
    Alignment = taCenter
    Caption = #20889#21345' '
  end
  object Bevel2: TBevel
    Left = -8
    Top = 272
    Width = 785
    Height = 9
    Shape = bsTopLine
  end
  object Label3: TLabel
    Left = 16
    Top = 264
    Width = 48
    Height = 16
    Alignment = taCenter
    Caption = ' '#35835#21345' '
  end
  object Label4: TLabel
    Left = 8
    Top = 292
    Width = 80
    Height = 16
    Caption = #21047#21345#36755#20837#26694
  end
  object Label5: TLabel
    Left = 8
    Top = 324
    Width = 32
    Height = 16
    Caption = #20363#23376
  end
  object Label6: TLabel
    Left = 8
    Top = 352
    Width = 457
    Height = 17
    AutoSize = False
    Caption = #23558' ['#20363#23376'] '#20013#30340#25968#25454#22797#21046#21040' ['#21047#21345#36755#20837#26694'] '#20013#21487#20197#30475#21040#36716#25442#25928#26524#12290
  end
  object Button2: TButton
    Left = 424
    Top = 136
    Width = 185
    Height = 113
    Caption = #29992'USB'#35835#20889#22120#20889#21345
    TabOrder = 0
    OnClick = Button2Click
  end
  object Button4: TButton
    Left = 472
    Top = 320
    Width = 137
    Height = 49
    Caption = #36864#20986
    TabOrder = 1
    OnClick = Button4Click
  end
  object GroupBox1: TGroupBox
    Left = 56
    Top = 32
    Width = 361
    Height = 65
    Caption = #31532#19968#22359'('#20004#23383#33410#30340#33521#25991')'
    TabOrder = 2
    object Edit1: TEdit
      Left = 16
      Top = 24
      Width = 153
      Height = 24
      TabOrder = 0
      Text = 'AB'
    end
  end
  object GroupBox2: TGroupBox
    Left = 56
    Top = 104
    Width = 361
    Height = 65
    Caption = #31532#20108#22359'('#22995#21517'#'#24615#21035'#'#26085#26399')'
    TabOrder = 3
    object Edit2: TEdit
      Left = 16
      Top = 24
      Width = 153
      Height = 24
      TabOrder = 0
      Text = #24352#19977
    end
    object ComboBox1: TComboBox
      Left = 288
      Top = 24
      Width = 57
      Height = 24
      ItemHeight = 16
      ItemIndex = 0
      TabOrder = 1
      Text = #30007
      Items.Strings = (
        #30007
        #22899)
    end
    object DateTimePicker1: TDateTimePicker
      Left = 176
      Top = 24
      Width = 105
      Height = 24
      Date = 39742.443501157410000000
      Time = 39742.443501157410000000
      TabOrder = 2
    end
  end
  object GroupBox3: TGroupBox
    Left = 56
    Top = 184
    Width = 361
    Height = 65
    Caption = #31532#19977#22359'('#36523#20221#35777#21495#30721')'
    TabOrder = 4
    object Edit3: TEdit
      Left = 16
      Top = 24
      Width = 161
      Height = 24
      TabOrder = 0
      Text = '44010519880808586X'
    end
  end
  object Edit4: TEdit
    Left = 94
    Top = 288
    Width = 513
    Height = 24
    TabOrder = 5
    OnChange = Edit4Change
  end
  object Edit5: TEdit
    Left = 41
    Top = 320
    Width = 432
    Height = 24
    TabOrder = 6
    Text = '30310CE24A41424D5C5C8FD1081021144010519880808586580A'
    OnChange = Edit4Change
  end
end
