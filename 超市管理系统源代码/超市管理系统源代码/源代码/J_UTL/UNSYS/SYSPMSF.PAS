unit SYSPMSF;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, ComCtrls, ToolWin, StdCtrls, JLOOKUP;

type
  TFMPMSF = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    LB_CON21: TEdit;
    ToolBar: TToolBar;
    ToolButton1: TToolButton;
    BTNSER: TSpeedButton;
    BTNCLR: TSpeedButton;
    BTNQUT: TSpeedButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    LB_CON11: JLOOKUPBOX;
    procedure FormActivate(Sender: TObject);
    procedure BTNQUTClick(Sender: TObject);
    procedure BTNSERClick(Sender: TObject);
    procedure BTNCLRClick(Sender: TObject);
  private
    { Private declarations }
    procedure Search_data;
  public
    { Public declarations }
    SearchFORMMODE : STRING;
  end;

var
  FMPMSF: TFMPMSF;

implementation

uses sysini, fm_utl, SYSPMS, MAINU;

{$R *.DFM}



procedure TFMPMSF.FormActivate(Sender: TObject);
begin
  LB_CON11.SETFOCUS;

  if SearchFORMMODE = 'SEARCH' then
     begin
     BTNSER.Caption := '&F 查询';
     //加载按钮图形
     BTN_LOADBMPFILE(BTNQUT,BTNQUT,BTNQUT,BTNQUT,BTNQUT,BTNSER,BTNCLR,BTNQUT,
                     INS_TB,UPD_TB,DEL_TB,YES_TB,CAL_TB,SER_TB,DEL_TB,QUT_TB);
     end;
end;

procedure TFMPMSF.BTNQUTClick(Sender: TObject);
begin
CLOSE;
end;

procedure TFMPMSF.BTNSERClick(Sender: TObject);
var RecordCount_Tmp :Integer;
begin

  Search_data;

  RecordCount_Tmp := FMPMS.QSYSPMS.RecordCount;

  IF RecordCount_Tmp <= 0 THEN
    BEGIN
      SHOWMESSAGE('没有此数据');
      LB_CON11.SETFOCUS;
    END ELSE
    BEGIN

    CLOSE;
    END;

end;

procedure TFMPMSF.BTNCLRClick(Sender: TObject);
begin
LB_CON11.Clear;
LB_CON21.Clear;
end;





procedure TFMPMSF.Search_data;
VAR F_NAME : array[1..10] of STRING;
begin

  WITH FMPMS.QSYSPMS DO
  BEGIN
    CLOSE;
    SQL.CLEAR;
    SQL.ADD('SELECT * ');
    SQL.ADD('FROM  SYSPMS');
    SQL.ADD('WHERE BNENO IS NOT NULL');

    F_NAME[1] := 'BNENO';
    F_NAME[2] := 'PMSFUN';

    //字符串查询
    SQL.ADD(FINDFORM_WHEREKEY_STRING(F_NAME[1],LB_CON11.Text,''));
    SQL.ADD(FINDFORM_WHEREKEY_STRING(F_NAME[2],LB_CON21.Text,''));

    //查询 排序    //ORDER BYE=======================================
    SQL.ADD('ORDER BY BNENO, PMSFUN');
//    SQL.ADD(FINDFORM_ORDERBY3(F_NAME[1],F_NAME[2],F_NAME[3],WHEREKEY1.ItemIndex,WHEREKEY2.ItemIndex,WHEREKEY3.ItemIndex));

//    SHOWMESSAGE(SQL.TEXT);
  OPEN;
  END;


end;


end.
