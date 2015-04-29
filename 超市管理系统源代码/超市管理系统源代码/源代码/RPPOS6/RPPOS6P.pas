unit RPPOS6P;

interface
                 
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  quickrpt, ExtCtrls, Qrctrls, Thubar39;

type
  TRMPOS6P = class(TForm)
    QuickRep: TQuickRep;
    QRBand1: TQRBand;
    QRShape3: TQRShape;
    QRLabel1: TQRLabel;
    QRLabel7: TQRLabel;
    QRShape5: TQRShape;
    QRShape7: TQRShape;
    QRLabel3: TQRLabel;
    QRBand3: TQRBand;
    QRDBText2: TQRDBText;
    QRShape6: TQRShape;
    Expr1002: TQRDBText;
    QRShape17: TQRShape;
    QRShape16: TQRShape;
    Expr1004: TQRDBText;
    QRLabel2: TQRLabel;
    QRDBText1: TQRDBText;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRBand4: TQRBand;
    ED_BGCNT: TQRLabel;
    ED_BGCOT: TQRLabel;
    QRLabel4: TQRLabel;
    QRShape4: TQRShape;
    QRShape9: TQRShape;
    LB_BGKIN: TQRLabel;
    QRShape10: TQRShape;
    QRShape12: TQRShape;
    QRLabel41: TQRLabel;
    QRLabel42: TQRLabel;
    QRLabel43: TQRLabel;
    QRLabel44: TQRLabel;
    QRDBText13: TQRDBText;
    QRDBText14: TQRDBText;
    QRDBText15: TQRDBText;
    QRDBText16: TQRDBText;
    QRLabel5: TQRLabel;
    LB_BGCOSX: TQRLabel;
    ED_BGCOTX: TQRLabel;
    LBBSENO: TQRLabel;
    QRShape8: TQRShape;
    QRShape11: TQRShape;
    BSENO: TQRDBText;
    BSNAM: TQRLabel;
    QRDBText4: TQRDBText;
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
    T_BGCNT, T_BGCOS, T_BGCOT : INTEGER;
    T_BGCOTX : REAL;
  public
    { Public declarations }
  end;

var
  RMPOS6P: TRMPOS6P;

implementation

USES RPPOS6F, DB_UTL, UN_UTL, SYSINI;

{$R *.DFM}












































procedure TRMPOS6P.QRBand3BeforePrint(Sender: TQRCustomBand;  var PrintBand: Boolean);
begin

 //Á`­p ===============================================
WITH RMPOS6F.QPOS6F DO
 BEGIN
 T_BGCNT := T_BGCNT + FieldByName(_SUMF[0]).AsINTEGER;
 T_BGCOS := T_BGCOS + FieldByName(_SUMF[1]).AsINTEGER;
 T_BGCOT := T_BGCOT + FieldByName(_SUMF[2]).AsINTEGER;
 ED_BGCNT.Caption := INTTOSTR(T_BGCNT);
// ED_BGCOS.Caption := INTTOSTR(T_BGCOS);
 ED_BGCOT.Caption := INTTOSTR(T_BGCOT);


 LB_BGCOSX.Caption := FLOAT_LENGTH(FLOATTOSTR( Fields.Fields[0].AsINTEGER * FieldByName('BGCOS').AsFLOAT ),2);

 IF CHECK_FLOAT(LB_BGCOSX.Caption) THEN
    BEGIN
    T_BGCOTX := T_BGCOTX + STRTOFLOAT(LB_BGCOSX.Caption);
    ED_BGCOTX.Caption := FLOATTOSTR(T_BGCOTX);
    END;

 BSNAM.Caption     := DB_QUERY_FIND_VALUE('BSUP','BSENO',FieldByName('BSENO').AsString,'BSNAM');
 LB_BGKIN.Caption  := UNSETREAD('BGDSBGKIN' ,FieldByName('BGKIN').AsString);
 END;

end;

procedure TRMPOS6P.QuickRepBeforePrint(Sender: TCustomQuickRep;  var PrintReport: Boolean);
begin
Expr1002.DataField := _SUMF[0];
//Expr1003.DataField := _SUMF[1];
Expr1004.DataField := _SUMF[2];
T_BGCNT := 0;
T_BGCOS := 0;
T_BGCOT := 0;
T_BGCOTX := 0;
end;

end.
  