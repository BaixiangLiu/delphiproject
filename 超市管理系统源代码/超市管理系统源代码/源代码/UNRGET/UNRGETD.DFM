object FMRGETD: TFMRGETD
  OldCreateOrder = True
  Left = 450
  Top = 155
  Height = 354
  Width = 252
  object DSRGET: TDataSource
    DataSet = QRGET
    Left = 75
    Top = 10
  end
  object QRGET: TQuery
    CachedUpdates = True
    DatabaseName = 'MAIN'
    SQL.Strings = (
      'SELECT *'
      'FROM RGET'
      '')
    UpdateObject = URGET
    Left = 15
    Top = 10
    object QRGETRGENO: TStringField
      FieldName = 'RGENO'
      Origin = 'RGET.RGENO'
      Size = 10
    end
    object QRGETBGENO: TStringField
      FieldName = 'BGENO'
      Origin = 'RGET.BGENO'
    end
    object QRGETRBPST: TStringField
      FieldName = 'RBPST'
      Origin = 'RGET.RBPST'
      Size = 3
    end
    object QRGETRGREA: TStringField
      FieldName = 'RGREA'
      Origin = 'RGET.RGREA'
      Size = 3
    end
    object QRGETRGDAT: TDateTimeField
      FieldName = 'RGDAT'
      Origin = 'RGET.RGDAT'
    end
    object QRGETRGTME: TStringField
      FieldName = 'RGTME'
      Origin = 'RGET.RGTME'
      Size = 5
    end
    object QRGETBNENO: TStringField
      FieldName = 'BNENO'
      Origin = 'RGET.BNENO'
      Size = 10
    end
    object QRGETRGMRK: TStringField
      FieldName = 'RGMRK'
      Origin = 'RGET.RGMRK'
      Size = 40
    end
    object QRGETRGCNT: TFloatField
      FieldName = 'RGCNT'
      Origin = 'RGET.RGCNT'
    end
    object QRGETRGOUT: TBooleanField
      FieldName = 'RGOUT'
      Origin = 'RGET.RGOUT'
    end
  end
  object URGET: TUpdateSQL
    Left = 155
    Top = 10
  end
end