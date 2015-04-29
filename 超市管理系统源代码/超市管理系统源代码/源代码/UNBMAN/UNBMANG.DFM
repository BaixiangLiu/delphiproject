object FMBMANG: TFMBMANG
  Left = 148
  Top = 153
  Width = 500
  Height = 375
  Caption = '个人信息'
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '宋体'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 490
    Height = 271
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = '宋体'
    Font.Style = []
    ImeName = '中文 (简体) - 微软拼音'
    ParentFont = False
    TabOrder = 0
  end
  object BTNADD: TBitBtn
    Left = 0
    Top = 275
    Width = 491
    Height = 71
    Caption = '存盘'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -28
    Font.Name = '宋体'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = BTNADDClick
  end
end
