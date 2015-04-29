unit SYSPSW;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBTables, Db, DBCtrls, StdCtrls, Buttons, ComCtrls, ToolWin, Mask, Grids,
  DBGrids, JLOOKUPD, JEdit;

type
  TFMPSW = class(TForm)
    QSYSPSW: TQuery;
    DSSYSPSW: TDataSource;
    DBGrid1: TDBGrid;
    QSYSPSWBNENO: TStringField;
    QSYSPSWPSWPSW: TStringField;
    QSYSPSWPSWPSM: TDateTimeField;
    QSYSPSWPSWLOG: TDateTimeField;
    QSYSPSWPSWPSW2: TStringField;
    ToolBar: TToolBar;
    ToolButton1: TToolButton;
    BTNINS: TSpeedButton;
    BTNUPD: TSpeedButton;
    BTNDEL: TSpeedButton;
    BTNYES: TSpeedButton;
    BTNCAL: TSpeedButton;
    BTNQUT: TSpeedButton;
    USYSPSW: TUpdateSQL;
    PSWPSW: TEdit;
    QBMAN: TQuery;
    QBMANBNENO: TStringField;
    QBMANBNNAM: TStringField;
    QSYSPSWBNNAM: TStringField;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    DSBMAN: TDataSource;
    BNENO: JDBLOOKUPBOX;
    PSWPSM: TJDBEdit;
    PSWLOG: TJDBEdit;
    Label5: TLabel;
    PSWLOM: TJDBEdit;
    QSYSPSWPSWLOM: TStringField;
    procedure QSYSPSWCalcFields(DataSet: TDataSet);
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
    procedure DSSYSPSWDataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
    FORMMODE : STRING;
    procedure BTNMODE;
    procedure INSERTMODE;
    procedure UPDATEMODE;
    procedure NORMALMODE;
  public
    { Public declarations }
  end;

var
  FMPSW: TFMPSW;

implementation

USES SYSINI, UN_UTL, FM_UTL, DB_UTL, MAIND;

{$R *.DFM}

procedure TFMPSW.BTNMODE;
begin

  //一般模式
  BTN_ENABLED_MODE(BTNINS,BTNUPD,BTNDEL,BTNYES,BTNCAL,BTNQUT,BTNQUT,BTNQUT,
                   FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE );
  //新增修改模式
  if (FORMMODE = 'INS' ) or (FORMMODE = 'UPD' ) then
  BTN_ENABLED_MODE(BTNINS,BTNUPD,BTNDEL,BTNYES,BTNCAL,BTNQUT,BTNQUT,BTNQUT,
                   FALSE, FALSE, FALSE, TRUE  ,TRUE  ,FALSE, FALSE, FALSE );
  //一般模式
  if (FORMMODE = 'CAN' ) then
  BTN_ENABLED_MODE(BTNINS,BTNUPD,BTNDEL,BTNYES,BTNCAL,BTNQUT,BTNQUT,BTNQUT,
                   TRUE  ,TRUE  ,TRUE  ,FALSE ,FALSE ,TRUE  ,TRUE  ,TRUE  );

if _SUPER_USER <> TRUE then BTNINS.Enabled := FALSE;
if _SUPER_USER <> TRUE then BTNDEL.Enabled := FALSE;
end;

procedure TFMPSW.INSERTMODE;
begin
FORMMODE := 'INS';
BTNMODE;

DBGrid1.Enabled  := FALSE;


BNENO.Enabled := TRUE;
PSWPSW.Enabled := TRUE;
BNENO.SetFocus;
end;

procedure TFMPSW.UPDATEMODE;
begin
FORMMODE := 'UPD';
BTNMODE;

DBGrid1.Enabled  := FALSE;

BNENO.Enabled := FALSE;
PSWPSW.Enabled := TRUE;
PSWPSW.SetFocus;
end;

procedure TFMPSW.NORMALMODE;
begin
FORMMODE := 'CAN';
BTNMODE;

DBGrid1.Enabled  := TRUE;

BNENO.Enabled := FALSE;
PSWPSW.Enabled := FALSE;
PSWPSM.Enabled := FALSE;
PSWLOG.Enabled := FALSE;
PSWLOM.Enabled := FALSE;
end;



procedure TFMPSW.FormCreate(Sender: TObject);
begin

     //加载按钮图形
     BTN_LOADBMPFILE(BTNINS,BTNUPD,BTNDEL,BTNYES,BTNCAL,BTNQUT,BTNQUT,BTNQUT,
                     INS_TB,UPD_TB,DEL_TB,YES_TB,CAL_TB,SER_TB,PRN_TB,QUT_TB);


     QSYSPSW.SQL.CLEAR;
     QSYSPSW.SQL.ADD('SELECT *  ');
     QSYSPSW.SQL.ADD('FROM SYSPSW ');
     if _SUPER_USER <> TRUE then QSYSPSW.SQL.ADD('WHERE BNENO ='''+_USER_ID+'''');
     QSYSPSW.SQL.ADD('ORDER BY BNENO ');


     USYSPSW.InsertSQL.CLEAR;
     USYSPSW.InsertSQL.Add('INSERT INTO SYSPSW ');
     USYSPSW.InsertSQL.Add(' ( BNENO, PSWPSW, PSWPSM, PSWLOG ) ');
     USYSPSW.InsertSQL.Add('   VALUES ');
     USYSPSW.InsertSQL.Add(' (:BNENO,:PSWPSW,:PSWPSM,:PSWLOG ) ');

     USYSPSW.ModifySQL.CLEAR;
     USYSPSW.ModifySQL.Add('UPDATE SYSPSW ');
     USYSPSW.ModifySQL.Add('SET ');
     USYSPSW.ModifySQL.Add('BNENO  = :BNENO  ,');
     USYSPSW.ModifySQL.Add('PSWPSW = :PSWPSW ,');
     USYSPSW.ModifySQL.Add('PSWPSM = :PSWPSM ,');
     USYSPSW.ModifySQL.Add('PSWLOG = :PSWLOG  ');
     USYSPSW.ModifySQL.Add('WHERE BNENO = :OLD_BNENO');

     USYSPSW.DeleteSQL.CLEAR;
     USYSPSW.DeleteSQL.Add('DELETE FROM SYSPSW ');
     USYSPSW.DeleteSQL.Add('WHERE BNENO = :OLD_BNENO');

     QSYSPSW.CLOSE;
     QSYSPSW.OPEN;

     QBMAN.SQL.CLEAR;
     QBMAN.SQL.Add('SELECT BNENO, BNNAM');
     QBMAN.SQL.Add('FROM BMAN');
     if _SUPER_USER <> TRUE then QBMAN.SQL.ADD('WHERE BNENO ='''+_USER_ID+'''');
     QBMAN.SQL.Add('ORDER BY BNENO');

     QBMAN.CLOSE;
     QBMAN.OPEN;

end;


procedure TFMPSW.FormActivate(Sender: TObject);
begin
NORMALMODE;
end;

procedure TFMPSW.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  //Form 要结束前的询问(系统事件)
  CanClose := True;
  if (FORMMODE = 'INS' ) or (FORMMODE = 'UPD' ) then
    begin
    MessageDlg('请先结束输入模式后再退出!',mtConfirmation,[mbOk],0);
    CanClose := False;
    end;

end;

procedure TFMPSW.BTNINSClick(Sender: TObject);
begin
INSERTMODE;

    QSYSPSW.APPEND;
    QSYSPSWBNENO.VALUE := '';
    QSYSPSWPSWPSW.VALUE := '';
//    QSYSPSWPSWPSM.VALUE := '';
//    QSYSPSWPSWLOG.VALUE := '';


end;

procedure TFMPSW.BTNUPDClick(Sender: TObject);
begin
UPDATEMODE;
QSYSPSW.Edit;
end;

procedure TFMPSW.BTNDELClick(Sender: TObject);
begin
NORMALMODE;

IF BNENO.Text = 'admin' THEN EXIT;

    IF MessageDlg('是否确定要删除此条记录吗?',mtWarning, [mbYes, mbNo], 0) = mrYes then
    BEGIN
      IF MessageDlg('如果您按下确定键此条记录将会被删除',mtWarning, [mbYes, mbNo], 0) = mrYes then
      BEGIN
        QSYSPSW.Delete;
        FM_DB_QUERY_UPDATE(FMMAIND.DATABASE,QSYSPSW);
        NORMALMODE;
      END;
    END;


end;

procedure TFMPSW.BTNYESClick(Sender: TObject);
begin

if (FORMMODE = 'INS' ) then
if TABLECHECK_RE1('SYSPSW','BNENO',BNENO.Text) > 0 THEN
   begin
   SHOWMESSAGE('此编号已经重复使用!');
   EXIT;
   end;


//检查有无值
IF BNENO.Text <> 'admin' THEN
IF (BNENO.FIND_QUERY_IDNO(BNENO.Text) = '') THEN
   BEGIN
   SHOWMESSAGE('员工编号输入错误!');
   EXIT;
   END;

QSYSPSWPSWPSW.AsString := '1'+Encrypt(PSWPSW.Text,1357,2,1)+'1';
QSYSPSWPSWPSM.VALUE    := DATE;


Case MessageDlg('是否确定储存此条记录?',mtConfirmation,[mbYes,mbNo,mbCancel],0) of
 mrYES :begin
        FM_DB_QUERY_POST(FMMAIND.DATABASE,QSYSPSW);

        NORMALMODE;
        QSYSPSW.CLOSE;
        QSYSPSW.OPEN;
        end;
 mrNO  :begin
        QSYSPSW.Cancel;
        NORMALMODE;
        end;

end;

end;

procedure TFMPSW.BTNCALClick(Sender: TObject);
begin

 IF MessageDlg('确定不新增本条记录?',mtConfirmation,[mbYes,mbNo],0)=mrYes Then
    begin
    QSYSPSW.Cancel;
    NORMALMODE;
    end;

end;

procedure TFMPSW.BTNQUTClick(Sender: TObject);
begin
NORMALMODE;
close;
end;

procedure TFMPSW.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FMPSW.RELEASE;
end;


procedure TFMPSW.QSYSPSWCalcFields(DataSet: TDataSet);
var T_STR : STRING;
begin
T_STR := QSYSPSWPSWPSW.asstring;
T_STR := copy( T_STR , 2, LENGTH(T_STR)-2);
QSYSPSWPSWPSW2.AsString := Decrypt(T_STR,1357,2,1);
end;

procedure TFMPSW.DSSYSPSWDataChange(Sender: TObject; Field: TField);
begin
PSWPSW.Text := QSYSPSWPSWPSW2.AsString;
end;

end.
