unit UNBMAND;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables;

type
  TFMBMAND = class(TDataModule)
    DSBMAN: TDataSource;
    QBMAN: TQuery;
    QBMANBNENO: TStringField;
    QBMANBNNAM: TStringField;
    QBMANBNCNA: TStringField;
    QBMANBNBTH: TDateTimeField;
    QBMANBNROT: TStringField;
    QBMANBNIDN: TStringField;
    QBMANBNPAS: TStringField;
    QBMANBNLIV: TStringField;
    QBMANBNSEX: TStringField;
    QBMANBNBLD: TStringField;
    QBMANBNSCS: TStringField;
    QBMANBNSDP: TStringField;
    QBMANBNCPL: TStringField;
    QBMANBNSPP: TFloatField;
    QBMANBNSCH: TStringField;
    QBMANBNHIS: TStringField;
    QBMANBNCMN: TStringField;
    QBMANBNREL: TStringField;
    QBMANBNTL1: TStringField;
    QBMANBNTL2: TStringField;
    QBMANBNTL3: TStringField;
    QBMANBNAD1: TStringField;
    QBMANBNAD2: TStringField;
    QBMANBNVIC: TStringField;
    QBMANBNVIN: TStringField;
    QBMANBNSEC: TStringField;
    QBMANBNCLS: TStringField;
    QBMANBNDPO: TStringField;
    QBMANBNDPT: TStringField;
    QBMANBNLLC: TStringField;
    QBMANBNSVR: TStringField;
    QBMANBNNUM: TStringField;
    QBMANBNLCC: TStringField;
    QBMANBNEPC: TStringField;
    QBMANBNTIT: TStringField;
    QBMANBNGRC: TStringField;
    QBMANBNBNS: TStringField;
    QBMANBNBNO: TStringField;
    QBMANBNC02: TDateTimeField;
    QBMANBNC03: TStringField;
    QBMANBNFDY: TDateTimeField;
    QBMANBNEDY: TDateTimeField;
    QBMANBNHPS: TDateTimeField;
    QBMANBNHPF: TDateTimeField;
    QBMANBNCHM: TStringField;
    QBMANBNHPV: TFloatField;
    QBMANBNSPL: TFloatField;
    QBMANBNSPN: TFloatField;
    QBMANBNLV1: TFloatField;
    QBMANBNLV2: TFloatField;
    QBMANBNTB1: TDateTimeField;
    QBMANBNTB2: TDateTimeField;
    QBMANBNIF1: TDateTimeField;
    QBMANBNIF2: TDateTimeField;
    QBMANBNHI1: TDateTimeField;
    QBMANBNHI2: TDateTimeField;
    QBMANBNHIX: TStringField;
    QBMANBNTBX: TStringField;
    QBMANBNISM: TFloatField;
    QBMANBNHIM: TFloatField;
    QBMANBNHIN: TFloatField;
    QBMANBNHBS: TBooleanField;
    QBMANBNCTY: TStringField;
    QBMANBNZP1: TStringField;
    QBMANBNZP2: TStringField;
    UBMAN: TUpdateSQL;
    QBMANBNPWD: TStringField;
    procedure QBMANAfterEdit(DataSet: TDataSet);
    procedure DSBMANDataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
  public
    { Public declarations }
    REC_CNT:INTEGER;
  end;

var
  FMBMAND: TFMBMAND;

implementation

uses UN_UTL, UNBMAN;

{$R *.DFM}










procedure TFMBMAND.QBMANAfterEdit(DataSet: TDataSet);
begin
FMBMAN.UPDATEMODE;
end;

procedure TFMBMAND.DSBMANDataChange(Sender: TObject; Field: TField);
begin

IF QBMAN.Eof = FALSE THEN FMBMAN.BNPWD.TEXT := Decrypt( COPY(QBMAN.FieldByName('BNPWD').AsString, 2, LENGTH(QBMAN.FieldByName('BNPWD').AsString)-2) ,1357,2,1);;

end;

end.
