unit UNPOSAMESSAGE;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, Buttons;

type
  TFMPOSAMESSAGE = class(TForm)
    MainMenu1: TMainMenu;
    ESC: TMenuItem;
    Memo1: TMemo;
    BTNENTER: TBitBtn;
    procedure ESCClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BTNQUTKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMPOSAMESSAGE: TFMPOSAMESSAGE;

implementation

USES MAIND, SYSINI;

{$R *.DFM}

procedure TFMPOSAMESSAGE.FormCreate(Sender: TObject);
begin
  IF (_USER_ID <> '') THEN
    BEGIN
    FMMAIND.QUERY.SQL.CLEAR;
    FMMAIND.QUERY.SQL.ADD('SELECT * FROM BMAN WHERE BNENO = '''+_USER_ID+''' ');
    FMMAIND.QUERY.CLOSE;
    FMMAIND.QUERY.OPEN;
    MEMO1.LINES.CLEAR;
    MEMO1.LINES.Add( FMMAIND.QUERY.FieldByName('BNMSG').AsString );
    END;
end;

procedure TFMPOSAMESSAGE.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
  FMPOSAMESSAGE.Release;
end;

procedure TFMPOSAMESSAGE.ESCClick(Sender: TObject);
begin
  CLOSE;
end;

procedure TFMPOSAMESSAGE.BTNQUTKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  IF KEY=27 THEN
     BEGIN
     CLOSE;
     END ELSE BEGIN
     FMMAIND.QUERY.SQL.CLEAR;
     FMMAIND.QUERY.SQL.ADD('UPDATE BMAN SET BNMSG = '''' ');
     FMMAIND.QUERY.SQL.ADD('WHERE BNENO = '''+_USER_ID+''' ');
     FMMAIND.QUERY.ExecSQL;
     CLOSE;
     END;
end;


end.
