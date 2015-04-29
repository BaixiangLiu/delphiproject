unit SYSPMS;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBTables, Db, StdCtrls, DBCtrls, Buttons, ComCtrls, ToolWin, Mask, Grids,
  DBGrids, JLOOKUPD, Gauges;

type
  TFMPMS = class(TForm)
    QSYSPMS: TQuery;
    DSSYSPMS: TDataSource;
    USYSPMS: TUpdateSQL;
    QBMAN: TQuery;
    QBMANBNENO: TStringField;
    QBMANBNNAM: TStringField;
    DSBMAN: TDataSource;
    QSYSPMSBNENO: TStringField;
    QSYSPMSPMSFUN: TStringField;
    QSYSPMSPMSNAM: TStringField;
    QSYSPMSPMSPMS: TBooleanField;
    QPMSFUN: TQuery;
    QPMSFUNLSTID1: TStringField;
    QPMSFUNLSTID2: TStringField;
    QPMSFUNLSTNAM: TStringField;
    QPMSFUNLSTMRK: TStringField;
    QSYSPMS_PMSFUN: TStringField;
    QSYSPMS_BNNAM: TStringField;
    Page: TPageControl;
    PAGE_A: TTabSheet;
    PAGE_B: TTabSheet;
    Label1: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    DBGrid1: TDBGrid;
    ToolBar: TToolBar;
    ToolButton1: TToolButton;
    BTNINS: TSpeedButton;
    BTNUPD: TSpeedButton;
    BTNDEL: TSpeedButton;
    BTNYES: TSpeedButton;
    BTNCAL: TSpeedButton;
    BTNSER: TSpeedButton;
    BTNQUT: TSpeedButton;
    PMSPMS: TDBCheckBox;
    PMSFUN: JDBLOOKUPBOX;
    BNENO: JDBLOOKUPBOX;
    DBGRID_BMAN: TDBGrid;
    DBGrid2: TDBGrid;
    QSYSPMSLST: TQuery;
    DSSYSPMSLST: TDataSource;
    GRID_SYSLST: TDBGrid;
    QSYSPMSLSTLSTID1: TStringField;
    QSYSPMSLSTLSTID2: TStringField;
    QSYSPMSLSTLSTNAM: TStringField;
    QSYSPMSLSTLSTMRK: TStringField;
    Label4: TLabel;
    BTNPMS: TBitBtn;
    Label8: TLabel;
    Gauge: TGauge;
    BTNPMSA: TBitBtn;
    BTNPMSD: TBitBtn;
    QALLPMS: TQuery;
    StringField1: TStringField;
    StringField2: TStringField;
    StringField3: TStringField;
    StringField4: TStringField;
    BTNPMSC: TBitBtn;
    procedure FormActivate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure BTNINSClick(Sender: TObject);
    procedure BTNUPDClick(Sender: TObject);
    procedure BTNDELClick(Sender: TObject);
    procedure BTNYESClick(Sender: TObject);
    procedure BTNCALClick(Sender: TObject);
    procedure BTNQUTClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure BTNSERClick(Sender: TObject);
    procedure BNENOKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGRID_BMANCellClick(Column: TColumn);
    procedure PageChange(Sender: TObject);
    procedure BTNPMSClick(Sender: TObject);
    procedure BTNPMSAClick(Sender: TObject);
    procedure BTNPMSDClick(Sender: TObject);
    procedure BTNPMSCClick(Sender: TObject);
  private
    { Private declarations }
    T_BNENO : STRING;

    FORMMODE : STRING;
    procedure BTNMODE;
    procedure INSERTMODE;
    procedure UPDATEMODE;
    procedure NORMALMODE;
  public
    { Public declarations }
  end;

var
  FMPMS: TFMPMS;

implementation

USES SYSINI, UN_UTL, FM_UTL, DB_UTL, MAIND, MAINU, SYSPMSF;

{$R *.DFM}

procedure TFMPMS.BTNMODE;
begin

  //一般模式
  BTN_ENABLED_MODE(BTNINS,BTNUPD,BTNDEL,BTNYES,BTNCAL,BTNSER,BTNQUT,BTNQUT,
                   FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE );
  //新增修改模式
  if (FORMMODE = 'INS' ) or (FORMMODE = 'UPD' ) then
  BTN_ENABLED_MODE(BTNINS,BTNUPD,BTNDEL,BTNYES,BTNCAL,BTNSER,BTNQUT,BTNQUT,
                   FALSE, FALSE, FALSE, TRUE  ,TRUE  ,FALSE, FALSE, FALSE );
  //一般模式
  if (FORMMODE = 'CAN' ) then
  BTN_ENABLED_MODE(BTNINS,BTNUPD,BTNDEL,BTNYES,BTNCAL,BTNSER,BTNQUT,BTNQUT,
                   TRUE  ,TRUE  ,TRUE  ,FALSE ,FALSE ,TRUE  ,TRUE  ,TRUE  );

IF TRIM(BNENO.Text) = '' THEN
   BEGIN
   BTNUPD.Enabled := FALSE;
   BTNDEL.Enabled := FALSE;
   END;


end;

procedure TFMPMS.INSERTMODE;
begin
FORMMODE := 'INS';
BTNMODE;

DBGrid1.Enabled  := FALSE;


BNENO.Enabled := TRUE;
//BNNAM.Enabled := TRUE;
PMSFUN.Enabled := TRUE;
//PMSNAM.Enabled := TRUE;
PMSPMS.Enabled := TRUE;

BNENO.SetFocus;
end;

procedure TFMPMS.UPDATEMODE;
begin
FORMMODE := 'UPD';
BTNMODE;

DBGrid1.Enabled  := FALSE;

BNENO.Enabled := FALSE;
//BNNAM.Enabled := FALSE;
//PMSFUN.Enabled := TRUE;
//PMSNAM.Enabled := TRUE;
PMSPMS.Enabled := TRUE;
PMSPMS.SetFocus;
end;

procedure TFMPMS.NORMALMODE;
begin
FORMMODE := 'CAN';
BTNMODE;

DBGrid1.Enabled  := TRUE;

BNENO.Enabled := FALSE;
//BNNAM.Enabled := FALSE;
PMSFUN.Enabled := FALSE;
//PMSNAM.Enabled := FALSE;
PMSPMS.Enabled := FALSE;
end;



procedure TFMPMS.FormCreate(Sender: TObject);
begin

     //加载按钮图形
     BTN_LOADBMPFILE(BTNINS,BTNUPD,BTNDEL,BTNYES,BTNCAL,BTNSER,BTNQUT,BTNQUT,
                     INS_TB,UPD_TB,DEL_TB,YES_TB,CAL_TB,SER_TB,PRN_TB,QUT_TB);


     QSYSPMS.SQL.CLEAR;
     QSYSPMS.SQL.ADD('SELECT *  ');
     QSYSPMS.SQL.ADD('FROM SYSPMS ');
     QSYSPMS.SQL.ADD('ORDER BY BNENO, PMSFUN ');


     USYSPMS.InsertSQL.CLEAR;
     USYSPMS.InsertSQL.Add('INSERT INTO SYSPMS ');
     USYSPMS.InsertSQL.Add(' ( BNENO, PMSFUN, PMSPMS ) ');
     USYSPMS.InsertSQL.Add('   VALUES ');
     USYSPMS.InsertSQL.Add(' (:BNENO,:PMSFUN,:PMSPMS ) ');

     USYSPMS.ModifySQL.CLEAR;
     USYSPMS.ModifySQL.Add('UPDATE SYSPMS ');
     USYSPMS.ModifySQL.Add('SET ');
     USYSPMS.ModifySQL.Add('BNENO  = :BNENO  ,');
     USYSPMS.ModifySQL.Add('PMSFUN = :PMSFUN ,');
     USYSPMS.ModifySQL.Add('PMSPMS = :PMSPMS  ');
     USYSPMS.ModifySQL.Add('WHERE BNENO  = :OLD_BNENO');
     USYSPMS.ModifySQL.Add('  AND PMSFUN = :OLD_PMSFUN');

     USYSPMS.DeleteSQL.CLEAR;
     USYSPMS.DeleteSQL.Add('DELETE FROM SYSPMS ');
     USYSPMS.DeleteSQL.Add('WHERE BNENO  = :OLD_BNENO');
     USYSPMS.DeleteSQL.Add('  AND PMSFUN = :OLD_PMSFUN');

//     QSYSPMS.CLOSE;
//     QSYSPMS.OPEN;

     QBMAN.CLOSE;
     QBMAN.OPEN;

     QSYSPMSLST.SQL.CLEAR;
     QSYSPMSLST.SQL.ADD('SELECT *  ');
     QSYSPMSLST.SQL.ADD('FROM SYSLST ');
     QSYSPMSLST.SQL.ADD('WHERE LSTMRK = ''''');
     QSYSPMSLST.SQL.ADD('  AND LSTID1 = ''SYSPMS''');
     QSYSPMSLST.SQL.ADD('ORDER BY LSTNAM ');
     QSYSPMSLST.CLOSE;
     QSYSPMSLST.OPEN;

end;


procedure TFMPMS.FormActivate(Sender: TObject);
begin
NORMALMODE;
BNENO .Change;
PMSFUN.Change;
end;

procedure TFMPMS.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  //Form 要结束前的询问(系统事件)
  CanClose := True;
  if (FORMMODE = 'INS' ) or (FORMMODE = 'UPD' ) then
    begin
    MessageDlg('请先结束输入模式后再退出!',mtConfirmation,[mbOk],0);
    CanClose := False;
    end;

end;

procedure TFMPMS.BTNINSClick(Sender: TObject);
begin
INSERTMODE;

    QSYSPMS.APPEND;

    QSYSPMSBNENO.VALUE  := '';
    QSYSPMSPMSFUN.VALUE := '';
    QSYSPMSPMSPMS.VALUE := TRUE;

   IF T_BNENO <> '' THEN  QSYSPMSBNENO.VALUE  := T_BNENO;
end;

procedure TFMPMS.BTNUPDClick(Sender: TObject);
begin
UPDATEMODE;
QSYSPMS.Edit;
end;

procedure TFMPMS.BTNDELClick(Sender: TObject);
begin
NORMALMODE;


    IF MessageDlg('是否确定要删除此条记录吗?',mtWarning, [mbYes, mbNo], 0) = mrYes then
    BEGIN
      IF MessageDlg('如果您按下确定键此条记录将会被删除',mtWarning, [mbYes, mbNo], 0) = mrYes then
      BEGIN
        QSYSPMS.Delete;
        FMMAIND.Database.STARTTRANSACTION;
          try
            QSYSPMS.ApplyUpdates;
            QSYSPMS.CommitUpdates;
            FMMAIND.Database.COMMIT;
          except
            FMMAIND.Database.ROLLBACK;
            SHOWMESSAGE('删除失败!');
            QSYSPMS.CANCELUpdates;
          END;
        NORMALMODE;
      END;
    END;


end;

procedure TFMPMS.BTNYESClick(Sender: TObject);
begin
T_BNENO:= QSYSPMSBNENO.VALUE;


if (FORMMODE = 'INS' ) then
if TABLECHECK_RE2('SYSPMS','BNENO','PMSFUN',BNENO.Text,PMSFUN.TEXT) > 0 THEN
   begin
   SHOWMESSAGE('此编号已经重复使用!');
   EXIT;
   end;



   //检查有无值
   IF (BNENO.FIND_QUERY_IDNO(BNENO.Text)   = '') THEN
      BEGIN
      SHOWMESSAGE('员工编号输入错误!');
      EXIT;
      END;

   //检查有无值
   IF (PMSFUN.FIND_QUERY_IDNO(PMSFUN.Text) = '') THEN
      BEGIN
      SHOWMESSAGE('使用功能输入错误!');
      EXIT;
      END;




Case MessageDlg('是否确定储存此条记录?',mtConfirmation,[mbYes,mbNo,mbCancel],0) of
 mrYES :begin
        NORMALMODE;
        try
          FMMAIND.DATABASE.STARTTRANSACTION;
          QSYSPMS.Post;
          QSYSPMS.ApplyUpdates;
          QSYSPMS.CommitUpdates;
          FMMAIND.DATABASE.COMMIT;
        except
          FMMAIND.DATABASE.ROLLBACK;
          QSYSPMS.CANCELUpdates;
          SHOWMESSAGE('存盘失败!');
        end;
        end;
 mrNO  :begin
        QSYSPMS.Cancel;
        NORMALMODE;
        end;

end;

end;

procedure TFMPMS.BTNCALClick(Sender: TObject);
begin

 IF MessageDlg('确定不新增本条记录?',mtConfirmation,[mbYes,mbNo],0)=mrYes Then
    begin
    QSYSPMS.Cancel;
    NORMALMODE;
    end;

end;

procedure TFMPMS.BTNQUTClick(Sender: TObject);
begin
NORMALMODE;
close;
end;

procedure TFMPMS.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FMPMS.RELEASE;
  FMPMSF.RELEASE;

end;






procedure TFMPMS.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
GRID_DRAWCOLUMNCELL(Sender, Rect, DataCol, Column, State,True_bmp, False_bmp, Blank_bmp);
end;


procedure TFMPMS.BTNSERClick(Sender: TObject);
begin
NORMALMODE;
FMPMSF.SearchFORMMODE  := 'SEARCH';
FMPMSF.Caption := '查询';
FMPMSF.SHOWMODAL;
end;

procedure TFMPMS.BNENOKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
IF (KEY = 13) AND (SENDER = BNENO  ) THEN PMSFUN.SetFocus;
IF (KEY = 13) AND (SENDER = PMSFUN ) THEN BNENO .SetFocus;

IF (KEY = 13) AND (SENDER = BNENO  ) THEN PMSFUN.SelectAll;
IF (KEY = 13) AND (SENDER = PMSFUN ) THEN BNENO .SelectAll;
end;

procedure TFMPMS.DBGrid1DblClick(Sender: TObject);
begin

IF QSYSPMSPMSPMS.VALUE = FALSE THEN
   BEGIN
   QSYSPMS.Edit;
   QSYSPMSPMSPMS.VALUE := TRUE;
   FM_DB_QUERY_POST(FMMAIND.DATABASE,QSYSPMS);
   END ELSE BEGIN
   QSYSPMS.Edit;
   QSYSPMSPMSPMS.VALUE := FALSE;
   FM_DB_QUERY_POST(FMMAIND.DATABASE,QSYSPMS);
   END;

end;

procedure TFMPMS.DBGRID_BMANCellClick(Column: TColumn);
begin

     QSYSPMS.SQL.CLEAR;
     QSYSPMS.SQL.ADD('SELECT * FROM SYSPMS, SYSLST');
     QSYSPMS.SQL.ADD('WHERE PMSFUN = LSTID2 ');
     QSYSPMS.SQL.ADD('  AND BNENO  =    '''+QBMAN     .FieldByName('BNENO') .AsString+'''');
     QSYSPMS.SQL.ADD('  AND PMSFUN LIKE '''+QSYSPMSLST.FieldByName('LSTID2').AsString+'%''');
     QSYSPMS.SQL.ADD('ORDER BY LSTNAM, PMSFUN ');
     QSYSPMS.CLOSE;
     QSYSPMS.OPEN;
     
end;

procedure TFMPMS.PageChange(Sender: TObject);
begin
CASE Page.ActivePage.TabIndex OF
 0 : BEGIN
     QSYSPMS.CLOSE;
     NORMALMODE;
     END;
 1 : BEGIN
     QSYSPMS.SQL.CLEAR;
     QSYSPMS.SQL.ADD('SELECT *  ');
     QSYSPMS.SQL.ADD('FROM SYSPMS ');
     QSYSPMS.SQL.ADD('WHERE BNENO  =    '''+QBMAN     .FieldByName('BNENO') .AsString+'''');
     QSYSPMS.SQL.ADD('ORDER BY BNENO, PMSFUN ');
     QSYSPMS.CLOSE;
     QSYSPMS.OPEN;
     NORMALMODE;
     END;
END;

end;

procedure TFMPMS.BTNPMSClick(Sender: TObject);
begin
QALLPMS.SQL.CLEAR;
QALLPMS.SQL.ADD('SELECT *  ');
QALLPMS.SQL.ADD('FROM SYSLST ');
QALLPMS.SQL.ADD('WHERE LSTID1 = ''SYSPMS''');
QALLPMS.CLOSE;
QALLPMS.OPEN;

Gauge.Progress := 0;
Gauge.MaxValue := QSYSPMSLST.RecordCount;

QALLPMS.First;
WHILE NOT QALLPMS.EOF DO
  BEGIN
  PERMISSION_CHECK_EXIST(QBMAN.FieldByName('BNENO').AsString,QALLPMS.FieldByName('LSTID2').AsString,'');
  QALLPMS.NEXT;
  Gauge.AddProgress(1);
  END;

Gauge.Progress := 0;

QSYSPMS.CLOSE;
QSYSPMS.OPEN;

SHOWMESSAGE('产生完成!');
end;

procedure TFMPMS.BTNPMSCClick(Sender: TObject);
begin
FMMAIND.QUPD.SQL.Clear;
FMMAIND.QUPD.SQL.ADD('DELETE FROM SYSPMS');
FMMAIND.QUPD.SQL.ADD('WHERE BNENO = '''+QBMAN.FieldByName('BNENO').AsString+'''');
FMMAIND.QUPD.EXECSQL;
end;

procedure TFMPMS.BTNPMSAClick(Sender: TObject);
begin
FMMAIND.QUPD.SQL.Clear;
FMMAIND.QUPD.SQL.ADD('UPDATE SYSPMS');
FMMAIND.QUPD.SQL.ADD('SET');
FMMAIND.QUPD.SQL.ADD('PMSPMS = 1');
FMMAIND.QUPD.SQL.ADD('WHERE BNENO = '''+QBMAN.FieldByName('BNENO').AsString+'''');
FMMAIND.QUPD.EXECSQL;
end;

procedure TFMPMS.BTNPMSDClick(Sender: TObject);
begin
FMMAIND.QUPD.SQL.Clear;
FMMAIND.QUPD.SQL.ADD('UPDATE SYSPMS');
FMMAIND.QUPD.SQL.ADD('SET');
FMMAIND.QUPD.SQL.ADD('PMSPMS = 0');
FMMAIND.QUPD.SQL.ADD('WHERE BNENO = '''+QBMAN.FieldByName('BNENO').AsString+'''');
FMMAIND.QUPD.EXECSQL;
end;


end.
