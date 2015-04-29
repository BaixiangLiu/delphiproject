unit JLOOKUPL;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBTables, Db, Grids, DBGrids, ComCtrls, StdCtrls, Mask, DBCtrls, Buttons,
  ToolWin, Menus, JEdit, ExtCtrls;

type
  TFMLOOKUPL = class(TForm)
    LBTAEID: TLabel;
    LBTAEMRK: TLabel;
    Label2: TLabel;
    DBGrid1: TDBGrid;
    QSYSLST: TQuery;
    DSSYSLST: TDataSource;
    USYSLST: TUpdateSQL;
    QSYSLSTLSTID1: TStringField;
    QSYSLSTLSTID2: TStringField;
    QSYSLSTLSTNAM: TStringField;
    QSYSLSTLSTMRK: TStringField;
    LSTID2: TDBEdit;
    LSTNAM: TDBEdit;
    LSTMRK: TDBEdit;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
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
  FMLOOKUPL: TFMLOOKUPL;

implementation

uses UN_UTL, FM_UTL, DB_UTL;
{$R *.DFM}



procedure TFMLOOKUPL.BTNMODE;
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

IF TRIM(LSTID2.Text) = '' THEN
   BEGIN
   BTNUPD.Enabled := FALSE;
   BTNDEL.Enabled := FALSE;
   END;

end;

procedure TFMLOOKUPL.INSERTMODE;
begin
FORMMODE := 'INS';
BTNMODE;

DBGrid1.Enabled  := FALSE;

LSTID2.Enabled  := TRUE;
LSTNAM.Enabled  := TRUE;
LSTMRK.Enabled  := TRUE;
end;

procedure TFMLOOKUPL.UPDATEMODE;
begin
FORMMODE := 'UPD';
BTNMODE;

DBGrid1.Enabled  := FALSE;

//LSTID2.Enabled  := TRUE;
LSTNAM.Enabled  := TRUE;
LSTMRK.Enabled  := TRUE;
end;

procedure TFMLOOKUPL.NORMALMODE;
begin
FORMMODE := 'CAN';
BTNMODE;

LSTID2.Enabled  := FALSE;
LSTNAM.Enabled  := FALSE;
LSTMRK.Enabled  := FALSE;

DBGrid1.Enabled  := TRUE;
DBGrid1.SetFocus;
end;






procedure TFMLOOKUPL.FormCreate(Sender: TObject);
begin
//


end;

procedure TFMLOOKUPL.FormActivate(Sender: TObject);
begin
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

NORMALMODE;
end;



procedure TFMLOOKUPL.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  //Form 要结束前的询问(系统事件)
  CanClose := True;
  if (FORMMODE = 'INS' ) or (FORMMODE = 'UPD' ) then
    begin
    MessageDlg('请先结束输入模式后再退出!',mtConfirmation,[mbOk],0);
    CanClose := False;
    end;

end;



procedure TFMLOOKUPL.BTNINSClick(Sender: TObject);
begin
INSERTMODE;
    QSYSLST.APPEND;
    QSYSLSTLSTID1.VALUE := LIST_STR ;
    QSYSLSTLSTID2.VALUE := '' ;
    QSYSLSTLSTNAM.VALUE := '' ;
    QSYSLSTLSTMRK.VALUE := '' ;
    LSTID2.SetFocus;
end;

procedure TFMLOOKUPL.BTNUPDClick(Sender: TObject);
begin
UPDATEMODE;
QSYSLST.Edit;
LSTNAM.SetFocus;
end;

procedure TFMLOOKUPL.BTNDELClick(Sender: TObject);
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

procedure TFMLOOKUPL.BTNYESClick(Sender: TObject);
begin


if (FORMMODE = 'INS' ) then
   BEGIN

   IF (TRIM(LSTID2.Text) = '' ) OR
      (TRIM(LSTNAM.Text) = '' ) THEN
      BEGIN
      SHOWMESSAGE('编号及名称不能为空!');
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

procedure TFMLOOKUPL.BTNCALClick(Sender: TObject);
begin

 IF MessageDlg('确定不新增本条记录?',mtConfirmation,[mbYes,mbNo],0)=mrYes Then
    begin
    QSYSLST.Cancel;
    NORMALMODE;
    end;

end;

procedure TFMLOOKUPL.BTNSERClick(Sender: TObject);
begin
NORMALMODE;
end;

procedure TFMLOOKUPL.BTNQUTClick(Sender: TObject);
begin
NORMALMODE;
close;
end;


procedure TFMLOOKUPL.FormClose(Sender: TObject; var Action: TCloseAction);
begin
FMLOOKUPL.RELEASE;
end;



procedure TFMLOOKUPL.N1Click(Sender: TObject);
begin
CLOSE;
end;

end.
