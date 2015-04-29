unit JLOOKUPM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBTables, Db, Grids, DBGrids, ComCtrls, StdCtrls, Mask, DBCtrls, Buttons,
  ToolWin, Menus, JEdit, ExtCtrls;

type
  TFMLOOKUPM = class(TForm)
    DBGrid1: TDBGrid;
    QSYSLST: TQuery;
    DSSYSLST: TDataSource;
    QSYSLSTLSTID1: TStringField;
    QSYSLSTLSTID2: TStringField;
    QSYSLSTLSTNAM: TStringField;
    QSYSLSTLSTMRK: TStringField;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


var
  FMLOOKUPM: TFMLOOKUPM;


implementation

uses UN_UTL, FM_UTL, DB_UTL, JLOOKUPD, JLOOKUP;
{$R *.DFM}







procedure TFMLOOKUPM.FormCreate(Sender: TObject);
begin
//
   FMLOOKUPM.Left := SCREEN.Width  - FMLOOKUPM.Width;
   FMLOOKUPM.Top  := SCREEN.Height - FMLOOKUPM.Height;

end;

end.
