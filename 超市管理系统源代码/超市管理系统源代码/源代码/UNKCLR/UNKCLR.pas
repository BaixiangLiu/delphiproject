unit UNKCLR;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, Buttons, Db, DBTables, JEdit, Gauges;

type
  TFMKCLR = class(TForm)
    PageControl1: TPageControl;
    PAGE_A: TTabSheet;
    PABE_B: TTabSheet;
    BTNQUT: TBitBtn;
    GroupBox2: TGroupBox;
    BitBtn2: TBitBtn;
    ED_IVTA: TJEdit;
    Label1: TLabel;
    GroupBox3: TGroupBox;
    Label2: TLabel;
    BitBtn3: TBitBtn;
    ED_IVTT: TJEdit;
    GroupBox4: TGroupBox;
    Label3: TLabel;
    BitBtn4: TBitBtn;
    ED_RQKI: TJEdit;
    GroupBox5: TGroupBox;
    Label4: TLabel;
    BitBtn5: TBitBtn;
    ED_RQKO: TJEdit;
    GroupBox6: TGroupBox;
    Label5: TLabel;
    BitBtn6: TBitBtn;
    ED_MTBA: TJEdit;
    GroupBox7: TGroupBox;
    Label6: TLabel;
    BitBtn7: TBitBtn;
    ED_POSA: TJEdit;
    GroupBox1: TGroupBox;
    Label7: TLabel;
    ED_BGPST: TJEdit;
    BTNBGPST: TBitBtn;
    GroupBox8: TGroupBox;
    Label8: TLabel;
    ED_BGPMM: TJEdit;
    BTNBGPMM: TBitBtn;
    GroupBox9: TGroupBox;
    Label9: TLabel;
    ED_BGPVP: TJEdit;
    BTNBGPVP: TBitBtn;
    TabSheet1: TTabSheet;
    GroupBox10: TGroupBox;
    Label10: TLabel;
    BTNSYSLOGSLG: TBitBtn;
    ED_SYSLOGSLG: TJEdit;
    GroupBox11: TGroupBox;
    Label11: TLabel;
    BTNSYSLOGSPW: TBitBtn;
    ED_SYSLOGSPW: TJEdit;
    GroupBox12: TGroupBox;
    Label12: TLabel;
    BTNSYSLOGSPM: TBitBtn;
    ED_SYSLOGSPM: TJEdit;
    GroupBox13: TGroupBox;
    Label13: TLabel;
    BTNSYSLOGCBX: TBitBtn;
    ED_SYSLOGCBX: TJEdit;
    GroupBox14: TGroupBox;
    Label14: TLabel;
    BTNSYSLOGBAK: TBitBtn;
    ED_SYSLOGBAK: TJEdit;
    GroupBox15: TGroupBox;
    Label15: TLabel;
    BTNSYSLOGALL: TBitBtn;
    ED_SYSLOGALL: TJEdit;
    BTNBMBYR: TBitBtn;
    BTNBMBTM: TBitBtn;
    BTNBMBPO: TBitBtn;
    GroupBox16: TGroupBox;
    BTNREBUILD: TButton;
    Gauge: TGauge;
    Label16: TLabel;
    procedure BTNBMBYRClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BTNQUTClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BTNBGPSTClick(Sender: TObject);
    procedure BTNBGPMMClick(Sender: TObject);
    procedure BTNBGPVPClick(Sender: TObject);
    procedure BTNBMBTMClick(Sender: TObject);
    procedure BTNBMBPOClick(Sender: TObject);
    procedure BTNSYSLOGSLGClick(Sender: TObject);
    procedure BTNREBUILDClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMKCLR: TFMKCLR;

implementation

USES SYSINI, UN_UTL, DB_UTL, MAINU, MAIND;

{$R *.DFM}

procedure TFMKCLR.FormActivate(Sender: TObject);
begin
PAGE_A.SHOW;
end;

procedure TFMKCLR.FormClose(Sender: TObject; var Action: TCloseAction);
begin
FMKCLR.Release;
end;

procedure TFMKCLR.BTNQUTClick(Sender: TObject);
begin
CLOSE;
end;

procedure TFMKCLR.BTNBMBYRClick(Sender: TObject);
begin

Case MessageDlg('是否确定要处理?',mtConfirmation,[mbYes,mbNo],0) of
 mrYES :
 BEGIN
 FMMAIND.QDEL.SQL.Clear;
 FMMAIND.QDEL.SQL.ADD('UPDATE BMEM');
 FMMAIND.QDEL.SQL.ADD('SET');
 FMMAIND.QDEL.SQL.ADD('BMBYR = 0 ,');
 FMMAIND.QDEL.SQL.ADD('BMBYD = '''+DATETOSTR(DATE)+'''');
 FMMAIND.QDEL.ExecSQL;

 SHOWMESSAGE('处理完成!');
 END;
END;

end;



procedure TFMKCLR.BTNBMBTMClick(Sender: TObject);
begin

Case MessageDlg('是否确定要处理?',mtConfirmation,[mbYes,mbNo],0) of
 mrYES :
 BEGIN
 FMMAIND.QDEL.SQL.Clear;
 FMMAIND.QDEL.SQL.ADD('UPDATE BMEM');
 FMMAIND.QDEL.SQL.ADD('SET');
 FMMAIND.QDEL.SQL.ADD('BMBTM = 0 ');
 FMMAIND.QDEL.ExecSQL;

 SHOWMESSAGE('处理完成!');
 END;
END;

end;

procedure TFMKCLR.BTNBMBPOClick(Sender: TObject);
begin

Case MessageDlg('是否确定要处理?',mtConfirmation,[mbYes,mbNo],0) of
 mrYES :
 BEGIN
 FMMAIND.QDEL.SQL.Clear;
 FMMAIND.QDEL.SQL.ADD('UPDATE BMEM');
 FMMAIND.QDEL.SQL.ADD('SET');
 FMMAIND.QDEL.SQL.ADD('BMBPO = 0 ');
 FMMAIND.QDEL.ExecSQL;

 SHOWMESSAGE('处理完成!');
 END;
END;

end;






















procedure TFMKCLR.BTNBGPSTClick(Sender: TObject);
begin
IF CHECK_INT(ED_BGPST.TEXT) = FALSE THEN
   BEGIN SHOWMESSAGE('请输入所要调整的金额数字!');  EXIT;  END;

Case MessageDlg('是否确定要处理?',mtConfirmation,[mbYes,mbNo],0) of
 mrYES :
 BEGIN
 FMMAIND.QDEL.SQL.Clear;
 FMMAIND.QDEL.SQL.ADD('UPDATE BGDS');
 FMMAIND.QDEL.SQL.ADD('SET');
 FMMAIND.QDEL.SQL.ADD('BGPST = BGPST + BGPST * '+ED_BGPST.TEXT+' / 100');
 FMMAIND.QDEL.ExecSQL;

 SHOWMESSAGE('处理完成!');
 END;
END;

end;


procedure TFMKCLR.BTNBGPMMClick(Sender: TObject);
begin
IF CHECK_INT(ED_BGPMM.TEXT) = FALSE THEN
   BEGIN SHOWMESSAGE('请输入所要调整的金额数字!');  EXIT;  END;

Case MessageDlg('是否确定要处理?',mtConfirmation,[mbYes,mbNo],0) of
 mrYES :
 BEGIN
 FMMAIND.QDEL.SQL.Clear;
 FMMAIND.QDEL.SQL.ADD('UPDATE BGDS');
 FMMAIND.QDEL.SQL.ADD('SET');
 FMMAIND.QDEL.SQL.ADD('BGPMM = BGPMM + BGPMM * '+ED_BGPMM.TEXT+' / 100');
 FMMAIND.QDEL.ExecSQL;

 SHOWMESSAGE('处理完成!');
 END;
END;

end;

procedure TFMKCLR.BTNBGPVPClick(Sender: TObject);
begin
IF CHECK_INT(ED_BGPVP.TEXT) = FALSE THEN
   BEGIN SHOWMESSAGE('请输入所要调整的金额数字!');  EXIT;  END;

Case MessageDlg('是否确定要处理?',mtConfirmation,[mbYes,mbNo],0) of
 mrYES :
 BEGIN
 FMMAIND.QDEL.SQL.Clear;
 FMMAIND.QDEL.SQL.ADD('UPDATE BGDS');
 FMMAIND.QDEL.SQL.ADD('SET');
 FMMAIND.QDEL.SQL.ADD('BGPVP = BGPVP + BGPVP * '+ED_BGPVP.TEXT+' / 100');
 FMMAIND.QDEL.ExecSQL;

 SHOWMESSAGE('处理完成!');
 END;
END;

end;




procedure TFMKCLR.BitBtn2Click(Sender: TObject);
begin
IF CDATE_TO_EDATE(ED_IVTA.TEXT) = '' THEN EXIT;

Case MessageDlg('是否确定要处理?',mtConfirmation,[mbYes,mbNo],0) of
 mrYES :
 BEGIN
 FMMAIND.QDEL.SQL.Clear;
 FMMAIND.QDEL.SQL.ADD('DELETE FROM IVTA');
 FMMAIND.QDEL.SQL.ADD('WHERE IADAT <= #'+CDATE_TO_EDATE(ED_IVTA.TEXT)+'#');
// SHOWMESSAGE(  FMMAIND.QDEL.SQL.TEXT);
 FMMAIND.QDEL.ExecSQL;

 SHOWMESSAGE('处理完成!');
 END;
END;


end;

procedure TFMKCLR.BitBtn3Click(Sender: TObject);
begin

IF CDATE_TO_EDATE(ED_IVTT.TEXT) = '' THEN EXIT;

Case MessageDlg('是否确定要处理?',mtConfirmation,[mbYes,mbNo],0) of
 mrYES :
 BEGIN
 FMMAIND.QDEL.SQL.Clear;
 FMMAIND.QDEL.SQL.ADD('DELETE FROM IVTT');
 FMMAIND.QDEL.SQL.ADD('WHERE ITDAT <= #'+CDATE_TO_EDATE(ED_IVTT.TEXT)+'#');
// SHOWMESSAGE(  FMMAIND.QDEL.SQL.TEXT);
 FMMAIND.QDEL.ExecSQL;

 SHOWMESSAGE('处理完成!');
 END;
END;

end;

procedure TFMKCLR.BitBtn4Click(Sender: TObject);
begin

IF CDATE_TO_EDATE(ED_RQKI.TEXT) = '' THEN EXIT;

Case MessageDlg('是否确定要处理?',mtConfirmation,[mbYes,mbNo],0) of
 mrYES :
 BEGIN
 FMMAIND.QDEL.SQL.Clear;
 FMMAIND.QDEL.SQL.ADD('DELETE FROM RQKI');
 FMMAIND.QDEL.SQL.ADD('WHERE RIDAT <= #'+CDATE_TO_EDATE(ED_RQKI.TEXT)+'#');
// SHOWMESSAGE(  FMMAIND.QDEL.SQL.TEXT);
 FMMAIND.QDEL.ExecSQL;

 SHOWMESSAGE('处理完成!');
 END;
END;

end;

procedure TFMKCLR.BitBtn5Click(Sender: TObject);
begin

IF CDATE_TO_EDATE(ED_RQKO.TEXT) = '' THEN EXIT;

Case MessageDlg('是否确定要处理?',mtConfirmation,[mbYes,mbNo],0) of
 mrYES :
 BEGIN
 FMMAIND.QDEL.SQL.Clear;
 FMMAIND.QDEL.SQL.ADD('DELETE FROM RQKO');
 FMMAIND.QDEL.SQL.ADD('WHERE RODAT <= #'+CDATE_TO_EDATE(ED_RQKO.TEXT)+'#');
// SHOWMESSAGE(  FMMAIND.QDEL.SQL.TEXT);
 FMMAIND.QDEL.ExecSQL;

 SHOWMESSAGE('处理完成!');
 END;
END;

end;

procedure TFMKCLR.BitBtn6Click(Sender: TObject);
begin

IF CDATE_TO_EDATE(ED_MTBA.TEXT) = '' THEN EXIT;

Case MessageDlg('是否确定要处理?',mtConfirmation,[mbYes,mbNo],0) of
 mrYES :
 BEGIN
 FMMAIND.QDEL.SQL.Clear;
 FMMAIND.QDEL.SQL.ADD('DELETE FROM MTBA');
 FMMAIND.QDEL.SQL.ADD('WHERE MADAT <= #'+CDATE_TO_EDATE(ED_MTBA.TEXT)+'#');
// SHOWMESSAGE(  FMMAIND.QDEL.SQL.TEXT);
 FMMAIND.QDEL.ExecSQL;

 SHOWMESSAGE('处理完成!');
 END;
END;

end;


procedure TFMKCLR.BitBtn7Click(Sender: TObject);
begin

IF CDATE_TO_EDATE(ED_POSA.TEXT) = '' THEN EXIT;

Case MessageDlg('是否确定要处理?',mtConfirmation,[mbYes,mbNo],0) of
 mrYES :
 BEGIN
 FMMAIND.QUERY.SQL.CLEAR;
 FMMAIND.QUERY.SQL.ADD('SELECT * FROM POSA');
 FMMAIND.QUERY.SQL.ADD('WHERE PADAT <= #'+CDATE_TO_EDATE(ED_POSA.TEXT)+'#');
 FMMAIND.QUERY.CLOSE;
 FMMAIND.QUERY.OPEN;

 FMMAIND.QUERY.FIRST;
 WHILE NOT FMMAIND.QUERY.EOF DO
   BEGIN
   FMMAIND.QDEL.SQL.Clear;
   FMMAIND.QDEL.SQL.ADD('DELETE FROM POSB');
   FMMAIND.QDEL.SQL.ADD('WHERE PAENO = '''+FMMAIND.QUERY.FieldByName('PAENO').AsString+'''');
   FMMAIND.QDEL.ExecSQL;
   FMMAIND.QUERY.NEXT;
   END;

 FMMAIND.QDEL.SQL.Clear;
 FMMAIND.QDEL.SQL.ADD('DELETE FROM POSA');
 FMMAIND.QDEL.SQL.ADD('WHERE PADAT <= #'+CDATE_TO_EDATE(ED_POSA.TEXT)+'#');
 FMMAIND.QDEL.ExecSQL;
// SHOWMESSAGE(  FMMAIND.QDEL.SQL.TEXT);
 SHOWMESSAGE('处理完成!');
 END;
END;

end;



procedure TFMKCLR.BTNSYSLOGSLGClick(Sender: TObject);
VAR T_DATE , T_KIND : STRING;
begin

IF SENDER = BTNSYSLOGSLG THEN T_DATE := ED_SYSLOGSLG.TEXT;
IF SENDER = BTNSYSLOGSPW THEN T_DATE := ED_SYSLOGSPW.TEXT;
IF SENDER = BTNSYSLOGSPM THEN T_DATE := ED_SYSLOGSPM.TEXT;
IF SENDER = BTNSYSLOGCBX THEN T_DATE := ED_SYSLOGCBX.TEXT;
IF SENDER = BTNSYSLOGBAK THEN T_DATE := ED_SYSLOGBAK.TEXT;
IF SENDER = BTNSYSLOGALL THEN T_DATE := ED_SYSLOGALL.TEXT;
IF CDATE_TO_EDATE(T_DATE) = '' THEN EXIT;

Case MessageDlg('是否确定要处理?',mtConfirmation,[mbYes,mbNo],0) of
 mrYES :
 BEGIN
 FMMAIND.QDEL.SQL.Clear;
 FMMAIND.QDEL.SQL.ADD('DELETE FROM SYSLOG');
 FMMAIND.QDEL.SQL.ADD('WHERE SGDAT <= #'+CDATE_TO_EDATE(T_DATE)+'#');

 IF SENDER = BTNSYSLOGSLG THEN FMMAIND.QDEL.SQL.ADD('  AND SGKIN = ''SLG''');
 IF SENDER = BTNSYSLOGSPW THEN FMMAIND.QDEL.SQL.ADD('  AND SGKIN = ''SPW''');
 IF SENDER = BTNSYSLOGSPM THEN FMMAIND.QDEL.SQL.ADD('  AND SGKIN = ''SPM''');
 IF SENDER = BTNSYSLOGCBX THEN FMMAIND.QDEL.SQL.ADD('  AND SGKIN = ''CBX''');
 IF SENDER = BTNSYSLOGBAK THEN FMMAIND.QDEL.SQL.ADD('  AND SGKIN = ''BAK''');

// SHOWMESSAGE(  FMMAIND.QDEL.SQL.TEXT);
 FMMAIND.QDEL.ExecSQL;
 SHOWMESSAGE('处理完成!');
 END;
END;

end;

procedure TFMKCLR.BTNREBUILDClick(Sender: TObject);
begin

WITH FMMAIND DO
 BEGIN
 FMMAIND.QUERY.SQL.Clear;
 FMMAIND.QUERY.SQL.ADD('SELECT * FROM BGDS ORDER BY BGENO');
 FMMAIND.QUERY.CLOSE;
 FMMAIND.QUERY.OPEN;

 Gauge.Progress := 0;
 Gauge.MaxValue := QUERY.RecordCount ;
 FMMAIND.QUERY.FIRST;
 WHILE NOT FMMAIND.QUERY.EOF DO
   BEGIN
   Gauge.AddProgress (1);

   IF TABLECHECK_RE1('BGDSB','BGENO',QUERY.FieldByName('BGENO').AsString) <= 0 THEN
      BEGIN
      QINS.SQL.CLEAR;
      QINS.SQL.Add('INSERT INTO BGDSB ');
      QINS.SQL.Add(' ( BGENO, BGSNA ) ');
      QINS.SQL.Add('VALUES ');
      QINS.SQL.Add(' ('''+QUERY.FieldByName('BGENO').AsString+''','''+QUERY.FieldByName('BGNAM').AsString+' '' ) ');
      QINS.ExecSQL;
      END;

   if TABLECHECK_RE2('RBRN','BGENO','RBPST',QUERY.FieldByName('BGENO').AsString,_SYS_RBPST) <= 0 THEN
      BEGIN
//      RBRN_CHECK_EXIST(QUERY.FieldByName('BGENO').AsString , _SYS_RBPST);
      END;
      
   FMMAIND.QUERY.Next;
   END;

   
 END;

end;

end.
