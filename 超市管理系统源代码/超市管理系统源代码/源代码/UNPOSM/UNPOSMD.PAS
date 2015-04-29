unit UNPOSMD;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables;

type
  TFMPOSMD = class(TDataModule)
    DSPOSM: TDataSource;
    QPOSM: TQuery;
    UPOSM: TUpdateSQL;
    QPOSMBGENO: TStringField;
    QPOSMPMDT1: TDateTimeField;
    QPOSMPMDT2: TDateTimeField;
    QPOSMPMDAT: TDateTimeField;
    QPOSMPMPRI: TFloatField;
    QPOSM_BGNAM: TStringField;
    procedure QPOSMAfterEdit(DataSet: TDataSet);
    procedure QPOSMCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMPOSMD: TFMPOSMD;

implementation

uses DB_UTL, UNPOSM;

{$R *.DFM}




procedure TFMPOSMD.QPOSMAfterEdit(DataSet: TDataSet);
begin
FMPOSM.UPDATEMODE;

end;

procedure TFMPOSMD.QPOSMCalcFields(DataSet: TDataSet);
begin
QPOSM_BGNAM.Value :=  DB_QUERY_FIND_VALUE('BGDS','BGENO',QPOSMBGENO.Value,'BGNAM');

end;

end.
