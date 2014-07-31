inherited frm_sel_renyuan: Tfrm_sel_renyuan
  Caption = #36873#25321#20154#21592
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 12
  inherited p1: TPanel
    inherited ptop: TPanel
      inherited p4: TPanel
        inherited list: TdxDBGrid
          KeyField = 'id'
          DataSource = dsquery
          Filter.Criteria = {00000000}
          OptionsView = [edgoBandHeaderWidth, edgoRowSelect, edgoUseBitmap]
          object listColumn1: TdxDBGridMaskColumn
            Caption = #20154#21592#21517#31216
            Width = 73
            BandIndex = 0
            RowIndex = 0
            FieldName = 'name'
          end
          object listColumn2: TdxDBGridMaskColumn
            Caption = #20154#21592#21517#31216#31616#20889
            Width = 92
            BandIndex = 0
            RowIndex = 0
            FieldName = 'name_py'
          end
          object listColumn3: TdxDBGridMaskColumn
            Caption = #32844#20301
            Width = 39
            BandIndex = 0
            RowIndex = 0
            FieldName = 'career'
          end
          object listColumn4: TdxDBGridMaskColumn
            Caption = #32844#32423
            Width = 57
            BandIndex = 0
            RowIndex = 0
            FieldName = 'grade'
          end
          object listColumn5: TdxDBGridMaskColumn
            Caption = #21442#21152#20250#35758#29366#24577
            Width = 78
            BandIndex = 0
            RowIndex = 0
            FieldName = 'status_ex'
          end
        end
      end
    end
  end
  inherited query: TADOQuery
    Connection = dmseat.seatconn
    LockType = ltBatchOptimistic
  end
end
