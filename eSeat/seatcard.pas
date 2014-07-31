unit seatcard;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QuickRpt, QRCtrls, ExtCtrls, RM_Class, RM_Designer, RM_Dataset,
  RM_Common;

type
  Tfrmcard = class(TForm)
    QuickRep1: TQuickRep;
    QRSubDetail1: TQRSubDetail;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmcard: Tfrmcard;

implementation

{$R *.dfm}

end.
