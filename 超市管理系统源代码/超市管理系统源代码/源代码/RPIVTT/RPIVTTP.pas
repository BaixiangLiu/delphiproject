unit RPIVTTP;

interface
                 
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  quickrpt, ExtCtrls, Qrctrls, Thubar39;

type
  TRMIVTTP = class(TForm)
    QuickRep: TQuickRep;
    QRBand1: TQRBand;
    QRBand2: TQRBand;
    QRShape1: TQRShape;
    ED_PAGE: TQRLabel;
    LBTITLE: TQRLabel;
    QRLabel1: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel3: TQRLabel;
    QRBand3: TQRBand;
    QRDBText2: TQRDBText;
    QRDBText11: TQRDBText;
    QRDBText3: TQRDBText;
    QRLabel2: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRShape2: TQRShape;
    QRBand4: TQRBand;
    QRLabel6: TQRLabel;
    ED_TOTAL: TQRLabel;
    ED_RECNO: TQRLabel;
    BGNAM: TQRLabel;
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QRBand3BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QuickRepStartPage(Sender: TCustomQuickRep);
  private
    { Private declarations }
    T_RECNO : INTEGER;
    T_PAGE  : INTEGER;
  public
    { Public declarations }
    T_TOTAL : INTEGER;
  end;

var
  RMIVTTP: TRMIVTTP;

implementation

USES DB_UTL, RPIVTTF;

{$R *.DFM}












































procedure TRMIVTTP.QuickRepBeforePrint(Sender: TCustomQuickRep;  var PrintReport: Boolean);
begin
T_RECNO := 0;
T_PAGE := 0;

T_TOTAL := 0;
end;

procedure TRMIVTTP.QuickRepStartPage(Sender: TCustomQuickRep);
begin
T_PAGE  := T_PAGE  + 1;
ED_PAGE .CAPTION := '²Ä ' + INTTOSTR(T_PAGE) + ' ­¶' ;
end;

procedure TRMIVTTP.QRBand3BeforePrint(Sender: TQRCustomBand;  var PrintBand: Boolean);
begin
T_RECNO := T_RECNO + 1;
ED_RECNO.CAPTION := INTTOSTR(T_RECNO);

BGNAM.CAPTION := DB_QUERY_FIND_VALUE('BGDS','BGENO',RMIVTTF.QUERYF.FieldByName('BGENO').AsString,'BGNAM');

T_TOTAL := T_TOTAL +
STRTOINTDEF(
RMIVTTF.QUERYF.FIELDBYNAME('_COST').ASSTRING,0);
ED_TOTAL.Caption := INTTOSTR(T_TOTAL);
end;


end.
