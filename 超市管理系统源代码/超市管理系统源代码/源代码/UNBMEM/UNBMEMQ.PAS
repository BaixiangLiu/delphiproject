unit UNBMEMQ;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, JEdit, Db, DBTables, Menus;

type
  TFMBMEMQ = class(TForm)
    MainMenu1: TMainMenu;
    ESC: TMenuItem;
    ED_BMEM: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    ED_BMENO: TJEdit;
    ED_BMNAM: TJEdit;
    procedure FormActivate(Sender: TObject);
    procedure ESCClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ED_BMENOKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ED_BMNAMKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMBMEMQ: TFMBMEMQ;

implementation

USES UN_UTL, DB_UTL, MAIND, MAINU;

{$R *.DFM}

procedure TFMBMEMQ.FormActivate(Sender: TObject);
begin
  ED_BMENO.SetFocus;
  ED_BMENO.SelectAll;
end;

procedure TFMBMEMQ.ESCClick(Sender: TObject);
begin
  CLOSE;
end;

procedure TFMBMEMQ.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FMBMEMQ.Release;
end;

procedure TFMBMEMQ.ED_BMENOKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  IF KEY = 13 THEN ED_BMNAM.SetFocus;
  IF KEY = 27 THEN ED_BMEM.Visible := FALSE;
end;

procedure TFMBMEMQ.ED_BMNAMKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
VAR T_BMENO, T_BMNAM : STRING;
begin
  IF KEY = 27 THEN ED_BMEM.Visible := FALSE;
  IF KEY = 13 THEN
     BEGIN
     T_BMENO := ED_BMENO.TEXT;
     T_BMNAM := ED_BMNAM.TEXT;
  
     //检查是否有输入编号,名称
     IF (T_BMENO = '') THEN
        BEGIN
        ED_BMENO.SetFocus;      EXIT;
        END;
     IF (T_BMNAM = '') THEN
        BEGIN
        ED_BMNAM.SetFocus;      EXIT;
        END;

     //检查重复
     IF TABLECHECK_RE1('BMEM','BMENO',T_BMENO) > 0 THEN
        BEGIN
        SHOWMESSAGE('此编号已经重复使用!');
        ED_BMENO.SetFocus;      EXIT;
        END;

     FMMAIND.QINS.SQL.CLEAR;
     FMMAIND.QINS.SQL.Add('INSERT INTO BMEM');
     FMMAIND.QINS.SQL.Add('( BMENO, BMNAM )');
     FMMAIND.QINS.SQL.Add('VALUES');
     FMMAIND.QINS.SQL.Add('( '''+T_BMENO+''','''+T_BMNAM+''')');
     FMMAIND.QINS.ExecSQL;
  
     CLOSE;
     END;
end;

procedure TFMBMEMQ.FormCreate(Sender: TObject);
begin
  ED_BMENO.TEXT   := TABLEFINDMAXENO('BMEM','BMENO');
  ED_BMENO.TEXT   := STR_INC('0', ED_BMENO.TEXT, 0, 10, 1);
end;

end.
