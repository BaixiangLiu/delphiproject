unit UNRBOWP;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  quickrpt, ExtCtrls, Qrctrls;

type
  TFMRBOWP = class(TForm)
    QuickRep: TQuickRep;
    QRBand1: TQRBand;
    QRShape3: TQRShape;
    QRLabel1: TQRLabel;
    QRLabel7: TQRLabel;
    QRShape8: TQRShape;
    QRShape7: TQRShape;
    QRLabel3: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel5: TQRLabel;
    QRShape10: TQRShape;
    QRLabel6: TQRLabel;
    QRShape4: TQRShape;
    QRShape14: TQRShape;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRShape18: TQRShape;
    QRBand2: TQRBand;
    LB_RECORDCOUNT: TQRLabel;
    LBTITLE: TQRLabel;
    QRBand3: TQRBand;
    QRShape2: TQRShape;
    QRDBText2: TQRDBText;
    QRShape13: TQRShape;
    QRShape6: TQRShape;
    QRDBText7: TQRDBText;
    QRShape21: TQRShape;
    QRShape11: TQRShape;
    QRShape16: TQRShape;
    QRShape12: TQRShape;
    QRDBText6: TQRDBText;
    QRShape9: TQRShape;
    QRShape15: TQRShape;
    QRDBText9: TQRDBText;
    QRShape19: TQRShape;
    BGNAM: TQRLabel;
    BNNAM: TQRLabel;
    QRShape1: TQRShape;
    QRDBText1: TQRDBText;
    RBREA: TQRLabel;
    QRLabel4: TQRLabel;
    QRDBText3: TQRDBText;
    QRLabel10: TQRLabel;
    QRDBText4: TQRDBText;
    procedure QRBand3BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMRBOWP: TFMRBOWP;

implementation

USES UNRBOWD, DB_UTL;

{$R *.DFM}












































procedure TFMRBOWP.QRBand3BeforePrint(Sender: TQRCustomBand;  var PrintBand: Boolean);
begin
WITH FMRBOWD.QRBOW DO
 BEGIN
 BGNAM.Caption := DB_QUERY_FIND_VALUE('BGDS','BGENO',FieldByName('BGENO').AsString,'BGNAM');
 BNNAM.Caption := DB_QUERY_FIND_VALUE('BMAN','BNENO',FieldByName('BNENO').AsString,'BNNAM');

 RBREA.Caption := UNSETREAD('RBOWRBREA',FieldByName('RBREA').AsString);
 END;
end;

end.
