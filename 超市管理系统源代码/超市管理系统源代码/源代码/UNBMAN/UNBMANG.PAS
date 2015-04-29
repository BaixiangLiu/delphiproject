unit UNBMANG;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons;

type
  TFMBMANG = class(TForm)
    Memo1: TMemo;
    BTNADD: TBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BTNADDClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMBMANG: TFMBMANG;

implementation

USES MAIND, UNBMAN, UNBMAND;

{$R *.DFM}


procedure TFMBMANG.FormCreate(Sender: TObject);
begin
  FMMAIND.QUERY.SQL.CLEAR;
  FMMAIND.QUERY.SQL.ADD('SELECT * FROM BMAN WHERE BNENO = '''+FMBMAN.BNENO.Text+''' ');
  FMMAIND.QUERY.CLOSE;
  FMMAIND.QUERY.OPEN;

  MEMO1.LINES.CLEAR;
  MEMO1.LINES.Add( FMMAIND.QUERY.FieldByName('BNMSG').AsString );
end;

procedure TFMBMANG.FormClose(Sender: TObject; var Action: TCloseAction);
begin
FMBMANG.Release;
end;

procedure TFMBMANG.BTNADDClick(Sender: TObject);
begin
  FMMAIND.QUERY.SQL.CLEAR;
  FMMAIND.QUERY.SQL.ADD('UPDATE BMAN SET BNMSG = '''+MEMO1.LINES.TEXT+''' ');
  FMMAIND.QUERY.SQL.ADD('WHERE BNENO = '''+FMBMAN.BNENO.Text+''' ');
  FMMAIND.QUERY.ExecSQL;
  CLOSE;
end;


end.
