unit RPTOP1P;

interface
                 
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  quickrpt, ExtCtrls, Qrctrls, Thubar39;

type
  TRMTOP1P = class(TForm)
    QuickRep: TQuickRep;
    QRBand4: TQRBand;
    QRDBText2: TQRDBText;
    Expr10051: TQRDBText;
    Expr10041: TQRDBText;
    Expr10031: TQRDBText;
    QRDBText1: TQRDBText;
    QRBand5: TQRBand;
    QRShape1: TQRShape;
    QRLabel1: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel6: TQRLabel;
    BGKIN: TQRLabel;
    QRShape4: TQRShape;
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
    ED_REC_CNT: TQRLabel;
    procedure QRBand4BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
    T_REC_CNT : INTEGER;
    T_CNT : INTEGER;
  public
    { Public declarations }
  end;

var
  RMTOP1P: TRMTOP1P;

implementation

USES RPTOP1F, DB_UTL, SYSINI;

{$R *.DFM}












































procedure TRMTOP1P.QRBand4BeforePrint(Sender: TQRCustomBand;  var PrintBand: Boolean);
begin
INC(T_REC_CNT);
ED_REC_CNT.Caption := INTTOSTR(T_REC_CNT);

WITH RMTOP1F.QTOP1F DO
 BEGIN
 BGKIN.Caption := UNSETREAD('BGDSBGKIN' ,FieldByName('BGKIN').AsString);
 END;

INC(T_CNT);
IF T_CNT > RMTOP1F.CN1.Value THEN QuickRep.EndPage;
end;

procedure TRMTOP1P.QuickRepBeforePrint(Sender: TCustomQuickRep;  var PrintReport: Boolean);
begin
T_REC_CNT := 0;

Expr10031.DataField := _SUMF[3];
Expr10041.DataField := _SUMF[4];
Expr10051.DataField := _SUMF[5];
T_CNT := 0;
end;

end.
