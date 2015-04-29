unit UNBMEM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, Grids, DBGrids, SELOOKUPD, StdCtrls, DBCtrls, Mask, JEdit,
  Buttons, ExtCtrls, ComCtrls;

type

  TFMBMEM = class(TForm)
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
    BTNSET: TBitBtn;
    BTNPRE: TBitBtn;
    N6: TMenuItem;
    MENPRE: TMenuItem;
    MENPRN: TMenuItem;
    LBBMCNA: TLabel;
    LBBMBTH: TLabel;
    LBBMSEX: TLabel;
    LBBMENO: TLabel;
    LBBMNAM: TLabel;
    LBBMTL3: TLabel;
    LBBMWPN: TLabel;
    LBBMTL1: TLabel;
    LBBMTL2: TLabel;
    LBBMAD1: TLabel;
    LBBMAD2: TLabel;
    LBBMEML: TLabel;
    LBBMWWW: TLabel;
    LBBMZP1: TLabel;
    LBBMZP2: TLabel;
    LBBMJND: TLabel;
    LBBMCRD: TLabel;
    LBBMDAT: TLabel;
    LBBMMRK: TLabel;
    LBBMLVE: TLabel;
    LBBMBYR: TLabel;
    LBBMBTO: TLabel;
    LBBMBDT: TLabel;
    LBBMBYD: TLabel;
    LBBMBPO: TLabel;
    LBBMBTM: TLabel;
    BMCNA: TJDBEdit;
    BMENO: TJDBEdit;
    BMNAM: TJDBEdit;
    BMBTH: TJDBEdit;
    BMTL3: TJDBEdit;
    BMWPN: TJDBEdit;
    BMTL1: TJDBEdit;
    BMTL2: TJDBEdit;
    BMAD1: TJDBEdit;
    BMAD2: TJDBEdit;
    BMEML: TJDBEdit;
    BMWWW: TJDBEdit;
    BMZP1: TJDBEdit;
    BMZP2: TJDBEdit;
    BMLVE: TJDBEdit;
    BMBYR: TJDBEdit;
    BMBTO: TJDBEdit;
    BMBPO: TJDBEdit;
    BMBTM: TJDBEdit;
    BMJND: TJDBEdit;
    BMCRD: TJDBEdit;
    BMBDT: TJDBEdit;
    BMBYD: TJDBEdit;
    BMDAT: TJDBEdit;
    LBRBPST: TLabel;
    RBPST: TJDBEdit;
    BMMRK: TDBMemo;
    BNSEX: SEDBLOOKUPBOX;
    DBGrid: TDBGrid;
    Bevel1: TBevel;
    Bevel2: TBevel;
    LB_MAX: TLabel;
    GroupBox1: TGroupBox;
    Label7: TLabel;
    Label9: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    Label10: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    LB_CON1: TLabel;
    LB_CON2: TLabel;
    LB_CON3: TLabel;
    LB_CON4: TLabel;
    LB_CON7: TLabel;
    LB_CON8: TLabel;
    LB_CON6: TLabel;
    LB_CON5: TLabel;
    Label2: TLabel;
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
    LB81: TJEdit;
    LB82: TJEdit;
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
  FMBMEM: TFMBMEM;

implementation

uses SYSINI, FM_UTL, DB_UTL, MAIND, MAINU,
     UNBMEMD, UNREP1;

{$R *.DFM}

procedure TFMBMEM.BTNMODE;
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
  {新增才可改编号}         BMENO.Enabled := FALSE;
  IF FORMMODE = 'INS' THEN BMENO.Enabled := TRUE;
end;

procedure TFMBMEM.INSERTMODE;
begin
  FORMMODE := 'INS';
  BTNMODE;
  BMENO.SetFocus;
end;

procedure TFMBMEM.UPDATEMODE;
begin
  FORMMODE := 'UPD';
  BTNMODE;
end;

procedure TFMBMEM.NORMALMODE;
begin
  FORMMODE := 'CAN';
  BTNMODE;
  DBGRID.SetFocus;
end;

procedure TFMBMEM.FormCreate(Sender: TObject);
begin
  IF FormExists('FMBMEMD')=FALSE THEN Application.CreateForm(TFMBMEMD, FMBMEMD );
  
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
  
  
  FMBMEMD.UBMEM.InsertSQL.CLEAR;
  FMBMEMD.UBMEM.InsertSQL.Add('INSERT INTO BMEM ');
  FMBMEMD.UBMEM.InsertSQL.Add(' ( BMENO, BMNAM, BMCNA, BMBTH, BMSEX, BMLVE, BMBYR, BMBTO, BMBDT, BMBYD, BMWPN, BMTL1, BMTL2, BMTL3, BMAD1, BMAD2, BMEML, BMWWW, BMJND, BMCRD, BMDAT, BMMRK, BMBPO, BMBTM, BMZP1, BMZP2, RBPST ) ');
  FMBMEMD.UBMEM.InsertSQL.Add('VALUES ');
  FMBMEMD.UBMEM.InsertSQL.Add(' (:BMENO,:BMNAM,:BMCNA,:BMBTH,:BMSEX,:BMLVE,:BMBYR,:BMBTO,:BMBDT,:BMBYD,:BMWPN,:BMTL1,:BMTL2,:BMTL3,:BMAD1,:BMAD2,:BMEML,:BMWWW,:BMJND,:BMCRD,:BMDAT,:BMMRK,:BMBPO,:BMBTM,:BMZP1,:BMZP2,:RBPST ) ');

  FMBMEMD.UBMEM.ModifySQL.CLEAR;
  FMBMEMD.UBMEM.ModifySQL.Add('UPDATE BMEM ');
  FMBMEMD.UBMEM.ModifySQL.Add('SET ');
  FMBMEMD.UBMEM.ModifySQL.Add('BMENO = :BMENO ,');
  FMBMEMD.UBMEM.ModifySQL.Add('BMNAM = :BMNAM ,');
  FMBMEMD.UBMEM.ModifySQL.Add('BMCNA = :BMCNA ,');
  FMBMEMD.UBMEM.ModifySQL.Add('BMBTH = :BMBTH ,');
  FMBMEMD.UBMEM.ModifySQL.Add('BMSEX = :BMSEX ,');

  FMBMEMD.UBMEM.ModifySQL.Add('BMLVE = :BMLVE ,');
  FMBMEMD.UBMEM.ModifySQL.Add('BMBYR = :BMBYR ,');
  FMBMEMD.UBMEM.ModifySQL.Add('BMBTO = :BMBTO ,');
  FMBMEMD.UBMEM.ModifySQL.Add('BMBPO = :BMBPO ,');
  FMBMEMD.UBMEM.ModifySQL.Add('BMBTM = :BMBTM ,');
  FMBMEMD.UBMEM.ModifySQL.Add('BMBDT = :BMBDT ,');
  FMBMEMD.UBMEM.ModifySQL.Add('BMBYD = :BMBYD ,');
  FMBMEMD.UBMEM.ModifySQL.Add('BMWPN = :BMWPN ,');
  FMBMEMD.UBMEM.ModifySQL.Add('BMTL1 = :BMTL1 ,');
  FMBMEMD.UBMEM.ModifySQL.Add('BMTL2 = :BMTL2 ,');
  FMBMEMD.UBMEM.ModifySQL.Add('BMTL3 = :BMTL3 ,');
  FMBMEMD.UBMEM.ModifySQL.Add('BMAD1 = :BMAD1 ,');
  FMBMEMD.UBMEM.ModifySQL.Add('BMAD2 = :BMAD2 ,');
  FMBMEMD.UBMEM.ModifySQL.Add('BMZP1 = :BMZP1 ,');
  FMBMEMD.UBMEM.ModifySQL.Add('BMZP2 = :BMZP2 ,');
  FMBMEMD.UBMEM.ModifySQL.Add('BMEML = :BMEML ,');
  FMBMEMD.UBMEM.ModifySQL.Add('BMWWW = :BMWWW ,');
  FMBMEMD.UBMEM.ModifySQL.Add('BMJND = :BMJND ,');
  FMBMEMD.UBMEM.ModifySQL.Add('BMCRD = :BMCRD ,');
  FMBMEMD.UBMEM.ModifySQL.Add('BMDAT = :BMDAT ,');
  FMBMEMD.UBMEM.ModifySQL.Add('RBPST = :RBPST  ');
  FMBMEMD.UBMEM.ModifySQL.Add('WHERE BMENO = :OLD_BMENO');

  FMBMEMD.UBMEM.DeleteSQL.CLEAR;
  FMBMEMD.UBMEM.DeleteSQL.Add('DELETE FROM BMEM ');
  FMBMEMD.UBMEM.DeleteSQL.Add('WHERE BMENO = :OLD_BMENO');

  FMBMEMD.QBMEM.SQL.CLEAR;
  FMBMEMD.QBMEM.SQL.ADD('SELECT * FROM BMEM ');
  FMBMEMD.QBMEM.SQL.ADD('ORDER BY BMENO');
  FMBMEMD.QBMEM.CLOSE;
  FMBMEMD.QBMEM.OPEN;

  LB_MAX.CAPTION := '最大编号'+CHECK_BASE_TABLE_NO('BMEM','BMENO');
end;

procedure TFMBMEM.FormShow(Sender: TObject);
begin
  NORMALMODE;
end;

procedure TFMBMEM.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  //Form 要结束前的询问(系统事件)
  CanClose := True;
  if (FORMMODE = 'INS' ) or (FORMMODE = 'UPD' ) then
    begin
    MessageDlg('请先结束输入模式后再退出!',mtConfirmation,[mbOk],0);
    CanClose := False;
    end;
end;

procedure TFMBMEM.BTNQUTClick(Sender: TObject);
begin
  NORMALMODE;
  CLOSE;
end;


procedure TFMBMEM.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DataModuleRelease(FMBMEMD);
  FormRelease(FMBMEM);
  FormFREE('FMBMEMP');
end;

procedure TFMBMEM.BTNINSClick(Sender: TObject);
begin
  //检查权限============================================
  IF PERMISSION_CHECK(_USER_ID,'BMEM_INS') = FALSE THEN EXIT;
  
  INSERTMODE;
  
  WITH FMBMEMD DO
    BEGIN
    QBMEM.APPEND;
    QBMEMBMENO.VALUE := ''  ;
    QBMEMBMNAM.VALUE := ''  ;
    QBMEMBMCNA.VALUE := ''  ;
    QBMEMBMSEX.VALUE := '1' ;
    QBMEMBMLVE.VALUE := 1   ;
    QBMEMBMBYR.VALUE := 0   ;
    QBMEMBMBTO.VALUE := 0   ;
    QBMEMBMWPN.VALUE := ''  ;
    QBMEMBMTL1.VALUE := ''  ;
    QBMEMBMTL2.VALUE := ''  ;
    QBMEMBMTL3.VALUE := ''  ;
    QBMEMBMAD1.VALUE := ''  ;
    QBMEMBMAD2.VALUE := ''  ;
    QBMEMBMZP1.VALUE := ''  ;
    QBMEMBMZP2.VALUE := ''  ;
    QBMEMBMEML.VALUE := ''  ;
    QBMEMBMWWW.VALUE := ''  ;
    QBMEMBMDAT.VALUE := DATE;
    QBMEMBMMRK.VALUE := ''  ;
    QBMEMRBPST.VALUE := _SYS_RBPST  ;
    QBMEMBMBPO.VALUE := 0   ;
    QBMEMBMBTM.VALUE := 0   ;
    END;
end;

procedure TFMBMEM.BTNDELClick(Sender: TObject);
begin
  //检查权限============================================
  IF PERMISSION_CHECK(_USER_ID,'BMEM_DEL') = FALSE THEN EXIT;

  IF MessageDlg('是否确定要删除此条记录吗?',mtWarning, [mbYes, mbNo], 0) = mrYes then
     IF MessageDlg('如果您按下确定按钮此条记录将会被删除',mtWarning, [mbYes, mbNo], 0) = mrYes then
        BEGIN
        FMBMEMD.QBMEM.Delete;
        FM_DB_QUERY_UPDATE(FMMAIND.DATABASE,FMBMEMD.QBMEM);
        NORMALMODE;
        END;

  LB_MAX.CAPTION := '最大编号'+CHECK_BASE_TABLE_NO('BMEM','BMENO');
end;

procedure TFMBMEM.BTNYESClick(Sender: TObject);
begin
  //检查权限============================================
  IF PERMISSION_CHECK(_USER_ID,'BMEM_UPD') = FALSE THEN EXIT;
  
  //检查重复
  if (FORMMODE = 'INS' ) then
  if TABLECHECK_RE1('BMEM','BMENO',BMENO.Text) > 0 THEN
     begin
     SHOWMESSAGE('此编号已经重复使用!');  EXIT;
     end;
  
  
  Case MessageDlg('是否确定存储此条记录?',mtConfirmation,[mbYes,mbNo,mbCancel],0) of
   mrYES :begin
          NORMALMODE;
          FM_DB_QUERY_POST(FMMAIND.DATABASE,FMBMEMD.QBMEM);
  
          // 更新 MEMO 的资料
          FMMAIND.QUPD.SQL.CLEAR;
          FMMAIND.QUPD.SQL.ADD('UPDATE BMEM SET');
          FMMAIND.QUPD.SQL.ADD('BMMRK = '''+StringReplace(BMMRK.TEXT,'''','"',[rfReplaceAll])+''' ');
          FMMAIND.QUPD.SQL.ADD('WHERE BMENO = '''+BMENO.TEXT+''' ');
          FMMAIND.QUPD.ExecSQL;
  
          end;
   mrNO  :begin
          NORMALMODE;
          FMBMEMD.QBMEM.Cancel;
          end;
  END;
  
  LB_MAX.CAPTION := '最大编号'+CHECK_BASE_TABLE_NO('BMEM','BMENO');
end;

procedure TFMBMEM.BTNCALClick(Sender: TObject);
begin
  NORMALMODE;
  FMBMEMD.QBMEM.Cancel;
end;

procedure TFMBMEM.BTNSERClick(Sender: TObject);
begin
  //检查权限============================================
  IF PERMISSION_CHECK(_USER_ID,'BMEM_SEA') = FALSE THEN EXIT;
  
  WITH FMBMEMD.QBMEM DO
    BEGIN
    CLOSE;
    SQL.CLEAR;
    SQL.ADD('SELECT * FROM BMEM');
    SQL.ADD('WHERE BMENO IS NOT NULL');

    //字符串查询
    SQL.ADD(FINDFORM_WHEREKEY_STRING('BMENO',LB11.Text,LB12.Text));
    SQL.ADD(FINDFORM_WHEREKEY_STRING('BMNAM',LB21.Text,LB22.Text));
    SQL.ADD(FINDFORM_WHEREKEY_STRING('BMTL1',LB31.Text,LB32.Text));
    SQL.ADD(FINDFORM_WHEREKEY_STRING('BMAD1',LB41.Text,LB42.Text));
    SQL.ADD(FINDFORM_WHEREKEY_STRING('BMLVE',LB51.Text,LB52.Text));

    //ACCESS " DATE " WHERE KEY  ======================
    SQL.ADD(FINDFORM_WHEREKEY_DATE('BMJND',LB61.Text,LB62.Text));
    SQL.ADD(FINDFORM_WHEREKEY_DATE('BMCRD',LB71.Text,LB72.Text));
    SQL.ADD(FINDFORM_WHEREKEY_DATE('BMBDT',LB81.Text,LB82.Text));
    OPEN;
    END;
end;

procedure TFMBMEM.BTNCLRClick(Sender: TObject);
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

procedure TFMBMEM.BTNPRNClick(Sender: TObject);
begin
  //检查权限============================================
  IF PERMISSION_CHECK(_USER_ID,'BMEM_PRN') = FALSE THEN EXIT;

  IF FormExists('FMREP1')=FALSE THEN Application.CreateForm(TFMREP1, FMREP1 );
  FMREP1.QR_NAME := ExtractFilePath(Application.EXEName)+'/ini/QREP_BMEM.ini';
  FMREP1.ED_PAGE_TABLE.TEXT := 'BMEM';

  FMREP1.QUERY.SQL.CLEAR;
  FMREP1.QUERY.SQL.TEXT := FMBMEMD.QBMEM.SQL.TEXT;
  FMREP1.QUERY.CLOSE;
  FMREP1.QUERY.OPEN;

  FMREP1.LOAD_INI;

  IF SENDER = BTNPRE THEN FMREP1.QuickRep.Preview;
  IF SENDER = MENPRE THEN FMREP1.QuickRep.Preview;
  IF SENDER = BTNPRN THEN FMREP1.QuickRep.Print;
  IF SENDER = MENPRN THEN FMREP1.QuickRep.Print;
end;

procedure TFMBMEM.BTNSETClick(Sender: TObject);
begin
  IF FormExists('FMREP1' )=FALSE THEN Application.CreateForm(TFMREP1, FMREP1 );
  FMREP1.QR_NAME := ExtractFilePath(Application.EXEName)+'/ini/QREP_BMEM.ini';
  FMREP1.ED_PAGE_TABLE.TEXT := 'BMEM';
  Form_NORMAL_SHOWMODAL(FMREP1,-1,-1);
end;

end.
