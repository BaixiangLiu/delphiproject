object FMREP1: TFMREP1
  Left = -109
  Top = 170
  Width = 800
  Height = 581
  Caption = 'FMREP1'
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '宋体'
  Font.Style = []
  OldCreateOrder = True
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 1581
    Height = 90
    ButtonHeight = 85
    Caption = 'ToolBar1'
    Ctl3D = False
    TabOrder = 0
    object ToolButton1: TToolButton
      Left = 0
      Top = 2
      Width = 8
      Caption = 'ToolButton1'
      Style = tbsSeparator
    end
    object DsnSwitch1: TDsnSwitch
      Left = 8
      Top = 2
      Width = 80
      Height = 85
      AllowAllUp = True
      GroupIndex = 2302
      Caption = '修改位置'
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        04000000000080000000120B0000120B00001000000010000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF00C0C0C00000FFFF00FF000000C0C0C000FFFF0000FFFFFF00DADADADADADA
        DADAADADADADADADADADDADADADAD0FFFFFAADADADAD0FF0FFFFDADADAD0FF0F
        FFFFADADADA000FFFFFFDADADA008FF0FFFFADADA08FFF0F0FFFD0000FFF00F0
        F0F00330FF00FF0F0F0D0FF0F03300F0F00A0F0000000000030D0FF3F3F3F3F3
        F30A0F0000000000030D0FF3F3F3F3F3F80AA0000000000000AD}
      Layout = blGlyphTop
      Spacing = 1
      OnClick = DsnSwitch1Click
      DsnRegister = Dsn8Register1
      DsnMessageFlg = False
      DsnMessage = 'Now, Starting Design'
    end
    object ToolButton2: TToolButton
      Left = 88
      Top = 2
      Width = 8
      Caption = 'ToolButton2'
      ImageIndex = 0
      Style = tbsSeparator
    end
    object PageControl1: TPageControl
      Left = 96
      Top = 2
      Width = 500
      Height = 85
      ActivePage = TabSheet2
      MultiLine = True
      Style = tsButtons
      TabOrder = 1
      object PAGE_A: TTabSheet
        Caption = '产生组件'
        object BTN_QRLB: TSpeedButton
          Left = 5
          Top = 3
          Width = 75
          Height = 25
          Cursor = crHandPoint
          Caption = '文字'
          Layout = blGlyphTop
          Spacing = 0
          OnClick = BTN_QRLBClick
        end
        object BTN_QRQD: TSpeedButton
          Left = 80
          Top = 3
          Width = 75
          Height = 25
          Cursor = crHandPoint
          Caption = '资料'
          Layout = blGlyphTop
          Spacing = 0
          OnClick = BTN_QRQDClick
        end
        object BTN_QRSPV: TSpeedButton
          Left = 5
          Top = 29
          Width = 50
          Height = 25
          Cursor = crHandPoint
          Caption = '直线'
          Layout = blGlyphTop
          Spacing = 0
          OnClick = BTN_QRSPVClick
        end
        object BTN_QRSPH: TSpeedButton
          Left = 55
          Top = 29
          Width = 50
          Height = 25
          Cursor = crHandPoint
          Caption = '横线'
          Layout = blGlyphTop
          Spacing = 0
          OnClick = BTN_QRSPHClick
        end
        object BTN_QRSPR: TSpeedButton
          Left = 105
          Top = 29
          Width = 50
          Height = 25
          Cursor = crHandPoint
          Caption = '方格'
          Layout = blGlyphTop
          Spacing = 0
          OnClick = BTN_QRSPRClick
        end
        object Label2: TLabel
          Left = 170
          Top = 10
          Width = 48
          Height = 12
          Caption = '放入位置'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object CB_COL: TComboBox
          Left = 220
          Top = 6
          Width = 191
          Height = 20
          Style = csDropDownList
          ImeName = '中文 (简体) - 微软拼音'
          ItemHeight = 12
          TabOrder = 0
          Items.Strings = (
            '标题栏'
            '数据域')
        end
      end
      object TabSheet2: TTabSheet
        Caption = '组件信息'
        ImageIndex = 1
        object Label6: TLabel
          Left = 7
          Top = 31
          Width = 11
          Height = 11
          Caption = '上'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object Label11: TLabel
          Left = 67
          Top = 31
          Width = 11
          Height = 11
          Caption = '左'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object Label12: TLabel
          Left = 127
          Top = 31
          Width = 11
          Height = 11
          Caption = '高'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object Label13: TLabel
          Left = 187
          Top = 31
          Width = 11
          Height = 11
          Caption = '宽'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object ED_OBJ: TLabel
          Left = 7
          Top = 8
          Width = 33
          Height = 11
          Caption = '名称：'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object ED_OBJ_TOP: TJEdit
          Left = 22
          Top = 28
          Width = 40
          Height = 17
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = '宋体'
          Font.Style = []
          ImeName = '中文 (简体) - 微软拼音'
          ParentFont = False
          TabOrder = 0
          Text = '0'
          OnChange = ED_OBJ_NAMEChange
          Digits = 0
          Max = 999.9
          _EditType = INTEGER_EDIT
          _SHOWCAL = NONE
          _BADINPUT = False
          _LONGTIME = False
        end
        object ED_OBJ_LEFT: TJEdit
          Left = 82
          Top = 28
          Width = 40
          Height = 17
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = '宋体'
          Font.Style = []
          ImeName = '中文 (简体) - 微软拼音'
          ParentFont = False
          TabOrder = 1
          Text = '0'
          OnChange = ED_OBJ_NAMEChange
          Digits = 0
          Max = 999.9
          _EditType = INTEGER_EDIT
          _SHOWCAL = NONE
          _BADINPUT = False
          _LONGTIME = False
        end
        object ED_OBJ_HEIGHT: TJEdit
          Left = 142
          Top = 28
          Width = 40
          Height = 17
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = '宋体'
          Font.Style = []
          ImeName = '中文 (简体) - 微软拼音'
          ParentFont = False
          TabOrder = 2
          Text = '0'
          OnChange = ED_OBJ_NAMEChange
          Digits = 0
          Max = 999.9
          _EditType = INTEGER_EDIT
          _SHOWCAL = NONE
          _BADINPUT = False
          _LONGTIME = False
        end
        object ED_OBJ_WIDTH: TJEdit
          Left = 202
          Top = 28
          Width = 40
          Height = 17
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = '宋体'
          Font.Style = []
          ImeName = '中文 (简体) - 微软拼音'
          ParentFont = False
          TabOrder = 3
          Text = '0'
          OnChange = ED_OBJ_NAMEChange
          Digits = 0
          Max = 999.9
          _EditType = INTEGER_EDIT
          _SHOWCAL = NONE
          _BADINPUT = False
          _LONGTIME = False
        end
        object BTN_OBJ_APPLY: TBitBtn
          Left = 250
          Top = 5
          Width = 96
          Height = 45
          Caption = '应用'
          TabOrder = 4
          OnClick = BTN_OBJ_APPLYClick
        end
        object ED_OBJ_NAME: TJEdit
          Left = 40
          Top = 5
          Width = 201
          Height = 18
          Color = clSilver
          ImeName = '中文 (简体) - 微软拼音'
          ReadOnly = True
          TabOrder = 5
          Digits = 1
          Max = 999999999
          _EditType = EDIT
          _SHOWCAL = NONE
          _BADINPUT = False
          _LONGTIME = False
        end
      end
      object TabSheet3: TTabSheet
        Caption = '卷标信息'
        ImageIndex = 3
        object Label16: TLabel
          Left = 7
          Top = 3
          Width = 55
          Height = 11
          Caption = '显示标题：'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object Label17: TLabel
          Left = 7
          Top = 23
          Width = 33
          Height = 11
          Caption = '字号：'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object BTN_OBJ_APPLY_LB: TBitBtn
          Left = 250
          Top = 5
          Width = 96
          Height = 45
          Caption = '应用'
          TabOrder = 0
          OnClick = BTN_OBJ_APPLYClick
        end
        object ED_OBJ_FONTSIZE: TSpinEdit
          Left = 70
          Top = 20
          Width = 41
          Height = 21
          MaxValue = 0
          MinValue = 0
          TabOrder = 1
          Value = 11
        end
        object ED_OBJ_CAPTION: TJEdit
          Left = 70
          Top = 0
          Width = 176
          Height = 18
          ImeName = '中文 (简体) - 微软拼音'
          ReadOnly = True
          TabOrder = 2
          Digits = 1
          Max = 999999999
          _EditType = EDIT
          _SHOWCAL = NONE
          _BADINPUT = False
          _LONGTIME = False
        end
      end
      object TabSheet4: TTabSheet
        Caption = '数据信息'
        ImageIndex = 4
        object Label15: TLabel
          Left = 0
          Top = 3
          Width = 48
          Height = 12
          Caption = '数据域位'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object ED_OBJ_FIELD: TComboBox
          Left = 50
          Top = -1
          Width = 100
          Height = 20
          Ctl3D = False
          ImeName = '中文 (简体) - 微软拼音'
          ItemHeight = 12
          ParentCtl3D = False
          TabOrder = 0
          OnChange = ED_OBJ_NAMEChange
        end
        object BTN_OBJ_APPLY_QD: TBitBtn
          Left = 250
          Top = 5
          Width = 96
          Height = 45
          Caption = '应用'
          TabOrder = 1
          OnClick = BTN_OBJ_APPLYClick
        end
      end
      object TabSheet5: TTabSheet
        Caption = '形状信息'
        ImageIndex = 5
        object Label1: TLabel
          Left = 0
          Top = 6
          Width = 24
          Height = 12
          Caption = '图形'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object ED_OBJ_SHAPE: TComboBox
          Left = 25
          Top = 2
          Width = 100
          Height = 20
          Ctl3D = False
          ImeName = '中文 (简体) - 微软拼音'
          ItemHeight = 12
          ParentCtl3D = False
          TabOrder = 0
          OnChange = ED_OBJ_NAMEChange
          Items.Strings = (
            '距形'
            '圆形'
            '直线'
            '横线'
            '横分隔'
            '直分隔')
        end
        object BTN_OBJ_APPLY_SP: TBitBtn
          Left = 250
          Top = 5
          Width = 96
          Height = 45
          Caption = '应用'
          TabOrder = 1
          OnClick = BTN_OBJ_APPLYClick
        end
      end
      object TabSheet1: TTabSheet
        Caption = '报表信息'
        ImageIndex = 2
        object Label3: TLabel
          Left = 2
          Top = 7
          Width = 11
          Height = 11
          Caption = '长'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object Label5: TLabel
          Left = 62
          Top = 7
          Width = 11
          Height = 11
          Caption = '宽'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object Label7: TLabel
          Left = 122
          Top = 7
          Width = 11
          Height = 11
          Caption = '上'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object Label8: TLabel
          Left = 182
          Top = 7
          Width = 11
          Height = 11
          Caption = '下'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object Label9: TLabel
          Left = 242
          Top = 7
          Width = 11
          Height = 11
          Caption = '左'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object Label10: TLabel
          Left = 302
          Top = 7
          Width = 11
          Height = 11
          Caption = '右'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object Label4: TLabel
          Left = 5
          Top = 36
          Width = 48
          Height = 12
          Caption = '数据表格'
        end
        object Label14: TLabel
          Left = 162
          Top = 33
          Width = 22
          Height = 11
          Caption = '抬头'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
        end
        object ED_PAGE_LENGTH: TFloatEdit
          Left = 17
          Top = 4
          Width = 40
          Height = 17
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = '宋体'
          Font.Style = []
          ImeName = '中文 (简体) - 微软拼音'
          ParentFont = False
          TabOrder = 0
          Text = '0.0'
          OnChange = ED_OBJ_NAMEChange
          Digits = 1
          Max = 999.9
          ErrorMessage = '[No Text]'
        end
        object ED_PAGE_WIDTH: TFloatEdit
          Left = 77
          Top = 4
          Width = 40
          Height = 17
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = '宋体'
          Font.Style = []
          ImeName = '中文 (简体) - 微软拼音'
          ParentFont = False
          TabOrder = 1
          Text = '0.0'
          OnChange = ED_OBJ_NAMEChange
          Digits = 1
          Max = 999.9
          ErrorMessage = '[No Text]'
        end
        object ED_PAGE_TOPMARGIN: TFloatEdit
          Left = 137
          Top = 4
          Width = 40
          Height = 17
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = '宋体'
          Font.Style = []
          ImeName = '中文 (简体) - 微软拼音'
          ParentFont = False
          TabOrder = 2
          Text = '0.0'
          OnChange = ED_OBJ_NAMEChange
          Digits = 1
          Max = 999.9
          ErrorMessage = '[No Text]'
        end
        object ED_PAGE_BOTTOMMARGIN: TFloatEdit
          Left = 197
          Top = 4
          Width = 40
          Height = 17
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = '宋体'
          Font.Style = []
          ImeName = '中文 (简体) - 微软拼音'
          ParentFont = False
          TabOrder = 3
          Text = '0.0'
          OnChange = ED_OBJ_NAMEChange
          Digits = 1
          Max = 999.9
          ErrorMessage = '[No Text]'
        end
        object ED_PAGE_LEFTMARGIN: TFloatEdit
          Left = 257
          Top = 4
          Width = 40
          Height = 17
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = '宋体'
          Font.Style = []
          ImeName = '中文 (简体) - 微软拼音'
          ParentFont = False
          TabOrder = 4
          Text = '0.0'
          OnChange = ED_OBJ_NAMEChange
          Digits = 1
          Max = 999.9
          ErrorMessage = '[No Text]'
        end
        object ED_PAGE_RIGHTMARGIN: TFloatEdit
          Left = 317
          Top = 4
          Width = 40
          Height = 17
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = '宋体'
          Font.Style = []
          ImeName = '中文 (简体) - 微软拼音'
          ParentFont = False
          TabOrder = 5
          Text = '0.0'
          OnChange = ED_OBJ_NAMEChange
          Digits = 1
          Max = 999.9
          ErrorMessage = '[No Text]'
        end
        object ED_PAGE_TABLE: TComboBox
          Left = 60
          Top = 28
          Width = 95
          Height = 20
          Ctl3D = False
          ImeName = '中文 (简体) - 微软拼音'
          ItemHeight = 12
          ParentCtl3D = False
          TabOrder = 6
          OnChange = ED_OBJ_NAMEChange
        end
        object ED_PAGE_TITLE: TJEdit
          Left = 187
          Top = 30
          Width = 169
          Height = 17
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = '宋体'
          Font.Style = []
          ImeName = '中文 (简体) - 微软拼音'
          ParentFont = False
          TabOrder = 7
          Text = '0'
          OnChange = ED_OBJ_NAMEChange
          Digits = 0
          Max = 999.9
          _EditType = EDIT
          _SHOWCAL = NONE
          _BADINPUT = False
          _LONGTIME = False
        end
        object BTN_PAGE_APPLY: TBitBtn
          Left = 360
          Top = 5
          Width = 70
          Height = 45
          Caption = '应用'
          TabOrder = 8
          OnClick = BTN_PAGE_APPLYClick
        end
      end
    end
    object ToolButton3: TToolButton
      Left = 596
      Top = 2
      Width = 8
      Caption = 'ToolButton3'
      ImageIndex = 1
      Style = tbsSeparator
    end
    object Panel1: TPanel
      Left = 604
      Top = 2
      Width = 163
      Height = 85
      Caption = ' '
      TabOrder = 0
      object BTNPRN: TSpeedButton
        Left = 80
        Top = 0
        Width = 80
        Height = 43
        Cursor = crHandPoint
        Caption = '预览'
        Glyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          04000000000080000000120B0000120B00001000000010000000000000000084
          840084848400C6C6C6000000FF0000FFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00333333333333
          3333330000000000033330313131313010330000000000000103013131355531
          0003031313122213010300000000000001100131313131301010300000000003
          0100330666666660301044446000002203033333066666663033444444000002
          2203333333066666633044444444000000003333333333333333}
        Layout = blGlyphTop
        OnClick = BTNPRNClick
      end
      object BTNSAV: TSpeedButton
        Left = 0
        Top = 0
        Width = 80
        Height = 43
        Cursor = crHandPoint
        Caption = '保存'
        Glyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          04000000000080000000120B0000120B00001000000010000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF00C0C0C00000FFFF00FF000000C0C0C000FFFF0000FFFFFF00DADADADADADA
          DADAAD0000000000000DD03300000088030AA03300000088030DD03300000088
          030AA03300000000030DD03333333333330AA03300000000330DD03088888888
          030AA03088888888030DD03088888888030AA03088888888030DD03088888888
          000AA03088888888080DD00000000000000AADADADADADADADAD}
        Layout = blGlyphTop
        OnClick = BTNSAVClick
      end
      object BTNQUT: TSpeedButton
        Left = 80
        Top = 43
        Width = 80
        Height = 41
        Cursor = crHandPoint
        Caption = '离开'
        Glyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          04000000000080000000120B0000120B00001000000010000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF00C0C0C00000FFFF00FF000000C0C0C000FFFF0000FFFFFF00DADADADADADA
          DADAAD000000000000ADDA0FFF0BB0FFF0DAAD0FFF0BB0FFF0ADDA0FFF0BB0FF
          F0DAAD0FFF0BB0FFF0ADDA0FFF0000FFF0DAAD0FFFFFFFFFF0ADD0B0FFFFFFFF
          0B0AAD0B0FFFFFF0B0ADDAD0B0FFFF0B0ADAADAD0B0FF0B00DADDADAD0B00B01
          0ADAADADAD0BB0A10DADDADADAD00AD10ADAADADADADADADADAD}
        Layout = blGlyphTop
        OnClick = BTNQUTClick
      end
      object BTNCLR: TSpeedButton
        Left = 0
        Top = 43
        Width = 80
        Height = 41
        Cursor = crHandPoint
        Caption = '清除'
        Glyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          04000000000080000000120B0000120B00001000000010000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF00C0C0C00000FFFF00FF000000C0C0C000FFFF0000FFFFFF00DADADADADADA
          DADAADADA70000000000DADA088770DADADAADA08888770DADADDA78878F8770
          DADAAD0878F8F8770DADDAD0FF8F8F8770DAADAD0FF8F8F8770DDADAD0FF8F8F
          870AADADAD0FF8F8F80DDADADAD0FF8F8F0AADADADAD0FF880ADDADADADAD777
          7ADAADADADADADADADADDADADADADADADADAADADADADADADADAD}
        Layout = blGlyphTop
        OnClick = BTNCLRClick
      end
    end
  end
  object QRLB: TDsnStage
    Left = 1
    Top = 90
    Width = 1580
    Height = 1120
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Caption = ' '
    Color = 14211288
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 1
    Rubberband.Color = clGray
    Rubberband.PenWidth = 2
    Rubberband.MoveWidth = 8
    Rubberband.MoveHeight = 8
    FixPosition = False
    FixSize = False
    object QuickRep: TQuickRep
      Left = 5
      Top = 5
      Width = 1111
      Height = 1572
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      DataSet = Query
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      Functions.Strings = (
        'PAGENUMBER'
        'COLUMNNUMBER'
        'REPORTTITLE')
      Functions.DATA = (
        '0'
        '0'
        #39#39)
      Options = [FirstPageHeader, LastPageFooter]
      Page.Columns = 1
      Page.Orientation = poPortrait
      Page.PaperSize = A4
      Page.Values = (
        100
        2970
        100
        2100
        80
        80
        0)
      PrinterSettings.Copies = 1
      PrinterSettings.Duplex = False
      PrinterSettings.FirstPage = 0
      PrinterSettings.LastPage = 0
      PrinterSettings.OutputBin = First
      PrintIfEmpty = False
      SnapToGrid = True
      Units = MM
      Zoom = 140
      object QRBand_TITLE: TQRBand
        Left = 42
        Top = 128
        Width = 1026
        Height = 24
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        AlignToBottom = False
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = '宋体'
        Font.Style = []
        ForceNewColumn = False
        ForceNewPage = False
        ParentFont = False
        Size.Values = (
          45.3571428571429
          1939.01785714286)
        BandType = rbColumnHeader
        object QRShape5: TQRShape
          Left = 10
          Top = 1
          Width = 1000
          Height = 22
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            41.577380952381
            18.8988095238095
            1.88988095238095
            1889.88095238095)
          Shape = qrsRectangle
        end
        object QRShape9: TQRShape
          Left = 100
          Top = 2
          Width = 1
          Height = 21
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            39.6875
            188.988095238095
            3.7797619047619
            1.88988095238095)
          Shape = qrsVertLine
        end
      end
      object QRBand5: TQRBand
        Left = 42
        Top = 53
        Width = 1026
        Height = 75
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        AlignToBottom = False
        Color = clWhite
        ForceNewColumn = False
        ForceNewPage = False
        Size.Values = (
          141.741071428571
          1939.01785714286)
        BandType = rbTitle
        object VRITUAL_LB: TLabel
          Left = 605
          Top = 30
          Width = 76
          Height = 16
          Caption = 'VRITUAL_LB'
          Visible = False
          OnMouseDown = VRITUAL_LBMouseDown
        end
        object VRITUAL_QD: TLabel
          Left = 605
          Top = 45
          Width = 79
          Height = 16
          Caption = 'VRITUAL_QD'
          Visible = False
          OnMouseDown = VRITUAL_QDMouseDown
        end
        object VRITUAL_SP: TLabel
          Left = 605
          Top = 60
          Width = 78
          Height = 16
          Caption = 'VRITUAL_SP'
          Visible = False
          OnMouseDown = VRITUAL_SPMouseDown
        end
        object XLB_TITLE: TQRLabel
          Left = 829
          Top = 2
          Width = 197
          Height = 38
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            71.8154761904762
            1566.71130952381
            3.7797619047619
            372.306547619048)
          Alignment = taRightJustify
          AlignToBand = True
          AutoSize = True
          AutoStretch = False
          Caption = '资料明细表'
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -27
          Font.Name = '楷体'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 20
        end
        object QRLabel17: TQRLabel
          Left = 5
          Top = 2
          Width = 78
          Height = 16
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            30.2380952380952
            9.44940476190476
            3.7797619047619
            147.410714285714)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = '本店位置：'
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = False
          FontSize = 8
        end
        object QRLabel19: TQRLabel
          Left = 5
          Top = 38
          Width = 78
          Height = 16
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            30.2380952380952
            9.44940476190476
            71.8154761904762
            147.410714285714)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = '公司电话：'
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = False
          FontSize = 8
        end
        object QRLabel20: TQRLabel
          Left = 5
          Top = 56
          Width = 78
          Height = 16
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            30.2380952380952
            9.44940476190476
            105.833333333333
            147.410714285714)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = '公司地址：'
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = False
          FontSize = 8
        end
        object QRLabel21: TQRLabel
          Left = 5
          Top = 20
          Width = 78
          Height = 16
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            30.2380952380952
            9.44940476190476
            37.797619047619
            147.410714285714)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = '公司名称：'
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = False
          FontSize = 8
        end
        object QRLabel23: TQRLabel
          Left = 185
          Top = 38
          Width = 78
          Height = 16
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            30.2380952380952
            349.627976190476
            71.8154761904762
            147.410714285714)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = '公司传真：'
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = False
          FontSize = 8
        end
        object QRLabel18: TQRLabel
          Left = 185
          Top = 2
          Width = 78
          Height = 16
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            30.2380952380952
            349.627976190476
            3.7797619047619
            147.410714285714)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = '统一编号：'
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = False
          FontSize = 8
        end
        object XLB_USER_TEL: TQRLabel
          Left = 85
          Top = 38
          Width = 95
          Height = 16
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            30.2380952380952
            160.639880952381
            71.8154761904762
            179.53869047619)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = False
          AutoStretch = False
          Caption = ' '
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = False
          FontSize = 8
        end
        object XLB_USER_RBPST: TQRLabel
          Left = 85
          Top = 3
          Width = 95
          Height = 16
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            30.2380952380952
            160.639880952381
            5.66964285714286
            179.53869047619)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = False
          AutoStretch = False
          Caption = 'XLB_USER_RBPST'
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = False
          FontSize = 8
        end
        object XLB_USER_NO: TQRLabel
          Left = 265
          Top = 3
          Width = 95
          Height = 16
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            30.2380952380952
            500.818452380952
            5.66964285714286
            179.53869047619)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = False
          AutoStretch = False
          Caption = ' '
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = False
          FontSize = 8
        end
        object XLB_USER_FAX: TQRLabel
          Left = 265
          Top = 38
          Width = 95
          Height = 16
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            30.2380952380952
            500.818452380952
            71.8154761904762
            179.53869047619)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = False
          AutoStretch = False
          Caption = ' '
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = False
          FontSize = 8
        end
        object XLB_USER_ADDR: TQRLabel
          Left = 85
          Top = 56
          Width = 276
          Height = 16
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            30.2380952380952
            160.639880952381
            105.833333333333
            521.607142857143)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = False
          AutoStretch = False
          Caption = ' '
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = False
          FontSize = 8
        end
        object XLB_USER_NAME: TQRLabel
          Left = 85
          Top = 20
          Width = 276
          Height = 16
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            30.2380952380952
            160.639880952381
            37.797619047619
            521.607142857143)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = False
          AutoStretch = False
          Caption = ' '
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = False
          FontSize = 8
        end
        object XLB_DAT1: TQRLabel
          Left = 769
          Top = 42
          Width = 257
          Height = 30
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            56.6964285714286
            1453.31845238095
            79.375
            485.699404761905)
          Alignment = taRightJustify
          AlignToBand = True
          AutoSize = False
          AutoStretch = False
          Caption = ' '
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = '宋体'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = False
          FontSize = 16
        end
      end
      object QRBand_DETAIL: TQRBand
        Left = 42
        Top = 152
        Width = 1026
        Height = 19
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        AlignToBottom = False
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = '宋体'
        Font.Style = []
        ForceNewColumn = False
        ForceNewPage = False
        ParentFont = False
        Size.Values = (
          35.9077380952381
          1939.01785714286)
        BandType = rbDetail
        object QRShape21: TQRShape
          Left = 10
          Top = -1
          Width = 1000
          Height = 20
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            37.797619047619
            18.8988095238095
            -1.88988095238095
            1889.88095238095)
          Shape = qrsRectangle
        end
        object QRShape7: TQRShape
          Left = 100
          Top = 0
          Width = 1
          Height = 19
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            35.9077380952381
            188.988095238095
            0
            1.88988095238095)
          Shape = qrsVertLine
        end
      end
    end
  end
  object Dsn8Register1: TDsn8Register
    DsnStage = QRLB
    Left = 209
    Top = 345
  end
  object Query: TQuery
    DatabaseName = 'MAIN'
    Left = 214
    Top = 392
  end
end
