unit UNRGET;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBCtrls, StdCtrls, Mask, Grids, DBGrids, ComCtrls, Buttons, ToolWin,
  JLOOKUPD, JEdit, ExtCtrls;

type
  TFMRGET = class(TForm)
    StatusBar: TStatusBar;
    Panel1: TPanel;
    RGREA: JDBLOOKUPBOX;
    AREA_TOOL: TPanel;
    BTNQUT: TBitBtn;
    BTNINS: TBitBtn;
    BTNUPD: TBitBtn;
    BTNDEL: TBitBtn;
    BTNYES: TBitBtn;
    BTNCAL: TBitBtn;
    BTNSER: TBitBtn;
    BTNPRN: TBitBtn;
    LBRGENO: TLabel;
    RGENO: TJDBEDIT;
    LBBGENO: TLabel;
    LBRBPST: TLabel;
    LBRGREA: TLabel;
    LBRGDAT: TLabel;
    RGDAT: TJDBEDIT;
    LBRGTME: TLabel;
    RGTME: TJDBEDIT;
    LBBNENO: TLabel;
    RGMRK: TJDBEDIT;
    LBRGMRK: TLabel;
    RBPST: JDBLOOKUPBOX;
    BNENO: JDBLOOKUPBOX;
    BGENO: JDBLOOKUPBOX;
    LBRGCNT: TLabel;
    RGCNT: TJDBEDIT;
    DBGrid1: TDBGrid;
    LBRGOUT: TLabel;
    RGOUT: TDBCheckBox;
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
  FMRGET: TFMRGET;

implementation

uses sysini, un_utl, fm_utl, DB_UTL, MAIND, MAINU, 
     UNRGETD, UNRGETF, UNRGETP
       ;
{$R *.DFM}



procedure TFMRGET.BTNMODE;
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

procedure TFMRGET.INSERTMODE;
begin
FORMMODE := 'INS';
BTNMODE;

RGENO.Enabled := TRUE;
BGENO.Enabled := TRUE;
RGCNT.Enabled := TRUE;
RBPST.Enabled := TRUE;
RGREA.Enabled := TRUE;
RGDAT.Enabled := TRUE;
RGTME.Enabled := TRUE;
BNENO.Enabled := TRUE;
RGMRK.Enabled := TRUE;
//RGOUT.Enabled := TRUE;

DBGRID1.Enabled := FALSE;
RGENO.SetFocus;
end;

procedure TFMRGET.UPDATEMODE;
begin
FORMMODE := 'UPD';
BTNMODE;

//RGENO.Enabled := TRUE;
BGENO.Enabled := TRUE;
RGCNT.Enabled := TRUE;
RBPST.Enabled := TRUE;
RGREA.Enabled := TRUE;
RGDAT.Enabled := TRUE;
RGTME.Enabled := TRUE;
BNENO.Enabled := TRUE;
RGMRK.Enabled := TRUE;
//RGOUT.Enabled := TRUE;

DBGRID1.Enabled := FALSE;
BGENO.SetFocus;
end;

procedure TFMRGET.NORMALMODE;
begin
FORMMODE := 'CAN';
BTNMODE;

RGENO.Enabled := FALSE;
BGENO.Enabled := FALSE;
RGCNT.Enabled := FALSE;
RBPST.Enabled := FALSE;
RGREA.Enabled := FALSE;
RGDAT.Enabled := FALSE;
RGTME.Enabled := FALSE;
BNENO.Enabled := FALSE;
RGMRK.Enabled := FALSE;
RGOUT.Enabled := FALSE;

DBGRID1.Enabled := TRUE;
end;


procedure TFMRGET.FormCreate(Sender: TObject);
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

     FMRGETD.QRGET.SQL.CLEAR;
     FMRGETD.QRGET.SQL.ADD('SELECT *  ');
     FMRGETD.QRGET.SQL.ADD('FROM RGET ');
     FMRGETD.QRGET.SQL.ADD('WHERE RGOUT = 0 ');
     FMRGETD.QRGET.SQL.ADD('ORDER BY RGENO');

     FMRGETD.URGET.InsertSQL.CLEAR;
     FMRGETD.URGET.InsertSQL.Add('INSERT INTO RGET ');
     FMRGETD.URGET.InsertSQL.Add(' ( RGENO, BGENO, RGCNT, RBPST, RGREA, RGDAT, RGTME, BNENO, RGMRK, RGOUT ) ');
     FMRGETD.URGET.InsertSQL.Add('VALUES ');
     FMRGETD.URGET.InsertSQL.Add(' (:RGENO,:BGENO,:RGCNT,:RBPST,:RGREA,:RGDAT,:RGTME,:BNENO,:RGMRK,:RGOUT  ) ');

     FMRGETD.URGET.ModifySQL.CLEAR;
     FMRGETD.URGET.ModifySQL.Add('UPDATE RGET ');
     FMRGETD.URGET.ModifySQL.Add('SET ');
     FMRGETD.URGET.ModifySQL.Add('RGENO = :RGENO ,');
     FMRGETD.URGET.ModifySQL.Add('BGENO = :BGENO ,');
     FMRGETD.URGET.ModifySQL.Add('RGCNT = :RGCNT ,');
     FMRGETD.URGET.ModifySQL.Add('RBPST = :RBPST ,');
     FMRGETD.URGET.ModifySQL.Add('RGREA = :RGREA ,');
     FMRGETD.URGET.ModifySQL.Add('RGDAT = :RGDAT ,');
     FMRGETD.URGET.ModifySQL.Add('RGTME = :RGTME ,');
     FMRGETD.URGET.ModifySQL.Add('BNENO = :BNENO ,');
     FMRGETD.URGET.ModifySQL.Add('RGMRK = :RGMRK ,');
     FMRGETD.URGET.ModifySQL.Add('RGOUT = :RGOUT  ');
     FMRGETD.URGET.ModifySQL.Add('WHERE RGENO = :OLD_RGENO');

     FMRGETD.URGET.DeleteSQL.CLEAR;
     FMRGETD.URGET.DeleteSQL.Add('DELETE FROM RGET ');
     FMRGETD.URGET.DeleteSQL.Add('WHERE RGENO = :OLD_RGENO');

     FMRGETD.QRGET.CLOSE;
     FMRGETD.QRGET.OPEN;

end;

procedure TFMRGET.FormActivate(Sender: TObject);
begin
//PAGE_A.SHOW;
NORMALMODE;
end;

procedure TFMRGET.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  //Form 要结束前的询问(系统事件)
  CanClose := True;
  if (FORMMODE = 'INS' ) or (FORMMODE = 'UPD' ) then
    begin
    MessageDlg('请先结束输入模式后再退出!',mtConfirmation,[mbOk],0);
    CanClose := False;
    end;

end;



procedure TFMRGET.BTNINSClick(Sender: TObject);
begin
//试用版记录数限定
IF CHECK_DEMO_VERSION_RECCNT('RGET') = FALSE THEN EXIT;

//检查权限============================================
if PERMISSION_CHECK(_USER_ID, 'UNRGETI') = FALSE then
   EXIT;

INSERTMODE;

  WITH FMRGETD DO
    BEGIN
    QRGET.APPEND;

    QRGETRGENO.VALUE := TABLEFINDMAXCNT('RGET','RGENO',4,1);
    QRGETBGENO.VALUE := ''  ;
    QRGETRGCNT.VALUE := 1  ;
    QRGETRBPST.VALUE := _SYS_RBPST;
    QRGETRGREA.VALUE := '001'  ;
    QRGETRGDAT.VALUE := DATE;
    QRGETRGTME.VALUE := TIME_GET_24H(TIME);
    QRGETBNENO.VALUE := _USER_ID  ;
    QRGETRGMRK.VALUE := ''  ;
    QRGETRGOUT.VALUE := FALSE;
    END;

end;

procedure TFMRGET.BTNUPDClick(Sender: TObject);
begin
//检查权限============================================
if PERMISSION_CHECK(_USER_ID, 'UNRGETU') = FALSE then
   EXIT;

UPDATEMODE;
FMRGETD.QRGET.Edit;
end;

procedure TFMRGET.BTNDELClick(Sender: TObject);
begin
//检查权限============================================
if PERMISSION_CHECK(_USER_ID, 'UNRGETD') = FALSE then
   EXIT;

NORMALMODE;


    IF MessageDlg('是否确定要删除此条记录吗?',mtWarning, [mbYes, mbNo], 0) = mrYes then
    BEGIN
      IF MessageDlg('如果您按下确定按钮此条记录将会被删除',mtWarning, [mbYes, mbNo], 0) = mrYes then
      BEGIN
        FMRGETD.QRGET.Delete;
        FM_DB_QUERY_UPDATE(FMMAIND.DATABASE,FMRGETD.QRGET);
        NORMALMODE;
      END;
    END;

end;

procedure TFMRGET.BTNYESClick(Sender: TObject);
begin

//检查空白字段
IF FM_CHECK_FIELD_BLANK(RGENO .Text,LBRGENO .Caption ,LBRGENO .Caption + ' 此栏不可输入空白!') = FALSE THEN EXIT;
IF FM_CHECK_FIELD_BLANK(BNENO .Text,LBBNENO .Caption ,LBBNENO .Caption + ' 此栏不可输入空白!') = FALSE THEN EXIT;

//检查重复
if (FORMMODE = 'INS' ) then
if TABLECHECK_RE1('RGET','RGENO',RGENO.Text) > 0 THEN
   begin
   SHOWMESSAGE('此编号已经重复使用!');
   EXIT;
   end;




Case MessageDlg('是否确定存储此条记录?',mtConfirmation,[mbYes,mbNo,mbCancel],0) of
 mrYES :begin
        NORMALMODE;
        FM_DB_QUERY_POST(FMMAIND.DATABASE,FMRGETD.QRGET);
        end;
 mrNO  :begin
        FMRGETD.QRGET.Cancel;
        NORMALMODE;
        end;

end;


end;

procedure TFMRGET.BTNCALClick(Sender: TObject);
begin

 IF MessageDlg('确定不新增本条记录?',mtConfirmation,[mbYes,mbNo],0)=mrYes Then
    begin
    FMRGETD.QRGET.Cancel;
    NORMALMODE;
    end;

end;

procedure TFMRGET.BTNSERClick(Sender: TObject);
begin
//检查权限============================================
if PERMISSION_CHECK(_USER_ID, 'UNRGETS') = FALSE then
   EXIT;

NORMALMODE;
FMRGETF.SearchFORMMODE  := 'SEARCH';
FMRGETF.Caption := '查询';
FMRGETF.SHOWMODAL;
end;

procedure TFMRGET.BTNPRNClick(Sender: TObject);
begin
//检查权限============================================
if PERMISSION_CHECK(_USER_ID, 'UNRGETP') = FALSE then
   EXIT;

NORMALMODE;
FMRGETF.SearchFORMMODE  := 'PRINT';
FMRGETF.Caption := '打印';
FMRGETF.SHOWMODAL;
end;

procedure TFMRGET.BTNQUTClick(Sender: TObject);
begin
NORMALMODE;
close;
end;


procedure TFMRGET.FormClose(Sender: TObject; var Action: TCloseAction);
begin
DataModuleRelease(FMRGETD);
FormRelease(FMRGET);
FormRelease(FMRGETF);
FormRelease(FMRGETP);
end;
















procedure TFMRGET.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
GRID_DRAWCOLUMNCELL(Sender, Rect, DataCol, Column, State,True_bmp, False_bmp, Blank_bmp);

end;

procedure TFMRGET.BitBtn1Click(Sender: TObject);
begin

IF FMRGETD.QRGETRGOUT.VALUE = FALSE THEN
IF MessageDlg('是否确定保存?',mtConfirmation,[mbYes,mbNo],0) =mrYES THEN
   begin

   //更新库存资料
   RBRN_CHECK_EXIST(BGENO.TEXT,RBPST.TEXT);
   FMMAIND.QUPD.SQL.Clear;
   FMMAIND.QUPD.SQL.ADD('UPDATE RBRN');
   FMMAIND.QUPD.SQL.ADD('SET');
   FMMAIND.QUPD.SQL.ADD(' RBCNT = RBCNT - '+RGCNT.TEXT+' ,');
   FMMAIND.QUPD.SQL.ADD(' RBDTU = '''+ DATETOSTR(DATE) +''', ');
   FMMAIND.QUPD.SQL.ADD(' RBTMU = '''+TIME_GET_24H(TIME)+''' ');
   FMMAIND.QUPD.SQL.ADD(' WHERE BGENO = '''+BGENO.TEXT+'''');
   FMMAIND.QUPD.SQL.ADD('   AND RBPST = '''+RBPST.TEXT+'''');
   try FMMAIND.QUPD.ExecSQL;
   except SHOWMESSAGE('RBRN 无法更新!');   end;

   FMRGETD.QRGET.Edit;
   FMRGETD.QRGETRGOUT.VALUE := TRUE;
   FM_DB_QUERY_POST(FMMAIND.DATABASE,FMRGETD.QRGET);

   end;


end;

end.
 
