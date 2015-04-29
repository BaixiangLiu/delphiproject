unit SELOOKUPM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBTables, Db, Grids, DBGrids, ComCtrls, StdCtrls, Mask, DBCtrls, Buttons,
  ToolWin, Menus, JEdit, ExtCtrls;

type
  TFMSELOOKUPM = class(TForm)
    DBGrid1: TDBGrid;
    QSYSLST: TQuery;
    DSSYSLST: TDataSource;
    QSYSLSTLSTNAM: TStringField;
    QSYSLSTLSTMRK: TStringField;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    QSYSLSTLSTENO: TStringField;
    QSYSLSTLSTITM: TStringField;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


var
  FMSELOOKUPM: TFMSELOOKUPM;


implementation

uses UN_UTL, FM_UTL, DB_UTL, JLOOKUPD, JLOOKUP;
{$R *.DFM}







procedure TFMSELOOKUPM.FormCreate(Sender: TObject);
begin
//
   FMSELOOKUPM.Left := SCREEN.Width  - FMSELOOKUPM.Width;
   FMSELOOKUPM.Top  := SCREEN.Height - FMSELOOKUPM.Height;

end;

end.
