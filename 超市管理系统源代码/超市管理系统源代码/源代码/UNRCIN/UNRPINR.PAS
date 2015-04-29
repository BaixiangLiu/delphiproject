unit UNRPINR;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ComCtrls, ToolWin, JLOOKUP, JEdit, ExtCtrls, Grids,
  DBGrids, Gauges;

type
  TFMRPINR = class(TForm)
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    Panel5: TPanel;
    BTNINA: TBitBtn;
    BTNQUT: TBitBtn;
    Gauge: TGauge;
    Label8: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    procedure BTNQUTClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BTNINAClick(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGrid2DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGrid2DblClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMRPINR: TFMRPINR;

implementation

uses sysini, fm_utl, UNRPIND, UNRPIN, MAINU, MAIND, DB_UTL, UN_UTL;

{$R *.DFM}



procedure TFMRPINR.FormCreate(Sender: TObject);
begin
     FMRPIND.QRPCHA.SQL.CLEAR;
     FMRPIND.QRPCHA.SQL.ADD('SELECT *  ');
     FMRPIND.QRPCHA.SQL.ADD('FROM RPCHA ');
     FMRPIND.QRPCHA.SQL.ADD('WHERE RHTRN = 0 ');
     FMRPIND.QRPCHA.SQL.ADD('ORDER BY RHPTD ');

     FMRPIND.URPCHA.InsertSQL.CLEAR;
     FMRPIND.URPCHA.InsertSQL.Add('INSERT INTO RPCHA ');
     FMRPIND.URPCHA.InsertSQL.Add(' ( RHENO, BSENO, RHPTD, RHPTT, RHPDT, BNENO, RHSAT, RHTRN, RHMRK, RHMEM ) ');
     FMRPIND.URPCHA.InsertSQL.Add('VALUES ');
     FMRPIND.URPCHA.InsertSQL.Add(' (:RHENO,:BSENO,:RHPTD,:RHPTT,:RHPDT,:BNENO,:RHSAT,:RHTRN,:RHMRK,:RHMEM ) ');

     FMRPIND.URPCHA.ModifySQL.CLEAR;
     FMRPIND.URPCHA.ModifySQL.Add('UPDATE RPCHA ');
     FMRPIND.URPCHA.ModifySQL.Add('SET ');
     FMRPIND.URPCHA.ModifySQL.Add('RHENO = :RHENO ,');
     FMRPIND.URPCHA.ModifySQL.Add('BSENO = :BSENO ,');
     FMRPIND.URPCHA.ModifySQL.Add('RHPTD = :RHPTD ,');
     FMRPIND.URPCHA.ModifySQL.Add('RHPTT = :RHPTT ,');
     FMRPIND.URPCHA.ModifySQL.Add('RHPDT = :RHPDT ,');
     FMRPIND.URPCHA.ModifySQL.Add('BNENO = :BNENO ,');
     FMRPIND.URPCHA.ModifySQL.Add('RHSAT = :RHSAT ,');
     FMRPIND.URPCHA.ModifySQL.Add('RHTRN = :RHTRN ,');
     FMRPIND.URPCHA.ModifySQL.Add('RHMRK = :RHMRK ,');
     FMRPIND.URPCHA.ModifySQL.Add('RHMEM = :RHMEM  ');
     FMRPIND.URPCHA.ModifySQL.Add('WHERE RHENO = :OLD_RHENO');

     FMRPIND.URPCHA.DeleteSQL.CLEAR;
     FMRPIND.URPCHA.DeleteSQL.Add('DELETE FROM RPCHA ');
     FMRPIND.URPCHA.DeleteSQL.Add('WHERE RHENO = :OLD_RHENO');

     FMRPIND.QRPCHB.SQL.CLEAR;
     FMRPIND.QRPCHB.SQL.ADD('SELECT *  ');
     FMRPIND.QRPCHB.SQL.ADD('FROM RPCHB ,BGDS');

     FMRPIND.URPCHB.InsertSQL.CLEAR;
     FMRPIND.URPCHB.InsertSQL.Add('INSERT INTO RPCHB ');
     FMRPIND.URPCHB.InsertSQL.Add(' ( RHENO, BGENO, RHCSI, RHCST, RHPCA, RHTRN ) ');
     FMRPIND.URPCHB.InsertSQL.Add('VALUES ');
     FMRPIND.URPCHB.InsertSQL.Add(' (:RHENO,:BGENO,:RHCSI,:RHCST,:RHPCA,:RHTRN ) ');

     FMRPIND.URPCHB.ModifySQL.CLEAR;
     FMRPIND.URPCHB.ModifySQL.Add('UPDATE RPCHB ');
     FMRPIND.URPCHB.ModifySQL.Add('SET ');
     FMRPIND.URPCHB.ModifySQL.Add('RHENO = :RHENO ,');
     FMRPIND.URPCHB.ModifySQL.Add('BGENO = :BGENO ,');
     FMRPIND.URPCHB.ModifySQL.Add('RHCSI = :RHCSI ,');
     FMRPIND.URPCHB.ModifySQL.Add('RHCST = :RHCST ,');
     FMRPIND.URPCHB.ModifySQL.Add('RHPCA = :RHPCA ,');
     FMRPIND.URPCHB.ModifySQL.Add('RHTRN = :RHTRN  ');
     FMRPIND.URPCHB.ModifySQL.Add('WHERE RHENO = :OLD_RHENO');
     FMRPIND.URPCHB.ModifySQL.Add('  AND BGENO = :OLD_BGENO');

     FMRPIND.URPCHB.DeleteSQL.CLEAR;
     FMRPIND.URPCHB.DeleteSQL.Add('DELETE FROM RPCHB ');
     FMRPIND.URPCHB.DeleteSQL.Add('WHERE RHENO = :OLD_RHENO');
     FMRPIND.URPCHB.DeleteSQL.Add('  AND BGENO = :OLD_BGENO');

     FMRPIND.QRPCHA.CLOSE;
     FMRPIND.QRPCHA.OPEN;
     
end;

procedure TFMRPINR.FormClose(Sender: TObject; var Action: TCloseAction);
begin
FMRPIND.QRCINB.Close;
FMRPIND.QRCINB.OPEN;

FMRPINR.Release;
end;

procedure TFMRPINR.BTNQUTClick(Sender: TObject);
begin
CLOSE;
end;


procedure TFMRPINR.BTNINAClick(Sender: TObject);
VAR T_RCENO : STRING;
    T_BSID1,T_BSAD2,T_BSTTP,T_BSTEG:STRING;
begin

Gauge.Progress := 0;
Gauge.MaxValue := FMRPIND.QRPCHB.RecordCount;
T_RCENO := TABLEFINDMAXCNT('RCIN','RIENO',4,1);

  WITH FMRPIND DO
    BEGIN
    QRCIN.APPEND;
    QRCINRIENO.VALUE := T_RCENO;
    QRCINRITYP.VALUE := FMRPIN.FORMTYPE;
    QRCINRIDAT.VALUE := DATE;
    QRCINRITME.VALUE := TIME_GET_24H(TIME);
    QRCINBNENO.VALUE := _USER_ID;
    QRCINBSENO.VALUE := QRPCHA.FieldByName('BSENO').AsString;
    QRCINRIINO.VALUE := ''  ;
    QRCINRIIID.VALUE := ''  ;
    QRCINRIIAD.VALUE := ''  ;
    QRCINRIPAY.VALUE := '001'  ;
    QRCINRIEXG.VALUE := 'TW'  ;
    QRCINRIEXR.VALUE := 1   ;
    QRCINRITX1.VALUE := 0   ;
    QRCINRITX2.VALUE := 0   ;
    QRCINRIAM1.VALUE := 0   ;
    QRCINRIAM2.VALUE := 0   ;
    QRCINRIAM3.VALUE := 0   ;
    QRCINRIAMT.VALUE := 0   ;
    QRCINRISA1.VALUE := 0   ;
    QRCINRISA2.VALUE := 0   ;
    QRCINRISA3.VALUE := 0   ;
    QRCINRISA4.VALUE := 0   ;
    QRCINRISA5.VALUE := 0   ;
    QRCINRISA6.VALUE := 0   ;
    QRCINRISA7.VALUE := 0   ;
    QRCINRIMRK.VALUE := ''  ;
    QRCINRIMEM.VALUE := FMRPIN.T_RIMEM;

    T_BSID1 := DB_QUERY_FIND_VALUE('BSUP','BSENO',QRCINBSENO.VALUE,'BSID1');
    T_BSAD2 := DB_QUERY_FIND_VALUE('BSUP','BSENO',QRCINBSENO.VALUE,'BSAD2');
    T_BSTTP := DB_QUERY_FIND_VALUE('BSUP','BSENO',QRCINBSENO.VALUE,'BSTTP');
    T_BSTEG := DB_QUERY_FIND_VALUE('BSUP','BSENO',QRCINBSENO.VALUE,'BSTEG');
    IF T_BSID1 <> '' THEN FMRPIND.QRCINRIIID.AsString := T_BSID1;
    IF T_BSAD2 <> '' THEN FMRPIND.QRCINRIIAD.AsString := T_BSAD2;
    IF T_BSTTP <> '' THEN FMRPIND.QRCINRIPAY.AsString := T_BSTTP;
    IF T_BSTEG <> '' THEN FMRPIND.QRCINRIEXG.AsString := T_BSTEG;

    FM_DB_QUERY_POST(FMMAIND.DATABASE,QRCIN);
    Gauge.AddProgress(1);

    QRCINB.SQL.CLEAR;
    QRCINB.SQL.ADD('SELECT *  ');
    QRCINB.SQL.ADD('FROM RCINB ');
    QRCINB.SQL.ADD('WHERE RIENO = '''+T_RCENO+'''');
    QRCINB.SQL.ADD('ORDER BY RIENO, RIITM');
    QRCINB.CLOSE;
    QRCINB.OPEN;


    QRPCHB.FIRST;
    WHILE NOT QRPCHB.Eof DO
      BEGIN
      FMMAIND.QINS.SQL.Clear;
      FMMAIND.QINS.SQL.ADD('INSERT INTO RCINB');
      FMMAIND.QINS.SQL.ADD(' ( RIENO, RIITM,  ');
      FMMAIND.QINS.SQL.ADD('   BGENO, RIUNP,  ');
      FMMAIND.QINS.SQL.ADD('   RIGCN, RIGCS,  ');
      FMMAIND.QINS.SQL.ADD('   RIGCT, RBPST ) ');
      FMMAIND.QINS.SQL.ADD('VALUES');
      FMMAIND.QINS.SQL.ADD('('''+T_RCENO+''',');
      FMMAIND.QINS.SQL.ADD(' '''+TABLEFINDMAXITM('RCINB','RIENO',T_RCENO,'RIITM',5,1)+''',');
      FMMAIND.QINS.SQL.ADD(' '''+QRPCHB.FieldByName('BGENO').AsString+''',');
      FMMAIND.QINS.SQL.ADD(' '''+'001'+''',');  //-----------------------------
      FMMAIND.QINS.SQL.ADD(' '''+QRPCHB.FieldByName('RHPCA').Asstring+''',');
      FMMAIND.QINS.SQL.ADD(' '''+QRPCHB.FieldByName('RHCSI').Asstring+''',');
      FMMAIND.QINS.SQL.ADD(' '''+QRPCHB.FieldByName('RHCST').Asstring+''',');
//      FMMAIND.QINS.SQL.ADD(' '''++''' ');
      FMMAIND.QINS.SQL.ADD(' '''+''+''')');
      FMMAIND.QINS.ExecSQL;

      Gauge.AddProgress(1);
      QRPCHB.Next;
      END;

    END;

IF MessageDlg('是否要注销此采购单?',mtConfirmation,[mbYes,mbNo],0) = mrYES THEN
   BEGIN
   FMRPIND.QRPCHA.Edit;
   FMRPIND.QRPCHARHTRN.Value := NOT FMRPIND.QRPCHARHTRN.Value;
   FM_DB_QUERY_POST(FMMAIND.DATABASE,FMRPIND.QRPCHA);
   END;

CLOSE;
end;

procedure TFMRPINR.DBGrid1DrawColumnCell(Sender: TObject;  const Rect: TRect; DataCol: Integer; Column: TColumn;  State: TGridDrawState);
begin
GRID_DRAWCOLUMNCELL(Sender, Rect, DataCol, Column, State,True_bmp, False_bmp, Blank_bmp);
end;

procedure TFMRPINR.DBGrid2DrawColumnCell(Sender: TObject;  const Rect: TRect; DataCol: Integer; Column: TColumn;  State: TGridDrawState);
begin
GRID_DRAWCOLUMNCELL(Sender, Rect, DataCol, Column, State,True_bmp, False_bmp, Blank_bmp);
end;

procedure TFMRPINR.DBGrid2DblClick(Sender: TObject);
VAR T_RIENO, T_BGENO, T_BGCNT, T_BGCSI, T_BGCOT : STRING;
begin

IF FMRPIND.QRPCHB.Eof = TRUE THEN EXIT;

IF FMRPIND.QRPCHBRHTRN.Value = FALSE THEN
BEGIN

T_RIENO := FMRPIND.QRCINRIENO.AsString;
T_BGENO := FMRPIND.QRPCHB.FieldByName('BGENO').AsString;
T_BGCNT := FMRPIND.QRPCHB.FieldByName('RHPCA').Asstring;
T_BGCSI := FMRPIND.QRPCHB.FieldByName('RHCSI').Asstring;
T_BGCOT := FMRPIND.QRPCHB.FieldByName('RHCST').Asstring;

      FMMAIND.QINS.SQL.Clear;
      FMMAIND.QINS.SQL.ADD('INSERT INTO RCINB');
      FMMAIND.QINS.SQL.ADD(' ( RIENO, RIITM,  ');
      FMMAIND.QINS.SQL.ADD('   BGENO, RIUNP,  ');
      FMMAIND.QINS.SQL.ADD('   RIGCN, RIGCS,  ');
      FMMAIND.QINS.SQL.ADD('   RIGCT, RBPST ) ');
      FMMAIND.QINS.SQL.ADD('VALUES');
      FMMAIND.QINS.SQL.ADD('('''+T_RIENO+''',');
      FMMAIND.QINS.SQL.ADD(' '''+TABLEFINDMAXITM('RCINB','RIENO',T_RIENO,'RIITM',5,1)+''',');
      FMMAIND.QINS.SQL.ADD(' '''+T_BGENO+''',');
      FMMAIND.QINS.SQL.ADD(' '''+'001'+''',');  //-----------------------------
      FMMAIND.QINS.SQL.ADD(' '''+T_BGCNT+''',');
      FMMAIND.QINS.SQL.ADD(' '''+T_BGCSI+''',');
      FMMAIND.QINS.SQL.ADD(' '''+T_BGCOT+''',');
      FMMAIND.QINS.SQL.ADD(' '''+''+''')');
      FMMAIND.QINS.ExecSQL;

 FMRPIND.QRPCHB.EDIT;
 FMRPIND.QRPCHBRHTRN.Value := TRUE;
 FM_DB_QUERY_POST(FMMAIND.DATABASE,FMRPIND.QRPCHB);

END ELSE BEGIN
 FMRPIND.QRPCHB.EDIT;
 FMRPIND.QRPCHBRHTRN.Value := FALSE;
 FM_DB_QUERY_POST(FMMAIND.DATABASE,FMRPIND.QRPCHB);
END;

end;

procedure TFMRPINR.DBGrid1DblClick(Sender: TObject);
begin

FMRPIND.QRPCHA.Edit;
FMRPIND.QRPCHARHTRN.Value := NOT FMRPIND.QRPCHARHTRN.Value;
FM_DB_QUERY_POST(FMMAIND.DATABASE,FMRPIND.QRPCHA);

end;

end.
