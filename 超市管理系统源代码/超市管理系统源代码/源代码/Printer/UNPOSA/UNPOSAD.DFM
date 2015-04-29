object FMPOSAD: TFMPOSAD
  OldCreateOrder = True
  Left = 285
  Top = 161
  Height = 479
  Width = 741
  object QRBRNRBPST: TQuery
    CachedUpdates = True
    DatabaseName = 'MAIN'
    SQL.Strings = (
      'SELECT *'
      'FROM SYSLST'
      'WHERE LSTID1 = '#39'RBRNRBPST'#39
      'ORDER BY LSTID2, LSTNAM')
    Left = 30
    Top = 185
    object QRBRNRBPSTLSTID1: TStringField
      FieldName = 'LSTID1'
      Origin = 'SYSLST.LSTID1'
      Size = 10
    end
    object QRBRNRBPSTLSTID2: TStringField
      FieldName = 'LSTID2'
      Origin = 'SYSLST.LSTID2'
      Size = 10
    end
    object QRBRNRBPSTLSTNAM: TStringField
      FieldName = 'LSTNAM'
      Origin = 'SYSLST.LSTNAM'
      Size = 40
    end
    object QRBRNRBPSTLSTMRK: TStringField
      FieldName = 'LSTMRK'
      Origin = 'SYSLST.LSTMRK'
      Size = 40
    end
  end
  object DSRBRNRBPST: TDataSource
    DataSet = QRBRNRBPST
    Left = 115
    Top = 185
  end
  object DSBMEM: TDataSource
    Left = 70
    Top = 10
  end
  object QBGDS: TQuery
    CachedUpdates = True
    DatabaseName = 'MAIN'
    SQL.Strings = (
      'SELECT *'
      'FROM BGDS'
      'ORDER BY BGENO')
    Left = 15
    Top = 60
    object QBGDSBGENO: TStringField
      FieldName = 'BGENO'
    end
    object QBGDSBGNAM: TStringField
      FieldName = 'BGNAM'
      Size = 50
    end
    object QBGDSBGPST: TFloatField
      FieldName = 'BGPST'
    end
    object QBGDSBGPVP: TFloatField
      FieldName = 'BGPVP'
    end
    object QBGDSBGPMM: TFloatField
      FieldName = 'BGPMM'
    end
    object QBGDSBGPR1: TFloatField
      FieldName = 'BGPR1'
    end
    object QBGDSBGPR2: TFloatField
      FieldName = 'BGPR2'
    end
    object QBGDSBGPR3: TFloatField
      FieldName = 'BGPR3'
    end
    object QBGDSBGID1: TStringField
      FieldName = 'BGID1'
    end
    object QBGDSBGKIN: TStringField
      FieldName = 'BGKIN'
      Size = 10
    end
    object QBGDSBGQTS: TFloatField
      FieldName = 'BGQTS'
    end
    object QBGDSBGCOS: TFloatField
      FieldName = 'BGCOS'
    end
    object QBGDSBSENO: TStringField
      FieldName = 'BSENO'
      Size = 10
    end
  end
  object DSBGDS: TDataSource
    DataSet = QBGDS
    Left = 70
    Top = 60
  end
  object QPOSM: TQuery
    DatabaseName = 'MAIN'
    Left = 405
    Top = 10
  end
  object QPOSNA: TQuery
    DatabaseName = 'MAIN'
    Left = 370
    Top = 80
  end
  object QPOSNB: TQuery
    DatabaseName = 'MAIN'
    Left = 370
    Top = 130
  end
  object DSPOSNA: TDataSource
    DataSet = QPOSNA
    Left = 430
    Top = 80
  end
  object DSPOSNB: TDataSource
    DataSet = QPOSNB
    Left = 430
    Top = 130
  end
  object QBCST: TQuery
    CachedUpdates = True
    DatabaseName = 'MAIN'
    SQL.Strings = (
      'SELECT *'
      'FROM BCST'
      'ORDER BY BCENO')
    Left = 15
    Top = 115
    object QBCSTBCENO: TStringField
      FieldName = 'BCENO'
      Size = 10
    end
    object QBCSTBCNAM: TStringField
      FieldName = 'BCNAM'
      Size = 40
    end
    object QBCSTBCCNA: TStringField
      FieldName = 'BCCNA'
      Size = 40
    end
    object QBCSTBCSNA: TStringField
      FieldName = 'BCSNA'
    end
    object QBCSTBCSCN: TStringField
      FieldName = 'BCSCN'
    end
    object QBCSTBCMN1: TStringField
      FieldName = 'BCMN1'
      Size = 10
    end
    object QBCSTBCMN2: TStringField
      FieldName = 'BCMN2'
      Size = 10
    end
    object QBCSTBCMN3: TStringField
      FieldName = 'BCMN3'
      Size = 10
    end
    object QBCSTBCM2T: TStringField
      FieldName = 'BCM2T'
      Size = 15
    end
    object QBCSTBCM2P: TStringField
      FieldName = 'BCM2P'
      Size = 15
    end
    object QBCSTBCM2W: TStringField
      FieldName = 'BCM2W'
      Size = 15
    end
    object QBCSTBCM3T: TStringField
      FieldName = 'BCM3T'
      Size = 15
    end
    object QBCSTBCM3P: TStringField
      FieldName = 'BCM3P'
      Size = 15
    end
    object QBCSTBCM3W: TStringField
      FieldName = 'BCM3W'
      Size = 15
    end
    object QBCSTBCTL1: TStringField
      FieldName = 'BCTL1'
      Size = 15
    end
    object QBCSTBCTL2: TStringField
      FieldName = 'BCTL2'
      Size = 15
    end
    object QBCSTBCFX1: TStringField
      FieldName = 'BCFX1'
      Size = 15
    end
    object QBCSTBCFX2: TStringField
      FieldName = 'BCFX2'
      Size = 15
    end
    object QBCSTBCAD1: TStringField
      FieldName = 'BCAD1'
      Size = 50
    end
    object QBCSTBCAD2: TStringField
      FieldName = 'BCAD2'
      Size = 50
    end
    object QBCSTBCZP1: TStringField
      FieldName = 'BCZP1'
      Size = 5
    end
    object QBCSTBCZP2: TStringField
      FieldName = 'BCZP2'
      Size = 5
    end
    object QBCSTBCTL9: TStringField
      FieldName = 'BCTL9'
      Size = 15
    end
    object QBCSTBCAD9: TStringField
      FieldName = 'BCAD9'
      Size = 50
    end
    object QBCSTBCZP9: TStringField
      FieldName = 'BCZP9'
      Size = 5
    end
    object QBCSTBCDIS: TFloatField
      FieldName = 'BCDIS'
    end
    object QBCSTBCTP1: TFloatField
      FieldName = 'BCTP1'
    end
    object QBCSTBCTP2: TFloatField
      FieldName = 'BCTP2'
    end
    object QBCSTBCTP5: TFloatField
      FieldName = 'BCTP5'
    end
    object QBCSTBCTP6: TFloatField
      FieldName = 'BCTP6'
    end
    object QBCSTBCTPN: TStringField
      FieldName = 'BCTPN'
      Size = 30
    end
    object QBCSTBCTTP: TStringField
      FieldName = 'BCTTP'
      Size = 3
    end
    object QBCSTBCTTD: TFloatField
      FieldName = 'BCTTD'
    end
    object QBCSTBCTEG: TStringField
      FieldName = 'BCTEG'
      Size = 5
    end
    object QBCSTBCTBK: TStringField
      FieldName = 'BCTBK'
      Size = 3
    end
    object QBCSTBCALT: TFloatField
      FieldName = 'BCALT'
    end
    object QBCSTBCTDT: TDateTimeField
      FieldName = 'BCTDT'
    end
    object QBCSTBCDAT: TDateTimeField
      FieldName = 'BCDAT'
    end
    object QBCSTBCID1: TStringField
      FieldName = 'BCID1'
      Size = 10
    end
    object QBCSTBCMRK: TStringField
      FieldName = 'BCMRK'
      Size = 80
    end
    object QBCSTBNENO: TStringField
      FieldName = 'BNENO'
      Size = 10
    end
  end
  object UpdateSQL1: TUpdateSQL
    Left = 175
    Top = 50
  end
  object Query1: TQuery
    CachedUpdates = True
    DatabaseName = 'MAIN'
    SQL.Strings = (
      'SELECT *'
      'FROM BMEM'
      'ORDER BY BMENO')
    Left = 15
    Top = 10
    object StringField1: TStringField
      FieldName = 'BMENO'
      Size = 10
    end
    object StringField2: TStringField
      FieldName = 'BMNAM'
      Size = 10
    end
    object StringField3: TStringField
      FieldName = 'BMCNA'
      Size = 10
    end
    object DateTimeField1: TDateTimeField
      FieldName = 'BMBTH'
    end
    object StringField4: TStringField
      FieldName = 'BMSEX'
      Size = 1
    end
    object DateTimeField2: TDateTimeField
      FieldName = 'BMBDT'
    end
    object DateTimeField3: TDateTimeField
      FieldName = 'BMBYD'
    end
    object StringField5: TStringField
      FieldName = 'BMPGR'
      Size = 15
    end
    object StringField6: TStringField
      FieldName = 'BMWPN'
      Size = 15
    end
    object DateTimeField4: TDateTimeField
      FieldName = 'BMJND'
    end
    object DateTimeField5: TDateTimeField
      FieldName = 'BMCRD'
    end
    object DateTimeField6: TDateTimeField
      FieldName = 'BMDAT'
    end
    object FloatField1: TFloatField
      FieldName = 'BMLVE'
    end
    object FloatField2: TFloatField
      FieldName = 'BMBYR'
    end
    object FloatField3: TFloatField
      FieldName = 'BMBTO'
    end
    object FloatField4: TFloatField
      FieldName = 'BMBPO'
    end
    object FloatField5: TFloatField
      FieldName = 'BMBTM'
    end
  end
end