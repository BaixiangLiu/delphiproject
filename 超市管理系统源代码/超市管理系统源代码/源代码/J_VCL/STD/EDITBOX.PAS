unit EDITBOX;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, GIFImage, ExtCtrls, Grids, LunarCal, CLCAL;

type
  TFMEDITBOX = class(TForm)
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;



var
  FMEDITBOX: TFMEDITBOX;

procedure Register;

implementation

uses UN_UTL, FM_UTL, DB_UTL;//, JLOOKUPD, JLOOKUP;
{$R *.DFM}







procedure TFMEDITBOX.FormCreate(Sender: TObject);
begin
//   FMEDITL.Left := 0;
//   FMEDITL.Top  := SCREEN.Height - FMEDITL.Height;
end;

procedure Register;
begin
     RegisterComponents('J_STD', [TFMEDITBOX])
end;

end.

