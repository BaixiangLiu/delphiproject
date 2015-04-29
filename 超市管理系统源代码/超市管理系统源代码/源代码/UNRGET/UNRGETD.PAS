unit UNRGETD;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables;

type
  TFMRGETD = class(TDataModule)
    DSRGET: TDataSource;
    QRGET: TQuery;
    URGET: TUpdateSQL;
    QRGETRGENO: TStringField;
    QRGETBGENO: TStringField;
    QRGETRBPST: TStringField;
    QRGETRGREA: TStringField;
    QRGETRGDAT: TDateTimeField;
    QRGETRGTME: TStringField;
    QRGETBNENO: TStringField;
    QRGETRGMRK: TStringField;
    QRGETRGCNT: TFloatField;
    QRGETRGOUT: TBooleanField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMRGETD: TFMRGETD;

implementation

uses UNBCST;

{$R *.DFM}




end.
