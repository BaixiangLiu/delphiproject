object frm_datamodule: Tfrm_datamodule
  OldCreateOrder = False
  Left = 106
  Top = 202
  Height = 193
  Width = 215
  object DataSource1: TDataSource
    DataSet = ADOTable1
    Left = 64
    Top = 8
  end
  object ADOTable1: TADOTable
    Connection = ADOConnection1
    CursorType = ctStatic
    TableName = 'capital'
    Left = 16
    Top = 8
  end
  object ADOConnection1: TADOConnection
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 120
    Top = 8
  end
  object DataSource3: TDataSource
    DataSet = ADODataSet1
    Left = 72
    Top = 96
  end
  object ADODataSet1: TADODataSet
    Connection = ADOConnection1
    Parameters = <>
    Left = 24
    Top = 96
  end
end
