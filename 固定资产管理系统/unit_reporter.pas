unit unit_reporter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, QRCtrls, QuickRpt, ExtCtrls, DBTables;

type
  Tfrm_reporter = class(TForm)
    QuickRep1: TQuickRep;
    ADODataSet1: TADODataSet;
    QRBand1: TQRBand;
    QRBand2: TQRBand;
    QRLabel12: TQRLabel;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    DetailBand1: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRLabel11: TQRLabel;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    QRDBText10: TQRDBText;
    QRDBText11: TQRDBText;
    QRBand3: TQRBand;
    QRLabel13: TQRLabel;
    QRShape1: TQRShape;
    procedure QuickRep1StartPage(Sender: TCustomQuickRep);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_reporter: Tfrm_reporter;

implementation

uses unit_main;

{$R *.dfm}

procedure Tfrm_reporter.QuickRep1StartPage(Sender: TCustomQuickRep);
begin
showmessage('«Î”√A3÷Ω¥Ú”°!');
end;

end.
