object FMEMAIL: TFMEMAIL
  Left = 57
  Top = 165
  AutoScroll = False
  Caption = '来信询问'
  ClientHeight = 345
  ClientWidth = 552
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = '宋体'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object StatusBar: TStatusBar
    Left = 0
    Top = 320
    Width = 552
    Height = 25
    Panels = <>
    SimplePanel = True
  end
  object GroupBox4: TGroupBox
    Left = 0
    Top = 0
    Width = 550
    Height = 320
    Caption = '寄件内容'
    Color = 14012076
    Ctl3D = False
    ParentColor = False
    ParentCtl3D = False
    TabOrder = 1
    object Label11: TLabel
      Left = 11
      Top = 73
      Width = 30
      Height = 15
      Caption = '主旨'
    end
    object Label3: TLabel
      Left = 25
      Top = 104
      Width = 15
      Height = 180
      Caption = '请在右侧输入您的问题内容'
      WordWrap = True
    end
    object Label5: TLabel
      Left = 15
      Top = 23
      Width = 30
      Height = 15
      Caption = '姓名'
    end
    object Label6: TLabel
      Left = 5
      Top = 48
      Width = 36
      Height = 12
      Caption = 'E-Mail'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
    end
    object Edit10: TEdit
      Left = 45
      Top = 70
      Width = 500
      Height = 25
      Ctl3D = False
      ImeName = '中文 (简体) - 微软拼音'
      ParentCtl3D = False
      TabOrder = 2
      Text = 'Micro POS 问题'
    end
    object Memo1: TMemo
      Left = 45
      Top = 95
      Width = 500
      Height = 221
      Ctl3D = False
      ImeName = '中文 (简体) - 微软拼音'
      ParentCtl3D = False
      ScrollBars = ssBoth
      TabOrder = 3
    end
    object BitBtn1: TBitBtn
      Left = 350
      Top = 20
      Width = 196
      Height = 46
      Caption = 'Send It !'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = BitBtn1Click
      Glyph.Data = {
        FA0E0000424DFA0E000000000000360000002800000023000000230000000100
        180000000000C40E0000465C0000465C000000000000000000000000FF0000FF
        0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000
        FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF00
        00FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF
        0000FF0000000000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000
        FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF00
        00FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF
        0000FF0000FF0000FF0000FF0000FF0000000000FF0000FF0000FF0000FF0000
        FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF00000000
        00FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF
        0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000000000
        FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF00
        00FF0000FF0000000000000000000000FF0000FF0000FF0000FF0000FF0000FF
        0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000
        FF0000FF0000FF0000000000FF0000FF0000FF0000FF0000FF0000FF0000FF00
        00FF0000FF0000FF0000FF0000FF000000000000C0C0C00000000000000000FF
        0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000
        FF0000FF0000FF0000FF0000FF0000FF0000FF0000000000FF0000FF0000FF00
        00FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF000000000000C0C0C0
        FFFFFFC0C0C00000000000000000FF0000FF0000FF0000FF0000FF0000FF0000
        FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF00
        00000000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF
        000000000000C0C0C0FFFFFFFFFFFFFFFFFFC0C0C00000000000000000FF0000
        FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF00
        00FF0000FF0000FF0000FF0000000000FF0000FF0000FF0000FF0000FF0000FF
        0000FF0000FF0000FF000000000000C0C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFC0C0C00000000000000000FF0000FF0000FF0000FF0000FF0000FF0000FF00
        00FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000000000FF0000FF
        0000FF0000FF0000FF0000FF0000FF0000FF000000000000C0C0C0FFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0C00000000000000000FF0000FF00
        00FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF
        0000FF0000000000FF0000FF0000FF0000FF0000FF0000FF0000FF0000000000
        00C0C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0
        C0C00000000000000000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF
        0000FF0000FF0000FF0000FF0000FF0000000000FF0000FF0000FF0000FF0000
        FF0000FF000000000000C0C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0C00000000000000000FF0000FF0000FF
        0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000000000
        FF0000FF0000FF0000FF0000FF000000000000C0C0C0FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0C0
        0000000000000000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000
        FF0000FF0000FF0000000000FF0000FF0000FF0000FF000000000000C0C0C0FF
        FFFFFF6000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFC0C0C00000000000000000FF0000FF0000FF0000
        FF0000FF0000FF0000FF0000FF0000FF0000FF0000000000FF0000FF0000FF00
        00FF000000C0C0C0FFFFFFFFFFFFFFFFFFFF6000FFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6000FFFFFFFFFFFFFFFFFFC0C0C00000
        000000000000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF00
        00000000FF0000FF0000FF000000C0C0C0FFFFFFFF6000FFFFFFFFFFFFFFFFFF
        FF6000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6000FFFFFFFFFFFFFF60
        00FFFFFFFFFFFFFFFFFFC0C0C00000000000000000FF0000FF0000FF0000FF00
        00FF0000FF0000FF0000FF0000000000FF0000FF0000FF0000FF000000C0C0C0
        FFFFFFFF6000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6000FFFF
        FFFFFFFFFF6000FFFFFFFFFFFFFF6000FFFFFFFFFFFFFFFFFFC0C0C000000000
        00000000FF0000FF0000FF0000FF0000FF0000FF0000FF0000000000FF0000FF
        0000FF0000FF0000FF000000C0C0C0FFFFFFFF6000FFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFF6000FFFFFFFFFFFFFF6000FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFC0C0C00000000000000000FF0000FF0000FF0000FF0000FF
        0000FF0000000000FF0000FF0000FF0000FF0000FF0000FF000000C0C0C0FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6000FFFFFFFF
        FFFFFF6000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0C0000000000000
        0000FF0000FF0000FF0000FF0000FF0000000000FF0000FF0000FF0000FF0000
        FF0000FF0000FF000000C0C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFF6000FFFFFFFFFFFFFF6000FFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFC0C0C00000000000000000FF0000FF0000FF0000FF0000000000
        FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF000000C0C0C0C0C0C0C0
        C0C0C0C0C0C0C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0C00000000000000000
        FF0000FF0000FF0000000000FF0000FF0000FF0000FF0000FF0000FF0000FF00
        00FF0000FF000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFF6000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFC0C0C00000000000000000FF0000FF0000000000FF0000FF0000FF00
        00FF0000FF0000FF0000FF0000FF000000C0C0C0FFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0C00000000000FF0000FF00
        00000000FF0000FF0000FF0000FF0000FF0000FF0000FF000000C0C0C0C0C0C0
        C0C0C0C0C0C0C0C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0C0000000FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFC0C0C00000000000FF0000000000FF0000FF0000FF0000FF0000FF0000FF
        0000FF000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFF
        FFC0C0C0000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFC0C0C00000000000FF0000FF0000000000FF0000FF
        0000FF0000FF0000FF0000FF000000C0C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFC0C0C0000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0C00000000000FF0000FF
        0000FF0000000000FF0000FF0000FF0000FF0000FF0000FF000000C0C0C0C0C0
        C0C0C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0C0000000FFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0C0
        0000000000FF0000FF0000FF0000FF0000000000FF0000FF0000FF0000FF0000
        00000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFC0C0C000
        0000C0C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF008F00FFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFC0C0C00000000000FF0000FF0000FF0000FF0000FF0000000000
        FF0000FF0000FF000000C0C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFC0C0C0000000707070000000C0C0C0FFFFFFFFFFFFFFFFFF008F00
        008F00008F00FFFFFFFFFFFFFFFFFFC0C0C00000000000FF0000FF0000FF0000
        FF0000FF0000FF0000000000FF0000FF000000C0C0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000707070707070707070000000
        C0C0C0FFFFFF008F00008F00008F00008F00008F00FFFFFFC0C0C00000000000
        FF0000FF0000FF0000FF0000FF0000FF0000FF0000000000FF0000FF00000000
        0000000000000000000000000000000000000000000000000000000000707070
        7070707070700000000000FF000000C0C0C0FFFFFF008F00008F00008F00FFFF
        FFC0C0C00000000000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF00
        00000000FF0000FF0000FF0000FF0000FF000000707070707070707070707070
        7070707070707070707070707070700000000000FF0000FF0000FF000000C0C0
        C0FFFFFF008F00FFFFFFC0C0C00000000000FF0000FF0000FF0000FF0000FF00
        00FF0000FF0000FF0000FF0000000000FF0000FF0000FF0000FF0000FF000000
        0000000000000000000000000000000000000000000000000000000000FF0000
        FF0000FF0000FF0000FF000000C0C0C0FFFFFFC0C0C00000000000FF0000FF00
        00FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000000000FF0000FF
        0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000
        FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000000000FF00
        00000000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF
        0000FF0000000000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000
        FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF00
        00FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF
        0000FF0000FF0000FF0000FF0000FF0000000000FF0000FF0000FF0000FF0000
        FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF00
        00FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF
        0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF000000}
    end
    object Edit5: TEdit
      Left = 45
      Top = 20
      Width = 300
      Height = 25
      ImeName = '中文 (简体) - 微软拼音'
      TabOrder = 0
    end
    object Edit6: TEdit
      Left = 45
      Top = 45
      Width = 300
      Height = 25
      ImeName = '中文 (简体) - 微软拼音'
      TabOrder = 1
    end
    object GroupBox2: TGroupBox
      Left = 265
      Top = 117
      Width = 260
      Height = 160
      Caption = '主机信息'
      Color = 16760962
      Ctl3D = False
      ParentColor = False
      ParentCtl3D = False
      TabOrder = 5
      Visible = False
      object Label1: TLabel
        Left = 5
        Top = 23
        Width = 60
        Height = 15
        Caption = '登入主机'
      end
      object Label2: TLabel
        Left = 186
        Top = 23
        Width = 32
        Height = 15
        Caption = 'Port'
      end
      object Label4: TLabel
        Left = 5
        Top = 48
        Width = 60
        Height = 15
        Caption = '登入名称'
      end
      object Label7: TLabel
        Left = 5
        Top = 68
        Width = 16
        Height = 15
        Caption = 'To'
      end
      object Edit1: TEdit
        Left = 63
        Top = 20
        Width = 120
        Height = 25
        Ctl3D = False
        ImeName = '中文 (简体) - 微软拼音'
        ParentCtl3D = False
        TabOrder = 0
        Text = '203.74.200.13'
      end
      object Edit2: TEdit
        Left = 215
        Top = 20
        Width = 30
        Height = 25
        Ctl3D = False
        ImeName = '中文 (简体) - 微软拼音'
        ParentCtl3D = False
        TabOrder = 1
        Text = '25'
      end
      object BTN_SERVER_CONN: TButton
        Left = 3
        Top = 95
        Width = 143
        Height = 61
        Caption = '联机'
        TabOrder = 2
        OnClick = BTN_SERVER_CONNClick
      end
      object BTN_SERVER_DISC: TButton
        Left = 148
        Top = 95
        Width = 100
        Height = 61
        Caption = '中断'
        TabOrder = 3
        OnClick = BTN_SERVER_DISCClick
      end
      object Edit4: TEdit
        Left = 63
        Top = 45
        Width = 120
        Height = 25
        Ctl3D = False
        ImeName = '中文 (简体) - 微软拼音'
        ParentCtl3D = False
        TabOrder = 4
        Text = 'guest'
      end
      object Edit7: TEdit
        Left = 63
        Top = 70
        Width = 120
        Height = 25
        Ctl3D = False
        ImeName = '中文 (简体) - 微软拼音'
        ParentCtl3D = False
        TabOrder = 5
        Text = 'huangcp@ms29.hinet.net'
      end
    end
  end
  object NMSMTP1: TNMSMTP
    Port = 25
    ReportLevel = 0
    OnDisconnect = NMSMTP1Disconnect
    OnConnect = NMSMTP1Connect
    OnInvalidHost = NMSMTP1InvalidHost
    OnHostResolved = NMSMTP1HostResolved
    OnStatus = NMSMTP1Status
    OnConnectionFailed = NMSMTP1ConnectionFailed
    OnPacketSent = NMSMTP1PacketSent
    OnConnectionRequired = NMSMTP1ConnectionRequired
    PostMessage.LocalProgram = 'NetMasters SMTP Demo'
    EncodeType = uuMime
    ClearParams = True
    SubType = mtHtml
    Charset = 'gb2312'
    OnRecipientNotFound = NMSMTP1RecipientNotFound
    OnHeaderIncomplete = NMSMTP1HeaderIncomplete
    OnSendStart = NMSMTP1SendStart
    OnSuccess = NMSMTP1Success
    OnFailure = NMSMTP1Failure
    OnEncodeStart = NMSMTP1EncodeStart
    OnEncodeEnd = NMSMTP1EncodeEnd
    Left = 73
    Top = 222
  end
end
