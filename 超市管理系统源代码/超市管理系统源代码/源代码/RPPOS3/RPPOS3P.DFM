object RMPOS3P: TRMPOS3P
  Left = 199
  Top = 121
  Width = 811
  Height = 636
  Caption = 'RMPOS3P'
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '宋体'
  Font.Style = []
  OldCreateOrder = True
  Scaled = False
  PixelsPerInch = 96
  TextHeight = 12
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
    DataSet = RMPOS3F.QBMEM
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    Functions.Strings = (
      'PAGENUMBER'
      'COLUMNNUMBER'
      'REPORTTITLE'
      'QRSTRINGSBAND1')
    Functions.DATA = (
      '0'
      '0'
      #39#39
      #39#39)
    Options = [FirstPageHeader, LastPageFooter]
    Page.Columns = 1
    Page.Orientation = poPortrait
    Page.PaperSize = A4
    Page.Values = (
      160
      2970
      100
      2100
      50
      50
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
    object QRBand3: TQRBand
      Left = 26
      Top = 153
      Width = 1058
      Height = 30
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      AlignToBottom = False
      BeforePrint = QRBand3BeforePrint
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
        56.6964285714286
        1999.49404761905)
      BandType = rbDetail
      object QRShape2: TQRShape
        Left = 7
        Top = 9
        Width = 1040
        Height = 21
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          39.6875
          13.2291666666667
          17.0089285714286
          1965.47619047619)
        Shape = qrsRectangle
      end
      object PAENO: TQRDBText
        Left = 12
        Top = 12
        Width = 100
        Height = 16
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          30.2380952380952
          22.6785714285714
          22.6785714285714
          188.988095238095)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Color = clWhite
        DataSet = RMPOS3F.QBMEM
        DataField = 'PAENO'
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
      object BMNAM: TQRDBText
        Left = 195
        Top = 12
        Width = 65
        Height = 16
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          30.2380952380952
          368.526785714286
          22.6785714285714
          122.842261904762)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Color = clWhite
        DataSet = RMPOS3F.QBMEM
        DataField = 'BMNAM'
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
      object BMENO: TQRDBText
        Left = 119
        Top = 12
        Width = 70
        Height = 16
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          30.2380952380952
          224.895833333333
          22.6785714285714
          132.291666666667)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Color = clWhite
        DataSet = RMPOS3F.QBMEM
        DataField = 'BMENO'
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
      object QRDBText7: TQRDBText
        Left = 283
        Top = 12
        Width = 40
        Height = 16
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          30.2380952380952
          534.83630952381
          22.6785714285714
          75.5952380952381)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Color = clWhite
        DataSet = RMPOS3F.QBMEM
        DataField = 'BMLVE'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 8
      end
      object QRDBText6: TQRDBText
        Left = 595
        Top = 12
        Width = 100
        Height = 16
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          30.2380952380952
          1124.47916666667
          22.6785714285714
          188.988095238095)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Color = clWhite
        DataSet = RMPOS3F.QBMEM
        DataField = 'BMTL1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 8
      end
      object QRDBText8: TQRDBText
        Left = 510
        Top = 12
        Width = 80
        Height = 16
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          30.2380952380952
          963.839285714286
          22.6785714285714
          151.190476190476)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Color = clWhite
        DataSet = RMPOS3F.QBMEM
        DataField = 'BMBDT'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 8
      end
      object QRDBText9: TQRDBText
        Left = 340
        Top = 12
        Width = 80
        Height = 16
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          30.2380952380952
          642.559523809524
          22.6785714285714
          151.190476190476)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Color = clWhite
        DataSet = RMPOS3F.QBMEM
        DataField = 'BMBYR'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 8
      end
      object QRDBText10: TQRDBText
        Left = 425
        Top = 12
        Width = 80
        Height = 16
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          30.2380952380952
          803.199404761905
          22.6785714285714
          151.190476190476)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Color = clWhite
        DataSet = RMPOS3F.QBMEM
        DataField = 'BMBTO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 8
      end
      object QRDBText11: TQRDBText
        Left = 700
        Top = 12
        Width = 340
        Height = 16
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          30.2380952380952
          1322.91666666667
          22.6785714285714
          642.559523809524)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Color = clWhite
        DataSet = RMPOS3F.QBMEM
        DataField = 'BMAD1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 8
      end
    end
    object QRBand1: TQRBand
      Left = 26
      Top = 128
      Width = 1058
      Height = 25
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
        47.2470238095238
        1999.49404761905)
      BandType = rbColumnHeader
      object QRShape1: TQRShape
        Left = 7
        Top = 5
        Width = 1040
        Height = 20
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          37.797619047619
          13.2291666666667
          9.44940476190476
          1965.47619047619)
        Shape = qrsRectangle
      end
      object QRLabel1: TQRLabel
        Left = 12
        Top = 7
        Width = 100
        Height = 16
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          30.2380952380952
          22.6785714285714
          13.2291666666667
          188.988095238095)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = '销售编号'
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
      object LB_BMNAM: TQRLabel
        Left = 195
        Top = 7
        Width = 65
        Height = 16
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          30.2380952380952
          368.526785714286
          13.2291666666667
          122.842261904762)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = '会员姓名'
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
      object LB_BMENO: TQRLabel
        Left = 119
        Top = 7
        Width = 70
        Height = 16
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          30.2380952380952
          224.895833333333
          13.2291666666667
          132.291666666667)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = '会员编号'
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
      object QRLabel6: TQRLabel
        Left = 283
        Top = 7
        Width = 40
        Height = 16
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          30.2380952380952
          534.83630952381
          13.2291666666667
          75.5952380952381)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = '等级'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 8
      end
      object QRLabel8: TQRLabel
        Left = 340
        Top = 7
        Width = 80
        Height = 16
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          30.2380952380952
          642.559523809524
          13.2291666666667
          151.190476190476)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = '年消费额'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 8
      end
      object QRLabel9: TQRLabel
        Left = 425
        Top = 7
        Width = 80
        Height = 16
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          30.2380952380952
          803.199404761905
          13.2291666666667
          151.190476190476)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = '总消费额'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 8
      end
      object QRLabel11: TQRLabel
        Left = 510
        Top = 7
        Width = 80
        Height = 16
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          30.2380952380952
          963.839285714286
          13.2291666666667
          151.190476190476)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = '最近交易日'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 8
      end
      object QRLabel12: TQRLabel
        Left = 595
        Top = 7
        Width = 100
        Height = 16
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          30.2380952380952
          1124.47916666667
          13.2291666666667
          188.988095238095)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = '现居电话'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 8
      end
      object QRLabel13: TQRLabel
        Left = 700
        Top = 7
        Width = 340
        Height = 16
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          30.2380952380952
          1322.91666666667
          13.2291666666667
          642.559523809524)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = '现居地址'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 8
      end
    end
    object QRSubDetail1: TQRSubDetail
      Left = 26
      Top = 201
      Width = 1058
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      AlignToBottom = False
      Color = clWhite
      ForceNewColumn = False
      ForceNewPage = False
      LinkBand = QRBand3
      Size.Values = (
        32.1279761904762
        1999.49404761905)
      Master = QuickRep
      DataSet = QPOSB
      HeaderBand = QRBand4
      PrintBefore = False
      PrintIfEmpty = True
      object QRDBText1: TQRDBText
        Left = 10
        Top = 0
        Width = 100
        Height = 16
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          30.2380952380952
          18.8988095238095
          0
          188.988095238095)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Color = clWhite
        DataSet = QPOSB
        DataField = 'BGENO'
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
      object QRDBText2: TQRDBText
        Left = 118
        Top = 0
        Width = 218
        Height = 16
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          30.2380952380952
          223.005952380952
          0
          411.994047619048)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Color = clWhite
        DataSet = QPOSB
        DataField = 'BGNAM'
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
      object QRDBText3: TQRDBText
        Left = 340
        Top = 0
        Width = 35
        Height = 16
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          30.2380952380952
          642.559523809524
          0
          66.1458333333333)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Color = clWhite
        DataSet = QPOSB
        DataField = 'BGCNT'
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
      object QRDBText4: TQRDBText
        Left = 380
        Top = 0
        Width = 70
        Height = 16
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          30.2380952380952
          718.154761904762
          0
          132.291666666667)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Color = clWhite
        DataSet = QPOSB
        DataField = 'BGCOS'
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
      object QRDBText5: TQRDBText
        Left = 455
        Top = 0
        Width = 70
        Height = 16
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          30.2380952380952
          859.895833333333
          0
          132.291666666667)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Color = clWhite
        DataSet = QPOSB
        DataField = 'BGCOT'
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
      object QRDBText12: TQRDBText
        Left = 842
        Top = 0
        Width = 50
        Height = 16
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          30.2380952380952
          1591.27976190476
          0
          94.4940476190476)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Color = clWhite
        DataSet = QPOSB
        DataField = 'BGKIN'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
        Transparent = True
        WordWrap = False
        FontSize = 8
      end
      object QRDBText13: TQRDBText
        Left = 595
        Top = 0
        Width = 55
        Height = 16
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          30.2380952380952
          1124.47916666667
          0
          103.943452380952)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Color = clWhite
        DataSet = QPOSB
        DataField = 'BGPST'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
        Transparent = True
        WordWrap = False
        FontSize = 8
      end
      object QRDBText14: TQRDBText
        Left = 655
        Top = 0
        Width = 55
        Height = 16
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          30.2380952380952
          1237.87202380952
          0
          103.943452380952)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Color = clWhite
        DataSet = QPOSB
        DataField = 'BGPMM'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
        Transparent = True
        WordWrap = False
        FontSize = 8
      end
      object QRDBText15: TQRDBText
        Left = 715
        Top = 0
        Width = 55
        Height = 16
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          30.2380952380952
          1351.26488095238
          0
          103.943452380952)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Color = clWhite
        DataSet = QPOSB
        DataField = 'BGPVP'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
        Transparent = True
        WordWrap = False
        FontSize = 8
      end
      object QRDBText16: TQRDBText
        Left = 775
        Top = 0
        Width = 55
        Height = 16
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          30.2380952380952
          1464.65773809524
          0
          103.943452380952)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Color = clWhite
        DataSet = QPOSB
        DataField = 'BGCOS_1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
        Transparent = True
        WordWrap = False
        FontSize = 8
      end
    end
    object QRBand2: TQRBand
      Left = 26
      Top = 53
      Width = 1058
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
        1999.49404761905)
      BandType = rbTitle
      object QRLabel16: TQRLabel
        Left = 713
        Top = 42
        Width = 96
        Height = 30
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          56.6964285714286
          1347.48511904762
          79.375
          181.428571428571)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = '日期：'
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
      object ED_DAT1: TQRLabel
        Left = 810
        Top = 42
        Width = 100
        Height = 30
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          56.6964285714286
          1530.80357142857
          79.375
          188.988095238095)
        Alignment = taCenter
        AlignToBand = False
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
      object QRLabel22: TQRLabel
        Left = 910
        Top = 42
        Width = 34
        Height = 30
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          56.6964285714286
          1719.79166666667
          79.375
          64.2559523809524)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = '～'
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
      object ED_DAT2: TQRLabel
        Left = 945
        Top = 42
        Width = 100
        Height = 30
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          56.6964285714286
          1785.9375
          79.375
          188.988095238095)
        Alignment = taCenter
        AlignToBand = False
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
      object QRLabel17: TQRLabel
        Left = 0
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
          0
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
      object QRLabel2: TQRLabel
        Left = 0
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
          0
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
        Left = 0
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
          0
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
        Left = 0
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
          0
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
        Left = 180
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
          340.178571428571
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
        Left = 180
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
          340.178571428571
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
      object LB_USER_CORP_TEL: TQRLabel
        Left = 80
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
          151.190476190476
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
      object LB_USER_CORP_RBPST: TQRLabel
        Left = 80
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
          151.190476190476
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
      object LB_USER_CORP_NO: TQRLabel
        Left = 260
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
          491.369047619048
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
      object LB_USER_CORP_FAX: TQRLabel
        Left = 260
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
          491.369047619048
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
      object LB_USER_CORP_ADDR: TQRLabel
        Left = 80
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
          151.190476190476
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
      object LB_USER_CORP_NAME: TQRLabel
        Left = 80
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
          151.190476190476
          37.7976190476191
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
      object LBTITLE: TQRLabel
        Left = 855
        Top = 3
        Width = 203
        Height = 35
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          66.1458333333333
          1615.84821428571
          5.66964285714286
          383.645833333333)
        Alignment = taRightJustify
        AlignToBand = True
        AutoSize = True
        AutoStretch = False
        Caption = '查询分类报表'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = '楷体'
        Font.Style = []
        ParentFont = False
        Transparent = False
        WordWrap = False
        FontSize = 18
      end
    end
    object QRBand4: TQRBand
      Left = 26
      Top = 183
      Width = 1058
      Height = 18
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      AlignToBottom = False
      BeforePrint = QRBand3BeforePrint
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
        34.0178571428571
        1999.49404761905)
      BandType = rbGroupHeader
      object QRLabel3: TQRLabel
        Left = 118
        Top = 2
        Width = 218
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          24.5684523809524
          223.005952380952
          3.7797619047619
          411.994047619048)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = '产品名称'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
        Transparent = True
        WordWrap = False
        FontSize = 7
      end
      object QRLabel4: TQRLabel
        Left = 10
        Top = 2
        Width = 100
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          24.5684523809524
          18.8988095238095
          3.7797619047619
          188.988095238095)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = '产品条形码'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
        Transparent = True
        WordWrap = False
        FontSize = 7
      end
      object QRLabel5: TQRLabel
        Left = 340
        Top = 2
        Width = 35
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          24.5684523809524
          642.559523809524
          3.7797619047619
          66.1458333333333)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = '数量'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
        Transparent = True
        WordWrap = False
        FontSize = 7
      end
      object QRLabel7: TQRLabel
        Left = 380
        Top = 2
        Width = 70
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          24.5684523809524
          718.154761904762
          3.7797619047619
          132.291666666667)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = '卖出单价'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
        Transparent = True
        WordWrap = False
        FontSize = 7
      end
      object QRLabel10: TQRLabel
        Left = 455
        Top = 2
        Width = 70
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          24.5684523809524
          859.895833333333
          3.7797619047619
          132.291666666667)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = '卖出小计'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
        Transparent = True
        WordWrap = False
        FontSize = 7
      end
      object QRLabel15: TQRLabel
        Left = 842
        Top = 2
        Width = 50
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          24.5684523809524
          1591.27976190476
          3.7797619047619
          94.4940476190476)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = '分类'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
        Transparent = True
        WordWrap = False
        FontSize = 7
      end
      object QRLabel24: TQRLabel
        Left = 595
        Top = 2
        Width = 55
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          24.5684523809524
          1124.47916666667
          3.7797619047619
          103.943452380952)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = '标准价'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
        Transparent = True
        WordWrap = False
        FontSize = 7
      end
      object QRLabel25: TQRLabel
        Left = 655
        Top = 2
        Width = 55
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          24.5684523809524
          1237.87202380952
          3.7797619047619
          103.943452380952)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = '会员价'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
        Transparent = True
        WordWrap = False
        FontSize = 7
      end
      object QRLabel26: TQRLabel
        Left = 715
        Top = 2
        Width = 55
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          24.5684523809524
          1351.26488095238
          3.7797619047619
          103.943452380952)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = '贵宾价'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
        Transparent = True
        WordWrap = False
        FontSize = 7
      end
      object QRLabel27: TQRLabel
        Left = 775
        Top = 2
        Width = 55
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          24.5684523809524
          1464.65773809524
          3.7797619047619
          103.943452380952)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = '成本'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
        Transparent = True
        WordWrap = False
        FontSize = 7
      end
    end
  end
  object QPOSB: TQuery
    DatabaseName = 'MAIN'
    SQL.Strings = (
      'SELECT * FROM BGDS, POSB'
      'WHERE POSB.BGENO = BGDS.BGENO '
      '  AND PAENO IN ('
      '          SELECT PAENO FROM POSA'
      '          WHERE POSA.BMENO = '#39'000006'#39
      '           )')
    Left = 30
    Top = 15
    object QPOSBBGENO: TStringField
      FieldName = 'BGENO'
    end
    object QPOSBBGNAM: TStringField
      FieldName = 'BGNAM'
      Size = 40
    end
    object QPOSBBGKIN: TStringField
      FieldName = 'BGKIN'
      Size = 3
    end
    object QPOSBBGPST: TFloatField
      FieldName = 'BGPST'
    end
    object QPOSBBGPVP: TFloatField
      FieldName = 'BGPVP'
    end
    object QPOSBBGPMM: TFloatField
      FieldName = 'BGPMM'
    end
    object QPOSBBGCST: TFloatField
      FieldName = 'BGCST'
    end
    object QPOSBBGOTH: TFloatField
      FieldName = 'BGOTH'
    end
    object QPOSBBGQTS: TFloatField
      FieldName = 'BGQTS'
    end
    object QPOSBBGQTN: TFloatField
      FieldName = 'BGQTN'
    end
    object QPOSBBGCOS: TFloatField
      FieldName = 'BGCOS'
    end
    object QPOSBBSENO: TStringField
      FieldName = 'BSENO'
      Size = 10
    end
    object QPOSBBGQTN_1: TFloatField
      FieldName = 'BGQTN_1'
    end
    object QPOSBBGENO_1: TStringField
      FieldName = 'BGENO_1'
    end
    object QPOSBBGCNT: TFloatField
      FieldName = 'BGCNT'
    end
    object QPOSBBGCOS_1: TFloatField
      FieldName = 'BGCOS_1'
    end
    object QPOSBBGCOT: TFloatField
      FieldName = 'BGCOT'
    end
  end
end
