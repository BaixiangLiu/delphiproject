inherited frm_sel_huichang: Tfrm_sel_huichang
  Caption = #36873#25321#20250#22330
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
            Caption = #20250#22330#21517#31216
            Width = 79
            BandIndex = 0
            RowIndex = 0
            FieldName = 'name'
          end
          object listColumn2: TdxDBGridMaskColumn
            Caption = #20250#22330#21517#31216#32553#20889
            Width = 96
            BandIndex = 0
            RowIndex = 0
            FieldName = 'name_py'
          end
          object listColumn3: TdxDBGridMaskColumn
            Caption = #20250#22330#23481#37327
            Width = 60
            BandIndex = 0
            RowIndex = 0
            FieldName = 'capacity'
          end
          object listColumn4: TdxDBGridMaskColumn
            Caption = #39046#23548#21306#23481#37327
            Width = 71
            BandIndex = 0
            RowIndex = 0
            FieldName = 'leader'
          end
          object listColumn5: TdxDBGridMaskColumn
            Caption = #29366#24577
            Width = 49
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
  end
end
