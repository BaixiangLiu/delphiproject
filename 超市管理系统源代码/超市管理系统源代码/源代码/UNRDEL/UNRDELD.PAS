unit UNRDELD;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables;

type
  TFMRDELD = class(TDataModule)
    DSRDEL: TDataSource;
    QRDEL: TQuery;
    URDEL: TUpdateSQL;
    QRDELRDENO: TStringField;
    QRDELBGENO: TStringField;
    QRDELRDCNT: TFloatField;
    QRDELRBPST: TStringField;
    QRDELRDREA: TStringField;
    QRDELRDDAT: TDateTimeField;
    QRDELRDTME: TStringField;
    QRDELBNENO: TStringField;
    QRDELRDMRK: TStringField;
    QRDELRDOUT: TBooleanField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMRDELD: TFMRDELD;

implementation

uses UNBCST;

{$R *.DFM}




end.
