unit UNBMEM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, JEdit, Db, DBTables, Menus;

type
  TFMBMEM = class(TForm)
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
  FMBMEM: TFMBMEM;

implementation

USES UN_UTL, DB_UTL, MAIND, MAINU;

{$R *.DFM}

procedure TFMBMEM.FormActivate(Sender: TObject);
begin
ED_BMENO.SetFocus;
ED_BMENO.SelectAll;
end;

procedure TFMBMEM.ESCClick(Sender: TObject);
begin
CLOSE;
end;

procedure TFMBMEM.FormClose(Sender: TObject; var Action: TCloseAction);
begin
FMBMEM.Release;
end;

procedure TFMBMEM.ED_BMENOKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
IF KEY = 13 THEN ED_BMNAM.SetFocus;
IF KEY = 27 THEN ED_BMEM.Visible := FALSE;

end;

procedure TFMBMEM.ED_BMNAMKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
VAR T_BMENO, T_BMNAM : STRING;
begin
IF KEY = 27 THEN ED_BMEM.Visible := FALSE;
IF KEY = 13 THEN
   BEGIN
   T_BMENO := ED_BMENO.TEXT;
   T_BMNAM := ED_BMNAM.TEXT;

   //检查是否有输入编号,名称
   if (T_BMENO = '') THEN
      begin
      ED_BMENO.SetFocus;      EXIT;
      end;
   if (T_BMNAM = '') THEN
      begin
      ED_BMNAM.SetFocus;      EXIT;
      end;

   //检查重复
   if TABLECHECK_RE1('BMEM','BMENO',T_BMENO) > 0 THEN
      begin
      SHOWMESSAGE('此编号已经重复使用!');
      ED_BMENO.SetFocus;      EXIT;
      end;

   FMMAIND.QINS.SQL.CLEAR;
   FMMAIND.QINS.SQL.Add('INSERT INTO BMEM');
   FMMAIND.QINS.SQL.Add('( BMENO, BMNAM )');
   FMMAIND.QINS.SQL.Add('VALUES');
   FMMAIND.QINS.SQL.Add('( '''+T_BMENO+''','''+T_BMNAM+''')');
   FMMAIND.QINS.ExecSQL;

   CLOSE;
   END;


end;

procedure TFMBMEM.FormCreate(Sender: TObject);
begin
ED_BMENO.TEXT   := TABLEFINDMAXENO('BMEM','BMENO');
ED_BMENO.TEXT   := STR_INC('0', ED_BMENO.TEXT, 0, 10, 1);
end;

end.
