object FMALLEGO: TFMALLEGO
  Left = 274
  Top = 113
  AutoScroll = False
  Caption = 'DATAMAX Allegro 2  打印设置'
  ClientHeight = 373
  ClientWidth = 342
  Color = 10472673
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 16
  object PageControl: TPageControl
    Left = 5
    Top = 2
    Width = 331
    Height = 334
    ActivePage = PAGE_A
    Style = tsFlatButtons
    TabOrder = 0
    TabWidth = 155
    object PAGE_A: TTabSheet
      Caption = '打印设置'
      object Label5: TLabel
        Left = 170
        Top = 64
        Width = 48
        Height = 16
        Caption = '打印密度'
      end
      object Label6: TLabel
        Left = 50
        Top = 34
        Width = 56
        Height = 16
        Caption = '参考坐标X'
      end
      object Label7: TLabel
        Left = 170
        Top = 34
        Width = 57
        Height = 16
        Caption = '参考坐标Y'
      end
      object Label10: TLabel
        Left = 50
        Top = 94
        Width = 48
        Height = 16
        Caption = '延迟时间'
      end
      object Label16: TLabel
        Left = 50
        Top = 124
        Width = 48
        Height = 16
        Caption = '条形码种类'
      end
      object Label1: TLabel
        Left = 50
        Top = 64
        Width = 48
        Height = 16
        Caption = '打印点数'
      end
      object ED_PORT: TRadioGroup
        Left = 165
        Top = 185
        Width = 150
        Height = 110
        Caption = '连接口'
        Columns = 2
        ItemIndex = 1
        Items.Strings = (
          'COM1'
          'COM2'
          'COM3'
          'COM4')
        TabOrder = 8
      end
      object ED_CUTTER: TCheckBox
        Left = 50
        Top = 154
        Width = 83
        Height = 17
        Alignment = taLeftJustify
        Caption = '裁刀切纸'
        TabOrder = 7
      end
      object ED_DENSITY: TSpinEdit
        Left = 245
        Top = 59
        Width = 45
        Height = 26
        MaxValue = 30
        MinValue = 0
        TabOrder = 3
        Value = 10
      end
      object ED_DIR: TRadioGroup
        Left = 5
        Top = 185
        Width = 150
        Height = 110
        BiDiMode = bdLeftToRight
        Caption = '打印方向'
        Columns = 2
        ItemIndex = 0
        Items.Strings = (
          '正面'
          '左侧'
          '反面'
          '右侧')
        ParentBiDiMode = False
        TabOrder = 6
      end
      object ED_DELAY: TSpinEdit
        Left = 120
        Top = 90
        Width = 145
        Height = 26
        MaxValue = 0
        MinValue = 0
        TabOrder = 4
        Value = 600
      end
      object ED_CODE: TComboBox
        Left = 120
        Top = 120
        Width = 145
        Height = 24
        Style = csDropDownList
        ImeName = '中文 (简体) - 智能 ABC '
        ItemHeight = 16
        TabOrder = 5
        Items.Strings = (
          'CODE 39'
          'CODE 93'
          'CODE 128'
          'EAN13')
      end
      object ED_DOT: TSpinEdit
        Left = 120
        Top = 59
        Width = 45
        Height = 26
        MaxValue = 30
        MinValue = 0
        TabOrder = 2
        Value = 12
      end
      object ED_REF1: TMaskEdit
        Left = 120
        Top = 30
        Width = 45
        Height = 24
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ImeName = '中文 (简体) - 智能 ABC'
        ParentFont = False
        TabOrder = 0
        Text = '0'
        OnExit = ED_REF2Exit
      end
      object ED_REF2: TMaskEdit
        Left = 246
        Top = 30
        Width = 45
        Height = 24
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ImeName = '中文 (简体) - 智能 ABC'
        ParentFont = False
        TabOrder = 1
        Text = '0'
        OnExit = ED_REF2Exit
      end
    end
    object TabSheet2: TTabSheet
      Caption = '打印测试'
      object Label8: TLabel
        Left = 15
        Top = 9
        Width = 24
        Height = 16
        Caption = '文字'
      end
      object Label9: TLabel
        Left = 15
        Top = 34
        Width = 24
        Height = 16
        Caption = '条形码'
      end
      object Label17: TLabel
        Left = 125
        Top = 84
        Width = 48
        Height = 16
        Caption = '传送内容'
      end
      object Label2: TLabel
        Left = 15
        Top = 59
        Width = 24
        Height = 16
        Caption = '中文'
      end
      object P_TEST_TEXT: TBitBtn
        Left = 240
        Top = 5
        Width = 80
        Height = 25
        Caption = '打印'
        TabOrder = 1
        OnClick = P_TEST_TEXTClick
        Glyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          04000000000080000000120B0000120B00001000000010000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF00C0C0C00000FFFF00FF000000C0C0C000FFFF0000FFFFFF00DADADADADADA
          DADAAD00000000000DADD0888888888080DA000000000000080D0888888BBB88
          000A088888877788080D00000000000008800888888888808080D00000000008
          0800AD0FFFFFFFF08080DAD0F00000F0000AADA0FFFFFFFF0DADDADA0F00000F
          0ADAADAD0FFFFFFFF0ADDADAD000000000DAADADADADADADADAD}
      end
      object P_TEXT: TEdit
        Left = 50
        Top = 5
        Width = 180
        Height = 24
        ImeName = '中文 (简体) - 智能 ABC'
        TabOrder = 0
      end
      object P_BARCODE: TEdit
        Left = 50
        Top = 30
        Width = 180
        Height = 24
        ImeName = '中文 (简体) - 智能 ABC'
        TabOrder = 2
      end
      object P_TEST_BARCODE: TBitBtn
        Left = 240
        Top = 30
        Width = 80
        Height = 25
        Caption = '打印'
        TabOrder = 3
        OnClick = P_TEST_BARCODEClick
        Glyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          04000000000080000000120B0000120B00001000000010000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF00C0C0C00000FFFF00FF000000C0C0C000FFFF0000FFFFFF00DADADADADADA
          DADAAD00000000000DADD0888888888080DA000000000000080D0888888BBB88
          000A088888877788080D00000000000008800888888888808080D00000000008
          0800AD0FFFFFFFF08080DAD0F00000F0000AADA0FFFFFFFF0DADDADA0F00000F
          0ADAADAD0FFFFFFFF0ADDADAD000000000DAADADADADADADADAD}
      end
      object Memo: TMemo
        Left = 0
        Top = 105
        Width = 321
        Height = 196
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ImeName = '中文 (简体) - 智能 ABC'
        ParentFont = False
        ScrollBars = ssVertical
        TabOrder = 4
      end
      object P_CTEXT: TEdit
        Left = 50
        Top = 55
        Width = 180
        Height = 24
        ImeName = '中文 (简体) - 智能 ABC'
        TabOrder = 5
      end
      object P_TEST_CTEXT: TBitBtn
        Left = 240
        Top = 55
        Width = 80
        Height = 25
        Caption = '打印'
        TabOrder = 6
        OnClick = P_TEST_CTEXTClick
        Glyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          04000000000080000000120B0000120B00001000000010000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF00C0C0C00000FFFF00FF000000C0C0C000FFFF0000FFFFFF00DADADADADADA
          DADAAD00000000000DADD0888888888080DA000000000000080D0888888BBB88
          000A088888877788080D00000000000008800888888888808080D00000000008
          0800AD0FFFFFFFF08080DAD0F00000F0000AADA0FFFFFFFF0DADDADA0F00000F
          0ADAADAD0FFFFFFFF0ADDADAD000000000DAADADADADADADADAD}
      end
    end
  end
  object BitBtn1: TBitBtn
    Left = 5
    Top = 340
    Width = 330
    Height = 30
    Caption = '将设置值存入Allegro 2'
    TabOrder = 1
    OnClick = BitBtn1Click
    Glyph.Data = {
      66010000424D6601000000000000560000002800000010000000110000000100
      08000000000010010000120B0000120B00000800000000000000FFFF9400CCCC
      CC009E9E9E00E8E80F00A3A3010030301E0060605B005E5E1300010202020202
      0202020207070202020102020202020202020202070307020202020202020202
      0202020207030407060206060606060606020202070304040505010101010101
      0605060207030404070201010101020606060606070304040702010101010207
      0502020207030404070201010202020407060202070305070702010606060504
      0307060207030607070206040404040303030706070304040702060300000000
      0000040607030404070202060606060400040602070304040702010101010204
      0406020207030404070201010101020705020202060404040702010101010202
      0602020202060404070201010101010106020202020206040702010101010101
      02060606060606060601}
  end
  object Comm1: TComm
    CommName = 'COM2'
    BaudRate = 9600
    ParityCheck = False
    Outx_CtsFlow = False
    Outx_DsrFlow = False
    DtrControl = DtrEnable
    DsrSensitivity = False
    TxContinueOnXoff = True
    Outx_XonXoffFlow = True
    Inx_XonXoffFlow = True
    ReplaceWhenParityError = False
    IgnoreNullChar = False
    RtsControl = RtsEnable
    XonLimit = 500
    XoffLimit = 500
    ByteSize = _8
    Parity = None
    StopBits = _1
    XonChar = #17
    XoffChar = #19
    ReplacedChar = #0
    ReadIntervalTimeout = 100
    ReadTotalTimeoutMultiplier = 0
    ReadTotalTimeoutConstant = 0
    WriteTotalTimeoutMultiplier = 0
    WriteTotalTimeoutConstant = 0
    Left = 230
    Top = 340
  end
end
