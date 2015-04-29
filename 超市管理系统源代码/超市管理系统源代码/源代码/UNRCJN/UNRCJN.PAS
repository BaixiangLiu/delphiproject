unit UNRCJN;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, DBCtrls, JLOOKUPD, Mask, JEdit, ExtCtrls, Grids,
  DBGrids, Menus, SELOOKUPD, JLOOKUP;

type
  TFMRCJN = class(TForm)
    Panel5: TPanel;
    BTNINS: TBitBtn;
    BTNYES: TBitBtn;
    BTNCAL: TBitBtn;
    BTNSET: TBitBtn;
    BTNQUT: TBitBtn;
    Panel2: TPanel;
    LBROAMT: TLabel;
    ROAMT: TJDBEdit;
    DBGrid2: TDBGrid;
    Label1: TLabel;
    BTNDEL: TBitBtn;
    DBGrid1: TDBGrid;
    Label3: TLabel;
    Label4: TLabel;
    _RODM2: TEdit;
    _RODM1: TEdit;
    _ROAMD: TEdit;
    PopupMenuDBGRID: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    BGENO: JLOOKUPBOX;
    LBRJAMT: TLabel;
    LBRJENO: TLabel;
    LBBSENO: TLabel;
    LBRJDAT: TLabel;
    LBBNENO: TLabel;
    LBRJMRK: TLabel;
    LBRJAM1: TLabel;
    RJAMT: TJDBEdit;
    RJMRK: TDBMemo;
    RJENO: TJDBEdit;
    BSENO: JDBLOOKUPBOX;
    RJDAT: TJDBEdit;
    BNENO: JDBLOOKUPBOX;
    RJAM1: TJDBEdit;
    GroupBox1: TGroupBox;
    LB1: TLabel;
    LB3: TLabel;
    Label7: TLabel;
    Label6: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    LB11: TJEdit;
    LB12: TJEdit;
    LB51: TJEdit;
    LB41: TJEdit;
    LB42: TJEdit;
    LB61: TJEdit;
    BTNSER: TBitBtn;
    BTNCLR: TBitBtn;
    BTNPRE: TBitBtn;
    BTNPRN: TBitBtn;
    MainMenu: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N6: TMenuItem;
    MENPRE: TMenuItem;
    MENPRN: TMenuItem;
    N5: TMenuItem;
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
    T_RJMEM : STRING;
    T_RJIID : STRING;
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
  FMRCJN: TFMRCJN;

implementation

uses SYSINI, UN_UTL, FM_UTL, DB_UTL, MAIND, MAINU,
     UNRCJND, UNRCJNP;

{$R *.DFM}

PROCEDURE TFMRCJN.QUERY_RCON;
BEGIN
FMRCJND.QRCJN.SQL.CLEAR;
FMRCJND.QRCJN.SQL.ADD('SELECT * FROM RCJN');
//FMRCJND.QRCJN.SQL.ADD('WHERE RJTYP = '''+FORMTYPE+'''');
FMRCJND.QRCJN.SQL.ADD('ORDER BY RJENO');

FMRCJND.QRCJN.CLOSE;
FMRCJND.QRCJN.OPEN;
END;

procedure TFMRCJN.BTNMODE;
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

//IF FMRCJND.QRCJN.Eof = TRUE THEN BTNDEL.Enabled := FALSE;
end;

procedure TFMRCJN.INSERTMODE;
begin
FORMMODE := 'INS';
BTNMODE;
DBGrid1.Enabled := FALSE;
end;

procedure TFMRCJN.UPDATEMODE;
begin
FORMMODE := 'UPD';
BTNMODE;
DBGrid1.Enabled := FALSE;
end;

procedure TFMRCJN.NORMALMODE;
begin
FORMMODE := 'CAN';
BTNMODE;
DBGrid1.Enabled := TRUE;
end;

procedure TFMRCJN.FormCreate(Sender: TObject);
begin
IF FormExists('FMRCJND')=FALSE THEN Application.CreateForm(TFMRCJND, FMRCJND );

     //按钮图形加载
     BTNINS.Glyph := INS_TB;
     BTNDEL.Glyph := DEL_TB;
     BTNYES.Glyph := YES_TB;
     BTNCAL.Glyph := CAL_TB;
     BTNSER.Glyph := SER_TB;
     BTNCLR.Glyph := CLR_TB;
//     BTNLST.Glyph := PRN_TB;
     BTNPRN.Glyph := PRN_TB;
     BTNPRE.Glyph := PRE_TB;
     BTNSET.Glyph := SET_TB;
     BTNQUT.Glyph := QUT_TB;

     FMRCJND.URCJN.InsertSQL.CLEAR;
     FMRCJND.URCJN.InsertSQL.Add('INSERT INTO RCJN ');
     FMRCJND.URCJN.InsertSQL.Add(' ( RJENO, RJTYP, RJDAT, BNENO, BSENO, RJAM1, RJAMT, RJMRK, RJSTA ) ');
     FMRCJND.URCJN.InsertSQL.Add('VALUES ');
     FMRCJND.URCJN.InsertSQL.Add(' (:RJENO,:RJTYP,:RJDAT,:BNENO,:BSENO,:RJAM1,:RJAMT,:RJMRK,:RJSTA ) ');

     FMRCJND.URCJN.ModifySQL.CLEAR;
     FMRCJND.URCJN.ModifySQL.Add('UPDATE RCJN ');
     FMRCJND.URCJN.ModifySQL.Add('SET ');
     FMRCJND.URCJN.ModifySQL.Add('RJENO = :RJENO ,');
     FMRCJND.URCJN.ModifySQL.Add('RJTYP = :RJTYP ,');
     FMRCJND.URCJN.ModifySQL.Add('RJDAT = :RJDAT ,');
     FMRCJND.URCJN.ModifySQL.Add('BNENO = :BNENO ,');
     FMRCJND.URCJN.ModifySQL.Add('BSENO = :BSENO ,');
     FMRCJND.URCJN.ModifySQL.Add('RJAM1 = :RJAM1 ,');
     FMRCJND.URCJN.ModifySQL.Add('RJAMT = :RJAMT ,');
     FMRCJND.URCJN.ModifySQL.Add('RJMRK = :RJMRK  ');
     FMRCJND.URCJN.ModifySQL.Add('WHERE RJENO = :OLD_RJENO');

     FMRCJND.URCJN.DeleteSQL.CLEAR;
     FMRCJND.URCJN.DeleteSQL.Add('DELETE FROM RCJN ');
     FMRCJND.URCJN.DeleteSQL.Add('WHERE RJENO = :OLD_RJENO');

     FMRCJND.URCJNB.InsertSQL.CLEAR;
     FMRCJND.URCJNB.InsertSQL.Add('INSERT INTO RCJNB ');
     FMRCJND.URCJNB.InsertSQL.Add(' ( RJENO, RJITM, BGENO, RJGCN, RJGCS, RJGCT ) ');
     FMRCJND.URCJNB.InsertSQL.Add('VALUES ');
     FMRCJND.URCJNB.InsertSQL.Add(' (:RJENO,:RJITM,:BGENO,:RJGCN,:RJGCS,:RJGCT ) ');

     FMRCJND.URCJNB.ModifySQL.CLEAR;
     FMRCJND.URCJNB.ModifySQL.Add('UPDATE RCJNB ');
     FMRCJND.URCJNB.ModifySQL.Add('SET ');
     FMRCJND.URCJNB.ModifySQL.Add('RJENO = :RJENO ,');
     FMRCJND.URCJNB.ModifySQL.Add('RJITM = :RJITM ,');
     FMRCJND.URCJNB.ModifySQL.Add('BGENO = :BGENO ,');
     FMRCJND.URCJNB.ModifySQL.Add('RJGCN = :RJGCN ,');
     FMRCJND.URCJNB.ModifySQL.Add('RJGCS = :RJGCS ,');
     FMRCJND.URCJNB.ModifySQL.Add('RJGCT = :RJGCT  ');
     FMRCJND.URCJNB.ModifySQL.Add('WHERE RJENO = :OLD_RJENO');
     FMRCJND.URCJNB.ModifySQL.Add('  AND RJITM = :OLD_RJITM');

     FMRCJND.URCJNB.DeleteSQL.CLEAR;
     FMRCJND.URCJNB.DeleteSQL.Add('DELETE FROM RCJNB ');
     FMRCJND.URCJNB.DeleteSQL.Add('WHERE RJENO = :OLD_RJENO');
     FMRCJND.URCJNB.DeleteSQL.Add('  AND RJITM = :OLD_RJITM');

     QUERY_RCON;

NORMALMODE;
end;

procedure TFMRCJN.FormClose(Sender: TObject; var Action: TCloseAction);
begin

FormFREE('FMRCJNP');
DataModuleRelease(FMRCJND);
FormRelease(FMRCJN );
end;

procedure TFMRCJN.BTNINSClick(Sender: TObject);
VAR T_ROMEM : STRING;
begin
//检查权限============================================
IF PERMISSION_CHECK(_USER_ID,'RCJN_INS') = FALSE THEN EXIT;

  WITH FMRCJND DO
    BEGIN
    QRCJN.APPEND;
    QRCJNRJENO.VALUE := TABLEFINDMAXCNT('RCJN','RJENO',4,1);
    QRCJNRJTYP.VALUE := FORMTYPE;
    QRCJNRJDAT.VALUE := DATE;
    QRCJNBNENO.VALUE := _USER_ID;
    QRCJNBSENO.VALUE := ''  ;
    QRCJNRJAM1.VALUE := 0   ;
    QRCJNRJAMT.VALUE := 0   ;
    QRCJNRJMRK.VALUE := ''  ;
    QRCJNRJSTA.VALUE := FALSE;
    END;

end;

procedure TFMRCJN.BTNDELClick(Sender: TObject);
begin
//检查权限============================================
IF PERMISSION_CHECK(_USER_ID,'RCJN_DEL') = FALSE THEN EXIT;

    IF MessageDlg('是否确定要删除此条记录吗?',mtWarning, [mbYes, mbNo], 0) = mrYes then
    BEGIN IF MessageDlg('如果您按下确定按钮此条记录将会被删除',mtWarning, [mbYes, mbNo], 0) = mrYes then     BEGIN

      WITH FMRCJND DO
        BEGIN

        QRCJNB.First;
        WHILE NOT QRCJNB.Eof DO
          BEGIN
          BGDS_UPDATE_BGQTN( QRCJNB.FieldByName('BGENO').AsString,
                - QRCJNB.FieldByName('RJGCN').AsINTEGER); //进货单
          QRCJNB.Next;
          END;


          try
            FMMAIND.QDEL.SQL.Clear;
            FMMAIND.QDEL.SQL.Add('DELETE FROM RCJNB WHERE RJENO = '''+RJENO.Text+'''');
            FMMAIND.QDEL.ExecSQL;
          except  SHOWMESSAGE('B表删除失败!');  END;


        FMRCJND.QRCJN.Delete;
        FM_DB_QUERY_UPDATE(FMMAIND.DATABASE,FMRCJND.QRCJN);
        
//        BTNYES.Click;
        END;
        
      END;
    END;


end;

procedure TFMRCJN.BTNYESClick(Sender: TObject);
begin
//检查权限============================================
IF PERMISSION_CHECK(_USER_ID,'RCJN_UPD') = FALSE THEN EXIT;

IF FMRCJND.QRCJNB.Modified = TRUE THEN
   BEGIN
   FMRCJND.QRCJNB.POST;
   END;

IF FMRCJND.QRCJN.Modified  = TRUE THEN
   BEGIN
   FMRCJND.QRCJN.POST;
   FM_DB_QUERY_UPDATE(FMMAIND.DATABASE,FMRCJND.QRCJN);
   END;



NORMALMODE;
end;


procedure TFMRCJN.BTNCALClick(Sender: TObject);
begin
FMRCJND.QRCJN.Cancel;
FMRCJND.QRCJNB.Cancel;
NORMALMODE;
end;

procedure TFMRCJN.BTNQUTClick(Sender: TObject);
begin
CLOSE;
end;


procedure TFMRCJN.N1Click(Sender: TObject);
begin
BGDS_UPDATE_BGQTN( FMRCJND.QRCJNB.FieldByName('BGENO').AsString,
                 - FMRCJND.QRCJNB.FieldByName('RJGCN').AsINTEGER); //进货单

FMRCJND.QRCJNB.DELETE;
FM_DB_QUERY_UPDATE(FMMAIND.DATABASE,FMRCJND.QRCJNB);
end;

procedure TFMRCJN.N2Click(Sender: TObject);
begin
BTNCAL.CLICK;
end;

procedure TFMRCJN.BTNPRNClick(Sender: TObject);
begin
//检查权限============================================
IF PERMISSION_CHECK(_USER_ID,'RCJN_PRN') = FALSE THEN EXIT;

 IF FormExists('FMRCJNP')=FALSE THEN Application.CreateForm(TFMRCJNP, FMRCJNP  );
 IF SENDER = BTNPRE THEN FMRCJNP.QuickRep.Preview;
 IF SENDER = MENPRE THEN FMRCJNP.QuickRep.Preview;
 IF SENDER = BTNPRN THEN FMRCJNP.QuickRep.Print;
 IF SENDER = MENPRN THEN FMRCJNP.QuickRep.Print;
end;

procedure TFMRCJN.DBGrid2EditButtonClick(Sender: TObject);
begin
 BGENO.Text := FMRCJND.QRCJNBBGENO.VALUE;
 FMRCJND.QRCJNB.Edit;
 FMRCJND.QRCJNBBGENO.VALUE := BGENO.CALL_FMLOOKUP_IDNO  ;
end;

procedure TFMRCJN.DBGrid2ColExit(Sender: TObject);
begin


IF FMRCJND.QRCJNB.Modified = TRUE THEN
   BEGIN
   IF DBGRID2.Columns.Grid.SelectedIndex <= 2 THEN
      BEGIN
      FMRCJND.QRCJNBRJGCN.VALUE := 1;
      FMRCJND.QRCJNBRJGCS.VALUE := STRTOINTDEF(DB_QUERY_FIND_VALUE('BGDS','BGENO',FMRCJND.QRCJNB.FIELDBYNAME('BGENO').AsString,'BGPST'),0);
      FMRCJND.QRCJNBRJGCT.VALUE := STRTOINTDEF(DB_QUERY_FIND_VALUE('BGDS','BGENO',FMRCJND.QRCJNB.FIELDBYNAME('BGENO').AsString,'BGPST'),0);
      END;


   FMRCJND.QRCJNBRJGCT.VALUE := FMRCJND.QRCJNBRJGCN.VALUE * FMRCJND.QRCJNBRJGCS.VALUE;
   END;
end;

procedure TFMRCJN.BTNSERClick(Sender: TObject);
begin
//检查权限============================================
IF PERMISSION_CHECK(_USER_ID,'RCJN_SEA') = FALSE THEN EXIT;

  WITH FMRCJND.QRCJN DO
  BEGIN
    CLOSE;
    SQL.CLEAR;
    SQL.ADD('SELECT * FROM RCJN');
    SQL.ADD('WHERE RJENO IS NOT NULL');

    //字符串查询
    SQL.ADD(FINDFORM_WHEREKEY_STRING('RJENO',LB11.Text,LB12.Text));
    SQL.ADD(FINDFORM_WHEREKEY_STRING('BSENO',LB51.Text,''));
    SQL.ADD(FINDFORM_WHEREKEY_STRING('BNENO',LB61.Text,''));

    //ACCESS " DATE " WHERE KEY  ======================
    SQL.ADD(FINDFORM_WHEREKEY_DATE('RJDAT',LB41.Text,LB42.Text));

    //查询 排序    //ORDER BYE=======================================
//    SQL.ADD(FINDFORM_ORDERBY3(F_NAME[1],F_NAME[2],F_NAME[3],WHEREKEY1.ItemIndex,WHEREKEY2.ItemIndex,WHEREKEY3.ItemIndex));

//    SHOWMESSAGE(SQL.TEXT);
    OPEN;
  END;



end;

procedure TFMRCJN.BTNCLRClick(Sender: TObject);
begin
LB11.Clear;
LB12.Clear;
LB41.Clear;
LB42.Clear;
LB51.Clear;
LB61.Clear;

end;


end.
