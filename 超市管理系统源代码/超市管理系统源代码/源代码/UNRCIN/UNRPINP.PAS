unit UNRPINP;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  quickrpt, ExtCtrls, Qrctrls, StdCtrls, Db, DBTables;

type
  TFMRPINP = class(TForm)
    QuickRep: TQuickRep;
    QRSubDetail1: TQRSubDetail;
    QRShape9: TQRShape;
    QRDBText13: TQRDBText;
    QRDBText11: TQRDBText;
    ED_RIGCS: TQRDBText;
    ED_ROGCT: TQRDBText;
    QRBand7: TQRBand;
    QRShape11: TQRShape;
    QRLabel37: TQRLabel;
    QRLabel48: TQRLabel;
    QRLabel49: TQRLabel;
    QRShape23: TQRShape;
    QRLabel7: TQRLabel;
    QRLabel2: TQRLabel;
    QRShape24: TQRShape;
    QRLabel31: TQRLabel;
    QRShape25: TQRShape;
    QRLabel34: TQRLabel;
    QRShape26: TQRShape;
    QRLabel29: TQRLabel;
    QRLabel30: TQRLabel;
    QRShape27: TQRShape;
    QRShape28: TQRShape;
    QRDBText36: TQRDBText;
    QRDBText38: TQRDBText;
    QRDBText1: TQRDBText;
    QRLabel22: TQRLabel;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText6: TQRDBText;
    QRBand1: TQRBand;
    QRLabel36: TQRLabel;
    BD_DATE: TQRLabel;
    QRBand2: TQRBand;
    QRLabel1: TQRLabel;
    QRDBText4: TQRDBText;
    procedure QRBand7BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMRPINP: TFMRPINP;

implementation

USES UN_UTL, DB_UTL, SYSINI, UNRPIND;

{$R *.DFM}


procedure TFMRPINP.QuickRepBeforePrint(Sender: TCustomQuickRep;  var PrintReport: Boolean);
begin
{
BD_CORP_NAME.Caption :=_1_CORP_NAME;
BD_CORP_TEL .Caption :=_1_CORP_TEL ;
BD_CORP_FAX .Caption :=_1_CORP_FAX ;
BD_CORP_ADD .Caption :=_1_CORP_ADDR ;
BD_DATE .Caption     := '´òÓ¡ÈÕÆÚ£º' + DATETOSTR(DATE);
}
end;

procedure TFMRPINP.QRBand7BeforePrint(Sender: TQRCustomBand;  var PrintBand: Boolean);
begin
WITH FMRPIND DO
  BEGIN
  QBSUP.SQL.Clear;
  QBSUP.SQL.Add('SELECT * FROM BSUP');
  QBSUP.SQL.Add('WHERE BSENO = '''+QRCIN.FieldByName('BSENO').AsString+'''');
  QBSUP.Close;
  QBSUP.Open;
//  BBCNAM.Caption := QBSUP.FieldByName('BSNAM').AsString;
//  BBCTL1.Caption := QBSUP.FieldByName('BSTL1').AsString;
//  BBCFX1.Caption := QBSUP.FieldByName('BSFX1').AsString;
//  BBCMN2.Caption := QBSUP.FieldByName('BSMN2').AsString;

//  BROPAY.Caption := UNSETREAD('B_PAYWAY',QRCIN.FieldByName('RIPAY').AsString);

QRCINB.SQL.CLEAR;
QRCINB.SQL.ADD('SELECT * FROM RCINB ');
QRCINB.SQL.ADD('WHERE RIENO = '''+QRCIN.FieldByName('RIENO').AsString+'''');
QRCINB.SQL.ADD('ORDER BY RIENO, RIITM');
QRCINB.CLOSE;
QRCINB.OPEN;
  END;

end;


end.
