unit UNPOSND;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables;

type
  TFMPOSND = class(TDataModule)
    DSPOSN: TDataSource;
    QPOSN: TQuery;
    UPOSN: TUpdateSQL;
    QPOSNBGEN1: TStringField;
    QPOSNBGEN2: TStringField;
    QPOSNPNPR1: TFloatField;
    QPOSNPNPR2: TFloatField;
    QPOSNPNDT1: TDateTimeField;
    QPOSNPNDT2: TDateTimeField;
    QPOSNPNDAT: TDateTimeField;
    QPOSN_BGNAM1: TStringField;
    QPOSN_BGNAM2: TStringField;
    QPOSNBGENO: TStringField;
    QPOSNBGNAM: TStringField;
    QPOSNBGKIN: TStringField;
    QPOSNBGPST: TFloatField;
    QPOSNBGPVP: TFloatField;
    QPOSNBGPMM: TFloatField;
    QPOSNBGCST: TFloatField;
    QPOSNBGOTH: TFloatField;
    procedure QPOSNCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMPOSND: TFMPOSND;

implementation

USES DB_UTL;

{$R *.DFM}




procedure TFMPOSND.QPOSNCalcFields(DataSet: TDataSet);
begin
QPOSN_BGNAM1.Value :=  DB_QUERY_FIND_VALUE('BGDS','BGENO',QPOSNBGEN1.Value,'BGNAM');
QPOSN_BGNAM2.Value :=  DB_QUERY_FIND_VALUE('BGDS','BGENO',QPOSNBGEN2.Value,'BGNAM');

end;

end.
