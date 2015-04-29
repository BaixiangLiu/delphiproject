object FMCCAWD: TFMCCAWD
  OldCreateOrder = False
  Left = 285
  Top = 161
  Height = 479
  Width = 741
  object QBMEM: TQuery
    DatabaseName = 'MAIN'
    SQL.Strings = (
      'SELECT * FROM BMEM')
    Left = 30
    Top = 70
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
  object DSBMEM: TDataSource
    DataSet = QBMEM
    Left = 75
    Top = 70
  end
  object QCCAW: TQuery
    DatabaseName = 'MAIN'
    SQL.Strings = (
      'SELECT * FROM CCAW, BMEM'
      'WHERE CCAW.BMENO = BMEM.BMENO')
    Left = 30
    Top = 5
    object QCCAWBMENO: TStringField
      FieldName = 'BMENO'
      Origin = 'CCAW.BMENO'
      Size = 10
    end
    object QCCAWCWGET: TBooleanField
      FieldName = 'CWGET'
      Origin = 'CCAW.CWGET'
    end
    object QCCAWCWGDS: TStringField
      FieldName = 'CWGDS'
      Origin = 'CCAW.CWGDS'
    end
    object QCCAWBMENO_1: TStringField
      FieldName = 'BMENO_1'
      Origin = 'CCAW.BMENO'
      Size = 10
    end
    object QCCAWBMNAM: TStringField
      FieldName = 'BMNAM'
      Origin = 'MAIN.CCAW.BMENO'
      Size = 10
    end
    object QCCAWBMCNA: TStringField
      FieldName = 'BMCNA'
      Origin = 'MAIN.CCAW.BMENO'
      Size = 10
    end
    object QCCAWBMBTH: TDateTimeField
      FieldName = 'BMBTH'
      Origin = 'MAIN.CCAW.BMENO'
    end
    object QCCAWBMSEX: TStringField
      FieldName = 'BMSEX'
      Origin = 'MAIN.CCAW.BMENO'
      Size = 1
    end
    object QCCAWBMLVE: TFloatField
      FieldName = 'BMLVE'
      Origin = 'MAIN.CCAW.BMENO'
    end
    object QCCAWBMBYR: TFloatField
      FieldName = 'BMBYR'
      Origin = 'MAIN.CCAW.BMENO'
    end
    object QCCAWBMBTO: TFloatField
      FieldName = 'BMBTO'
      Origin = 'MAIN.CCAW.BMENO'
    end
    object QCCAWBMBPO: TFloatField
      FieldName = 'BMBPO'
      Origin = 'MAIN.CCAW.BMENO'
    end
    object QCCAWBMBTM: TFloatField
      FieldName = 'BMBTM'
      Origin = 'MAIN.CCAW.BMENO'
    end
    object QCCAWBMBDT: TDateTimeField
      FieldName = 'BMBDT'
      Origin = 'MAIN.CCAW.BMENO'
    end
    object QCCAWBMBYD: TDateTimeField
      FieldName = 'BMBYD'
      Origin = 'MAIN.CCAW.BMENO'
    end
    object QCCAWBMWPN: TStringField
      FieldName = 'BMWPN'
      Origin = 'MAIN.CCAW.BMENO'
      Size = 15
    end
    object QCCAWBMTL1: TStringField
      FieldName = 'BMTL1'
      Origin = 'MAIN.CCAW.BMENO'
      Size = 15
    end
    object QCCAWBMTL2: TStringField
      FieldName = 'BMTL2'
      Origin = 'MAIN.CCAW.BMENO'
      Size = 15
    end
    object QCCAWBMTL3: TStringField
      FieldName = 'BMTL3'
      Origin = 'MAIN.CCAW.BMENO'
      Size = 15
    end
    object QCCAWBMAD1: TStringField
      FieldName = 'BMAD1'
      Origin = 'MAIN.CCAW.BMENO'
      Size = 50
    end
    object QCCAWBMAD2: TStringField
      FieldName = 'BMAD2'
      Origin = 'MAIN.CCAW.BMENO'
      Size = 50
    end
    object QCCAWBMZP1: TStringField
      FieldName = 'BMZP1'
      Origin = 'MAIN.CCAW.BMENO'
      Size = 5
    end
    object QCCAWBMZP2: TStringField
      FieldName = 'BMZP2'
      Origin = 'MAIN.CCAW.BMENO'
      Size = 5
    end
    object QCCAWBMEML: TStringField
      FieldName = 'BMEML'
      Origin = 'MAIN.CCAW.BMENO'
      Size = 30
    end
    object QCCAWBMWWW: TStringField
      FieldName = 'BMWWW'
      Origin = 'MAIN.CCAW.BMENO'
      Size = 30
    end
    object QCCAWBMJND: TDateTimeField
      FieldName = 'BMJND'
      Origin = 'MAIN.CCAW.BMENO'
    end
    object QCCAWBMCRD: TDateTimeField
      FieldName = 'BMCRD'
      Origin = 'MAIN.CCAW.BMENO'
    end
    object QCCAWBMDAT: TDateTimeField
      FieldName = 'BMDAT'
      Origin = 'MAIN.CCAW.BMENO'
    end
    object QCCAWRBPST: TStringField
      FieldName = 'RBPST'
      Origin = 'MAIN.CCAW.BMENO'
      Size = 3
    end
    object QCCAWBMMRK: TMemoField
      FieldName = 'BMMRK'
      Origin = 'MAIN.CCAW.BMENO'
      BlobType = ftMemo
      Size = 1
    end
  end
  object DSCCAW: TDataSource
    DataSet = QCCAW
    Left = 75
    Top = 5
  end
end