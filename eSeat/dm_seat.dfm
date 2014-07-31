object dmseat: Tdmseat
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 177
  Top = 221
  Height = 250
  Width = 847
  object seatconn: TADOConnection
    ConnectionString = 
      'Provider=SQLOLEDB.1;Persist Security Info=False;User ID=sa;Initi' +
      'al Catalog=eseat;Data Source=JANETHOME'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 16
    Top = 8
  end
  object aq_meetingroom: TADOQuery
    Connection = seatconn
    LockType = ltBatchOptimistic
    Parameters = <>
    Left = 88
    Top = 8
  end
  object ds_meetingroom: TDataSource
    DataSet = aq_meetingroom
    Left = 88
    Top = 64
  end
  object aq_meeting: TADOQuery
    Connection = seatconn
    LockType = ltBatchOptimistic
    Parameters = <>
    Left = 160
    Top = 8
  end
  object ds_meeting: TDataSource
    DataSet = aq_meeting
    Left = 160
    Top = 64
  end
  object aq_meetingpeople: TADOQuery
    Connection = seatconn
    LockType = ltBatchOptimistic
    Parameters = <>
    Left = 224
    Top = 8
  end
  object ds_meetingpeople: TDataSource
    DataSet = aq_meetingpeople
    Left = 224
    Top = 64
  end
  object aq_param: TADOQuery
    Connection = seatconn
    LockType = ltBatchOptimistic
    Parameters = <>
    Left = 280
    Top = 8
  end
  object ds_param: TDataSource
    DataSet = aq_param
    Left = 280
    Top = 64
  end
  object aq_meeting_people: TADOQuery
    Connection = seatconn
    LockType = ltBatchOptimistic
    Parameters = <>
    Left = 336
    Top = 8
  end
  object ds_meeting_people: TDataSource
    DataSet = aq_meeting_people
    Left = 336
    Top = 72
  end
  object aq_room_table: TADOQuery
    Connection = seatconn
    LockType = ltBatchOptimistic
    Parameters = <>
    Left = 416
    Top = 16
  end
  object ds_room_table: TDataSource
    DataSet = aq_room_table
    Left = 408
    Top = 72
  end
  object aq_seat_people: TADOQuery
    Connection = seatconn
    LockType = ltBatchOptimistic
    Parameters = <>
    Left = 488
    Top = 16
  end
  object ds_seat_people: TDataSource
    DataSet = aq_seat_people
    Left = 472
    Top = 72
  end
  object aq_cancelpeople: TADOQuery
    Connection = seatconn
    LockType = ltBatchOptimistic
    Parameters = <>
    Left = 544
    Top = 16
  end
  object ds_cancelpeople: TDataSource
    DataSet = aq_cancelpeople
    Left = 544
    Top = 72
  end
  object aq_leaderpeople: TADOQuery
    Connection = seatconn
    LockType = ltBatchOptimistic
    Parameters = <>
    Left = 608
    Top = 16
  end
  object ds_leaderpeople: TDataSource
    DataSet = aq_leaderpeople
    Left = 608
    Top = 80
  end
  object aq_seat: TADOQuery
    Connection = seatconn
    Parameters = <>
    Left = 744
    Top = 16
  end
  object ds_seat: TDataSource
    DataSet = aq_seat
    Left = 744
    Top = 88
  end
end
