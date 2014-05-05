unit unit_datamodule;

interface

uses
  SysUtils, Classes, DB, DBTables, ADODB;

type
  Tfrm_datamodule = class(TDataModule)
    DataSource1: TDataSource;
    ADOTable1: TADOTable;
    ADOConnection1: TADOConnection;
    DataSource3: TDataSource;
    ADODataSet1: TADODataSet;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_datamodule: Tfrm_datamodule;

implementation

{$R *.dfm}

end.
