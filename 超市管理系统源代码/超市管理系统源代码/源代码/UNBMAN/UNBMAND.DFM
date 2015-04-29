object FMBMAND: TFMBMAND
  OldCreateOrder = True
  Left = 285
  Top = 161
  Height = 479
  Width = 741
  object DSBMAN: TDataSource
    DataSet = QBMAN
    OnDataChange = DSBMANDataChange
    Left = 75
    Top = 10
  end
  object QBMAN: TQuery
    CachedUpdates = True
    AfterEdit = QBMANAfterEdit
    DatabaseName = 'MAIN'
    SQL.Strings = (
      'SELECT *'
      'FROM BMAN'
      'ORDER BY BNENO')
    UpdateObject = UBMAN
    Left = 15
    Top = 10
    object QBMANBNENO: TStringField
      FieldName = 'BNENO'
      Origin = 'BMAN.BNENO'
      Size = 10
    end
    object QBMANBNNAM: TStringField
      FieldName = 'BNNAM'
      Origin = 'BMAN.BNNAM'
    end
    object QBMANBNCNA: TStringField
      FieldName = 'BNCNA'
      Origin = 'BMAN.BNCNA'
    end
    object QBMANBNBTH: TDateTimeField
      FieldName = 'BNBTH'
      Origin = 'BMAN.BNBTH'
    end
    object QBMANBNROT: TStringField
      FieldName = 'BNROT'
      Origin = 'BMAN.BNROT'
    end
    object QBMANBNIDN: TStringField
      FieldName = 'BNIDN'
      Origin = 'BMAN.BNIDN'
      Size = 10
    end
    object QBMANBNPAS: TStringField
      FieldName = 'BNPAS'
      Origin = 'BMAN.BNPAS'
      Size = 10
    end
    object QBMANBNLIV: TStringField
      FieldName = 'BNLIV'
      Origin = 'BMAN.BNLIV'
      Size = 10
    end
    object QBMANBNSEX: TStringField
      FieldName = 'BNSEX'
      Origin = 'BMAN.BNSEX'
      Size = 1
    end
    object QBMANBNBLD: TStringField
      DisplayWidth = 3
      FieldName = 'BNBLD'
      Origin = 'BMAN.BNBLD'
      Size = 3
    end
    object QBMANBNSCS: TStringField
      FieldName = 'BNSCS'
      Origin = 'BMAN.BNSCS'
      Size = 3
    end
    object QBMANBNSDP: TStringField
      FieldName = 'BNSDP'
      Origin = 'BMAN.BNSDP'
      Size = 3
    end
    object QBMANBNCPL: TStringField
      FieldName = 'BNCPL'
      Origin = 'BMAN.BNCPL'
      Size = 3
    end
    object QBMANBNSPP: TFloatField
      FieldName = 'BNSPP'
      Origin = 'BMAN.BNSPP'
    end
    object QBMANBNSCH: TStringField
      FieldName = 'BNSCH'
      Origin = 'BMAN.BNSCH'
      Size = 30
    end
    object QBMANBNHIS: TStringField
      FieldName = 'BNHIS'
      Origin = 'BMAN.BNHIS'
      Size = 50
    end
    object QBMANBNCMN: TStringField
      FieldName = 'BNCMN'
      Origin = 'BMAN.BNCMN'
    end
    object QBMANBNREL: TStringField
      FieldName = 'BNREL'
      Origin = 'BMAN.BNREL'
      Size = 3
    end
    object QBMANBNTL1: TStringField
      FieldName = 'BNTL1'
      Origin = 'BMAN.BNTL1'
      Size = 15
    end
    object QBMANBNTL2: TStringField
      FieldName = 'BNTL2'
      Origin = 'BMAN.BNTL2'
      Size = 15
    end
    object QBMANBNTL3: TStringField
      FieldName = 'BNTL3'
      Origin = 'BMAN.BNTL3'
      Size = 15
    end
    object QBMANBNAD1: TStringField
      FieldName = 'BNAD1'
      Origin = 'BMAN.BNAD1'
      Size = 50
    end
    object QBMANBNAD2: TStringField
      FieldName = 'BNAD2'
      Origin = 'BMAN.BNAD2'
      Size = 50
    end
    object QBMANBNVIC: TStringField
      FieldName = 'BNVIC'
      Origin = 'BMAN.BNVIC'
      Size = 3
    end
    object QBMANBNVIN: TStringField
      FieldName = 'BNVIN'
      Origin = 'BMAN.BNVIN'
      Size = 10
    end
    object QBMANBNSEC: TStringField
      FieldName = 'BNSEC'
      Origin = 'BMAN.BNSEC'
      Size = 3
    end
    object QBMANBNCLS: TStringField
      FieldName = 'BNCLS'
      Origin = 'BMAN.BNCLS'
      Size = 3
    end
    object QBMANBNDPO: TStringField
      FieldName = 'BNDPO'
      Origin = 'BMAN.BNDPO'
      Size = 10
    end
    object QBMANBNDPT: TStringField
      FieldName = 'BNDPT'
      Origin = 'BMAN.BNDPT'
      Size = 10
    end
    object QBMANBNLLC: TStringField
      FieldName = 'BNLLC'
      Origin = 'BMAN.BNLLC'
      Size = 3
    end
    object QBMANBNSVR: TStringField
      FieldName = 'BNSVR'
      Origin = 'BMAN.BNSVR'
      Size = 10
    end
    object QBMANBNNUM: TStringField
      FieldName = 'BNNUM'
      Origin = 'BMAN.BNNUM'
      Size = 10
    end
    object QBMANBNLCC: TStringField
      FieldName = 'BNLCC'
      Origin = 'BMAN.BNLCC'
      Size = 3
    end
    object QBMANBNEPC: TStringField
      FieldName = 'BNEPC'
      Origin = 'BMAN.BNEPC'
      Size = 3
    end
    object QBMANBNTIT: TStringField
      FieldName = 'BNTIT'
      Origin = 'BMAN.BNTIT'
      Size = 3
    end
    object QBMANBNGRC: TStringField
      FieldName = 'BNGRC'
      Origin = 'BMAN.BNGRC'
      Size = 3
    end
    object QBMANBNBNS: TStringField
      FieldName = 'BNBNS'
      Origin = 'BMAN.BNBNS'
      Size = 3
    end
    object QBMANBNBNO: TStringField
      FieldName = 'BNBNO'
      Origin = 'BMAN.BNBNO'
      Size = 25
    end
    object QBMANBNC02: TDateTimeField
      FieldName = 'BNC02'
      Origin = 'BMAN.BNC02'
    end
    object QBMANBNC03: TStringField
      FieldName = 'BNC03'
      Origin = 'BMAN.BNC03'
      Size = 8
    end
    object QBMANBNFDY: TDateTimeField
      FieldName = 'BNFDY'
      Origin = 'BMAN.BNFDY'
    end
    object QBMANBNEDY: TDateTimeField
      FieldName = 'BNEDY'
      Origin = 'BMAN.BNEDY'
    end
    object QBMANBNHPS: TDateTimeField
      FieldName = 'BNHPS'
      Origin = 'BMAN.BNHPS'
    end
    object QBMANBNHPF: TDateTimeField
      FieldName = 'BNHPF'
      Origin = 'BMAN.BNHPF'
    end
    object QBMANBNCHM: TStringField
      FieldName = 'BNCHM'
      Origin = 'BMAN.BNCHM'
      Size = 3
    end
    object QBMANBNHPV: TFloatField
      FieldName = 'BNHPV'
      Origin = 'BMAN.BNHPV'
    end
    object QBMANBNSPL: TFloatField
      FieldName = 'BNSPL'
      Origin = 'BMAN.BNSPL'
    end
    object QBMANBNSPN: TFloatField
      FieldName = 'BNSPN'
      Origin = 'BMAN.BNSPN'
    end
    object QBMANBNLV1: TFloatField
      FieldName = 'BNLV1'
      Origin = 'BMAN.BNLV1'
    end
    object QBMANBNLV2: TFloatField
      FieldName = 'BNLV2'
      Origin = 'BMAN.BNLV2'
    end
    object QBMANBNTB1: TDateTimeField
      FieldName = 'BNTB1'
      Origin = 'BMAN.BNTB1'
    end
    object QBMANBNTB2: TDateTimeField
      FieldName = 'BNTB2'
      Origin = 'BMAN.BNTB2'
    end
    object QBMANBNIF1: TDateTimeField
      FieldName = 'BNIF1'
      Origin = 'BMAN.BNIF1'
    end
    object QBMANBNIF2: TDateTimeField
      FieldName = 'BNIF2'
      Origin = 'BMAN.BNIF2'
    end
    object QBMANBNHI1: TDateTimeField
      FieldName = 'BNHI1'
      Origin = 'BMAN.BNHI1'
    end
    object QBMANBNHI2: TDateTimeField
      FieldName = 'BNHI2'
      Origin = 'BMAN.BNHI2'
    end
    object QBMANBNHIX: TStringField
      FieldName = 'BNHIX'
      Origin = 'BMAN.BNHIX'
      Size = 3
    end
    object QBMANBNTBX: TStringField
      FieldName = 'BNTBX'
      Origin = 'BMAN.BNTBX'
      Size = 3
    end
    object QBMANBNISM: TFloatField
      FieldName = 'BNISM'
      Origin = 'BMAN.BNISM'
    end
    object QBMANBNHIM: TFloatField
      FieldName = 'BNHIM'
      Origin = 'BMAN.BNHIM'
    end
    object QBMANBNHIN: TFloatField
      FieldName = 'BNHIN'
      Origin = 'BMAN.BNHIN'
    end
    object QBMANBNHBS: TBooleanField
      FieldName = 'BNHBS'
      Origin = 'BMAN.BNHBS'
    end
    object QBMANBNCTY: TStringField
      FieldName = 'BNCTY'
      Size = 3
    end
    object QBMANBNZP1: TStringField
      FieldName = 'BNZP1'
      Size = 5
    end
    object QBMANBNZP2: TStringField
      FieldName = 'BNZP2'
      Size = 5
    end
    object QBMANBNPWD: TStringField
      FieldName = 'BNPWD'
      Origin = 'MAIN.BMAN.BNPWD'
      Size = 10
    end
  end
  object UBMAN: TUpdateSQL
    Left = 135
    Top = 10
  end
end