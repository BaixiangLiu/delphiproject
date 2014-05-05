object FMain: TFMain
  Left = 579
  Top = 298
  Width = 457
  Height = 346
  Caption = #27979#35797#26381#21153#31471
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 441
    Height = 308
    Align = alClient
    Ctl3D = False
    ImeName = #20013#25991' - QQ'#25340#38899#36755#20837#27861
    Lines.Strings = (
      #25151#38388#20449#24687#65306)
    ParentCtl3D = False
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object GameServer: TIdTCPServer
    Active = True
    Bindings = <>
    CommandHandlers = <>
    DefaultPort = 8300
    Greeting.NumericCode = 0
    MaxConnectionReply.NumericCode = 0
    OnConnect = GameServerConnect
    OnExecute = GameServerExecute
    OnDisconnect = GameServerDisconnect
    OnException = GameServerException
    OnListenException = GameServerListenException
    ReplyExceptionCode = 0
    ReplyTexts = <>
    ReplyUnknownCommand.NumericCode = 0
    Left = 120
    Top = 160
  end
end
