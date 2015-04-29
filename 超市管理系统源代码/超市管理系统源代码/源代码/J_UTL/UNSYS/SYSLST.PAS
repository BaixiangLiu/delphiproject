unit SYSLST;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBTables, Db, Grids, DBGrids, ComCtrls, StdCtrls, Mask, DBCtrls, Buttons,
  ToolWin, Menus, JEdit, ExtCtrls, GIFImage;

type
  TFMLST = class(TForm)
    ToolBar: TToolBar;
    ToolButton1: TToolButton;
    BTNINS: TSpeedButton;
    BTNUPD: TSpeedButton;
    BTNDEL: TSpeedButton;
    BTNYES: TSpeedButton;
    BTNCAL: TSpeedButton;
    BTNPRN: TSpeedButton;
    BTNQUT: TSpeedButton;
    LBTAEID: TLabel;
    LBTAEMRK: TLabel;
    Label2: TLabel;
    StatusBar: TStatusBar;
    DBGrid1: TDBGrid;
    QSYSLST: TQuery;
    DSSYSLST: TDataSource;
    USYSLST: TUpdateSQL;
    QSYSLSTLSTID1: TStringField;
    QSYSLSTLSTID2: TStringField;
    QSYSLSTLSTNAM: TStringField;
    QSYSLSTLSTMRK: TStringField;
    MainMenu1: TMainMenu;
    ABCD1: TMenuItem;
    LSTID2: TJDBEdit;
    LSTNAM: TJDBEdit;
    LSTMRK: TJDBEdit;
    Image2: TImage;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BTNINSClick(Sender: TObject);
    procedure BTNUPDClick(Sender: TObject);
    procedure BTNDELClick(Sender: TObject);
    procedure BTNYESClick(Sender: TObject);
    procedure BTNCALClick(Sender: TObject);
    procedure BTNSERClick(Sender: TObject);
    procedure BTNPRNClick(Sender: TObject);
    procedure BTNQUTClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
    FORMMODE : STRING;
//    CANSAVE:BOOLEAN;
    procedure BTNMODE;
    procedure INSERTMODE;
    procedure UPDATEMODE;
    procedure NORMALMODE;

  public
    { Public declarations }
  end;


var
  FMLST: TFMLST;

implementation

uses UN_UTL, FM_UTL, DB_UTL, SYSLSTP, MAIND, SYSINI;
{$R *.DFM}



procedure TFMLST.BTNMODE;
begin

  //一般模式
  BTN_ENABLED_MODE(BTNINS,BTNUPD,BTNDEL,BTNYES,BTNCAL,BTNPRN,BTNPRN,BTNQUT,
                   FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE );
  //新增修改模式
  if (FORMMODE = 'INS' ) or (FORMMODE = 'UPD' ) then
  BTN_ENABLED_MODE(BTNINS,BTNUPD,BTNDEL,BTNYES,BTNCAL,BTNPRN,BTNPRN,BTNQUT,
                   FALSE, FALSE, FALSE, TRUE  ,TRUE  ,FALSE, FALSE, FALSE );
  //一般模式
  if (FORMMODE = 'CAN' ) then
  BTN_ENABLED_MODE(BTNINS,BTNUPD,BTNDEL,BTNYES,BTNCAL,BTNPRN,BTNPRN,BTNQUT,
                   TRUE  ,TRUE  ,TRUE  ,FALSE ,FALSE ,TRUE  ,TRUE  ,TRUE  );

IF TRIM(LSTID2.Text) = '' THEN
   BEGIN
   BTNUPD.Enabled := FALSE;
   BTNDEL.Enabled := FALSE;
   END;

end;

procedure TFMLST.INSERTMODE;
begin
FORMMODE := 'INS';
BTNMODE;

DBGrid1.Enabled  := FALSE;

LSTID2.Enabled  := TRUE;
LSTNAM.Enabled  := TRUE;
LSTMRK.Enabled  := TRUE;
end;

procedure TFMLST.UPDATEMODE;
begin
FORMMODE := 'UPD';
BTNMODE;

DBGrid1.Enabled  := FALSE;

//LSTID2.Enabled  := TRUE;
LSTNAM.Enabled  := TRUE;
LSTMRK.Enabled  := TRUE;
end;

procedure TFMLST.NORMALMODE;
begin
FORMMODE := 'CAN';
BTNMODE;

LSTID2.Enabled  := FALSE;
LSTNAM.Enabled  := FALSE;
LSTMRK.Enabled  := FALSE;

DBGrid1.Enabled  := TRUE;
DBGrid1.SetFocus;
end;






procedure TFMLST.FormCreate(Sender: TObject);
begin

     //加载按钮图形
     BTN_LOADBMPFILE(BTNINS,BTNUPD,BTNDEL,BTNYES,BTNCAL,BTNPRN,BTNPRN,BTNQUT,
                     INS_TB,UPD_TB,DEL_TB,YES_TB,CAL_TB,SER_TB,PRN_TB,QUT_TB);

     QSYSLST.SQL.CLEAR;
     QSYSLST.SQL.ADD('SELECT *  ');
     QSYSLST.SQL.ADD('FROM SYSLST ');
     QSYSLST.SQL.ADD('WHERE LSTID1 = '''+LIST_STR+'''');
     QSYSLST.SQL.ADD('ORDER BY LSTID1,LSTID2 ');

     USYSLST.InsertSQL.CLEAR;
     USYSLST.InsertSQL.Add('INSERT INTO SYSLST ');
     USYSLST.InsertSQL.Add(' (      LSTID1,     LSTID2, LSTNAM, LSTMRK ) ');
     USYSLST.InsertSQL.Add('   VALUES ');
     USYSLST.InsertSQL.Add(' ('''+LIST_STR+''',:LSTID2,:LSTNAM,:LSTMRK ) ');


     USYSLST.ModifySQL.CLEAR;
     USYSLST.ModifySQL.Add('UPDATE SYSLST ');
     USYSLST.ModifySQL.Add('SET ');
     USYSLST.ModifySQL.Add('LSTID2 = :LSTID2 ,');
     USYSLST.ModifySQL.Add('LSTNAM = :LSTNAM ,');
     USYSLST.ModifySQL.Add('LSTMRK = :LSTMRK  ');
     USYSLST.ModifySQL.Add('WHERE LSTID1 = '''+LIST_STR+'''');
     USYSLST.ModifySQL.Add('  AND LSTID2 = :OLD_LSTID2');

     USYSLST.DeleteSQL.CLEAR;
     USYSLST.DeleteSQL.Add('DELETE FROM SYSLST ');
     USYSLST.DeleteSQL.Add('WHERE LSTID1 = '''+LIST_STR+'''');
     USYSLST.DeleteSQL.Add('  AND LSTID2 = :OLD_LSTID2');

     QSYSLST.CLOSE;
     QSYSLST.OPEN;


end;

procedure TFMLST.FormActivate(Sender: TObject);
begin
NORMALMODE;
end;



procedure TFMLST.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  //Form 要结束前的询问(系统事件)
  CanClose := True;
  if (FORMMODE = 'INS' ) or (FORMMODE = 'UPD' ) then
    begin
    MessageDlg('请先结束输入模式后再退出!',mtConfirmation,[mbOk],0);
    CanClose := False;
    end;

end;



procedure TFMLST.BTNINSClick(Sender: TObject);
begin
INSERTMODE;

    QSYSLST.APPEND;
    QSYSLSTLSTID1.VALUE := LIST_STR ;
    QSYSLSTLSTID2.VALUE := '' ;
    QSYSLSTLSTNAM.VALUE := '' ;
    QSYSLSTLSTMRK.VALUE := ' ' ;
    LSTID2.SetFocus;

end;

procedure TFMLST.BTNUPDClick(Sender: TObject);
begin
UPDATEMODE;
QSYSLST.Edit;
LSTNAM.SetFocus;
end;

procedure TFMLST.BTNDELClick(Sender: TObject);
begin
NORMALMODE;


    IF MessageDlg('是否确定要删除此条记录吗?',mtWarning, [mbYes, mbNo], 0) = mrYes then
    BEGIN
      IF MessageDlg('如果您按下确定键此条记录将会被删除',mtWarning, [mbYes, mbNo], 0) = mrYes then
      BEGIN
        QSYSLST.Delete;

        FM_DB_QUERY_UPDATE(FMMAIND.DATABASE,QSYSLST);

        NORMALMODE;
      END;
    END;

end;

procedure TFMLST.BTNYESClick(Sender: TObject);
begin


if (FORMMODE = 'INS' ) then
   BEGIN

   IF (TRIM(LSTID2.Text) = '' ) OR
      (TRIM(LSTNAM.Text) = '' ) THEN
      BEGIN
      SHOWMESSAGE('编号及名称不能输入空白!');
      EXIT;
      END;

   //删除空白
   QSYSLSTLSTID2.VALUE := TRIM(LSTID2.Text);

   if TABLECHECK_RE2('SYSLST','LSTID1','LSTID2',LIST_STR, LSTID2.Text) > 0 THEN
      begin
      SHOWMESSAGE('此编号已经重复使用!');
      EXIT;
      end;
   END;





Case MessageDlg('是否确定存储此条记录?',mtConfirmation,[mbYes,mbNo,mbCancel],0) of
 mrYES :begin
        FM_DB_QUERY_POST(FMMAIND.DATABASE,QSYSLST);
        NORMALMODE;
        end;
 mrNO  :begin
        NORMALMODE;
        end;
end;


end;

procedure TFMLST.BTNCALClick(Sender: TObject);
begin

 IF MessageDlg('确定不新增本条记录?',mtConfirmation,[mbYes,mbNo],0)=mrYes Then
    begin
    QSYSLST.Cancel;
    NORMALMODE;
    end;

end;

procedure TFMLST.BTNSERClick(Sender: TObject);
begin
NORMALMODE;
end;

procedure TFMLST.BTNPRNClick(Sender: TObject);
begin
NORMALMODE;

IF FormExists('FMLSTP')=FALSE THEN Application.CreateForm(TFMLSTP, FMLSTP );

FMLSTP.LBTITLE.CAPTION := FMLST.Caption;
FMLSTP.LB_RECORDCOUNT.Caption := '共 '+INTTOSTR(QSYSLST.RecordCount)+'条';
FMLSTP.QuickRep.Preview;
end;


procedure TFMLST.BTNQUTClick(Sender: TObject);
begin
NORMALMODE;
close;
end;


procedure TFMLST.FormClose(Sender: TObject; var Action: TCloseAction);
begin
FMLST.RELEASE;
end;

procedure TFMLST.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
StatusBar.Panels.Items[0].Text := '共 '+INTTOSTR(QSYSLST.RecordCount)+'条';
end;


end.
