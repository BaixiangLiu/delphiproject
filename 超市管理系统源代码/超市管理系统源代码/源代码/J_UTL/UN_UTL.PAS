unit un_utl;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Dialogs,
  StdCtrls, WinTypes, WinProcs, FORMS, Menus, inifiles;


// CPU ID 专用变量==================================
const
	ID_BIT	=	$200000;			// EFLAGS ID bit
type
	TCPUID	= array[1..4] of Longint;
	TVendor	= array [0..11] of char;
//===================================================

// UN_UTL  专用变量==================================
//===================================================



// 日期---------------------------------------------
//英日期转中日期
FUNCTION EDATETOCDATE(EDATE:STRING):STRING;
//检查英文日期格式是否正确
FUNCTION EDATECHECK(EDATE:STRING):BOOLEAN;
//英日期转中日期
FUNCTION EDATE_TO_CDATE(EDATE:STRING):STRING;
//中日期转英日期
FUNCTION CDATE_TO_EDATE(CDATE:STRING):STRING;
//中日期 -> 取年份
FUNCTION CDATE_GET_YEAR(T_DATE:STRING):STRING;
//中日期 -> 取月份
FUNCTION CDATE_GET_MONTH(T_DATE:STRING):STRING;
//中日期 -> 取日期
FUNCTION CDATE_GET_DAY(T_DATE:STRING):STRING;
//英日期 -> 取年份
FUNCTION DATE_GET_YEAR(T_DATE:STRING):STRING;
//英日期 -> 取月份
FUNCTION DATE_GET_MONTH(T_DATE:STRING):STRING;
//英日期 -> 取日期
FUNCTION DATE_GET_DAY(T_DATE:STRING):STRING;
//时间   -> 取时间 24H
FUNCTION TIME_GET_24H(T_TIME:TTIME):STRING;
//时间   -> 检查是否在时间范围内
FUNCTION TIME_CHECK_RANGE(TIME1,TIME2 :STRING; T_RANGE :INTEGER):BOOLEAN;


//检查英文日期格式是否正确
FUNCTION CHECK_EDATE(EDATE:STRING;WARNING:BOOLEAN):BOOLEAN;
//检查中文日期格式是否正确
FUNCTION CHECK_CDATE(CDATE:STRING;WARNING:BOOLEAN):BOOLEAN;
//检查 月份 日期数 格式是否正确
FUNCTION CHECK_DAY(MONTH,DAY:INTEGER;WARNING:BOOLEAN):BOOLEAN;
//检查 时间  格式是否正确
FUNCTION CHECK_TIME(TIME:STRING;WARNING:BOOLEAN):BOOLEAN;
//检查 时间  格式是否正确(可超过 24H )
FUNCTION CHECK_LONGTIME(TIME:STRING;WARNING:BOOLEAN):BOOLEAN;
// 计算 当月 日数
FUNCTION CYEARMONTH_DAYS(CYEARMONTH:STRING):INTEGER;
// 计算 当月 日数
FUNCTION EYEARMONTH_DAYS(EYEARMONTH:STRING):INTEGER;

// 英文 日期 - 日期 减法
FUNCTION EDATE_SUB_EDATE(DAT1, DAT2 : TDATETIME):INTEGER;
// 英文 年份 减法
FUNCTION EYEAR_SUB(CYEAR:STRING;T_SUB:INTEGER):STRING;
// 中文 月份 减法
FUNCTION CYEARMONTH_SUB(CYEARMONTH:STRING;T_SUB:INTEGER):STRING;


// 密码---------------------------------------------
FUNCTION Encrypt(const InSTRING:STRING; StartKey,MultKey,AddKey:INTEGER): STRING;
FUNCTION Decrypt(const InSTRING:STRING; StartKey,MultKey,AddKey:INTEGER): STRING;
//edit2.text := Encrypt(edit1.text,123456,13579,24680);
//edit3.text := Decrypt(edit2.text,123456,13579,24680);


// 文件相关功能 ================================================================
FUNCTION TEST_OPEN_FILE(FILENAME:STRING):BOOLEAN;            // 测试文件是否可以打开
FUNCTION FILE_CREATE(FILENAME:STRING):BOOLEAN;               // 建立新文件
FUNCTION FILE_REWRITE(FILENAME:STRING):BOOLEAN;              // 清除文件
FUNCTION TEXTFILE_RECCNT(FILENAME:STRING):INTEGER;           // TEXT读出文件 行数
FUNCTION FILE_APPEND_LOG(FILENAME,TITLE,TXT:STRING):BOOLEAN; // 写入文件
FUNCTION FILE_WRITELN_REC(FILENAME,TITLE,TXT:STRING):STRING; // 写入文件单行
FUNCTION FILE_READLN_REC(FILENAME,TITLE:STRING):STRING;      // 读出文件单行
// 文件相关功能 ================================================================



//字符串处理 =======================================================================
//copy 由右至左
FUNCTION Copy_R(S: STRING; Index, Count: INTEGER): STRING;
//产生空白
FUNCTION SPACE(Count: INTEGER): STRING;
{ 字符串复制  }
FUNCTION REPLICATE(VSTR1:STRING;VLEN:SMALLINT):STRING;
{ 字符串填满  }
FUNCTION FILL_STR(FILL_STR, STR, KIND:STRING; TOTAL_LENGTH:INTEGER):STRING;
{ 字符串累加  }
FUNCTION STR_INC(FILL_STR, STR:STRING; T_START, T_END, T_CNT:INTEGER):STRING;
{ 字符串转浮点  }
FUNCTION STRTOFLOATDEF(STR:STRING;FDEFAULT:REAL):REAL;
{ 字符串替换  }
FUNCTION STR_REPLACE(STR, SUBSTR1,SUBSTR2:STRING):STRING;
{ 字符串插入  }
FUNCTION STR_INSERT(STR, S1, S2:STRING; FB:BOOLEAN):STRING;
{ 数据字符串找寻  }
FUNCTION STR_DB_FIELDBYNO(STR, RAIL:STRING;FIELD_NO:INTEGER):STRING;
{ 删除数据字符串  }
FUNCTION TRIM_STR(STR, TRIMSTR:STRING):STRING;
{ 整数 转 字符串 再补零 }
FUNCTION INTTOSTR_REP(TINT,REP:INTEGER):STRING;
{ BOOLEAN TRUE FALSE 转 01 }
FUNCTION BOOLEANTOSTR(TB : BOOLEAN):STRING;


{ 检查是否为整数 }
FUNCTION CHECK_INT(T_STR:STRING):BOOLEAN;
{ 检查是否为浮点数 }
FUNCTION CHECK_FLOAT(T_STR:STRING):BOOLEAN;
{ 检查是否为浮点数 和 整数}
FUNCTION CHECK_FLOATINT(T_STR:STRING):BOOLEAN;
{ 取 浮点数 , 小数点位数 }
FUNCTION FLOAT_LENGTH(T_STR:STRING;T_LENGTH:INTEGER):STRING;
{ 浮点数 转 整数 }
FUNCTION FLOATTOINT(T_FLOAT:REAL):INTEGER;
{ 浮点数 转 整数 PS: 无条件小数第一位进位}
FUNCTION FLOATTOINT_ROUND(T_FLOAT:REAL):INTEGER;
{ 整数 个位数 四舍五入  }
FUNCTION ROUND_1(T_INT:INTEGER):INTEGER;
{ 整数 次方 }
FUNCTION INT_CUBE(T_INT,T_CUBE:INTEGER):INTEGER;
{ 16 进位 转 整数  }
FUNCTION HEXTOINT(THEX:STRING):INTEGER;



//其它{ Delay program execution by n milliseconds }
procedure Delay(n: INTEGER);
//汇率计算
FUNCTION EXCHANGE_CAL(T_EXCHG:STRING;T_LENGTH:INTEGER):STRING;


//打印机 输出入 ================================================================
procedure Out32(PortAddress:smallint;Value:smallint);stdcall;export;
FUNCTION  Inp32(PortAddress:smallint):smallint;stdcall;export;
FUNCTION  COMPORT_OUT  (PortNAME,EXPRESS:STRING):BOOLEAN;
FUNCTION  COMPORT_OUTLN(PortNAME,EXPRESS:STRING):BOOLEAN;
//打印机 输出入 ================================================================


//CPU ID 及信息
FUNCTION IsCPUID_Available : BOOLEAN; register;
FUNCTION GetCPUID : TCPUID; assembler; register;
FUNCTION GetCPUVendor : TVendor; assembler; register;


//条形码类
FUNCTION EAN13_ENCODE(T_STR:STRING):STRING;
FUNCTION EAN13_AUTOADD(T_STR:STRING):STRING;

//发票类 =======================================================================
FUNCTION INVOICE_NO_CHECK(T_STR:STRING):BOOLEAN;  //检查发票号码
//发票类 =======================================================================


//检查信用卡号
FUNCTION ValidateCreditCardNo(value: STRING; WARNING:BOOLEAN): BOOLEAN;






//对象 储存相关信息值 INI FILE  ================================================
FUNCTION INI_SAVE_OBJECT(INIFILENAME, OBJECT_NAME :STRING; T_LEFT, T_TOP :INTEGER; T_TEXT:STRING):BOOLEAN;
FUNCTION INI_SAVE_INT   (INIFILENAME, OBJECT_NAME :STRING; T_INTEGER :INTEGER):BOOLEAN;
FUNCTION INI_SAVE_STR   (INIFILENAME, OBJECT_NAME :STRING; T_STR :STRING):BOOLEAN;
FUNCTION INI_SAVE_STR2  (INIFILENAME, OBJECT_NAME, OBJECT_KIND :STRING; T_STR :STRING):BOOLEAN;
FUNCTION INI_SAVE_BOOL  (INIFILENAME, OBJECT_NAME :STRING; T_BOOL :BOOLEAN):BOOLEAN;
//对象 取回相关信息值 INI FILE  ================================================
FUNCTION INI_LOAD_OBJECT(INIFILENAME, OBJECT_NAME, OBJECT_KIND, T_DEFAULT :STRING):STRING;
FUNCTION INI_LOAD_INT   (INIFILENAME, OBJECT_NAME :STRING; T_DEFAULT:INTEGER ):INTEGER;
FUNCTION INI_LOAD_STR   (INIFILENAME, OBJECT_NAME :STRING; T_DEFAULT:STRING  ):STRING;
FUNCTION INI_LOAD_STR2  (INIFILENAME, OBJECT_NAME , OBJECT_KIND:STRING; T_DEFAULT:STRING  ):STRING;
FUNCTION INI_LOAD_BOOL  (INIFILENAME, OBJECT_NAME :STRING; T_DEFAULT:BOOLEAN  ):BOOLEAN;
// =============================================================================


{ Input dialog }

FUNCTION JInputBox(const ACaption, APrompt, ADefault: STRING): STRING;
FUNCTION JInputQuery(const ACaption, APrompt: STRING; VAR Value: STRING): BOOLEAN;
FUNCTION JMSGFORM(const ACaption, ADefault: STRING;T_FONTSIZE:INTEGER): BOOLEAN;
FUNCTION JSHOWMESSAGE(const ACaption, APROMPT: STRING): BOOLEAN;
//FUNCTION JInputIntQuery(const ACaption, APrompt: STRING; Value: INTEGER):INTEGER;






implementation


// 日期---------------------------------------------
//英日期转中日期
FUNCTION EDATETOCDATE(EDATE:STRING):STRING;
VAR T_DATE :STRING;
    T_YEAR, T_MONTH, T_DAY :STRING;
BEGIN
IF EDATECHECK(EDATE) = FALSE THEN EXIT;

T_DATE := EDATE;

T_YEAR  := COPY(T_DATE,1,POS('/',T_DATE)-1 );
T_DATE  := TRIM( COPY(T_DATE,POS('/',T_DATE)+1 ,10) );
T_MONTH := COPY(T_DATE,1,POS('/',T_DATE)-1 );
T_DATE  := TRIM( COPY(T_DATE,POS('/',T_DATE)+1 ,10) );
T_DAY   := T_DATE;

T_YEAR  := INTTOSTR( STRTOINT(T_YEAR)-1911  );
T_MONTH := REPLICATE('0',2 - LENGTH(T_MONTH)) + T_MONTH;  //加'0'
T_DAY   := REPLICATE('0',2 - LENGTH(T_DAY  )) + T_DAY  ;  //加'0'

Result := T_YEAR+T_MONTH+T_DAY;
END;



//检查英文日期格式是否正确
FUNCTION EDATECHECK(EDATE:STRING):BOOLEAN;
VAR T_DATE :STRING;
    T_YEAR, T_MONTH, T_DAY :STRING;
BEGIN

T_DATE := EDATE;

T_YEAR  := COPY(T_DATE,1,POS('/',T_DATE)-1 );
T_DATE  := TRIM( COPY(T_DATE,POS('/',T_DATE)+1 ,10) );
T_MONTH := COPY(T_DATE,1,POS('/',T_DATE)-1 );
T_DATE  := TRIM( COPY(T_DATE,POS('/',T_DATE)+1 ,10) );
T_DAY   := T_DATE;

IF (T_YEAR  = '') OR
   (T_MONTH = '') OR
   (T_DAY   = '') OR
   ( STRTOINTDEF(T_YEAR  ,-1)<= 0  ) OR
   ( STRTOINTDEF(T_MONTH ,-1)<= 0  ) OR
   ( STRTOINTDEF(T_DAY   ,-1)<= 0  ) OR
   ( STRTOINTDEF(T_YEAR  ,-1)> 2100) OR
   ( STRTOINTDEF(T_MONTH ,-1)> 12  ) OR
   ( STRTOINTDEF(T_DAY   ,-1)> 31  ) THEN
   BEGIN
   SHOWMESSAGE('日期格式不正确');
   Result := FALSE;
   END ELSE
   BEGIN
   Result := TRUE;
   END;

END;


FUNCTION EDATE_TO_CDATE(EDATE:STRING):STRING;
VAR T_YEAR,T_MONTH,T_DAY, T_STR :STRING;
    BASE_YEAR :INTEGER;
BEGIN

IF CHECK_EDATE(EDATE,FALSE) = FALSE THEN EXIT;

T_YEAR  := COPY(EDATE,1,4);
T_STR   := TRIM(COPY(EDATE,POS('/',EDATE)+1,10));

T_MONTH := COPY(T_STR,1,POS('/',T_STR)-1);
T_STR   := TRIM(COPY(T_STR,POS('/',T_STR)+1,10));

T_DAY   := COPY(T_STR,POS('/',T_STR)+1,2);

IF LENGTH(T_MONTH) < 2 THEN T_MONTH := '0' + T_MONTH;
IF LENGTH(T_DAY)   < 2 THEN T_DAY   := '0' + T_DAY;

BASE_YEAR := 1911;

//RESULT := INTTOSTR(STRTOINT(T_YEAR)-BASE_YEAR) + T_MONTH + T_DAY ;
RESULT := T_YEAR + '-' + T_MONTH + '-' + T_DAY ;
END;

FUNCTION CDATE_TO_EDATE(CDATE:STRING):STRING;
VAR T_YEAR,T_MONTH,T_DAY :STRING;
    BASE_YEAR :INTEGER;
BEGIN

IF CHECK_CDATE(CDATE,TRUE) = FALSE THEN EXIT;

//ds
IF LENGTH(CDATE) = 10 THEN
   BEGIN
   T_YEAR  := COPY(CDATE,1,4);
   T_MONTH := COPY(CDATE,6,2);
   T_DAY   := COPY(CDATE,9,2);
   END;
//ds

{ds
IF LENGTH(CDATE) = 7 THEN
   BEGIN
   T_YEAR  := COPY(CDATE,1,3);
   T_MONTH := COPY(CDATE,4,2);
   T_DAY   := COPY(CDATE,6,2);
   END;
IF LENGTH(CDATE) = 6 THEN
   BEGIN
   T_YEAR  := COPY(CDATE,1,2);
   T_MONTH := COPY(CDATE,3,2);
   T_DAY   := COPY(CDATE,5,2);
   END;}


BASE_YEAR := 1911;

//RESULT := INTTOSTR(STRTOINT(T_YEAR)+BASE_YEAR)+'/'+T_MONTH+'/'+T_DAY ;
RESULT := T_YEAR+'/'+T_MONTH+'/'+T_DAY ;
END;






//中日期 -> 取年份
FUNCTION CDATE_GET_YEAR(T_DATE:STRING):STRING;
BEGIN
RESULT := '';
IF LENGTH(T_DATE) = 10 THEN RESULT := TRIM(COPY(T_DATE,1,4));
//IF LENGTH(T_DATE) = 6 THEN RESULT := TRIM(COPY(T_DATE,1,2));
//IF LENGTH(T_DATE) = 7 THEN RESULT := TRIM(COPY(T_DATE,1,3));
END;

//中日期 -> 取月份
FUNCTION CDATE_GET_MONTH(T_DATE:STRING):STRING;
BEGIN
RESULT := '';
IF LENGTH(T_DATE) = 10 THEN RESULT := TRIM(COPY(T_DATE,6,2));
//IF LENGTH(T_DATE) = 6 THEN RESULT := TRIM(COPY(T_DATE,3,2));
//IF LENGTH(T_DATE) = 7 THEN RESULT := TRIM(COPY(T_DATE,4,2));
END;

//中日期 -> 取日期
FUNCTION CDATE_GET_DAY(T_DATE:STRING):STRING;
BEGIN
RESULT := '';
IF LENGTH(T_DATE) = 10 THEN RESULT := TRIM(COPY(T_DATE,9,3));
//IF LENGTH(T_DATE) = 6 THEN RESULT := TRIM(COPY(T_DATE,5,2));
//IF LENGTH(T_DATE) = 7 THEN RESULT := TRIM(COPY(T_DATE,6,3));
END;




//英日期 -> 取年份
FUNCTION DATE_GET_YEAR(T_DATE:STRING):STRING;
BEGIN
RESULT := TRIM(COPY(T_DATE,1,POS('/',T_DATE)-1));
END;

//英日期 -> 取月份
FUNCTION DATE_GET_MONTH(T_DATE:STRING):STRING;
VAR T1:STRING;
BEGIN
T1 := TRIM(COPY(T_DATE,POS('/',T_DATE)+1,LENGTH(T_DATE)));
RESULT := TRIM(COPY(T1,1,POS('/',T1)-1));
END;

//英日期 -> 取日期
FUNCTION DATE_GET_DAY(T_DATE:STRING):STRING;
VAR T1:STRING;
BEGIN
T1 := T_DATE;
T1 := TRIM(COPY(T1,POS('/',T1)+1,LENGTH(T1)));
T1 := TRIM(COPY(T1,POS('/',T1)+1,LENGTH(T1)));
RESULT := REPLICATE('0',2-LENGTH(T1)) + TRIM(COPY(T1,1,LENGTH(T1)));
END;

//时间   -> 取时间 24H
FUNCTION TIME_GET_24H(T_TIME:TTIME):STRING;
VAR RET_TIME, T_APM, T_HOUR, T_MIN :STRING;
    X_HOUR : INTEGER;
BEGIN
RET_TIME := COPY(TIMETOSTR(T_TIME),4,5);
T_APM    := COPY(TIMETOSTR(T_TIME),1,2);
T_HOUR   := COPY(TIMETOSTR(T_TIME),4,2);
T_MIN    := COPY(TIMETOSTR(T_TIME),7,2);

X_HOUR := STRTOINTDEF(T_HOUR,0);

IF T_APM = 'PM' THEN
   BEGIN
   IF X_HOUR <12 THEN T_HOUR := INTTOSTR(STRTOINTDEF(T_HOUR,0)+12);
   RET_TIME := REPLICATE('0',2-LENGTH(T_HOUR)) + T_HOUR+':'+ T_MIN; //加'0'
   END;

IF T_APM = 'AM' THEN
   BEGIN
   IF X_HOUR =12 THEN T_HOUR := INTTOSTR(STRTOINTDEF(T_HOUR,0)+12);
   RET_TIME := REPLICATE('0',2-LENGTH(T_HOUR)) + T_HOUR+':'+ T_MIN; //加'0'
   END;

RESULT := RET_TIME;
END;

//时间   -> 检查是否在时间范围内
FUNCTION TIME_CHECK_RANGE(TIME1,TIME2 :STRING; T_RANGE :INTEGER):BOOLEAN;
VAR T11, T12, T21, T22, T1, T2: INTEGER;
BEGIN
RESULT := FALSE;
IF (CHECK_TIME(TIME1,FALSE) = FALSE) OR (CHECK_TIME(TIME2,FALSE) = FALSE) THEN  EXIT;

T11 := STRTOINTDEF( COPY(TIME1,1,2) ,0);
T12 := STRTOINTDEF( COPY(TIME1,4,2) ,0);
T21 := STRTOINTDEF( COPY(TIME2,1,2) ,0);
T22 := STRTOINTDEF( COPY(TIME2,4,2) ,0);
T1 := T11 * 60 + T12;
T2 := T21 * 60 + T22;

//SHOWMESSAGE(INTTOSTR(T1)+'='+INTTOSTR(T2));

IF T1 > T2 THEN
   IF (T1 - T2) <= T_RANGE THEN RESULT := TRUE;
IF T2 > T1 THEN
   IF (T2 - T1) <= T_RANGE THEN RESULT := TRUE;

IF T1 = T2 THEN RESULT := TRUE;

{   IF T12 = T22 THEN RESULT := TRUE;
   IF T12 > T22 THEN
      IF (T12 - T22) <= T_RANGE THEN RESULT := TRUE;
   IF T22 > T12 THEN
      IF (T22 - T12) <= T_RANGE THEN RESULT := TRUE;
 }



END;

FUNCTION CHECK_EDATE(EDATE:STRING;WARNING:BOOLEAN):BOOLEAN;
VAR T_YEAR,T_MONTH,T_DAY,     T_STR :STRING;
BEGIN

T_YEAR  := COPY(EDATE,1,4);
T_STR   := TRIM(COPY(EDATE,POS('/',EDATE)+1,10));

T_MONTH := COPY(T_STR,1,POS('/',T_STR)-1);
T_STR   := TRIM(COPY(T_STR,POS('/',T_STR)+1,10));

T_DAY   := COPY(T_STR,POS('/',T_STR)+1,2);

IF (STRTOINTDEF(T_YEAR ,-1) < 0 ) OR
   (STRTOINTDEF(T_MONTH,-1) < 0 ) OR
   (STRTOINTDEF(T_DAY  ,-1) < 0 ) OR
   (STRTOINTDEF(T_YEAR ,-1) > 9999 ) OR
   (STRTOINTDEF(T_MONTH,-1) > 12 ) OR
   (STRTOINTDEF(T_DAY  ,-1) > 31 ) THEN  
   BEGIN
   IF WARNING = TRUE THEN showmessage('日期格式不正确!');
   RESULT := FALSE;
   END ELSE
   RESULT := TRUE;
END;


FUNCTION CHECK_CDATE(CDATE:STRING;WARNING:BOOLEAN):BOOLEAN;
VAR T_YEAR,T_MONTH,T_DAY,T_STR :STRING;
BEGIN

  T_YEAR  := COPY(CDATE,1,4);
  T_STR   := TRIM(COPY(CDATE,POS('-',CDATE)+1,10));
  T_MONTH := COPY(T_STR,1,POS('-',T_STR)-1);
  T_STR   := TRIM(COPY(T_STR,POS('-',T_STR)+1,10));
  T_DAY   := COPY(T_STR,POS('-',T_STR)+1,2);

  IF (STRTOINTDEF(T_YEAR ,-1) < 0 ) OR
     (STRTOINTDEF(T_MONTH,-1) < 0 ) OR
     (STRTOINTDEF(T_DAY  ,-1) < 0 ) OR
     (STRTOINTDEF(T_YEAR ,-1) > 9999 ) OR
     (STRTOINTDEF(T_MONTH,-1) > 12 ) OR
     (STRTOINTDEF(T_DAY  ,-1) > 31 ) or
     (Length(CDATE) < 10) or //check length
     (CHECK_DAY(STRTOINT(T_MONTH),STRTOINT(T_DAY) ,TRUE)=FALSE)//check day
       THEN//ds
   BEGIN
   IF WARNING = TRUE THEN showmessage('日期格式不正确!');
   RESULT := FALSE;
   END ELSE
   RESULT := TRUE;

{IF (STRTOINTDEF(CDATE,-1) < 0 ) then
   BEGIN
   IF WARNING = TRUE THEN showmessage('日期格式不正确!');
   RESULT := FALSE;
   EXIT;
   END;

IF (LENGTH(CDATE) > 7 ) then
   BEGIN
   IF WARNING = TRUE THEN showmessage('日期长度不能超过7个!');
   RESULT := FALSE;
   EXIT;
   END;

IF (LENGTH(CDATE) < 6 ) then
   BEGIN
   IF WARNING = TRUE THEN showmessage('日期长度不能小于6个!');
   RESULT := FALSE;
   EXIT;
   END;

//==========================================================
IF (LENGTH(CDATE) = 7 ) AND
   (CHECK_DAY( STRTOINT(COPY(CDATE,4,2)),STRTOINT(COPY(CDATE,6,2)) ,TRUE)=FALSE   )then
      BEGIN
      RESULT := FALSE;
      EXIT;
      END;

//==========================================================
IF (LENGTH(CDATE) = 6 ) AND
   (CHECK_DAY( STRTOINT(COPY(CDATE,3,2)),STRTOINT(COPY(CDATE,5,2)) ,TRUE)=FALSE   )then
      BEGIN
      RESULT := FALSE;
      EXIT;
      END;
//==========================================================


RESULT := TRUE;}

END;


FUNCTION CHECK_DAY(MONTH,DAY:INTEGER;WARNING:BOOLEAN):BOOLEAN;
BEGIN

IF (MONTH > 12 ) OR (MONTH < 1 ) THEN
   BEGIN
   IF WARNING = TRUE THEN showmessage('月份格式不正确!');
   RESULT := FALSE;
   EXIT;
   END;


CASE MONTH OF
  1,3,5,7,8,10,12 :BEGIN
                   IF (DAY > 31 ) OR (DAY < 1 ) THEN
                      BEGIN
                      IF WARNING = TRUE THEN showmessage('日期格式不正确!');
                      RESULT := FALSE;
                      EXIT;
                      END;
                   END;
  4,6,9,11        :BEGIN
                   IF (DAY > 30 ) OR (DAY < 1 ) THEN
                      BEGIN
                      IF WARNING = TRUE THEN showmessage('日期格式不正确!');
                      RESULT := FALSE;
                      EXIT;
                      END;
                   END;
  2               :BEGIN
                   IF (DAY > 29 ) OR (DAY < 1 ) THEN
                      BEGIN
                      IF WARNING = TRUE THEN showmessage('2月份日期格式不正确!');
                      RESULT := FALSE;
                      EXIT;
                      END;
                   END;

END;

RESULT := TRUE;
END;

FUNCTION CHECK_TIME(TIME:STRING;WARNING:BOOLEAN):BOOLEAN;
BEGIN

IF (STRTOINTDEF(COPY(TIME,1,2),-1) < 0   ) OR
   (STRTOINTDEF(COPY(TIME,1,2),-1) >= 24 ) OR
   (STRTOINTDEF(COPY(TIME,4,2),-1) < 0   ) OR
   (STRTOINTDEF(COPY(TIME,4,2),-1) >= 60 ) OR
   (COPY(TIME,3,1) <> ':'              ) THEN
   BEGIN
   IF WARNING = TRUE THEN showmessage('时间格式不正确!');
   RESULT := FALSE;
   EXIT;
   END;

IF (LENGTH(TIME) > 5 ) then
   BEGIN
   IF WARNING = TRUE THEN showmessage('时间长度不能超过5个!');
   RESULT := FALSE;
   EXIT;
   END;

IF (LENGTH(TIME) < 5 ) then
   BEGIN
   IF WARNING = TRUE THEN showmessage('时间长度不能小于5个!');
   RESULT := FALSE;
   EXIT;
   END;

RESULT := TRUE;
END;

FUNCTION CHECK_LONGTIME(TIME:STRING;WARNING:BOOLEAN):BOOLEAN;
BEGIN

IF (STRTOINTDEF(COPY(TIME,1,2),-1) < 0   ) OR
   (STRTOINTDEF(COPY(TIME,1,2),-1) >= 29 ) OR
   (STRTOINTDEF(COPY(TIME,4,2),-1) < 0   ) OR
   (STRTOINTDEF(COPY(TIME,4,2),-1) >= 60 ) OR
   (COPY(TIME,3,1) <> ':'              ) THEN
   BEGIN
   IF WARNING = TRUE THEN showmessage('时间格式不正确!');
   RESULT := FALSE;
   EXIT;
   END;

IF (LENGTH(TIME) > 5 ) then
   BEGIN
   IF WARNING = TRUE THEN showmessage('时间长度不能超过5个!');
   RESULT := FALSE;
   EXIT;
   END;

IF (LENGTH(TIME) < 5 ) then
   BEGIN
   IF WARNING = TRUE THEN showmessage('时间长度不能小于5个!');
   RESULT := FALSE;
   EXIT;
   END;

RESULT := TRUE;
END;


// 计算 当月 日数
FUNCTION CYEARMONTH_DAYS(CYEARMONTH:STRING):INTEGER;
VAR T_D1, THIS_MONTH:STRING;
    T_MONTHDAYS:INTEGER;
BEGIN
T_MONTHDAYS := 30;
T_D1 := CDATE_TO_EDATE(CYEARMONTH+'01');
THIS_MONTH := DATE_GET_MONTH(T_D1);
IF DATE_GET_MONTH(DATETOSTR(STRTODATE(T_D1)+27)) = TRIM_STR(THIS_MONTH,'0') THEN T_MONTHDAYS := 28;
IF DATE_GET_MONTH(DATETOSTR(STRTODATE(T_D1)+28)) = TRIM_STR(THIS_MONTH,'0') THEN T_MONTHDAYS := 29;
IF DATE_GET_MONTH(DATETOSTR(STRTODATE(T_D1)+29)) = TRIM_STR(THIS_MONTH,'0') THEN T_MONTHDAYS := 30;
IF DATE_GET_MONTH(DATETOSTR(STRTODATE(T_D1)+30)) = TRIM_STR(THIS_MONTH,'0') THEN T_MONTHDAYS := 31;

RESULT := T_MONTHDAYS;
END;

// 计算 当月 日数
FUNCTION EYEARMONTH_DAYS(EYEARMONTH:STRING):INTEGER;
VAR T_D1, THIS_MONTH:STRING;
    T_MONTHDAYS:INTEGER;
BEGIN
T_MONTHDAYS := 30;
T_D1 := DATE_GET_YEAR(EYEARMONTH)+'/'+DATE_GET_MONTH(EYEARMONTH)+'/'+'01';
THIS_MONTH := DATE_GET_MONTH(T_D1);
IF DATE_GET_MONTH(DATETOSTR(STRTODATE(T_D1)+27)) = TRIM_STR(THIS_MONTH,'0') THEN T_MONTHDAYS := 28;
IF DATE_GET_MONTH(DATETOSTR(STRTODATE(T_D1)+28)) = TRIM_STR(THIS_MONTH,'0') THEN T_MONTHDAYS := 29;
IF DATE_GET_MONTH(DATETOSTR(STRTODATE(T_D1)+29)) = TRIM_STR(THIS_MONTH,'0') THEN T_MONTHDAYS := 30;
IF DATE_GET_MONTH(DATETOSTR(STRTODATE(T_D1)+30)) = TRIM_STR(THIS_MONTH,'0') THEN T_MONTHDAYS := 31;

RESULT := T_MONTHDAYS;
END;

// 英文 日期 - 日期 减法
FUNCTION EDATE_SUB_EDATE(DAT1, DAT2 : TDATETIME):INTEGER;
VAR DAT3 : TDATETIME;
    Y1, M1, D1: Word;
    R : INTEGER;
BEGIN
R := 0;

IF DAT2 = DAT1 THEN
   BEGIN
   R := 0;
   END;
IF DAT2 > DAT1 THEN
   BEGIN
   DAT3 := DAT2 - DAT1 + 1;
   DecodeDate(DAT3 , Y1, M1, D1);
   //加上年
   R := R + ( (Y1-1900)*365 );
   //加上月
   IF M1 = 1 THEN R := R + 0 ;
   IF M1 = 2 THEN R := R + 31 ;
   IF M1 = 3 THEN R := R + 31 +28 ;
   IF M1 = 4 THEN R := R + 31 +28 +31 ;
   IF M1 = 5 THEN R := R + 31 +28 +31 +30 ;
   IF M1 = 6 THEN R := R + 31 +28 +31 +30 +31 ;
   IF M1 = 7 THEN R := R + 31 +28 +31 +30 +31 +30 ;
   IF M1 = 8 THEN R := R + 31 +28 +31 +30 +31 +30 +31 ;
   IF M1 = 9 THEN R := R + 31 +28 +31 +30 +31 +30 +31 +31 ;
   IF M1 =10 THEN R := R + 31 +28 +31 +30 +31 +30 +31 +31 +30 ;
   IF M1 =11 THEN R := R + 31 +28 +31 +30 +31 +30 +31 +31 +30 +31 ;
   IF M1 =12 THEN R := R + 31 +28 +31 +30 +31 +30 +31 +31 +30 +31 +30 ;
   //加上日
   R := R + D1;

   END;
IF DAT2 < DAT1 THEN
   BEGIN
   DAT3 := DAT1 - DAT2 + 1;
   DecodeDate(DAT3 , Y1, M1, D1);
   //加上年
   R := R + ( (Y1-1900)*365 );
   //加上月
   IF M1 = 1 THEN R := R + 0 ;
   IF M1 = 2 THEN R := R + 31 ;
   IF M1 = 3 THEN R := R + 31 +28 ;
   IF M1 = 4 THEN R := R + 31 +28 +31 ;
   IF M1 = 5 THEN R := R + 31 +28 +31 +30 ;
   IF M1 = 6 THEN R := R + 31 +28 +31 +30 +31 ;
   IF M1 = 7 THEN R := R + 31 +28 +31 +30 +31 +30 ;
   IF M1 = 8 THEN R := R + 31 +28 +31 +30 +31 +30 +31 ;
   IF M1 = 9 THEN R := R + 31 +28 +31 +30 +31 +30 +31 +31 ;
   IF M1 =10 THEN R := R + 31 +28 +31 +30 +31 +30 +31 +31 +30 ;
   IF M1 =11 THEN R := R + 31 +28 +31 +30 +31 +30 +31 +31 +30 +31 ;
   IF M1 =12 THEN R := R + 31 +28 +31 +30 +31 +30 +31 +31 +30 +31 +30 ;
   //加上日
   R := R + D1;
   R := 0 - R ;
   END;
RESULT := R ;
END;


// 英文 年份 减法
FUNCTION EYEAR_SUB(CYEAR:STRING;T_SUB:INTEGER):STRING;
VAR T_D1  :INTEGER;
    T_DX2 :STRING;
BEGIN
RESULT := CYEAR;
T_D1  := STRTOINTDEF(TRIM( COPY(CYEAR,1,POS('/',CYEAR)-1) ),1);
T_DX2 :=             TRIM( COPY(CYEAR,POS('/',CYEAR), 10) )   ;

T_D1 := T_D1 - T_SUB;

RESULT := INTTOSTR(T_D1) + T_DX2;
END;

// 中文 月份 减一
FUNCTION CYEARMONTH_SUB(CYEARMONTH:STRING;T_SUB:INTEGER):STRING;
VAR T_D1, T_D2 : INTEGER;
    T_DX2 :STRING;
BEGIN
RESULT := CYEARMONTH;
IF STRTOINTDEF(CYEARMONTH,-1) < 0 THEN EXIT;
T_D1 := STRTOINTDEF(COPY(CYEARMONTH,1,2),1);
T_D2 := STRTOINTDEF(COPY(CYEARMONTH,3,2),1);

IF T_D2 > T_SUB THEN
   BEGIN
   T_D2 := T_D2 - T_SUB;
   END ELSE BEGIN
   T_D1 := T_D1 - 1;
   T_D2 := T_D2 + 12 - T_SUB;
   END;

T_DX2 := INTTOSTR(T_D2);
IF LENGTH(T_DX2) < 2 THEN T_DX2 := '0' + T_DX2;
IF LENGTH(T_DX2) < 2 THEN T_DX2 := '0' + T_DX2;
RESULT := INTTOSTR(T_D1) + T_DX2;
END;

//====================================================================================

























// 密码---------------------------------------------

{*******************************************************
 * Standard Encryption algorithm - Copied from Borland *
 *******************************************************}
FUNCTION Encrypt(const InSTRING:STRING; StartKey,MultKey,AddKey:INTEGER): STRING;
var
  I : Byte;
BEGIN
  Result := '';
  for I := 1 to Length(InSTRING) do
  BEGIN
    Result := Result + CHAR(Byte(InSTRING[I]) xor (StartKey shr 8));
    StartKey := (Byte(Result[I]) + StartKey) * MultKey + AddKey;
  END;
END;
{*******************************************************
 * Standard Decryption algorithm - Copied from Borland *
 *******************************************************}
FUNCTION Decrypt(const InSTRING:STRING; StartKey,MultKey,AddKey:INTEGER): STRING;
var
  I : Byte;
BEGIN
  Result := '';
  for I := 1 to Length(InSTRING) do
  BEGIN
    Result := Result + CHAR(Byte(InSTRING[I]) xor (StartKey shr 8));
    StartKey := (Byte(InSTRING[I]) + StartKey) * MultKey + AddKey;
  END;
END;


// 文件相关功能 ================================================================
//测试文件是否可以打开
FUNCTION TEST_OPEN_FILE(FILENAME:STRING):BOOLEAN;
VAR FileHandle : INTEGER;
BEGIN
  FileHandle := FileOpen(FILENAME, fmOpenWrite);
  FileClose(FileHandle);
  IF FileHandle < 0 then
     BEGIN
     TEST_OPEN_FILE:= FALSE; //     SHOWMESSAGE(FILENAME+'路径文件名设定错误, 文件无法打开!');
     END ELSE BEGIN
     TEST_OPEN_FILE:= TRUE;
     END;
END;

//建立新文件
FUNCTION FILE_CREATE(FILENAME:STRING):BOOLEAN;
var FileHandle : INTEGER;
BEGIN
  FileHandle := FileOpen(FILENAME, fmOpenWrite);
  FileClose(FileHandle);
  IF FileHandle < 0 then
     BEGIN
     FileHandle := FileCREATE(FILENAME);
     FileClose(FileHandle);
     END;
  RESULT:= TRUE;
END;


//清除文件
FUNCTION FILE_REWRITE(FILENAME:STRING):BOOLEAN;
VAR TF :TEXTFILE;
BEGIN
  RESULT:= FALSE;
  IF FileExists(FILENAME) = FALSE THEN
     BEGIN
     FILE_CREATE(FILENAME);
     RESULT:= FALSE;
     END;
  IF FileExists(FILENAME) = TRUE  THEN
     BEGIN
     AssignFile(TF,FILENAME);
     Rewrite(TF);
     CloseFile(TF);
     RESULT:= TRUE;
     END;
END;


//写入文件
FUNCTION FILE_APPEND_LOG(FILENAME,TITLE,TXT:STRING):BOOLEAN;
VAR TF :TEXTFILE;
BEGIN
  RESULT:= FALSE;
  IF FileExists(FILENAME) = FALSE THEN
     BEGIN
     FILE_CREATE(FILENAME);
     RESULT:= FALSE;
     END;
  IF FileExists(FILENAME) = TRUE  THEN
     BEGIN
     AssignFile(TF,FILENAME);
     Append(TF);
     Writeln(TF,TITLE +'~'+CHR(1)+CHR(2)+CHR(3)+'~'+ TXT);
     CloseFile(TF);
     RESULT:= TRUE;
     END;
END;


//写入文件单行
FUNCTION FILE_WRITELN_REC(FILENAME,TITLE,TXT:STRING):STRING;
VAR TF1, TF2   : TEXTFILE;
    STR :STRING;
BEGIN
  IF FileExists(FILENAME) = TRUE  THEN
     BEGIN
     AssignFile(TF1,FILENAME);
     RESET(TF1);
     FILE_Rewrite('~LOG.TMP');
     AssignFile(TF2,'~LOG.TMP');
     Rewrite(TF2);
     WHILE NOT EOF(TF1) DO
       BEGIN
       Readln (TF1,STR);
       Writeln(TF2,STR);
       END;
     CloseFile(TF1);
     CloseFile(TF2);

     AssignFile(TF1,FILENAME);
     Rewrite(TF1);
     AssignFile(TF2,'~LOG.TMP');
     Reset(TF2);
     WHILE NOT EOF(TF2) DO
       BEGIN
       READLN(TF2,STR);
       IF TITLE = COPY(STR,1,POS('~'+CHR(1)+CHR(2)+CHR(3)+'~',STR)-1) THEN
          BEGIN
          Writeln(TF1,TITLE+'~'+CHR(1)+CHR(2)+CHR(3)+'~'+TXT);
          Break;
          END;
       END;
     CloseFile(TF1);
     CloseFile(TF2);
     END;
END;



//读出文件单行
FUNCTION FILE_READLN_REC(FILENAME,TITLE:STRING):STRING;
VAR TF  :TEXTFILE;
    STR :STRING;
BEGIN
  IF FileExists(FILENAME) = TRUE  THEN
     BEGIN
     AssignFile(TF,FILENAME);
     Reset(TF);
     WHILE NOT EOF(TF) DO
       BEGIN
       READLN(TF,STR);
       IF TITLE = COPY(STR,1,POS('~'+CHR(1)+CHR(2)+CHR(3)+'~',STR)-1) THEN
          BEGIN
          RESULT := TRIM(COPY(STR,POS('~'+CHR(1)+CHR(2)+CHR(3)+'~',STR)+5,100 ) );
          Break;
          END;
       END;
     CloseFile(TF);
     END;
END;


// TEXT读出文件 行数
FUNCTION TEXTFILE_RECCNT(FILENAME:STRING):INTEGER;
VAR TF  :TEXTFILE; STR: STRING;   I :INTEGER;
BEGIN
  I := 0;
  IF FileExists(FILENAME) = TRUE  THEN
     BEGIN
     AssignFile(TF,FILENAME);
     Reset(TF);
     WHILE NOT EOF(TF) DO
       BEGIN
       Readln(TF,STR);
       INC(I);
       END;
     CloseFile(TF);
     END;
  RESULT := I;
END;
// 文件相关功能 ================================================================











//copy 由右至左
FUNCTION Copy_R(S: STRING; Index, Count: INTEGER): STRING;
BEGIN
COPY_R := COPY(S, LENGTH(S) - COUNT + 1 - (INDEX-1) , COUNT);
END;

//产生空白
FUNCTION SPACE(Count: INTEGER): STRING;
VAR I :INTEGER;
    S , RETURN_S :STRING;
BEGIN
S := ' ';  RETURN_S := '';
for I := 1 to COUNT do RETURN_S := RETURN_S + S;

SPACE := RETURN_S ;
END;

{ 字符串复制  }
FUNCTION REPLICATE(VSTR1:STRING;VLEN:SMALLINT):STRING;
VAR VI:INTEGER ;
    VSTR2:STRING;
BEGIN
  VSTR2:='';
  FOR VI:=1 TO VLEN DO
    VSTR2:=VSTR2+VSTR1;
  REPLICATE:=VSTR2;
END; {REPLICATE}



{ 字符串填满  }
FUNCTION FILL_STR(FILL_STR, STR, KIND:STRING; TOTAL_LENGTH:INTEGER):STRING;
VAR T_STR:STRING;
    L_LENGTH, R_LENGTH :INTEGER;
BEGIN

IF KIND = 'L' THEN
   BEGIN
   T_STR := REPLICATE( FILL_STR,TOTAL_LENGTH-LENGTH(STR) ) + STR;
   IF (LENGTH(T_STR)>TOTAL_LENGTH) THEN T_STR := COPY_R(T_STR,1,TOTAL_LENGTH);
   END ELSE
IF KIND = 'R' THEN
   BEGIN
   T_STR := STR + REPLICATE( FILL_STR,TOTAL_LENGTH-LENGTH(STR) );
   IF (LENGTH(T_STR)>TOTAL_LENGTH) THEN T_STR := COPY(T_STR,1,TOTAL_LENGTH);
   END;
IF KIND = 'C' THEN
   BEGIN
   L_LENGTH := (TOTAL_LENGTH - LENGTH(STR)) DIV 2;
   R_LENGTH := TOTAL_LENGTH - L_LENGTH - LENGTH(STR);
   T_STR := REPLICATE( FILL_STR,R_LENGTH) + STR + REPLICATE( FILL_STR,R_LENGTH);
   IF (LENGTH(T_STR)>TOTAL_LENGTH) THEN T_STR := COPY(T_STR,1,TOTAL_LENGTH);
   END;


RESULT := T_STR;
END;


{ 字符串累加  }
FUNCTION STR_INC(FILL_STR, STR:STRING; T_START, T_END, T_CNT:INTEGER):STRING;
VAR L_STR, M_STR, R_STR :STRING;
    TOTAL_LENGTH, M_LENGTH :INTEGER;
BEGIN
RESULT := '';

IF STRTOINTDEF(COPY(STR,T_START,T_END),-1) < 0 THEN EXIT;

TOTAL_LENGTH := LENGTH(STR);
L_STR := COPY(STR,1,T_START-1);
M_STR := COPY(STR,T_START,T_END-T_START+1);
R_STR := COPY(STR,T_END+1,TOTAL_LENGTH-T_END);
M_LENGTH := LENGTH(M_STR);

M_STR := INTTOSTR(STRTOINTDEF(M_STR,0) + T_CNT);
M_STR := REPLICATE(FILL_STR,M_LENGTH - LENGTH(M_STR) ) + M_STR;

RESULT := L_STR+M_STR+R_STR;
END;

{ 字符串转浮点  }
FUNCTION STRTOFLOATDEF(STR:STRING;FDEFAULT:REAL):REAL;
BEGIN
IF CHECK_FLOATINT(STR) = TRUE THEN
   BEGIN
   RESULT := STRTOFLOAT(TRIM(STR));
   END ELSE BEGIN
   RESULT := FDEFAULT;
   END;
END;

{ 字符串替换  }
FUNCTION STR_REPLACE(STR, SUBSTR1,SUBSTR2:STRING):STRING;
VAR A, B:STRING;
BEGIN
WHILE POS(SUBSTR1,STR) > 0 DO
   BEGIN
   A := COPY(STR,1, POS(SUBSTR1,STR)-1 );
   B := COPY(STR,POS(SUBSTR1,STR)+LENGTH(SUBSTR1), LENGTH(STR) );
   STR := A + SUBSTR2 + B;
   END;

RESULT := STR;
END;

{ 字符串插入  }
FUNCTION STR_INSERT(STR, S1, S2:STRING; FB:BOOLEAN):STRING;
VAR A, B, T_RETURN:STRING;
BEGIN

IF POS(S1,STR) <= 0 THEN
   BEGIN
   IF FB = TRUE  THEN RESULT := S2  + STR;
   IF FB = FALSE THEN RESULT := STR + S2;
   END ELSE BEGIN
   A := COPY(STR,1, POS(S1,STR)-1 );
   B := COPY(STR,POS(S1,STR)+LENGTH(S1), LENGTH(STR) );
   IF FB = TRUE  THEN
      BEGIN
      RESULT := A + S2 + S1 + B;
      END;
   IF FB = FALSE THEN
      BEGIN
      RESULT := A + S1 + S2 + B;
      END;
   END;

END;


{ 数据字符串找寻  }
FUNCTION STR_DB_FIELDBYNO(STR, RAIL:STRING;FIELD_NO:INTEGER):STRING;
VAR T, T_RETURN:STRING;
    I : INTEGER;
BEGIN

FOR I := 1 TO FIELD_NO DO
    BEGIN
    T   := COPY(STR,1,POS(RAIL,STR)-1);
    IF POS(RAIL,STR) <= 0 THEN T_RETURN := STR
                          ELSE T_RETURN := T;
    STR := COPY(STR,POS(RAIL,STR)+1,LENGTH(STR)-POS(RAIL,STR));
    END;

RESULT := T_RETURN;
END;

{ 删除数据字符串  }
FUNCTION TRIM_STR(STR, TRIMSTR:STRING):STRING;
BEGIN
WHILE COPY(STR,1,1) = TRIMSTR DO  STR := COPY(STR,2,LENGTH(STR)-1);
RESULT := STR;
END;

{ 整数 转 字符串 再补零 }
FUNCTION INTTOSTR_REP(TINT,REP:INTEGER):STRING;
VAR S:STRING;
BEGIN
S := INTTOSTR(TINT);
RESULT := REPLICATE('0',REP-LENGTH(S) ) + S;
END;

{ BOOLEAN TRUE FALSE 转 01 }
FUNCTION BOOLEANTOSTR(TB : BOOLEAN):STRING;
BEGIN
RESULT := '0';
IF TB= TRUE THEN RESULT := '1' ELSE RESULT := '0';
END;


{ 检查是否为整数 }
FUNCTION CHECK_INT(T_STR:STRING):BOOLEAN;
BEGIN
RESULT := FALSE;
IF POS('-',T_STR) <= 0 THEN
   BEGIN
   IF (STRTOINTDEF(T_STR,-1) >= 0) THEN RESULT := TRUE;
   END ELSE BEGIN
   IF (STRTOINTDEF(COPY(T_STR,2,LENGTH(T_STR)),-1) >= 0) THEN RESULT := TRUE;
   END;
END;

{ 检查是否为浮点数 }
FUNCTION CHECK_FLOAT(T_STR:STRING):BOOLEAN;
VAR T_A,T_B:STRING;
BEGIN
T_A   := TRIM(COPY(T_STR,1,POS('.',T_STR)-1)  );
T_B   := TRIM(COPY(T_STR,POS('.',T_STR)+1,LENGTH(T_STR))  );
IF (STRTOINTDEF(T_A,-1) >= 0) AND
   (STRTOINTDEF(T_B,-1) >= 0) THEN
   RESULT := TRUE ELSE
   RESULT := FALSE;
END;

{ 检查是否为浮点数 和 整数}
FUNCTION CHECK_FLOATINT(T_STR:STRING):BOOLEAN;
VAR T_A,T_B:STRING;
BEGIN
IF POS('.',T_STR) >0 THEN
   BEGIN
   T_A   := TRIM(COPY(T_STR,1,POS('.',T_STR)-1)  );
   T_B   := TRIM(COPY(T_STR,POS('.',T_STR)+1,LENGTH(T_STR))  );
   IF (STRTOINTDEF(T_A,-99999999) >= -99999998) AND
      (STRTOINTDEF(T_B,-99999999) >= -99999998) THEN
      RESULT := TRUE ELSE RESULT := FALSE;
   END ELSE BEGIN
   IF (STRTOINTDEF(T_STR,-99999999) >= -99999998) THEN
      RESULT := TRUE ELSE RESULT := FALSE;
   END;
END;

{ 取 浮点数 , 小数点位数 }
FUNCTION FLOAT_LENGTH(T_STR:STRING;T_LENGTH:INTEGER):STRING;
VAR T_A,T_B:STRING;
BEGIN
IF POS('.',T_STR) > 0 THEN
   BEGIN
   IF T_LENGTH <= 0 THEN  RESULT := TRIM(COPY(T_STR,1,POS('.',T_STR)-1)  );
   IF T_LENGTH >  0 THEN
      BEGIN
      T_A   := TRIM(COPY(T_STR,1,POS('.',T_STR)-1)  );
      T_B   := TRIM(COPY(T_STR,POS('.',T_STR)+1,T_LENGTH)  );
      IF (T_A =  '') AND (T_B =  '') THEN RESULT := '0' +'.'+    REPLICATE('0',T_LENGTH);
      IF (T_A <> '') AND (T_B =  '') THEN RESULT := T_A +'.'+    REPLICATE('0',T_LENGTH);
      IF (T_A =  '') AND (T_B <> '') THEN RESULT := '0' +'.'+T_B+REPLICATE('0',T_LENGTH-LENGTH(T_B));
      IF (T_A <> '') AND (T_B <> '') THEN RESULT := T_A +'.'+T_B+REPLICATE('0',T_LENGTH-LENGTH(T_B));
      END;
   END ELSE
   BEGIN
   IF T_LENGTH <= 0 THEN RESULT := T_STR;
   IF T_LENGTH >  0 THEN RESULT := T_STR +'.'+ REPLICATE('0',T_LENGTH);
   END;

END;

{ 浮点数 转 整数 }
FUNCTION FLOATTOINT(T_FLOAT:REAL):INTEGER;
VAR A,B : INTEGER;
    STR : STRING;
BEGIN
A := 0; B := 0;
STR := FLOATTOSTR(T_FLOAT);

IF POS('.',STR) >  0 THEN           //有小数点
   BEGIN
   A := STRTOINT(COPY(STR,1,POS('.',STR)-1));
   B := STRTOINT(COPY(STR,POS('.',STR)+1,2));
   IF A >=0 THEN IF B >=5 THEN A := A + 1;
   IF A < 0 THEN IF B >=5 THEN A := A - 1;
//   T := COPY(T,1,POS('.',T)-1)
   END ELSE BEGIN                   //无小数点
   A := STRTOINT(STR);
   END;

RESULT := A;
END;



{ 浮点数 转 整数 PS: 无条件小数第一位进位}
FUNCTION FLOATTOINT_ROUND(T_FLOAT:REAL):INTEGER;
VAR A,B : INTEGER;
    STR : STRING;
BEGIN
A := 0; B := 0;
STR := FLOATTOSTR(T_FLOAT);

IF POS('.',STR) >  0 THEN           //有小数点
   BEGIN
   A := STRTOINT(COPY(STR,1,POS('.',STR)-1));
   B := STRTOINT(COPY(STR,POS('.',STR)+1,2));
   IF A >=0 THEN IF B >=1 THEN A := A + 1;
   IF A < 0 THEN IF B >=1 THEN A := A - 1;
//   T := COPY(T,1,POS('.',T)-1)
   END ELSE BEGIN                   //无小数点
   A := STRTOINT(STR);
   END;

RESULT := A;
END;




{ 整数 个位数 四舍五入  }
FUNCTION ROUND_1(T_INT:INTEGER):INTEGER;
VAR T, T1, T2 : STRING;
BEGIN
RESULT := 0;
T  := INTTOSTR(T_INT);
IF T_INT >= 0 THEN
   BEGIN
   IF LENGTH(T) =0 THEN RESULT := 0;
   IF LENGTH(T) =1 THEN
      BEGIN
      IF T_INT >=5  THEN RESULT :=  10;
      IF T_INT <=4  THEN RESULT :=   0;
      END;
   IF LENGTH(T) >1 THEN
      BEGIN
      T1 := COPY_R(T,1,1);
      T2 := COPY(T,1,LENGTH(T)-1);
   //   SHOWMESSAGE(T1+'='+T2);
      IF STRTOINT(T1) >= 5 THEN RESULT := (STRTOINT(T2)+1)*10;
      IF STRTOINT(T1) <= 4 THEN RESULT := (STRTOINT(T2)  )*10;
      END;
END ELSE BEGIN
   IF LENGTH(T) =2 THEN
      BEGIN
      IF T_INT <=-5  THEN RESULT := -10;
      IF T_INT >=-4  THEN RESULT :=   0;
      END;
   IF LENGTH(T) >2 THEN
      BEGIN
      T1 := COPY_R(T,1,1);
      T2 := COPY(T,1,LENGTH(T)-1);
   //   SHOWMESSAGE(T1+'='+T2);
      IF STRTOINT(T1) >= 5 THEN RESULT := (STRTOINT(T2)-1)*10;
      IF STRTOINT(T1) <= 4 THEN RESULT := (STRTOINT(T2)  )*10;
      END;
{   IF LENGTH(T) <-1 THEN
      BEGIN
      T1 := COPY_R(T,1,1);
      T2 := COPY(T,1,LENGTH(T)-1);
      IF STRTOINT(T1) <= -5 THEN RESULT := (STRTOINT(T2)+1)*10;
      IF STRTOINT(T1) >= -4 THEN RESULT := (STRTOINT(T2)  )*10;
      END;
}      
END;


END;



{ 整数 次方 }
FUNCTION INT_CUBE(T_INT,T_CUBE:INTEGER):INTEGER;
VAR R, I : INTEGER;
BEGIN
R := T_INT;
FOR I := 1 TO T_CUBE-1 DO R := R * T_INT;
IF T_CUBE >=1 THEN RESULT := R ELSE RESULT := 1;
END;

{ 16 进位 转 整数  }
FUNCTION HEXTOINT(THEX:STRING):INTEGER;
VAR TLEN, TINT, T1, I : INTEGER;
    TX: STRING;
BEGIN
TLEN := LENGTH(THEX);
TINT := 0;

FOR I := 1 TO TLEN DO
  BEGIN
  TX := COPY_R(THEX,I,1);
                   T1 := 0;
  IF TX = '0' THEN T1 := 0;
  IF TX = '1' THEN T1 := 1;
  IF TX = '2' THEN T1 := 2;
  IF TX = '3' THEN T1 := 3;
  IF TX = '4' THEN T1 := 4;
  IF TX = '5' THEN T1 := 5;
  IF TX = '6' THEN T1 := 6;
  IF TX = '7' THEN T1 := 7;
  IF TX = '8' THEN T1 := 8;
  IF TX = '9' THEN T1 := 9;
  IF TX = 'A' THEN T1 :=10;
  IF TX = 'B' THEN T1 :=11;
  IF TX = 'C' THEN T1 :=12;
  IF TX = 'D' THEN T1 :=13;
  IF TX = 'E' THEN T1 :=14;
  IF TX = 'F' THEN T1 :=15;
  TINT := TINT + (  T1 *  (  INT_CUBE(16,(I-1))  ));
  END;

RESULT := TINT;
END;





procedure Delay(n: INTEGER);
VAR     start: LongInt;
BEGIN
        start := GetTickCount;
        repeat Application.ProcessMessages;
        until (GetTickCount - start) >= n;
END;

FUNCTION EXCHANGE_CAL(T_EXCHG:STRING;T_LENGTH:INTEGER):STRING;
VAR T1, T2: STRING;
BEGIN
T1 := TRIM(COPY(T_EXCHG,1                 ,POS(':',T_EXCHG)-1)  );
T2 := TRIM(COPY(T_EXCHG,POS(':',T_EXCHG)+1, 10)                 );

IF ( (CHECK_FLOAT(T1) = TRUE) AND (CHECK_FLOAT(T2) = TRUE) ) OR
   ( (CHECK_FLOAT(T1) = TRUE) AND (CHECK_INT  (T2) = TRUE) ) OR
   ( (CHECK_INT  (T1) = TRUE) AND (CHECK_FLOAT(T2) = TRUE) ) OR
   ( (CHECK_INT  (T1) = TRUE) AND (CHECK_INT  (T2) = TRUE) ) THEN
   BEGIN                      //台币  / 外币
   RESULT := FLOAT_LENGTH( FLOATTOSTR( STRTOFLOAT(T2) / STRTOFLOAT(T1) ),T_LENGTH );
   END ELSE BEGIN
   RESULT := '1';
   END;
END;





//打印机 输出入 ================================================================
procedure Out32(PortAddress:smallint;Value:smallint);stdcall;export;
VAR ByteValue:Byte;
BEGIN
  ByteValue:=Byte(Value);
  asm
     push dx
     mov dx,PortAddress
     mov al, ByteValue
     out dx,al
     pop dx
  END;
END;

FUNCTION Inp32(PortAddress:smallint):smallint;stdcall;export;
VAR ByteValue:byte;
BEGIN
  asm
      push dx
      mov dx, PortAddress
      //////////////in al,dx
      mov ByteValue,al
      pop dx
  END;
  Inp32:=smallint(ByteValue) and $00FF;
END;

FUNCTION COMPORT_OUT(PortNAME,EXPRESS:STRING):BOOLEAN;
VAR TF :TEXTFILE;
BEGIN
  RESULT := FALSE;
  IF TEST_OPEN_FILE(PortNAME) = TRUE THEN
     BEGIN
     TRY
       AssignFile(TF,PortNAME);   Rewrite(TF);
       WRITE(TF,EXPRESS);    CloseFile(TF);
       RESULT := TRUE;
     EXCEPT
       SHOWMESSAGE('无法送出资料!');
       RESULT := FALSE;
     END;
     END;
END;

FUNCTION  COMPORT_OUTLN(PortNAME,EXPRESS:STRING):BOOLEAN;
VAR TF :TEXTFILE;
BEGIN
  RESULT := FALSE;
  IF TEST_OPEN_FILE(PortNAME) = TRUE THEN
     BEGIN
     TRY
       AssignFile(TF,PortNAME);   Rewrite(TF);
       Writeln(TF,EXPRESS);    CloseFile(TF);
       RESULT := TRUE;
     EXCEPT
       SHOWMESSAGE('无法送出资料!');
       RESULT := FALSE;
     END;
     END;
END;
//打印机 输出入 ================================================================









// CPU ID ==================================================
FUNCTION IsCPUID_Available : BOOLEAN; register;
asm
  PUSHFD		{direct access to flags no possible, only via stack}
  POP     EAX		{flags to EAX}
  MOV     EDX,EAX	{save current flags}
  XOR     EAX,ID_BIT	{not ID bit}
  PUSH    EAX		{onto stack}
  POPFD			{from stack to flags, WITH not ID bit}
  PUSHFD		{back to stack}
  POP     EAX		{get back to EAX}
  XOR     EAX,EDX	{check IF ID bit affected}
  JZ      @exit		{no, CPUID not availavle}
  MOV     AL,TRUE	{Result=TRUE}
  @exit:
END;

FUNCTION GetCPUID : TCPUID; assembler; register;
asm
  PUSH    EBX         {Save affected register}
  PUSH    EDI
  MOV     EDI,EAX     {@Resukt}
  MOV     EAX,1
  DW      $A20F       {CPUID Command}
  STOSD		      {CPUID[1]}
  MOV     EAX,EBX
  STOSD               {CPUID[2]}
  MOV     EAX,ECX
  STOSD               {CPUID[3]}
  MOV     EAX,EDX
  STOSD               {CPUID[4]}
  POP     EDI	      {Restore registers}
  POP     EBX
END;

FUNCTION GetCPUVendor : TVendor; assembler; register;
asm
  PUSH    EBX	      {Save affected register}
  PUSH    EDI
  MOV     EDI,EAX     {@Result (TVendor)}
  MOV     EAX,0
  DW      $A20F	      {CPUID Command}
  MOV     EAX,EBX
  XCHG	  EBX,ECX     {save ECX result}
  MOV	  ECX,4
@1:
  STOSB
  SHR     EAX,8
  LOOP    @1
  MOV     EAX,EDX
  MOV	  ECX,4
@2:
  STOSB
  SHR     EAX,8
  LOOP    @2
  MOV     EAX,EBX
  MOV	  ECX,4
@3:
  STOSB
  SHR     EAX,8
  LOOP    @3
  POP     EDI	     {Restore registers}
  POP     EBX
END;



FUNCTION EAN13_ENCODE(T_STR:STRING):STRING;
VAR S : ARRAY [2..13] OF INTEGER;
    ANSWER : STRING;
BEGIN
  T_STR := TRIM(T_STR);
  RESULT := '';

  //空白跳出
  IF LENGTH(T_STR) < 12 THEN EXIT;
  S[13] := STRTOINTDEF( T_STR[ 1] ,-1);
  S[12] := STRTOINTDEF( T_STR[ 2] ,-1);
  S[11] := STRTOINTDEF( T_STR[ 3] ,-1);
  S[10] := STRTOINTDEF( T_STR[ 4] ,-1);
  S[ 9] := STRTOINTDEF( T_STR[ 5] ,-1);
  S[ 8] := STRTOINTDEF( T_STR[ 6] ,-1);
  S[ 7] := STRTOINTDEF( T_STR[ 7] ,-1);
  S[ 6] := STRTOINTDEF( T_STR[ 8] ,-1);
  S[ 5] := STRTOINTDEF( T_STR[ 9] ,-1);
  S[ 4] := STRTOINTDEF( T_STR[10] ,-1);
  S[ 3] := STRTOINTDEF( T_STR[11] ,-1);
  S[ 2] := STRTOINTDEF( T_STR[12] ,-1);
  
  IF S[13] < 0 THEN EXIT;
  IF S[12] < 0 THEN EXIT;
  IF S[11] < 0 THEN EXIT;
  IF S[10] < 0 THEN EXIT;
  IF S[ 9] < 0 THEN EXIT;
  IF S[ 8] < 0 THEN EXIT;
  IF S[ 7] < 0 THEN EXIT;
  IF S[ 6] < 0 THEN EXIT;
  IF S[ 5] < 0 THEN EXIT;
  IF S[ 4] < 0 THEN EXIT;
  IF S[ 3] < 0 THEN EXIT;
  IF S[ 2] < 0 THEN EXIT;
  
  ANSWER := INTTOSTR( (S[2] + S[4] + S[6] + S[8] + S[10] + S[12])*3 +
                      S[3] + S[5] + S[7] + S[9] + S[11] + S[13] );
  ANSWER := INTTOSTR(10 - (STRTOINT(ANSWER)MOD 10) );
  
  RESULT := T_STR+COPY_R(ANSWER,1,1);
END;

FUNCTION EAN13_AUTOADD(T_STR:STRING):STRING;
BEGIN
  IF LENGTH(T_STR) < 13 THEN
     BEGIN
     T_STR := REPLICATE('0',12 - LENGTH(T_STR) ) + T_STR;
     T_STR := EAN13_ENCODE(T_STR);
     END;
  RESULT := T_STR;
END;




//发票类 =======================================================================
FUNCTION INVOICE_NO_CHECK(T_STR:STRING):BOOLEAN;
BEGIN
  RESULT  := FALSE;
  IF T_STR <> '' THEN
     BEGIN
     IF (LENGTH(T_STR)=10 ) THEN IF STRTOINTDEF(COPY(T_STR,3,8),-1) >= 0 THEN RESULT := TRUE;
     IF (LENGTH(T_STR)= 8 ) THEN IF STRTOINTDEF(T_STR,-1) >= 0           THEN RESULT := TRUE;
     END;
END;
//发票类 =======================================================================




//检查信用卡号
FUNCTION ValidateCreditCardNo(value: STRING; WARNING:BOOLEAN): BOOLEAN;
VAR idx, Sum, leng, Weight: INTEGER;
    Digital: array of INTEGER;
    DigitalNumberIsOdd: BOOLEAN;
BEGIN
  Result := FALSE;
  leng := length(value);
  IF leng=0 then EXIT;
  SetLength(Digital, leng);
  Sum := 0;

  IF Odd(leng) then DigitalNumberIsOdd := TRUE
               else DigitalNumberIsOdd := FALSE;

  for idx := 1 to leng do
  BEGIN
    Digital[idx - 1] := Ord(Value[idx]) - Ord('0');
    IF (Digital[idx - 1] > 9) or (Digital[idx - 1] < 0) then EXIT;
    IF (DigitalNumberIsOdd) then
      IF odd(idx) then Weight := 1
                  else Weight := 2
    else
      IF odd(idx) then Weight := 2
                  else Weight := 1;
    Digital[idx - 1] := Digital[idx - 1] * Weight;
    IF (Digital[idx - 1] > 9) then Digital[idx - 1] := Digital[idx - 1] - 9;
    Sum := Sum + Digital[idx - 1];
  END;

  IF (Sum mod 10 = 0) then Result := TRUE
                      else Result := FALSE;

  IF (WARNING = TRUE) AND (RESULT = FALSE) THEN SHOWMESSAGE('信用卡号码错误!');
END;


















//对象 储存相关信息值 INI FILE  ================================================
FUNCTION INI_SAVE_OBJECT(INIFILENAME, OBJECT_NAME :STRING; T_LEFT, T_TOP :INTEGER; T_TEXT:STRING):BOOLEAN;
VAR T : TINIFILE; //暂存对象
BEGIN
  TRY
    T := TINIFILE.Create(INIFILENAME);
    T.WriteINTEGER(OBJECT_NAME,'LEFT', T_LEFT);
    T.WriteINTEGER(OBJECT_NAME,'TOP' , T_TOP );
    T.WriteSTRING (OBJECT_NAME,'TEXT', T_TEXT);
    RESULT := TRUE;
  FINALLY   T.FREE;  END;
END;

//对象 储存相关信息值 INI FILE  ================================================
FUNCTION INI_SAVE_INT(INIFILENAME, OBJECT_NAME :STRING; T_INTEGER :INTEGER):BOOLEAN;
VAR T : TINIFILE; //暂存对象
BEGIN
  TRY
    T := TINIFILE.Create(INIFILENAME);
    T.WriteINTEGER(OBJECT_NAME,'INTEGER', T_INTEGER);
    RESULT := TRUE;
  FINALLY   T.FREE;  END;
END;

//对象 储存相关信息值 INI FILE  ================================================
FUNCTION INI_SAVE_STR(INIFILENAME, OBJECT_NAME :STRING; T_STR :STRING):BOOLEAN;
VAR T : TINIFILE; //暂存对象
BEGIN
  TRY
    T := TINIFILE.Create(INIFILENAME);
    T.WriteSTRING(OBJECT_NAME,'STRING', T_STR);
    RESULT := TRUE;
  FINALLY   T.FREE;  END;
END;

//对象 储存相关信息值 INI FILE  ================================================
FUNCTION INI_SAVE_STR2(INIFILENAME, OBJECT_NAME, OBJECT_KIND :STRING; T_STR :STRING):BOOLEAN;
VAR T : TINIFILE; //暂存对象
BEGIN
  TRY
    T := TINIFILE.Create(INIFILENAME);
    T.WriteSTRING(OBJECT_NAME,OBJECT_KIND, T_STR);
    RESULT := TRUE;
  FINALLY   T.FREE;  END;
END;

//对象 储存相关信息值 INI FILE  ================================================
FUNCTION INI_SAVE_BOOL(INIFILENAME, OBJECT_NAME :STRING; T_BOOL :BOOLEAN):BOOLEAN;
VAR T : TINIFILE; //暂存对象
BEGIN
  TRY
    T := TINIFILE.Create(INIFILENAME);
    T.WriteBool(OBJECT_NAME,'BOOL', T_BOOL);
    RESULT := TRUE;
  FINALLY   T.FREE;  END;
END;

//对象 取回相关信息值 INI FILE  ================================================
FUNCTION INI_LOAD_OBJECT(INIFILENAME, OBJECT_NAME, OBJECT_KIND, T_DEFAULT :STRING):STRING;
VAR T : TINIFILE; //暂存对象
BEGIN
  TRY
    T := TINIFILE.Create(INIFILENAME);
    RESULT := T.ReadSTRING(OBJECT_NAME,OBJECT_KIND, T_DEFAULT);
  FINALLY   T.FREE;  END;
END;

//对象 取回相关信息值 INI FILE  ================================================
FUNCTION INI_LOAD_INT(INIFILENAME, OBJECT_NAME :STRING; T_DEFAULT:INTEGER ):INTEGER;
VAR T : TINIFILE; //暂存对象
BEGIN
  TRY
    T := TINIFILE.Create(INIFILENAME);
    RESULT := T.ReadINTEGER(OBJECT_NAME,'INTEGER', T_DEFAULT);
  FINALLY   T.FREE;  END;
END;

//对象 取回相关信息值 INI FILE  ================================================
FUNCTION INI_LOAD_STR(INIFILENAME, OBJECT_NAME :STRING; T_DEFAULT:STRING  ):STRING;
VAR T : TINIFILE; //暂存对象
BEGIN
  TRY
    T := TINIFILE.Create(INIFILENAME);
    RESULT := T.ReadSTRING(OBJECT_NAME,'STRING', T_DEFAULT);
  FINALLY   T.FREE;  END;
END;

//对象 取回相关信息值 INI FILE  ================================================
FUNCTION INI_LOAD_STR2(INIFILENAME, OBJECT_NAME , OBJECT_KIND:STRING; T_DEFAULT:STRING  ):STRING;
VAR T : TINIFILE; //暂存对象
BEGIN
  TRY
    T := TINIFILE.Create(INIFILENAME);
    RESULT := T.ReadSTRING(OBJECT_NAME,OBJECT_KIND, T_DEFAULT);
  FINALLY   T.FREE;  END;
END;

//对象 取回相关信息值 INI FILE  ================================================
FUNCTION INI_LOAD_BOOL(INIFILENAME, OBJECT_NAME :STRING; T_DEFAULT:BOOLEAN  ):BOOLEAN;
VAR T : TINIFILE; //暂存对象
BEGIN
  TRY
    T := TINIFILE.Create(INIFILENAME);
    RESULT := T.ReadBool(OBJECT_NAME,'BOOL', T_DEFAULT);
  FINALLY   T.FREE;  END;
END;
// =============================================================================









FUNCTION GetAveCharSize(Canvas: TCanvas): TPoint;
var
  I: INTEGER;
  Buffer: array[0..51] of Char;
BEGIN
  for I := 0 to 25 do Buffer[I] := Chr(I + Ord('A'));
  for I := 0 to 25 do Buffer[I + 26] := Chr(I + Ord('a'));
  GetTextExtentPoint(Canvas.Handle, Buffer, 52, TSize(Result));
  Result.X := Result.X div 52;
END;




FUNCTION JInputQuery(const ACaption, APrompt: STRING;  VAR Value: STRING): BOOLEAN;
var
  Form: TForm;
  Prompt: TLabel;
  Edit: TEdit;
  DialogUnits: TPoint;
  ButtonTop, ButtonWidth, ButtonHeight: INTEGER;
BEGIN
  Result := FALSE;
  Form := TForm.Create(Application);
  WITH Form do
    try
      Canvas.Font := Font;
      FONT.SIZE   := 20;
      FONT.NAME   := 'Arial';
      DialogUnits := GetAveCharSize(Canvas);
      BorderStyle := bsDialog;
      Caption := ACaption;
      ClientWidth := MulDiv(180, DialogUnits.X, 4);
      ClientHeight := MulDiv(64, DialogUnits.Y, 8);
      Position := poScreenCenter;
      Prompt := TLabel.Create(Form);
      WITH Prompt do
      BEGIN
        Parent := Form;
        FONT.SIZE   := 46;
        AutoSize := TRUE;
        Left := MulDiv(8, DialogUnits.X, 4);
        Top := MulDiv(2, DialogUnits.Y, 72);
        Caption := APrompt;
      END;
      Edit := TEdit.Create(Form);
      WITH Edit do
      BEGIN
        Parent := Form;
        FONT.SIZE   := 46;
        Left := Prompt.Left;
        Top := MulDiv(19, DialogUnits.Y, 8);
        Width := MulDiv(164, DialogUnits.X, 4);
        MaxLength := 255;
        Text := Value;
        SelectAll;
      END;
      ButtonTop := MulDiv(41, DialogUnits.Y, 8);
      ButtonWidth := MulDiv(50, DialogUnits.X, 4);
      ButtonHeight := MulDiv(14, DialogUnits.Y, 8);
      WITH TButton.Create(Form) do
      BEGIN
        Parent := Form;
        Caption := ' 确定 OK ';
        ModalResult := mrOk;
        Default := TRUE;
        SetBounds(MulDiv(60, DialogUnits.X, 4), ButtonTop, ButtonWidth,  ButtonHeight);
        Top := MulDiv(45, DialogUnits.Y, 8);
      END;
{      WITH TButton.Create(Form) do
      BEGIN
        Parent := Form;
        Caption := 'SMsgDlgCancel;
        ModalResult := mrCancel;
        Cancel := TRUE;
        SetBounds(MulDiv(92, DialogUnits.X, 4), ButtonTop, ButtonWidth,
          ButtonHeight);
      END;
}      IF ShowModal = mrOk then
      BEGIN
        Value := Edit.Text;
        Result := TRUE;
      END;
    finally
      Form.FREE;
    END;
END;

FUNCTION JInputBox(const ACaption, APrompt, ADefault: STRING): STRING;
BEGIN
  Result := ADefault;
  JInputQuery(ACaption, APrompt, Result);
END;

FUNCTION JMSGFORM(const ACaption, ADefault: STRING;T_FONTSIZE:INTEGER): BOOLEAN;
var
  Form: TForm;
  MEMO  : TMEMO;
  DialogUnits: TPoint;
  ButtonTop, ButtonWidth, ButtonHeight: INTEGER;
BEGIN
  Result := FALSE;
  Form := TForm.Create(Application);
  WITH Form do
    try
      Canvas.Font := Font;
      FONT.SIZE   := 16;
      FONT.NAME   := 'Arial';
      DialogUnits := GetAveCharSize(Canvas);
      BorderStyle := bsDialog;
      Caption := ACaption;
      ClientWidth  := MulDiv(180, DialogUnits.X, 4);
      ClientHeight := MulDiv(160, DialogUnits.Y, 8);
      Position := poScreenCenter;
      MEMO := TMEMO.Create(Form);
      WITH MEMO do
      BEGIN
        Parent := Form;
        SCROLLBARS := SSBOTH;
        COLOR := CLBLACK;
        FONT.COLOR := CLWHITE;
        FONT.Name  := 'Courier New';
        FONT.SIZE   := T_FONTSIZE;
        Left   := 2;  Top := 2;
        Width  := FORM.Width  -11;
        HEIGHT := FORM.HEIGHT -70;
        Lines.Text := ADefault;
      END;
      ButtonTop    := MulDiv(41, DialogUnits.Y, 8);
      ButtonWidth  := MulDiv(50, DialogUnits.X, 4);
      ButtonHeight := MulDiv(14, DialogUnits.Y, 8);
      WITH TButton.Create(Form) do
      BEGIN
        Parent := Form;
        Caption := ' 确定 OK ';
        ModalResult := mrOk;
        Default := TRUE;
        Width  := 200;     HEIGHT := 40;
        Top := FORM.Height - HEIGHT - 24;
        LEFT := 50;
      END;
      WITH TButton.Create(Form) do
      BEGIN
        Parent := Form;
        Caption := ' 取消 Cancel ';
        ModalResult := mrCancel;
        Cancel := TRUE;
        Width  := 200;     HEIGHT := 40;
        Top := FORM.Height - HEIGHT - 24;
        LEFT := FORM.WIDTH - 50 - WIDTH;
      END;
    IF ShowModal = mrOk then Result := TRUE;
    finally
      Form.FREE;
    END;

END;



FUNCTION JSHOWMESSAGE(const ACaption, APROMPT: STRING): BOOLEAN;
VAR Form: TForm;
    Prompt: TLabel;
    DialogUnits: TPoint;
    ButtonTop, ButtonWidth, ButtonHeight: INTEGER;
BEGIN
  Result := FALSE;
  Form := TForm.Create(Application);
  WITH Form do
    try
      Canvas.Font := Font;
      FONT.SIZE   := 20;
      FONT.NAME   := 'Arial';
      DialogUnits := GetAveCharSize(Canvas);
      BorderStyle := bsDialog;
      Caption := ACaption;
      ClientWidth := MulDiv(180, DialogUnits.X, 4);
      ClientHeight := MulDiv(32, DialogUnits.Y, 8);
      Position := poScreenCenter;
      Prompt := TLabel.Create(Form);
      WITH Prompt do
      BEGIN
        Parent := Form;
        FONT.SIZE   := 32;
        AutoSize := TRUE;
        Left := MulDiv(6, DialogUnits.X, 4);
        Top := MulDiv(12, DialogUnits.Y, 72);
        Caption := APROMPT;
      END;
      ButtonTop := MulDiv(10, DialogUnits.Y, 8);
      ButtonWidth := MulDiv(50, DialogUnits.X, 4);
      ButtonHeight := MulDiv(14, DialogUnits.Y, 8);
      WITH TButton.Create(Form) do
      BEGIN
        Parent := Form;
        Caption := ' 确定 OK ';
        ModalResult := mrOk;
        Default := TRUE;
        SetBounds(MulDiv(60, DialogUnits.X, 4), ButtonTop, ButtonWidth,  ButtonHeight);
        Top := MulDiv(16, DialogUnits.Y, 8);
      END;
      IF ShowModal = mrOk then Result := TRUE;
    finally
      Form.FREE;
    END;

END;










end.

