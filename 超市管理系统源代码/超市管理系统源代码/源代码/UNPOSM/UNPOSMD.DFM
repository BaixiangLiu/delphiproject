object FMPOSMD: TFMPOSMD
  OldCreateOrder = True
  Left = 285
  Top = 161
  Height = 479
  Width = 741
  object DSPOSM: TDataSource
    DataSet = QPOSM
    Left = 75
    Top = 10
  end
  object QPOSM: TQuery
    CachedUpdates = True
    AfterEdit = QPOSMAfterEdit
    OnCalcFields = QPOSMCalcFields
    DatabaseName = 'MAIN'
    SQL.Strings = (
      'SELECT *'
      'FROM POSM'
      'ORDER BY BGENO')
    UpdateObject = UPOSM
    Left = 15
    Top = 10
    object QPOSMBGENO: TStringField
      FieldName = 'BGENO'
      Origin = 'POSM.BGENO'
    end
    object QPOSMPMDT1: TDateTimeField
      FieldName = 'PMDT1'
      Origin = 'POSM.PMDT1'
    end
    object QPOSMPMDT2: TDateTimeField
      FieldName = 'PMDT2'
      Origin = 'POSM.PMDT2'
    end
    object QPOSMPMDAT: TDateTimeField
      FieldName = 'PMDAT'
      Origin = 'POSM.PMDAT'
    end
    object QPOSMPMPRI: TFloatField
      FieldName = 'PMPRI'
      Origin = 'POSM.PMPRI'
    end
    object QPOSM_BGNAM: TStringField
      FieldKind = fkCalculated
      FieldName = '_BGNAM'
      Calculated = True
    end
  end
  object UPOSM: TUpdateSQL
    Left = 155
    Top = 10
  end
end