object FMRBOWD: TFMRBOWD
  OldCreateOrder = True
  Left = 450
  Top = 155
  Height = 354
  Width = 252
  object DSRBOW: TDataSource
    DataSet = QRBOW
    Left = 75
    Top = 10
  end
  object QRBOW: TQuery
    CachedUpdates = True
    DatabaseName = 'MAIN'
    SQL.Strings = (
      'SELECT *'
      'FROM RBOW'
      '')
    UpdateObject = URBOW
    Left = 15
    Top = 10
    object QRBOWRBENO: TStringField
      FieldName = 'RBENO'
      Origin = 'RBOW.RBENO'
      Size = 10
    end
    object QRBOWBGENO: TStringField
      FieldName = 'BGENO'
      Origin = 'RBOW.BGENO'
    end
    object QRBOWRBCN1: TFloatField
      FieldName = 'RBCN1'
      Origin = 'RBOW.RBCN1'
    end
    object QRBOWRBCN2: TFloatField
      FieldName = 'RBCN2'
      Origin = 'RBOW.RBCN2'
    end
    object QRBOWRBPST: TStringField
      FieldName = 'RBPST'
      Origin = 'RBOW.RBPST'
      Size = 3
    end
    object QRBOWRBBCK: TBooleanField
      FieldName = 'RBBCK'
      Origin = 'RBOW.RBBCK'
    end
    object QRBOWRBOUT: TBooleanField
      FieldName = 'RBOUT'
      Origin = 'RBOW.RBOUT'
    end
    object QRBOWRBREA: TStringField
      FieldName = 'RBREA'
      Origin = 'RBOW.RBREA'
      Size = 3
    end
    object QRBOWRBDT1: TDateTimeField
      FieldName = 'RBDT1'
      Origin = 'RBOW.RBDT1'
    end
    object QRBOWRBTM1: TStringField
      FieldName = 'RBTM1'
      Origin = 'RBOW.RBTM1'
      Size = 5
    end
    object QRBOWRBDT2: TDateTimeField
      FieldName = 'RBDT2'
      Origin = 'RBOW.RBDT2'
    end
    object QRBOWRBTM2: TStringField
      FieldName = 'RBTM2'
      Origin = 'RBOW.RBTM2'
      Size = 5
    end
    object QRBOWBNENO: TStringField
      FieldName = 'BNENO'
      Origin = 'RBOW.BNENO'
      Size = 10
    end
    object QRBOWRBMRK: TStringField
      FieldName = 'RBMRK'
      Origin = 'RBOW.RBMRK'
      Size = 40
    end
  end
  object URBOW: TUpdateSQL
    Left = 155
    Top = 10
  end
end