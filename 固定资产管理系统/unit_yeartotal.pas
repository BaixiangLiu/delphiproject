unit unit_yeartotal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QRCtrls, DB, ADODB, QuickRpt, ExtCtrls;

type
  Tfrm_yeartotal = class(TForm)
    QuickRep1: TQuickRep;
    TitleBand1: TQRBand;
    ChildBand1: TQRChildBand;
    QRLabel1: TQRLabel;
    QRSysData1: TQRSysData;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    DetailBand1: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    ADOTable1: TADOTable;
    PageFooterBand1: TQRBand;
    QRLabel7: TQRLabel;
    QRSysData2: TQRSysData;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRExpr1: TQRExpr;
    QRLabel11: TQRLabel;
    QRShape1: TQRShape;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_yeartotal: Tfrm_yeartotal;

implementation

uses unit_main;

{$R *.dfm}

end.
