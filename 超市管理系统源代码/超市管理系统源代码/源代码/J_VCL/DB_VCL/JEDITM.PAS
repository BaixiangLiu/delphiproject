unit JEditM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, GIFImage, ExtCtrls;

type
  TFMEDITM = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


var
  FMEDITM: TFMEDITM;


implementation

uses UN_UTL, FM_UTL, DB_UTL, JLOOKUPD, JLOOKUP;
{$R *.DFM}







procedure TFMEDITM.FormCreate(Sender: TObject);
begin
   FMEDITM.Left := SCREEN.Width  - FMEDITM.Width;
   FMEDITM.Top  := SCREEN.Height - FMEDITM.Height;
end;

end.
