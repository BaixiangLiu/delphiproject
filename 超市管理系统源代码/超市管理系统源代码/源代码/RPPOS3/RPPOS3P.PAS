unit RPPOS3P;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, QuickRpt, Qrctrls, ExtCtrls;

type
  TRMPOS3P = class(TForm)
    QuickRep: TQuickRep;
    QRBand1: TQRBand;
    QRBand3: TQRBand;
    PAENO: TQRDBText;
    QRLabel1: TQRLabel;
    LB_BMNAM: TQRLabel;
    LB_BMENO: TQRLabel;
    BMNAM: TQRDBText;
    BMENO: TQRDBText;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QPOSB: TQuery;
    QRSubDetail1: TQRSubDetail;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText12: TQRDBText;
    QRDBText13: TQRDBText;
    QRDBText14: TQRDBText;
    QRDBText15: TQRDBText;
    QRDBText16: TQRDBText;
    QRBand2: TQRBand;
    QRLabel16: TQRLabel;
    ED_DAT1: TQRLabel;
    QRLabel22: TQRLabel;
    ED_DAT2: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel20: TQRLabel;
    QRLabel21: TQRLabel;
    QRLabel23: TQRLabel;
    QRLabel18: TQRLabel;
    LB_USER_CORP_TEL: TQRLabel;
    LB_USER_CORP_RBPST: TQRLabel;
    LB_USER_CORP_NO: TQRLabel;
    LB_USER_CORP_FAX: TQRLabel;
    LB_USER_CORP_ADDR: TQRLabel;
    LB_USER_CORP_NAME: TQRLabel;
    LBTITLE: TQRLabel;
    QRBand4: TQRBand;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel24: TQRLabel;
    QRLabel25: TQRLabel;
    QRLabel26: TQRLabel;
    QRLabel27: TQRLabel;
    QPOSBBGENO: TStringField;
    QPOSBBGNAM: TStringField;
    QPOSBBGKIN: TStringField;
    QPOSBBGPST: TFloatField;
    QPOSBBGPVP: TFloatField;
    QPOSBBGPMM: TFloatField;
    QPOSBBGCST: TFloatField;
    QPOSBBGOTH: TFloatField;
    QPOSBBGQTS: TFloatField;
    QPOSBBGQTN: TFloatField;
    QPOSBBGCOS: TFloatField;
    QPOSBBSENO: TStringField;
    QPOSBBGQTN_1: TFloatField;
    QPOSBBGENO_1: TStringField;
    QPOSBBGCNT: TFloatField;
    QPOSBBGCOS_1: TFloatField;
    QPOSBBGCOT: TFloatField;
    QRLabel6: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRDBText7: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText8: TQRDBText;
    QRDBText9: TQRDBText;
    QRDBText10: TQRDBText;
    QRDBText11: TQRDBText;
    procedure QRBand3BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RMPOS3P: TRMPOS3P;

implementation

USES RPPOS3F, DB_UTL, MAIN;

{$R *.DFM}












































procedure TRMPOS3P.QRBand3BeforePrint(Sender: TQRCustomBand;  var PrintBand: Boolean);
begin

   WITH QPOSB DO
   BEGIN
     SQL.CLEAR;
     SQL.ADD('SELECT * FROM BGDS, POSB                  ');
     SQL.ADD('WHERE POSB.BGENO = BGDS.BGENO             ');
     SQL.ADD('  AND PAENO IN (                          ');
     SQL.ADD('          SELECT PAENO FROM POSA          ');
     SQL.ADD('          WHERE POSA.BMENO = '''+RMPOS3F.QBMEM.FieldByName('BMENO').AsString+'''');
     SQL.ADD('           )  ');
 //    SHOWMESSAGE(SQL.TEXT);
     CLOSE;
     OPEN;
   END;

end;

end.
 