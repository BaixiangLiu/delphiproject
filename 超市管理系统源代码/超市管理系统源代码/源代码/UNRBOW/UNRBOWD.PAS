unit UNRBOWD;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables;

type
  TFMRBOWD = class(TDataModule)
    DSRBOW: TDataSource;
    QRBOW: TQuery;
    URBOW: TUpdateSQL;
    QRBOWRBENO: TStringField;
    QRBOWBGENO: TStringField;
    QRBOWRBCN1: TFloatField;
    QRBOWRBCN2: TFloatField;
    QRBOWRBPST: TStringField;
    QRBOWRBBCK: TBooleanField;
    QRBOWRBOUT: TBooleanField;
    QRBOWRBREA: TStringField;
    QRBOWRBDT1: TDateTimeField;
    QRBOWRBTM1: TStringField;
    QRBOWRBDT2: TDateTimeField;
    QRBOWRBTM2: TStringField;
    QRBOWBNENO: TStringField;
    QRBOWRBMRK: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMRBOWD: TFMRBOWD;

implementation

uses UNBCST;

{$R *.DFM}




end.
