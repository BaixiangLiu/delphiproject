unit RPPOS5P;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  quickrpt, ExtCtrls, Qrctrls, Thubar39;

type
  TRMPOS5P = class(TForm)
    QuickRep: TQuickRep;
    QRBand1: TQRBand;
    QRShape3: TQRShape;
    QRLabel1: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel9: TQRLabel;
    QRShape8: TQRShape;
    QRShape5: TQRShape;
    QRShape7: TQRShape;
    QRLabel3: TQRLabel;
    QRBand3: TQRBand;
    QRDBText2: TQRDBText;
    QRShape6: TQRShape;
    Expr1002: TQRDBText;
    Expr1003: TQRDBText;
    QRShape11: TQRShape;
    QRShape17: TQRShape;
    QRShape16: TQRShape;
    Expr1004: TQRDBText;
    QRLabel2: TQRLabel;
    QRDBText1: TQRDBText;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRBand4: TQRBand;
    ED_BGCNT: TQRLabel;
    ED_BGCOS: TQRLabel;
    ED_BGCOT: TQRLabel;
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
  public
    { Public declarations }
  end;

var
  RMPOS5P: TRMPOS5P;

implementation

USES DB_UTL, RPPOS5F, SYSINI;

{$R *.DFM}












































procedure TRMPOS5P.QRBand3BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
 //Á`­p ===============================================
WITH RMPOS5F.QPOS5F DO
 BEGIN
 T_BGCNT := T_BGCNT + FieldByName(_SUMF[2]).AsINTEGER;
 T_BGCOS := T_BGCOS + FieldByName(_SUMF[3]).AsINTEGER;
 T_BGCOT := T_BGCOT + FieldByName(_SUMF[4]).AsINTEGER;
 ED_BGCNT.Caption := INTTOSTR(T_BGCNT);
 ED_BGCOS.Caption := INTTOSTR(T_BGCOS);
 ED_BGCOT.Caption := INTTOSTR(T_BGCOT);

 END;

end;

procedure TRMPOS5P.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin

Expr1002.DataField := _SUMF[2];
Expr1003.DataField := _SUMF[3];
Expr1004.DataField := _SUMF[4];
T_BGCNT := 0;
T_BGCOS := 0;
T_BGCOT := 0;

end;

end.
  