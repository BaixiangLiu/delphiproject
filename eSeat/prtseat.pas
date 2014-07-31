unit prtseat;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QuickRpt, ExtCtrls, QRCtrls;

type
  TForm2 = class(TForm)
    QuickRep1: TQuickRep;
    QRSubDetail1: TQRSubDetail;
    QRSubDetail2: TQRSubDetail;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

end.
