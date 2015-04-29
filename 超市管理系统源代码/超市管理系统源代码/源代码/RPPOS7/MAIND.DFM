object FMMAIND: TFMMAIND
  OldCreateOrder = True
  Left = 513
  Top = 171
  Height = 216
  Width = 256
  object Database: TDatabase
    AliasName = 'MICROPOS'
    DatabaseName = 'MAIN'
    HandleShared = True
    LoginPrompt = False
    SessionName = 'Default'
    Left = 15
    Top = 20
  end
  object QUPD: TQuery
    DatabaseName = 'MAIN'
    Left = 70
    Top = 125
  end
  object QDEL: TQuery
    DatabaseName = 'MAIN'
    Left = 125
    Top = 125
  end
  object QINS: TQuery
    DatabaseName = 'MAIN'
    Left = 15
    Top = 125
  end
  object QUERY: TQuery
    DatabaseName = 'MAIN'
    Left = 180
    Top = 125
  end
end
