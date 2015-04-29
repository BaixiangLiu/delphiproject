object FMRCIND: TFMRCIND
  OldCreateOrder = True
  Left = 253
  Top = 117
  Height = 479
  Width = 741
  object DSRCIN: TDataSource
    DataSet = QRCIN
    OnDataChange = DSRCINDataChange
    Left = 115
    Top = 66
  end
  object QRCIN: TQuery
    CachedUpdates = True
    AfterInsert = QRCINAfterInsert
    AfterEdit = QRCINAfterEdit
    AfterPost = QRCINAfterPost
    OnCalcFields = QRCINCalcFields
    DatabaseName = 'MAIN'
    SQL.Strings = (
      'SELECT *'
      'FROM RCIN'
      '')
    UpdateObject = URCIN
    Left = 15
    Top = 10
    object QRCINRIENO: TStringField
      FieldName = 'RIENO'
      Origin = 'MAIN.RCIN.RIENO'
      Size = 10
    end
    object QRCINRITYP: TStringField
      FieldName = 'RITYP'
      Origin = 'MAIN.RCIN.RITYP'
      Size = 1
    end
    object QRCINRIDAT: TDateTimeField
      FieldName = 'RIDAT'
      Origin = 'MAIN.RCIN.RIDAT'
    end
    object QRCINBNENO: TStringField
      FieldName = 'BNENO'
      Origin = 'MAIN.RCIN.BNENO'
      Size = 10
    end
    object QRCINBSENO: TStringField
      FieldName = 'BSENO'
      Origin = 'MAIN.RCIN.BSENO'
      Size = 10
    end
    object QRCINRISNO: TStringField
      FieldName = 'RISNO'
      Origin = 'MAIN.RCIN.RISNO'
      Size = 10
    end
    object QRCINRIIID: TStringField
      FieldName = 'RIIID'
      Origin = 'MAIN.RCIN.RIIID'
      Size = 10
    end
    object QRCINRIINO: TStringField
      FieldName = 'RIINO'
      Origin = 'MAIN.RCIN.RIINO'
      Size = 10
    end
    object QRCINRIIAD: TStringField
      FieldName = 'RIIAD'
      Origin = 'MAIN.RCIN.RIIAD'
      Size = 50
    end
    object QRCINRIPAY: TStringField
      FieldName = 'RIPAY'
      Origin = 'MAIN.RCIN.RIPAY'
      Size = 3
    end
    object QRCINRIEXG: TStringField
      FieldName = 'RIEXG'
      Origin = 'MAIN.RCIN.RIEXG'
      Size = 5
    end
    object QRCINRIEXR: TFloatField
      FieldName = 'RIEXR'
      Origin = 'MAIN.RCIN.RIEXR'
    end
    object QRCINRIAM1: TFloatField
      FieldName = 'RIAM1'
      Origin = 'MAIN.RCIN.RIAM1'
    end
    object QRCINRIAM2: TFloatField
      FieldName = 'RIAM2'
      Origin = 'MAIN.RCIN.RIAM2'
    end
    object QRCINRIAMT: TFloatField
      FieldName = 'RIAMT'
      Origin = 'MAIN.RCIN.RIAMT'
    end
    object QRCINRISA1: TFloatField
      FieldName = 'RISA1'
      Origin = 'MAIN.RCIN.RISA1'
    end
    object QRCINRISA2: TFloatField
      FieldName = 'RISA2'
      Origin = 'MAIN.RCIN.RISA2'
    end
    object QRCINRISA3: TFloatField
      FieldName = 'RISA3'
      Origin = 'MAIN.RCIN.RISA3'
    end
    object QRCINRISA4: TFloatField
      FieldName = 'RISA4'
      Origin = 'MAIN.RCIN.RISA4'
    end
    object QRCINRISA5: TFloatField
      FieldName = 'RISA5'
      Origin = 'MAIN.RCIN.RISA5'
    end
    object QRCINRIMRK: TMemoField
      FieldName = 'RIMRK'
      Origin = 'MAIN.RCIN.RIMRK'
      BlobType = ftMemo
      Size = 1
    end
    object QRCINRISTA: TBooleanField
      FieldName = 'RISTA'
      Origin = 'MAIN.RCIN.RISTA'
    end
  end
  object URCIN: TUpdateSQL
    Left = 19
    Top = 122
  end
  object QRCINB: TQuery
    CachedUpdates = True
    AfterInsert = QRCINBAfterInsert
    AfterEdit = QRCINAfterEdit
    AfterPost = QRCINBAfterPost
    OnCalcFields = QRCINBCalcFields
    DatabaseName = 'MAIN'
    SQL.Strings = (
      'SELECT *'
      'FROM RCINB'
      '')
    UpdateObject = URCINB
    Left = 47
    Top = 17
    object QRCINB_BGNAM: TStringField
      FieldKind = fkCalculated
      FieldName = '_BGNAM'
      Calculated = True
    end
    object QRCINB_BGID1: TStringField
      FieldKind = fkCalculated
      FieldName = '_BGID1'
      Calculated = True
    end
    object QRCINBRIENO: TStringField
      FieldName = 'RIENO'
      Origin = 'RCINB.RIENO'
      Size = 10
    end
    object QRCINBRIITM: TStringField
      FieldName = 'RIITM'
      Origin = 'RCINB.RIITM'
      Size = 5
    end
    object QRCINBBGENO: TStringField
      FieldName = 'BGENO'
      Origin = 'RCINB.BGENO'
    end
    object QRCINBRIUNP: TStringField
      FieldName = 'RIUNP'
      Origin = 'RCINB.RIUNP'
      Size = 3
    end
    object QRCINBRIGCN: TFloatField
      FieldName = 'RIGCN'
      Origin = 'RCINB.RIGCN'
    end
    object QRCINBRIGCS: TFloatField
      FieldName = 'RIGCS'
      Origin = 'RCINB.RIGCS'
    end
    object QRCINBRIGCT: TFloatField
      FieldName = 'RIGCT'
      Origin = 'RCINB.RIGCT'
    end
  end
  object DSRCINB: TDataSource
    DataSet = QRCINB
    Left = 75
    Top = 57
  end
  object URCINB: TUpdateSQL
    Left = 155
    Top = 113
  end
  object QRCONBSTORY: TQuery
    CachedUpdates = True
    DatabaseName = 'MAIN'
    SQL.Strings = (
      'SELECT * FROM RCONB, RCON, BCST'
      'WHERE RCON.ROENO = RCONB.ROENO'
      '  AND RCON.BCENO=BCST.BCENO')
    Left = 251
    Top = 23
    object QRCONBSTORYBGENO: TStringField
      FieldName = 'BGENO'
    end
    object QRCONBSTORYROGCN: TFloatField
      FieldName = 'ROGCN'
    end
    object QRCONBSTORYROGCS: TFloatField
      FieldName = 'ROGCS'
    end
    object QRCONBSTORYROGCT: TFloatField
      FieldName = 'ROGCT'
    end
    object QRCONBSTORYRBPST: TStringField
      FieldName = 'RBPST'
      Size = 3
    end
    object QRCONBSTORYBCNAM: TStringField
      FieldName = 'BCNAM'
      Origin = 'RCONB.ROENO'
      Size = 40
    end
    object QRCONBSTORYRODAT: TDateTimeField
      FieldName = 'RODAT'
      Origin = 'RCONB.ROENO'
    end
  end
  object DSRCONBSTORY: TDataSource
    DataSet = QRCONBSTORY
    Left = 245
    Top = 71
  end
  object DSRPCHA: TDataSource
    DataSet = QRPCHA
    OnDataChange = DSRPCHADataChange
    Left = 165
    Top = 63
  end
  object QRPCHA: TQuery
    CachedUpdates = True
    OnCalcFields = QRPCHACalcFields
    DatabaseName = 'MAIN'
    SQL.Strings = (
      'SELECT *'
      'FROM RPCHA'
      'WHERE RHTRN = 0 '
      'ORDER BY RHPTD')
    UpdateObject = URPCHA
    Left = 169
    Top = 7
    object QRPCHARHENO: TStringField
      FieldName = 'RHENO'
      Origin = 'RPCHA.RHENO'
      Size = 10
    end
    object QRPCHABSENO: TStringField
      FieldName = 'BSENO'
      Origin = 'RPCHA.BSENO'
      Size = 10
    end
    object QRPCHARHPTD: TDateTimeField
      FieldName = 'RHPTD'
      Origin = 'RPCHA.RHPTD'
    end
    object QRPCHARHPTT: TStringField
      FieldName = 'RHPTT'
      Origin = 'RPCHA.RHPTT'
      Size = 5
    end
    object QRPCHARHPDT: TDateTimeField
      FieldName = 'RHPDT'
      Origin = 'RPCHA.RHPDT'
    end
    object QRPCHABNENO: TStringField
      FieldName = 'BNENO'
      Origin = 'RPCHA.BNENO'
      Size = 10
    end
    object QRPCHARHSAT: TStringField
      FieldName = 'RHSAT'
      Origin = 'RPCHA.RHSAT'
      Size = 3
    end
    object QRPCHARHTRN: TBooleanField
      FieldName = 'RHTRN'
      Origin = 'RPCHA.RHTRN'
    end
    object QRPCHARHMRK: TStringField
      FieldName = 'RHMRK'
      Origin = 'RPCHA.RHMRK'
      Size = 40
    end
    object QRPCHARHMEM: TMemoField
      FieldName = 'RHMEM'
      Origin = 'RPCHA.RHMEM'
      BlobType = ftMemo
      Size = 1
    end
    object QRPCHA_BNNAM: TStringField
      FieldKind = fkCalculated
      FieldName = '_BNNAM'
      Calculated = True
    end
    object QRPCHA_BSNAM: TStringField
      FieldKind = fkCalculated
      FieldName = '_BSNAM'
      Calculated = True
    end
    object QRPCHARH_OVERDAT: TBooleanField
      FieldKind = fkCalculated
      FieldName = 'RH_OVERDAT'
      Calculated = True
    end
    object QRPCHARH_OVERINT: TStringField
      FieldKind = fkCalculated
      FieldName = 'RH_OVERINT'
      Calculated = True
    end
  end
  object URPCHA: TUpdateSQL
    Left = 86
    Top = 127
  end
  object QRPCHB: TQuery
    CachedUpdates = True
    DatabaseName = 'MAIN'
    SQL.Strings = (
      'SELECT *'
      'FROM RPCHB,BGDS'
      'WHERE RPCHB.BGENO = BGDS.BGENO'
      'ORDER BY RPCHB.RHENO, RPCHB.BGENO ')
    UpdateObject = URPCHB
    Left = 97
    Top = 6
    object QRPCHBRHENO: TStringField
      FieldName = 'RHENO'
      Origin = 'RPCHB.RHENO'
      Size = 10
    end
    object QRPCHBBGENO: TStringField
      FieldName = 'BGENO'
      Origin = 'RPCHB.BGENO'
    end
    object QRPCHBRHCSI: TFloatField
      FieldName = 'RHCSI'
      Origin = 'RPCHB.RHCSI'
    end
    object QRPCHBRHCST: TFloatField
      FieldName = 'RHCST'
      Origin = 'RPCHB.RHCST'
    end
    object QRPCHBRHPCA: TFloatField
      FieldName = 'RHPCA'
      Origin = 'RPCHB.RHPCA'
    end
    object QRPCHBRHTRN: TBooleanField
      FieldName = 'RHTRN'
      Origin = 'RPCHB.RHTRN'
    end
    object QRPCHBBGENO_1: TStringField
      FieldName = 'BGENO_1'
      Origin = 'RPCHB.RHTRN'
    end
    object QRPCHBBGID1: TStringField
      FieldName = 'BGID1'
      Origin = 'RPCHB.RHTRN'
    end
    object QRPCHBBGNAM: TStringField
      FieldName = 'BGNAM'
      Origin = 'RPCHB.RHTRN'
      Size = 50
    end
    object QRPCHBBGKIN: TStringField
      FieldName = 'BGKIN'
      Origin = 'RPCHB.RHTRN'
      Size = 10
    end
    object QRPCHBBGPST: TFloatField
      FieldName = 'BGPST'
      Origin = 'RPCHB.RHTRN'
    end
    object QRPCHBBGPVP: TFloatField
      FieldName = 'BGPVP'
      Origin = 'RPCHB.RHTRN'
    end
    object QRPCHBBGPMM: TFloatField
      FieldName = 'BGPMM'
      Origin = 'RPCHB.RHTRN'
    end
    object QRPCHBBGPR1: TFloatField
      FieldName = 'BGPR1'
      Origin = 'RPCHB.RHTRN'
    end
    object QRPCHBBGPR2: TFloatField
      FieldName = 'BGPR2'
      Origin = 'RPCHB.RHTRN'
    end
    object QRPCHBBGPR3: TFloatField
      FieldName = 'BGPR3'
      Origin = 'RPCHB.RHTRN'
    end
    object QRPCHBBGQTS: TFloatField
      FieldName = 'BGQTS'
      Origin = 'RPCHB.RHTRN'
    end
    object QRPCHBBGCOS: TFloatField
      FieldName = 'BGCOS'
      Origin = 'RPCHB.RHTRN'
    end
    object QRPCHBBSENO: TStringField
      FieldName = 'BSENO'
      Origin = 'RPCHB.RHTRN'
      Size = 10
    end
  end
  object DSRPCHB: TDataSource
    DataSet = QRPCHB
    Left = 21
    Top = 70
  end
  object URPCHB: TUpdateSQL
    Left = 222
    Top = 126
  end
  object QBSUP: TQuery
    CachedUpdates = True
    DatabaseName = 'MAIN'
    SQL.Strings = (
      'SELECT *'
      'FROM BSUP')
    Left = 207
    Top = 13
  end
end
