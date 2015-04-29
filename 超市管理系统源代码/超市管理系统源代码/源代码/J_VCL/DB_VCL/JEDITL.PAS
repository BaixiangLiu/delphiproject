unit JEditL;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, GIFImage, ExtCtrls, Grids, LunarCal, CLCAL;

type
  TFMEDITL = class(TForm)
    Label2: TLabel;
    CLCal1: TCLCal;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


var
  FMEDITL: TFMEDITL;


implementation

uses UN_UTL, FM_UTL, DB_UTL, JLOOKUPD, JLOOKUP;
{$R *.DFM}







procedure TFMEDITL.FormCreate(Sender: TObject);
begin
   FMEDITL.Left := 0;
   FMEDITL.Top  := SCREEN.Height - FMEDITL.Height;
end;

end.
