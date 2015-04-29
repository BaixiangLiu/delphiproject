unit MAINT;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Spin, JEdit, ExtCtrls, ComCtrls, Buttons, DBTables, Db, Grids,
  DBGrids, Gauges;

type
  TFMMAINT = class(TForm)
    BTNYES: TBitBtn;
    BTNNO: TBitBtn;
    Memo1: TMemo;
    DatabaseP: TDatabase;
    PUERY: TQuery;
    PINS: TQuery;
    QUERY1: TQuery;
    QINS: TQuery;
    QUERY2: TQuery;
    Gauge: TGauge;
    CB_SYS: TCheckBox;
    CB_BMAN: TCheckBox;
    CB_BGDS: TCheckBox;
    CB_BMEM: TCheckBox;
    CB_POSA: TCheckBox;
    BGDS_DAT1: TJEdit;
    BGDS_DAT2: TJEdit;
    Label1: TLabel;
    BMEM_DAT1: TJEdit;
    Label2: TLabel;
    BMEM_DAT2: TJEdit;
    POSA_DAT1: TJEdit;
    Label3: TLabel;
    POSA_DAT2: TJEdit;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure BTNYESClick(Sender: TObject);
    procedure BTNNOClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }

    P_DT :STRING;
    PROCEDURE INS_SYSLOG;
    PROCEDURE INS_SYSLST;
    PROCEDURE INS_SYSPMS;
    PROCEDURE INS_SYSPSW;
    PROCEDURE INS_BMAN;
    PROCEDURE INS_BGDS;
    PROCEDURE INS_BMEM;
    PROCEDURE INS_POSA;
    PROCEDURE INS_POSA_PABCK;

    function SQLSERVERFINDFORM_WHEREKEY_DATE(F_NAME, T_DATE1,T_DATE2:STRING):STRING;
  public
    { Public declarations }
  end;

FUNCTION BOOLEANTOSTR(TB : BOOLEAN):STRING;
var
  FMMAINT: TFMMAINT;

implementation

USES UN_UTL, DB_UTL, SYSINI,
     MAIND, MAINU;

{$R *.DFM}

FUNCTION BOOLEANTOSTR(TB : BOOLEAN):STRING;
BEGIN
RESULT := '0';
IF TB= TRUE THEN RESULT := '1' ELSE RESULT := '0';
END;

//ACCESS " DATE " WHERE KEY  ======================
function TFMMAINT.SQLSERVERFINDFORM_WHEREKEY_DATE(F_NAME, T_DATE1,T_DATE2:STRING):STRING;
VAR T1, T2 : STRING;
BEGIN
RESULT := '';

   IF T_DATE1 <> '' THEN T1 := CDATE_TO_EDATE(T_DATE1);
   IF T_DATE2 <> '' THEN T2 := CDATE_TO_EDATE(T_DATE2);
   IF (TRIM(T1)<>'')AND(TRIM(T2)<>'') THEN
      BEGIN
      RESULT := 'AND '+F_NAME+'>='''+ T1 +''' AND '+F_NAME+'<='''+ T2 +'''';
      END ELSE
      BEGIN
      IF TRIM(T1)<>'' THEN RESULT := 'AND '+F_NAME+' = '''+ T1 +'''';
      IF TRIM(T2)<>'' THEN RESULT := 'AND '+F_NAME+' = '''+ T2 +'''';
      END;
END;

PROCEDURE TFMMAINT.INS_SYSLOG;
VAR SGENO,SGKIN,RBPST,PAIDE,BNENO,SGDAT,SGTME,SGMRK : STRING;
BEGIN
MEMO1.Lines.Add('上载系统记录文件');
QUERY1.SQL.CLEAR;      //SERVER===============================
QUERY1.SQL.ADD('SELECT * FROM SYSLOG');
QUERY1.Close;
QUERY1.OPEN;
Gauge.MaxValue := QUERY1.RecordCount;

QUERY1.FIRST;
WHILE NOT QUERY1.EOF DO
 BEGIN
 //抓取系统 SERVER LOG 编号
 SGENO := DBTABLEFINDMAXCNT('MAINP','SYSLOG','SGENO',9,1);
 SGKIN :=           QUERY1.FieldByName('SGKIN' ).AsString;
 RBPST :=           QUERY1.FieldByName('RBPST' ).AsString;
 PAIDE :=           QUERY1.FieldByName('PAIDE' ).AsString;
 BNENO :=           QUERY1.FieldByName('BNENO' ).AsString;
 SGDAT := DATETOSTR(QUERY1.FieldByName('SGDAT' ).AsDATETIME);
 SGTME :=           QUERY1.FieldByName('SGTME' ).AsString;
 SGMRK :=           QUERY1.FieldByName('SGMRK' ).AsString;

 PINS.Close;   // LOCAL INSERT
 PINS.SQL.CLEAR;
 PINS.SQL.Add('INSERT INTO SYSLOG');
 PINS.SQL.Add('( SGENO , SGKIN , RBPST , PAIDE ,');
 PINS.SQL.Add('  BNENO , SGDAT , SGTME , SGMRK  ');
 PINS.SQL.Add(') VALUES (');
 PINS.SQL.Add(''''+SGENO+''', ');
 PINS.SQL.Add(''''+SGKIN+''', ');
 PINS.SQL.Add(''''+RBPST+''', ');
 PINS.SQL.Add(''''+PAIDE+''', ');
 PINS.SQL.Add(''''+BNENO+''', ');
 PINS.SQL.Add(''''+SGDAT+''', ');
 PINS.SQL.Add(''''+SGTME+''', ');
 PINS.SQL.Add(''''+SGMRK+''') ');
 TRY PINS.EXECSQL; EXCEPT MEMO1.Lines.Add('上载系统记录文件 '+PINS.FieldByName('SGENO').AsString+'更新失败');  END;
 QUERY1.Next;
 Gauge.AddProgress(1);
 END;

 QINS.Close;   // LOCAL SYSLOG DELETE
 QINS.SQL.CLEAR;
 QINS.SQL.Add('DELETE FROM SYSLOG');
 TRY QINS.EXECSQL; EXCEPT END;
Gauge.Progress := 0;
END;

PROCEDURE TFMMAINT.INS_SYSLST;
BEGIN
MEMO1.Lines.Add('检查系统设置');
PUERY.SQL.CLEAR;      //SERVER===============================
PUERY.SQL.ADD('SELECT * FROM SYSLST');
PUERY.Close;
PUERY.OPEN;
Gauge.MaxValue := PUERY.RecordCount;

PUERY.FIRST;
WHILE NOT PUERY.EOF DO
 BEGIN
 QUERY1.SQL.CLEAR;      //LOCAL------------------------
 QUERY1.SQL.ADD('SELECT * FROM SYSLST');
 QUERY1.SQL.ADD('WHERE LSTID1 = '''+PUERY.FieldByName('LSTID1').AsString+'''');
 QUERY1.SQL.ADD('  AND LSTID2 = '''+PUERY.FieldByName('LSTID2').AsString+'''');
 QUERY1.Close;
 QUERY1.OPEN;
 IF QUERY1.EOF = FALSE THEN // UPDATE
    BEGIN
//    MEMO1.Lines.Add('更新系统设置 '+PUERY.FieldByName('LSTID1').AsString+PUERY.FieldByName('LSTID2').AsString);
    QINS.Close;   // LOCAL INSERT
    QINS.SQL.CLEAR;
    QINS.SQL.ADD('UPDATE SYSLST ');
    QINS.SQL.ADD('SET ');
    QINS.SQL.ADD('LSTNAM = '''+PUERY.FieldByName('LSTNAM').AsString+''', ');
    QINS.SQL.ADD('LSTMRK = '''+PUERY.FieldByName('LSTMRK').AsString+'''  ');
    QINS.SQL.ADD('WHERE LSTID1 = '''+PUERY.FieldByName('LSTID1').AsString+'''');
    QINS.SQL.ADD('  AND LSTID2 = '''+PUERY.FieldByName('LSTID2').AsString+'''');
    TRY QINS.EXECSQL; EXCEPT MEMO1.Lines.Add('更新系统设置 '+PUERY.FieldByName('LSTID1').AsString+PUERY.FieldByName('LSTID2').AsString+'更新失败');  END;
    END;
 IF QUERY1.EOF = TRUE THEN  //INSERT
    BEGIN
//    MEMO1.Lines.Add('新增系统设置 '+PUERY.FieldByName('LSTID1').AsString+PUERY.FieldByName('LSTID2').AsString);
    QINS.Close;   // LOCAL INSERT
    QINS.SQL.CLEAR;
    QINS.SQL.ADD('INSERT INTO SYSLST ');
    QINS.SQL.ADD(' ( LSTID1, LSTID2, LSTNAM, LSTMRK ) ');
    QINS.SQL.ADD('VALUES (');
    QINS.SQL.ADD(' '''+PUERY.FieldByName('LSTID1').AsString+''', ');
    QINS.SQL.ADD(' '''+PUERY.FieldByName('LSTID2').AsString+''', ');
    QINS.SQL.ADD(' '''+PUERY.FieldByName('LSTNAM').AsString+''', ');
    QINS.SQL.ADD(' '''+PUERY.FieldByName('LSTMRK').AsString+''') ');
    TRY QINS.EXECSQL; EXCEPT MEMO1.Lines.Add('更新系统设置 '+PUERY.FieldByName('LSTID1').AsString+PUERY.FieldByName('LSTID2').AsString+'更新失败');  END;
    END;

 PUERY.Next;
 Gauge.AddProgress(1);
 END;

UNSETWRITE('SYSSET','_DBKIND'  ,'0');
Gauge.Progress := 0;
END;

PROCEDURE TFMMAINT.INS_SYSPMS;
VAR BNENO, PMSFUN, PMSNAM, PMSPMS :STRING;
BEGIN
MEMO1.Lines.Add('检查权限设置');
PUERY.SQL.CLEAR;      //SERVER===============================
PUERY.SQL.ADD('SELECT * FROM SYSPMS');
PUERY.Close;
PUERY.OPEN;
Gauge.MaxValue := PUERY.RecordCount;

PUERY.FIRST;
WHILE NOT PUERY.EOF DO
 BEGIN
 QUERY1.SQL.CLEAR;      //LOCAL------------------------
 QUERY1.SQL.ADD('SELECT * FROM SYSPMS');
 QUERY1.SQL.ADD('WHERE BNENO = '''+PUERY.FieldByName('BNENO').AsString+'''');
 QUERY1.SQL.ADD('  AND PMSFUN= '''+PUERY.FieldByName('PMSFUN').AsString+'''');
 QUERY1.Close;
 QUERY1.OPEN;

 BNENO  := PUERY.FieldByName('BNENO' ).AsString;
 PMSFUN := PUERY.FieldByName('PMSFUN').AsString;
 PMSNAM := PUERY.FieldByName('PMSNAM').AsString;
 PMSPMS := BOOLEANTOSTR(PUERY.FieldByName('PMSPMS').AsBOOLEAN);


 IF QUERY1.EOF = FALSE THEN // UPDATE
    BEGIN
    QINS.Close;   // LOCAL INSERT
    QINS.SQL.CLEAR;
    QINS.SQL.ADD('UPDATE SYSPMS ');
    QINS.SQL.ADD('SET ');
    QINS.SQL.ADD('PMSFUN = '''+PMSFUN+''', ');
    QINS.SQL.ADD('PMSNAM = '''+PMSNAM+''', ');
    QINS.SQL.ADD('PMSPMS =   '+PMSPMS+'    ');
    QINS.SQL.ADD('WHERE BNENO  = '''+BNENO  +'''');
    QINS.SQL.ADD('  AND PMSFUN = '''+PMSFUN +'''');
    TRY QINS.EXECSQL; EXCEPT MEMO1.Lines.Add('更新权限设置 '+PUERY.FieldByName('BNENO').AsString+'更新失败');  END;
    END;
 IF QUERY1.EOF = TRUE THEN  //INSERT
    BEGIN
    QINS.Close;   // LOCAL INSERT
    QINS.SQL.CLEAR;
    QINS.SQL.ADD('INSERT INTO SYSPMS ');
    QINS.SQL.ADD(' ( BNENO, PMSFUN, PMSNAM, PMSPMS ) ');
    QINS.SQL.ADD('VALUES (');
    QINS.SQL.ADD(' '''+BNENO +''', ');
    QINS.SQL.ADD(' '''+PMSFUN+''', ');
    QINS.SQL.ADD(' '''+PMSNAM+''', ');
    QINS.SQL.ADD('   '+PMSPMS+'  ) ');
    TRY QINS.EXECSQL; EXCEPT MEMO1.Lines.Add('更新权限设置 '+PUERY.FieldByName('BNENO').AsString+'更新失败');  END;
    END;

 PUERY.Next;
 Gauge.AddProgress(1);
 END;

Gauge.Progress := 0;
END;

PROCEDURE TFMMAINT.INS_SYSPSW;
VAR BNENO, PSWPSW, PSWPSM, PSWLOG, PSWLOM : STRING;
BEGIN
MEMO1.Lines.Add('检查密码设置');
PUERY.SQL.CLEAR;      //SERVER===============================
PUERY.SQL.ADD('SELECT * FROM SYSPSW');
PUERY.Close;
PUERY.OPEN;
Gauge.MaxValue := PUERY.RecordCount;

PUERY.FIRST;
WHILE NOT PUERY.EOF DO
 BEGIN
 QUERY1.SQL.CLEAR;      //LOCAL------------------------
 QUERY1.SQL.ADD('SELECT * FROM SYSPSW');
 QUERY1.SQL.ADD('WHERE BNENO = '''+PUERY.FieldByName('BNENO').AsString+'''');
 QUERY1.Close;
 QUERY1.OPEN;
 BNENO  := PUERY.FieldByName('BNENO').AsString;
 PSWPSW := PUERY.FieldByName('PSWPSW').AsString;
 PSWPSM := DATETOSTR(PUERY.FieldByName('PSWPSM').AsDATETIME);
 PSWLOG := DATETOSTR(PUERY.FieldByName('PSWLOG').AsDATETIME);
 PSWLOM := PUERY.FieldByName('PSWLOM').AsString;


 IF QUERY1.EOF = FALSE THEN // UPDATE
    BEGIN
    QINS.Close;   // LOCAL INSERT
    QINS.SQL.CLEAR;
    QINS.SQL.ADD('UPDATE SYSPSW ');
    QINS.SQL.ADD('SET ');
//    QINS.SQL.ADD('PSWPSW = '''+PUERY.FieldByName('PSWPSW').AsString+''', ');
    QINS.SQL.ADD('PSWPSW = :PSW ,');
    QINS.SQL.ADD('PSWPSM =  #'+PSWPSM+'# , ');
    QINS.SQL.ADD('PSWLOG =  #'+PSWLOG+'# , ');
    QINS.SQL.ADD('PSWLOM = '''+PSWLOM+'''  ');
    QINS.SQL.ADD('WHERE BNENO = '''+BNENO+'''');
    QINS.ParamByName('PSW').DataType := FTSTRING;
    QINS.ParamByName('PSW').Value    := PSWPSW;

    TRY QINS.EXECSQL; EXCEPT EXIT ; MEMO1.Lines.Add('更新密码设置 '+BNENO+'更新失败');  END;
    END;
 IF QUERY1.EOF = TRUE THEN  //INSERT
    BEGIN
    QINS.Close;   // LOCAL INSERT
    QINS.SQL.CLEAR;
    QINS.SQL.ADD('INSERT INTO SYSPSW ');
    QINS.SQL.ADD(' ( BNENO, PSWPSW, PSWPSM, PSWLOG, PSWLOM ) ');
    QINS.SQL.ADD('VALUES (');
    QINS.SQL.ADD(' '''+BNENO+''', ');
    QINS.SQL.ADD(' :PSW , ');
    QINS.SQL.ADD('  #'+PSWPSM+'# , ');
    QINS.SQL.ADD('  #'+PSWLOG+'# , ');
    QINS.SQL.ADD(' '''+PSWLOM+''') ');
    QINS.ParamByName('PSW').DataType := FTSTRING;
    QINS.ParamByName('PSW').Value    := PSWPSW;
    TRY QINS.EXECSQL; EXCEPT MEMO1.Lines.Add('更新密码设置 '+BNENO+'更新失败');  END;
    END;

 PUERY.Next;
 Gauge.AddProgress(1);
 END;

Gauge.Progress := 0;
END;

PROCEDURE TFMMAINT.INS_BMAN;
BEGIN
MEMO1.Lines.Add('检查人员设置');
PUERY.SQL.CLEAR;      //SERVER===============================
PUERY.SQL.ADD('SELECT * FROM BMAN');
PUERY.Close;
PUERY.OPEN;
Gauge.MaxValue := PUERY.RecordCount;

PUERY.FIRST;
WHILE NOT PUERY.EOF DO
 BEGIN
 QUERY1.SQL.CLEAR;      //LOCAL------------------------
 QUERY1.SQL.ADD('SELECT * FROM BMAN');
 QUERY1.SQL.ADD('WHERE BNENO = '''+PUERY.FieldByName('BNENO').AsString+'''');
 QUERY1.Close;
 QUERY1.OPEN;
 IF QUERY1.EOF = FALSE THEN // UPDATE
    BEGIN
    MEMO1.Lines.Add('更新人员设置 '+PUERY.FieldByName('BNENO').AsString+PUERY.FieldByName('BNNAM').AsString);
    QINS.Close;   // LOCAL INSERT
    QINS.SQL.CLEAR;
    QINS.SQL.ADD('UPDATE BMAN ');
    QINS.SQL.ADD('SET ');
    QINS.SQL.ADD('BNENO = '''+PUERY.FieldByName('BNENO').AsString+''', ');
    QINS.SQL.ADD('BNNAM = '''+PUERY.FieldByName('BNNAM').AsString+'''  ');
    QINS.SQL.ADD('WHERE BNENO = '''+PUERY.FieldByName('BNENO').AsString+'''');
    TRY QINS.EXECSQL; EXCEPT MEMO1.Lines.Add('更新人员设置 '+PUERY.FieldByName('BNENO').AsString+PUERY.FieldByName('BNNAM').AsString+'更新失败');  END;
    END;
 IF QUERY1.EOF = TRUE THEN  //INSERT
    BEGIN
    MEMO1.Lines.Add('新增人员设置 '+PUERY.FieldByName('BNENO').AsString+PUERY.FieldByName('BNNAM').AsString);
    QINS.Close;   // LOCAL INSERT
    QINS.SQL.CLEAR;
    QINS.SQL.ADD('INSERT INTO BMAN ');
    QINS.SQL.ADD(' ( BNENO, BNNAM ) ');
    QINS.SQL.ADD('VALUES (');
    QINS.SQL.ADD(' '''+PUERY.FieldByName('BNENO').AsString+''', ');
    QINS.SQL.ADD(' '''+PUERY.FieldByName('BNNAM').AsString+''') ');
    TRY QINS.EXECSQL; EXCEPT MEMO1.Lines.Add('更新人员设置 '+PUERY.FieldByName('BNENO').AsString+PUERY.FieldByName('BNNAM').AsString+'更新失败');  END;
    END;

 PUERY.Next;
 Gauge.AddProgress(1);
 END;

Gauge.Progress := 0;
END;

PROCEDURE TFMMAINT.INS_BGDS;
BEGIN
MEMO1.Lines.Add('检查新产品');
PUERY.SQL.CLEAR;      //SERVER===============================
PUERY.SQL.ADD('SELECT * FROM BGDS, BGDSB');
PUERY.SQL.ADD('WHERE BGDS.BGENO IS NOT NULL');
PUERY.SQL.ADD('  AND BGDS.BGENO = BGDSB.BGENO');
PUERY.SQL.ADD(SQLSERVERFINDFORM_WHEREKEY_DATE('BGDSB.BGDAT',BGDS_DAT1.Text,BGDS_DAT2.Text));
PUERY.Close;
PUERY.OPEN;
Gauge.MaxValue := PUERY.RecordCount;

PUERY.FIRST;
WHILE NOT PUERY.EOF DO
 BEGIN
 QUERY1.SQL.CLEAR;      //LOCAL------------------------
 QUERY1.SQL.ADD('SELECT * FROM BGDS');
 QUERY1.SQL.ADD('WHERE BGENO = '''+PUERY.FieldByName('BGENO').AsString+'''');

 QUERY1.Close;
 QUERY1.OPEN;
 IF QUERY1.EOF = FALSE THEN // UPDATE
    BEGIN
    MEMO1.Lines.Add('更新产品 '+PUERY.FieldByName('BGENO').AsString+PUERY.FieldByName('BGNAM').AsString);
    QINS.Close;   // LOCAL INSERT
    QINS.SQL.CLEAR;
    QINS.SQL.ADD('UPDATE BGDS ');
    QINS.SQL.ADD('SET ');
//    QINS.SQL.ADD('BGENO = '''+PUERY.FieldByName('BGENO').AsString+''', ');
    QINS.SQL.ADD('BGNAM = '''+PUERY.FieldByName('BGNAM').AsString+''', ');
    QINS.SQL.ADD('BGKIN = '''+PUERY.FieldByName('BGKIN').AsString+''', ');
    QINS.SQL.ADD('BGPST =   '+PUERY.FieldByName('BGPVP').AsString+'  , ');
    QINS.SQL.ADD('BGPVP =   '+PUERY.FieldByName('BGPST').AsString+'  , ');
    QINS.SQL.ADD('BGPMM =   '+PUERY.FieldByName('BGPMM').AsString+'  , ');
    QINS.SQL.ADD('BGQTS =   '+PUERY.FieldByName('BGQTS').AsString+'  , ');
    QINS.SQL.ADD('BGCOS =   '+PUERY.FieldByName('BGCOS').AsString+'  , ');
    QINS.SQL.ADD('BSENO = '''+PUERY.FieldByName('BSENO').AsString+''', ');
    QINS.SQL.ADD('BGID1 = '''+PUERY.FieldByName('BGID1').AsString+'''  ');
    QINS.SQL.ADD('WHERE BGENO = '''+PUERY.FieldByName('BGENO').AsString+'''');
    TRY
     QINS.EXECSQL;
     MEMO1.Lines.Add('产品 '+PUERY.FieldByName('BGENO').AsString+PUERY.FieldByName('BGNAM').AsString+'已更新');
    EXCEPT
     MEMO1.Lines.Add('产品 '+PUERY.FieldByName('BGENO').AsString+PUERY.FieldByName('BGNAM').AsString+'更新失败');
    END;
    END;
 IF QUERY1.EOF = TRUE THEN  //INSERT
    BEGIN
    MEMO1.Lines.Add('下载产品 '+PUERY.FieldByName('BGENO').AsString+PUERY.FieldByName('BGNAM').AsString);
    QINS.Close;   // LOCAL INSERT
    QINS.SQL.CLEAR;
    QINS.SQL.ADD('INSERT INTO BGDS ');
    QINS.SQL.ADD(' ( BGENO, BGNAM, BGKIN, BGPST, BGPVP, BGPMM, BGQTS, BGCOS, BSENO, BGID1 ) ');
    QINS.SQL.ADD('VALUES (');
    QINS.SQL.ADD(' '''+PUERY.FieldByName('BGENO').AsString+''', ');
    QINS.SQL.ADD(' '''+PUERY.FieldByName('BGNAM').AsString+''', ');
    QINS.SQL.ADD(' '''+PUERY.FieldByName('BGKIN').AsString+''', ');
    QINS.SQL.ADD('   '+PUERY.FieldByName('BGPVP').AsString+'  , ');
    QINS.SQL.ADD('   '+PUERY.FieldByName('BGPST').AsString+'  , ');
    QINS.SQL.ADD('   '+PUERY.FieldByName('BGPMM').AsString+'  , ');
    QINS.SQL.ADD('   '+PUERY.FieldByName('BGQTS').AsString+'  , ');
    QINS.SQL.ADD('   '+PUERY.FieldByName('BGCOS').AsString+'  , ');
    QINS.SQL.ADD(' '''+PUERY.FieldByName('BSENO').AsString+''', ');
    QINS.SQL.ADD(' '''+PUERY.FieldByName('BGID1').AsString+''') ');
    TRY
     if TABLECHECK_RE1('BGDS','BGENO',PUERY.FieldByName('BGENO').AsString) <= 0 THEN
        QINS.EXECSQL;
     MEMO1.Lines.Add('产品 '+PUERY.FieldByName('BGENO').AsString+PUERY.FieldByName('BGNAM').AsString+'已下载');
    EXCEPT
     MEMO1.Lines.Add('产品 '+PUERY.FieldByName('BGENO').AsString+PUERY.FieldByName('BGNAM').AsString+'下载失败');
    END;
    QINS.Close;   // LOCAL INSERT
    QINS.SQL.CLEAR;
    QINS.SQL.ADD('INSERT INTO BGDSB ');
    QINS.SQL.ADD(' ( BGENO ) ');
    QINS.SQL.ADD('VALUES (');
    QINS.SQL.ADD(' '''+PUERY.FieldByName('BGENO').AsString+''') ');
    TRY
     if TABLECHECK_RE1('BGDSB','BGENO',PUERY.FieldByName('BGENO').AsString) <= 0 THEN
        QINS.EXECSQL;
     MEMO1.Lines.Add('产品B '+PUERY.FieldByName('BGENO').AsString+PUERY.FieldByName('BGNAM').AsString+'已下载');
    EXCEPT
     MEMO1.Lines.Add('产品B '+PUERY.FieldByName('BGENO').AsString+PUERY.FieldByName('BGNAM').AsString+'下载失败');
    END;

    //新增库存
    TRY
     RBRN_CHECK_EXIST(PUERY.FieldByName('BGENO').AsString,_SYS_RBPST);
     MEMO1.Lines.Add('产品库存 '+PUERY.FieldByName('BGENO').AsString+PUERY.FieldByName('BGNAM').AsString+'已下载');
    EXCEPT
     MEMO1.Lines.Add('产品库存 '+PUERY.FieldByName('BGENO').AsString+PUERY.FieldByName('BGNAM').AsString+'下载失败');
    END;
    END;

 PUERY.Next;
 Gauge.AddProgress(1);
 END;

Gauge.Progress := 0;
END;

PROCEDURE TFMMAINT.INS_BMEM;
VAR
T_BMENO,T_BMNAM,T_BMCNA,T_BMBTH,T_BMSEX,T_BMLVE,T_BMBYR,T_BMBTO,T_BMBPO,
T_BMBTM,T_BMBDT,T_BMBYD,T_BMPGR,T_BMWPN,T_BMTL1,T_BMTL2,T_BMFX1,T_BMFX2,
T_BMAD1,T_BMAD2,T_BMEML,T_BMWWW,T_BMJND,T_BMCRD,T_BMDAT,T_BMMRK,T_BMZP1,T_BMZP2 :STRING;
BEGIN
MEMO1.Lines.Add('检查新会员');
PUERY.SQL.CLEAR;      //SERVER===============================
PUERY.SQL.ADD('SELECT * FROM BMEM');
PUERY.SQL.ADD('WHERE BMENO IS NOT NULL');
PUERY.SQL.ADD(SQLSERVERFINDFORM_WHEREKEY_DATE('BMDAT',BMEM_DAT1.Text,BMEM_DAT2.Text));
PUERY.Close;
PUERY.OPEN;
Gauge.MaxValue := PUERY.RecordCount;

PUERY.FIRST;
WHILE NOT PUERY.EOF DO
 BEGIN
 T_BMENO := TRIM(PUERY.FieldByName('BMENO').AsString);
 T_BMNAM := TRIM(PUERY.FieldByName('BMNAM').AsString);
 T_BMCNA := TRIM(PUERY.FieldByName('BMCNA').AsString);
 T_BMBTH := DATETOSTR(PUERY.FieldByName('BMBTH').AsDATETIME);
 T_BMSEX := TRIM(PUERY.FieldByName('BMSEX').AsString);
 T_BMLVE := INTTOSTR(PUERY.FieldByName('BMLVE').AsINTEGER);
 T_BMBYR := INTTOSTR(PUERY.FieldByName('BMBYR').AsINTEGER);
 T_BMBTO := INTTOSTR(PUERY.FieldByName('BMBTO').AsINTEGER);
 T_BMBPO := INTTOSTR(PUERY.FieldByName('BMBPO').AsINTEGER);
 T_BMBTM := INTTOSTR(PUERY.FieldByName('BMBTM').AsINTEGER);
 T_BMBDT := DATETOSTR(PUERY.FieldByName('BMBDT').AsDATETIME);
 T_BMBYD := DATETOSTR(PUERY.FieldByName('BMBYD').AsDATETIME);
 T_BMPGR := TRIM(PUERY.FieldByName('BMPGR').AsString);
 T_BMWPN := TRIM(PUERY.FieldByName('BMWPN').AsString);
 T_BMTL1 := TRIM(PUERY.FieldByName('BMTL1').AsString);
 T_BMTL2 := TRIM(PUERY.FieldByName('BMTL2').AsString);
 T_BMFX1 := TRIM(PUERY.FieldByName('BMFX1').AsString);
 T_BMFX2 := TRIM(PUERY.FieldByName('BMFX2').AsString);
 T_BMAD1 := TRIM(PUERY.FieldByName('BMAD1').AsString);
 T_BMAD2 := TRIM(PUERY.FieldByName('BMAD2').AsString);
 T_BMEML := TRIM(PUERY.FieldByName('BMEML').AsString);
 T_BMWWW := TRIM(PUERY.FieldByName('BMWWW').AsString);
 T_BMJND := DATETOSTR(PUERY.FieldByName('BMJND').AsDATETIME);
 T_BMCRD := DATETOSTR(PUERY.FieldByName('BMCRD').AsDATETIME);
 T_BMDAT := DATETOSTR(PUERY.FieldByName('BMDAT').AsDATETIME);
 T_BMMRK := TRIM(PUERY.FieldByName('BMMRK').AsString);
 T_BMZP1 := TRIM(PUERY.FieldByName('BMZP1').AsString);
 T_BMZP2 := TRIM(PUERY.FieldByName('BMZP2').AsString);
  
 QUERY1.SQL.CLEAR;      //LOCAL------------------------
 QUERY1.SQL.ADD('SELECT * FROM BMEM');
 QUERY1.SQL.ADD('WHERE BMENO = '''+PUERY.FieldByName('BMENO').AsString+'''');
 QUERY1.Close;
 QUERY1.OPEN;
 IF QUERY1.EOF = FALSE THEN // UPDATE
    BEGIN
    MEMO1.Lines.Add('更新会员 '+PUERY.FieldByName('BMENO').AsString+PUERY.FieldByName('BMNAM').AsString);
    QINS.Close;   // LOCAL INSERT
    QINS.SQL.CLEAR;
    QINS.SQL.Add('UPDATE BMEM ');
    QINS.SQL.Add('SET ');
    QINS.SQL.Add('BMNAM = '''+T_BMNAM+''', ');
    QINS.SQL.Add('BMCNA = '''+T_BMCNA+''', ');
    QINS.SQL.Add('BMBTH =  #'+T_BMBTH+'# , ');
    QINS.SQL.Add('BMSEX = '''+T_BMSEX+''', ');
    QINS.SQL.Add('BMLVE =   '+T_BMLVE+'  , ');
    QINS.SQL.Add('BMBYR =   '+T_BMBYR+'  , ');
    QINS.SQL.Add('BMBTO =   '+T_BMBTO+'  , ');
    QINS.SQL.Add('BMBPO =   '+T_BMBPO+'  , ');
    QINS.SQL.Add('BMBTM =   '+T_BMBTM+'  , ');
    QINS.SQL.Add('BMBDT =  #'+T_BMBDT+'#,  ');
    QINS.SQL.Add('BMBYD =  #'+T_BMBYD+'#,  ');
    QINS.SQL.Add('BMPGR = '''+T_BMPGR+''', ');
    QINS.SQL.Add('BMWPN = '''+T_BMWPN+''', ');
    QINS.SQL.Add('BMTL1 = '''+T_BMTL1+''', ');
    QINS.SQL.Add('BMTL2 = '''+T_BMTL2+''', ');
    QINS.SQL.Add('BMFX1 = '''+T_BMFX1+''', ');
    QINS.SQL.Add('BMFX2 = '''+T_BMFX2+''', ');
    QINS.SQL.Add('BMAD1 = '''+T_BMAD1+''', ');
    QINS.SQL.Add('BMAD2 = '''+T_BMAD2+''', ');
    QINS.SQL.Add('BMZP1 = '''+T_BMZP1+''', ');
    QINS.SQL.Add('BMZP2 = '''+T_BMZP2+''', ');
    QINS.SQL.Add('BMEML = '''+T_BMEML+''', ');
    QINS.SQL.Add('BMWWW = '''+T_BMWWW+''', ');
    QINS.SQL.Add('BMJND =  #'+T_BMJND+'#,  ');
    QINS.SQL.Add('BMCRD =  #'+T_BMCRD+'#,  ');
    QINS.SQL.Add('BMDAT =  #'+T_BMDAT+'#,  ');
    QINS.SQL.Add('BMMRK = '''+T_BMMRK+'''  ');
    QINS.SQL.ADD('WHERE BMENO = '''+T_BMENO+'''');
    TRY
     QINS.EXECSQL;
     MEMO1.Lines.Add('会员 '+PUERY.FieldByName('BMENO').AsString+PUERY.FieldByName('BMNAM').AsString+'已更新');
    EXCEPT
     MEMO1.Lines.Add('会员 '+PUERY.FieldByName('BMENO').AsString+PUERY.FieldByName('BMNAM').AsString+'更新失败');
    END;
    END;
 IF QUERY1.EOF = TRUE THEN
    BEGIN
    MEMO1.Lines.Add('下载会员 '+PUERY.FieldByName('BMENO').AsString+PUERY.FieldByName('BMNAM').AsString);
    QINS.Close;   // LOCAL INSERT
    QINS.SQL.CLEAR;
    QINS.SQL.ADD('INSERT INTO BMEM ');
    QINS.SQL.ADD(' ( BMENO, BMNAM, BMCNA, BMBTH, BMSEX, BMLVE, BMBYR, BMBTO, BMBPO, BMBTM, BMBDT, BMBYD, BMPGR, BMWPN, BMTL1, BMTL2, BMFX1, BMFX2, BMAD1, BMAD2, BMEML, BMWWW, BMJND, BMCRD, BMDAT, BMMRK, BMZP1, BMZP2 ) ');
    QINS.SQL.ADD('VALUES (');
    QINS.SQL.ADD(' '''+T_BMENO+''', ');
    QINS.SQL.ADD(' '''+T_BMNAM+''', ');
    QINS.SQL.ADD(' '''+T_BMCNA+''', ');
    QINS.SQL.ADD('  #'+T_BMBTH+'# , ');
    QINS.SQL.ADD(' '''+T_BMSEX+''', ');
    QINS.SQL.ADD('   '+T_BMLVE+'  , ');
    QINS.SQL.ADD('   '+T_BMBYR+'  , ');
    QINS.SQL.ADD('   '+T_BMBTO+'  , ');
    QINS.SQL.ADD('   '+T_BMBPO+'  , ');
    QINS.SQL.ADD('   '+T_BMBTM+'  , ');
    QINS.SQL.ADD('  #'+T_BMBDT+'#, ');
    QINS.SQL.ADD('  #'+T_BMBYD+'#, ');
    QINS.SQL.ADD(' '''+T_BMPGR+''', ');
    QINS.SQL.ADD(' '''+T_BMWPN+''', ');
    QINS.SQL.ADD(' '''+T_BMTL1+''', ');
    QINS.SQL.ADD(' '''+T_BMTL2+''', ');
    QINS.SQL.ADD(' '''+T_BMFX1+''', ');
    QINS.SQL.ADD(' '''+T_BMFX2+''', ');
    QINS.SQL.ADD(' '''+T_BMAD1+''', ');
    QINS.SQL.ADD(' '''+T_BMAD2+''', ');
    QINS.SQL.ADD(' '''+T_BMEML+''', ');
    QINS.SQL.ADD(' '''+T_BMWWW+''', ');
    QINS.SQL.ADD('  #'+T_BMJND+'#, ');
    QINS.SQL.ADD('  #'+T_BMCRD+'#, ');
    QINS.SQL.ADD('  #'+T_BMDAT+'#, ');
    QINS.SQL.ADD(' '''+T_BMMRK+''', ');
    QINS.SQL.ADD(' '''+T_BMZP1+''', ');
    QINS.SQL.ADD(' '''+T_BMZP2+''') ');
    TRY
    //SHOWMESSAGE(QINS.SQL.TEXT);
    if TABLECHECK_RE1('BMEM','BMENO',T_BMENO) <= 0 THEN
       QINS.EXECSQL;
    MEMO1.Lines.Add('会员 '+PUERY.FieldByName('BMENO').AsString+PUERY.FieldByName('BMNAM').AsString+'已下载');
    EXCEPT
     MEMO1.Lines.Add('会员 '+PUERY.FieldByName('BMENO').AsString+PUERY.FieldByName('BMNAM').AsString+'下载失败');
    END;
    END;
  PUERY.Next;
  Gauge.AddProgress(1);
  END;

Gauge.Progress := 0;
END;

PROCEDURE TFMMAINT.INS_POSA;
VAR PAENO_S : STRING;
    PAENO,RBPST,BGCOT,BMENO,BNENO,PAIDE,PAIPN,PAIVO,PADAT,PATME,
    PACNO,PACDT,PACNA,PACKD,PACIV,PABCK,PABCN,PACPD,PAWEK :STRING;
    PBENO,RBCNT,BGENO,BGCNT,BGCOS,BGCOT2            :STRING;
    BGKIN : STRING;   //产品类别
    BMBPO : INTEGER;  //会员点数
BEGIN
MEMO1.Lines.Add('上传销售资料');
QUERY1.SQL.CLEAR;  //LOCAL===============================
QUERY1.SQL.ADD('SELECT * FROM POSA');
QUERY1.SQL.ADD('WHERE PABCN = 0 ');
QUERY1.SQL.ADD(SQLSERVERFINDFORM_WHEREKEY_DATE('PADAT',POSA_DAT1.Text,POSA_DAT2.Text));
QUERY1.Close;
QUERY1.OPEN;
Gauge.MaxValue := QUERY1.RecordCount;

QUERY1.FIRST;
WHILE NOT QUERY1.EOF DO
 BEGIN
 PUERY.SQL.CLEAR;      //SERVER------------------------
 PUERY.SQL.ADD('SELECT * FROM POSA');
 PUERY.SQL.ADD('WHERE PAENO = '''+QUERY1.FieldByName('PAENO').AsString+'''');
 PUERY.Close;
 PUERY.OPEN;
 PAENO := TRIM(        QUERY1.FieldByName('PAENO').AsString);
 RBPST := TRIM(        QUERY1.FieldByName('RBPST').AsString);
 BGCOT := INTTOSTR(    QUERY1.FieldByName('BGCOT').AsINTEGER);
 BMENO := TRIM(        QUERY1.FieldByName('BMENO').AsString);
 BNENO := TRIM(        QUERY1.FieldByName('BNENO').AsString);
 PAIDE := TRIM(        QUERY1.FieldByName('PAIDE').AsString);
 PAIPN := BOOLEANTOSTR(QUERY1.FieldByName('PAIPN').AsBOOLEAN);
 PAIVO := TRIM(        QUERY1.FieldByName('PAIVO').AsString);
 PADAT := DATETOSTR(   QUERY1.FieldByName('PADAT').AsDATETIME);
 PATME := TRIM(        QUERY1.FieldByName('PATME').AsString);
 PACNO := TRIM(        QUERY1.FieldByName('PACNO').AsString);
 PACDT := DATETOSTR(   QUERY1.FieldByName('PACDT').AsDATETIME);
 PACNA := TRIM(        QUERY1.FieldByName('PACNA').AsString);
 PACKD := TRIM(        QUERY1.FieldByName('PACKD').AsString);
 PACIV := TRIM(        QUERY1.FieldByName('PACIV').AsString);
 PABCK := BOOLEANTOSTR(QUERY1.FieldByName('PABCK').AsBOOLEAN);
 PABCN := BOOLEANTOSTR(QUERY1.FieldByName('PABCN').AsBOOLEAN);
 PACPD := BOOLEANTOSTR(QUERY1.FieldByName('PACPD').AsBOOLEAN);
 PAWEK := TRIM(        QUERY1.FieldByName('PAWEK').AsString);

 IF PUERY.EOF = FALSE THEN  //UPDATE    //上次已传, 只更新变动资料
    BEGIN
{    //更新 SERVER POS PAENO
    MEMO1.Lines.Add('上载销售资料 变动资料 -'+QUERY1.FieldByName('PAENO').AsString);
    PINS.SQL.CLEAR;
    PINS.SQL.ADD('UPDATE POSA');
    PINS.SQL.ADD('SET');
    PINS.SQL.ADD(' PABCK =  '+PABCK+' ,');
    PINS.SQL.ADD(' PABCN = 1           ');
    PINS.SQL.ADD(' WHERE PAENO = '''+QUERY1.FieldByName('PAENO').AsString+'''');
    try PINS.ExecSQL;  except SHOWMESSAGE('POSA 变动资料 无法更新!');   end;

    //更新 LOCAL POS PAENO
    QINS.SQL.CLEAR;
    QINS.SQL.ADD('UPDATE POSA');
    QINS.SQL.ADD('SET');
    QINS.SQL.ADD(' PABCN = 1           ');
    QINS.SQL.ADD(' WHERE PAENO = '''+QUERY1.FieldByName('PAENO').AsString+'''');
    try QINS.ExecSQL;  except SHOWMESSAGE('POSA PAENO 无法更新!');   end;
 }   END;

 IF PUERY.EOF = TRUE  THEN  //INSERT
    BEGIN
    MEMO1.Lines.Add('上载销售资料 '+QUERY1.FieldByName('PAENO').AsString);
    //抓取销售编号
    PAENO_S := DBTABLEFINDMAXCNT('MAINP','POSA','PAENO',6,1);

    //加入出货资料
    PINS.SQL.Clear;
    PINS.SQL.ADD('INSERT INTO POSA');
    PINS.SQL.ADD('( PAENO, BGCOT, BMENO, BNENO, ');
    PINS.SQL.ADD('  PAIDE, PAIPN, PAIVO, PADAT, PATME, RBPST, ');
    PINS.SQL.ADD('  PACNO, PACDT, PACNA, PACKD, PACIV, ');
    PINS.SQL.ADD('  PABCK, PABCN, PACPD, PAWEK )');
    PINS.SQL.ADD('VALUES ');
    PINS.SQL.ADD('('''+PAENO_S+''',');//销售编号
    PINS.SQL.ADD('   '+BGCOT  +'  ,');//产品总价
    PINS.SQL.ADD(' '''+BMENO  +''',');//会员编号
    PINS.SQL.ADD(' '''+BNENO  +''',');//员工编号
    PINS.SQL.ADD(' '''+PAIDE  +''',');//柜台号码
    PINS.SQL.ADD('   '+PAIPN  +'  ,');//是否打印发票
    PINS.SQL.ADD(' '''+PAIVO  +''',');//发票号码
    PINS.SQL.ADD('   '+P_DT+PADAT +P_DT+' ,');//销售日期
    PINS.SQL.ADD(' '''+PATME +''',');//销售时间
    PINS.SQL.ADD(' '''+RBPST  +''', '); //销售仓库
    PINS.SQL.ADD(' '''+PACNO  +''',');//信用卡号
    PINS.SQL.ADD('   '+P_DT+PACDT  +P_DT +',');//信用卡到期日
    PINS.SQL.ADD(' '''+PACNA  +''',');//信用卡人姓名
    PINS.SQL.ADD(' '''+PACKD  +''',');//信用卡类别
    PINS.SQL.ADD(' '''+PACIV  +''',');//统一编号
    PINS.SQL.ADD('   '+PABCK  +'  ,');//
    PINS.SQL.ADD('   0            ,');// PABCN
    PINS.SQL.ADD('   '+PACPD  +'  ,');//刷卡或付现
    PINS.SQL.ADD(' '''+PAWEK  +''' ');//星期几
    PINS.SQL.ADD(' )');
    TRY
    //SHOWMESSAGE(PINS.SQL.TEXT);
     PINS.EXECSQL; MEMO1.Lines.Add('销售资料 '+PUERY.FieldByName('PAENO').AsString+'已上载');
    EXCEPT         MEMO1.Lines.Add('销售资料 '+PUERY.FieldByName('PAENO').AsString+'上载失败');    END;

    //更新 LOCAL POS PAENO
    QINS.SQL.CLEAR;
    QINS.SQL.ADD('UPDATE POSA');
    QINS.SQL.ADD('SET');
    QINS.SQL.ADD(' PAENO = '+PAENO_S+',');
    QINS.SQL.ADD(' PABCN = 1           ');
    QINS.SQL.ADD(' WHERE PAENO = '''+QUERY1.FieldByName('PAENO').AsString+'''');
    try QINS.ExecSQL;
    except SHOWMESSAGE('POSA PAENO 无法更新!');   end;
    
    //更新会员消费
    IF TRIM(BMENO) <> '' THEN
       BEGIN
       BMBPO := STRTOINTDEF(UNSETREAD('SYSSET','SET_BMBPO'),1); //会员点数
       IF BMBPO <=0 THEN BMBPO := 1;
       PINS.SQL.Clear;
       PINS.SQL.ADD('UPDATE BMEM');
       PINS.SQL.ADD('SET');
       PINS.SQL.ADD(' BMBYR = BMBYR + '+BGCOT+',');
       PINS.SQL.ADD(' BMBTO = BMBTO + '+BGCOT+',');
       PINS.SQL.ADD(' BMBPO = BMBPO + '+BGCOT+'/'+INTTOSTR(BMBPO)+',');
       PINS.SQL.ADD(' BMBTM = BMBTM + 1 ,');
       PINS.SQL.ADD(' BMBDT = '+P_DT+ DATETOSTR(DATE) +P_DT);
       PINS.SQL.ADD(' WHERE BMENO = '''+BMENO+'''');
       try PINS.ExecSQL;
       except SHOWMESSAGE('BMEM 无法更新!');   end;
       END;

    //更新业务业绩
    IF TRIM(BNENO) <> '' THEN
       BEGIN
       PINS.SQL.Clear;
       PINS.SQL.ADD('UPDATE BSAL');
       PINS.SQL.ADD('SET');
       PINS.SQL.ADD(' BASYR = BASYR + '+BGCOT+',');
       PINS.SQL.ADD(' BASTO = BASTO + '+BGCOT+',');
       PINS.SQL.ADD(' BASDT = '+P_DT+ DATETOSTR(DATE) +P_DT);
       PINS.SQL.ADD(' WHERE BAENO = '''+BNENO+'''');
       try PINS.ExecSQL;
       except SHOWMESSAGE('BSAL 无法更新!');   end;
       END;




    //存入数据库
    MEMO1.Lines.Add('上传销售资料 - 销货项目 ----------');
    QUERY2.SQL.CLEAR;  //LOCAL===============================
    QUERY2.SQL.ADD('SELECT * FROM POSB');
    QUERY2.SQL.ADD('WHERE PAENO = '''+QUERY1.FieldByName('PAENO').AsString+'''');
    QUERY2.Close;
    QUERY2.OPEN;

    QUERY2.FIRST;
    WHILE NOT QUERY2.EOF DO
     BEGIN
     MEMO1.Lines.Add('上传销售资料 - '+QUERY2.FieldByName('BGENO').AsString);
     PUERY.SQL.CLEAR;      //SERVER------------------------
     PUERY.SQL.ADD('SELECT * FROM POSB');
     PUERY.SQL.ADD('WHERE PAENO = '''+QUERY1.FieldByName('PAENO').AsString+'''');
     PUERY.SQL.ADD('  AND PBENO = '''+QUERY2.FieldByName('PBENO').AsString+'''');
     PUERY.Close;
     PUERY.OPEN;

     PBENO := DBTABLEFINDMAXITM('MAINP','POSB','PAENO',PAENO_S,'PBENO',3,1);//销售ITEM
     BGENO := QUERY2.FieldByName('BGENO').AsString; //产品条形码
     BGCNT := QUERY2.FieldByName('BGCNT').AsString; //产品数量
     BGCOS := QUERY2.FieldByName('BGCOS').AsString; //产品单价
     BGCOT := QUERY2.FieldByName('BGCOT').AsString; //产品总价
     BGKIN := DB_QUERY_FIND_VALUE('BGDS','BGENO',BGENO,'BGKIN');

     //加入出货资料
     PINS.SQL.Clear;
     PINS.SQL.ADD('INSERT INTO POSB');
     PINS.SQL.ADD('( PAENO, BGENO, BGCNT, ');
     PINS.SQL.ADD('  BGCOS, BGCOT, RBCNT, ');
     PINS.SQL.ADD('  PBENO )');
     PINS.SQL.ADD('VALUES ');
     PINS.SQL.ADD('('''+PAENO_S+''',');//销售编号
     PINS.SQL.ADD(' '''+BGENO+''',');//产品条形码
     PINS.SQL.ADD('   '+BGCNT+'  ,');//产品数量
     PINS.SQL.ADD('   '+BGCOS+'  ,');//产品单价
     PINS.SQL.ADD('   '+BGCOT+'  ,');//产品总价
     PINS.SQL.ADD(' '''+RBCNT+''',');//仓库删前存量
     PINS.SQL.ADD(' '''+PBENO+''' ');//销售ITEM
     PINS.SQL.ADD(' )');
     try PINS.ExecSQL;
     except SHOWMESSAGE('POSB 无法新增!');   end;

     //更新 LOCAL POS PAENO
     QINS.SQL.CLEAR;
     QINS.SQL.ADD('UPDATE POSB');
     QINS.SQL.ADD('SET');
     QINS.SQL.ADD(' PAENO = '''+PAENO_S+''' ');
     QINS.SQL.ADD(' WHERE PAENO = '''+QUERY1.FieldByName('PAENO').AsString+'''');
     try QINS.ExecSQL;
     except SHOWMESSAGE('POSB PAENO 无法更新!');   end;
    

     //检查库存量
     RBCNT := '-999';
     PUERY.SQL.Clear;
     PUERY.SQL.Add('SELECT RBCNT FROM RBRN');
     PUERY.SQL.Add(' WHERE RBPST = '''+_SYS_RBPST+'''');
     PUERY.SQL.Add('   AND BGENO = '''+BGENO+'''');
     PUERY.Close;  PUERY.Open;
     IF QUERY1.Eof = FALSE THEN RBCNT := PUERY.FieldByName('RBCNT').AsSTRING;
     IF STRTOINTDEF(RBCNT,-999) < -998 THEN RBCNT := '-999';

     //更新库存资料 -分类999不更新库存
     IF BGKIN <> '999' THEN
        BEGIN
        FMMAIND.QUPD.SQL.Clear;
        FMMAIND.QUPD.SQL.ADD('UPDATE RBRN');
        FMMAIND.QUPD.SQL.ADD('SET');
        FMMAIND.QUPD.SQL.ADD(' RBCNT = RBCNT - '+BGCNT+' ,');
        FMMAIND.QUPD.SQL.ADD(' RBDTU = '+P_DT+ DATETOSTR(DATE)+P_DT+', ');
        FMMAIND.QUPD.SQL.ADD(' RBTMU = '''+TIME_GET_24H(TIME)+''' ');
        FMMAIND.QUPD.SQL.ADD(' WHERE BGENO = '''+BGENO+'''');
        FMMAIND.QUPD.SQL.ADD('   AND RBPST = '''+_SYS_RBPST+'''');
        try FMMAIND.QUPD.ExecSQL; except SHOWMESSAGE('RBRN 无法更新!');   end;
        END;

    QUERY2.NEXT;
    END;  // WHILE DO

  END;  // IF QUERY = TRUE

 QUERY1.Next;
 Gauge.AddProgress(1);
 END;   // WHILE DO






{  //分析资料======================================
  IF FMPOSA.AS_SAVE = TRUE THEN
     BEGIN
     T_BGCNT  := INTTOSTR(STRTOINTDEF(T_BGCNT ,0));
     T_BGCOS  := INTTOSTR(STRTOINTDEF(T_BGCOS ,0));
     AS_ASQC2 := INTTOSTR(STRTOINTDEF(AS_ASQC2,0));
     AS_BMBTH := INTTOSTR(STRTOINTDEF(AS_BMBTH,0));

     QINS.SQL.CLEAR;
     QINS.SQL.ADD('INSERT INTO ACUS');
     QINS.SQL.ADD('(PAENO,RBPST,BNENO,BGENO,BGCNT,BGCOS,');
     QINS.SQL.ADD(' ASQA1,ASQA2,ASQA3,ASQA4,ASQA5,');
     QINS.SQL.ADD(' ASQB1,ASQB2,ASQB3,ASQB4,ASQB5,');
     QINS.SQL.ADD(' ASQC1,ASQC2,BMNAM,BMBTH,BMSEX,PADAT )');
     QINS.SQL.ADD('VALUES (');
     QINS.SQL.ADD(''''+T_PAENO+''',');         //销售编号
     QINS.SQL.ADD(''''+T_RBPST+''',');         //出货仓库
     QINS.SQL.ADD(''''+_USER_ID+''',');        //员工编号
     QINS.SQL.ADD(''''+T_BGENO+''',');         //产品条形码
     QINS.SQL.ADD('  '+T_BGCNT+'  ,');         //产品数量
     QINS.SQL.ADD('  '+T_BGCOS+'  ,');         //产品单价
     QINS.SQL.ADD(''''+AS_ASQA1+''',');        //状况1
     QINS.SQL.ADD(''''+AS_ASQA2+''',');        //状况2
     QINS.SQL.ADD(''''+AS_ASQA3+''',');        //状况3
     QINS.SQL.ADD(''''+AS_ASQA4+''',');        //状况4
     QINS.SQL.ADD(''''+AS_ASQA5+''',');        //状况5
     IF AS_ASQB1 = TRUE  THEN QINS.SQL.ADD('1,') ELSE QINS.SQL.ADD('0,');  //是否1
     IF AS_ASQB2 = TRUE  THEN QINS.SQL.ADD('1,') ELSE QINS.SQL.ADD('0,');  //是否2
     IF AS_ASQB3 = TRUE  THEN QINS.SQL.ADD('1,') ELSE QINS.SQL.ADD('0,');  //是否3
     IF AS_ASQB4 = TRUE  THEN QINS.SQL.ADD('1,') ELSE QINS.SQL.ADD('0,');  //是否4
     IF AS_ASQB5 = TRUE  THEN QINS.SQL.ADD('1,') ELSE QINS.SQL.ADD('0,');  //是否5
     QINS.SQL.ADD(''''+AS_ASQC1+''',');        //星期几
     QINS.SQL.ADD('  '+AS_ASQC2+'  ,');        //同行人数
     QINS.SQL.ADD(''''+AS_BMNAM+''',');        //中文姓名
     QINS.SQL.ADD('  '+AS_BMBTH+'  ,');        //年　　龄
     QINS.SQL.ADD(''''+AS_BMSEX+''',');        //性　　别
     QINS.SQL.ADD(' '+_DT+DATETOSTR(FMMAIN.T_INSERT_DATE)+_DT+' )');        //销售日期
       showmessage(QINS.SQL.text);
     try QINS.ExecSQL;
     except SHOWMESSAGE('ACUS 无法新增!');   end;

     END;


 }


Gauge.Progress := 0;
END;

PROCEDURE TFMMAINT.INS_POSA_PABCK;
BEGIN
{
MEMO1.Lines.Add('上传销售资料');
QUERY1.SQL.CLEAR;  //LOCAL===============================
QUERY1.SQL.ADD('SELECT * FROM POSA');
QUERY1.SQL.ADD('WHERE PABCK = 1 ');
QUERY1.Close;
QUERY1.OPEN;
Gauge.MaxValue := QUERY1.RecordCount;

QUERY1.FIRST;
WHILE NOT QUERY1.EOF DO
 BEGIN
 PUERY.SQL.CLEAR;      //SERVER------------------------
 PUERY.SQL.ADD('SELECT * FROM POSA');
 PUERY.SQL.ADD('WHERE PAENO = '''+QUERY1.FieldByName('PAENO').AsString+'''');
 PUERY.SQL.ADD('  AND PABCK = 0 ');
 PUERY.Close;
 PUERY.OPEN;
 IF PUERY.EOF = FALSE THEN  //UPDATE    //上次已传, 只更新变动资料
    BEGIN
    //更新 SERVER POS PAENO
    MEMO1.Lines.Add('上载销售资料 变动资料 -'+QUERY1.FieldByName('PAENO').AsString);
    PINS.SQL.CLEAR;
    PINS.SQL.ADD('UPDATE POSA');
    PINS.SQL.ADD('SET');
    PINS.SQL.ADD(' PABCK =  '+PABCK+' ,');
    PINS.SQL.ADD(' PABCN = 1           ');
    PINS.SQL.ADD(' WHERE PAENO = '''+QUERY1.FieldByName('PAENO').AsString+'''');
    try PINS.ExecSQL;  except SHOWMESSAGE('POSA 变动资料 无法更新!');   end;

    //更新 LOCAL POS PAENO
    QINS.SQL.CLEAR;
    QINS.SQL.ADD('UPDATE POSA');
    QINS.SQL.ADD('SET');
    QINS.SQL.ADD(' PABCN = 1           ');
    QINS.SQL.ADD(' WHERE PAENO = '''+QUERY1.FieldByName('PAENO').AsString+'''');
    try QINS.ExecSQL;  except SHOWMESSAGE('POSA PAENO 无法更新!');   end;
    END;

 IF PUERY.EOF = TRUE  THEN  //INSERT
    BEGIN
    MEMO1.Lines.Add('上载销售资料 '+QUERY1.FieldByName('PAENO').AsString);
    //抓取销售编号
    PAENO_S := DBTABLEFINDMAXCNT('MAINP','POSA','PAENO',6,1);

    //加入出货资料
    PINS.SQL.Clear;
    PINS.SQL.ADD('INSERT INTO POSA');
    PINS.SQL.ADD('( PAENO, BGCOT, BMENO, BNENO, ');
    PINS.SQL.ADD('  PAIDE, PAIPN, PAIVO, PADAT, PATME, RBPST, ');
    PINS.SQL.ADD('  PACNO, PACDT, PACNA, PACKD, PACIV, ');
    PINS.SQL.ADD('  PABCK, PABCN, PACPD, PAWEK )');
    PINS.SQL.ADD('VALUES ');
    PINS.SQL.ADD('('''+PAENO_S+''',');//销售编号
    PINS.SQL.ADD('   '+BGCOT  +'  ,');//产品总价
    PINS.SQL.ADD(' '''+BMENO  +''',');//会员编号
    PINS.SQL.ADD(' '''+BNENO  +''',');//员工编号
    PINS.SQL.ADD(' '''+PAIDE  +''',');//柜台号码
    PINS.SQL.ADD('   '+PAIPN  +'  ,');//是否打印发票
    PINS.SQL.ADD(' '''+PAIVO  +''',');//发票号码
    PINS.SQL.ADD('   '+P_DT+PADAT +P_DT+' ,');//销售日期
    PINS.SQL.ADD(' '''+PATME +''',');//销售时间
    PINS.SQL.ADD(' '''+RBPST  +''', '); //销售仓库
    PINS.SQL.ADD(' '''+PACNO  +''',');//信用卡号
    PINS.SQL.ADD('   '+P_DT+PACDT  +P_DT +',');//信用卡到期日
    PINS.SQL.ADD(' '''+PACNA  +''',');//信用卡人姓名
    PINS.SQL.ADD(' '''+PACKD  +''',');//信用卡类别
    PINS.SQL.ADD(' '''+PACIV  +''',');//统一编号
    PINS.SQL.ADD('   '+PABCK  +'  ,');//
    PINS.SQL.ADD('   '+PABCN  +'  ,');//
    PINS.SQL.ADD('   '+PACPD  +'  ,');//刷卡或付现
    PINS.SQL.ADD(' '''+PAWEK  +''' ');//星期几
    PINS.SQL.ADD(' )');
    TRY
    //SHOWMESSAGE(PINS.SQL.TEXT);
     PINS.EXECSQL; MEMO1.Lines.Add('销售资料 '+PUERY.FieldByName('PAENO').AsString+'已上载');
    EXCEPT         MEMO1.Lines.Add('销售资料 '+PUERY.FieldByName('PAENO').AsString+'上载失败');    END;

    //更新 LOCAL POS PAENO
    QINS.SQL.CLEAR;
    QINS.SQL.ADD('UPDATE POSA');
    QINS.SQL.ADD('SET');
    QINS.SQL.ADD(' PAENO = '+PAENO_S+',');
    QINS.SQL.ADD(' PABCN = 1           ');
    QINS.SQL.ADD(' WHERE PAENO = '''+QUERY1.FieldByName('PAENO').AsString+'''');
    try QINS.ExecSQL;
    except SHOWMESSAGE('POSA PAENO 无法更新!');   end;
    
    //更新会员消费
    IF TRIM(BMENO) <> '' THEN
       BEGIN
       BMBPO := STRTOINTDEF(UNSETREAD('SYSSET','SET_BMBPO'),1); //会员点数
       IF BMBPO <=0 THEN BMBPO := 1;
       PINS.SQL.Clear;
       PINS.SQL.ADD('UPDATE BMEM');
       PINS.SQL.ADD('SET');
       PINS.SQL.ADD(' BMBYR = BMBYR + '+BGCOT+',');
       PINS.SQL.ADD(' BMBTO = BMBTO + '+BGCOT+',');
       PINS.SQL.ADD(' BMBPO = BMBPO + '+BGCOT+'/'+INTTOSTR(BMBPO)+',');
       PINS.SQL.ADD(' BMBTM = BMBTM + 1 ,');
       PINS.SQL.ADD(' BMBDT = '+P_DT+ DATETOSTR(DATE) +P_DT);
       PINS.SQL.ADD(' WHERE BMENO = '''+BMENO+'''');
       try PINS.ExecSQL;
       except SHOWMESSAGE('BMEM 无法更新!');   end;
       END;

    //更新业务业绩
    IF TRIM(BNENO) <> '' THEN
       BEGIN
       PINS.SQL.Clear;
       PINS.SQL.ADD('UPDATE BSAL');
       PINS.SQL.ADD('SET');
       PINS.SQL.ADD(' BASYR = BASYR + '+BGCOT+',');
       PINS.SQL.ADD(' BASTO = BASTO + '+BGCOT+',');
       PINS.SQL.ADD(' BASDT = '+P_DT+ DATETOSTR(DATE) +P_DT);
       PINS.SQL.ADD(' WHERE BAENO = '''+BNENO+'''');
       try PINS.ExecSQL;
       except SHOWMESSAGE('BSAL 无法更新!');   end;
       END;




    //存入数据库
    MEMO1.Lines.Add('上传销售资料 - 销货项目 ----------');
    QUERY2.SQL.CLEAR;  //LOCAL===============================
    QUERY2.SQL.ADD('SELECT * FROM POSB');
    QUERY2.SQL.ADD('WHERE PAENO = '''+QUERY1.FieldByName('PAENO').AsString+'''');
    QUERY2.Close;
    QUERY2.OPEN;

    QUERY2.FIRST;
    WHILE NOT QUERY2.EOF DO
     BEGIN
     MEMO1.Lines.Add('上传销售资料 - '+QUERY2.FieldByName('BGENO').AsString);
     PUERY.SQL.CLEAR;      //SERVER------------------------
     PUERY.SQL.ADD('SELECT * FROM POSB');
     PUERY.SQL.ADD('WHERE PAENO = '''+QUERY1.FieldByName('PAENO').AsString+'''');
     PUERY.SQL.ADD('  AND PBENO = '''+QUERY2.FieldByName('PBENO').AsString+'''');
     PUERY.Close;
     PUERY.OPEN;

     PBENO := DBTABLEFINDMAXITM('MAINP','POSB','PAENO',PAENO_S,'PBENO',3,1);//销售ITEM
     BGENO := QUERY2.FieldByName('BGENO').AsString; //产品条形码
     BGCNT := QUERY2.FieldByName('BGCNT').AsString; //产品数量
     BGCOS := QUERY2.FieldByName('BGCOS').AsString; //产品单价
     BGCOT := QUERY2.FieldByName('BGCOT').AsString; //产品总价
     BGKIN := DB_QUERY_FIND_VALUE('BGDS','BGENO',BGENO,'BGKIN');

     //加入出货资料
     PINS.SQL.Clear;
     PINS.SQL.ADD('INSERT INTO POSB');
     PINS.SQL.ADD('( PAENO, BGENO, BGCNT, ');
     PINS.SQL.ADD('  BGCOS, BGCOT, RBCNT, ');
     PINS.SQL.ADD('  PBENO )');
     PINS.SQL.ADD('VALUES ');
     PINS.SQL.ADD('('''+PAENO_S+''',');//销售编号
     PINS.SQL.ADD(' '''+BGENO+''',');//产品条形码
     PINS.SQL.ADD('   '+BGCNT+'  ,');//产品数量
     PINS.SQL.ADD('   '+BGCOS+'  ,');//产品单价
     PINS.SQL.ADD('   '+BGCOT+'  ,');//产品总价
     PINS.SQL.ADD(' '''+RBCNT+''',');//仓库删前存量
     PINS.SQL.ADD(' '''+PBENO+''' ');//销售ITEM
     PINS.SQL.ADD(' )');
     try PINS.ExecSQL;
     except SHOWMESSAGE('POSB 无法新增!');   end;

     //更新 LOCAL POS PAENO
     QINS.SQL.CLEAR;
     QINS.SQL.ADD('UPDATE POSB');
     QINS.SQL.ADD('SET');
     QINS.SQL.ADD(' PAENO = '''+PAENO_S+''' ');
     QINS.SQL.ADD(' WHERE PAENO = '''+QUERY1.FieldByName('PAENO').AsString+'''');
     try QINS.ExecSQL;
     except SHOWMESSAGE('POSB PAENO 无法更新!');   end;
    

     //检查库存量
     RBCNT := '-999';
     PUERY.SQL.Clear;
     PUERY.SQL.Add('SELECT RBCNT FROM RBRN');
     PUERY.SQL.Add(' WHERE RBPST = '''+_SYS_RBPST+'''');
     PUERY.SQL.Add('   AND BGENO = '''+BGENO+'''');
     PUERY.Close;  PUERY.Open;
     IF QUERY1.Eof = FALSE THEN RBCNT := PUERY.FieldByName('RBCNT').AsSTRING;
     IF STRTOINTDEF(RBCNT,-999) < -998 THEN RBCNT := '-999';

     //更新库存资料 -分类999不更新库存
     IF BGKIN <> '999' THEN
        BEGIN
        FMMAIND.QUPD.SQL.Clear;
        FMMAIND.QUPD.SQL.ADD('UPDATE RBRN');
        FMMAIND.QUPD.SQL.ADD('SET');
        FMMAIND.QUPD.SQL.ADD(' RBCNT = RBCNT - '+BGCNT+' ,');
        FMMAIND.QUPD.SQL.ADD(' RBDTU = '+P_DT+ DATETOSTR(DATE)+P_DT+', ');
        FMMAIND.QUPD.SQL.ADD(' RBTMU = '''+TIME_GET_24H(TIME)+''' ');
        FMMAIND.QUPD.SQL.ADD(' WHERE BGENO = '''+BGENO+'''');
        FMMAIND.QUPD.SQL.ADD('   AND RBPST = '''+_SYS_RBPST+'''');
        try FMMAIND.QUPD.ExecSQL; except SHOWMESSAGE('RBRN 无法更新!');   end;
        END;

    QUERY2.NEXT;
    END;  // WHILE DO

  END;  // IF QUERY = TRUE

 QUERY1.Next;
 Gauge.AddProgress(1);
 END;   // WHILE DO






{  //分析资料======================================
  IF FMPOSA.AS_SAVE = TRUE THEN
     BEGIN
     T_BGCNT  := INTTOSTR(STRTOINTDEF(T_BGCNT ,0));
     T_BGCOS  := INTTOSTR(STRTOINTDEF(T_BGCOS ,0));
     AS_ASQC2 := INTTOSTR(STRTOINTDEF(AS_ASQC2,0));
     AS_BMBTH := INTTOSTR(STRTOINTDEF(AS_BMBTH,0));

     QINS.SQL.CLEAR;
     QINS.SQL.ADD('INSERT INTO ACUS');
     QINS.SQL.ADD('(PAENO,RBPST,BNENO,BGENO,BGCNT,BGCOS,');
     QINS.SQL.ADD(' ASQA1,ASQA2,ASQA3,ASQA4,ASQA5,');
     QINS.SQL.ADD(' ASQB1,ASQB2,ASQB3,ASQB4,ASQB5,');
     QINS.SQL.ADD(' ASQC1,ASQC2,BMNAM,BMBTH,BMSEX,PADAT )');
     QINS.SQL.ADD('VALUES (');
     QINS.SQL.ADD(''''+T_PAENO+''',');         //销售编号
     QINS.SQL.ADD(''''+T_RBPST+''',');         //出货仓库
     QINS.SQL.ADD(''''+_USER_ID+''',');        //员工编号
     QINS.SQL.ADD(''''+T_BGENO+''',');         //产品条形码
     QINS.SQL.ADD('  '+T_BGCNT+'  ,');         //产品数量
     QINS.SQL.ADD('  '+T_BGCOS+'  ,');         //产品单价
     QINS.SQL.ADD(''''+AS_ASQA1+''',');        //状况1
     QINS.SQL.ADD(''''+AS_ASQA2+''',');        //状况2
     QINS.SQL.ADD(''''+AS_ASQA3+''',');        //状况3
     QINS.SQL.ADD(''''+AS_ASQA4+''',');        //状况4
     QINS.SQL.ADD(''''+AS_ASQA5+''',');        //状况5
     IF AS_ASQB1 = TRUE  THEN QINS.SQL.ADD('1,') ELSE QINS.SQL.ADD('0,');  //是否1
     IF AS_ASQB2 = TRUE  THEN QINS.SQL.ADD('1,') ELSE QINS.SQL.ADD('0,');  //是否2
     IF AS_ASQB3 = TRUE  THEN QINS.SQL.ADD('1,') ELSE QINS.SQL.ADD('0,');  //是否3
     IF AS_ASQB4 = TRUE  THEN QINS.SQL.ADD('1,') ELSE QINS.SQL.ADD('0,');  //是否4
     IF AS_ASQB5 = TRUE  THEN QINS.SQL.ADD('1,') ELSE QINS.SQL.ADD('0,');  //是否5
     QINS.SQL.ADD(''''+AS_ASQC1+''',');        //星期几
     QINS.SQL.ADD('  '+AS_ASQC2+'  ,');        //同行人数
     QINS.SQL.ADD(''''+AS_BMNAM+''',');        //中文姓名
     QINS.SQL.ADD('  '+AS_BMBTH+'  ,');        //年　　龄
     QINS.SQL.ADD(''''+AS_BMSEX+''',');        //性　　别
     QINS.SQL.ADD(' '+_DT+DATETOSTR(FMMAIN.T_INSERT_DATE)+_DT+' )');        //销售日期
       showmessage(QINS.SQL.text);
     try QINS.ExecSQL;
     except SHOWMESSAGE('ACUS 无法新增!');   end;

     END;


 }


Gauge.Progress := 0;
END;


procedure TFMMAINT.FormCreate(Sender: TObject);
VAR SETFILENAME : STRING;
begin
SETFILENAME := 'MAINT.INI';
IF FileExists(SETFILENAME) = FALSE  THEN FILE_CREATE(SETFILENAME);

CB_SYS .Checked := INI_LOAD_BOOL(SETFILENAME,'CB_SYS'  ,FALSE);
CB_BMAN.Checked := INI_LOAD_BOOL(SETFILENAME,'CB_BMAN' ,FALSE);
CB_BGDS.Checked := INI_LOAD_BOOL(SETFILENAME,'CB_BGDS' ,FALSE);
CB_BMEM.Checked := INI_LOAD_BOOL(SETFILENAME,'CB_BMEM' ,FALSE);
CB_POSA.Checked := INI_LOAD_BOOL(SETFILENAME,'CB_POSA' ,FALSE);



P_DT := ''''; // SQL SERVER DATE

BGDS_DAT1.Text := EDATE_TO_CDATE(DATETOSTR(DATE-3 ));
BGDS_DAT2.Text := EDATE_TO_CDATE(DATETOSTR(DATE   ));
BMEM_DAT1.Text := EDATE_TO_CDATE(DATETOSTR(DATE-3 ));
BMEM_DAT2.Text := EDATE_TO_CDATE(DATETOSTR(DATE   ));
POSA_DAT1.Text := EDATE_TO_CDATE(DATETOSTR(DATE-2 ));
POSA_DAT2.Text := EDATE_TO_CDATE(DATETOSTR(DATE   ));
//
end;

procedure TFMMAINT.FormActivate(Sender: TObject);
begin
MEMO1.Lines.CLEAR;
TRY
 DATABASEP.Connected := TRUE;
 MEMO1.Lines.Add('服务器已经连接');
EXCEPT
 MEMO1.Lines.Add('服务器无法连接');
END;

end;

procedure TFMMAINT.BTNNOClick(Sender: TObject);
begin
CLOSE;
end;

procedure TFMMAINT.FormClose(Sender: TObject; var Action: TCloseAction);
VAR SETFILENAME : STRING;
begin
SETFILENAME := 'MAINT.INI';
IF FileExists(SETFILENAME) = FALSE  THEN FILE_CREATE(SETFILENAME);

INI_SAVE_BOOL(SETFILENAME,'CB_SYS'  ,CB_SYS .Checked);
INI_SAVE_BOOL(SETFILENAME,'CB_BMAN' ,CB_BMAN.Checked);
INI_SAVE_BOOL(SETFILENAME,'CB_BGDS' ,CB_BGDS.Checked);
INI_SAVE_BOOL(SETFILENAME,'CB_BMEM' ,CB_BMEM.Checked);
INI_SAVE_BOOL(SETFILENAME,'CB_POSA' ,CB_POSA.Checked);

FMMAINT.Release;
end;

procedure TFMMAINT.BTNYESClick(Sender: TObject);
begin

IF DATABASEP.Connected = FALSE THEN
   BEGIN
   MEMO1.Lines.CLEAR;
   TRY
    DATABASEP.Connected := TRUE;
    MEMO1.Lines.Add('服务器已经连接');
   EXCEPT MEMO1.Lines.Add('服务器无法连接'); END;
   END;

IF CB_SYS.Checked = TRUE THEN
   BEGIN
   //上载作业记录文件
   INS_SYSLOG;
   MEMO1.Lines.Add('上载作业记录文件完成=========================');

   //检查系统设置
   INS_SYSLST;
   MEMO1.Lines.Add('检查系统设置完成=========================');
   END;

IF CB_BMAN.Checked = TRUE THEN
   BEGIN
   //检查人员设置
   INS_BMAN;
   INS_SYSPSW;
   INS_SYSPMS;
   MEMO1.Lines.Add('检查人员设置完成=========================');
   END;

IF CB_BGDS.Checked = TRUE THEN
   BEGIN
   //检查新产品
   INS_BGDS;
   MEMO1.Lines.Add('检查新产品完成=========================');
   END;

IF CB_BMEM.Checked = TRUE THEN
   BEGIN
   //检查新会员
   INS_BMEM;
   MEMO1.Lines.Add('检查新会员完成=========================');
   END;

IF CB_POSA.Checked = TRUE THEN
   BEGIN
   //检查销售资料
   INS_POSA;
   MEMO1.Lines.Add('上载销售资料完成=======================');
   END;

end;




end.
