unit RPPOS6P1;

interface
                 
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  quickrpt, ExtCtrls, Qrctrls, Thubar39;

type
  TRMPOS6P1 = class(TForm)
    QuickRep: TQuickRep;
    QRBand1: TQRBand;
    QRBand3: TQRBand;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRBand4: TQRBand;
    ED_BGCOT: TQRLabel;
    QRLabel6: TQRLabel;
    QRDBText3: TQRDBText;
    BSNAM: TQRLabel;
    QRLabel1: TQRLabel;
    QRDBText1: TQRDBText;
    QRShape8: TQRShape;
    QRShape11: TQRShape;
    QRLabel2: TQRLabel;
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
    procedure QRBand3BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
    T_BGCOT : INTEGER;
  public
    { Public declarations }
  end;

var
  RMPOS6P1: TRMPOS6P1;

implementation

USES RPPOS6F, DB_UTL, UN_UTL, SYSINI, MAIND;

{$R *.DFM}












































procedure TRMPOS6P1.QRBand3BeforePrint(Sender: TQRCustomBand;  var PrintBand: Boolean);
VAR F_NAME : array[1..10] of STRING;
begin
{
WITH RMPOS6F DO
 BEGIN
 F_NAME[1] := 'POSA.PADAT';
 F_NAME[2] := 'BGDS.BSENO';
 FMMAIND.QUERY.SQL.Clear;
 FMMAIND.QUERY.SQL.ADD('SELECT SUM(BGCOT) FROM POSA, POSB, BGDS');
 FMMAIND.QUERY.SQL.ADD('WHERE POSA.PAENO IS NOT NULL');
 FMMAIND.QUERY.SQL.ADD('  AND POSB.BGENO = BGDS.BGENO');
 FMMAIND.QUERY.SQL.ADD('  AND POSA.PAENO = POSB.PAENO');
 FMMAIND.QUERY.SQL.ADD('');
 FMMAIND.QUERY.SQL.ADD('');

 //ACCESS " DATE " WHERE KEY  ======================
 SQL.ADD(FINDFORM_WHEREKEY_DATE(F_NAME[1],LB11.Text,LB12.Text));

 //¦r¦ê¬d¸ß
 SQL.ADD(FINDFORM_WHEREKEY_STRING(F_NAME[6],LB61.Text,''));
 END;
 }
//Á`­p ===============================================
WITH RMPOS6F.QPOS6F1 DO
 BEGIN

 T_BGCOT := T_BGCOT + Fields.Fields[0].AsInteger;

 BSNAM.Caption    := DB_QUERY_FIND_VALUE('BSUP','BSENO',FieldByName('BSENO').AsString,'BSNAM');
 ED_BGCOT.Caption := INTTOSTR(T_BGCOT);
 END;

end;

procedure TRMPOS6P1.QuickRepBeforePrint(Sender: TCustomQuickRep;  var PrintReport: Boolean);
begin
T_BGCOT := 0;
{
Expr1002.DataField := _SUMF[0];
//Expr1003.DataField := _SUMF[1];
Expr1004.DataField := _SUMF[2];
T_BGCNT := 0;
T_BGCOS := 0;
T_BGCOT := 0;
T_BGCOTX := 0;
}
end;

end.
  