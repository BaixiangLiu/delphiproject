unit SELOOKUPL;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBTables, Db, Grids, DBGrids, ComCtrls, StdCtrls, Mask, DBCtrls, Buttons,
  ToolWin, Menus, JEdit, ExtCtrls;

type
  TFMSELOOKUPL = class(TForm)
    LBTAEID: TLabel;
    LBTAEMRK: TLabel;
    Label2: TLabel;
    DBGrid1: TDBGrid;
    QSYSLST: TQuery;
    DSSYSLST: TDataSource;
    USYSLST: TUpdateSQL;
    LSTITM: TDBEdit;
    LSTNAM: TDBEdit;
    LSTMRK: TDBEdit;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    QSYSLSTLSTENO: TStringField;
    QSYSLSTLSTITM: TStringField;
    QSYSLSTLSTNAM: TStringField;
    QSYSLSTLSTMRK: TStringField;
    BTNINS: TSpeedButton;
    BTNUPD: TSpeedButton;
    BTNDEL: TSpeedButton;
    BTNYES: TSpeedButton;
    BTNCAL: TSpeedButton;
    BTNQUT: TSpeedButton;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BTNINSClick(Sender: TObject);
    procedure BTNUPDClick(Sender: TObject);
    procedure BTNDELClick(Sender: TObject);
    procedure BTNYESClick(Sender: TObject);
    procedure BTNCALClick(Sender: TObject);
    procedure BTNSERClick(Sender: TObject);
    procedure BTNQUTClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure N1Click(Sender: TObject);
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
    LIST_STR : STRING;
  end;


var
  FMSELOOKUPL: TFMSELOOKUPL;

implementation

uses UN_UTL, FM_UTL, DB_UTL;
{$R *.DFM}



procedure TFMSELOOKUPL.BTNMODE;
begin
  //一般模式
     BTNINS.Enabled := FALSE;
     BTNUPD.Enabled := FALSE;
     BTNDEL.Enabled := FALSE;
     BTNYES.Enabled := FALSE;
     BTNCAL.Enabled := FALSE;
     BTNQUT.Enabled := FALSE;
  //新增修改模式
  if (FORMMODE = 'INS' ) or (FORMMODE = 'UPD' ) then
     BEGIN
     BTNINS.Enabled := FALSE;
     BTNUPD.Enabled := FALSE;
     BTNDEL.Enabled := FALSE;
     BTNYES.Enabled := TRUE;
     BTNCAL.Enabled := TRUE;
     BTNQUT.Enabled := FALSE;
     END;
  //一般模式
  if (FORMMODE = 'CAN' ) then
     BEGIN
     BTNINS.Enabled := TRUE;
     BTNUPD.Enabled := TRUE;
     BTNDEL.Enabled := TRUE;
     BTNYES.Enabled := FALSE;
     BTNCAL.Enabled := FALSE;
     BTNQUT.Enabled := TRUE;
     END;

IF TRIM(LSTITM.Text) = '' THEN
   BEGIN
   BTNUPD.Enabled := FALSE;
   BTNDEL.Enabled := FALSE;
   END;

end;

procedure TFMSELOOKUPL.INSERTMODE;
begin
FORMMODE := 'INS';
BTNMODE;

DBGrid1.Enabled  := FALSE;

LSTITM.Enabled  := TRUE;
LSTNAM.Enabled  := TRUE;
LSTMRK.Enabled  := TRUE;
end;

procedure TFMSELOOKUPL.UPDATEMODE;
begin
FORMMODE := 'UPD';
BTNMODE;

DBGrid1.Enabled  := FALSE;

//LSTITM.Enabled  := TRUE;
LSTNAM.Enabled  := TRUE;
LSTMRK.Enabled  := TRUE;
end;

procedure TFMSELOOKUPL.NORMALMODE;
begin
FORMMODE := 'CAN';
BTNMODE;

LSTITM.Enabled  := FALSE;
LSTNAM.Enabled  := FALSE;
LSTMRK.Enabled  := FALSE;

DBGrid1.Enabled  := TRUE;
DBGrid1.SetFocus;
end;






procedure TFMSELOOKUPL.FormCreate(Sender: TObject);
begin
//


end;

procedure TFMSELOOKUPL.FormActivate(Sender: TObject);
begin
     QSYSLST.SQL.CLEAR;
     QSYSLST.SQL.ADD('SELECT * FROM SYSLST ');
     QSYSLST.SQL.ADD('WHERE LSTENO = '''+LIST_STR+'''');
     QSYSLST.SQL.ADD('ORDER BY LSTENO,LSTITM ');

     USYSLST.InsertSQL.CLEAR;
     USYSLST.InsertSQL.Add('INSERT INTO SYSLST ');
     USYSLST.InsertSQL.Add(' (       LSTENO,    LSTITM, LSTNAM, LSTMRK ) ');
     USYSLST.InsertSQL.Add('   VALUES ');
     USYSLST.InsertSQL.Add(' ('''+LIST_STR+''',:LSTITM,:LSTNAM,:LSTMRK ) ');

     USYSLST.ModifySQL.CLEAR;
     USYSLST.ModifySQL.Add('UPDATE SYSLST ');
     USYSLST.ModifySQL.Add('SET ');
     USYSLST.ModifySQL.Add('LSTITM = :LSTITM ,');
     USYSLST.ModifySQL.Add('LSTNAM = :LSTNAM ,');
     USYSLST.ModifySQL.Add('LSTMRK = :LSTMRK  ');
     USYSLST.ModifySQL.Add('WHERE LSTENO = '''+LIST_STR+'''');
     USYSLST.ModifySQL.Add('  AND LSTITM = :OLD_LSTITM');

     USYSLST.DeleteSQL.CLEAR;
     USYSLST.DeleteSQL.Add('DELETE FROM SYSLST ');
     USYSLST.DeleteSQL.Add('WHERE LSTENO = '''+LIST_STR+'''');
     USYSLST.DeleteSQL.Add('  AND LSTITM = :OLD_LSTITM');

     QSYSLST.CLOSE;
     QSYSLST.OPEN;

NORMALMODE;
end;



procedure TFMSELOOKUPL.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  //Form 要结束前的询问(系统事件)
  CanClose := True;
  if (FORMMODE = 'INS' ) or (FORMMODE = 'UPD' ) then
    begin
    MessageDlg('请先结束输入模式后再退出!',mtConfirmation,[mbOk],0);
    CanClose := False;
    end;

end;



procedure TFMSELOOKUPL.BTNINSClick(Sender: TObject);
begin
INSERTMODE;
    QSYSLST.APPEND;
    QSYSLSTLSTENO.VALUE := LIST_STR ;
    QSYSLSTLSTITM.VALUE := '' ;
    QSYSLSTLSTNAM.VALUE := '' ;
    QSYSLSTLSTMRK.VALUE := '' ;
    LSTITM.SetFocus;
end;

procedure TFMSELOOKUPL.BTNUPDClick(Sender: TObject);
begin
UPDATEMODE;
QSYSLST.Edit;
LSTNAM.SetFocus;
end;

procedure TFMSELOOKUPL.BTNDELClick(Sender: TObject);
begin
NORMALMODE;


    IF MessageDlg('是否确定要删除此条记录吗?',mtWarning, [mbYes, mbNo], 0) = mrYes then
    BEGIN
      IF MessageDlg('如果您按下确定按钮此条记录将会被删除',mtWarning, [mbYes, mbNo], 0) = mrYes then
      BEGIN
        QSYSLST.Delete;

        try
        QSYSLST.Database.STARTTRANSACTION;
        QSYSLST.ApplyUpdates;
        QSYSLST.CommitUpdates;
        QSYSLST.Database.COMMIT;
        except
        QSYSLST.Database.ROLLBACK;
        QSYSLST.CANCELUpdates;   SHOWMESSAGE('存盘失败!');
        end;

        NORMALMODE;
      END;
    END;

end;

procedure TFMSELOOKUPL.BTNYESClick(Sender: TObject);
begin


if (FORMMODE = 'INS' ) then
   BEGIN

   IF (TRIM(LSTITM.Text) = '' ) OR
      (TRIM(LSTNAM.Text) = '' ) THEN
      BEGIN
      SHOWMESSAGE('编号及名称不能为空!');
      EXIT;
      END;

   //删除空白
   QSYSLSTLSTITM.VALUE := TRIM(LSTITM.Text);

   if TABLECHECK_RE2('SYSLST','LSTENO','LSTITM',LIST_STR, LSTITM.Text) > 0 THEN
      begin
      SHOWMESSAGE('此编号已经重复使用!');
      EXIT;
      end;
   END;





Case MessageDlg('是否确定储存此条记录?',mtConfirmation,[mbYes,mbNo,mbCancel],0) of
 mrYES :begin
        try
        QSYSLST.Post;
        QSYSLST.Database.STARTTRANSACTION;
        QSYSLST.ApplyUpdates;
        QSYSLST.CommitUpdates;
        QSYSLST.Database.COMMIT;
      except
        QSYSLST.Database.ROLLBACK;
        QSYSLST.CANCELUpdates;   SHOWMESSAGE('存盘失败!');
      end;

        NORMALMODE;
        end;
 mrNO  :begin
        NORMALMODE;
        end;
end;


end;

procedure TFMSELOOKUPL.BTNCALClick(Sender: TObject);
begin

 IF MessageDlg('确定不新增本条记录?',mtConfirmation,[mbYes,mbNo],0)=mrYes Then
    begin
    QSYSLST.Cancel;
    NORMALMODE;
    end;

end;

procedure TFMSELOOKUPL.BTNSERClick(Sender: TObject);
begin
NORMALMODE;
end;

procedure TFMSELOOKUPL.BTNQUTClick(Sender: TObject);
begin
NORMALMODE;
close;
end;


procedure TFMSELOOKUPL.FormClose(Sender: TObject; var Action: TCloseAction);
begin
FMSELOOKUPL.RELEASE;
end;



procedure TFMSELOOKUPL.N1Click(Sender: TObject);
begin
CLOSE;
end;

end.
