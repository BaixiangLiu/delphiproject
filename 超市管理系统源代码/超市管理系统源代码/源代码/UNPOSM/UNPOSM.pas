unit UNPOSM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, JLOOKUPD, SELOOKUPD, Menus, Grids, DBGrids, Mask,
  DBCtrls, JEdit, ExtCtrls, ComCtrls;

type

  TFMPOSM = class(TForm)
    StatusBar: TStatusBar;
    Panel2: TPanel;
    MainMenu: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    Panel1: TPanel;
    BTNQUT: TBitBtn;
    BTNCAL: TBitBtn;
    BTNYES: TBitBtn;
    BTNDEL: TBitBtn;
    BTNINS: TBitBtn;
    BTNPRN: TBitBtn;
    GroupBox1: TGroupBox;
    LB1: TLabel;
    LB2: TLabel;
    LB3: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    Label1: TLabel;
    LB11: TJEdit;
    LB31: TJEdit;
    LB12: TJEdit;
    LB32: TJEdit;
    LB21: TJEdit;
    LB22: TJEdit;
    BTNSER: TBitBtn;
    BTNCLR: TBitBtn;
    BTNPRE: TBitBtn;
    N6: TMenuItem;
    MENPRE: TMenuItem;
    MENPRN: TMenuItem;
    LBBGENO: TLabel;
    LBPMPRI: TLabel;
    LBPMDT1: TLabel;
    LBPMDT2: TLabel;
    PMPRI: TDBEdit;
    PMDT1: TJDBEdit;
    PMDT2: TJDBEdit;
    BGENO: JDBLOOKUPBOX;
    DBGrid: TDBGrid;
    LBPNDAT: TLabel;
    PMDAT: TJDBEdit;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure BTNQUTClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BTNINSClick(Sender: TObject);
    procedure BTNDELClick(Sender: TObject);
    procedure BTNYESClick(Sender: TObject);
    procedure BTNCALClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BTNPRNClick(Sender: TObject);
    procedure BTNSERClick(Sender: TObject);
    procedure BTNCLRClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    FORMMODE : STRING;
    procedure BTNMODE;
    procedure INSERTMODE;
    procedure UPDATEMODE;
    procedure NORMALMODE;
  end;


var
  FMPOSM: TFMPOSM;

implementation

uses SYSINI, FM_UTL, DB_UTL, MAIND, MAINU,
     UNPOSMD, UNPOSMP;
     
{$R *.DFM}



procedure TFMPOSM.BTNMODE;
begin

  //一般模式
  DBGrid.Enabled := FALSE;
  BTNINS.Enabled := FALSE;
  BTNDEL.Enabled := FALSE;
  BTNYES.Enabled := FALSE;
  BTNCAL.Enabled := FALSE;
  BTNSER.Enabled := FALSE;
  BTNCLR.Enabled := FALSE;
  BTNPRE.Enabled := FALSE;
  BTNPRN.Enabled := FALSE;
  BTNQUT.Enabled := FALSE;
  //新增修改模式
  if (FORMMODE = 'INS' ) or (FORMMODE = 'UPD' ) then
     BEGIN
     DBGrid.Enabled := FALSE;
     BTNINS.Enabled := FALSE;
     BTNDEL.Enabled := FALSE;
     BTNYES.Enabled := TRUE;
     BTNCAL.Enabled := TRUE;
     BTNSER.Enabled := FALSE;
     BTNCLR.Enabled := FALSE;
     BTNPRE.Enabled := FALSE;
     BTNPRN.Enabled := FALSE;
     BTNQUT.Enabled := FALSE;
     END;
  //一般模式
  if (FORMMODE = 'CAN' ) then
     BEGIN
     DBGrid.Enabled := TRUE;
     BTNINS.Enabled := TRUE;
     BTNDEL.Enabled := TRUE;
     BTNYES.Enabled := FALSE;
     BTNCAL.Enabled := FALSE;
     BTNSER.Enabled := TRUE;
     BTNCLR.Enabled := TRUE;
     BTNPRE.Enabled := TRUE;
     BTNPRN.Enabled := TRUE;
     BTNQUT.Enabled := TRUE;
     END;

  {新增才可改编号}         BGENO.Enabled := FALSE;
  IF FORMMODE = 'INS' THEN BGENO.Enabled := TRUE;

end;

procedure TFMPOSM.INSERTMODE;
begin
FORMMODE := 'INS';
BTNMODE;
BGENO.SetFocus;
end;

procedure TFMPOSM.UPDATEMODE;
begin
FORMMODE := 'UPD';
BTNMODE;

end;

procedure TFMPOSM.NORMALMODE;
begin
FORMMODE := 'CAN';
BTNMODE;
DBGRID.SetFocus;
end;






procedure TFMPOSM.FormCreate(Sender: TObject);
begin
IF FormExists('FMPOSMD')=FALSE THEN Application.CreateForm(TFMPOSMD, FMPOSMD );

//按钮图形加载
BTNINS.Glyph := INS_TB;
BTNDEL.Glyph := DEL_TB;
BTNYES.Glyph := YES_TB;
BTNCAL.Glyph := CAL_TB;
BTNSER.Glyph := SER_TB;
BTNCLR.Glyph := CLR_TB;
BTNPRE.Glyph := PRE_TB;
BTNPRN.Glyph := PRN_TB;
BTNQUT.Glyph := QUT_TB;


     FMPOSMD.UPOSM.InsertSQL.CLEAR;
     FMPOSMD.UPOSM.InsertSQL.Add('INSERT INTO POSM ');
     FMPOSMD.UPOSM.InsertSQL.Add(' ( BGENO, PMPRI, PMDT1, PMDT2, PMDAT ) ');
     FMPOSMD.UPOSM.InsertSQL.Add('VALUES ');
     FMPOSMD.UPOSM.InsertSQL.Add(' (:BGENO,:PMPRI,:PMDT1,:PMDT2,:PMDAT ) ');

     FMPOSMD.UPOSM.ModifySQL.CLEAR;
     FMPOSMD.UPOSM.ModifySQL.Add('UPDATE POSM ');
     FMPOSMD.UPOSM.ModifySQL.Add('SET ');
     FMPOSMD.UPOSM.ModifySQL.Add('BGENO = :BGENO ,');
     FMPOSMD.UPOSM.ModifySQL.Add('PMPRI = :PMPRI ,');
     FMPOSMD.UPOSM.ModifySQL.Add('PMDT1 = :PMDT1 ,');
     FMPOSMD.UPOSM.ModifySQL.Add('PMDT2 = :PMDT2 ,');
     FMPOSMD.UPOSM.ModifySQL.Add('PMDAT = :PMDAT  ');
     FMPOSMD.UPOSM.ModifySQL.Add('WHERE BGENO = :OLD_BGENO');

     FMPOSMD.UPOSM.DeleteSQL.CLEAR;
     FMPOSMD.UPOSM.DeleteSQL.Add('DELETE FROM POSM ');
     FMPOSMD.UPOSM.DeleteSQL.Add('WHERE BGENO = :OLD_BGENO');

     FMPOSMD.QPOSM.SQL.CLEAR;
     FMPOSMD.QPOSM.SQL.ADD('SELECT * FROM POSM ');
     FMPOSMD.QPOSM.SQL.ADD('ORDER BY PMDT2 DESC ');
     FMPOSMD.QPOSM.CLOSE;
     FMPOSMD.QPOSM.OPEN;


end;

procedure TFMPOSM.FormShow(Sender: TObject);
begin
NORMALMODE;
end;

procedure TFMPOSM.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  //Form 要结束前的询问(系统事件)
  CanClose := True;
  if (FORMMODE = 'INS' ) or (FORMMODE = 'UPD' ) then
    begin
    MessageDlg('请先结束输入模式后再退出!',mtConfirmation,[mbOk],0);
    CanClose := False;
    end;

end;



procedure TFMPOSM.BTNQUTClick(Sender: TObject);
begin
NORMALMODE;
close;
end;


procedure TFMPOSM.FormClose(Sender: TObject; var Action: TCloseAction);
begin
DataModuleRelease(FMPOSMD);
FormRelease(FMPOSM);
FormFREE('FMPOSMP');
end;
















procedure TFMPOSM.BTNINSClick(Sender: TObject);
begin
//检查权限============================================
IF PERMISSION_CHECK(_USER_ID,'POSM_INS') = FALSE THEN EXIT;

INSERTMODE;

  WITH FMPOSMD DO
    BEGIN
    QPOSM.APPEND;
    QPOSMBGENO.VALUE := ''  ;
    QPOSMPMPRI.VALUE := 0   ;
    QPOSMPMDT1.VALUE := DATE;
    QPOSMPMDT2.VALUE := DATE;
    QPOSMPMDAT.VALUE := DATE;
    END;

end;

procedure TFMPOSM.BTNDELClick(Sender: TObject);
begin
//检查权限============================================
IF PERMISSION_CHECK(_USER_ID,'POSM_DEL') = FALSE THEN EXIT;

IF MessageDlg('是否确定要删除此条记录吗?',mtWarning, [mbYes, mbNo], 0) = mrYes then
   IF MessageDlg('如果您按下确定按钮此条记录将会被删除',mtWarning, [mbYes, mbNo], 0) = mrYes then
      BEGIN
      FMPOSMD.QPOSM.Delete;
      FM_DB_QUERY_UPDATE(FMMAIND.DATABASE,FMPOSMD.QPOSM);
      NORMALMODE;
      END;


end;

procedure TFMPOSM.BTNYESClick(Sender: TObject);
begin
//检查权限============================================
IF PERMISSION_CHECK(_USER_ID,'POSM_UPD') = FALSE THEN EXIT;

//检查重复
if (FORMMODE = 'INS' ) then
if TABLECHECK_RE1('POSM','BGENO',BGENO.Text) > 0 THEN
   begin
   SHOWMESSAGE('此编号已经重复使用!');  EXIT;
   end;


Case MessageDlg('是否确定存储此条记录?',mtConfirmation,[mbYes,mbNo,mbCancel],0) of
 mrYES :begin
        NORMALMODE;
        FM_DB_QUERY_POST(FMMAIND.DATABASE,FMPOSMD.QPOSM);
        end;
 mrNO  :begin
        NORMALMODE;
        FMPOSMD.QPOSM.Cancel;
        end;
END;

end;

procedure TFMPOSM.BTNCALClick(Sender: TObject);
begin
NORMALMODE;
FMPOSMD.QPOSM.Cancel;
end;



procedure TFMPOSM.BTNSERClick(Sender: TObject);
begin
//检查权限============================================
IF PERMISSION_CHECK(_USER_ID,'POSM_SEA') = FALSE THEN EXIT;

  WITH FMPOSMD.QPOSM DO
  BEGIN
    CLOSE;
    SQL.CLEAR;
    SQL.ADD('SELECT * FROM POSM');
    SQL.ADD('WHERE BGENO IS NOT NULL');
    IF _SUPER_USER = FALSE THEN FMPOSMD.QPOSM.SQL.ADD('AND BNENO = '''+ _USER_ID +'''');

    //字符串查询
    SQL.ADD(FINDFORM_WHEREKEY_STRING('BGENO',LB11.Text,LB12.Text));
    SQL.ADD(FINDFORM_WHEREKEY_STRING('BCNAM',LB21.Text,LB22.Text));
    SQL.ADD(FINDFORM_WHEREKEY_STRING('BCMN1',LB31.Text,LB32.Text));

    //ACCESS " DATE " WHERE KEY  ======================
//    SQL.ADD(FINDFORM_WHEREKEY_DATE(F_NAME[3],LB31.Text,LB32.Text));

    //查询 排序    //ORDER BYE=======================================
//    SQL.ADD(FINDFORM_ORDERBY3(F_NAME[1],F_NAME[2],F_NAME[3],WHEREKEY1.ItemIndex,WHEREKEY2.ItemIndex,WHEREKEY3.ItemIndex));

//    SHOWMESSAGE(SQL.TEXT);
    OPEN;
  END;




end;


procedure TFMPOSM.BTNCLRClick(Sender: TObject);
begin
LB11.Clear;
LB12.Clear;
LB21.Clear;
LB22.Clear;
LB31.Clear;
LB32.Clear;
end;

procedure TFMPOSM.BTNPRNClick(Sender: TObject);
begin
//检查权限============================================
IF PERMISSION_CHECK(_USER_ID,'POSM_PRN') = FALSE THEN EXIT;

 IF FormExists('FMPOSMP')=FALSE THEN Application.CreateForm(TFMPOSMP, FMPOSMP  );
 IF SENDER = BTNPRE THEN FMPOSMP.QuickRep.Preview;
 IF SENDER = MENPRE THEN FMPOSMP.QuickRep.Preview;
 IF SENDER = BTNPRN THEN FMPOSMP.QuickRep.Print;
 IF SENDER = MENPRN THEN FMPOSMP.QuickRep.Print;

end;



end.
