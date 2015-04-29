unit UNPOSN;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, JLOOKUPD, SELOOKUPD, Menus, Grids, DBGrids, Mask,
  DBCtrls, JEdit, ExtCtrls, ComCtrls;

type

  TFMPOSN = class(TForm)
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
    LBBGEN1: TLabel;
    LBBGEN2: TLabel;
    LBPNPR1: TLabel;
    LBPNPR2: TLabel;
    LBPNDT1: TLabel;
    LBPNDT2: TLabel;
    LBPNDAT: TLabel;
    PNPR1: TDBEdit;
    PNPR2: TDBEdit;
    BGEN2: JDBLOOKUPBOX;
    BGEN1: JDBLOOKUPBOX;
    PNDT1: TJDBEdit;
    PNDT2: TJDBEdit;
    PNDAT: TJDBEdit;
    DBGrid: TDBGrid;
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
  FMPOSN: TFMPOSN;

implementation

uses SYSINI, FM_UTL, DB_UTL, MAIND, MAINU,
     UNPOSND, UNPOSNP;
     
{$R *.DFM}



procedure TFMPOSN.BTNMODE;
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

  {新增才可改编号}         BGEN1.Enabled := FALSE;
  IF FORMMODE = 'INS' THEN BGEN1.Enabled := TRUE;

end;

procedure TFMPOSN.INSERTMODE;
begin
FORMMODE := 'INS';
BTNMODE;
BGEN1.SetFocus;
end;

procedure TFMPOSN.UPDATEMODE;
begin
FORMMODE := 'UPD';
BTNMODE;

end;

procedure TFMPOSN.NORMALMODE;
begin
FORMMODE := 'CAN';
BTNMODE;
DBGRID.SetFocus;
end;






procedure TFMPOSN.FormCreate(Sender: TObject);
begin
IF FormExists('FMPOSND')=FALSE THEN Application.CreateForm(TFMPOSND, FMPOSND );

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

     FMPOSND.UPOSN.InsertSQL.CLEAR;
     FMPOSND.UPOSN.InsertSQL.Add('INSERT INTO POSN ');
     FMPOSND.UPOSN.InsertSQL.Add(' ( BGEN1, BGEN2, PNPR1, PNPR2, PNDT1, PNDT2, PNDAT ) ');
     FMPOSND.UPOSN.InsertSQL.Add('VALUES ');
     FMPOSND.UPOSN.InsertSQL.Add(' (:BGEN1,:BGEN2,:PNPR1,:PNPR2,:PNDT1,:PNDT2,:PNDAT ) ');

     FMPOSND.UPOSN.ModifySQL.CLEAR;
     FMPOSND.UPOSN.ModifySQL.Add('UPDATE POSN ');
     FMPOSND.UPOSN.ModifySQL.Add('SET ');
     FMPOSND.UPOSN.ModifySQL.Add('BGEN1 = :BGEN1 ,');
     FMPOSND.UPOSN.ModifySQL.Add('BGEN2 = :BGEN2 ,');
     FMPOSND.UPOSN.ModifySQL.Add('PNPR1 = :PNPR1 ,');
     FMPOSND.UPOSN.ModifySQL.Add('PNPR2 = :PNPR2 ,');
     FMPOSND.UPOSN.ModifySQL.Add('PNDT1 = :PNDT1 ,');
     FMPOSND.UPOSN.ModifySQL.Add('PNDT2 = :PNDT2 ,');
     FMPOSND.UPOSN.ModifySQL.Add('PNDAT = :PNDAT  ');
     FMPOSND.UPOSN.ModifySQL.Add('WHERE BGEN1 = :OLD_BGEN1');
     FMPOSND.UPOSN.ModifySQL.Add('  AND BGEN2 = :OLD_BGEN2');

     FMPOSND.UPOSN.DeleteSQL.CLEAR;
     FMPOSND.UPOSN.DeleteSQL.Add('DELETE FROM POSN ');
     FMPOSND.UPOSN.DeleteSQL.Add('WHERE BGEN1 = :OLD_BGEN1');
     FMPOSND.UPOSN.DeleteSQL.Add('  AND BGEN2 = :OLD_BGEN2');

     FMPOSND.QPOSN.SQL.CLEAR;
     FMPOSND.QPOSN.SQL.ADD('SELECT * FROM POSN, BGDS ');
     FMPOSND.QPOSN.SQL.ADD('WHERE POSN.BGEN1 IS NOT NULL');
     FMPOSND.QPOSN.SQL.ADD('  AND POSN.BGEN1 = BGDS.BGENO');
     FMPOSND.QPOSN.SQL.ADD('ORDER BY PNDT2 DESC');
     FMPOSND.QPOSN.CLOSE;
     FMPOSND.QPOSN.OPEN;

end;

procedure TFMPOSN.FormShow(Sender: TObject);
begin
NORMALMODE;
end;

procedure TFMPOSN.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  //Form 要结束前的询问(系统事件)
  CanClose := True;
  if (FORMMODE = 'INS' ) or (FORMMODE = 'UPD' ) then
    begin
    MessageDlg('请先结束输入模式后再退出!',mtConfirmation,[mbOk],0);
    CanClose := False;
    end;

end;



procedure TFMPOSN.BTNQUTClick(Sender: TObject);
begin
NORMALMODE;
close;
end;


procedure TFMPOSN.FormClose(Sender: TObject; var Action: TCloseAction);
begin
DataModuleRelease(FMPOSND);
FormRelease(FMPOSN);
FormFREE('FMPOSNP');
end;
















procedure TFMPOSN.BTNINSClick(Sender: TObject);
begin
//检查权限============================================
IF PERMISSION_CHECK(_USER_ID,'POSN_INS') = FALSE THEN EXIT;

INSERTMODE;

  WITH FMPOSND DO
    BEGIN
    QPOSN.APPEND;
    QPOSNBGEN1.VALUE := ''  ;
    QPOSNBGEN2.VALUE := ''  ;
    QPOSNPNPR1.VALUE := 0   ;
    QPOSNPNPR2.VALUE := 0   ;
    QPOSNPNDT1.VALUE := DATE;
    QPOSNPNDT2.VALUE := DATE;
    QPOSNPNDAT.VALUE := DATE;
    END;

end;

procedure TFMPOSN.BTNDELClick(Sender: TObject);
begin
//检查权限============================================
IF PERMISSION_CHECK(_USER_ID,'POSN_DEL') = FALSE THEN EXIT;

IF MessageDlg('是否确定要删除此条记录吗?',mtWarning, [mbYes, mbNo], 0) = mrYes then
   IF MessageDlg('如果您按下确定按钮此条记录将会被删除',mtWarning, [mbYes, mbNo], 0) = mrYes then
      BEGIN
      FMPOSND.QPOSN.Delete;
      FM_DB_QUERY_UPDATE(FMMAIND.DATABASE,FMPOSND.QPOSN);
      NORMALMODE;
      END;


end;

procedure TFMPOSN.BTNYESClick(Sender: TObject);
begin
//检查权限============================================
IF PERMISSION_CHECK(_USER_ID,'POSN_UPD') = FALSE THEN EXIT;

//检查重复
if (FORMMODE = 'INS' ) then
if TABLECHECK_RE2('POSN','BGEN1','BGEN2',BGEN1.Text,BGEN2.Text) > 0 THEN
   begin
   SHOWMESSAGE('此编号已经重复使用!');  EXIT;
   end;


Case MessageDlg('是否确定存储此条记录?',mtConfirmation,[mbYes,mbNo,mbCancel],0) of
 mrYES :begin
        NORMALMODE;
        FM_DB_QUERY_POST(FMMAIND.DATABASE,FMPOSND.QPOSN);
        end;
 mrNO  :begin
        NORMALMODE;
        FMPOSND.QPOSN.Cancel;
        end;
END;

end;

procedure TFMPOSN.BTNCALClick(Sender: TObject);
begin
NORMALMODE;
FMPOSND.QPOSN.Cancel;
end;



procedure TFMPOSN.BTNSERClick(Sender: TObject);
begin
//检查权限============================================
IF PERMISSION_CHECK(_USER_ID,'POSN_SEA') = FALSE THEN EXIT;

  WITH FMPOSND.QPOSN DO
  BEGIN
    CLOSE;
    SQL.CLEAR;
    SQL.ADD('SELECT * FROM POSN');
    SQL.ADD('WHERE BGEN1 IS NOT NULL');
    IF _SUPER_USER = FALSE THEN FMPOSND.QPOSN.SQL.ADD('AND BNENO = '''+ _USER_ID +'''');

    //字符串查询
    SQL.ADD(FINDFORM_WHEREKEY_STRING('BGEN1',LB11.Text,LB12.Text));
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


procedure TFMPOSN.BTNCLRClick(Sender: TObject);
begin
LB11.Clear;
LB12.Clear;
LB21.Clear;
LB22.Clear;
LB31.Clear;
LB32.Clear;
end;

procedure TFMPOSN.BTNPRNClick(Sender: TObject);
begin
//检查权限============================================
IF PERMISSION_CHECK(_USER_ID,'POSN_PRN') = FALSE THEN EXIT;

 IF FormExists('FMPOSNP')=FALSE THEN Application.CreateForm(TFMPOSNP, FMPOSNP  );
 IF SENDER = BTNPRE THEN FMPOSNP.QuickRep.Preview;
 IF SENDER = MENPRE THEN FMPOSNP.QuickRep.Preview;
 IF SENDER = BTNPRN THEN FMPOSNP.QuickRep.Print;
 IF SENDER = MENPRN THEN FMPOSNP.QuickRep.Print;

end;



end.
