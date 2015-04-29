object FMPOSND: TFMPOSND
  OldCreateOrder = True
  Left = 285
  Top = 161
  Height = 479
  Width = 741
  object DSPOSN: TDataSource
    DataSet = QPOSN
    Left = 75
    Top = 10
  end
  object QPOSN: TQuery
    CachedUpdates = True
    OnCalcFields = QPOSNCalcFields
    DatabaseName = 'MAIN'
    SQL.Strings = (
      'SELECT *'
      'FROM POSN,BGDS'
      'WHERE POSN.BGEN1 = BGDS.BGENO'
      'ORDER BY BGEN1')
    UpdateObject = UPOSN
    Left = 15
    Top = 10
    object QPOSNBGEN1: TStringField
      FieldName = 'BGEN1'
      Origin = 'POSN.BGEN1'
    end
    object QPOSNBGEN2: TStringField
      FieldName = 'BGEN2'
      Origin = 'POSN.BGEN2'
    end
    object QPOSNPNPR1: TFloatField
      FieldName = 'PNPR1'
      Origin = 'POSN.PNPR1'
    end
    object QPOSNPNPR2: TFloatField
      FieldName = 'PNPR2'
      Origin = 'POSN.PNPR2'
    end
    object QPOSNPNDT1: TDateTimeField
      FieldName = 'PNDT1'
      Origin = 'POSN.PNDT1'
    end
    object QPOSNPNDT2: TDateTimeField
      FieldName = 'PNDT2'
      Origin = 'POSN.PNDT2'
    end
    object QPOSNPNDAT: TDateTimeField
      FieldName = 'PNDAT'
      Origin = 'POSN.PNDAT'
    end
    object QPOSN_BGNAM1: TStringField
      FieldKind = fkCalculated
      FieldName = '_BGNAM1'
      LookupKeyFields = 'BGENO'
      LookupResultField = 'BGNAM'
      KeyFields = 'BGEN1'
      Calculated = True
    end
    object QPOSN_BGNAM2: TStringField
      FieldKind = fkCalculated
      FieldName = '_BGNAM2'
      LookupKeyFields = 'BGENO'
      LookupResultField = 'BGNAM'
      KeyFields = 'BGEN2'
      Calculated = True
    end
    object QPOSNBGENO: TStringField
      FieldName = 'BGENO'
      Origin = 'POSN.BGEN1'
    end
    object QPOSNBGNAM: TStringField
      FieldName = 'BGNAM'
      Origin = 'MAIN.POSN.BGEN1'
      Size = 40
    end
    object QPOSNBGKIN: TStringField
      FieldName = 'BGKIN'
      Origin = 'MAIN.POSN.BGEN1'
      Size = 3
    end
    object QPOSNBGPST: TFloatField
      FieldName = 'BGPST'
      Origin = 'MAIN.POSN.BGEN1'
    end
    object QPOSNBGPVP: TFloatField
      FieldName = 'BGPVP'
      Origin = 'MAIN.POSN.BGEN1'
    end
    object QPOSNBGPMM: TFloatField
      FieldName = 'BGPMM'
      Origin = 'MAIN.POSN.BGEN1'
    end
    object QPOSNBGCST: TFloatField
      FieldName = 'BGCST'
      Origin = 'MAIN.POSN.BGEN1'
    end
    object QPOSNBGOTH: TFloatField
      FieldName = 'BGOTH'
      Origin = 'MAIN.POSN.BGEN1'
    end
  end
  object UPOSN: TUpdateSQL
    Left = 155
    Top = 10
  end
end