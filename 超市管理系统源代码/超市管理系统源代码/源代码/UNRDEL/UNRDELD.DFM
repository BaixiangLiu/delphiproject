object FMRDELD: TFMRDELD
  OldCreateOrder = True
  Left = 450
  Top = 155
  Height = 354
  Width = 252
  object DSRDEL: TDataSource
    DataSet = QRDEL
    Left = 75
    Top = 10
  end
  object QRDEL: TQuery
    CachedUpdates = True
    DatabaseName = 'MAIN'
    SQL.Strings = (
      'SELECT *'
      'FROM RDEL'
      '')
    UpdateObject = URDEL
    Left = 15
    Top = 10
    object QRDELRDENO: TStringField
      FieldName = 'RDENO'
      Origin = 'RDEL.RDENO'
      Size = 10
    end
    object QRDELBGENO: TStringField
      FieldName = 'BGENO'
      Origin = 'RDEL.BGENO'
    end
    object QRDELRDCNT: TFloatField
      FieldName = 'RDCNT'
      Origin = 'RDEL.RDCNT'
    end
    object QRDELRBPST: TStringField
      FieldName = 'RBPST'
      Origin = 'RDEL.RBPST'
      Size = 3
    end
    object QRDELRDREA: TStringField
      FieldName = 'RDREA'
      Origin = 'RDEL.RDREA'
      Size = 3
    end
    object QRDELRDDAT: TDateTimeField
      FieldName = 'RDDAT'
      Origin = 'RDEL.RDDAT'
    end
    object QRDELRDTME: TStringField
      FieldName = 'RDTME'
      Origin = 'RDEL.RDTME'
      Size = 5
    end
    object QRDELBNENO: TStringField
      FieldName = 'BNENO'
      Origin = 'RDEL.BNENO'
      Size = 10
    end
    object QRDELRDMRK: TStringField
      FieldName = 'RDMRK'
      Origin = 'RDEL.RDMRK'
      Size = 40
    end
    object QRDELRDOUT: TBooleanField
      FieldName = 'RDOUT'
      Origin = 'RDEL.RDOUT'
    end
  end
  object URDEL: TUpdateSQL
    Left = 155
    Top = 10
  end
end