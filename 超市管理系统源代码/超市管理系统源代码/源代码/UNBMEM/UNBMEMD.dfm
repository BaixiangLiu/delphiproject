object FMBMEMD: TFMBMEMD
  OldCreateOrder = True
  Left = 285
  Top = 161
  Height = 479
  Width = 741
  object DSBMEM: TDataSource
    DataSet = QBMEM
    Left = 75
    Top = 10
  end
  object QBMEM: TQuery
    CachedUpdates = True
    AfterOpen = QBMEMAfterOpen
    AfterEdit = QBMEMAfterEdit
    AfterPost = QBMEMAfterPost
    DatabaseName = 'MAIN'
    SQL.Strings = (
      'SELECT *'
      'FROM BMEM'
      'ORDER BY BMENO')
    UpdateObject = UBMEM
    Left = 15
    Top = 10
    object QBMEMBMENO: TStringField
      FieldName = 'BMENO'
      Origin = 'MAIN.BMEM.BMENO'
      Size = 10
    end
    object QBMEMBMNAM: TStringField
      FieldName = 'BMNAM'
      Origin = 'MAIN.BMEM.BMNAM'
      Size = 10
    end
    object QBMEMBMCNA: TStringField
      FieldName = 'BMCNA'
      Origin = 'MAIN.BMEM.BMCNA'
      Size = 10
    end
    object QBMEMBMBTH: TDateTimeField
      FieldName = 'BMBTH'
      Origin = 'MAIN.BMEM.BMBTH'
    end
    object QBMEMBMSEX: TStringField
      FieldName = 'BMSEX'
      Origin = 'MAIN.BMEM.BMSEX'
      Size = 1
    end
    object QBMEMBMLVE: TFloatField
      FieldName = 'BMLVE'
      Origin = 'MAIN.BMEM.BMLVE'
    end
    object QBMEMBMBYR: TFloatField
      FieldName = 'BMBYR'
      Origin = 'MAIN.BMEM.BMBYR'
    end
    object QBMEMBMBTO: TFloatField
      FieldName = 'BMBTO'
      Origin = 'MAIN.BMEM.BMBTO'
    end
    object QBMEMBMBPO: TFloatField
      FieldName = 'BMBPO'
      Origin = 'MAIN.BMEM.BMBPO'
    end
    object QBMEMBMBTM: TFloatField
      FieldName = 'BMBTM'
      Origin = 'MAIN.BMEM.BMBTM'
    end
    object QBMEMBMBDT: TDateTimeField
      FieldName = 'BMBDT'
      Origin = 'MAIN.BMEM.BMBDT'
    end
    object QBMEMBMBYD: TDateTimeField
      FieldName = 'BMBYD'
      Origin = 'MAIN.BMEM.BMBYD'
    end
    object QBMEMBMWPN: TStringField
      FieldName = 'BMWPN'
      Origin = 'MAIN.BMEM.BMWPN'
      Size = 15
    end
    object QBMEMBMTL1: TStringField
      FieldName = 'BMTL1'
      Origin = 'MAIN.BMEM.BMTL1'
      Size = 15
    end
    object QBMEMBMTL2: TStringField
      FieldName = 'BMTL2'
      Origin = 'MAIN.BMEM.BMTL2'
      Size = 15
    end
    object QBMEMBMTL3: TStringField
      FieldName = 'BMTL3'
      Origin = 'MAIN.BMEM.BMTL3'
      Size = 15
    end
    object QBMEMBMAD1: TStringField
      FieldName = 'BMAD1'
      Origin = 'MAIN.BMEM.BMAD1'
      Size = 50
    end
    object QBMEMBMAD2: TStringField
      FieldName = 'BMAD2'
      Origin = 'MAIN.BMEM.BMAD2'
      Size = 50
    end
    object QBMEMBMZP1: TStringField
      FieldName = 'BMZP1'
      Origin = 'MAIN.BMEM.BMZP1'
      Size = 5
    end
    object QBMEMBMZP2: TStringField
      FieldName = 'BMZP2'
      Origin = 'MAIN.BMEM.BMZP2'
      Size = 5
    end
    object QBMEMBMEML: TStringField
      FieldName = 'BMEML'
      Origin = 'MAIN.BMEM.BMEML'
      Size = 30
    end
    object QBMEMBMWWW: TStringField
      FieldName = 'BMWWW'
      Origin = 'MAIN.BMEM.BMWWW'
      Size = 30
    end
    object QBMEMBMJND: TDateTimeField
      FieldName = 'BMJND'
      Origin = 'MAIN.BMEM.BMJND'
    end
    object QBMEMBMCRD: TDateTimeField
      FieldName = 'BMCRD'
      Origin = 'MAIN.BMEM.BMCRD'
    end
    object QBMEMBMDAT: TDateTimeField
      FieldName = 'BMDAT'
      Origin = 'MAIN.BMEM.BMDAT'
    end
    object QBMEMRBPST: TStringField
      FieldName = 'RBPST'
      Origin = 'MAIN.BMEM.RBPST'
      Size = 3
    end
    object QBMEMBMMRK: TMemoField
      FieldName = 'BMMRK'
      Origin = 'MAIN.BMEM.BMMRK'
      BlobType = ftMemo
      Size = 1
    end
  end
  object UBMEM: TUpdateSQL
    Left = 155
    Top = 10
  end
  object QBMNAMLIKE: TQuery
    CachedUpdates = True
    DatabaseName = 'MAIN'
    SQL.Strings = (
      'SELECT BMNAM'
      'FROM BMEM')
    Left = 15
    Top = 54
    object QBMNAMLIKEBMNAM: TStringField
      FieldName = 'BMNAM'
      Size = 10
    end
  end
  object DSBMNAMLIKE: TDataSource
    DataSet = QBMNAMLIKE
    Left = 78
    Top = 62
  end
end
