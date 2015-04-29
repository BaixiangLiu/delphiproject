unit UNBMAN;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, Grids, DBGrids, StdCtrls, DBCtrls, SELOOKUPD, JLOOKUPD, Mask,
  JEdit, ExtCtrls, ComCtrls, Buttons;

type

  TFMBMAN = class(TForm)
    StatusBar: TStatusBar;
    Panel2: TPanel;
    MainMenu: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    MENPRE: TMenuItem;
    MENPRN: TMenuItem;
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
    Page: TPageControl;
    PAGE_A: TTabSheet;
    LBBNCNA: TLabel;
    LBBNBTH: TLabel;
    LBBNCTY: TLabel;
    LBBNROT: TLabel;
    LBBNIDN: TLabel;
    LBBNPAS: TLabel;
    LBBNLIV: TLabel;
    LBBNSEX: TLabel;
    LBBNBLD: TLabel;
    LBBNSCS: TLabel;
    LBBNSDP: TLabel;
    LBBNCPL: TLabel;
    LBBNSCH: TLabel;
    LBBNHIS: TLabel;
    LBBNCMN: TLabel;
    LBBNREL: TLabel;
    LBBNTL1: TLabel;
    LBBNTL2: TLabel;
    LBBNTL3: TLabel;
    LBBNAD1: TLabel;
    LBBNVIC: TLabel;
    LBBNVIN: TLabel;
    LBBNAD2: TLabel;
    LBBNZP2: TLabel;
    LBBNZP1: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    LBBNENO: TLabel;
    LBBNNAM: TLabel;
    BNCNA: TJDBEdit;
    BNBTH: TJDBEdit;
    BNROT: TJDBEdit;
    BNIDN: TJDBEdit;
    BNPAS: TJDBEdit;
    BNLIV: TJDBEdit;
    BNSCH: TJDBEdit;
    BNHIS: TJDBEdit;
    BNSCS: JDBLOOKUPBOX;
    BNCMN: TJDBEdit;
    BNREL: TJDBEdit;
    BNTL1: TJDBEdit;
    BNTL3: TJDBEdit;
    BNAD1: TJDBEdit;
    BNVIN: TJDBEdit;
    BNAD2: TJDBEdit;
    BNTL2: TJDBEdit;
    BNZP2: TJDBEdit;
    BNZP1: TJDBEdit;
    BNENO: TJDBEdit;
    BNNAM: TJDBEdit;
    TabSheet6: TTabSheet;
    LBBNSEC: TLabel;
    LBBNCLS: TLabel;
    LBBNDPO: TLabel;
    LBBNDPT: TLabel;
    LBBNLLC: TLabel;
    LBBNSVR: TLabel;
    LBBNNUM: TLabel;
    LBBNLCC: TLabel;
    LBBNEPC: TLabel;
    LBBNTIT: TLabel;
    LBBNGRC: TLabel;
    LBBNC02: TLabel;
    LBBNFDY: TLabel;
    LBBNEDY: TLabel;
    LBBNHPS: TLabel;
    LBBNHPF: TLabel;
    LBBNHPV: TLabel;
    LBBNSPL: TLabel;
    LBBNSPN: TLabel;
    LBBNC03: TLabel;
    LBBNCHM: TLabel;
    LBBNLV2: TLabel;
    LBBNLV1: TLabel;
    LBBNTB1: TLabel;
    LBBNTB2: TLabel;
    LBBNIF1: TLabel;
    LBBNIF2: TLabel;
    LBBNHI1: TLabel;
    LBBNHI2: TLabel;
    LBBNISM: TLabel;
    LBBNHIM: TLabel;
    LBBNBNS: TLabel;
    LBBNBNO: TLabel;
    LBBNHIN: TLabel;
    LBBNHIX: TLabel;
    LBBNTBX: TLabel;
    LBBNSPP: TLabel;
    BNDPO: TJDBEdit;
    BNDPT: TJDBEdit;
    BNSVR: TJDBEdit;
    BNNUM: TJDBEdit;
    BNC02: TJDBEdit;
    BNFDY: TJDBEdit;
    BNEDY: TJDBEdit;
    BNHPS: TJDBEdit;
    BNHPF: TJDBEdit;
    BNHPV: TJDBEdit;
    BNSPL: TJDBEdit;
    BNSPN: TJDBEdit;
    BNC03: TJDBEdit;
    BNCHM: TJDBEdit;
    BNHBS: TDBCheckBox;
    BNLV2: TJDBEdit;
    BNLV1: TJDBEdit;
    BNTB1: TJDBEdit;
    BNTB2: TJDBEdit;
    BNIF1: TJDBEdit;
    BNIF2: TJDBEdit;
    BNHI1: TJDBEdit;
    BNHI2: TJDBEdit;
    BNISM: TJDBEdit;
    BNHIM: TJDBEdit;
    BNBNO: TJDBEdit;
    BNHIN: TJDBEdit;
    BNSPP: TJDBEdit;
    DBGrid: TDBGrid;
    BNSEX: SEDBLOOKUPBOX;
    BNBLD: SEDBLOOKUPBOX;
    BNCPL: SEDBLOOKUPBOX;
    BNCTY: SEDBLOOKUPBOX;
    BNSDP: SEDBLOOKUPBOX;
    BNVIC: SEDBLOOKUPBOX;
    BNBNS: SEDBLOOKUPBOX;
    BNCLS: SEDBLOOKUPBOX;
    BNLLC: SEDBLOOKUPBOX;
    BNEPC: SEDBLOOKUPBOX;
    BNTIT: SEDBLOOKUPBOX;
    BNLCC: SEDBLOOKUPBOX;
    BNSEC: SEDBLOOKUPBOX;
    BNGRC: SEDBLOOKUPBOX;
    BNHIX: SEDBLOOKUPBOX;
    BNTBX: SEDBLOOKUPBOX;
    Bevel3: TBevel;
    Bevel4: TBevel;
    LBBNPWD: TLabel;
    BNPWD: TEdit;
    BTNPMS: TBitBtn;
    N7: TMenuItem;
    LB_MAX: TLabel;
    BTNMSG: TBitBtn;
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
    procedure BNPWDKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BTNPMSClick(Sender: TObject);
    procedure BTNSETClick(Sender: TObject);
    procedure BTNMSGClick(Sender: TObject);
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
  FMBMAN: TFMBMAN;

implementation

uses SYSINI, UN_UTL, FM_UTL, DB_UTL, MAIND, MAINU,
     UNBMAND, UNBMANM, UNBMANG, UNREP1;
                                         
{$R *.DFM}

procedure TFMBMAN.BTNMODE;
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

  {新增才可改编号}         BNENO.Enabled := FALSE;
  IF FORMMODE = 'INS' THEN BNENO.Enabled := TRUE;
end;

procedure TFMBMAN.INSERTMODE;
begin
  FORMMODE := 'INS';
  BTNMODE;
  PAGE_A.Show;
  BNENO.SetFocus;
end;

procedure TFMBMAN.UPDATEMODE;
begin
  FORMMODE := 'UPD';
  BTNMODE;
end;

procedure TFMBMAN.NORMALMODE;
begin
  FORMMODE := 'CAN';
  BTNMODE;
  DBGRID.SetFocus;
end;

procedure TFMBMAN.FormCreate(Sender: TObject);
begin
  IF FormExists('FMBMAND')=FALSE THEN Application.CreateForm(TFMBMAND, FMBMAND );
  
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
  

  FMBMAND.UBMAN.InsertSQL.CLEAR;
  FMBMAND.UBMAN.InsertSQL.Add('INSERT INTO BMAN ');
  FMBMAND.UBMAN.InsertSQL.Add(' ( BNENO, BNNAM, BNPWD, BNCNA, BNBTH, BNCTY, BNROT, BNIDN, BNPAS, BNLIV, BNSEX, BNBLD, BNSCS, BNSDP, BNCPL, BNSPP, BNSCH, BNHIS, BNCMN, BNREL, BNTL1, BNTL2, BNTL3, BNAD1, BNAD2, BNVIC, BNVIN, BNSEC, BNCLS, BNDPO, BNDPT, BNLLC, ');
  FMBMAND.UBMAN.InsertSQL.Add('   BNSVR, BNNUM, BNLCC, BNEPC, BNTIT, BNGRC, BNBNS, BNBNO, BNC02, BNC03, BNFDY, BNEDY, BNHPS, BNHPF, BNCHM, BNHPV, BNSPL, BNSPN, BNLV1, BNLV2, BNTB1, BNTB2, BNIF1, BNIF2, BNHI1, BNHI2, BNHIX, BNTBX, BNISM, BNHIM, BNHIN, BNHBS, BNZP2, BNZP1 ) ');
  FMBMAND.UBMAN.InsertSQL.Add('   VALUES ');
  FMBMAND.UBMAN.InsertSQL.Add(' (:BNENO,:BNNAM,:BNPWD,:BNCNA,:BNBTH,:BNCTY,:BNROT,:BNIDN,:BNPAS,:BNLIV,:BNSEX,:BNBLD,:BNSCS,:BNSDP,:BNCPL,:BNSPP,:BNSCH,:BNHIS,:BNCMN,:BNREL,:BNTL1,:BNTL2,:BNTL3,:BNAD1,:BNAD2,:BNVIC,:BNVIN,:BNSEC,:BNCLS,:BNDPO,:BNDPT,:BNLLC, ');
  FMBMAND.UBMAN.InsertSQL.Add('  :BNSVR,:BNNUM,:BNLCC,:BNEPC,:BNTIT,:BNGRC,:BNBNS,:BNBNO,:BNC02,:BNC03,:BNFDY,:BNEDY,:BNHPS,:BNHPF,:BNCHM,:BNHPV,:BNSPL,:BNSPN,:BNLV1,:BNLV2,:BNTB1,:BNTB2,:BNIF1,:BNIF2,:BNHI1,:BNHI2,:BNHIX,:BNTBX,:BNISM,:BNHIM,:BNHIN,:BNHBS,:BNZP2,:BNZP1 ) ');

  FMBMAND.UBMAN.ModifySQL.CLEAR;
  FMBMAND.UBMAN.ModifySQL.Add('UPDATE BMAN ');
  FMBMAND.UBMAN.ModifySQL.Add('SET ');
  FMBMAND.UBMAN.ModifySQL.Add('BNENO = :BNENO ,');
  FMBMAND.UBMAN.ModifySQL.Add('BNNAM = :BNNAM ,');
  FMBMAND.UBMAN.ModifySQL.Add('BNPWD = :BNPWD ,');
  FMBMAND.UBMAN.ModifySQL.Add('BNCNA = :BNCNA ,');
  FMBMAND.UBMAN.ModifySQL.Add('BNBTH = :BNBTH ,');
  FMBMAND.UBMAN.ModifySQL.Add('BNCTY = :BNCTY ,');
  FMBMAND.UBMAN.ModifySQL.Add('BNROT = :BNROT ,');
  FMBMAND.UBMAN.ModifySQL.Add('BNIDN = :BNIDN ,');
  FMBMAND.UBMAN.ModifySQL.Add('BNPAS = :BNPAS ,');
  FMBMAND.UBMAN.ModifySQL.Add('BNLIV = :BNLIV ,');
  FMBMAND.UBMAN.ModifySQL.Add('BNSEX = :BNSEX ,');
  FMBMAND.UBMAN.ModifySQL.Add('BNBLD = :BNBLD ,');
  FMBMAND.UBMAN.ModifySQL.Add('BNSCS = :BNSCS ,');
  FMBMAND.UBMAN.ModifySQL.Add('BNSDP = :BNSDP ,');
  FMBMAND.UBMAN.ModifySQL.Add('BNCPL = :BNCPL ,');
  FMBMAND.UBMAN.ModifySQL.Add('BNSPP = :BNSPP ,');
  FMBMAND.UBMAN.ModifySQL.Add('BNSCH = :BNSCH ,');
  FMBMAND.UBMAN.ModifySQL.Add('BNHIS = :BNHIS ,');
  FMBMAND.UBMAN.ModifySQL.Add('BNCMN = :BNCMN ,');
  FMBMAND.UBMAN.ModifySQL.Add('BNREL = :BNREL ,');
  FMBMAND.UBMAN.ModifySQL.Add('BNTL1 = :BNTL1 ,');
  FMBMAND.UBMAN.ModifySQL.Add('BNTL2 = :BNTL2 ,');
  FMBMAND.UBMAN.ModifySQL.Add('BNTL3 = :BNTL3 ,');
  FMBMAND.UBMAN.ModifySQL.Add('BNAD1 = :BNAD1 ,');
  FMBMAND.UBMAN.ModifySQL.Add('BNAD2 = :BNAD2 ,');
  FMBMAND.UBMAN.ModifySQL.Add('BNZP2 = :BNZP2 ,');
  FMBMAND.UBMAN.ModifySQL.Add('BNZP1 = :BNZP1 ,');
  FMBMAND.UBMAN.ModifySQL.Add('BNVIC = :BNVIC ,');
  FMBMAND.UBMAN.ModifySQL.Add('BNVIN = :BNVIN ,');
  FMBMAND.UBMAN.ModifySQL.Add('BNSEC = :BNSEC ,');
  FMBMAND.UBMAN.ModifySQL.Add('BNCLS = :BNCLS ,');
  FMBMAND.UBMAN.ModifySQL.Add('BNDPO = :BNDPO ,');
  FMBMAND.UBMAN.ModifySQL.Add('BNDPT = :BNDPT ,');
  FMBMAND.UBMAN.ModifySQL.Add('BNLLC = :BNLLC ,');
  FMBMAND.UBMAN.ModifySQL.Add('BNSVR = :BNSVR ,');
  FMBMAND.UBMAN.ModifySQL.Add('BNNUM = :BNNUM ,');
  FMBMAND.UBMAN.ModifySQL.Add('BNLCC = :BNLCC ,');
  FMBMAND.UBMAN.ModifySQL.Add('BNEPC = :BNEPC ,');
  FMBMAND.UBMAN.ModifySQL.Add('BNTIT = :BNTIT ,');
  FMBMAND.UBMAN.ModifySQL.Add('BNGRC = :BNGRC ,');
  FMBMAND.UBMAN.ModifySQL.Add('BNBNS = :BNBNS ,');
  FMBMAND.UBMAN.ModifySQL.Add('BNBNO = :BNBNO ,');
  FMBMAND.UBMAN.ModifySQL.Add('BNC02 = :BNC02 ,');
  FMBMAND.UBMAN.ModifySQL.Add('BNC03 = :BNC03 ,');
  FMBMAND.UBMAN.ModifySQL.Add('BNFDY = :BNFDY ,');
  FMBMAND.UBMAN.ModifySQL.Add('BNEDY = :BNEDY ,');
  FMBMAND.UBMAN.ModifySQL.Add('BNHPS = :BNHPS ,');
  FMBMAND.UBMAN.ModifySQL.Add('BNHPF = :BNHPF ,');
  FMBMAND.UBMAN.ModifySQL.Add('BNCHM = :BNCHM ,');
  FMBMAND.UBMAN.ModifySQL.Add('BNHPV = :BNHPV ,');
  FMBMAND.UBMAN.ModifySQL.Add('BNSPL = :BNSPL ,');
  FMBMAND.UBMAN.ModifySQL.Add('BNSPN = :BNSPN ,');
  FMBMAND.UBMAN.ModifySQL.Add('BNLV1 = :BNLV1 ,');
  FMBMAND.UBMAN.ModifySQL.Add('BNLV2 = :BNLV2 ,');
  FMBMAND.UBMAN.ModifySQL.Add('BNTB1 = :BNTB1 ,');
  FMBMAND.UBMAN.ModifySQL.Add('BNTB2 = :BNTB2 ,');
  FMBMAND.UBMAN.ModifySQL.Add('BNIF1 = :BNIF1 ,');
  FMBMAND.UBMAN.ModifySQL.Add('BNIF2 = :BNIF2 ,');
  FMBMAND.UBMAN.ModifySQL.Add('BNHI1 = :BNHI1 ,');
  FMBMAND.UBMAN.ModifySQL.Add('BNHI2 = :BNHI2 ,');
  FMBMAND.UBMAN.ModifySQL.Add('BNHIX = :BNHIX ,');
  FMBMAND.UBMAN.ModifySQL.Add('BNTBX = :BNTBX ,');
  FMBMAND.UBMAN.ModifySQL.Add('BNISM = :BNISM ,');
  FMBMAND.UBMAN.ModifySQL.Add('BNHIM = :BNHIM ,');
  FMBMAND.UBMAN.ModifySQL.Add('BNHIN = :BNHIN ,');
  FMBMAND.UBMAN.ModifySQL.Add('BNHBS = :BNHBS  ');
  FMBMAND.UBMAN.ModifySQL.Add('WHERE BNENO = :OLD_BNENO');
  
  FMBMAND.UBMAN.DeleteSQL.CLEAR;
  FMBMAND.UBMAN.DeleteSQL.Add('DELETE FROM BMAN ');
  FMBMAND.UBMAN.DeleteSQL.Add('WHERE BNENO = :OLD_BNENO');
  
  
  FMBMAND.QBMAN.SQL.CLEAR;
  FMBMAND.QBMAN.SQL.ADD('SELECT * FROM BMAN ');
  FMBMAND.QBMAN.SQL.ADD('ORDER BY BNENO ');
  FMBMAND.QBMAN.Close;
  FMBMAND.QBMAN.Open;
end;

procedure TFMBMAN.FormShow(Sender: TObject);
begin
  NORMALMODE;
end;

procedure TFMBMAN.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  //Form 要结束前的询问(系统事件)
  CanClose := True;
  if (FORMMODE = 'INS' ) or (FORMMODE = 'UPD' ) then
    begin
    MessageDlg('请先结束输入模式后再退出!',mtConfirmation,[mbOk],0);
    CanClose := False;
    end;
end;

procedure TFMBMAN.BTNQUTClick(Sender: TObject);
begin
  NORMALMODE;
  close;
end;

procedure TFMBMAN.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DataModuleRelease(FMBMAND);
  FormRelease(FMBMAN);
  FormFREE('FMBMANP');
end;

procedure TFMBMAN.BTNINSClick(Sender: TObject);
begin
  //检查权限============================================
  IF PERMISSION_CHECK(_USER_ID,'BMAN_INS') = FALSE THEN EXIT;
  
  INSERTMODE;
  
  WITH FMBMAND DO
    BEGIN
    QBMAN.APPEND;
    QBMANBNENO.VALUE := ''  ;
    QBMANBNNAM.VALUE := ''  ;
    QBMANBNPWD.VALUE := ''  ;
    QBMANBNCNA.VALUE := ''  ;
    QBMANBNCTY.VALUE := ''  ;
    QBMANBNROT.VALUE := ''  ;
    QBMANBNIDN.VALUE := ''  ;
    QBMANBNPAS.VALUE := ''  ;
    QBMANBNLIV.VALUE := ''  ;
    QBMANBNSEX.VALUE := ''  ;
    QBMANBNBLD.VALUE := ''  ;
    QBMANBNSCS.VALUE := ''  ;
    QBMANBNSDP.VALUE := ''  ;
    QBMANBNCPL.VALUE := ''  ;
    QBMANBNSPP.VALUE := 0   ;
    QBMANBNSCH.VALUE := ''  ;
    QBMANBNHIS.VALUE := ''  ;
    QBMANBNCMN.VALUE := ''  ;
    QBMANBNREL.VALUE := ''  ;
    QBMANBNTL1.VALUE := ''  ;
    QBMANBNTL2.VALUE := ''  ;
    QBMANBNTL3.VALUE := ''  ;
    QBMANBNAD1.VALUE := ''  ;
    QBMANBNAD2.VALUE := ''  ;
    QBMANBNVIC.VALUE := ''  ;
    QBMANBNVIN.VALUE := ''  ;
    QBMANBNSEC.VALUE := ''  ;
    QBMANBNCLS.VALUE := ''  ;
    QBMANBNDPO.VALUE := ''  ;
    QBMANBNDPT.VALUE := ''  ;
    QBMANBNLLC.VALUE := ''  ;
    QBMANBNSVR.VALUE := ''  ;
    QBMANBNNUM.VALUE := ''  ;
    QBMANBNLCC.VALUE := ''  ;
    QBMANBNEPC.VALUE := ''  ;
    QBMANBNTIT.VALUE := ''  ;
    QBMANBNGRC.VALUE := ''  ;
    QBMANBNBNS.VALUE := ''  ;
    QBMANBNBNO.VALUE := ''  ;
    QBMANBNC03.VALUE := ''  ;
    QBMANBNCHM.VALUE := ''  ;
    QBMANBNHPV.VALUE := 0   ;
    QBMANBNSPL.VALUE := 0   ;
    QBMANBNSPN.VALUE := 0   ;
    QBMANBNLV1.VALUE := 0   ;
    QBMANBNLV2.VALUE := 0   ;
    QBMANBNHIX.VALUE := ''  ;
    QBMANBNTBX.VALUE := ''  ;
    QBMANBNISM.VALUE := 0   ;
    QBMANBNHIM.VALUE := 0   ;
    QBMANBNHIN.VALUE := 0   ;
    QBMANBNZP2.VALUE := ''  ;
    QBMANBNZP1.VALUE := ''  ;
    QBMANBNHBS.VALUE := TRUE;
    END;
end;

procedure TFMBMAN.BTNDELClick(Sender: TObject);
begin
  //检查权限============================================
  IF PERMISSION_CHECK(_USER_ID,'BMAN_DEL') = FALSE THEN EXIT;
  
  //检查权限============================================
  IF FMBMAND.QBMAN.FieldByName('BNENO').AsString = 'admin' THEN
     BEGIN
     SHOWMESSAGE('这是管理员的帐号, 不可删除!');
     EXIT;
     END;
  
  IF MessageDlg('是否确定要删除此条记录吗?',mtWarning, [mbYes, mbNo], 0) = mrYes then
     IF MessageDlg('如果您按下确定按钮此条记录将会被删除',mtWarning, [mbYes, mbNo], 0) = mrYes then
        BEGIN
        FMBMAND.QBMAN.Delete;
        FM_DB_QUERY_UPDATE(FMMAIND.DATABASE,FMBMAND.QBMAN);
        NORMALMODE;
        END;
end;

procedure TFMBMAN.BTNYESClick(Sender: TObject);
begin
  //检查权限============================================
  IF PERMISSION_CHECK(_USER_ID,'BMAN_UPD') = FALSE THEN EXIT;
  
  //检查重复
  if (FORMMODE = 'INS' ) then
  if TABLECHECK_RE1('BMAN','BNENO',BNENO.Text) > 0 THEN
     begin
     SHOWMESSAGE('此编号已经重复使用!');  EXIT;
     end;
  
  
  Case MessageDlg('是否确定存储此条记录?',mtConfirmation,[mbYes,mbNo,mbCancel],0) of
   mrYES :begin
          NORMALMODE;
  
          //检查权限============================================ 可改密码
          IF PERMISSION_CHECK(_USER_ID,'SET_PASSWD') = TRUE THEN
             BEGIN
             FMBMAND.QBMAN.FieldByName('BNPWD').AsString := '1'+Encrypt(BNPWD.Text,1357,2,1)+'1';
             END;
  
          FM_DB_QUERY_POST(FMMAIND.DATABASE,FMBMAND.QBMAN);
          end;
   mrNO  :begin
          NORMALMODE;
          FMBMAND.QBMAN.Cancel;
          end;
   END;

end;

procedure TFMBMAN.BTNCALClick(Sender: TObject);
begin
  NORMALMODE;
  FMBMAND.QBMAN.Cancel;
end;

procedure TFMBMAN.BTNSERClick(Sender: TObject);
begin
  //检查权限============================================
  IF PERMISSION_CHECK(_USER_ID,'BMAN_SEA') = FALSE THEN EXIT;
  
  WITH FMBMAND.QBMAN DO
    BEGIN
    CLOSE;
    SQL.CLEAR;
    SQL.ADD('SELECT * FROM BMAN');
    SQL.ADD('WHERE BNENO IS NOT NULL');

    //字符串查询
    SQL.ADD(FINDFORM_WHEREKEY_STRING('BNENO',LB11.Text,LB12.Text));
    SQL.ADD(FINDFORM_WHEREKEY_STRING('BNNAM',LB21.Text,LB22.Text));
    SQL.ADD(FINDFORM_WHEREKEY_STRING('BNCNA',LB31.Text,LB32.Text));
    OPEN;
    END;
end;

procedure TFMBMAN.BTNCLRClick(Sender: TObject);
begin
  LB11.Clear;
  LB12.Clear;
  LB21.Clear;
  LB22.Clear;
  LB31.Clear;
  LB32.Clear;
end;

procedure TFMBMAN.BTNPRNClick(Sender: TObject);
begin
  //检查权限============================================
  IF PERMISSION_CHECK(_USER_ID,'BMAN_PRN') = FALSE THEN EXIT;
  
  IF FormExists('FMREP1')=FALSE THEN Application.CreateForm(TFMREP1, FMREP1 );
  FMREP1.QR_NAME := ExtractFilePath(Application.EXEName)+'/ini/QREP_BMAN.ini';
  FMREP1.ED_PAGE_TABLE.TEXT := 'BMAN';

  FMREP1.QUERY.SQL.CLEAR;
  FMREP1.QUERY.SQL.TEXT := FMBMAND.QBMAN.SQL.TEXT;
  FMREP1.QUERY.CLOSE;
  FMREP1.QUERY.OPEN;

  FMREP1.LOAD_INI;

  IF SENDER = BTNPRE THEN FMREP1.QuickRep.Preview;
  IF SENDER = MENPRE THEN FMREP1.QuickRep.Preview;
  IF SENDER = BTNPRN THEN FMREP1.QuickRep.Print;
  IF SENDER = MENPRN THEN FMREP1.QuickRep.Print;
end;

procedure TFMBMAN.BNPWDKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  FMBMAND.QBMAN.EDIT;
end;

procedure TFMBMAN.BTNPMSClick(Sender: TObject);
begin
  //检查权限============================================
  IF PERMISSION_CHECK(_USER_ID,'SET_PMS') = FALSE THEN EXIT;

  IF FormExists('FMBMANM' )=FALSE THEN Application.CreateForm(TFMBMANM , FMBMANM );
  FMBMANM.PMS_BNENO := FMBMAND.QBMAN.FIELDBYNAME('BNENO').AsString;
  FMBMANM.PMS_BNNAM := FMBMAND.QBMAN.FIELDBYNAME('BNNAM').AsString;
  FMBMANM.LOAD_BMAN_PMS;
  Form_NORMAL_SHOWMODAL(FMBMANM,-1,-1);
end;

procedure TFMBMAN.BTNSETClick(Sender: TObject);
begin
  IF FormExists('FMREP1' )=FALSE THEN Application.CreateForm(TFMREP1, FMREP1 );
  FMREP1.QR_NAME := ExtractFilePath(Application.EXEName)+'/ini/QREP_BMAN.ini';
  FMREP1.ED_PAGE_TABLE.TEXT := 'BMAN';
  Form_NORMAL_SHOWMODAL(FMREP1,-1,-1);
end;

procedure TFMBMAN.BTNMSGClick(Sender: TObject);
begin
  IF FormExists('FMBMANG' )=FALSE THEN Application.CreateForm(TFMBMANG, FMBMANG );
  Form_NORMAL_SHOWMODAL(FMBMANG,-1,-1);
end;

end.
