unit UNBCST;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, JLOOKUPD, SELOOKUPD, Menus, Grids, DBGrids, Mask,
  DBCtrls, JEdit, ExtCtrls, ComCtrls;

type

  TFMBCST = class(TForm)
    StatusBar: TStatusBar;
    Panel2: TPanel;
    BCMRK: TDBMemo;
    MainMenu: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    LBBCENO: TLabel;
    LBBCNAM: TLabel;
    LBBNENO: TLabel;
    LBBCSCN: TLabel;
    LBBCMN1: TLabel;
    LBBCMN2: TLabel;
    LBBCMN3: TLabel;
    LBBCCNA: TLabel;
    LBBCTL1: TLabel;
    LBBCTL2: TLabel;
    LBBCFX1: TLabel;
    LBBCFX2: TLabel;
    LBBCAD1: TLabel;
    LBBCAD2: TLabel;
    LBBCTL9: TLabel;
    LBBCAD9: TLabel;
    LBBCZP1: TLabel;
    LBBCZP2: TLabel;
    LBBCZP9: TLabel;
    LBBCDIS: TLabel;
    LBBCTP1: TLabel;
    LBBCTP2: TLabel;
    LBBCTP5: TLabel;
    LBBCTP6: TLabel;
    LBBCALT: TLabel;
    LBBCTDT: TLabel;
    LBBCDAT: TLabel;
    LBBCID1: TLabel;
    LBBCTTD: TLabel;
    LBBCMRK: TLabel;
    LBBCTBK: TLabel;
    LBBCTPN: TLabel;
    LBBCTTP: TLabel;
    LBBCTEG: TLabel;
    BCENO: TJDBEdit;
    BCNAM: TJDBEdit;
    BCMN2: TJDBEdit;
    BCMN3: TJDBEdit;
    BCCNA: TJDBEdit;
    BCTL1: TJDBEdit;
    BCTL2: TJDBEdit;
    BCFX1: TJDBEdit;
    BCFX2: TJDBEdit;
    BCAD1: TJDBEdit;
    BCAD2: TJDBEdit;
    BCTL9: TJDBEdit;
    BCAD9: TJDBEdit;
    BCZP1: TJDBEdit;
    BCZP2: TJDBEdit;
    BCZP9: TJDBEdit;
    BCDIS: TJDBEdit;
    BCTP1: TJDBEdit;
    BCTP2: TJDBEdit;
    BCTP5: TJDBEdit;
    BCTP6: TJDBEdit;
    BCALT: TJDBEdit;
    BCTDT: TJDBEdit;
    BCDAT: TJDBEdit;
    BCID1: TJDBEdit;
    BCTTD: TJDBEdit;
    BCTPN: TJDBEdit;
    DBGrid: TDBGrid;
    BCMN1: TJDBEdit;
    BKKIN: SEDBLOOKUPBOX;
    SEDBLOOKUPBOX1: SEDBLOOKUPBOX;
    SEDBLOOKUPBOX2: SEDBLOOKUPBOX;
    SEDBLOOKUPBOX3: SEDBLOOKUPBOX;
    BNENO: JDBLOOKUPBOX;
    Panel1: TPanel;
    BTNQUT: TBitBtn;
    BTNCAL: TBitBtn;
    BTNYES: TBitBtn;
    BTNDEL: TBitBtn;
    BTNINS: TBitBtn;
    BTNPRN: TBitBtn;
    BTNSET: TBitBtn;
    BTNPRE: TBitBtn;
    N6: TMenuItem;
    MENPRE: TMenuItem;
    MENPRN: TMenuItem;
    LB_MAX: TLabel;
    GroupBox1: TGroupBox;
    LB1: TLabel;
    LB2: TLabel;
    LB3: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    LB11: TJEdit;
    LB31: TJEdit;
    LB12: TJEdit;
    LB32: TJEdit;
    LB21: TJEdit;
    LB22: TJEdit;
    LB41: TJEdit;
    LB42: TJEdit;
    LB51: TJEdit;
    LB52: TJEdit;
    LB61: TJEdit;
    LB62: TJEdit;
    LB71: TJEdit;
    LB72: TJEdit;
    BTNSER: TBitBtn;
    BTNCLR: TBitBtn;
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
    procedure BTNSETClick(Sender: TObject);
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
  FMBCST: TFMBCST;

implementation

uses SYSINI, FM_UTL, DB_UTL, MAIND, MAINU,
     UNBCSTD, UNREP1;
     
{$R *.DFM}

procedure TFMBCST.BTNMODE;
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
  BTNSET.Enabled := FALSE;
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
     BTNSET.Enabled := FALSE;
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
     BTNSET.Enabled := TRUE;
     BTNQUT.Enabled := TRUE;
     END;

  {新增才可改编号}         BCENO.Enabled := FALSE;
  IF FORMMODE = 'INS' THEN BCENO.Enabled := TRUE;
end;

procedure TFMBCST.INSERTMODE;
begin
  FORMMODE := 'INS';
  BTNMODE;
  BCENO.SetFocus;
end;

procedure TFMBCST.UPDATEMODE;
begin
  FORMMODE := 'UPD';
  BTNMODE;
end;

procedure TFMBCST.NORMALMODE;
begin
  FORMMODE := 'CAN';
  BTNMODE;
  DBGRID.SetFocus;
end;

procedure TFMBCST.FormCreate(Sender: TObject);
begin
  IF FormExists('FMBCSTD')=FALSE THEN Application.CreateForm(TFMBCSTD, FMBCSTD );
  
  //按钮图形加载
  BTNINS.Glyph := INS_TB;
  BTNDEL.Glyph := DEL_TB;
  BTNYES.Glyph := YES_TB;
  BTNCAL.Glyph := CAL_TB;
  BTNSER.Glyph := SER_TB;
  BTNCLR.Glyph := CLR_TB;
  BTNPRE.Glyph := PRE_TB;
  BTNPRN.Glyph := PRN_TB;
  BTNSET.Glyph := SET_TB;
  BTNQUT.Glyph := QUT_TB;
  
  FMBCSTD.UBCST.InsertSQL.CLEAR;
  FMBCSTD.UBCST.InsertSQL.Add('INSERT INTO BCST ');
  FMBCSTD.UBCST.InsertSQL.Add(' ( BCENO, BCNAM, BCCNA, BCSCN, BCMN1, BCMN2, BCMN3, BCTL1, BCTL2, BCFX1, BCFX2, BCAD1, BCAD2, BCTL9, BCAD9, BCDIS, BCTP1, BCTP2, BCTP5, BCTP6, BCTPN, BCTTP, BCTTD,');
  FMBCSTD.UBCST.InsertSQL.Add('   BCALT, BCTDT, BCDAT, BCID1, BCMRK, BNENO, BCTEG, BCTBK, BCZP1, BCZP2, BCZP9 ) ');
  FMBCSTD.UBCST.InsertSQL.Add('VALUES ');
  FMBCSTD.UBCST.InsertSQL.Add(' (:BCENO,:BCNAM,:BCCNA,:BCSCN,:BCMN1,:BCMN2,:BCMN3,:BCTL1,:BCTL2,:BCFX1,:BCFX2,:BCAD1,:BCAD2,:BCTL9,:BCAD9,:BCDIS,:BCTP1,:BCTP2,:BCTP5,:BCTP6,:BCTPN,:BCTTP,:BCTTD,');
  FMBCSTD.UBCST.InsertSQL.Add('  :BCALT,:BCTDT,:BCDAT,:BCID1,:BCMRK,:BNENO,:BCTEG,:BCTBK,:BCZP1,:BCZP2,:BCZP9 ) ');

  FMBCSTD.UBCST.ModifySQL.CLEAR;
  FMBCSTD.UBCST.ModifySQL.Add('UPDATE BCST ');
  FMBCSTD.UBCST.ModifySQL.Add('SET ');
  FMBCSTD.UBCST.ModifySQL.Add('BCENO = :BCENO ,');
  FMBCSTD.UBCST.ModifySQL.Add('BCNAM = :BCNAM ,');
  FMBCSTD.UBCST.ModifySQL.Add('BCCNA = :BCCNA ,');
  FMBCSTD.UBCST.ModifySQL.Add('BCSCN = :BCSCN ,');
  FMBCSTD.UBCST.ModifySQL.Add('BCMN1 = :BCMN1 ,');
  FMBCSTD.UBCST.ModifySQL.Add('BCMN2 = :BCMN2 ,');
  FMBCSTD.UBCST.ModifySQL.Add('BCMN3 = :BCMN3 ,');
  FMBCSTD.UBCST.ModifySQL.Add('BCTL1 = :BCTL1 ,');
  FMBCSTD.UBCST.ModifySQL.Add('BCTL2 = :BCTL2 ,');
  FMBCSTD.UBCST.ModifySQL.Add('BCFX1 = :BCFX1 ,');
  FMBCSTD.UBCST.ModifySQL.Add('BCFX2 = :BCFX2 ,');
  FMBCSTD.UBCST.ModifySQL.Add('BCAD1 = :BCAD1 ,');
  FMBCSTD.UBCST.ModifySQL.Add('BCAD2 = :BCAD2 ,');
  FMBCSTD.UBCST.ModifySQL.Add('BCZP1 = :BCZP1 ,');
  FMBCSTD.UBCST.ModifySQL.Add('BCZP2 = :BCZP2 ,');
  FMBCSTD.UBCST.ModifySQL.Add('BCZP9 = :BCZP9 ,');
  FMBCSTD.UBCST.ModifySQL.Add('BCTL9 = :BCTL9 ,');
  FMBCSTD.UBCST.ModifySQL.Add('BCAD9 = :BCAD9 ,');
  FMBCSTD.UBCST.ModifySQL.Add('BCDIS = :BCDIS ,');
  FMBCSTD.UBCST.ModifySQL.Add('BCTP1 = :BCTP1 ,');
  FMBCSTD.UBCST.ModifySQL.Add('BCTP2 = :BCTP2 ,');
  FMBCSTD.UBCST.ModifySQL.Add('BCTP5 = :BCTP5 ,');
  FMBCSTD.UBCST.ModifySQL.Add('BCTP6 = :BCTP6 ,');
  FMBCSTD.UBCST.ModifySQL.Add('BCTPN = :BCTPN ,');
  FMBCSTD.UBCST.ModifySQL.Add('BCTTP = :BCTTP ,');
  FMBCSTD.UBCST.ModifySQL.Add('BCTTD = :BCTTD ,');
  FMBCSTD.UBCST.ModifySQL.Add('BCALT = :BCALT ,');
  FMBCSTD.UBCST.ModifySQL.Add('BCTDT = :BCTDT ,');
  FMBCSTD.UBCST.ModifySQL.Add('BCDAT = :BCDAT ,');
  FMBCSTD.UBCST.ModifySQL.Add('BCID1 = :BCID1 ,');
  FMBCSTD.UBCST.ModifySQL.Add('BNENO = :BNENO ,');
  FMBCSTD.UBCST.ModifySQL.Add('BCTEG = :BCTEG ,');
  FMBCSTD.UBCST.ModifySQL.Add('BCTBK = :BCTBK  ');
  FMBCSTD.UBCST.ModifySQL.Add('WHERE BCENO = :OLD_BCENO');
  
  FMBCSTD.UBCST.DeleteSQL.CLEAR;
  FMBCSTD.UBCST.DeleteSQL.Add('DELETE FROM BCST ');
  FMBCSTD.UBCST.DeleteSQL.Add('WHERE BCENO = :OLD_BCENO');
  
  FMBCSTD.QBCST.SQL.CLEAR;
  FMBCSTD.QBCST.SQL.ADD('SELECT * FROM BCST ');
  FMBCSTD.QBCST.SQL.ADD('ORDER BY BCENO ');
  FMBCSTD.QBCST.Close;
  FMBCSTD.QBCST.Open;

  LB_MAX.CAPTION := '最大编号'+CHECK_BASE_TABLE_NO('BCST','BCENO');
end;

procedure TFMBCST.FormShow(Sender: TObject);
begin
  NORMALMODE;
end;

procedure TFMBCST.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  //Form 要结束前的询问(系统事件)
  CanClose := True;
  if (FORMMODE = 'INS' ) or (FORMMODE = 'UPD' ) then
    begin
    MessageDlg('请先结束输入模式后再退出!',mtConfirmation,[mbOk],0);
    CanClose := False;
    end;
end;

procedure TFMBCST.BTNQUTClick(Sender: TObject);
begin
  NORMALMODE;
  CLOSE;
end;

procedure TFMBCST.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DataModuleRelease(FMBCSTD);
  FormRelease(FMBCST);
  FormFREE('FMBCSTP');
end;

procedure TFMBCST.BTNINSClick(Sender: TObject);
begin
  //检查权限============================================
  IF PERMISSION_CHECK(_USER_ID,'BCST_INS') = FALSE THEN EXIT;

  INSERTMODE;

  WITH FMBCSTD DO
    BEGIN
    QBCST.APPEND;
    QBCSTBCENO.VALUE := ''  ;
    QBCSTBCNAM.VALUE := ''  ;
    QBCSTBCCNA.VALUE := ''  ;
    QBCSTBCSCN.VALUE := ''  ;
    QBCSTBCMN1.VALUE := ''  ;
    QBCSTBCMN2.VALUE := ''  ;
    QBCSTBCMN3.VALUE := ''  ;
    QBCSTBCTL1.VALUE := ''  ;
    QBCSTBCTL2.VALUE := ''  ;
    QBCSTBCFX1.VALUE := ''  ;
    QBCSTBCFX2.VALUE := ''  ;
    QBCSTBCAD1.VALUE := ''  ;
    QBCSTBCAD2.VALUE := ''  ;
    QBCSTBCTL9.VALUE := ''  ;
    QBCSTBCAD9.VALUE := ''  ;
    QBCSTBCDIS.VALUE := 1   ;
    QBCSTBCTP1.VALUE := 0   ;
    QBCSTBCTP2.VALUE := 0   ;
    QBCSTBCTP5.VALUE := 0   ;
    QBCSTBCTP6.VALUE := 0   ;
    QBCSTBCTPN.VALUE := ''  ;
    QBCSTBCTTP.VALUE := ''  ;
    QBCSTBCTTD.VALUE := 0   ;
    QBCSTBCALT.VALUE := 0   ;
    QBCSTBCDAT.VALUE := DATE;
    QBCSTBCID1.VALUE := ''  ;
    QBCSTBCMRK.VALUE := ''  ;
    QBCSTBNENO.VALUE := _USER_ID  ;
    QBCSTBCTEG.VALUE := 'TW'  ;
    QBCSTBCTBK.VALUE := ''  ;
    QBCSTBCZP1.VALUE := ''  ;
    QBCSTBCZP2.VALUE := ''  ;
    QBCSTBCZP9.VALUE := ''  ;
    END;
end;

procedure TFMBCST.BTNDELClick(Sender: TObject);
begin
  //检查权限============================================
  IF PERMISSION_CHECK(_USER_ID,'BCST_DEL') = FALSE THEN EXIT;
  
  IF MessageDlg('是否确定要删除此条记录吗?',mtWarning, [mbYes, mbNo], 0) = mrYes then
     IF MessageDlg('如果您按下取定按钮此条记录将会被删除',mtWarning, [mbYes, mbNo], 0) = mrYes then
        BEGIN
        FMBCSTD.QBCST.Delete;
        FM_DB_QUERY_UPDATE(FMMAIND.DATABASE,FMBCSTD.QBCST);
        NORMALMODE;
        END;
  LB_MAX.CAPTION := '最大编号'+CHECK_BASE_TABLE_NO('BCST','BCENO');
end;

procedure TFMBCST.BTNYESClick(Sender: TObject);
begin
  //检查权限============================================
  IF PERMISSION_CHECK(_USER_ID,'BCST_UPD') = FALSE THEN EXIT;
  
  //检查重复
  if (FORMMODE = 'INS' ) then
  if TABLECHECK_RE1('BCST','BCENO',BCENO.Text) > 0 THEN
     begin
     SHOWMESSAGE('此编号已经重复使用!');  EXIT;
     end;
  
  
  Case MessageDlg('是否确定存储此条记录?',mtConfirmation,[mbYes,mbNo,mbCancel],0) of
   mrYES :begin
          NORMALMODE;
          FM_DB_QUERY_POST(FMMAIND.DATABASE,FMBCSTD.QBCST);
  
          // 更新 MEMO 的资料
          FMMAIND.QUPD.SQL.CLEAR;
          FMMAIND.QUPD.SQL.ADD('UPDATE BCST SET');
          FMMAIND.QUPD.SQL.ADD('BCMRK = '''+StringReplace(BCMRK.TEXT,'''','"',[rfReplaceAll])+''' ');
          FMMAIND.QUPD.SQL.ADD('WHERE BCENO = '''+BCENO.TEXT+''' ');
          FMMAIND.QUPD.ExecSQL;
  
          end;
   mrNO  :begin
          NORMALMODE;
          FMBCSTD.QBCST.Cancel;
          end;
  END;

  LB_MAX.CAPTION := '最大编号'+CHECK_BASE_TABLE_NO('BCST','BCENO');
end;

procedure TFMBCST.BTNCALClick(Sender: TObject);
begin
  NORMALMODE;
  FMBCSTD.QBCST.Cancel;
end;

procedure TFMBCST.BTNSERClick(Sender: TObject);
begin
  //检查权限============================================
  IF PERMISSION_CHECK(_USER_ID,'BCST_SEA') = FALSE THEN EXIT;

  WITH FMBCSTD.QBCST DO
    BEGIN
    CLOSE;
    SQL.CLEAR;
    SQL.ADD('SELECT * FROM BCST');
    SQL.ADD('WHERE BCENO IS NOT NULL');
    IF _SUPER_USER = FALSE THEN FMBCSTD.QBCST.SQL.ADD('AND BNENO = '''+ _USER_ID +'''');

    //字符串查询
    SQL.ADD(FINDFORM_WHEREKEY_STRING('BCENO',LB11.Text,LB12.Text));
    SQL.ADD(FINDFORM_WHEREKEY_STRING('BCNAM',LB21.Text,LB22.Text));
    SQL.ADD(FINDFORM_WHEREKEY_STRING('BCMN1',LB31.Text,LB32.Text));
    SQL.ADD(FINDFORM_WHEREKEY_STRING('BCTL1',LB41.Text,LB42.Text));
    SQL.ADD(FINDFORM_WHEREKEY_STRING('BCTL2',LB51.Text,LB52.Text));
    SQL.ADD(FINDFORM_WHEREKEY_STRING('BCAD1',LB61.Text,LB62.Text));
    SQL.ADD(FINDFORM_WHEREKEY_STRING('BCAD2',LB71.Text,LB72.Text));
    OPEN;
    END;
end;

procedure TFMBCST.BTNCLRClick(Sender: TObject);
begin
  LB11.Clear;
  LB12.Clear;
  LB21.Clear;
  LB22.Clear;
  LB31.Clear;
  LB32.Clear;
  LB41.Clear;
  LB42.Clear;
  LB51.Clear;
  LB52.Clear;
  LB61.Clear;
  LB62.Clear;
  LB71.Clear;
  LB72.Clear;
end;

procedure TFMBCST.BTNPRNClick(Sender: TObject);
begin
  //检查权限============================================
  IF PERMISSION_CHECK(_USER_ID,'BCST_PRN') = FALSE THEN EXIT;

  IF FormExists('FMREP1')=FALSE THEN Application.CreateForm(TFMREP1, FMREP1 );
  FMREP1.QR_NAME := ExtractFilePath(Application.EXEName)+'/ini/QREP_BCST.ini';
  FMREP1.ED_PAGE_TABLE.TEXT := 'BCST';

  FMREP1.QUERY.SQL.CLEAR;
  FMREP1.QUERY.SQL.TEXT := FMBCSTD.QBCST.SQL.TEXT;
  FMREP1.QUERY.CLOSE;
  FMREP1.QUERY.OPEN;

  FMREP1.LOAD_INI;

  IF SENDER = BTNPRE THEN FMREP1.QuickRep.Preview;
  IF SENDER = MENPRE THEN FMREP1.QuickRep.Preview;
  IF SENDER = BTNPRN THEN FMREP1.QuickRep.Print;
  IF SENDER = MENPRN THEN FMREP1.QuickRep.Print;
end;

procedure TFMBCST.BTNSETClick(Sender: TObject);
begin
  IF FormExists('FMREP1' )=FALSE THEN Application.CreateForm(TFMREP1, FMREP1 );
  FMREP1.QR_NAME := ExtractFilePath(Application.EXEName)+'/ini/QREP_BCST.ini';
  FMREP1.ED_PAGE_TABLE.TEXT := 'BCST';
  Form_NORMAL_SHOWMODAL(FMREP1,-1,-1);
end;

end.
