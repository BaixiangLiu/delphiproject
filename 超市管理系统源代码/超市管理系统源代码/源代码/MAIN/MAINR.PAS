unit MAINR;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls;

type
  TFMMAINR = class(TForm)
    Panel1: TPanel;
    BTNQUT: TBitBtn;
    Edit1: TEdit;
    Label1: TLabel;
    LB_HINT: TLabel;
    BitBtn1: TBitBtn;
    procedure BTNQUTClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMMAINR: TFMMAINR;

implementation

USES UN_UTL, FM_UTL;

{$R *.DFM}

procedure TFMMAINR.BTNQUTClick(Sender: TObject);
begin
  REGISTER_POS_REGISTER('\Software\WEB',EDIT1.TEXT   );
  CLOSE;
end;

procedure TFMMAINR.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FMMAINR.Release;
end;

procedure TFMMAINR.FormShow(Sender: TObject);
begin
  LB_HINT.CAPTION := INTTOSTR(GetCPUID[4]);
  EDIT1.SetFocus;
end;

procedure TFMMAINR.Edit1KeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  IF KEY=13 THEN BTNQUT.Click;                                   
end;

end.
