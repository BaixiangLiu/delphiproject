unit SYSINI;

interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ToolWin, ComCtrls, ExtCtrls, StdCtrls, DBCtrls, DB, DBTables;

//公共变量声明初值
procedure VAR_DECLARE_INI;


// CALL SYSLST 
procedure UNLISTSHOW(LIST, CAPTION:STRING; ID_LENGTH:INTEGER);

// LOG FILE INSERT
procedure SYSLOG_INSERT(T_SGKIN,T_PAIDE,T_SGMRK:STRING);
FUNCTION  SYSLOG_COUNT (T_DATE, T_SGKIN,T_PAIDE,T_BNENO:STRING):TSTRINGS;

//密码检查权限
function PERMISSION_CHECK(_USER_ID, _FUNCTION_ID :STRING):BOOLEAN;



var
   _SUPER_USER    : boolean;
   _SUPER_USER_ID : STRING;

   //系统参考值
   _SYS_RBPST : STRING;      //预设仓库值
   _SYS_PAIDE : STRING;      //预设收银台值

   //系统默认值
   _USER_ID,   _USER_NAME : STRING;
   _USER_LOGINDATETIME  : TDATETIME;
   _USER_MSG : STRING;

   _USER_CORP_NAME,
   _USER_CORP_WWW , _USER_CORP_EMAIL : STRING;
   _USER_CORP_TEL , _USER_CORP_FAX  : STRING;
   _USER_CORP_ADD : STRING;

   _1_CORP_NO  ,
   _1_CORP_NAME, _1_CORP_ENAME,
   _1_CORP_WWW , _1_CORP_EMAIL,
   _1_CORP_TEL , _1_CORP_FAX  ,
   _1_CORP_ADDR, _1_CORP_EADDR : STRING;

   _2_CORP_NO  ,
   _2_CORP_NAME, _2_CORP_ENAME,
   _2_CORP_WWW , _2_CORP_EMAIL,
   _2_CORP_TEL , _2_CORP_FAX  ,
   _2_CORP_ADDR, _2_CORP_EADDR : STRING;

   //系统默认值
   _QRBGDS, _QRBMEM, _QRBMAD : STRING;  //标签路径文件名
   _CHG_BGENO, _CHG_BMENO, _CHG_BSENO, _CHG_BCENO, _CHG_BNENO : BOOLEAN; //可否改编号
   _ORI_BGENO, _ORI_BMENO, _ORI_BSENO, _ORI_BCENO, _ORI_BNENO : STRING;  //可否改编号
   //快速查询 - 显示详细资料
   SHOW_BGDSN_PANEL : BOOLEAN;
   SHOW_BMEMN_PANEL : BOOLEAN;
   SHOW_BCSTN_PANEL : BOOLEAN;

   _PATH_EXE, _PATH_INI : STRING;

   //按钮图形
   INS_TB,UPD_TB,DEL_TB,YES_TB,CAL_TB,SER_TB,PRN_TB,QUT_TB,SET_TB,PRE_TB: TBitmap;

   //GRID图形
   True_bmp, False_bmp, Blank_bmp : TBitmap;

   //UNLIST
   LIST_STR :STRING;


   //流动客分析资料
   ACUS_WANT_SHOW : BOOLEAN;
   ACUS_ASQA1,ACUS_ASQA2,ACUS_ASQA3,ACUS_ASQA4,ACUS_ASQA5 :STRING;
   ACUS_ASQB1,ACUS_ASQB2,ACUS_ASQB3,ACUS_ASQB4,ACUS_ASQB5 :STRING;

implementation

uses UN_UTL, DB_UTL, SYSLST;



//公共变量声明初值
procedure VAR_DECLARE_INI;
begin

//系统特殊值
_SUPER_USER    := FALSE;
_SUPER_USER_ID := EDATE_TO_CDATE(DATETOSTR(DATE))+'1234';

//系统参考值
_SYS_RBPST := '001';

//系统默认值
_USER_ID   := '';
_USER_NAME := '';
//_USER_LOGINDATETIME  : TDATETIME;

//按钮图形
INS_TB := TBitmap.Create;
UPD_TB := TBitmap.Create;
DEL_TB := TBitmap.Create;
YES_TB := TBitmap.Create;
CAL_TB := TBitmap.Create;
SER_TB := TBitmap.Create;
PRN_TB := TBitmap.Create;
QUT_TB := TBitmap.Create;
SET_TB := TBitmap.Create;
PRE_TB := TBitmap.Create;

IF FileExists('\DELPHI\PIC\INSERT.BMP' ) = TRUE THEN INS_TB.LoadFromFile('\DELPHI\PIC\INSERT.BMP' );
IF FileExists('\DELPHI\PIC\UPDATE.BMP' ) = TRUE THEN UPD_TB.LoadFromFile('\DELPHI\PIC\UPDATE.BMP' );
IF FileExists('\DELPHI\PIC\DELETE.BMP' ) = TRUE THEN DEL_TB.LoadFromFile('\DELPHI\PIC\DELETE.BMP' );
IF FileExists('\DELPHI\PIC\YES.BMP'    ) = TRUE THEN YES_TB.LoadFromFile('\DELPHI\PIC\YES.BMP'    );
IF FileExists('\DELPHI\PIC\CANCEL.BMP' ) = TRUE THEN CAL_TB.LoadFromFile('\DELPHI\PIC\CANCEL.BMP' );
IF FileExists('\DELPHI\PIC\FIND.BMP'   ) = TRUE THEN SER_TB.LoadFromFile('\DELPHI\PIC\FIND.BMP'   );
IF FileExists('\DELPHI\PIC\PRINT.BMP'  ) = TRUE THEN PRN_TB.LoadFromFile('\DELPHI\PIC\PRINT.BMP'  );
IF FileExists('\DELPHI\PIC\QUIT.BMP'   ) = TRUE THEN QUT_TB.LoadFromFile('\DELPHI\PIC\QUIT.BMP'   );
IF FileExists('\DELPHI\PIC\SET.BMP'    ) = TRUE THEN SET_TB.LoadFromFile('\DELPHI\PIC\SET.BMP'    );
IF FileExists('\DELPHI\PIC\PREVIEW.BMP') = TRUE THEN PRE_TB.LoadFromFile('\DELPHI\PIC\PREVIEW.BMP');

   //GRID图形
True_bmp  := TBitmap.Create;
False_bmp := TBitmap.Create;
Blank_bmp := TBitmap.Create;
IF FileExists('\DELPHI\pic\true.BMP' ) = TRUE  THEN True_bmp .LoadFromFile('\DELPHI\pic\true.BMP'  );
IF FileExists('\DELPHI\pic\false.BMP') = TRUE  THEN False_bmp.LoadFromFile('\DELPHI\pic\false.BMP'  );
IF FileExists('\DELPHI\pic\blank.BMP') = TRUE  THEN Blank_bmp.LoadFromFile('\DELPHI\pic\blank.BMP'  );


_PATH_EXE :=ExtractFilePath(Application.EXEName);
_PATH_INI :=ExtractFilePath(Application.EXEName)+ '\INI\';
end;


procedure UNLISTSHOW(LIST, CAPTION:STRING; ID_LENGTH:INTEGER);
begin

  IF Application.FindComponent('FMLST')=nil then
  BEGIN
    LIST_STR := LIST;
    Application.CreateForm(TFMLST,  FMLST);
    FMLST.LSTID2.MaxLength := ID_LENGTH;
    FMLST.CAPTION := CAPTION;
    FMLST.WINDOWSTATE:=wsNormal;
    FMLST.POSITION:=poScreenCenter;
    FMLST.FORMSTYLE:=FSMDICHILD;
  END ELSE
    SHOWMESSAGE('请先结束其它细项设置!');
end;



procedure SYSLOG_INSERT(T_SGKIN,T_PAIDE,T_SGMRK:STRING);
VAR QCHECK : TQUERY;
begin

  TRY
   QCHECK := TQUERY.Create(APPLICATION.Owner);
   QCHECK.DatabaseName := 'MAIN';
   QCHECK.SQL.Clear;
   QCHECK.SQL.Add('INSERT INTO SYSLOG');
   QCHECK.SQL.Add('( SGENO , SGKIN , RBPST , PAIDE ,');
   QCHECK.SQL.Add('  BNENO , SGDAT , SGTME , SGMRK  ');
   QCHECK.SQL.Add(') VALUES (');
   QCHECK.SQL.Add(''''+TABLEFINDMAXCNT('SYSLOG','SGENO',9,1)+''',');
   QCHECK.SQL.Add(''''+T_SGKIN+''',');
   QCHECK.SQL.Add(''''+_SYS_RBPST+''',');
   QCHECK.SQL.Add(''''+T_PAIDE+''',');
   QCHECK.SQL.Add(''''+_USER_ID+''',');
   QCHECK.SQL.Add(''''+DATETOSTR(DATE)+''',');
   QCHECK.SQL.Add(''''+TIME_GET_24H(TIME)+''',');
   QCHECK.SQL.Add(''''+T_SGMRK+''' ');
   QCHECK.SQL.Add(')');
//   SHOWMESSAGE(QCHECK.SQL.TEXT);
   QCHECK.EXECSQL;
  FINALLY
   QCHECK.Free;
  END;

end;


FUNCTION SYSLOG_COUNT (T_DATE, T_SGKIN,T_PAIDE,T_BNENO:STRING):TSTRINGS;
VAR QCHECK : TQUERY;
    ANS : TSTRINGS;
    T_SLG : INTEGER; //登入记录
    T_SPW : INTEGER; //改密码记录
    T_SPM : INTEGER; //改权限记录

    T_CBX : INTEGER; //开钱箱记录
    T_CBM : INTEGER; //改会员等级记录
    T_PBK : INTEGER; //发票作废记录
    T_PCN : INTEGER; //发票回复记录
    T_BAK : INTEGER; //备份资料记录
begin
  ANS := TSTRINGLIST.Create;
  T_SLG :=0; //登入记录
  T_SPW :=0; //改密码记录
  T_SPM :=0; //改权限记录

  T_CBX :=0; //开钱箱记录
  T_CBM :=0; //改会员等级记录
  T_PBK :=0; //发票作废记录
  T_PCN :=0; //发票回复记录
  T_BAK :=0; //备份资料记录

  TRY
   QCHECK := TQUERY.Create(APPLICATION.Owner);
   QCHECK.DatabaseName := 'MAIN';
   QCHECK.SQL.Clear;
   QCHECK.SQL.Add('SELECT * FROM SYSLOG');
   QCHECK.SQL.Add(' WHERE SGENO IS NOT NULL ');
   IF CHECK_EDATE(T_DATE,FALSE)=TRUE THEN QCHECK.SQL.Add('  AND SGDAT = '+_DT+ T_DATE+_DT+' ');
   IF TRIM(T_SGKIN)<>'' THEN QCHECK.SQL.Add('  AND SGKIN = '''+ T_SGKIN +''' ');
   IF TRIM(T_PAIDE)<>'' THEN QCHECK.SQL.Add('  AND PAIDE = '''+ T_PAIDE +''' ');
   IF TRIM(T_BNENO)<>'' THEN QCHECK.SQL.Add('  AND BNENO = '''+ T_BNENO +''' ');
//   SHOWMESSAGE(QCHECK.SQL.TEXT);
   QCHECK.CLOSE;
   QCHECK.OPEN;

   WITH QCHECK DO
     BEGIN
     FIRST;
     WHILE NOT Eof DO
       BEGIN
       IF (FieldByName('SGKIN').AsSTRING='SLG') THEN INC(T_SLG); //登入记录
       IF (FieldByName('SGKIN').AsSTRING='SPW') THEN INC(T_SPW); //改密码记录
       IF (FieldByName('SGKIN').AsSTRING='SPM') THEN INC(T_SPM); //改权限记录

       IF (FieldByName('SGKIN').AsSTRING='CBX') THEN INC(T_CBX); //开钱箱记录
       IF (FieldByName('SGKIN').AsSTRING='CBM') THEN INC(T_CBM); //改会员等级记录
       IF (FieldByName('SGKIN').AsSTRING='PBK') THEN INC(T_PBK); //发票作废记录
       IF (FieldByName('SGKIN').AsSTRING='PCN') THEN INC(T_PCN); //发票回复记录
       IF (FieldByName('SGKIN').AsSTRING='BAK') THEN INC(T_BAK); //备份资料记录

       Next;
       END;
     END;


      ANS.Clear;
      IF (T_SGKIN='')OR(T_SGKIN='SLG') THEN ANS.Add('登入记录      '+ INTTOSTR(T_SLG) );
      IF (T_SGKIN='')OR(T_SGKIN='SPW') THEN ANS.Add('改密码记录    '+ INTTOSTR(T_SPW) );
      IF (T_SGKIN='')OR(T_SGKIN='SPM') THEN ANS.Add('改权限记录    '+ INTTOSTR(T_SPM) );
      IF (T_SGKIN='')OR(T_SGKIN='CBX') THEN ANS.Add('开钱箱记录    '+ INTTOSTR(T_CBX) );
      IF (T_SGKIN='')OR(T_SGKIN='CBM') THEN ANS.Add('改会员等级记录'+ INTTOSTR(T_CBM) );
      IF (T_SGKIN='')OR(T_SGKIN='PBK') THEN ANS.Add('发票作废记录  '+ INTTOSTR(T_PBK) );
      IF (T_SGKIN='')OR(T_SGKIN='PCN') THEN ANS.Add('发票回复记录  '+ INTTOSTR(T_PCN) );
      IF (T_SGKIN='')OR(T_SGKIN='BAK') THEN ANS.Add('备份资料记录  '+ INTTOSTR(T_BAK) );

   
  FINALLY
   RESULT := ANS;
   QCHECK.Free;
  END;

end;



function PERMISSION_CHECK(_USER_ID, _FUNCTION_ID :STRING):BOOLEAN;
VAR QCHECK : TQUERY;
begin

  TRY
   QCHECK := TQUERY.Create(APPLICATION.Owner);
   QCHECK.DatabaseName := 'MAIN';

   try
     QCHECK.SQL.Clear;
     QCHECK.SQL.Add('SELECT * FROM SYSLST');
     QCHECK.SQL.Add('WHERE LSTID1 = ''SYSPMS''');
     QCHECK.SQL.Add('  AND LSTID2 =''' + _FUNCTION_ID +'''');
     QCHECK.Close;
     QCHECK.Open;

     if QCHECK.Eof = TRUE then RESULT := TRUE //没有列入权限
        ELSE BEGIN
        QCHECK.SQL.Clear;
        QCHECK.SQL.Add('SELECT PMSPMS FROM SYSPMS');
        QCHECK.SQL.Add('WHERE BNENO  =''' + _USER_ID     +'''');
        QCHECK.SQL.Add('  AND PMSFUN =''' + _FUNCTION_ID +'''');
        QCHECK.Close;
        QCHECK.Open;
        QCHECK.First;
        RESULT := QCHECK.Fields[0].AsBoolean;
        END;

     //特殊权限
     if _USER_ID = _SUPER_USER_ID then RESULT := TRUE;
     if _USER_ID = 'admin' then RESULT := TRUE;

     if RESULT = FALSE then showmessage('很抱歉, 目前您没有权限使用此功能!');
   except
     showmessage('权限表无法打开, 无法打开权限!');
     RESULT := false;
   end;

  FINALLY
   QCHECK.Free;
  END;

end;



end.
