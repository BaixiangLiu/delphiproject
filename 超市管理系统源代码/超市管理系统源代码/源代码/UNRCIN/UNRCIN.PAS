unit UNRCIN;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, DBCtrls, JLOOKUPD, Mask, JEdit, ExtCtrls, Grids,
  DBGrids, Menus, SELOOKUPD, JLOOKUP;

type
  TFMRCIN = class(TForm)
    DBGrid2: TDBGrid;
    PopupMenuDBGRID: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    BGENO: JLOOKUPBOX;
    MainMenu: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N6: TMenuItem;
    MENPRE: TMenuItem;
    MENPRN: TMenuItem;
    N5: TMenuItem;
    Panel2: TPanel;
    LBROAMT: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    LBRIAMT: TLabel;
    LBRIENO: TLabel;
    LBRITYP: TLabel;
    LBBSENO: TLabel;
    LBRIIID: TLabel;
    LBRIIAD: TLabel;
    LBRIINO: TLabel;
    LBRIDAT: TLabel;
    LBBNENO: TLabel;
    LBRIPAY: TLabel;
    LBRIMRK: TLabel;
    LBRIEXG: TLabel;
    LBRIEXR: TLabel;
    LBRISA1: TLabel;
    LBRISA2: TLabel;
    LBRISA3: TLabel;
    LBRISA4: TLabel;
    LBRISA5: TLabel;
    LBRIAM1: TLabel;
    LBRIAM2: TLabel;
    LBRISNO: TLabel;
    ROAMT: TJDBEdit;
    _RODM2: TEdit;
    _RODM1: TEdit;
    _ROAMD: TEdit;
    RIAMT: TJDBEdit;
    RIMRK: TDBMemo;
    RIENO: TJDBEdit;
    RITYP: TJDBEdit;
    RIIID: TJDBEdit;
    BSENO: JDBLOOKUPBOX;
    RIIAD: TJDBEdit;
    RIINO: TJDBEdit;
    RIDAT: TJDBEdit;
    RIEXR: TDBEdit;
    BNENO: JDBLOOKUPBOX;
    RISA1: TJDBEdit;
    RISA2: TJDBEdit;
    RISA3: TJDBEdit;
    RISA4: TJDBEdit;
    RISA5: TJDBEdit;
    RIAM1: TJDBEdit;
    RIAM2: TJDBEdit;
    RISNO: TJDBEdit;
    RIPAY: SEDBLOOKUPBOX;
    RIEXG: SEDBLOOKUPBOX;
    GroupBox1: TGroupBox;
    LB1: TLabel;
    LB2: TLabel;
    LB3: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    LB11: TJEdit;
    LB31: TJEdit;
    LB12: TJEdit;
    LB32: TJEdit;
    LB21: TJEdit;
    LB22: TJEdit;
    LB51: TJEdit;
    LB41: TJEdit;
    LB42: TJEdit;
    LB61: TJEdit;
    BTNSER: TBitBtn;
    BTNCLR: TBitBtn;
    DBGrid1: TDBGrid;
    Panel5: TPanel;
    BTNSET: TBitBtn;
    BitBtn3: TBitBtn;
    BTNINS: TBitBtn;
    BTNYES: TBitBtn;
    BTNCAL: TBitBtn;
    BTNQUT: TBitBtn;
    BTNDEL: TBitBtn;
    BTNPRE: TBitBtn;
    BTNPRN: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure BTNINSClick(Sender: TObject);
    procedure BTNYESClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BTNCALClick(Sender: TObject);
    procedure BTNQUTClick(Sender: TObject);
    procedure BTNDELClick(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure BTNPRNClick(Sender: TObject);
    procedure DBGrid2EditButtonClick(Sender: TObject);
    procedure DBGrid2ColExit(Sender: TObject);
    procedure BTNCLRClick(Sender: TObject);
    procedure BTNSERClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    T_RIMEM : STRING;
    T_RIIID : STRING;
    T_RHCOR : STRING;

    FORMMODE : STRING;
    FORMTYPE : STRING;

    procedure BTNMODE;
    procedure INSERTMODE;
    procedure UPDATEMODE;
    procedure NORMALMODE;
    PROCEDURE QUERY_RCON;
  end;


var
  FMRCIN: TFMRCIN;

implementation

uses SYSINI, UN_UTL, FM_UTL, DB_UTL, MAIND, MAINU,
     UNRCIND, UNRCINP;

{$R *.DFM}

PROCEDURE TFMRCIN.QUERY_RCON;
BEGIN
  FMRCIND.QRCIN.SQL.CLEAR;
  FMRCIND.QRCIN.SQL.ADD('SELECT * FROM RCIN');
  FMRCIND.QRCIN.SQL.ADD('WHERE RITYP = '''+FORMTYPE+'''');
  FMRCIND.QRCIN.SQL.ADD('ORDER BY RIENO');
  
  FMRCIND.QRCIN.CLOSE;
  FMRCIND.QRCIN.OPEN;
END;

procedure TFMRCIN.BTNMODE;
begin
  //一般模式
     BTNINS.Enabled := FALSE;
     BTNDEL.Enabled := FALSE;
     BTNYES.Enabled := FALSE;
     BTNCAL.Enabled := FALSE;
     BTNSER.Enabled := FALSE;
     BTNCLR.Enabled := FALSE;
     BTNPRN.Enabled := FALSE;
     BTNPRE.Enabled := FALSE;
     BTNQUT.Enabled := FALSE;
  //新增修改模式
  if (FORMMODE = 'INS' ) or (FORMMODE = 'UPD' ) then
     BEGIN
     BTNINS.Enabled := FALSE;
     BTNDEL.Enabled := FALSE;
     BTNYES.Enabled := TRUE;
     BTNCAL.Enabled := TRUE;
     BTNSER.Enabled := FALSE;
     BTNCLR.Enabled := FALSE;
     BTNPRN.Enabled := FALSE;
     BTNPRE.Enabled := FALSE;
     BTNQUT.Enabled := FALSE;
     END;
  //一般模式
  if (FORMMODE = 'CAN' ) then
     BEGIN
     BTNINS.Enabled := TRUE;
     BTNDEL.Enabled := TRUE;
     BTNYES.Enabled := FALSE;
     BTNCAL.Enabled := FALSE;
     BTNSER.Enabled := TRUE;
     BTNCLR.Enabled := TRUE;
     BTNPRN.Enabled := TRUE;
     BTNPRE.Enabled := TRUE;
     BTNQUT.Enabled := TRUE;
     END;
end;

procedure TFMRCIN.INSERTMODE;
begin
  FORMMODE := 'INS';
  BTNMODE;
  DBGrid1.Enabled := FALSE;
end;

procedure TFMRCIN.UPDATEMODE;
begin
  FORMMODE := 'UPD';
  BTNMODE;
  DBGrid1.Enabled := FALSE;
end;

procedure TFMRCIN.NORMALMODE;
begin
  FORMMODE := 'CAN';
  BTNMODE;
  DBGrid1.Enabled := TRUE;
end;

procedure TFMRCIN.FormCreate(Sender: TObject);
begin
  IF FormExists('FMRCIND')=FALSE THEN Application.CreateForm(TFMRCIND, FMRCIND );
  
  //按钮图形加载
  BTNINS.Glyph := INS_TB;
  BTNDEL.Glyph := DEL_TB;
  BTNYES.Glyph := YES_TB;
  BTNCAL.Glyph := CAL_TB;
  BTNSER.Glyph := SER_TB;
  BTNCLR.Glyph := CLR_TB;
  BTNPRN.Glyph := PRN_TB;
  BTNPRE.Glyph := PRE_TB;
  BTNSET.Glyph := SET_TB;
  BTNQUT.Glyph := QUT_TB;

  FMRCIND.URCIN.InsertSQL.CLEAR;
  FMRCIND.URCIN.InsertSQL.Add('INSERT INTO RCIN ');
  FMRCIND.URCIN.InsertSQL.Add(' ( RIENO, RITYP, RIDAT, BNENO, BSENO, RISNO, RIIID, RIINO, RIIAD, RIPAY, RIEXG, RIEXR, RIAM1, RIAM2, RIAMT, RISA1, RISA2, RISA3, RISA4, RISA5, RIMRK, RISTA ) ');
  FMRCIND.URCIN.InsertSQL.Add('VALUES ');
  FMRCIND.URCIN.InsertSQL.Add(' (:RIENO,:RITYP,:RIDAT,:BNENO,:BSENO,:RISNO,:RIIID,:RIINO,:RIIAD,:RIPAY,:RIEXG,:RIEXR,:RIAM1,:RIAM2,:RIAMT,:RISA1,:RISA2,:RISA3,:RISA4,:RISA5,:RIMRK,:RISTA ) ');

  FMRCIND.URCIN.ModifySQL.CLEAR;
  FMRCIND.URCIN.ModifySQL.Add('UPDATE RCIN ');
  FMRCIND.URCIN.ModifySQL.Add('SET ');
  FMRCIND.URCIN.ModifySQL.Add('RIENO = :RIENO ,');
  FMRCIND.URCIN.ModifySQL.Add('RITYP = :RITYP ,');
  FMRCIND.URCIN.ModifySQL.Add('RIDAT = :RIDAT ,');
  FMRCIND.URCIN.ModifySQL.Add('BNENO = :BNENO ,');
  FMRCIND.URCIN.ModifySQL.Add('BSENO = :BSENO ,');
  FMRCIND.URCIN.ModifySQL.Add('RISNO = :RISNO ,');
  FMRCIND.URCIN.ModifySQL.Add('RIIID = :RIIID ,');
  FMRCIND.URCIN.ModifySQL.Add('RIINO = :RIINO ,');
  FMRCIND.URCIN.ModifySQL.Add('RIIAD = :RIIAD ,');
  FMRCIND.URCIN.ModifySQL.Add('RIPAY = :RIPAY ,');
  FMRCIND.URCIN.ModifySQL.Add('RIEXG = :RIEXG ,');
  FMRCIND.URCIN.ModifySQL.Add('RIEXR = :RIEXR ,');
  FMRCIND.URCIN.ModifySQL.Add('RIAM1 = :RIAM1 ,');
  FMRCIND.URCIN.ModifySQL.Add('RIAM2 = :RIAM2 ,');
  FMRCIND.URCIN.ModifySQL.Add('RIAMT = :RIAMT ,');
  FMRCIND.URCIN.ModifySQL.Add('RISA1 = :RISA1 ,');
  FMRCIND.URCIN.ModifySQL.Add('RISA2 = :RISA2 ,');
  FMRCIND.URCIN.ModifySQL.Add('RISA3 = :RISA3 ,');
  FMRCIND.URCIN.ModifySQL.Add('RISA4 = :RISA4 ,');
  FMRCIND.URCIN.ModifySQL.Add('RISA5 = :RISA5 ,');
  FMRCIND.URCIN.ModifySQL.Add('RIMRK = :RIMRK  ');
  FMRCIND.URCIN.ModifySQL.Add('WHERE RIENO = :OLD_RIENO');

  FMRCIND.URCIN.DeleteSQL.CLEAR;
  FMRCIND.URCIN.DeleteSQL.Add('DELETE FROM RCIN ');
  FMRCIND.URCIN.DeleteSQL.Add('WHERE RIENO = :OLD_RIENO');

  FMRCIND.URCINB.InsertSQL.CLEAR;
  FMRCIND.URCINB.InsertSQL.Add('INSERT INTO RCINB ');
  FMRCIND.URCINB.InsertSQL.Add(' ( RIENO, RIITM, BGENO, RIUNP, RIGCN, RIGCS, RIGCT ) ');
  FMRCIND.URCINB.InsertSQL.Add('VALUES ');
  FMRCIND.URCINB.InsertSQL.Add(' (:RIENO,:RIITM,:BGENO,:RIUNP,:RIGCN,:RIGCS,:RIGCT ) ');

  FMRCIND.URCINB.ModifySQL.CLEAR;
  FMRCIND.URCINB.ModifySQL.Add('UPDATE RCINB ');
  FMRCIND.URCINB.ModifySQL.Add('SET ');
  FMRCIND.URCINB.ModifySQL.Add('RIENO = :RIENO ,');
  FMRCIND.URCINB.ModifySQL.Add('RIITM = :RIITM ,');
  FMRCIND.URCINB.ModifySQL.Add('BGENO = :BGENO ,');
  FMRCIND.URCINB.ModifySQL.Add('RIUNP = :RIUNP ,');
  FMRCIND.URCINB.ModifySQL.Add('RIGCN = :RIGCN ,');
  FMRCIND.URCINB.ModifySQL.Add('RIGCS = :RIGCS ,');
  FMRCIND.URCINB.ModifySQL.Add('RIGCT = :RIGCT  ');
  FMRCIND.URCINB.ModifySQL.Add('WHERE RIENO = :OLD_RIENO');
  FMRCIND.URCINB.ModifySQL.Add('  AND RIITM = :OLD_RIITM');

  FMRCIND.URCINB.DeleteSQL.CLEAR;
  FMRCIND.URCINB.DeleteSQL.Add('DELETE FROM RCINB ');
  FMRCIND.URCINB.DeleteSQL.Add('WHERE RIENO = :OLD_RIENO');
  FMRCIND.URCINB.DeleteSQL.Add('  AND RIITM = :OLD_RIITM');

  QUERY_RCON;

  NORMALMODE;
end;

procedure TFMRCIN.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FormFREE('FMRCINT');
  FormFREE('FMRCINP');
  FormFREE('FMRCINF');
  DataModuleRelease(FMRCIND);
  FormRelease(FMRCIN );
end;

procedure TFMRCIN.BTNINSClick(Sender: TObject);
VAR T_ROMEM : STRING;
begin
  //检查权限============================================
  IF PERMISSION_CHECK(_USER_ID,'RCIN_INS') = FALSE THEN EXIT;
  
  WITH FMRCIND DO
     BEGIN
     QRCIN.APPEND;
     QRCINRIENO.VALUE := TABLEFINDMAXCNT('RCIN','RIENO',4,1);
     QRCINRITYP.VALUE := FORMTYPE;
     QRCINRIDAT.VALUE := DATE;
     QRCINBNENO.VALUE := _USER_ID;
     QRCINBSENO.VALUE := ''  ;
     QRCINRIINO.VALUE := ''  ;
     QRCINRIIID.VALUE := T_RIIID;
     QRCINRIIAD.VALUE := ''  ;
     QRCINRIPAY.VALUE := '001';
     QRCINRIEXG.VALUE := 'TW';
     QRCINRIAM1.VALUE := 0   ;
     QRCINRIAM2.VALUE := 0   ;
     QRCINRIAMT.VALUE := 0   ;
     QRCINRISA1.VALUE := 0   ;
     QRCINRISA2.VALUE := 0   ;
     QRCINRISA3.VALUE := 0   ;
     QRCINRISA4.VALUE := 0   ;
     QRCINRISA5.VALUE := 0   ;
     QRCINRIMRK.VALUE := ''  ;
     QRCINRIEXR.VALUE := 1   ;
     QRCINRISNO.VALUE := ''  ;
     QRCINRISTA.VALUE := FALSE;
     END;
end;

procedure TFMRCIN.BTNDELClick(Sender: TObject);
begin
  //检查权限============================================
  IF PERMISSION_CHECK(_USER_ID,'RCIN_DEL') = FALSE THEN EXIT;

  IF MessageDlg('是否确定要删除此条记录吗?',mtWarning, [mbYes, mbNo], 0) = mrYes then
     BEGIN
     IF MessageDlg('如果您按下确定按钮此条记录将会被删除',mtWarning, [mbYes, mbNo], 0) = mrYes then
        BEGIN
        WITH FMRCIND DO
           BEGIN
           QRCINB.First;
           WHILE NOT QRCINB.Eof DO
              BEGIN
              BGDS_UPDATE_BGQTN( QRCINB.FieldByName('BGENO').AsString, - QRCINB.FieldByName('RIGCN').AsINTEGER); //进货单
              QRCINB.Next;
              END;
           TRY
             FMMAIND.QDEL.SQL.Clear;
             FMMAIND.QDEL.SQL.Add('DELETE FROM RCINB WHERE RIENO = '''+RIENO.Text+'''');
             FMMAIND.QDEL.ExecSQL;
           EXCEPT
             SHOWMESSAGE('B表删除失败!');
           END;

           FMRCIND.QRCIN.Delete;
           FM_DB_QUERY_UPDATE(FMMAIND.DATABASE,FMRCIND.QRCIN);
           END;

        END;
     END;
end;

procedure TFMRCIN.BTNYESClick(Sender: TObject);
begin
  //检查权限============================================
  IF PERMISSION_CHECK(_USER_ID,'RCIN_UPD') = FALSE THEN EXIT;

  IF FMRCIND.QRCINB.Modified = TRUE THEN
     BEGIN
     FMRCIND.QRCINB.POST;
     END;

  IF FMRCIND.QRCIN.Modified  = TRUE THEN
     BEGIN
     FMRCIND.QRCIN.POST;
     FM_DB_QUERY_UPDATE(FMMAIND.DATABASE,FMRCIND.QRCIN);
     END;

  NORMALMODE;
end;

procedure TFMRCIN.BTNCALClick(Sender: TObject);
begin
  FMRCIND.QRCIN.Cancel;
  FMRCIND.QRCINB.Cancel;
  NORMALMODE;
end;

procedure TFMRCIN.BTNQUTClick(Sender: TObject);
begin
  CLOSE;
end;

procedure TFMRCIN.N1Click(Sender: TObject);
begin
  BGDS_UPDATE_BGQTN( FMRCIND.QRCINB.FieldByName('BGENO').AsString,
                   - FMRCIND.QRCINB.FieldByName('RIGCN').AsINTEGER); //进货单
  
  FMRCIND.QRCINB.DELETE;
  FM_DB_QUERY_UPDATE(FMMAIND.DATABASE,FMRCIND.QRCINB);
end;

procedure TFMRCIN.N2Click(Sender: TObject);
begin
  BTNCAL.CLICK;
end;

procedure TFMRCIN.BTNPRNClick(Sender: TObject);
begin
  //检查权限============================================
  IF PERMISSION_CHECK(_USER_ID,'RCIN_PRN') = FALSE THEN EXIT;
  
  IF FormExists('FMRCINP')=FALSE THEN Application.CreateForm(TFMRCINP, FMRCINP  );
  IF SENDER = BTNPRE THEN FMRCINP.QuickRep.Preview;
  IF SENDER = MENPRE THEN FMRCINP.QuickRep.Preview;
  IF SENDER = BTNPRN THEN FMRCINP.QuickRep.Print;
  IF SENDER = MENPRN THEN FMRCINP.QuickRep.Print;
end;

procedure TFMRCIN.DBGrid2EditButtonClick(Sender: TObject);
begin
  BGENO.Text := FMRCIND.QRCINBBGENO.VALUE;
  FMRCIND.QRCINB.Edit;
  FMRCIND.QRCINBBGENO.VALUE := BGENO.CALL_FMLOOKUP_IDNO  ;
end;

procedure TFMRCIN.DBGrid2ColExit(Sender: TObject);
begin
  IF FMRCIND.QRCINB.Modified = TRUE THEN
     BEGIN
     IF DBGRID2.Columns.Grid.SelectedIndex <= 2 THEN
        BEGIN
        FMRCIND.QRCINBRIGCN.VALUE := 1;
        FMRCIND.QRCINBRIGCS.VALUE := STRTOINTDEF(DB_QUERY_FIND_VALUE('BGDS','BGENO',FMRCIND.QRCINB.FIELDBYNAME('BGENO').AsString,'BGPST'),0);
        FMRCIND.QRCINBRIGCT.VALUE := STRTOINTDEF(DB_QUERY_FIND_VALUE('BGDS','BGENO',FMRCIND.QRCINB.FIELDBYNAME('BGENO').AsString,'BGPST'),0);
        END;

     FMRCIND.QRCINBRIGCT.VALUE := FMRCIND.QRCINBRIGCN.VALUE * FMRCIND.QRCINBRIGCS.VALUE;
     END;
end;

procedure TFMRCIN.BTNSERClick(Sender: TObject);
begin
  //检查权限============================================
  IF PERMISSION_CHECK(_USER_ID,'RCIN_SEA') = FALSE THEN EXIT;

  WITH FMRCIND.QRCIN DO
    BEGIN
    CLOSE;
    SQL.CLEAR;
    SQL.ADD('SELECT * FROM RCIN');
    SQL.ADD('WHERE RIENO IS NOT NULL');

    //字符串查询
    SQL.ADD(FINDFORM_WHEREKEY_STRING('RIENO',LB11.Text,LB12.Text));
    SQL.ADD(FINDFORM_WHEREKEY_STRING('RIIID',LB21.Text,LB22.Text));
    SQL.ADD(FINDFORM_WHEREKEY_STRING('RISNO',LB31.Text,LB32.Text));
    SQL.ADD(FINDFORM_WHEREKEY_STRING('BSENO',LB51.Text,''));
    SQL.ADD(FINDFORM_WHEREKEY_STRING('BNENO',LB61.Text,''));

    //ACCESS " DATE " WHERE KEY  ======================
    SQL.ADD(FINDFORM_WHEREKEY_DATE('RIDAT',LB41.Text,LB42.Text));
    OPEN;
    END;
end;

procedure TFMRCIN.BTNCLRClick(Sender: TObject);
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
  LB61.Clear;
end;

end.
