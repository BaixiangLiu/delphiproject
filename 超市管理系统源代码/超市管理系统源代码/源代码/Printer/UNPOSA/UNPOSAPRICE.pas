unit UNPOSAPRICE;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Menus, Spin, JEdit;

type
  TFMPOSAPRICE = class(TForm)
    MainMenu1: TMainMenu;
    ESC: TMenuItem;
    ED_CHANGE: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label1: TLabel;
    ED_CHANGE_QTY: TJEdit;
    ED_CHANGE_SPRICE: TJEdit;
    ED_CHANGE_TPRICE: TJEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ESCClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ED_CHANGE_QTYKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMPOSAPRICE: TFMPOSAPRICE;

implementation

uses UN_UTL, UNPOSAD, UNPOSA, UNPOSAU;

{$R *.DFM}

procedure TFMPOSAPRICE.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FMPOSAPRICE.Release;
end;

procedure TFMPOSAPRICE.ESCClick(Sender: TObject);
begin
  CLOSE;
end;

procedure TFMPOSAPRICE.FormCreate(Sender: TObject);
BEGIN
  WITH FMPOSA DO
    BEGIN
    ED_CHANGE_SPRICE.Digits := 0;
    ED_CHANGE_TPRICE.Digits := 0;
    IF CHECK_FLOAT(OUT_GRID.Cells[4,OUT_GRID.Row])=TRUE THEN ED_CHANGE_SPRICE.Digits := 1;
    IF CHECK_FLOAT(OUT_GRID.Cells[5,OUT_GRID.Row])=TRUE THEN ED_CHANGE_TPRICE.Digits := 1;
  
    ED_CHANGE.Caption     := OUT_GRID.Cells[2,OUT_GRID.Row];
    ED_CHANGE_QTY.Text    := OUT_GRID.Cells[3,OUT_GRID.Row];
    ED_CHANGE_SPRICE.TEXT := OUT_GRID.Cells[4,OUT_GRID.Row];
    ED_CHANGE_TPRICE.TEXT := OUT_GRID.Cells[5,OUT_GRID.Row];
    ED_CHANGE.Show;
    END;
end;

procedure TFMPOSAPRICE.FormShow(Sender: TObject);
begin
  ED_CHANGE_QTY.SetFocus;
  ED_CHANGE_QTY.SelectAll;
end;

procedure TFMPOSAPRICE.ED_CHANGE_QTYKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
VAR QTY, PRICE : REAL;
begin
  IF STRTOFLOATDEF(ED_CHANGE_QTY.Text   ,-999999)< -999900 THEN EXIT;
  IF STRTOFLOATDEF(ED_CHANGE_SPRICE.Text,-999999)< -999900 THEN EXIT;
  IF STRTOFLOATDEF(ED_CHANGE_TPRICE.Text,-999999)< -999900 THEN EXIT;
  
  
  WITH FMPOSA DO
    BEGIN
    IF TRIM(ED_CHANGE_SPRICE.TEXT) <> '' THEN PRICE := ED_CHANGE_SPRICE.Value;
    IF TRIM(ED_CHANGE_QTY.TEXT)    <> '' THEN QTY   := ED_CHANGE_QTY.Value;
  
    IF ( KEY = 13 ) AND (SENDER = ED_CHANGE_QTY )    THEN
       BEGIN
       ED_CHANGE_TPRICE.Value := PRICE * QTY;
       ED_CHANGE_SPRICE.SetFocus;
       END;
    IF ( KEY = 13 ) AND (SENDER = ED_CHANGE_SPRICE ) THEN
       BEGIN
       ED_CHANGE_TPRICE.Value := PRICE * QTY;
       ED_CHANGE_TPRICE.SetFocus;
       END;
    IF ( KEY = 13 ) AND (SENDER = ED_CHANGE_TPRICE ) THEN
       BEGIN
       OUT_GRID.Cells[3,OUT_GRID.Row] := ED_CHANGE_QTY  .TEXT;
       OUT_GRID.Cells[4,OUT_GRID.Row] := ED_CHANGE_SPRICE.TEXT;
       OUT_GRID.Cells[5,OUT_GRID.Row] := ED_CHANGE_TPRICE.TEXT;
       FMPOSAPRICE.CLOSE;
       ED_INPUT_SetFocus;
       END;
    END;
end;



end.
