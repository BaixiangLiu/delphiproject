unit UNRBOW;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBCtrls, StdCtrls, Mask, Grids, DBGrids, ComCtrls, Buttons, ToolWin,
  JLOOKUPD, JEdit, ExtCtrls;

type
  TFMRBOW = class(TForm)
    StatusBar: TStatusBar;
    Panel1: TPanel;
    RBREA: JDBLOOKUPBOX;
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
    LBRBENO: TLabel;
    RBENO: TJDBEDIT;
    LBBGENO: TLabel;
    LBRBCN1: TLabel;
    RBCN1: TJDBEDIT;
    LBRBCN2: TLabel;
    RBCN2: TJDBEDIT;
    LBRBPST: TLabel;
    LBRBBCK: TLabel;
    LBRBOUT: TLabel;
    LBRBREA: TLabel;
    LBRBDT1: TLabel;
    RBDT1: TJDBEDIT;
    LBRBTM1: TLabel;
    RBTM1: TJDBEDIT;
    LBRBDT2: TLabel;
    RBDT2: TJDBEDIT;
    LBRBTM2: TLabel;
    RBTM2: TJDBEDIT;
    LBBNENO: TLabel;
    LBRBMRK: TLabel;
    RBMRK: TJDBEDIT;
    DBGrid1: TDBGrid;
    RBBCK: TDBCheckBox;
    RBOUT: TDBCheckBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
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
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
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
  FMRBOW: TFMRBOW;

implementation

uses sysini, un_utl, fm_utl, DB_UTL, MAIND, MAINU, 
     UNRBOWD, UNRBOWF, UNRBOWP
       ;
{$R *.DFM}



procedure TFMRBOW.BTNMODE;
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

procedure TFMRBOW.INSERTMODE;
begin
FORMMODE := 'INS';
BTNMODE;

RBENO.Enabled := TRUE;
BGENO.Enabled := TRUE;
IF FMRBOWD.QRBOWRBOUT.VALUE = FALSE THEN RBCN1.Enabled := TRUE;
IF FMRBOWD.QRBOWRBBCK.VALUE = FALSE THEN RBCN2.Enabled := TRUE;
RBPST.Enabled := TRUE;
//RBBCK.Enabled := TRUE;
//RBOUT.Enabled := TRUE;
RBREA.Enabled := TRUE;
RBDT1.Enabled := TRUE;
RBTM1.Enabled := TRUE;
RBDT2.Enabled := TRUE;
RBTM2.Enabled := TRUE;
BNENO.Enabled := TRUE;
RBMRK.Enabled := TRUE;

DBGRID1.Enabled := FALSE;
RBENO.SetFocus;
end;

procedure TFMRBOW.UPDATEMODE;
begin
FORMMODE := 'UPD';
BTNMODE;

//RBENO.Enabled := TRUE;
BGENO.Enabled := TRUE;
IF FMRBOWD.QRBOWRBOUT.VALUE = FALSE THEN RBCN1.Enabled := TRUE;
IF FMRBOWD.QRBOWRBBCK.VALUE = FALSE THEN RBCN2.Enabled := TRUE;
RBPST.Enabled := TRUE;
//RBBCK.Enabled := TRUE;
//RBOUT.Enabled := TRUE;
RBREA.Enabled := TRUE;
RBDT1.Enabled := TRUE;
RBTM1.Enabled := TRUE;
RBDT2.Enabled := TRUE;
RBTM2.Enabled := TRUE;
BNENO.Enabled := TRUE;
RBMRK.Enabled := TRUE;

DBGRID1.Enabled := FALSE;
BGENO.SetFocus;
end;

procedure TFMRBOW.NORMALMODE;
begin
FORMMODE := 'CAN';
BTNMODE;

RBENO.Enabled := FALSE;
BGENO.Enabled := FALSE;
RBCN1.Enabled := FALSE;
RBCN2.Enabled := FALSE;
RBPST.Enabled := FALSE;
RBBCK.Enabled := FALSE;
RBOUT.Enabled := FALSE;
RBREA.Enabled := FALSE;
RBDT1.Enabled := FALSE;
RBTM1.Enabled := FALSE;
RBDT2.Enabled := FALSE;
RBTM2.Enabled := FALSE;
BNENO.Enabled := FALSE;
RBMRK.Enabled := FALSE;

DBGRID1.Enabled := TRUE;
end;


procedure TFMRBOW.FormCreate(Sender: TObject);
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

     FMRBOWD.QRBOW.SQL.CLEAR;
     FMRBOWD.QRBOW.SQL.ADD('SELECT *  ');
     FMRBOWD.QRBOW.SQL.ADD('FROM RBOW ');
     FMRBOWD.QRBOW.SQL.ADD('WHERE RBBCK = 0');
     FMRBOWD.QRBOW.SQL.ADD('ORDER BY RBENO');

     FMRBOWD.URBOW.InsertSQL.CLEAR;
     FMRBOWD.URBOW.InsertSQL.Add('INSERT INTO RBOW ');
     FMRBOWD.URBOW.InsertSQL.Add(' ( RBENO, BGENO, RBCN1, RBCN2, RBPST, RBBCK, RBOUT, RBREA, RBDT1, RBTM1, RBDT2, RBTM2, BNENO, RBMRK ) ');
     FMRBOWD.URBOW.InsertSQL.Add('VALUES ');
     FMRBOWD.URBOW.InsertSQL.Add(' (:RBENO,:BGENO,:RBCN1,:RBCN2,:RBPST,:RBBCK,:RBOUT,:RBREA,:RBDT1,:RBTM1,:RBDT2,:RBTM2,:BNENO,:RBMRK ) ');

     FMRBOWD.URBOW.ModifySQL.CLEAR;
     FMRBOWD.URBOW.ModifySQL.Add('UPDATE RBOW ');
     FMRBOWD.URBOW.ModifySQL.Add('SET ');
     FMRBOWD.URBOW.ModifySQL.Add('RBENO = :RBENO ,');
     FMRBOWD.URBOW.ModifySQL.Add('BGENO = :BGENO ,');
     FMRBOWD.URBOW.ModifySQL.Add('RBCN1 = :RBCN1 ,');
     FMRBOWD.URBOW.ModifySQL.Add('RBCN2 = :RBCN2 ,');
     FMRBOWD.URBOW.ModifySQL.Add('RBPST = :RBPST ,');
     FMRBOWD.URBOW.ModifySQL.Add('RBBCK = :RBBCK ,');
     FMRBOWD.URBOW.ModifySQL.Add('RBOUT = :RBOUT ,');
     FMRBOWD.URBOW.ModifySQL.Add('RBREA = :RBREA ,');
     FMRBOWD.URBOW.ModifySQL.Add('RBDT1 = :RBDT1 ,');
     FMRBOWD.URBOW.ModifySQL.Add('RBTM1 = :RBTM1 ,');
     FMRBOWD.URBOW.ModifySQL.Add('RBDT2 = :RBDT2 ,');
     FMRBOWD.URBOW.ModifySQL.Add('RBTM2 = :RBTM2 ,');
     FMRBOWD.URBOW.ModifySQL.Add('BNENO = :BNENO ,');
     FMRBOWD.URBOW.ModifySQL.Add('RBMRK = :RBMRK  ');
     FMRBOWD.URBOW.ModifySQL.Add('WHERE RBENO = :OLD_RBENO');

     FMRBOWD.URBOW.DeleteSQL.CLEAR;
     FMRBOWD.URBOW.DeleteSQL.Add('DELETE FROM RBOW ');
     FMRBOWD.URBOW.DeleteSQL.Add('WHERE RBENO = :OLD_RBENO');

     FMRBOWD.QRBOW.CLOSE;
     FMRBOWD.QRBOW.OPEN;

end;

procedure TFMRBOW.FormActivate(Sender: TObject);
begin
//PAGE_A.SHOW;
NORMALMODE;
end;

procedure TFMRBOW.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  //Form 要结束前的询问(系统事件)
  CanClose := True;
  if (FORMMODE = 'INS' ) or (FORMMODE = 'UPD' ) then
    begin
    MessageDlg('请先结束输入模式后再退出!',mtConfirmation,[mbOk],0);
    CanClose := False;
    end;

end;



procedure TFMRBOW.BTNINSClick(Sender: TObject);
begin
//试用版记录数限定
IF CHECK_DEMO_VERSION_RECCNT('RBOW') = FALSE THEN EXIT;

//检查权限============================================
if PERMISSION_CHECK(_USER_ID, 'UNRBOWI') = FALSE then
   EXIT;

  WITH FMRBOWD DO
    BEGIN
    QRBOW.APPEND;

    QRBOWRBENO.VALUE := TABLEFINDMAXCNT('RBOW','RBENO',4,1);
    QRBOWBGENO.VALUE := ''  ;
    QRBOWRBCN1.VALUE := 1   ;
    QRBOWRBCN2.VALUE := 0   ;
    QRBOWRBPST.VALUE := _SYS_RBPST;
    QRBOWRBBCK.VALUE := FALSE;
    QRBOWRBOUT.VALUE := FALSE;
    QRBOWRBREA.VALUE := '001'  ;
    QRBOWRBDT1.VALUE := DATE;
    QRBOWRBTM1.VALUE := TIME_GET_24H(TIME);
    QRBOWRBDT2.VALUE := DATE+7;
    QRBOWRBTM2.VALUE := ''  ;
    QRBOWBNENO.VALUE := _USER_ID  ;
    QRBOWRBMRK.VALUE := ''  ;
    END;

INSERTMODE;
end;

procedure TFMRBOW.BTNUPDClick(Sender: TObject);
begin
//检查权限============================================
if PERMISSION_CHECK(_USER_ID, 'UNRBOWU') = FALSE then
   EXIT;

UPDATEMODE;
FMRBOWD.QRBOW.Edit;
end;

procedure TFMRBOW.BTNDELClick(Sender: TObject);
begin
//检查权限============================================
if PERMISSION_CHECK(_USER_ID, 'UNRBOWD') = FALSE then
   EXIT;

NORMALMODE;


    IF MessageDlg('是否确定要删除此条记录吗?',mtWarning, [mbYes, mbNo], 0) = mrYes then
    BEGIN
      IF MessageDlg('如果您按下确定按钮此条记录将会被删除',mtWarning, [mbYes, mbNo], 0) = mrYes then
      BEGIN
        FMRBOWD.QRBOW.Delete;
        FM_DB_QUERY_UPDATE(FMMAIND.DATABASE,FMRBOWD.QRBOW);
        NORMALMODE;
      END;
    END;

end;

procedure TFMRBOW.BTNYESClick(Sender: TObject);
begin

//检查空白字段
IF FM_CHECK_FIELD_BLANK(RBENO .Text,LBRBENO .Caption ,LBRBENO .Caption + ' 此栏不可输入空白!') = FALSE THEN EXIT;
IF FM_CHECK_FIELD_BLANK(BNENO .Text,LBBNENO .Caption ,LBBNENO .Caption + ' 此栏不可输入空白!') = FALSE THEN EXIT;

//检查重复
if (FORMMODE = 'INS' ) then
if TABLECHECK_RE1('RBOW','RBENO',RBENO.Text) > 0 THEN
   begin
   SHOWMESSAGE('此编号已经重复使用!');
   EXIT;
   end;




Case MessageDlg('是否确定存储此条记录?',mtConfirmation,[mbYes,mbNo,mbCancel],0) of
 mrYES :begin
        NORMALMODE;
        FM_DB_QUERY_POST(FMMAIND.DATABASE,FMRBOWD.QRBOW);
        end;
 mrNO  :begin
        FMRBOWD.QRBOW.Cancel;
        NORMALMODE;
        end;

end;


end;

procedure TFMRBOW.BTNCALClick(Sender: TObject);
begin

 IF MessageDlg('确定不新增本条记录?',mtConfirmation,[mbYes,mbNo],0)=mrYes Then
    begin
    FMRBOWD.QRBOW.Cancel;
    NORMALMODE;
    end;

end;

procedure TFMRBOW.BTNSERClick(Sender: TObject);
begin
//检查权限============================================
if PERMISSION_CHECK(_USER_ID, 'UNRBOWS') = FALSE then
   EXIT;

NORMALMODE;
FMRBOWF.SearchFORMMODE  := 'SEARCH';
FMRBOWF.Caption := '查询';
FMRBOWF.SHOWMODAL;
end;

procedure TFMRBOW.BTNPRNClick(Sender: TObject);
begin
//检查权限============================================
if PERMISSION_CHECK(_USER_ID, 'UNRBOWP') = FALSE then
   EXIT;

NORMALMODE;
FMRBOWF.SearchFORMMODE  := 'PRINT';
FMRBOWF.Caption := '打印';
FMRBOWF.SHOWMODAL;
end;

procedure TFMRBOW.BTNQUTClick(Sender: TObject);
begin
NORMALMODE;
close;
end;


procedure TFMRBOW.FormClose(Sender: TObject; var Action: TCloseAction);
begin
DataModuleRelease(FMRBOWD);
FormRelease(FMRBOW);
FormRelease(FMRBOWF);
FormRelease(FMRBOWP);
end;
















procedure TFMRBOW.BitBtn1Click(Sender: TObject);
begin
IF FMRBOWD.QRBOWRBOUT.VALUE = FALSE THEN
IF MessageDlg('是否确定保存?',mtConfirmation,[mbYes,mbNo],0) =mrYES THEN
   begin

   //更新库存资料
   RBRN_CHECK_EXIST(BGENO.TEXT,RBPST.TEXT);
   FMMAIND.QUPD.SQL.Clear;
   FMMAIND.QUPD.SQL.ADD('UPDATE RBRN');
   FMMAIND.QUPD.SQL.ADD('SET');
   FMMAIND.QUPD.SQL.ADD(' RBCNT = RBCNT - '+RBCN1.TEXT+' ,');
   FMMAIND.QUPD.SQL.ADD(' RBDTU = '''+ DATETOSTR(DATE) +''', ');
   FMMAIND.QUPD.SQL.ADD(' RBTMU = '''+TIME_GET_24H(TIME)+''' ');
   FMMAIND.QUPD.SQL.ADD(' WHERE BGENO = '''+BGENO.TEXT+'''');
   FMMAIND.QUPD.SQL.ADD('   AND RBPST = '''+RBPST.TEXT+'''');
   try FMMAIND.QUPD.ExecSQL;
   except SHOWMESSAGE('RBRN 无法更新!');   end;

   FMRBOWD.QRBOW.Edit;
   FMRBOWD.QRBOWRBOUT.VALUE := TRUE;
   FM_DB_QUERY_POST(FMMAIND.DATABASE,FMRBOWD.QRBOW);

   end;

end;

procedure TFMRBOW.BitBtn2Click(Sender: TObject);
begin

IF FMRBOWD.QRBOWRBBCK.VALUE = FALSE THEN
IF MessageDlg('是否确定销单?',mtConfirmation,[mbYes,mbNo],0) =mrYES THEN
   begin

   //更新库存资料
   RBRN_CHECK_EXIST(BGENO.TEXT,RBPST.TEXT);
   FMMAIND.QUPD.SQL.Clear;
   FMMAIND.QUPD.SQL.ADD('UPDATE RBRN');
   FMMAIND.QUPD.SQL.ADD('SET');
   FMMAIND.QUPD.SQL.ADD(' RBCNT = RBCNT + '+RBCN2.TEXT+' ,');
   FMMAIND.QUPD.SQL.ADD(' RBDTU = '''+ DATETOSTR(DATE) +''', ');
   FMMAIND.QUPD.SQL.ADD(' RBTMU = '''+TIME_GET_24H(TIME)+''' ');
   FMMAIND.QUPD.SQL.ADD(' WHERE BGENO = '''+BGENO.TEXT+'''');
   FMMAIND.QUPD.SQL.ADD('   AND RBPST = '''+RBPST.TEXT+'''');
   try FMMAIND.QUPD.ExecSQL;
   except SHOWMESSAGE('RBRN 无法更新!');   end;

   FMRBOWD.QRBOW.Edit;
   FMRBOWD.QRBOWRBBCK.VALUE := TRUE;
   FM_DB_QUERY_POST(FMMAIND.DATABASE,FMRBOWD.QRBOW);
   end;
end;

procedure TFMRBOW.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
GRID_DRAWCOLUMNCELL(Sender, Rect, DataCol, Column, State,True_bmp, False_bmp, Blank_bmp);
end;

end.
 
