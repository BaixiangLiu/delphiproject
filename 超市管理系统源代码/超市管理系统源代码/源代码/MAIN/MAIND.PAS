unit MAIND;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBTables, Db;

type
  TFMMAIND = class(TDataModule)
    Database: TDatabase;
    QUPD: TQuery;
    QDEL: TQuery;
    QINS: TQuery;
    QUERY: TQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;


var
  FMMAIND: TFMMAIND;

implementation


{$R *.DFM}

end.
