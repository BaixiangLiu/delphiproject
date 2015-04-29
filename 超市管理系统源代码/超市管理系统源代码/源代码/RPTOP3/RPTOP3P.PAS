unit RPTOP3P;

interface
                 
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  quickrpt, ExtCtrls, Qrctrls, Thubar39;

type
  TRMTOP3P = class(TForm)
    QuickRep: TQuickRep;
    QRBand4: TQRBand;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText1: TQRDBText;
    QRBand5: TQRBand;
    QRShape1: TQRShape;
    QRLabel1: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel6: TQRLabel;
    QRShape4: TQRShape;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
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
  RMTOP3P: TRMTOP3P;

implementation

USES RPTOP3F, DB_UTL;

{$R *.DFM}












































procedure TRMTOP3P.QRBand4BeforePrint(Sender: TQRCustomBand;  var PrintBand: Boolean);
begin
INC(T_REC_CNT);
ED_REC_CNT.Caption := INTTOSTR(T_REC_CNT);

INC(T_CNT);
IF T_CNT > RMTOP3F.CN1.Value THEN QuickRep.EndPage;
end;

procedure TRMTOP3P.QuickRepBeforePrint(Sender: TCustomQuickRep;  var PrintReport: Boolean);
begin
T_REC_CNT := 0;

T_CNT := 0;
end;

end.
