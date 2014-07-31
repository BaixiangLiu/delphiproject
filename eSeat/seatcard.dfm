object frmcard: Tfrmcard
  Left = 140
  Top = 215
  Width = 828
  Height = 780
  Caption = #25171#21360#24109#21345
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  Scaled = False
  PixelsPerInch = 96
  TextHeight = 13
  object QuickRep1: TQuickRep
    Left = -88
    Top = 48
    Width = 794
    Height = 1123
    Frame.Color = clBlack
    Frame.DrawTop = False
    Frame.DrawBottom = False
    Frame.DrawLeft = False
    Frame.DrawRight = False
    DataSet = dmseat.aq_meeting_people
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
      100
      100
      0)
    PrinterSettings.Copies = 1
    PrinterSettings.Duplex = False
    PrinterSettings.FirstPage = 0
    PrinterSettings.LastPage = 0
    PrinterSettings.OutputBin = Auto
    PrintIfEmpty = True
    SnapToGrid = True
    Units = MM
    Zoom = 100
    object QRSubDetail1: TQRSubDetail
      Left = 38
      Top = 38
      Width = 718
      Height = 747
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
        1976.4375
        1899.70833333333)
      Master = QuickRep1
      DataSet = dmseat.aq_meeting_people
      PrintBefore = False
      PrintIfEmpty = True
      object QRDBText1: TQRDBText
        Left = 104
        Top = 96
        Width = 538
        Height = 108
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          285.75
          275.166666666667
          254
          1423.45833333333)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = True
        Color = clWhite
        DataSet = dmseat.aq_meeting_people
        DataField = 'displayname'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -96
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 72
      end
      object QRDBText2: TQRDBText
        Left = 136
        Top = 232
        Width = 73
        Height = 457
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          1209.14583333333
          359.833333333333
          613.833333333333
          193.145833333333)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        BiDiMode = bdLeftToRight
        ParentBiDiMode = False
        Color = clWhite
        DataSet = dmseat.aq_meeting_people
        DataField = 'displayname'
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -96
        Font.Name = '@'#26041#27491#33298#20307
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 72
      end
    end
  end
end
