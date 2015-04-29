object FMRCJND: TFMRCJND
  OldCreateOrder = True
  Left = 285
  Top = 161
  Height = 479
  Width = 741
  object DSRCJN: TDataSource
    DataSet = QRCJN
    OnDataChange = DSRCJNDataChange
    Left = 75
    Top = 10
  end
  object QRCJN: TQuery
    CachedUpdates = True
    AfterInsert = QRCJNAfterInsert
    AfterEdit = QRCJNAfterEdit
    AfterPost = QRCJNAfterPost
    OnCalcFields = QRCJNCalcFields
    DatabaseName = 'MAIN'
    SQL.Strings = (
      'SELECT *'
      'FROM RCJN'
      '')
    UpdateObject = URCJN
    Left = 15
    Top = 10
    object QRCJNRJENO: TStringField
      FieldName = 'RJENO'
      Origin = 'MAIN.RCJN.RJENO'
      Size = 10
    end
    object QRCJNRJTYP: TStringField
      FieldName = 'RJTYP'
      Origin = 'MAIN.RCJN.RJTYP'
      Size = 1
    end
    object QRCJNRJDAT: TDateTimeField
      FieldName = 'RJDAT'
      Origin = 'MAIN.RCJN.RJDAT'
    end
    object QRCJNBNENO: TStringField
      FieldName = 'BNENO'
      Origin = 'MAIN.RCJN.BNENO'
      Size = 10
    end
    object QRCJNBSENO: TStringField
      FieldName = 'BSENO'
      Origin = 'MAIN.RCJN.BSENO'
      Size = 10
    end
    object QRCJNRJAM1: TFloatField
      FieldName = 'RJAM1'
      Origin = 'MAIN.RCJN.RJAM1'
    end
    object QRCJNRJAMT: TFloatField
      FieldName = 'RJAMT'
      Origin = 'MAIN.RCJN.RJAMT'
    end
    object QRCJNRJMRK: TMemoField
      FieldName = 'RJMRK'
      Origin = 'MAIN.RCJN.RJMRK'
      BlobType = ftMemo
      Size = 1
    end
    object QRCJNRJSTA: TBooleanField
      FieldName = 'RJSTA'
      Origin = 'MAIN.RCJN.RJSTA'
    end
  end
  object URCJN: TUpdateSQL
    Left = 155
    Top = 10
  end
  object QRCJNB: TQuery
    CachedUpdates = True
    AfterInsert = QRCJNBAfterInsert
    AfterEdit = QRCJNAfterEdit
    AfterPost = QRCJNBAfterPost
    OnCalcFields = QRCJNBCalcFields
    DatabaseName = 'MAIN'
    SQL.Strings = (
      'SELECT *'
      'FROM RCJNB'
      '')
    UpdateObject = URCJNB
    Left = 15
    Top = 65
    object QRCJNB_BGNAM: TStringField
      FieldKind = fkCalculated
      FieldName = '_BGNAM'
      Calculated = True
    end
    object QRCJNB_BGID1: TStringField
      FieldKind = fkCalculated
      FieldName = '_BGID1'
      Calculated = True
    end
    object QRCJNBRJENO: TStringField
      FieldName = 'RJENO'
      Origin = 'MAIN.RCJNB.RJENO'
      Size = 10
    end
    object QRCJNBRJITM: TStringField
      FieldName = 'RJITM'
      Origin = 'MAIN.RCJNB.RJITM'
      Size = 5
    end
    object QRCJNBBGENO: TStringField
      FieldName = 'BGENO'
      Origin = 'MAIN.RCJNB.BGENO'
    end
    object QRCJNBRJGCN: TFloatField
      FieldName = 'RJGCN'
      Origin = 'MAIN.RCJNB.RJGCN'
    end
    object QRCJNBRJGCS: TFloatField
      FieldName = 'RJGCS'
      Origin = 'MAIN.RCJNB.RJGCS'
    end
    object QRCJNBRJGCT: TFloatField
      FieldName = 'RJGCT'
      Origin = 'MAIN.RCJNB.RJGCT'
    end
  end
  object DSRCJNB: TDataSource
    DataSet = QRCJNB
    Left = 75
    Top = 65
  end
  object URCJNB: TUpdateSQL
    Left = 155
    Top = 65
  end
  object QBSUPPPP: TQuery
    CachedUpdates = True
    DatabaseName = 'MAIN'
    SQL.Strings = (
      'SELECT *'
      'FROM BSUP')
    Left = 295
    Top = 5
  end
end