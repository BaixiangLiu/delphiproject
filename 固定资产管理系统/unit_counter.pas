unit unit_counter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QuickRpt, DB, ADODB, QRCtrls, ExtCtrls, StdCtrls;

type
  Tfrm_counter = class(TForm)
    QuickRep1: TQuickRep;
    QRBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRSysData1: TQRSysData;
    DetailBand1: TQRBand;
    QRDBText1: TQRDBText;
    ChildBand1: TQRChildBand;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRExpr1: TQRExpr;
    QRDBText7: TQRDBText;
    QRShape1: TQRShape;
    PageFooterBand1: TQRBand;
    QRLabel11: TQRLabel;
    QRSysData2: TQRSysData;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRExpr2: TQRExpr;
    QRLabel14: TQRLabel;
    ChildBand2: TQRChildBand;
    QRLabel15: TQRLabel;
    Timer1: TTimer;
    Label1: TLabel;
    ADOTable1: TADOTable;
    procedure QuickRep1AfterPreview(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_counter: Tfrm_counter;

implementation

uses unit_main;

{$R *.dfm}

procedure Tfrm_counter.QuickRep1AfterPreview(Sender: TObject);
begin
adotable1.Close;
end;

end.
