unit UNRDEL;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBCtrls, StdCtrls, Mask, Grids, DBGrids, ComCtrls, Buttons, ToolWin,
  JLOOKUPD, JEdit, ExtCtrls;

type
  TFMRDEL = class(TForm)
    StatusBar: TStatusBar;
    Panel1: TPanel;
    RDREA: JDBLOOKUPBOX;
    AREA_TOOL: TPanel;
    BTNQUT: TBitBtn;
    BTNINS: TBitBtn;
    BTNUPD: TBitBtn;
    BTNDEL: TBitBtn;
    BTNYES: TBitBtn;
    BTNCAL: TBitBtn;
    BTNSER: TBitBtn;
    BTNPRN: TBitBtn;
    RBPST: JDBLOOKUPBOX;
    BNENO: JDBLOOKUPBOX;
    BGENO: JDBLOOKUPBOX;
    LBRDENO: TLabel;
    RDENO: TJDBEDIT;
    LBBGENO: TLabel;
    LBRDCNT: TLabel;
    RDCNT: TJDBEDIT;
    LBRBPST: TLabel;
    LBRDREA: TLabel;
    LBRDDAT: TLabel;
    RDDAT: TJDBEDIT;
    LBRDTME: TLabel;
    RDTME: TJDBEDIT;
    LBBNENO: TLabel;
    LBRDMRK: TLabel;
    RDMRK: TJDBEDIT;
    DBGrid1: TDBGrid;
    RDOUT: TDBCheckBox;
    LBRGOUT: TLabel;
    BitBtn1: TBitBtn;
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
    procedure BitBtn1Click(Sender: TObject);
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
  FMRDEL: TFMRDEL;

implementation

uses sysini, un_utl, fm_utl, DB_UTL, MAIND, MAINU, 
     UNRDELD, UNRDELF, UNRDELP
       ;
{$R *.DFM}



procedure TFMRDEL.BTNMODE;
begin
  //一般模式
     BTNINS.Enabled := FALSE;
     BTNUPD.Enabled := FALSE;
     BTNDEL.Enabled := FALSE;
     BTNYES.Enabled := FALSE;
     BTNCAL.Enabled := FALSE;
     BTNSER.Enabled := FALSE;
     BTNPRN.Enabled := FALSE;
     BTNQUT.Enabled := FALSE;
  //新增修改模式
  if (FORMMODE = 'INS' ) or (FORMMODE = 'UPD' ) then
     BEGIN
     BTNINS.Enabled := FALSE;
     BTNUPD.Enabled := FALSE;
     BTNDEL.Enabled := FALSE;
     BTNYES.Enabled := TRUE;
     BTNCAL.Enabled := TRUE;
     BTNSER.Enabled := FALSE;
     BTNPRN.Enabled := FALSE;
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
     BTNSER.Enabled := TRUE;
     BTNPRN.Enabled := TRUE;
     BTNQUT.Enabled := TRUE;
     END;
end;

procedure TFMRDEL.INSERTMODE;
begin
FORMMODE := 'INS';
BTNMODE;

RDENO.Enabled := TRUE;
BGENO.Enabled := TRUE;
RDCNT.Enabled := TRUE;
RBPST.Enabled := TRUE;
RDREA.Enabled := TRUE;
RDDAT.Enabled := TRUE;
RDTME.Enabled := TRUE;
BNENO.Enabled := TRUE;
RDMRK.Enabled := TRUE;
//RDOUT.Enabled := TRUE;

DBGRID1.Enabled := FALSE;
RDENO.SetFocus;
end;

procedure TFMRDEL.UPDATEMODE;
begin
FORMMODE := 'UPD';
BTNMODE;

//RDENO.Enabled := TRUE;
BGENO.Enabled := TRUE;
RDCNT.Enabled := TRUE;
RBPST.Enabled := TRUE;
RDREA.Enabled := TRUE;
RDDAT.Enabled := TRUE;
RDTME.Enabled := TRUE;
BNENO.Enabled := TRUE;
RDMRK.Enabled := TRUE;
//RDOUT.Enabled := TRUE;

DBGRID1.Enabled := FALSE;
BGENO.SetFocus;
end;

procedure TFMRDEL.NORMALMODE;
begin
FORMMODE := 'CAN';
BTNMODE;

RDENO.Enabled := FALSE;
BGENO.Enabled := FALSE;
RDCNT.Enabled := FALSE;
RBPST.Enabled := FALSE;
RDREA.Enabled := FALSE;
RDDAT.Enabled := FALSE;
RDTME.Enabled := FALSE;
BNENO.Enabled := FALSE;
RDMRK.Enabled := FALSE;
RDOUT.Enabled := FALSE;

DBGRID1.Enabled := TRUE;
end;


procedure TFMRDEL.FormCreate(Sender: TObject);
begin
     //按钮图形加载
     BTNINS.Glyph := INS_TB;
     BTNUPD.Glyph := UPD_TB;
     BTNDEL.Glyph := DEL_TB;
     BTNYES.Glyph := YES_TB;
     BTNCAL.Glyph := CAL_TB;
     BTNSER.Glyph := SER_TB;
     BTNPRN.Glyph := PRN_TB;
     BTNQUT.Glyph := QUT_TB;

     FMRDELD.QRDEL.SQL.CLEAR;
     FMRDELD.QRDEL.SQL.ADD('SELECT *  ');
     FMRDELD.QRDEL.SQL.ADD('FROM RDEL ');
     FMRDELD.QRDEL.SQL.ADD('WHERE RDOUT = 0 ');
     FMRDELD.QRDEL.SQL.ADD('ORDER BY RDENO');

     FMRDELD.URDEL.InsertSQL.CLEAR;
     FMRDELD.URDEL.InsertSQL.Add('INSERT INTO RDEL ');
     FMRDELD.URDEL.InsertSQL.Add(' ( RDENO, BGENO, RDCNT, RBPST, RDREA, RDDAT, RDTME, BNENO, RDMRK, RDOUT ) ');
     FMRDELD.URDEL.InsertSQL.Add('VALUES ');
     FMRDELD.URDEL.InsertSQL.Add(' (:RDENO,:BGENO,:RDCNT,:RBPST,:RDREA,:RDDAT,:RDTME,:BNENO,:RDMRK,:RDOUT ) ');

     FMRDELD.URDEL.ModifySQL.CLEAR;
     FMRDELD.URDEL.ModifySQL.Add('UPDATE RDEL ');
     FMRDELD.URDEL.ModifySQL.Add('SET ');
     FMRDELD.URDEL.ModifySQL.Add('RDENO = :RDENO ,');
     FMRDELD.URDEL.ModifySQL.Add('BGENO = :BGENO ,');
     FMRDELD.URDEL.ModifySQL.Add('RDCNT = :RDCNT ,');
     FMRDELD.URDEL.ModifySQL.Add('RBPST = :RBPST ,');
     FMRDELD.URDEL.ModifySQL.Add('RDREA = :RDREA ,');
     FMRDELD.URDEL.ModifySQL.Add('RDDAT = :RDDAT ,');
     FMRDELD.URDEL.ModifySQL.Add('RDTME = :RDTME ,');
     FMRDELD.URDEL.ModifySQL.Add('BNENO = :BNENO ,');
     FMRDELD.URDEL.ModifySQL.Add('RDMRK = :RDMRK ,');
     FMRDELD.URDEL.ModifySQL.Add('RDOUT = :RDOUT  ');
     FMRDELD.URDEL.ModifySQL.Add('WHERE RDENO = :OLD_RDENO');

     FMRDELD.URDEL.DeleteSQL.CLEAR;
     FMRDELD.URDEL.DeleteSQL.Add('DELETE FROM RDEL ');
     FMRDELD.URDEL.DeleteSQL.Add('WHERE RDENO = :OLD_RDENO');

     FMRDELD.QRDEL.CLOSE;
     FMRDELD.QRDEL.OPEN;

end;

procedure TFMRDEL.FormActivate(Sender: TObject);
begin
//PAGE_A.SHOW;
NORMALMODE;
end;

procedure TFMRDEL.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  //Form 要结束前的询问(系统事件)
  CanClose := True;
  if (FORMMODE = 'INS' ) or (FORMMODE = 'UPD' ) then
    begin
    MessageDlg('请先结束输入模式后再退出!',mtConfirmation,[mbOk],0);
    CanClose := False;
    end;

end;



procedure TFMRDEL.BTNINSClick(Sender: TObject);
begin
//试用版记录数限定
IF CHECK_DEMO_VERSION_RECCNT('RDEL') = FALSE THEN EXIT;

//检查权限============================================
if PERMISSION_CHECK(_USER_ID, 'UNRDELI') = FALSE then
   EXIT;

INSERTMODE;

  WITH FMRDELD DO
    BEGIN
    QRDEL.APPEND;

    QRDELRDENO.VALUE := TABLEFINDMAXCNT('RDEL','RDENO',4,1);
    QRDELBGENO.VALUE := ''  ;
    QRDELRDCNT.VALUE := 1   ;
    QRDELRBPST.VALUE := _SYS_RBPST;
    QRDELRDREA.VALUE := '001'  ;
    QRDELRDDAT.VALUE := DATE;
    QRDELRDTME.VALUE := TIME_GET_24H(TIME);
    QRDELBNENO.VALUE := _USER_ID  ;
    QRDELRDMRK.VALUE := ''  ;
    QRDELRDOUT.VALUE := FALSE ;
    END;

end;

procedure TFMRDEL.BTNUPDClick(Sender: TObject);
begin
//检查权限============================================
if PERMISSION_CHECK(_USER_ID, 'UNRDELU') = FALSE then
   EXIT;

UPDATEMODE;
FMRDELD.QRDEL.Edit;
end;

procedure TFMRDEL.BTNDELClick(Sender: TObject);
begin
//检查权限============================================
if PERMISSION_CHECK(_USER_ID, 'UNRDELD') = FALSE then
   EXIT;

NORMALMODE;


    IF MessageDlg('是否确定要删除此条记录吗?',mtWarning, [mbYes, mbNo], 0) = mrYes then
    BEGIN
      IF MessageDlg('如果您按下确定按钮此条记录将会被删除',mtWarning, [mbYes, mbNo], 0) = mrYes then
      BEGIN
        FMRDELD.QRDEL.Delete;
        FM_DB_QUERY_UPDATE(FMMAIND.DATABASE,FMRDELD.QRDEL);
        NORMALMODE;
      END;
    END;

end;

procedure TFMRDEL.BTNYESClick(Sender: TObject);
begin

//检查空白字段
IF FM_CHECK_FIELD_BLANK(RDENO .Text,LBRDENO .Caption ,LBRDENO .Caption + ' 此栏不可输入空白!') = FALSE THEN EXIT;
IF FM_CHECK_FIELD_BLANK(BNENO .Text,LBBNENO .Caption ,LBBNENO .Caption + ' 此栏不可输入空白!') = FALSE THEN EXIT;

//检查重复
if (FORMMODE = 'INS' ) then
if TABLECHECK_RE1('RDEL','RDENO',RDENO.Text) > 0 THEN
   begin
   SHOWMESSAGE('此编号已经重复使用!');
   EXIT;
   end;




Case MessageDlg('是否确定存储此条记录?',mtConfirmation,[mbYes,mbNo,mbCancel],0) of
 mrYES :begin
        NORMALMODE;
        FM_DB_QUERY_POST(FMMAIND.DATABASE,FMRDELD.QRDEL);
        end;
 mrNO  :begin
        FMRDELD.QRDEL.Cancel;
        NORMALMODE;
        end;

end;


end;

procedure TFMRDEL.BTNCALClick(Sender: TObject);
begin

 IF MessageDlg('确定不新增本条记录?',mtConfirmation,[mbYes,mbNo],0)=mrYes Then
    begin
    FMRDELD.QRDEL.Cancel;
    NORMALMODE;
    end;

end;

procedure TFMRDEL.BTNSERClick(Sender: TObject);
begin
//检查权限============================================
if PERMISSION_CHECK(_USER_ID, 'UNRDELS') = FALSE then
   EXIT;

NORMALMODE;
FMRDELF.SearchFORMMODE  := 'SEARCH';
FMRDELF.Caption := '查询';
FMRDELF.SHOWMODAL;
end;

procedure TFMRDEL.BTNPRNClick(Sender: TObject);
begin
//检查权限============================================
if PERMISSION_CHECK(_USER_ID, 'UNRDELP') = FALSE then
   EXIT;

NORMALMODE;
FMRDELF.SearchFORMMODE  := 'PRINT';
FMRDELF.Caption := '打印';
FMRDELF.SHOWMODAL;
end;

procedure TFMRDEL.BTNQUTClick(Sender: TObject);
begin
NORMALMODE;
close;
end;


procedure TFMRDEL.FormClose(Sender: TObject; var Action: TCloseAction);
begin
DataModuleRelease(FMRDELD);
FormRelease(FMRDEL);
FormRelease(FMRDELF);
FormRelease(FMRDELP);
end;
















procedure TFMRDEL.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
GRID_DRAWCOLUMNCELL(Sender, Rect, DataCol, Column, State,True_bmp, False_bmp, Blank_bmp);

end;

procedure TFMRDEL.BitBtn1Click(Sender: TObject);
begin

IF FMRDELD.QRDELRDOUT.VALUE = FALSE THEN
IF MessageDlg('是否确定过档?',mtConfirmation,[mbYes,mbNo],0) =mrYES THEN
   begin

   //更新库存资料
   RBRN_CHECK_EXIST(BGENO.TEXT,RBPST.TEXT);
   FMMAIND.QUPD.SQL.Clear;
   FMMAIND.QUPD.SQL.ADD('UPDATE RBRN');
   FMMAIND.QUPD.SQL.ADD('SET');
   FMMAIND.QUPD.SQL.ADD(' RBCNT = RBCNT - '+RDCNT.TEXT+' ,');
   FMMAIND.QUPD.SQL.ADD(' RBDTU = '''+ DATETOSTR(DATE) +''', ');
   FMMAIND.QUPD.SQL.ADD(' RBTMU = '''+TIME_GET_24H(TIME)+''' ');
   FMMAIND.QUPD.SQL.ADD(' WHERE BGENO = '''+BGENO.TEXT+'''');
   FMMAIND.QUPD.SQL.ADD('   AND RBPST = '''+RBPST.TEXT+'''');
   try FMMAIND.QUPD.ExecSQL;
   except SHOWMESSAGE('RBRN 无法更新!');   end;

   FMRDELD.QRDEL.Edit;
   FMRDELD.QRDELRDOUT.VALUE := TRUE;
   FM_DB_QUERY_POST(FMMAIND.DATABASE,FMRDELD.QRDEL);

   end;


end;

end.
 
