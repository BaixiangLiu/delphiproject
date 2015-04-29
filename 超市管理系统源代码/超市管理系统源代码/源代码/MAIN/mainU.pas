unit mainU;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Dialogs,
  StdCtrls, WinTypes, WinProcs, FORMS, DB, DBTables, Gauges;


//库存资料
FUNCTION BGDS_UPDATE_BGQTN(T_BGENO:STRING;T_BGCNT:INTEGER):BOOLEAN;


// 打印 销售 明细查询
PROCEDURE DISP_DETAIL_POSA_OPEN(T_SQL:STRING);            //打印明细查询
FUNCTION  DISP_DETAIL_POSA(T_KIND:STRING):TSTRINGS;  //打印明细计算


//试用版记录数限定
FUNCTION CHECK_DEMO_VERSION_RECCNT(T_TABLE:STRING):BOOLEAN;


//查询FORM -
//字符串查询
FUNCTION FINDFORM_WHEREKEY_STRING (F_NAME, T_STR1,T_STR2:STRING):STRING;
//数字查询
FUNCTION FINDFORM_WHEREKEY_INTEGER(F_NAME, T_INT1,T_INT2:STRING):STRING;
//日期查询
FUNCTION FINDFORM_WHEREKEY_DATE   (F_NAME, T_DATE1,T_DATE2:STRING):STRING;
//查询 排序    //ORDER BYE=======================================
FUNCTION FINDFORM_ORDERBY3(F_NAME1,F_NAME2,F_NAME3:STRING; I_1, I_2, I_3 :INTEGER):STRING;


// 检查个人信息
FUNCTION POS_CHECK_PERSONAL_MESSAGE(T_BNENO:STRING):STRING;
FUNCTION POS_DEL_PERSONAL_MESSAGE(T_BNENO:STRING):STRING;


//密码检查权限
FUNCTION PERMISSION_CHECK(T_USER, PMSFUN :STRING):BOOLEAN;
FUNCTION READ_BMAN_PMS(BNENO,PMSFUN :STRING):BOOLEAN;
FUNCTION WRITE_BMAN_PMS(BNENO,PMSFUN:STRING;VALUE :BOOLEAN ):BOOLEAN;


//修改编号限定
FUNCTION CHANGE_BGENO(S_BGENO,T_BGENO:STRING):BOOLEAN;
FUNCTION CHANGE_BMENO(S_BMENO,T_BMENO:STRING):BOOLEAN;
FUNCTION CHANGE_BSENO(S_BSENO,T_BSENO:STRING):BOOLEAN;
FUNCTION CHANGE_BCENO(S_BCENO,T_BCENO:STRING):BOOLEAN;
FUNCTION CHANGE_BNENO(S_BNENO,T_BNENO:STRING):BOOLEAN;

FUNCTION DOWNLOAD_TABLE(TABLE_NAME, FILE_NAME:STRING):INTEGER;
FUNCTION DOWNLOAD_TABLEADD(TABLE_NAME, FILE_NAME:STRING):INTEGER;
FUNCTION UPLOAD_TABLE(TABLE_NAME, PRIMARY_FIELD, FILE_NAME:STRING):INTEGER;
FUNCTION UPLOAD_TABLE2(TABLE_NAME, PRIMARY_FIELD1, PRIMARY_FIELD2, FILE_NAME:STRING):INTEGER;

FUNCTION DOWNLOAD_DATASET(Q:TQUERY; FILE_NAME, TCAPTION:STRING):INTEGER;
FUNCTION DOWNLOAD_DATASETADD(Q:TQUERY; FILE_NAME:STRING):INTEGER;

FUNCTION TABLE_TO_TABLE(Q:TQUERY; DATABASE_NAME, TABLE_NAME:STRING):INTEGER;
FUNCTION TABLE_TO_CLEAN(DATABASE_NAME, TABLE_NAME:STRING):BOOLEAN;

// 检查 档案的最大编号
FUNCTION CHECK_BASE_TABLE_NO(TABLE_NAME,FIELD_NAME:STRING):STRING;







FUNCTION HOTKEY_LIST(KEY_INDEX:INTEGER):STRING;





FUNCTION SYSLOG_INSERT(T_SGKIN,T_PAIDE,T_SGMRK:STRING):BOOLEAN;
FUNCTION SYSLOG_COUNT (T_DATE, T_SGKIN,T_PAIDE,T_BNENO:STRING):TSTRINGS;




implementation

USES UN_UTL, DB_UTL, SYSINI, MAIND;




FUNCTION BGDS_UPDATE_BGQTN(T_BGENO:STRING;T_BGCNT:INTEGER):BOOLEAN;
VAR QCHECK : TQUERY;
BEGIN
  TRY
   QCHECK := TQUERY.Create(APPLICATION.Owner);   QCHECK.DatabaseName := 'MAIN';
   QCHECK.SQL.Clear;
   QCHECK.SQL.Add('UPDATE BGDS SET ');
   QCHECK.SQL.Add('BGQTN = BGQTN + '+INTTOSTR(T_BGCNT)+',');
   QCHECK.SQL.Add('BGDTC = '+_DT + DATETOSTR(DATE)+_DT+' ');
   QCHECK.SQL.Add('WHERE BGENO = '''+T_BGENO+'''');
   QCHECK.ExecSQL;
   RESULT := TRUE;
  FINALLY
   QCHECK.Free;
  END;
END;




PROCEDURE DISP_DETAIL_POSA_OPEN(T_SQL:STRING);  //打印明细计算
BEGIN
  WITH FMMAIND.QUERY DO
    BEGIN
    CLOSE;
    SQL.CLEAR;
    SQL.ADD(T_SQL);
    OPEN;
    END;
END;

FUNCTION DISP_DETAIL_POSA(T_KIND:STRING):TSTRINGS;  //打印明细计算
VAR ANS , INV: TSTRINGS;
    T_BGCOT,  T_PACNA  : INTEGER;
    T_BGCOT1, T_PACNA1 : INTEGER;
    T_BGCOT2, T_PACNA2 : INTEGER;
    T_T1, T_T2, T_T3, T_T4, T_T5 : INTEGER;
    T_M1, T_M2, T_M3             : INTEGER;
    T_IV1, T_IV2 : STRING;
BEGIN
  ANS := TSTRINGLIST.Create;
  INV := TSTRINGLIST.Create;
  ANS.Clear;
  ANS.Add('选择错误, 无资料! ');
  INV.Clear;

  T_BGCOT := 0;
  T_BGCOT1:= 0;
  T_BGCOT2:= 0;
  T_PACNA := 0;
  T_PACNA1:= 0;
  T_PACNA2:= 0;
  T_T1 := 0; T_T2 := 0; T_T3 := 0; T_T4 := 0; T_T5 := 0;
  T_M1 := 0; T_M2 := 0; T_M3 := 0;
  T_IV1:=''; T_IV2:='';

  WITH FMMAIND.QUERY DO
    BEGIN
    FIRST;
    WHILE NOT Eof DO
      BEGIN
      //发票起始号码
      IF TRIM(FieldByName('PAIVO').AsSTRING) <> '' THEN
         BEGIN
         IF T_IV1 = '' THEN T_IV1 := FieldByName('PAIVO').AsSTRING;
                            T_IV2 := FieldByName('PAIVO').AsSTRING;
         END;

      //发票 金额 明细
      IF TRIM(FieldByName('PAIVO').AsSTRING) <> '' THEN
         BEGIN
         INV.Add( FieldByName('PAIVO').AsSTRING + '='+
                  REPLICATE(' ',6-LENGTH(FieldByName('BGCOT').AsSTRING))+
                                         FieldByName('BGCOT').AsSTRING + '+'+
                  REPLICATE(' ',6-LENGTH(FieldByName('PACNA').AsSTRING))+
                                         FieldByName('PACNA').AsSTRING );
         END;


      // 金额计算
      T_BGCOT := T_BGCOT + FieldByName('BGCOT').AsINTEGER;
      T_PACNA := T_PACNA + FLOATTOINT(STRTOFLOATDEF(FieldByName('PACNA').AsString,0));
      INC(T_M1);

      IF TRIM(FieldByName('BMENO').AsSTRING) = '' THEN
         BEGIN
         INC(T_M3);
         END ELSE BEGIN
         INC(T_M2);
         END;

      IF FieldByName('PABCK').AsBOOLEAN = TRUE  THEN INC(T_T5);
      IF FieldByName('PAIPN').AsBOOLEAN = TRUE  THEN
         BEGIN
         INC(T_T3);
         T_BGCOT1 := T_BGCOT1 + FieldByName('BGCOT').AsINTEGER+ FLOATTOINT(STRTOFLOATDEF(FieldByName('PACNA').AsString,0));
         END ELSE BEGIN
         INC(T_T4);
         T_BGCOT2 := T_BGCOT2 + FieldByName('BGCOT').AsINTEGER+ FLOATTOINT(STRTOFLOATDEF(FieldByName('PACNA').AsString,0));
         END;

      IF FieldByName('PACKD').AsSTRING = 'GFT' THEN
         BEGIN         //礼券
         INC(T_T2);
         T_PACNA1 := T_PACNA1 + FLOATTOINT(STRTOFLOATDEF(FieldByName('PACNA').AsString,0));
         END;
      IF (FieldByName('PACKD').AsSTRING = 'CRD') AND
         (STRTOINTDEF(FieldByName('PACNA').AsSTRING,-1)>0) THEN
         BEGIN        //刷卡
         INC(T_T1);
         T_PACNA2 := T_PACNA2 + FLOATTOINT(STRTOFLOATDEF(FieldByName('PACNA').AsString,0));
         END;

      Next;
      END;
    END;


  IF T_KIND = 'MONEY' THEN
     BEGIN
     ANS.Clear;
     ANS.Add('＋实收现金总和: '+REPLICATE(' ',7-LENGTH(INTTOSTR(T_BGCOT )))+ INTTOSTR(T_BGCOT ) + '元' );
     ANS.Add('＋刷卡礼券总和: '+REPLICATE(' ',7-LENGTH(INTTOSTR(T_PACNA )))+INTTOSTR(T_PACNA ) + '元' );
     ANS.Add('  ├信用卡    : '+REPLICATE(' ',7-LENGTH(INTTOSTR(T_PACNA2)))+INTTOSTR(T_PACNA2) + '元' );
     ANS.Add('  └礼  券    : '+REPLICATE(' ',7-LENGTH(INTTOSTR(T_PACNA1)))+INTTOSTR(T_PACNA1) + '元' );
     ANS.Add('─────────');
     ANS.Add('＝今日销售总和: '+REPLICATE(' ',7-LENGTH(INTTOSTR(T_BGCOT + T_PACNA)))+INTTOSTR(T_BGCOT + T_PACNA) + '元' );
     ANS.Add('  ├已开发票  : '+REPLICATE(' ',7-LENGTH(INTTOSTR(T_BGCOT1)         ))+INTTOSTR(T_BGCOT1)          + '元' );
     ANS.Add('  └未开发票  : '+REPLICATE(' ',7-LENGTH(INTTOSTR(T_BGCOT2)         ))+INTTOSTR(T_BGCOT2)          + '元' );
     END;
  IF T_KIND = 'COUNT' THEN
     BEGIN
     ANS.Clear;
     ANS.Add('刷卡人数:     '+INTTOSTR(T_T1 ) );
     ANS.Add('礼券张数:     '+INTTOSTR(T_T2 ) );
     ANS.Add('已开发票张数: '+INTTOSTR(T_T3 ) );
     ANS.Add('未开发票张数: '+INTTOSTR(T_T4 ) );
     ANS.Add('作废发票张数: '+INTTOSTR(T_T5 ) );
     ANS.Add('总计结帐次数: '+INTTOSTR(T_M1 ) );
     END;
  IF T_KIND = 'DATE' THEN
     BEGIN
     ANS.Clear;
     ANS.Add('');
     ANS.Add('------------------------');
     ANS.Add('＋实收现金总和: '+REPLICATE(' ',7-LENGTH(INTTOSTR(T_BGCOT )))+INTTOSTR(T_BGCOT ) + '元' );
     ANS.Add('＋刷卡礼券总和: '+REPLICATE(' ',7-LENGTH(INTTOSTR(T_PACNA )))+INTTOSTR(T_PACNA ) + '元' );
     ANS.Add('  ├信用卡    : '+REPLICATE(' ',7-LENGTH(INTTOSTR(T_PACNA2)))+INTTOSTR(T_PACNA2) + '元' );
     ANS.Add('  └礼  券    : '+REPLICATE(' ',7-LENGTH(INTTOSTR(T_PACNA1)))+INTTOSTR(T_PACNA1) + '元' );
     ANS.Add('────────────');
     ANS.Add('＝今日销售总和: '+REPLICATE(' ',7-LENGTH(INTTOSTR(T_BGCOT + T_PACNA)))+INTTOSTR(T_BGCOT + T_PACNA) + '元' );
     ANS.Add('  ├已开发票  : '+REPLICATE(' ',7-LENGTH(INTTOSTR(T_BGCOT1)         ))+INTTOSTR(T_BGCOT1) + '元' );
     ANS.Add('  └未开发票  : '+REPLICATE(' ',7-LENGTH(INTTOSTR(T_BGCOT2)         ))+INTTOSTR(T_BGCOT2) + '元' );
     ANS.Add('');
     ANS.Add('------------------------');
     ANS.Add('刷卡人数:     '+INTTOSTR(T_T1 ) );
     ANS.Add('礼券张数:     '+INTTOSTR(T_T2 ) );
     ANS.Add('已开发票张数: '+INTTOSTR(T_T3 ) );
     ANS.Add('未开发票张数: '+INTTOSTR(T_T4 ) );
     ANS.Add('作废发票张数: '+INTTOSTR(T_T5 ) );
     ANS.Add('');
     ANS.Add('总计结帐次数: '+INTTOSTR(T_M1 ) );
     ANS.Add('是会员人数:   '+INTTOSTR(T_M2 ) );
     ANS.Add('非会员人数:   '+INTTOSTR(T_M3 ) );
     END;
  IF T_KIND = 'INVOICE' THEN
     BEGIN
     ANS.Clear;
     ANS.Add('发票号码');
     ANS.Add('起始号码- '+T_IV1);
     ANS.Add('结束号码- '+T_IV2);
     END;
  IF T_KIND = 'INV' THEN
     BEGIN
     ANS.Clear;
     ANS := INV;
     END;

  RESULT := ANS;
END;

FUNCTION PERMISSION_CHECK(T_USER, PMSFUN :STRING):BOOLEAN;
VAR
  QDBCHECK : TQUERY;
BEGIN
  TRY
    QDBCHECK := TQUERY.Create(APPLICATION.Owner);
    QDBCHECK.DatabaseName := 'MAIN';
    QDBCHECK.SQL.Clear;
    QDBCHECK.SQL.Add('SELECT * FROM SYSPMS');
    QDBCHECK.SQL.Add('WHERE BNENO  = '''+T_USER +'''');
    QDBCHECK.SQL.Add('  AND PMSFUN = '''+PMSFUN+'''');
    TRY
      QDBCHECK.Close;
      QDBCHECK.Open;
    EXCEPT
      SHOWMESSAGE('权限表无法打开, 无法打开权限!');   RESULT := FALSE;
    END;

    IF QDBCHECK.Eof = FALSE THEN RESULT := QDBCHECK.FieldByName('PMSPMS').AsBOOLEAN;
    IF QDBCHECK.Eof = TRUE  THEN RESULT := FALSE;
 
    //特殊权限
    IF T_USER = _SUPER_USER_ID THEN RESULT := TRUE;
    IF T_USER = 'admin'        THEN RESULT := TRUE;
    IF RESULT = FALSE          THEN SHOWMESSAGE('很抱歉, 目前您没有权限使用此功能!');
  FINALLY
    QDBCHECK.Free;
  END;
END;

FUNCTION READ_BMAN_PMS(BNENO,PMSFUN :STRING):BOOLEAN;
VAR QDBCHECK : TQUERY;
BEGIN
  TRY
    QDBCHECK := TQUERY.Create(APPLICATION.Owner);
    QDBCHECK.DatabaseName := 'MAIN';
    QDBCHECK.SQL.Clear;
    QDBCHECK.SQL.Add('SELECT * FROM SYSPMS');
    QDBCHECK.SQL.Add('WHERE BNENO  = '''+BNENO +'''');
    QDBCHECK.SQL.Add('  AND PMSFUN = '''+PMSFUN+'''');
    QDBCHECK.Close;
    QDBCHECK.Open;
    IF QDBCHECK.Eof = FALSE THEN RESULT := QDBCHECK.FieldByName('PMSPMS').AsBOOLEAN;
    IF QDBCHECK.Eof = TRUE  THEN RESULT := FALSE;
  FINALLY
    QDBCHECK.Free;
  END;
END;

FUNCTION WRITE_BMAN_PMS(BNENO,PMSFUN:STRING;VALUE :BOOLEAN ):BOOLEAN;
VAR QDBCHECK : TQUERY;
BEGIN
  TRY
    QDBCHECK := TQUERY.Create(APPLICATION.Owner);
    QDBCHECK.DatabaseName := 'MAIN';
    QDBCHECK.SQL.Clear;
    QDBCHECK.SQL.Add('SELECT * FROM SYSPMS');
    QDBCHECK.SQL.Add('WHERE BNENO  = '''+BNENO +'''');
    QDBCHECK.SQL.Add('  AND PMSFUN = '''+PMSFUN+'''');
    QDBCHECK.Close;
    QDBCHECK.Open;
    TRY
      IF QDBCHECK.Eof = FALSE THEN
         BEGIN //FOUND
         QDBCHECK.SQL.Clear;
         QDBCHECK.SQL.Add('UPDATE SYSPMS SET ');
         QDBCHECK.SQL.Add('PMSPMS = '+BOOLEANTOSTR(VALUE)+'');
         QDBCHECK.SQL.Add('WHERE BNENO  = '''+BNENO +'''');
         QDBCHECK.SQL.Add('  AND PMSFUN = '''+PMSFUN+'''');
         QDBCHECK.ExecSQL;
         END ELSE BEGIN // NOT FOUND
         QDBCHECK.SQL.Clear;
         QDBCHECK.SQL.Add('INSERT INTO SYSPMS');
         QDBCHECK.SQL.Add('( BNENO, PMSFUN, PMSPMS )');
         QDBCHECK.SQL.Add('VALUES ');
         QDBCHECK.SQL.Add('('''+BNENO   +''',');
         QDBCHECK.SQL.Add(' '''+PMSFUN  +''',');
         QDBCHECK.SQL.Add(' '''+BOOLEANTOSTR(VALUE)   +''')');
         QDBCHECK.ExecSQL;
         END;
      RESULT := TRUE;
    EXCEPT
      RESULT := FALSE;
    END;
  FINALLY
    QDBCHECK.Free;
  END;
END;




















//试用版记录数限定
FUNCTION CHECK_DEMO_VERSION_RECCNT(T_TABLE:STRING):BOOLEAN;
VAR QCHECK : TQUERY;
BEGIN

IF UNSETREAD('SYSSET','S_VER0') = '1' THEN
   BEGIN
   TRY
    QCHECK := TQUERY.Create(APPLICATION.Owner);
    QCHECK.DatabaseName := 'MAIN';
    QCHECK.SQL.Clear;
    QCHECK.SQL.Add('SELECT COUNT(*) FROM '+T_TABLE);
    QCHECK.Close;
    QCHECK.Open;
    IF QCHECK.Fields.Fields[0].AsInteger >= 12 THEN
       BEGIN
       SHOWMESSAGE('您所使用的为试用版，请和本公司联系，谢谢!');
       RESULT := FALSE;
       END ELSE RESULT := TRUE;
   FINALLY
    QCHECK.Free;
   END;
   END ELSE BEGIN
   RESULT := TRUE;
   END;
END;


//字符串查询
FUNCTION FINDFORM_WHEREKEY_STRING(F_NAME, T_STR1,T_STR2:STRING):STRING;
BEGIN
  RESULT := '';
  IF F_NAME <> '' THEN
     BEGIN
     IF (TRIM(T_STR1)<>'')AND(TRIM(T_STR2)<>'') THEN
        BEGIN
        RESULT := 'AND '+F_NAME+'>='''+TRIM(T_STR1)+'''AND '+F_NAME+'<='''+TRIM(T_STR2)+'''';
        END ELSE BEGIN
        IF TRIM(T_STR1)<>'' THEN RESULT := 'AND '+F_NAME+' LIKE '''+'%'+T_STR1+'%'+'''';
        IF TRIM(T_STR2)<>'' THEN RESULT := 'AND '+F_NAME+' LIKE '''+'%'+T_STR2+'%'+'''';
        END;
     END;
END;

//数字查询
FUNCTION FINDFORM_WHEREKEY_INTEGER(F_NAME, T_INT1,T_INT2:STRING):STRING;
BEGIN
  RESULT := '';
  IF F_NAME <> '' THEN
     BEGIN
     IF (TRIM(T_INT1)<>'')AND(TRIM(T_INT2)<>'') THEN
        BEGIN
        RESULT := 'AND '+F_NAME+'>='+TRIM(T_INT1)+' AND '+F_NAME+'<='+TRIM(T_INT2)+'';
        END ELSE BEGIN
        IF TRIM(T_INT1)<>'' THEN RESULT := 'AND '+F_NAME+' = '+T_INT1+'';
        IF TRIM(T_INT2)<>'' THEN RESULT := 'AND '+F_NAME+' = '+T_INT2+'';
        END;
     END;
END;

//ACCESS " DATE " WHERE KEY  ======================
FUNCTION FINDFORM_WHEREKEY_DATE(F_NAME, T_DATE1,T_DATE2:STRING):STRING;
VAR T1, T2 : STRING;
BEGIN
  RESULT := '';

  // modified by ds
  //IF T_DATE1 <> '' THEN T1 := CDATE_TO_EDATE(T_DATE1);
  //IF T_DATE2 <> '' THEN T2 := CDATE_TO_EDATE(T_DATE2);
  // modified by ds

  IF T_DATE1 <> '' THEN T1 := T_DATE1;
  IF T_DATE2 <> '' THEN T2 := T_DATE2;

  IF (TRIM(T1)<>'')AND(TRIM(T2)<>'') THEN
     BEGIN
     RESULT := 'AND '+F_NAME+'>='+_DT+ T1 +_DT+' AND '+F_NAME+'<='+_DT+ T2 +_DT+'';
     END ELSE BEGIN
     IF TRIM(T1)<>'' THEN RESULT := 'AND '+F_NAME+' = '+_DT+ T1 +_DT+'';
     IF TRIM(T2)<>'' THEN RESULT := 'AND '+F_NAME+' = '+_DT+ T2 +_DT+'';
     END;
END;

//查询 排序    //ORDER BYE=======================================
FUNCTION FINDFORM_ORDERBY3(F_NAME1,F_NAME2,F_NAME3:STRING; I_1, I_2, I_3 :INTEGER):STRING;
VAR T_STR : ARRAY[1..3] OF STRING;
    T_RETURN : STRING;
BEGIN
  T_RETURN := '';
  T_STR [1] := F_NAME1;
  T_STR [2] := F_NAME2;
  T_STR [3] := F_NAME3;

  IF I_1 >= 0 THEN
     BEGIN
     T_RETURN := T_RETURN + 'ORDER BY '+T_STR[I_1+1] ;
     IF I_2 >= 0 THEN
        BEGIN
                         T_RETURN := T_RETURN + ', '+T_STR[I_2+1] ;
        IF I_3 >= 0 THEN T_RETURN := T_RETURN + ', '+T_STR[I_3+1] ;
        END;
     END;

  RESULT := T_RETURN;
END;

// 检查个人信息
FUNCTION POS_CHECK_PERSONAL_MESSAGE(T_BNENO:STRING):STRING;
VAR QCHECK : TQUERY;
BEGIN
  TRY
   RESULT := '';
   QCHECK := TQUERY.Create(APPLICATION.Owner);
   QCHECK.DatabaseName := 'MAIN';
   QCHECK.SQL.Clear;
   QCHECK.SQL.ADD('SELECT * FROM SYSLST ');
   QCHECK.SQL.ADD('WHERE LSTID1 = ''BNENOMSG''');
   QCHECK.SQL.ADD('  AND LSTNAM = ''EVERONE'' ');
   QCHECK.CLOSE;
   QCHECK.OPEN;
   IF QCHECK.Eof = FALSE THEN
      BEGIN
      RESULT := RESULT + '全部信息' + #13;
      QCHECK.FIRST;
      WHILE NOT QCHECK.EOF DO
        BEGIN
        RESULT := RESULT + QCHECK.FieldByName('LSTMRK').AsString + #13;
        QCHECK.NEXT;
        END;
      END;
   QCHECK.SQL.Clear;
   QCHECK.SQL.ADD('SELECT * FROM SYSLST ');
   QCHECK.SQL.ADD('WHERE LSTID1 = ''BNENOMSG''');
   QCHECK.SQL.ADD('  AND LSTNAM = '''+T_BNENO+'''');
   QCHECK.CLOSE;
   QCHECK.OPEN;
   IF QCHECK.Eof = FALSE THEN
      BEGIN
      RESULT := RESULT + '=====================' + #13;
      RESULT := RESULT + '个人信息' + #13;
      QCHECK.FIRST;
      WHILE NOT QCHECK.EOF DO
        BEGIN
        RESULT := RESULT + QCHECK.FieldByName('LSTMRK').AsString + #13;
        QCHECK.NEXT;
        END;
      END;
  FINALLY
   QCHECK.Free;
  END;
END;


// 检查个人信息
FUNCTION POS_DEL_PERSONAL_MESSAGE(T_BNENO:STRING):STRING;
VAR QCHECK : TQUERY;
BEGIN
  TRY
   QCHECK := TQUERY.Create(APPLICATION.Owner);
   QCHECK.DatabaseName := 'MAIN';
   QCHECK.SQL.Clear;
   QCHECK.SQL.ADD('DELETE FROM SYSLST ');
   QCHECK.SQL.ADD('WHERE LSTID1 = ''BNENOMSG''');
   QCHECK.SQL.ADD('  AND LSTNAM = '''+T_BNENO+'''');
   QCHECK.ExecSQL;
  FINALLY
   QCHECK.Free;
  END;
END;

//修改编号限定
FUNCTION CHANGE_BGENO(S_BGENO,T_BGENO:STRING):BOOLEAN;
BEGIN
  RESULT := FALSE;
  IF TRIM(S_BGENO) = '' THEN EXIT;
  IF TRIM(T_BGENO) = '' THEN EXIT;
  IF TABLECHECK_RE1('BGDS','BGENO',S_BGENO) > 0 THEN
     BEGIN
     IF (TABLECHECK_RE1('BGDS','BGENO',T_BGENO) >= 1)AND(S_BGENO<>T_BGENO) THEN
        BEGIN
        SHOWMESSAGE('编号重复!'); RESULT := FALSE; EXIT;
        END;
     DB_QUERY_UPDATE_VALUE_STRING('RPCHB','BGENO',S_BGENO,'BGENO',T_BGENO );
     DB_QUERY_UPDATE_VALUE_STRING('RCSG' ,'BGENO',S_BGENO,'BGENO',T_BGENO );
     DB_QUERY_UPDATE_VALUE_STRING('RCSGT','BGENO',S_BGENO,'BGENO',T_BGENO );
     DB_QUERY_UPDATE_VALUE_STRING('RBRN' ,'BGENO',S_BGENO,'BGENO',T_BGENO );
     DB_QUERY_UPDATE_VALUE_STRING('RCINB','BGENO',S_BGENO,'BGENO',T_BGENO );
     DB_QUERY_UPDATE_VALUE_STRING('RCONB','BGENO',S_BGENO,'BGENO',T_BGENO );
     DB_QUERY_UPDATE_VALUE_STRING('RQKI' ,'BGENO',S_BGENO,'BGENO',T_BGENO );
     DB_QUERY_UPDATE_VALUE_STRING('RQKO' ,'BGENO',S_BGENO,'BGENO',T_BGENO );
     DB_QUERY_UPDATE_VALUE_STRING('POSB' ,'BGENO',S_BGENO,'BGENO',T_BGENO );
     DB_QUERY_UPDATE_VALUE_STRING('POSM' ,'BGENO',S_BGENO,'BGENO',T_BGENO );
     DB_QUERY_UPDATE_VALUE_STRING('POSN' ,'BGEN1',S_BGENO,'BGEN1',T_BGENO );
     DB_QUERY_UPDATE_VALUE_STRING('POSN' ,'BGEN2',S_BGENO,'BGEN2',T_BGENO );
     DB_QUERY_UPDATE_VALUE_STRING('IVTA' ,'BGENO',S_BGENO,'BGENO',T_BGENO );
     DB_QUERY_UPDATE_VALUE_STRING('IVTT' ,'BGEN1',S_BGENO,'BGEN1',T_BGENO );
     DB_QUERY_UPDATE_VALUE_STRING('IVTT' ,'BGEN2',S_BGENO,'BGEN2',T_BGENO );
     DB_QUERY_UPDATE_VALUE_STRING('ACUS' ,'BGENO',S_BGENO,'BGENO',T_BGENO );
     RESULT := TRUE;
     END ELSE BEGIN
     END;
END;

FUNCTION CHANGE_BMENO(S_BMENO,T_BMENO:STRING):BOOLEAN;
BEGIN
  RESULT := FALSE;
  IF TRIM(S_BMENO) = '' THEN EXIT;
  IF TRIM(T_BMENO) = '' THEN EXIT;
  IF TABLECHECK_RE1('BMEM','BMENO',S_BMENO) > 0 THEN
     BEGIN
     DB_QUERY_UPDATE_VALUE_STRING('POSA' ,'BMENO',S_BMENO,'BMENO',T_BMENO );
     DB_QUERY_UPDATE_VALUE_STRING('CCAW' ,'BMENO',S_BMENO,'BMENO',T_BMENO );
     RESULT := TRUE;
     END ELSE BEGIN
     END;
END;

FUNCTION CHANGE_BSENO(S_BSENO,T_BSENO:STRING):BOOLEAN;
BEGIN
  RESULT := FALSE;
  IF TRIM(S_BSENO) = '' THEN EXIT;
  IF TRIM(T_BSENO) = '' THEN EXIT;
  IF TABLECHECK_RE1('BSUP','BSENO',S_BSENO) > 0 THEN
     BEGIN
     DB_QUERY_UPDATE_VALUE_STRING('BGDS' ,'BSENO',S_BSENO,'BSENO',T_BSENO );
     DB_QUERY_UPDATE_VALUE_STRING('RPCHA','BSENO',S_BSENO,'BSENO',T_BSENO );
     DB_QUERY_UPDATE_VALUE_STRING('RCSG' ,'RGICS',S_BSENO,'RGICS',T_BSENO );
     DB_QUERY_UPDATE_VALUE_STRING('RCIN' ,'BSENO',S_BSENO,'BSENO',T_BSENO );
     DB_QUERY_UPDATE_VALUE_STRING('RCII' ,'BSENO',S_BSENO,'BSENO',T_BSENO );
     DB_QUERY_UPDATE_VALUE_STRING('RQKI' ,'BSENO',S_BSENO,'BSENO',T_BSENO );
     RESULT := TRUE;
     END ELSE BEGIN
     END;
END;

FUNCTION CHANGE_BCENO(S_BCENO,T_BCENO:STRING):BOOLEAN;
BEGIN
  RESULT := FALSE;
  IF TRIM(S_BCENO) = '' THEN EXIT;
  IF TRIM(T_BCENO) = '' THEN EXIT;
  IF TABLECHECK_RE1('BCST','BCENO',S_BCENO) > 0 THEN
     BEGIN
     DB_QUERY_UPDATE_VALUE_STRING('RCON' ,'BCENO',S_BCENO,'BCENO',T_BCENO );
     DB_QUERY_UPDATE_VALUE_STRING('RCOI' ,'BCENO',S_BCENO,'BCENO',T_BCENO );
     DB_QUERY_UPDATE_VALUE_STRING('RQKO' ,'BCENO',S_BCENO,'BCENO',T_BCENO );
     RESULT := TRUE;
     END ELSE BEGIN
     END;
END;

FUNCTION CHANGE_BNENO(S_BNENO,T_BNENO:STRING):BOOLEAN;
BEGIN
  RESULT := FALSE;
  IF TRIM(S_BNENO) = '' THEN EXIT;
  IF TRIM(T_BNENO) = '' THEN EXIT;
  IF TABLECHECK_RE1('BMAN','BNENO',S_BNENO) > 0 THEN
     BEGIN
     DB_QUERY_UPDATE_VALUE_STRING('SYSPSW','BNENO',S_BNENO,'BNENO',T_BNENO );
     DB_QUERY_UPDATE_VALUE_STRING('SYSPMS','BNENO',S_BNENO,'BNENO',T_BNENO );
     DB_QUERY_UPDATE_VALUE_STRING('SYSLOG','BNENO',S_BNENO,'BNENO',T_BNENO );
     DB_QUERY_UPDATE_VALUE_STRING('BCST'  ,'BNENO',S_BNENO,'BNENO',T_BNENO );
     DB_QUERY_UPDATE_VALUE_STRING('BSAL'  ,'BAENO',S_BNENO,'BAENO',T_BNENO );
     DB_QUERY_UPDATE_VALUE_STRING('RPCHA' ,'BNENO',S_BNENO,'BNENO',T_BNENO );
     DB_QUERY_UPDATE_VALUE_STRING('RCSG'  ,'RGRBN',S_BNENO,'RGRBN',T_BNENO );
     DB_QUERY_UPDATE_VALUE_STRING('RCSGT' ,'BNENO',S_BNENO,'BNENO',T_BNENO );
     DB_QUERY_UPDATE_VALUE_STRING('RCIN'  ,'BNENO',S_BNENO,'BNENO',T_BNENO );
     DB_QUERY_UPDATE_VALUE_STRING('RCII'  ,'BNENO',S_BNENO,'BNENO',T_BNENO );
     DB_QUERY_UPDATE_VALUE_STRING('RCII'  ,'RAMAN',S_BNENO,'RAMAN',T_BNENO );
     DB_QUERY_UPDATE_VALUE_STRING('RCON'  ,'BNENO',S_BNENO,'BNENO',T_BNENO );
     DB_QUERY_UPDATE_VALUE_STRING('RCON'  ,'ROMAN',S_BNENO,'ROMAN',T_BNENO );
     DB_QUERY_UPDATE_VALUE_STRING('RCOI'  ,'BNENO',S_BNENO,'BNENO',T_BNENO );
     DB_QUERY_UPDATE_VALUE_STRING('RCOI'  ,'RBMAN',S_BNENO,'RBMAN',T_BNENO );
     DB_QUERY_UPDATE_VALUE_STRING('RQKI'  ,'BNENO',S_BNENO,'BNENO',T_BNENO );
     DB_QUERY_UPDATE_VALUE_STRING('RQKO'  ,'BNENO',S_BNENO,'BNENO',T_BNENO );
     DB_QUERY_UPDATE_VALUE_STRING('POSA'  ,'BNENO',S_BNENO,'BNENO',T_BNENO );
     DB_QUERY_UPDATE_VALUE_STRING('ACUS'  ,'BNENO',S_BNENO,'BNENO',T_BNENO );
     RESULT := TRUE;
     END ELSE BEGIN
     END;
END;

FUNCTION DOWNLOAD_TABLE(TABLE_NAME, FILE_NAME:STRING):INTEGER;
VAR I, J, CNT : INTEGER;
    FILENAME , STR: STRING;
    TF : TEXTFILE;
    QCHECK : TQUERY;
BEGIN
  CNT := 0;

  TRY
   QCHECK := TQUERY.Create(APPLICATION.Owner);
   QCHECK.DatabaseName := 'MAIN';
   QCHECK.SQL.Clear;
   QCHECK.SQL.ADD('SELECT * FROM '+TABLE_NAME);
   QCHECK.CLOSE;
   QCHECK.OPEN;

   IF FileExists(FILENAME) = FALSE THEN FILE_CREATE(FILE_NAME);
   IF TEST_OPEN_FILE(FILE_NAME) = TRUE THEN
      BEGIN
      AssignFile(TF,FILE_NAME);
      REWRITE(TF);

      QCHECK.FIRST;
      WHILE NOT QCHECK.EOF DO
        BEGIN
        FOR I := 0 TO QCHECK.FieldCount-1 DO
           BEGIN
           STR := QCHECK.Fields.Fields[I].AsString;
           IF QCHECK.Fields.Fields[I].DataType = ftString   THEN STR := STR+ REPLICATE(' ',QCHECK.Fields.Fields[I].DataSize-LENGTH(STR));
           IF QCHECK.Fields.Fields[I].DataType = ftFloat    THEN STR := STR+ REPLICATE(' ',8-LENGTH(STR));
           IF QCHECK.Fields.Fields[I].DataType = ftDateTime THEN STR := STR+ REPLICATE(' ',10-LENGTH(STR));
           WRITE(TF,STR);
           END;
        WRITELN(TF,'');
        QCHECK.NEXT;
        INC(CNT);
        END;

      CloseFile(TF);
      END;

  FINALLY
    QCHECK.Free;
  END;

  RESULT := CNT;
END;

FUNCTION DOWNLOAD_TABLEADD(TABLE_NAME, FILE_NAME:STRING):INTEGER;
VAR I, J, CNT : INTEGER;
    FILENAME , STR: STRING;
    TF : TEXTFILE;
    QCHECK : TQUERY;
BEGIN
  CNT := 0;

  TRY
   QCHECK := TQUERY.Create(APPLICATION.Owner);
   QCHECK.DatabaseName := 'MAIN';

   QCHECK.SQL.Clear;
   QCHECK.SQL.ADD('SELECT * FROM '+TABLE_NAME);
   QCHECK.CLOSE;
   QCHECK.OPEN;
  
   IF TEST_OPEN_FILE(FILE_NAME) = TRUE THEN
     BEGIN
     AssignFile(TF,FILE_NAME);
     APPEND(TF);
  
     QCHECK.FIRST;
     WHILE NOT QCHECK.EOF DO
       BEGIN
       FOR I := 0 TO QCHECK.FieldCount-1 DO
           BEGIN
           STR := QCHECK.Fields.Fields[I].AsString;
           IF QCHECK.Fields.Fields[I].DataType = ftString   THEN STR := STR+ REPLICATE(' ',QCHECK.Fields.Fields[I].DataSize-LENGTH(STR));
           IF QCHECK.Fields.Fields[I].DataType = ftFloat    THEN STR := STR+ REPLICATE(' ',8-LENGTH(STR));
           IF QCHECK.Fields.Fields[I].DataType = ftDateTime THEN STR := STR+ REPLICATE(' ',10-LENGTH(STR));
           WRITE(TF,STR);
           END;
       WRITELN(TF,'');
       QCHECK.NEXT;
       INC(CNT);
       END;

     CloseFile(TF);
     END;

  FINALLY
    QCHECK.Free;
  END;
  RESULT := CNT;
END;

FUNCTION UPLOAD_TABLE(TABLE_NAME, PRIMARY_FIELD, FILE_NAME:STRING):INTEGER;
VAR I, J, CNT : INTEGER;
      FILENAME,
      SQL_STR, STR, TMP,
      PRIMARY_VALUE: STRING;
      TF : TEXTFILE;
      QCHECK, QINS : TQUERY;
      GFORM  : TFORM;
      GGAUGE : TGAUGE;
BEGIN
  CNT := 0;

  TRY
   GFORM  := TFORM .Create(APPLICATION.Owner);
   GFORM.Position := POSCREENCENTER;
   GFORM.Caption := '进度';
   GFORM.HEIGHT  := 70;
   GFORM.WIDTH   := 200;
  
   GGAUGE := TGAUGE.Create(APPLICATION.Owner);
   GGAUGE.Parent    := GFORM;
   GGAUGE.ForeColor := CLRED;
   GGAUGE.Left      := 2;
   GGAUGE.TOP       := 10;
   GGAUGE.Width     := 185;
   GGAUGE.Height    := 30;
   GFORM.Show;
  
   QCHECK := TQUERY.Create(APPLICATION.Owner);
   QCHECK.DatabaseName := 'MAIN';
   QINS   := TQUERY.Create(APPLICATION.Owner);
   QINS  .DatabaseName := 'MAIN';
  
   QCHECK.SQL.Clear;
   QCHECK.SQL.ADD('SELECT * FROM '+TABLE_NAME);
   QCHECK.CLOSE;
   QCHECK.OPEN;

   IF FileExists(FILENAME) = FALSE THEN FILE_CREATE(FILE_NAME);
   IF TEST_OPEN_FILE(FILE_NAME) = TRUE THEN
     BEGIN
     AssignFile(TF,FILE_NAME);
     RESET(TF);
     GGAUGE.MaxValue := 0;
     GGAUGE.Progress := 0;
     WHILE NOT EOF(TF) DO
       BEGIN
       READLN(TF,STR);
       GGAUGE.MaxValue := GGAUGE.MaxValue + 1;
       END;
     CloseFile(TF);
  
     AssignFile(TF,FILE_NAME);
     RESET(TF);
  
     WHILE NOT EOF(TF) DO
       BEGIN
       GGAUGE.AddProgress(1);
       READLN(TF,STR);
       IF TRIM(STR) = '' THEN CONTINUE;
       PRIMARY_VALUE := TRIM(COPY(STR,1,QCHECK.Fields.Fields[0].DataSize));
       if TABLECHECK_RE1(TABLE_NAME,PRIMARY_FIELD,PRIMARY_VALUE) > 0 THEN CONTINUE;
  
       SQL_STR := '';
       SQL_STR := SQL_STR+'INSERT INTO '+TABLE_NAME +#13;
       SQL_STR := SQL_STR+'('                       +#13;
  
       FOR I := 0 TO QCHECK.FieldCount-1 DO
           BEGIN
           SQL_STR := SQL_STR+QCHECK.Fields.Fields[I].FieldName;
           IF I < QCHECK.FieldCount-1 THEN SQL_STR := SQL_STR + ','+#13;
           END;
       SQL_STR := SQL_STR+')VALUES('                +#13;
  
       J := 1;
       FOR I := 0 TO QCHECK.FieldCount-1 DO
           BEGIN
           IF QCHECK.Fields.Fields[I].DataType = ftString   THEN
              BEGIN
              SQL_STR := SQL_STR + ''''+TRIM(COPY(STR,J,QCHECK.Fields.Fields[I].DataSize))+'''';
              J := J + QCHECK.Fields.Fields[I].DataSize;
              END;
           IF QCHECK.Fields.Fields[I].DataType = ftFloat    THEN
              BEGIN
              TMP := TRIM(COPY(STR,J,8));
              IF CHECK_FLOATINT(TMP) = TRUE THEN SQL_STR := SQL_STR + TMP
                                            ELSE SQL_STR := SQL_STR + '0';
              J := J + 8;
              END;
           IF QCHECK.Fields.Fields[I].DataType = ftDateTime THEN
              BEGIN
              TMP := TRIM(COPY(STR,J,10));
              IF CHECK_EDATE(TMP,FALSE) = TRUE THEN SQL_STR := SQL_STR + _DT+TMP+_DT
                                               ELSE SQL_STR := SQL_STR + _DT+'1989/1/1'+_DT;
              J := J + 10;
              END;
           IF QCHECK.Fields.Fields[I].DataType = ftBoolean  THEN
              BEGIN
              TMP := TRIM(COPY(STR,J,QCHECK.Fields.Fields[I].DataSize));
              IF TMP = 'Tr' THEN SQL_STR := SQL_STR + '1';
              IF TMP = 'Fa' THEN SQL_STR := SQL_STR + '0';
              J := J + QCHECK.Fields.Fields[I].DataSize;
              END;

           IF I < QCHECK.FieldCount-1 THEN SQL_STR := SQL_STR + ','+#13;
           END;
       SQL_STR := SQL_STR+')'                       +#13;

       QINS.SQL.Text := SQL_STR;
       QINS.EXECSQL;
       INC(CNT);
       END;



     CloseFile(TF);
     END;

  FINALLY
  QCHECK.Free;
  QINS.FREE;

  GFORM.Free;
  END;

  RESULT := CNT;
END;

FUNCTION UPLOAD_TABLE2(TABLE_NAME, PRIMARY_FIELD1, PRIMARY_FIELD2, FILE_NAME:STRING):INTEGER;
VAR I, J, CNT : INTEGER;
    FILENAME,
    SQL_STR, STR, TMP,
    PRIMARY_VALUE1, PRIMARY_VALUE2: STRING;
    TF : TEXTFILE;
    QCHECK, QINS : TQUERY;
    GFORM  : TFORM;
    GGAUGE : TGAUGE;
BEGIN
  CNT := 0;

  TRY
   GFORM  := TFORM .Create(APPLICATION.Owner);
   GFORM.Position := POSCREENCENTER;
   GFORM.Caption := '进度';
   GFORM.HEIGHT  := 70;
   GFORM.WIDTH   := 200;
  
   GGAUGE := TGAUGE.Create(APPLICATION.Owner);
   GGAUGE.Parent    := GFORM;
   GGAUGE.ForeColor := CLRED;
   GGAUGE.Left      := 2;
   GGAUGE.TOP       := 10;
   GGAUGE.Width     := 185;
   GGAUGE.Height    := 30;
   GFORM.Show;

   QCHECK := TQUERY.Create(APPLICATION.Owner);
   QCHECK.DatabaseName := 'MAIN';
   QINS   := TQUERY.Create(APPLICATION.Owner);
   QINS  .DatabaseName := 'MAIN';
  
   QCHECK.SQL.Clear;
   QCHECK.SQL.ADD('SELECT * FROM '+TABLE_NAME);
   QCHECK.CLOSE;
   QCHECK.OPEN;


   IF FileExists(FILENAME) = FALSE THEN FILE_CREATE(FILE_NAME);
   IF TEST_OPEN_FILE(FILE_NAME) = TRUE THEN
     BEGIN
     AssignFile(TF,FILE_NAME);
     RESET(TF);
     GGAUGE.MaxValue := 0;
     GGAUGE.Progress := 0;
     WHILE NOT EOF(TF) DO
       BEGIN
       READLN(TF,STR);
       GGAUGE.MaxValue := GGAUGE.MaxValue + 1;
       END;
     CloseFile(TF);
  
     AssignFile(TF,FILE_NAME);
     RESET(TF);
  
     WHILE NOT EOF(TF) DO
       BEGIN
       GGAUGE.AddProgress(1);
       READLN(TF,STR);
       PRIMARY_VALUE1 := TRIM(COPY(STR,1,QCHECK.Fields.Fields[0].DataSize));
       PRIMARY_VALUE2 := TRIM(COPY(STR,QCHECK.Fields.Fields[0].DataSize+1,QCHECK.Fields.Fields[1].DataSize));
       if TABLECHECK_RE2(TABLE_NAME,PRIMARY_FIELD1,PRIMARY_FIELD2,PRIMARY_VALUE1,PRIMARY_VALUE2) > 0 THEN
          BEGIN
          SQL_STR := '';
          SQL_STR := SQL_STR+'UPDATE '+TABLE_NAME +#13;
          SQL_STR := SQL_STR+'SET'                +#13;
  
          J := 1;
          FOR I := 0 TO QCHECK.FieldCount-1 DO
              BEGIN
              SQL_STR := SQL_STR+QCHECK.Fields.Fields[I].FieldName+' = ';
  
              IF QCHECK.Fields.Fields[I].DataType = ftString   THEN
                 BEGIN
                 SQL_STR := SQL_STR + ''''+TRIM(COPY(STR,J,QCHECK.Fields.Fields[I].DataSize))+'''';
                 J := J + QCHECK.Fields.Fields[I].DataSize;
                 END;
              IF QCHECK.Fields.Fields[I].DataType = ftFloat    THEN
                 BEGIN
                 TMP := TRIM(COPY(STR,J,8));
                 IF CHECK_FLOATINT(TMP) = TRUE THEN SQL_STR := SQL_STR + TMP
                                               ELSE SQL_STR := SQL_STR + '0';
                 J := J + 8;
                 END;
              IF QCHECK.Fields.Fields[I].DataType = ftDateTime THEN
                 BEGIN
                 TMP := TRIM(COPY(STR,J,10));
                 IF CHECK_EDATE(TMP,FALSE) = TRUE THEN SQL_STR := SQL_STR + _DT+TMP+_DT
                                                  ELSE SQL_STR := SQL_STR + _DT+'1989/1/1'+_DT;
                 J := J + 10;
                 END;
              IF QCHECK.Fields.Fields[I].DataType = ftBoolean  THEN
                 BEGIN
                 TMP := TRIM(COPY(STR,J,QCHECK.Fields.Fields[I].DataSize));
                 IF TMP = 'Tr' THEN SQL_STR := SQL_STR + '1';
                 IF TMP = 'Fa' THEN SQL_STR := SQL_STR + '0';
                 J := J + QCHECK.Fields.Fields[I].DataSize;
                 END;
  
              IF I < QCHECK.FieldCount-1 THEN SQL_STR := SQL_STR + ','+#13;
              END;
          SQL_STR := SQL_STR+#13+'WHERE '+PRIMARY_FIELD1+' = '''+PRIMARY_VALUE1+''''+#13;
          SQL_STR := SQL_STR+#13+'  AND '+PRIMARY_FIELD2+' = '''+PRIMARY_VALUE2+''''+#13;
          QINS.SQL.Text := SQL_STR;
          QINS.EXECSQL;
          INC(CNT);
          END ELSE BEGIN
          SQL_STR := '';
          SQL_STR := SQL_STR+'INSERT INTO '+TABLE_NAME +#13;
          SQL_STR := SQL_STR+'('                       +#13;
  
          FOR I := 0 TO QCHECK.FieldCount-1 DO
              BEGIN
              SQL_STR := SQL_STR+QCHECK.Fields.Fields[I].FieldName;
              IF I < QCHECK.FieldCount-1 THEN SQL_STR := SQL_STR + ','+#13;
              END;
          SQL_STR := SQL_STR+')VALUES('                +#13;
  
          J := 1;
          FOR I := 0 TO QCHECK.FieldCount-1 DO
              BEGIN
              IF QCHECK.Fields.Fields[I].DataType = ftString   THEN
                 BEGIN
                 SQL_STR := SQL_STR + ''''+TRIM(COPY(STR,J,QCHECK.Fields.Fields[I].DataSize))+'''';
                 J := J + QCHECK.Fields.Fields[I].DataSize;
                 END;
              IF QCHECK.Fields.Fields[I].DataType = ftFloat    THEN
                 BEGIN
                 TMP := TRIM(COPY(STR,J,8));
                 IF CHECK_FLOATINT(TMP) = TRUE THEN SQL_STR := SQL_STR + TMP
                                               ELSE SQL_STR := SQL_STR + '0';
                 J := J + 8;
                 END;
              IF QCHECK.Fields.Fields[I].DataType = ftDateTime THEN
                 BEGIN
                 TMP := TRIM(COPY(STR,J,10));
                 IF CHECK_EDATE(TMP,FALSE) = TRUE THEN SQL_STR := SQL_STR + _DT+TMP+_DT
                                                  ELSE SQL_STR := SQL_STR + _DT+'1989/1/1'+_DT;
                 J := J + 10;
                 END;
              IF QCHECK.Fields.Fields[I].DataType = ftBoolean  THEN
                 BEGIN
                 TMP := TRIM(COPY(STR,J,QCHECK.Fields.Fields[I].DataSize));
                 IF TMP = 'Tr' THEN SQL_STR := SQL_STR + '1';
                 IF TMP = 'Fa' THEN SQL_STR := SQL_STR + '0';
                 J := J + QCHECK.Fields.Fields[I].DataSize;
                 END;
  
              IF I < QCHECK.FieldCount-1 THEN SQL_STR := SQL_STR + ','+#13;
              END;
          SQL_STR := SQL_STR+')'                       +#13;
          QINS.SQL.Text := SQL_STR;
          QINS.EXECSQL;
          INC(CNT);
          END;   // IF
  
       END;  // WHILE NOT


     CloseFile(TF);
     END;

  FINALLY
    QCHECK.Free;
    QINS.FREE;
    GFORM.Free;
  END;

  RESULT := CNT;
END;

FUNCTION DOWNLOAD_DATASET(Q:TQUERY; FILE_NAME, TCAPTION:STRING):INTEGER;
VAR I, J, CNT : INTEGER;
    FILENAME , STR: STRING;
    TF : TEXTFILE;
    QCHECK : TQUERY;
    GFORM  : TFORM;
    GGAUGE : TGAUGE;
BEGIN
  CNT := 0;

  TRY
   GFORM  := TFORM .Create(APPLICATION.Owner);
   GFORM.Position := POSCREENCENTER;
   GFORM.Caption := TCAPTION;
   GFORM.HEIGHT  := 70;
   GFORM.WIDTH   := 200;
  
   GGAUGE := TGAUGE.Create(APPLICATION.Owner);
   GGAUGE.Parent := GFORM;
   GGAUGE.ForeColor := CLRED;
   GGAUGE.Left := 2;
   GGAUGE.TOP  := 10;
   GGAUGE.Width := 185;
   GGAUGE.Height := 30;
   GFORM.Show;
  
  
   QCHECK := TQUERY.Create(APPLICATION.Owner);
   QCHECK.DatabaseName := 'MAIN';
  
   QCHECK.SQL.TEXT := Q.SQL.Text;
   QCHECK.CLOSE;
   QCHECK.OPEN;
  
   IF FileExists(FILENAME) = FALSE THEN FILE_CREATE(FILE_NAME);
   IF TEST_OPEN_FILE(FILE_NAME) = TRUE THEN
     BEGIN
     AssignFile(TF,FILE_NAME);
     REWRITE(TF);
  
     GGAUGE.MaxValue := QCHECK.RecordCount;
     GGAUGE.Progress := 0;
     QCHECK.FIRST;
     WHILE NOT QCHECK.EOF DO
       BEGIN
       GGAUGE.AddProgress(1);
       
       FOR I := 0 TO QCHECK.FieldCount-1 DO
           BEGIN
           IF QCHECK.Fields.Fields[I].DataType = ftString   THEN
              BEGIN
              STR := COPY(QCHECK.Fields.Fields[I].AsString,1,QCHECK.Fields.Fields[I].DataSize);
              STR := STR+ REPLICATE(' ',QCHECK.Fields.Fields[I].DataSize-LENGTH(STR));
              END;
           IF QCHECK.Fields.Fields[I].DataType = ftFloat    THEN
              BEGIN
              STR := COPY(QCHECK.Fields.Fields[I].AsString,1,8);
              STR := STR+ REPLICATE(' ',8-LENGTH(STR));
              END;
           IF QCHECK.Fields.Fields[I].DataType = ftDateTime THEN
              BEGIN
              STR := COPY(QCHECK.Fields.Fields[I].AsString,1,10);
              STR := STR+ REPLICATE(' ',10-LENGTH(STR));
              END;
           IF QCHECK.Fields.Fields[I].DataType = ftBoolean  THEN
              BEGIN
              STR := COPY(QCHECK.Fields.Fields[I].AsString,1,QCHECK.Fields.Fields[I].DataSize);
              STR := STR+ REPLICATE(' ',QCHECK.Fields.Fields[I].DataSize-LENGTH(STR));
              END;

           WRITE(TF,STR);
           END;
       WRITELN(TF,'');
       QCHECK.NEXT;
       INC(CNT);
       END;
  
     CloseFile(TF);
     END;

  FINALLY
    QCHECK.Free;
    GFORM.Free;
  END;
  
  RESULT := CNT;
END;

FUNCTION DOWNLOAD_DATASETADD(Q:TQUERY; FILE_NAME:STRING):INTEGER;
VAR I, J, CNT : INTEGER;
    FILENAME , STR: STRING;
    TF : TEXTFILE;
    QCHECK : TQUERY;
BEGIN
  CNT := 0;

  TRY
   QCHECK := TQUERY.Create(APPLICATION.Owner);
   QCHECK.DatabaseName := 'MAIN';
   QCHECK.SQL.TEXT := Q.SQL.Text;
   QCHECK.CLOSE;
   QCHECK.OPEN;
  
   IF FileExists(FILENAME) = FALSE THEN FILE_CREATE(FILE_NAME);
   IF TEST_OPEN_FILE(FILE_NAME) = TRUE THEN
     BEGIN
     AssignFile(TF,FILE_NAME);
     APPEND(TF);
  
     QCHECK.FIRST;
     WHILE NOT QCHECK.EOF DO
       BEGIN
  
       FOR I := 0 TO QCHECK.FieldCount-1 DO
           BEGIN
           IF QCHECK.Fields.Fields[I].DataType = ftString   THEN
              BEGIN
              STR := COPY(QCHECK.Fields.Fields[I].AsString,1,QCHECK.Fields.Fields[I].DataSize);
              STR := STR+ REPLICATE(' ',QCHECK.Fields.Fields[I].DataSize-LENGTH(STR));
              END;
           IF QCHECK.Fields.Fields[I].DataType = ftFloat    THEN
              BEGIN
              STR := COPY(QCHECK.Fields.Fields[I].AsString,1,8);
              STR := STR+ REPLICATE(' ',8-LENGTH(STR));
              END;
           IF QCHECK.Fields.Fields[I].DataType = ftDateTime THEN
              BEGIN
              STR := COPY(QCHECK.Fields.Fields[I].AsString,1,10);
              STR := STR+ REPLICATE(' ',10-LENGTH(STR));
              END;
           IF QCHECK.Fields.Fields[I].DataType = ftBoolean  THEN
              BEGIN
              STR := COPY(QCHECK.Fields.Fields[I].AsString,1,QCHECK.Fields.Fields[I].DataSize);
              STR := STR+ REPLICATE(' ',QCHECK.Fields.Fields[I].DataSize-LENGTH(STR));
              END;
  
           WRITE(TF,STR);
           END;
       WRITELN(TF,'');
       QCHECK.NEXT;
       INC(CNT);
       END;
  
     CloseFile(TF);
     END;

  FINALLY
    QCHECK.Free;
  END;

  RESULT := CNT;
END;

FUNCTION TABLE_TO_TABLE(Q:TQUERY; DATABASE_NAME, TABLE_NAME:STRING):INTEGER;
VAR I, J, CNT : INTEGER;
      SQL_STR, TMP    : STRING;
      TF : TEXTFILE;
      QCHECK : TQUERY;
      GFORM  : TFORM;
      GGAUGE : TGAUGE;
BEGIN
  CNT := 0;
  
  TRY
   GFORM  := TFORM .Create(APPLICATION.Owner);
   GFORM.Position := POSCREENCENTER;
   GFORM.Caption := '进度';
   GFORM.HEIGHT  := 70;
   GFORM.WIDTH   := 200;
  
   GGAUGE := TGAUGE.Create(APPLICATION.Owner);
   GGAUGE.Parent := GFORM;
   GGAUGE.ForeColor := CLRED;
   GGAUGE.Left := 2;
   GGAUGE.TOP  := 10;
   GGAUGE.Width := 185;
   GGAUGE.Height := 30;
   GFORM.Show;
  
   QCHECK := TQUERY.Create(APPLICATION.Owner);
   QCHECK.DatabaseName := DATABASE_NAME;
  
   GGAUGE.Progress := 0;
   IF (Q.RecordCount >0) AND (Q.RecordCount <1000000) THEN
       GGAUGE.MAXValue := Q.RecordCount;
   Q.FIRST;
   WHILE NOT Q.EOF DO
     BEGIN
     GGAUGE.AddProgress(1);
     SQL_STR := '';
     SQL_STR := SQL_STR+'INSERT INTO '+TABLE_NAME +#13;
     SQL_STR := SQL_STR+'('                       +#13;
  
  
     FOR I := 0 TO Q.FieldCount-1 DO
         BEGIN
         SQL_STR := SQL_STR + Q.Fields.Fields[I].FieldName;
         IF I < Q.FieldCount-1 THEN SQL_STR := SQL_STR + ',';
         END;
     SQL_STR := SQL_STR+')VALUES('                +#13;
  
     FOR I := 0 TO Q.FieldCount-1 DO
         BEGIN
         IF Q.Fields.Fields[I].DataType = ftString   THEN
            BEGIN
            SQL_STR := SQL_STR + ''''+ TRIM(Q.Fields.Fields[I].ASSTRING)+'''';
            END;
         IF Q.Fields.Fields[I].DataType = ftFloat    THEN
            BEGIN
            TMP := TRIM(Q.Fields.Fields[I].ASSTRING);
            IF CHECK_FLOATINT(TMP) = TRUE THEN SQL_STR := SQL_STR + TMP
                                          ELSE SQL_STR := SQL_STR + '0';
            END;
         IF Q.Fields.Fields[I].DataType = ftDateTime THEN
            BEGIN
            TMP := TRIM(Q.Fields.Fields[I].ASSTRING);
            IF CHECK_EDATE(TMP,FALSE) = TRUE THEN SQL_STR := SQL_STR + _DT+TMP+_DT
                                             ELSE SQL_STR := SQL_STR + _DT+'1989/1/1'+_DT;
            END;
         IF Q.Fields.Fields[I].DataType = ftBoolean  THEN
            BEGIN
            TMP := TRIM(Q.Fields.Fields[I].ASSTRING);
            IF POS('T',TMP) >0 THEN SQL_STR := SQL_STR + '1';
            IF POS('F',TMP) >0 THEN SQL_STR := SQL_STR + '0';
            END;
         IF Q.Fields.Fields[I].DataType = ftMEMO   THEN
            BEGIN
            SQL_STR := SQL_STR + ''''+ TRIM(Q.Fields.Fields[I].ASSTRING)+'''';
            END;
  
  
         IF I < Q.FieldCount-1 THEN SQL_STR := SQL_STR + ','+#13;
         END;
     SQL_STR := SQL_STR+')'                       +#13;
  
     QCHECK.SQL.CLEAR;
     QCHECK.SQL.TEXT := SQL_STR;
     QCHECK.EXECSQL;

     Q.NEXT;
     END;

  FINALLY
    QCHECK.Free;
    GFORM.Free;
  END;

  RESULT := CNT;
END;

FUNCTION TABLE_TO_CLEAN(DATABASE_NAME, TABLE_NAME:STRING):BOOLEAN;
VAR QCHECK : TQUERY;
BEGIN
  QCHECK := TQUERY.Create(APPLICATION.Owner);
  QCHECK.DatabaseName := DATABASE_NAME;
  QCHECK.SQL.CLEAR;
  QCHECK.SQL.ADD('DELETE FROM '+TABLE_NAME );
  QCHECK.EXECSQL;
  QCHECK.Free;
  RESULT := TRUE;
END;

// 检查 档案的最大编号
FUNCTION CHECK_BASE_TABLE_NO(TABLE_NAME,FIELD_NAME:STRING):STRING;
VAR QDBCHECK : TQUERY;
BEGIN
  IF (TABLE_NAME='') THEN EXIT;
  IF (FIELD_NAME='') THEN EXIT;
   QDBCHECK := TQUERY.Create(APPLICATION.Owner);
   QDBCHECK.DatabaseName := 'MAIN';
   QDBCHECK.SQL.Clear;
   QDBCHECK.SQL.Add('SELECT MAX('+FIELD_NAME+') AS MAX FROM '+TABLE_NAME);
   TRY
     QDBCHECK.Close;
     QDBCHECK.Open;
   EXCEPT
     RESULT := '';
   END;

   IF QDBCHECK.Eof = FALSE THEN RESULT := QDBCHECK.FieldByName('MAX').AsString;
   IF QDBCHECK.Eof = TRUE  THEN RESULT := '';
END;










FUNCTION HOTKEY_LIST(KEY_INDEX:INTEGER):STRING;
BEGIN
CASE KEY_INDEX OF
   0 : RESULT := 'ESC';
   1 : RESULT := 'F1';
   2 : RESULT := 'F2';
   3 : RESULT := 'F3';
   4 : RESULT := 'F4';
   5 : RESULT := 'F5';
   6 : RESULT := 'F6';
   7 : RESULT := 'F7';
   8 : RESULT := 'F8';
   9 : RESULT := 'F9';
  10 : RESULT := 'F10';
  11 : RESULT := 'F11';
  12 : RESULT := 'F12';
  13 : RESULT := 'CTRL+A';
  14 : RESULT := 'CTRL+B';
  15 : RESULT := 'CTRL+C';
  16 : RESULT := 'CTRL+D';
  17 : RESULT := 'CTRL+E';
  18 : RESULT := 'CTRL+F';
  19 : RESULT := 'CTRL+G';
  20 : RESULT := 'CTRL+H';
  21 : RESULT := 'CTRL+I';
  22 : RESULT := 'CTRL+J';
  23 : RESULT := 'CTRL+K';
  24 : RESULT := 'CTRL+L';
  25 : RESULT := 'CTRL+M';
  26 : RESULT := 'CTRL+N';
  27 : RESULT := 'CTRL+O';
  28 : RESULT := 'CTRL+P';
  29 : RESULT := 'CTRL+Q';
  30 : RESULT := 'CTRL+R';
  31 : RESULT := 'CTRL+S';
  32 : RESULT := 'CTRL+T';
  33 : RESULT := 'CTRL+U';
  34 : RESULT := 'CTRL+V';
  35 : RESULT := 'CTRL+W';
  36 : RESULT := 'CTRL+X';
  37 : RESULT := 'CTRL+Y';
  38 : RESULT := 'CTRL+Z';
  ELSE RESULT := 'ESC';
END;
END;











FUNCTION SYSLOG_INSERT(T_SGKIN,T_PAIDE,T_SGMRK:STRING):BOOLEAN;
VAR QCHECK : TQUERY;
BEGIN
  TRY
   QCHECK := TQUERY.Create(APPLICATION.Owner);
   QCHECK.DatabaseName := 'MAIN';
   QCHECK.SQL.Clear;
   QCHECK.SQL.Add('INSERT INTO SYSLOG');
   QCHECK.SQL.Add('( SGENO, SGKIN, PAIDE, BNENO , SGDAT , SGTME , SGMRK  ');
   QCHECK.SQL.Add(') VALUES (');
   QCHECK.SQL.Add(''''+TABLEFINDMAXCNT('SYSLOG','SGENO',9,1)+''',');
   QCHECK.SQL.Add(''''+T_SGKIN            +''',');
   QCHECK.SQL.Add(''''+T_PAIDE            +''',');
   QCHECK.SQL.Add(''''+_USER_ID           +''',');
   QCHECK.SQL.Add(''''+DATETOSTR(DATE)    +''',');
   QCHECK.SQL.Add(''''+TIME_GET_24H(TIME) +''',');
   QCHECK.SQL.Add(''''+T_SGMRK            +''' )');
   QCHECK.EXECSQL;
  FINALLY
    QCHECK.Free;
  END;
END;


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
BEGIN
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
END;


end.
