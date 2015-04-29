unit RPIVTAP;

interface
                 
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  quickrpt, ExtCtrls, Qrctrls, Thubar39;

type
  TRMIVTAP = class(TForm)
    QuickRep: TQuickRep;
    QRBand1: TQRBand;
    QRBand2: TQRBand;
    QRShape1: TQRShape;
    ED_PAGE: TQRLabel;
    LBTITLE: TQRLabel;
    QRLabel1: TQRLabel;
    QRBand3: TQRBand;
    QRDBText2: TQRDBText;
    QRLabel2: TQRLabel;
    QRLabel5: TQRLabel;
    QRDBText5: TQRDBText;
    QRLabel3: TQRLabel;
    QRDBText3: TQRDBText;
    QRShape2: TQRShape;
    ED_RECNO: TQRLabel;
    BGNAM: TQRLabel;
    procedure QRBand3BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QuickRepStartPage(Sender: TCustomQuickRep);
  private
    { Private declarations }
    T_RECNO : INTEGER;
    T_PAGE  : INTEGER;
  public
    { Public declarations }
  end;

var
  RMIVTAP: TRMIVTAP;

implementation

USES RPIVTAF, DB_UTL;

{$R *.DFM}













































procedure TRMIVTAP.QuickRepBeforePrint(Sender: TCustomQuickRep;  var PrintReport: Boolean);
begin
T_RECNO := 0;
T_PAGE := 0;
end;

procedure TRMIVTAP.QuickRepStartPage(Sender: TCustomQuickRep);
begin
T_PAGE  := T_PAGE  + 1;
ED_PAGE .CAPTION := '²Ä ' + INTTOSTR(T_PAGE) + ' ­¶' ;
end;

procedure TRMIVTAP.QRBand3BeforePrint(Sender: TQRCustomBand;  var PrintBand: Boolean);
begin
T_RECNO := T_RECNO + 1;
ED_RECNO.CAPTION := INTTOSTR(T_RECNO);

BGNAM.CAPTION := DB_QUERY_FIND_VALUE('BGDS','BGENO',RMIVTAF.QIVTAF.FieldByName('BGENO').AsString,'BGNAM');

end;




end.
