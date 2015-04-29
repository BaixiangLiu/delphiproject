unit UNPOSAD;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables;

type
  TFMPOSAD = class(TDataModule)
    QRBRNRBPST: TQuery;
    DSRBRNRBPST: TDataSource;
    QRBRNRBPSTLSTID1: TStringField;
    QRBRNRBPSTLSTID2: TStringField;
    QRBRNRBPSTLSTNAM: TStringField;
    QRBRNRBPSTLSTMRK: TStringField;
    DSBMEM: TDataSource;
    QBGDS: TQuery;
    DSBGDS: TDataSource;
    QBGDSBGENO: TStringField;
    QBGDSBGNAM: TStringField;
    QBGDSBGPST: TFloatField;
    QBGDSBGPVP: TFloatField;
    QBGDSBGPMM: TFloatField;
    QBGDSBGPR1: TFloatField;
    QBGDSBGPR2: TFloatField;
    QBGDSBGPR3: TFloatField;
    QPOSM: TQuery;
    QPOSNA: TQuery;
    QPOSNB: TQuery;
    DSPOSNA: TDataSource;
    DSPOSNB: TDataSource;
    QBGDSBGID1: TStringField;
    QBGDSBGKIN: TStringField;
    QBGDSBGQTS: TFloatField;
    QBGDSBGCOS: TFloatField;
    QBGDSBSENO: TStringField;
    QBCST: TQuery;
    QBCSTBCENO: TStringField;
    QBCSTBCNAM: TStringField;
    QBCSTBCCNA: TStringField;
    QBCSTBCSNA: TStringField;
    QBCSTBCSCN: TStringField;
    QBCSTBCMN1: TStringField;
    QBCSTBCMN2: TStringField;
    QBCSTBCMN3: TStringField;
    QBCSTBCM2T: TStringField;
    QBCSTBCM2P: TStringField;
    QBCSTBCM2W: TStringField;
    QBCSTBCM3T: TStringField;
    QBCSTBCM3P: TStringField;
    QBCSTBCM3W: TStringField;
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
    QBCSTBCMRK: TStringField;
    QBCSTBNENO: TStringField;
    UpdateSQL1: TUpdateSQL;
    Query1: TQuery;
    StringField1: TStringField;
    StringField2: TStringField;
    StringField3: TStringField;
    DateTimeField1: TDateTimeField;
    StringField4: TStringField;
    DateTimeField2: TDateTimeField;
    DateTimeField3: TDateTimeField;
    StringField5: TStringField;
    StringField6: TStringField;
    DateTimeField4: TDateTimeField;
    DateTimeField5: TDateTimeField;
    DateTimeField6: TDateTimeField;
    FloatField1: TFloatField;
    FloatField2: TFloatField;
    FloatField3: TFloatField;
    FloatField4: TFloatField;
    FloatField5: TFloatField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMPOSAD: TFMPOSAD;

implementation

{$R *.DFM}




end.
