unit SYSLSTP;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  quickrpt, ExtCtrls, Qrctrls;

type
  TFMLSTP = class(TForm)
    QuickRep: TQuickRep;
    QRBand1: TQRBand;
    QRBand2: TQRBand;
    QRBand3: TQRBand;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRShape4: TQRShape;
    QRShape9: TQRShape;
    QRLabel1: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRShape10: TQRShape;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRShape11: TQRShape;
    QRShape13: TQRShape;
    LB_RECORDCOUNT: TQRLabel;
    LBTITLE: TQRLabel;
    QRShape18: TQRShape;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMLSTP: TFMLSTP;

implementation

USES SYSLST;

{$R *.DFM}









































end.
