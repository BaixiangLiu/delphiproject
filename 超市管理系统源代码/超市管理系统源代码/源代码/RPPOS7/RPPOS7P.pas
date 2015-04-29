unit RPPOS7P;

interface
                 
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Qrctrls, QuickRpt, ExtCtrls, Db, DBTables;

type
  TRMPOS7P = class(TForm)
    QuickRep: TQuickRep;
    QRBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel3: TQRLabel;
    QRBand3: TQRBand;
    QRDBText2: TQRDBText;
    Expr1002: TQRDBText;
    Expr1004: TQRDBText;
    QRLabel2: TQRLabel;
    QRDBText1: TQRDBText;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRBand4: TQRBand;
    ED_PACNA: TQRLabel;
    QRLabel41: TQRLabel;
    QRLabel42: TQRLabel;
    QRLabel43: TQRLabel;
    QRLabel44: TQRLabel;
    QRDBText13: TQRDBText;
    QRDBText15: TQRDBText;
    QRDBText16: TQRDBText;
    QRLabel4: TQRLabel;
    BNNAM: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel8: TQRLabel;
    BMNAM: TQRLabel;
    QRDBText3: TQRDBText;
    QRBand2: TQRBand;
    QRLabel16: TQRLabel;
    ED_DAT1: TQRLabel;
    QRLabel22: TQRLabel;
    ED_DAT2: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel19: TQRLabel;
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
    QRBand5: TQRBand;
    QRLabel5: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRSubDetail1: TQRSubDetail;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    QPOSG: TQuery;
    QPOSGPAENO: TStringField;
    QPOSGPGITM: TStringField;
    QPOSGPGENO: TStringField;
    QPOSGPGDAT: TDateTimeField;
    QPOSGPGCOS: TFloatField;
    QPOSGPGKND: TStringField;
    QRDBText8: TQRDBText;
    QRLabel12: TQRLabel;
    QRDBText9: TQRDBText;
    QRLabel13: TQRLabel;
    QRDBText10: TQRDBText;
    ED_PACOG: TQRLabel;
    ED_PGCOS: TQRLabel;
    ED_PACOT: TQRLabel;
    QRLabel25: TQRLabel;
    procedure QRBand3BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
    T_PACOT, T_PACOG, T_PACNA, T_PGCOS : INTEGER;
  public
    { Public declarations }
  end;

var
  RMPOS7P: TRMPOS7P;

implementation

USES RPPOS7F, DB_UTL, UN_UTL, SYSINI;

{$R *.DFM}







procedure TRMPOS7P.QRBand3BeforePrint(Sender: TQRCustomBand;  var PrintBand: Boolean);
begin


  WITH RMPOS7F.QUERYF DO
   BEGIN
   BNNAM.CAPTION := DB_QUERY_FIND_VALUE('BMAN','BNENO',FieldByName('BNENO').AsString,'BNNAM');
   BMNAM.CAPTION := DB_QUERY_FIND_VALUE('BMEM','BMENO',FieldByName('BMENO').AsString,'BMNAM');

   T_PACOT := T_PACOT + FieldByName('PACOT').AsINTEGER;
   T_PACNA := T_PACNA + FieldByName('PACNA').AsINTEGER;
   T_PACOG := T_PACOG + FieldByName('PACOG').AsINTEGER;
   T_PGCOS := T_PGCOS + FieldByName('PGCOS').AsINTEGER;
   ED_PACOT.Caption := INTTOSTR(T_PACOT);
   ED_PACNA.Caption := INTTOSTR(T_PACNA);
   ED_PACOG.Caption := INTTOSTR(T_PACOG);
   ED_PGCOS.Caption := INTTOSTR(T_PGCOS);
   END;


  QRBand5     .Enabled := FALSE;
  QRSubDetail1.Enabled := FALSE;
  IF RMPOS7F.CB1.Checked = TRUE THEN
     BEGIN
     WITH QPOSG DO
      BEGIN
      SQL.CLEAR;
      SQL.ADD('SELECT * FROM POSG ');
      SQL.ADD('WHERE PAENO = '''+RMPOS7F.QUERYF.FieldByName('PAENO').AsString+'''');
      SQL.ADD('ORDER BY PGITM');
    //    SHOWMESSAGE(SQL.TEXT);
      CLOSE;  OPEN;
      IF QPOSG.EOF = TRUE THEN QRBand5.Enabled      := TRUE;
      IF QPOSG.EOF = TRUE THEN QRSubDetail1.Enabled := TRUE;
      END;
    END;  

end;

procedure TRMPOS7P.QuickRepBeforePrint(Sender: TCustomQuickRep;  var PrintReport: Boolean);
begin
T_PACOT := 0;
T_PACOG := 0;
T_PGCOS := 0;
T_PACNA := 0;

end;

end.
 