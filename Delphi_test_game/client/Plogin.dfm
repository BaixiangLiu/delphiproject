object Flogin: TFlogin
  Left = 686
  Top = 321
  Width = 291
  Height = 219
  Caption = #30331#24405#39029#38754
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object RzPageControl1: TRzPageControl
    Left = 0
    Top = 0
    Width = 275
    Height = 181
    ActivePage = TabSheet1
    Align = alClient
    BackgroundColor = clWhite
    BoldCurrentTab = True
    Color = clWhite
    UseColoredTabs = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = []
    FlatColor = 16744576
    HotTrackColor = 16744576
    ParentBackgroundColor = False
    ParentColor = False
    ParentFont = False
    ShowShadow = False
    TabColors.HighlightBar = 16776176
    TabColors.Shadow = 16744576
    TabColors.Unselected = clInfoText
    TabIndex = 0
    TabOrder = 0
    TabStyle = tsRoundCorners
    FixedDimension = 17
    object TabSheet1: TRzTabSheet
      Color = clWhite
      Caption = #30331#38470
      object RzBackground1: TRzBackground
        Left = 0
        Top = 0
        Width = 273
        Height = 159
        Active = True
        Align = alClient
        GradientColorStart = clWhite
        GradientColorStop = clNone
        ImageStyle = isCenter
        ShowGradient = True
        ShowImage = False
        ShowTexture = False
      end
      object RzLabel1: TRzLabel
        Left = 32
        Top = 40
        Width = 49
        Height = 13
        AutoSize = False
        Caption = #29992#25143#21517
        Transparent = True
      end
      object RzLabel2: TRzLabel
        Left = 32
        Top = 72
        Width = 49
        Height = 13
        AutoSize = False
        Caption = #23494#30721
        Transparent = True
      end
      object Epsd: TRzEdit
        Left = 88
        Top = 72
        Width = 121
        Height = 19
        Ctl3D = True
        FrameColor = 16744576
        FrameHotColor = 16744576
        FrameHotTrack = True
        FrameHotStyle = fsGroove
        FrameVisible = True
        ImeName = #20013#25991' ('#31616#20307') - '#26234#33021' ABC'
        ParentCtl3D = False
        PasswordChar = '*'
        TabOrder = 0
        OnKeyPress = EpsdKeyPress
      end
      object RzButton1: TRzButton
        Left = 56
        Top = 112
        Caption = #30331#38470
        Color = 15791348
        HighlightColor = 16026986
        HotTrack = True
        HotTrackColor = 3983359
        TabOrder = 1
        OnClick = RzButton1Click
      end
      object RzButton2: TRzButton
        Left = 152
        Top = 112
        Caption = #36864#20986
        Color = 15791348
        HighlightColor = 16026986
        HotTrack = True
        HotTrackColor = 3983359
        TabOrder = 2
        OnClick = RzButton2Click
      end
      object EAcc: TRzComboBox
        Left = 88
        Top = 40
        Width = 121
        Height = 19
        Ctl3D = False
        FlatButtons = True
        FrameColor = 16744576
        FrameHotTrack = True
        FrameHotStyle = fsFlat
        FrameVisible = True
        ImeName = #20013#25991' ('#31616#20307') - '#26234#33021' ABC'
        ItemHeight = 11
        ParentCtl3D = False
        TabOrder = 3
        Text = #32769#20309
      end
    end
    object TabSheet2: TRzTabSheet
      Color = clWhite
      Caption = #26381#21153#22120#35774#32622
      object RzBackground2: TRzBackground
        Left = 0
        Top = 0
        Width = 273
        Height = 159
        Active = True
        Align = alClient
        GradientColorStart = clBtnHighlight
        GradientColorStop = clNone
        ImageStyle = isCenter
        ShowGradient = True
        ShowImage = False
        ShowTexture = False
      end
      object RzLabel3: TRzLabel
        Left = 32
        Top = 80
        Width = 49
        Height = 13
        AutoSize = False
        Caption = #26381#21153#31471#21475
        Transparent = True
      end
      object RzLabel4: TRzLabel
        Left = 32
        Top = 40
        Width = 49
        Height = 13
        AutoSize = False
        Caption = #26381#21153#22120'ip'
        Transparent = True
      end
      object EserviceIP: TRzComboBox
        Left = 88
        Top = 40
        Width = 121
        Height = 21
        Style = csSimple
        Ctl3D = False
        FlatButtons = True
        FrameColor = 16744576
        FrameHotTrack = True
        FrameHotStyle = fsFlat
        FrameVisible = True
        ImeMode = imDisable
        ImeName = #20013#25991' ('#31616#20307') - '#26234#33021' ABC'
        ItemHeight = 11
        ParentCtl3D = False
        TabOrder = 0
        Text = '127.0.0.1'
        Items.Strings = (
          '218.104.213.109')
        ItemIndex = 0
      end
      object EServicePort: TRzComboBox
        Left = 88
        Top = 72
        Width = 121
        Height = 21
        Style = csSimple
        Ctl3D = False
        FlatButtons = True
        FrameColor = 16744576
        FrameHotTrack = True
        FrameHotStyle = fsFlat
        FrameVisible = True
        ImeMode = imDisable
        ImeName = #20013#25991' ('#31616#20307') - '#26234#33021' ABC'
        ItemHeight = 11
        ParentCtl3D = False
        TabOrder = 1
        Text = '8300'
        Items.Strings = (
          '8300')
        ItemIndex = 0
      end
      object RzButton3: TRzButton
        Left = 88
        Top = 112
        Caption = #20462#25913
        Color = 15791348
        HighlightColor = 16026986
        HotTrack = True
        HotTrackColor = 3983359
        TabOrder = 2
        OnClick = RzButton3Click
      end
    end
  end
end
