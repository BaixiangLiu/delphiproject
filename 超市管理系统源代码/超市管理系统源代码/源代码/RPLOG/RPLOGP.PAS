unit RPLOGP;

interface
                 
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  quickrpt, ExtCtrls, Qrctrls, Thubar39;

type
  TRMLOGP = class(TForm)
    QuickRep: TQuickRep;
    QRBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel3: TQRLabel;
    QRBand3: TQRBand;
    QRDBText2: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText3: TQRDBText;
    QRLabel2: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRLabel8: TQRLabel;
    QRDBText8: TQRDBText;
    QRBand2: TQRBand;
    LBTITLE: TQRLabel;
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
    QRShape1: TQRShape;
    ED_REC_CNT: TQRLabel;
    QRShape2: TQRShape;
    ED_PAIDE: TQRLabel;
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QRBand3BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
    T_REC_CNT : INTEGER;
  public
    { Public declarations }
  end;

var
  RMLOGP: TRMLOGP;

implementation

USES RPLOGF;

{$R *.DFM}












































procedure TRMLOGP.QuickRepBeforePrint(Sender: TCustomQuickRep;  var PrintReport: Boolean);
begin
 T_REC_CNT := 0;

end;

procedure TRMLOGP.QRBand3BeforePrint(Sender: TQRCustomBand;  var PrintBand: Boolean);
begin
INC(T_REC_CNT);
ED_REC_CNT.Caption := INTTOSTR(T_REC_CNT);

end;

end.
