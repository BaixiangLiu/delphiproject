unit SYSABOUT;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, GIFImage;

type
  TFMABOUT = class(TForm)
    Bevel1: TBevel;
    Bevel2: TBevel;
    Image1: TImage;
    Label1: TLabel;
    Image2: TImage;
    BitBtn1: TBitBtn;
    Label8: TLabel;
    procedure OKBtnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMABOUT: TFMABOUT;

implementation

{$R *.DFM}


procedure TFMABOUT.OKBtnClick(Sender: TObject);
begin
CLOSE;
end;

procedure TFMABOUT.FormClose(Sender: TObject; var Action: TCloseAction);
begin
FMABOUT.Release;
end;


end.
