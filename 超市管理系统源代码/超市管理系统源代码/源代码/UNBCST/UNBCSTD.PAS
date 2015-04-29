unit UNBCSTD;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables;

type
  TFMBCSTD = class(TDataModule)
    DSBCST: TDataSource;
    QBCST: TQuery;
    UBCST: TUpdateSQL;
    QBCSTBCMN2: TStringField;
    QBCSTBCENO: TStringField;
    QBCSTBCNAM: TStringField;
    QBCSTBCCNA: TStringField;
    QBCSTBCSCN: TStringField;
    QBCSTBCMN1: TStringField;
    QBCSTBCMN3: TStringField;
    QBCSTBCTL1: TStringField;
    QBCSTBCTL2: TStringField;
    QBCSTBCFX1: TStringField;
    QBCSTBCFX2: TStringField;
    QBCSTBCAD1: TStringField;
    QBCSTBCAD2: TStringField;
    QBCSTBCZP1: TStringField;
    QBCSTBCZP2: TStringField;
    QBCSTBCTL9: TStringField;
    QBCSTBCAD9: TStringField;
    QBCSTBCZP9: TStringField;
    QBCSTBCDIS: TFloatField;
    QBCSTBCTP1: TFloatField;
    QBCSTBCTP2: TFloatField;
    QBCSTBCTP5: TFloatField;
    QBCSTBCTP6: TFloatField;
    QBCSTBCTPN: TStringField;
    QBCSTBCTTP: TStringField;
    QBCSTBCTTD: TFloatField;
    QBCSTBCTEG: TStringField;
    QBCSTBCTBK: TStringField;
    QBCSTBCALT: TFloatField;
    QBCSTBCTDT: TDateTimeField;
    QBCSTBCDAT: TDateTimeField;
    QBCSTBCID1: TStringField;
    QBCSTBCMRK: TMemoField;
    QBCSTBNENO: TStringField;
    procedure QBCSTAfterEdit(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    REC_CNT:INTEGER;
  end;

var
  FMBCSTD: TFMBCSTD;

implementation

uses UNBCST;

{$R *.DFM}










procedure TFMBCSTD.QBCSTAfterEdit(DataSet: TDataSet);
begin
FMBCST.UPDATEMODE;
end;

end.
