object FMMAINR: TFMMAINR
  Left = 294
  Top = 229
  Width = 251
  Height = 106
  Caption = 'µÇÂ¼ÐòºÅ'
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'ËÎÌå'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 243
    Height = 79
    Align = alClient
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Caption = ' '
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 0
    object Label1: TLabel
      Left = 10
      Top = 10
      Width = 48
      Height = 12
      Caption = 'µÇÂ¼ÌáÊ¾'
    end
    object LB_HINT: TLabel
      Left = 120
      Top = 10
      Width = 231
      Height = 16
      AutoSize = False
      Caption = ' '
    end
    object BTNQUT: TBitBtn
      Left = 10
      Top = 35
      Width = 80
      Height = 30
      Caption = 'µÇÂ¼'
      TabOrder = 0
      OnClick = BTNQUTClick
    end
    object Edit1: TEdit
      Left = 74
      Top = 3
      Width = 156
      Height = 27
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'ËÎÌå'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnKeyDown = Edit1KeyDown
    end
    object BitBtn1: TBitBtn
      Left = 147
      Top = 35
      Width = 80
      Height = 30
      Caption = 'ÊÔÓÃ'
      TabOrder = 2
      OnClick = BTNQUTClick
    end
  end
end
