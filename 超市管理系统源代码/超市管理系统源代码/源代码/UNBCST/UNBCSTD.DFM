object FMBCSTD: TFMBCSTD
  OldCreateOrder = True
  Left = 344
  Top = 120
  Height = 428
  Width = 439
  object DSBCST: TDataSource
    DataSet = QBCST
    Left = 75
    Top = 10
  end
  object QBCST: TQuery
    CachedUpdates = True
    AfterEdit = QBCSTAfterEdit
    DatabaseName = 'MAIN'
    SQL.Strings = (
      'SELECT * FROM BCST')
    UpdateObject = UBCST
    Left = 15
    Top = 10
    object QBCSTBCMN2: TStringField
      FieldName = 'BCMN2'
      Origin = 'MAIN.BCST.BCMN2'
      Size = 10
    end
    object QBCSTBCENO: TStringField
      FieldName = 'BCENO'
      Origin = 'MAIN.BCST.BCENO'
      Size = 10
    end
    object QBCSTBCNAM: TStringField
      FieldName = 'BCNAM'
      Origin = 'MAIN.BCST.BCNAM'
      Size = 40
    end
    object QBCSTBCCNA: TStringField
      FieldName = 'BCCNA'
      Origin = 'MAIN.BCST.BCCNA'
      Size = 40
    end
    object QBCSTBCSCN: TStringField
      FieldName = 'BCSCN'
      Origin = 'MAIN.BCST.BCSCN'
      Size = 3
    end
    object QBCSTBCMN1: TStringField
      FieldName = 'BCMN1'
      Origin = 'MAIN.BCST.BCMN1'
      Size = 10
    end
    object QBCSTBCMN3: TStringField
      FieldName = 'BCMN3'
      Origin = 'MAIN.BCST.BCMN3'
      Size = 10
    end
    object QBCSTBCTL1: TStringField
      FieldName = 'BCTL1'
      Origin = 'MAIN.BCST.BCTL1'
      Size = 15
    end
    object QBCSTBCTL2: TStringField
      FieldName = 'BCTL2'
      Origin = 'MAIN.BCST.BCTL2'
      Size = 15
    end
    object QBCSTBCFX1: TStringField
      FieldName = 'BCFX1'
      Origin = 'MAIN.BCST.BCFX1'
      Size = 15
    end
    object QBCSTBCFX2: TStringField
      FieldName = 'BCFX2'
      Origin = 'MAIN.BCST.BCFX2'
      Size = 15
    end
    object QBCSTBCAD1: TStringField
      FieldName = 'BCAD1'
      Origin = 'MAIN.BCST.BCAD1'
      Size = 50
    end
    object QBCSTBCAD2: TStringField
      FieldName = 'BCAD2'
      Origin = 'MAIN.BCST.BCAD2'
      Size = 50
    end
    object QBCSTBCZP1: TStringField
      FieldName = 'BCZP1'
      Origin = 'MAIN.BCST.BCZP1'
      Size = 5
    end
    object QBCSTBCZP2: TStringField
      FieldName = 'BCZP2'
      Origin = 'MAIN.BCST.BCZP2'
      Size = 5
    end
    object QBCSTBCTL9: TStringField
      FieldName = 'BCTL9'
      Origin = 'MAIN.BCST.BCTL9'
      Size = 15
    end
    object QBCSTBCAD9: TStringField
      FieldName = 'BCAD9'
      Origin = 'MAIN.BCST.BCAD9'
      Size = 50
    end
    object QBCSTBCZP9: TStringField
      FieldName = 'BCZP9'
      Origin = 'MAIN.BCST.BCZP9'
      Size = 5
    end
    object QBCSTBCDIS: TFloatField
      FieldName = 'BCDIS'
      Origin = 'MAIN.BCST.BCDIS'
    end
    object QBCSTBCTP1: TFloatField
      FieldName = 'BCTP1'
      Origin = 'MAIN.BCST.BCTP1'
    end
    object QBCSTBCTP2: TFloatField
      FieldName = 'BCTP2'
      Origin = 'MAIN.BCST.BCTP2'
    end
    object QBCSTBCTP5: TFloatField
      FieldName = 'BCTP5'
      Origin = 'MAIN.BCST.BCTP5'
    end
    object QBCSTBCTP6: TFloatField
      FieldName = 'BCTP6'
      Origin = 'MAIN.BCST.BCTP6'
    end
    object QBCSTBCTPN: TStringField
      FieldName = 'BCTPN'
      Origin = 'MAIN.BCST.BCTPN'
      Size = 30
    end
    object QBCSTBCTTP: TStringField
      FieldName = 'BCTTP'
      Origin = 'MAIN.BCST.BCTTP'
      Size = 3
    end
    object QBCSTBCTTD: TFloatField
      FieldName = 'BCTTD'
      Origin = 'MAIN.BCST.BCTTD'
    end
    object QBCSTBCTEG: TStringField
      FieldName = 'BCTEG'
      Origin = 'MAIN.BCST.BCTEG'
      Size = 5
    end
    object QBCSTBCTBK: TStringField
      FieldName = 'BCTBK'
      Origin = 'MAIN.BCST.BCTBK'
      Size = 3
    end
    object QBCSTBCALT: TFloatField
      FieldName = 'BCALT'
      Origin = 'MAIN.BCST.BCALT'
    end
    object QBCSTBCTDT: TDateTimeField
      FieldName = 'BCTDT'
      Origin = 'MAIN.BCST.BCTDT'
    end
    object QBCSTBCDAT: TDateTimeField
      FieldName = 'BCDAT'
      Origin = 'MAIN.BCST.BCDAT'
    end
    object QBCSTBCID1: TStringField
      FieldName = 'BCID1'
      Origin = 'MAIN.BCST.BCID1'
      Size = 10
    end
    object QBCSTBCMRK: TMemoField
      FieldName = 'BCMRK'
      Origin = 'MAIN.BCST.BCMRK'
      BlobType = ftMemo
      Size = 1
    end
    object QBCSTBNENO: TStringField
      FieldName = 'BNENO'
      Origin = 'MAIN.BCST.BNENO'
      Size = 10
    end
  end
  object UBCST: TUpdateSQL
    Left = 155
    Top = 10
  end
end