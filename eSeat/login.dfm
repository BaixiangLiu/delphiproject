object frmlogin: Tfrmlogin
  Left = 364
  Top = 252
  Width = 320
  Height = 291
  Caption = #25968#25454#24211#37197#32622
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object Panel1: TPanel
    Left = 0
    Top = 221
    Width = 312
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object BitBtn1: TBitBtn
      Left = 136
      Top = 8
      Width = 75
      Height = 25
      Caption = #30830#23450
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 224
      Top = 8
      Width = 75
      Height = 25
      Caption = #21462#28040
      TabOrder = 1
      OnClick = BitBtn2Click
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 312
    Height = 221
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    object Label1: TLabel
      Left = 40
      Top = 83
      Width = 48
      Height = 12
      Caption = #29992#25143#21517#65306
    end
    object Label2: TLabel
      Left = 40
      Top = 111
      Width = 36
      Height = 12
      Caption = #23494#30721#65306
    end
    object Label3: TLabel
      Left = 40
      Top = 56
      Width = 72
      Height = 12
      Caption = #25968#25454#24211#21517#31216#65306
    end
    object Label4: TLabel
      Left = 40
      Top = 30
      Width = 72
      Height = 12
      Caption = #26381#21153#22120#21517#31216#65306
    end
    object dxEdit1: TdxEdit
      Left = 120
      Top = 24
      Width = 121
      TabOrder = 0
    end
    object dxEdit2: TdxEdit
      Left = 120
      Top = 50
      Width = 121
      TabOrder = 1
    end
    object dxEdit3: TdxEdit
      Left = 120
      Top = 77
      Width = 121
      TabOrder = 2
    end
    object dxEdit4: TdxEdit
      Left = 120
      Top = 105
      Width = 121
      TabOrder = 3
    end
    object RadioGroup1: TRadioGroup
      Left = 40
      Top = 136
      Width = 201
      Height = 65
      Caption = #36523#20221#39564#35777
      TabOrder = 4
    end
    object RadioButton1: TRadioButton
      Left = 80
      Top = 152
      Width = 137
      Height = 17
      Caption = 'SQL Server'#21644'Windows'
      TabOrder = 5
    end
    object RadioButton2: TRadioButton
      Left = 80
      Top = 176
      Width = 113
      Height = 17
      Caption = #20165'Windows'
      TabOrder = 6
    end
  end
end
