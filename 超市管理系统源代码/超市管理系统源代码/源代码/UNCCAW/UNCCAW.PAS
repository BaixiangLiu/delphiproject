unit UNCCAW;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, Grids, DBGrids, Gauges, ComCtrls, StdCtrls, JLOOKUP,
  Buttons, Spin;

type
  TFMCCAW = class(TForm)
    PageControl1: TPageControl;
    PAGE_A: TTabSheet;
    PAGE_B: TTabSheet;
    DBGRID_BMEM: TDBGrid;
    Gauge: TGauge;
    DBGRID_CCAW: TDBGrid;
    Label1: TLabel;
    ED_BMENO: JLOOKUPBOX;
    LB_INSERT: TLabel;
    BTNRUN: TBitBtn;
    LB_CCAWCNT: TLabel;
    BTNRANDOM: TBitBtn;
    ED_MAX: TSpinEdit;
    LB_RANDOM: TStaticText;
    ED_MAXCNT: TSpinEdit;
    Label2: TLabel;
    Label3: TLabel;
    Gauge1: TGauge;
    BitBtn2: TBitBtn;
    procedure DBGRID_BMEMDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure DBGRID_CCAWDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure ED_BMENOKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BTNRUNClick(Sender: TObject);
    procedure BTNRANDOMClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
    FUNCTION ADD_TO_CCAW(T_BMENO:STRING):BOOLEAN;
  public
    { Public declarations }
  end;

var
  FMCCAW: TFMCCAW;

implementation

USES SYSINI, FM_UTL, UN_UTL, UNCCAWD, MAIND;

{$R *.DFM}


procedure TFMCCAW.FormCreate(Sender: TObject);
begin
  IF FormExists('FMCCAWD' )=FALSE THEN Application.CreateForm(TFMCCAWD, FMCCAWD);
  FMCCAWD.QBMEM.Close;
  FMCCAWD.QBMEM.Open;

  FMCCAWD.QCCAW.Close;
  FMCCAWD.QCCAW.Open;
end;

procedure TFMCCAW.FormActivate(Sender: TObject);
begin
  PAGE_A.SHOW;
end;

procedure TFMCCAW.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FMCCAWD.Free;
  FMCCAW.Release;
end;


procedure TFMCCAW.DBGRID_BMEMDblClick(Sender: TObject);
begin
  LB_INSERT.Caption := '';
  IF ADD_TO_CCAW(DBGRID_BMEM.DataSource.DataSet.FieldByName('BMENO').AsString) THEN
     LB_INSERT.Caption := '加入成功!';
end;

procedure TFMCCAW.ED_BMENOKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  LB_INSERT.Caption := '';
  IF KEY = 13 THEN
     BEGIN
     IF ADD_TO_CCAW(ED_BMENO.TEXT) THEN  LB_INSERT.Caption := '加入成功!';
     END;
end;

procedure TFMCCAW.DBGRID_CCAWDrawColumnCell(Sender: TObject; const Rect: TRect;  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  GRID_DRAWCOLUMNCELL(Sender, Rect, DataCol, Column, State,True_bmp, False_bmp, Blank_bmp);
end;

FUNCTION TFMCCAW.ADD_TO_CCAW(T_BMENO:STRING):BOOLEAN;
BEGIN
  FMMAIND.QINS.SQL.Clear;
  FMMAIND.QINS.SQL.ADD('SELECT * FROM CCAW');
  FMMAIND.QINS.SQL.ADD('WHERE BMENO = '''+T_BMENO+'''');
  FMMAIND.QINS.CLOSE;
  FMMAIND.QINS.OPEN;
  
  RESULT := FALSE;
  IF FMMAIND.QINS.Eof = TRUE THEN
     BEGIN
     FMMAIND.QINS.SQL.Clear;
     FMMAIND.QINS.SQL.ADD('INSERT INTO CCAW');
     FMMAIND.QINS.SQL.ADD('( BMENO, CWGET, CWGDS )');
     FMMAIND.QINS.SQL.ADD('VALUES');
     FMMAIND.QINS.SQL.ADD('('''+T_BMENO+''', 0 '+ ', '' '')');
     FMMAIND.QINS.ExecSQL;
     RESULT := TRUE;
     END;
  
  FMCCAWD.QCCAW.Close;
  FMCCAWD.QCCAW.Open;
END;



procedure TFMCCAW.BTNRUNClick(Sender: TObject);
VAR T_NO , T_TOTAL , N : INTEGER;
    T_BMENO , T_BMNAM: STRING;
begin
  T_TOTAL := FMCCAWD.QCCAW.RecordCount;
  T_NO    := RANDOM(FMCCAWD.QCCAW.RecordCount);
  
  Gauge.MaxValue := T_TOTAL; Gauge.Progress := 0;
  FMCCAWD.QCCAW.First;
  FOR N := 0 TO T_NO DO
     BEGIN
     IF FMCCAWD.QCCAW.Eof = TRUE THEN FMCCAWD.QCCAW.First;
     FMCCAWD.QCCAW.Next; Gauge.AddProgress(1);
     END;

  T_BMENO := DBGRID_CCAW.DataSource.DataSet.FieldByName('BMENO').AsString;
  T_BMNAM := DBGRID_CCAW.DataSource.DataSet.FieldByName('BMNAM').AsString;

  FMMAIND.QINS.SQL.Clear;
  FMMAIND.QINS.SQL.ADD('UPDATE CCAW');
  FMMAIND.QINS.SQL.ADD('SET');
  FMMAIND.QINS.SQL.ADD('CWGET = 1 ');
  FMMAIND.QINS.SQL.ADD('WHERE BMENO = '''+T_BMENO+'''');
  FMMAIND.QINS.ExecSQL;

  FMCCAWD.QCCAW.Close;
  FMCCAWD.QCCAW.Open;

  //算中奖人的数量
  T_NO := 0;
  FMCCAWD.QCCAW.First;  Gauge.Progress := 0;
  WHILE NOT FMCCAWD.QCCAW.EOF DO
     BEGIN
     IF DBGRID_CCAW.DataSource.DataSet.FieldByName('CWGET').AsBoolean = TRUE THEN
        INC(T_NO);
     FMCCAWD.QCCAW.Next; Gauge.AddProgress(1);
     END;


  //跑到中奖人的位置
  FMCCAWD.QCCAW.First;  Gauge.Progress := 0;
  WHILE NOT FMCCAWD.QCCAW.EOF DO
     BEGIN
     IF T_BMENO = DBGRID_CCAW.DataSource.DataSet.FieldByName('BMENO').AsString THEN BREAK;
     FMCCAWD.QCCAW.Next; Gauge.AddProgress(1);
     END;

  Gauge.Progress := Gauge.MaxValue;
  LB_CCAWCNT.Caption := '共有 '+INTTOSTR(T_NO)+' 人中奖!';

  SHOWMESSAGE('恭喜 '+T_BMNAM+' 获奖!');
end;

procedure TFMCCAW.BitBtn2Click(Sender: TObject);
begin
  FMMAIND.QINS.SQL.Clear;
  FMMAIND.QINS.SQL.ADD('DELETE FROM CCAW');
  FMMAIND.QINS.ExecSQL;

  FMCCAWD.QCCAW.Close;
  FMCCAWD.QCCAW.Open;
end;


procedure TFMCCAW.BTNRANDOMClick(Sender: TObject);
VAR T_NO , N : INTEGER;
begin
  Gauge1.MaxValue := ED_MAXCNT.Value;
  FOR N := 0 TO ED_MAXCNT.Value DO
      BEGIN
      Gauge1.Progress := N;
      T_NO := RANDOM(ED_MAX.Value);
      LB_RANDOM.Caption := INTTOSTR(T_NO);
      END;
end;



end.
