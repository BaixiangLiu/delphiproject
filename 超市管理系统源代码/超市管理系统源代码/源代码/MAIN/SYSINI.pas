unit SYSINI;

interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ToolWin, ComCtrls, ExtCtrls, StdCtrls, DBCtrls, DB, DBTables;

//公共变量声明初值
procedure VAR_DECLARE_INI;
procedure VAR_DECLARE_ODBC;


procedure LOAD_FRONT_TABLE_VARIBLE;  // 读取前台变量
procedure SAVE_FRONT_TABLE_VARIBLE;  // 存储前台变量


var

   T_STR : STRING;  //暂存变量
   SystemDate: TSystemTime;     //系统日期

   
   //系统变量
   _SYS_PATH      : STRING; //系统目录
   _SYS_PATH_DB   : STRING; //系统数据库 完整路径
   _SYS_PATH_DATA : STRING; //系统 DATA 目录
   _SYS_PATH_INI  : STRING; //系统 INI 目录

   // 前台变量 ==================================================================
   FILEPATH_INVOICE    : STRING; // INI 发票文件路径
   FILEPATH_CLEVER     : STRING; // INI
   FILEPATH_DSP        : STRING; // INI
   FILEPATH_ARGOX      : STRING; // INI
   FILEPATH_COLLECT    : STRING; // INI
   FILEPATH_POSAKEY    : STRING; // INI
   FILEPATH_POSASINGLE : STRING; // INI 单品档

   _SYS_RBPST : STRING;      //预设仓库值
   _SYS_PAIDE : STRING;      //预设收款台值

   _SYS_LOGINED : BOOLEAN;  //是否已经登录
   _SYS_LOGO    : BOOLEAN;  //是否已显示过 LOGO


    //系统 USER 变量
   _SUPER_USER    : boolean;
   _SUPER_USER_ID : STRING;

   _USER_ID   : STRING;
   _USER_NAME : STRING;
   _USER_LOGINDATETIME  : TDATETIME;
//   _USER_MSG : STRING;

   _USER_CORP_RBPST : STRING;
   _USER_CORP_NAME  : STRING;
   _USER_CORP_NO    : STRING;
   _USER_CORP_TEL   : STRING;
   _USER_CORP_FAX   : STRING;
   _USER_CORP_ADDR  : STRING;
   _USER_CORP_EMAIL : STRING;
   _USER_CORP_WWW   : STRING;


    //硬件默认值
    _SYS_CFG_DBKIND : INTEGER;  // 数据库种类
    _SYS_CFG_BARPRN : INTEGER;  // 条形码机,预设机型

    //系统默认值
   _QRBGDS, _QRBMEM, _QRBMAD : STRING;  //标签路径文件名
   _CHG_BGENO, _CHG_BMENO, _CHG_BSENO, _CHG_BCENO, _CHG_BNENO : BOOLEAN; //可否改编号
   _ORI_BGENO, _ORI_BMENO, _ORI_BSENO, _ORI_BCENO, _ORI_BNENO : STRING;  //可否改编号

   //快速查询 - 显示详细资料
//   SHOW_BGDSN_PANEL : BOOLEAN;
//   SHOW_BMEMN_PANEL : BOOLEAN;
//   SHOW_BCSTN_PANEL : BOOLEAN;


   //按钮图形
   INS_TB,UPD_TB,DEL_TB,YES_TB,CAL_TB,
   SER_TB,PRN_TB,QUT_TB,SET_TB,PRE_TB,CLR_TB: TBitmap;

   //GRID图形
   True_bmp, False_bmp, Blank_bmp : TBitmap;


   //流动客分析资料
   ACUS_WANT_SHOW : BOOLEAN;
   ACUS_ASQA1,ACUS_ASQA2,ACUS_ASQA3,ACUS_ASQA4,ACUS_ASQA5 :STRING;
   ACUS_ASQB1,ACUS_ASQB2,ACUS_ASQB3,ACUS_ASQB4,ACUS_ASQB5 :STRING;





// 前台变量 ==================================================================

   _TB_PRACTICE_MODE : INTEGER; //练习模式

   _TB_AUTO_SHOWPOSA : BOOLEAN; //自动激活 前台程序
   _TB_AUTO_EAN13    : BOOLEAN; //13码数值自动补位
   _TB_ALL_CASHIN    : BOOLEAN; //全部使用现金结帐
   _TB_RE_INPUT      : BOOLEAN; //重复刷是否自动加
   _TB_CLEAR_INPUT   : BOOLEAN; //输入后是否清除输入格
   _TB_MINUSP        : BOOLEAN; //总计负数可结帐
   _TB_LAST_SUB      : BOOLEAN; //总计可以去尾数  //去尾数另外打印
   _TB_LAST_PRICE    : REAL;    //总计 - 去尾数金额


   _TB_AUTO_ROUND    : BOOLEAN; // 个位数四舍五入
   _TB_SHOW_FUNCTION : BOOLEAN; // 显示功能键
   _TB_SHOW_BGCOS    : BOOLEAN; // 显示成本价
   _TB_SHOW_BGQTS    : BOOLEAN; // 显示安存量
   _TB_SHOW_BGQTN    : BOOLEAN; // 显示库存量
   _TB_SHOW_BGDSN    : BOOLEAN; // 显示产品详细资料
   _TB_SHOW_BMEMN    : BOOLEAN; // 显示会员详细资料
   _TB_SHOW_RUNLG    : BOOLEAN; // 显示跑马灯
   _TB_SHOW_WARN     : BOOLEAN; // 刷无资料时要警告

   _TB_CHECK_POSM    : BOOLEAN; // 检查特价品资料
   _TB_CHECK_POSN    : BOOLEAN; // 检查组合销售资料
   _TB_CHECK_POSO    : BOOLEAN; // 检查买二送一资料
   _TB_CHECK_BGQTN   : BOOLEAN; // 检查库存量资料
   _TB_CHECK_GIFT_NO : BOOLEAN; // 检查礼券是否重复


   _TB_SET_ACUS      : BOOLEAN; // 是否输入流动客户分析
   _TB_SET_INPUT_INV : BOOLEAN; // 是否必须输入发票号码
   _TB_SET_LOWCOS    : BOOLEAN; // 是否售价可低于预设成本
   _TB_SET_BMBPO     : INTEGER; // 会员点数
   _TB_SET_CHG_PRICE : BOOLEAN; // 是否可直接更改售价
   _TB_SET_WIN_PRICE : BOOLEAN; // 开新窗口更改售价


   _TB_PAENO        : STRING;     //此次结帐编号
   _TB_NUMBER       : STRING;     //收款台编号
   _TB_INSERT_DATE  : TDATETIME;  //此笔日期
   _TB_ESC_CNT      : INTEGER;    //按ESC的次数

   //收款员资料======================================
   _TB_USER_NUMBER : STRING;  //收款员编号
   _TB_USER_NAME   : STRING;  //收款员姓名
   _TB_USER_MSG    : STRING;  //个人信息

   _TB_PACIV        : string;  //统一编号
   _TB_BACK_MODE    : BOOLEAN; //退货模式
   _TB_FORCUS_ROW   : INTEGER; //所在列数
   _TB_RUNLG_TMECNT : INTEGER; //跑马灯计数器
   _TB_RUNLG_PICCNT : INTEGER; //按 跑马灯 PIC计数

   //暂存资料======================================
   _TB_TMP_GRID     : BOOLEAN; //暂存区有东西
   _TB_TMP_BGENO : STRING; // 快速选取的暂存变量
   _TB_TMP_BMENO : STRING; // 快速选取的暂存变量

   _TB_TOTAL_QTY      : Integer;  //总卖出个数
   _TB_TOTAL_REC      : Integer;  //总卖出笔数
   _TB_TOTAL_PRICE    : REAL;     //总卖出金额 - 全部应付总计
   _TB_TOTAL_CASH     : REAL;     //应付现金   - 只须付现部份
   _TB_TOTAL_PAY      : REAL;     //客人付的现金
   _TB_TOTAL_EXCHANGE : REAL;     //要找的零钱
   _TB_TOTAL_NOPAY    : REAL;     //不用总卖出金额     (信用卡+礼券+折扣)

   _TB_DISC_PERCENT : REAL;    //打折比例
   _TB_DISC_PRICE   : REAL;    //折扣金额
   _TB_DISC_ALL     : BOOLEAN; //每笔都打折

   //信用卡资料======================================
   _TB_CARD_PACNO   : string;  //信用卡号
   _TB_CARD_PACDT   : string;  //信用卡到期日
   _TB_CARD_PACNA   : REAL;    //信用卡金额
   _TB_CARD_PACKD   : string;  //信用卡类别

   //礼券资料======================================
   _TB_GIFT_PGCNO   : string;  //礼券号
   _TB_GIFT_PGCDT   : string;  //礼券到期日
   _TB_GIFT_PGCNA   : REAL;    //礼券金额
   _TB_GIFT_PGCKD   : string;  //礼券类别
   _TB_GIFT_PRICE   : REAL;    //礼券总金额


   //会员资料======================================
   _TB_BMEM_BMENO   : STRING;   //会员姓名
   _TB_BMEM_BMNAM   : STRING;   //会员姓名
   _TB_BMEM_BMLVE   : INTEGER;  //会员等级
   _TB_BMEM_BMBYR   : INTEGER;  //年消费等级
   _TB_BMEM_BMBTO   : INTEGER;  //总消费等级
   _TB_BMEM_BMCRD   : STRING;   //发卡日
   _TB_BMEM_BMDAT   : STRING;   //入会日
   _TB_BMEM_FOUND   : BOOLEAN;  //找到会员

   //产品资料======================================
   _TB_BG_BGENO : string;
   _TB_BG_BGNAM : string;
   _TB_BG_BGKIN : STRING;  //产品分类
   _TB_BG_BGQTS : Integer; //安全量
   _TB_BG_BGQTN : Integer; //库存量
   _TB_BG_BGCOS : REAL;    //成本价
   _TB_BG_BGCNT : Integer; //数量
   _TB_BG_BGPST : REAL;    //标准价格
   _TB_BG_BGPVP : REAL;    //贵宾价格
   _TB_BG_BGPMM : REAL;    //会员价格
   _TB_BG_BGCST : REAL;    //特惠价格1
   _TB_BG_BGOTH : REAL;    //特惠价格2
   _TB_BG_FOUND : Boolean; //找到产品
   _TB_BG_CNT    : Integer;//此笔数量
   _TB_BG_SPRICE : REAL;   //此笔单价
   _TB_BG_TPRICE : REAL;   //此笔单价
   
   SHOW_BGDSN_PANEL : Boolean;
   SHOW_BMEMN_PANEL : Boolean;

    //其它功能
   _TB_PRN_ALWAYSON  : BOOLEAN; //强迫一定要打印发票      ========== SET
   _TB_PRN_PRINTING  : BOOLEAN; //是否打印发票            ========== SET
   _TB_PRN_CASHBOX   : BOOLEAN; //是否自动开钱箱        ========== SET

   _TB_INV_NO       : string;  //发票号码
   _TB_INV_PAGE     : INTEGER; //发票页
   _TB_INV_CNT      : INTEGER; //发票剩张数
   _TB_INV_SUBTOTAL : INTEGER; //发票 单张小计

   _TB_INV_SET_IV_TS1 : INTEGER; //发票 TITLE 空行
   _TB_INV_SET_IV_TS2 : INTEGER; //发票 TITLE 空行
   _TB_INV_SET_IV_TC1 : STRING;  //发票 TITLE 1
   _TB_INV_SET_IV_TC2 : STRING;  //发票 TITLE 2

   _TB_INV_SET_IV_CC1 : INTEGER; //发票 内容 1
   _TB_INV_SET_IV_CC2 : INTEGER; //发票 内容 2
   _TB_INV_SET_IV_CC3 : INTEGER; //发票 内容 3
   _TB_INV_SET_IV_CC4 : INTEGER; //发票 内容 4
   _TB_INV_SET_IV_CS1 : INTEGER; //发票 空格 1
   _TB_INV_SET_IV_CS2 : INTEGER; //发票 空格 2
   _TB_INV_SET_IV_CS3 : INTEGER; //发票 空格 3
   _TB_INV_SET_IV_CP1 : INTEGER; //发票 位数 1
   _TB_INV_SET_IV_CP2 : INTEGER; //发票 位数 2
   _TB_INV_SET_IV_CP3 : INTEGER; //发票 位数 3
   _TB_INV_SET_IV_CP4 : INTEGER; //发票 位数 4

   _TB_INV_SET_IV_EC1 : STRING;  //发票 结尾 1
   _TB_INV_SET_IV_EC2 : STRING;  //发票 结尾 2

   _TB_INV_SET_IV_RP1 : BOOLEAN; //打印应找金额
   _TB_INV_SET_IV_RP2 : BOOLEAN; //打印信用卡号
   _TB_INV_SET_IV_RP3 : BOOLEAN; //打印礼券明细
    //显示器数据
   _TB_DSP_CHANGED: BOOLEAN;
// 前台变量
implementation

uses INIFILES, FILECTRL,
     UN_UTL, DB_UTL;

procedure VAR_DECLARE_ODBC;
VAR T : Tinifile;     // LOG FILE
    INIFILENAME: STRING;
    PATHNAME_POS  : STRING;
    PATHNAME_IVTT : STRING;
    SERVER_KIND : STRING;
BEGIN
  // ODBC 自动设置
  INIFILENAME   := _SYS_PATH_INI + 'MAIN.INI';
  PATHNAME_POS  := ExtractFilePath(Application.EXEName)+'DATA\POS.MDB';
  PATHNAME_IVTT :=ExtractFilePath(Application.EXEName)+'DATA\IVTT.MDB';
  IF FileExists(INIFILENAME) = FALSE  THEN
     BEGIN
     FILE_CREATE(INIFILENAME);
     ShowMessage('数据库路径未指定!');
     PATHNAME_POS  := INPUTBOX('输入数据库路径POS' ,'POS路径' ,PATHNAME_POS);
     PATHNAME_IVTT := INPUTBOX('输入数据库路径IVTT','IVTT路径',PATHNAME_IVTT);

     T := Tinifile.Create(INIFILENAME);
     T.WRITEString('ODBC','SERVER','ACCESS');
     T.WRITEString('ODBC','PATH_NAME_POS' ,PATHNAME_POS);
     T.WRITEString('ODBC','PATH_NAME_IVTT',PATHNAME_IVTT);
     END ELSE BEGIN
     T := Tinifile.Create(INIFILENAME);
     SERVER_KIND := T.READString('ODBC','SERVER' ,'ACCESS');
     // MS ACCESS DRIVER
     IF SERVER_KIND = 'ACCESS' THEN
        BEGIN
        // 从main.ini文件中读出数据库设置
       // PATHNAME_POS  := T.READString('ODBC','PATH_NAME_POS'  ,PATHNAME_POS);
       //  PATHNAME_IVTT := T.READString('ODBC','PATH_NAME_IVTT' ,PATHNAME_IVTT);
        END;
     // MS SQL SERVER DRIVER
     IF SERVER_KIND = 'SQLSERVER' THEN
        BEGIN
        END;
     END;
  _SYS_PATH_DB := PATHNAME_POS;
  DB_SET_ODBC_ACCESS('MICROPOS'  ,PATHNAME_POS);
  DB_SET_ODBC_ACCESS('MICROIVTT' ,PATHNAME_IVTT);
END;
procedure LOAD_FRONT_TABLE_VARIBLE;  // 读取前台变量
BEGIN
_TB_PRACTICE_MODE := UNSET_READ_SIN ('TB_PRACTICE_MODE' ); //练习模式
IF (_TB_PRACTICE_MODE <= 0) OR (_TB_PRACTICE_MODE>=3) THEN _TB_PRACTICE_MODE := 0;

_TB_AUTO_SHOWPOSA := UNSET_READ_SBL ('TB_AUTO_SHOWPOSA' );  //自动激活 前台程序
_TB_PRN_ALWAYSON  := UNSET_READ_SBL ('TB_PRN_ALWAYSON'  );  //强迫一定要打印发票
_TB_PRN_PRINTING  := UNSET_READ_SBL ('TB_PRN_PRINTING'  );  //是否打印发票
_TB_PRN_CASHBOX   := UNSET_READ_SBL ('TB_PRN_CASHBOX'   );  //是否自动开钱箱
_TB_CLEAR_INPUT   := UNSET_READ_SBL ('TB_CLEAR_INPUT'   );  //输入后是否清除输入格
_TB_MINUSP        := UNSET_READ_SBL ('TB_MINUSP'        );  //总计负数可结帐
_TB_LAST_SUB      := UNSET_READ_SBL ('TB_LAST_SUB'      );  //去尾数另外打印
_TB_DISC_ALL      := UNSET_READ_SBL ('TB_DISC_ALL'      );  //每笔都打折
_TB_AUTO_EAN13    := UNSET_READ_SBL ('TB_AUTO_EAN13'    );  //13码数值自动补位
_TB_ALL_CASHIN    := UNSET_READ_SBL ('TB_ALL_CASHIN'    );  //全部使用现金结帐
_TB_RE_INPUT      := UNSET_READ_SBL ('TB_RE_INPUT'      );  //重复刷是否自动加

_TB_AUTO_ROUND    := UNSET_READ_SBL ('TB_AUTO_ROUND'    );  // 个位数四舍五入
_TB_SHOW_FUNCTION := UNSET_READ_SBL ('TB_SHOW_FUNCTION' );  // 显示功能键
_TB_SHOW_BGCOS    := UNSET_READ_SBL ('TB_SHOW_BGCOS'    );  // 显示成本价
_TB_SHOW_BGQTS    := UNSET_READ_SBL ('TB_SHOW_BGQTS'    );  // 显示安存量
_TB_SHOW_BGQTN    := UNSET_READ_SBL ('TB_SHOW_BGQTN'    );  // 显示库存量
_TB_SHOW_BGDSN    := UNSET_READ_SBL ('TB_SHOW_BGDSN'    );  // 显示产品详细资料
_TB_SHOW_BMEMN    := UNSET_READ_SBL ('TB_SHOW_BMEMN'    );  // 显示会员详细资料
_TB_SHOW_RUNLG    := UNSET_READ_SBL ('TB_SHOW_RUNLG'    );  // 显示跑马灯
_TB_SHOW_WARN     := UNSET_READ_SBL ('TB_SHOW_WARN'     );  // 刷无资料时要警告

_TB_CHECK_POSM    := UNSET_READ_SBL ('TB_CHECK_POSM'    );  // 检查特价品资料
_TB_CHECK_POSN    := UNSET_READ_SBL ('TB_CHECK_POSN'    );  // 检查组合销售资料
_TB_CHECK_POSO    := UNSET_READ_SBL ('TB_CHECK_POSO'    );  // 检查买二送一资料
_TB_CHECK_BGQTN   := UNSET_READ_SBL ('TB_CHECK_BGQTN'   );  // 检查库存量资料
_TB_CHECK_GIFT_NO := UNSET_READ_SBL ('TB_CHECK_GIFT_NO' );  // 检查礼券是否重复

_TB_SET_ACUS      := UNSET_READ_SBL ('_TB_SET_ACUS'      ); // 是否输入流动客户分析
_TB_SET_INPUT_INV := UNSET_READ_SBL ('_TB_SET_INPUT_INV' ); // 是否必须输入发票号码
_TB_SET_LOWCOS    := UNSET_READ_SBL ('_TB_SET_LOWCOS'    ); // 是否售价可低于预设成本
_TB_SET_BMBPO     := UNSET_READ_SIN ('_TB_SET_BMBPO'     ); // 会员点数
_TB_SET_CHG_PRICE := UNSET_READ_SBL ('_TB_SET_CHG_PRICE' ); // 是否可直接更改售价
_TB_SET_WIN_PRICE := UNSET_READ_SBL ('_TB_SET_WIN_PRICE' ); // 开新窗口更改售价

_TB_NUMBER         := UNSET_READ_SST ('_TB_NUMBER'         );  //收款台号码

_TB_INV_NO         := UNSET_READ_SST ('_TB_INV_NO'         );  //发票号码
_TB_INV_CNT        := UNSET_READ_SIN ('_TB_INV_CNT'        );; //发票剩张数

_TB_INV_SET_IV_TS1 := UNSET_READ_SIN ('_TB_INV_SET_IV_TS1' ); //发票 TITLE 空行
_TB_INV_SET_IV_TS2 := UNSET_READ_SIN ('_TB_INV_SET_IV_TS2' ); //发票 TITLE 空行
_TB_INV_SET_IV_TC1 := UNSET_READ_SST ('_TB_INV_SET_IV_TC1' ); //发票 TITLE 1
_TB_INV_SET_IV_TC2 := UNSET_READ_SST ('_TB_INV_SET_IV_TC2' ); //发票 TITLE 2

_TB_INV_SET_IV_CC1 := UNSET_READ_SIN ('_TB_INV_SET_IV_CC1' ); //发票 内容 1
_TB_INV_SET_IV_CC2 := UNSET_READ_SIN ('_TB_INV_SET_IV_CC2' ); //发票 内容 2
_TB_INV_SET_IV_CC3 := UNSET_READ_SIN ('_TB_INV_SET_IV_CC3' ); //发票 内容 3
_TB_INV_SET_IV_CC4 := UNSET_READ_SIN ('_TB_INV_SET_IV_CC4' ); //发票 内容 4
_TB_INV_SET_IV_CS1 := UNSET_READ_SIN ('_TB_INV_SET_IV_CS1' ); //发票 空格 1
_TB_INV_SET_IV_CS2 := UNSET_READ_SIN ('_TB_INV_SET_IV_CS2' ); //发票 空格 2
_TB_INV_SET_IV_CS3 := UNSET_READ_SIN ('_TB_INV_SET_IV_CS3' ); //发票 空格 3
_TB_INV_SET_IV_CP1 := UNSET_READ_SIN ('_TB_INV_SET_IV_CP1' ); //发票 位数 1
_TB_INV_SET_IV_CP2 := UNSET_READ_SIN ('_TB_INV_SET_IV_CP2' ); //发票 位数 2
_TB_INV_SET_IV_CP3 := UNSET_READ_SIN ('_TB_INV_SET_IV_CP3' ); //发票 位数 3
_TB_INV_SET_IV_CP4 := UNSET_READ_SIN ('_TB_INV_SET_IV_CP4' ); //发票 位数 4

_TB_INV_SET_IV_EC1 := UNSET_READ_SST ('_TB_INV_SET_IV_EC1' ); //发票 结尾 1
_TB_INV_SET_IV_EC2 := UNSET_READ_SST ('_TB_INV_SET_IV_EC2' ); //发票 结尾 2

_TB_INV_SET_IV_RP1 := UNSET_READ_SBL ('_TB_INV_SET_IV_RP1' ); //打印应找金额
_TB_INV_SET_IV_RP2 := UNSET_READ_SBL ('_TB_INV_SET_IV_RP2' ); //打印信用卡号
_TB_INV_SET_IV_RP3 := UNSET_READ_SBL ('_TB_INV_SET_IV_RP3' ); //打印礼券明细
END;

//公共变量声明初值
procedure VAR_DECLARE_INI;
begin

//设置系统变量
_SYS_PATH      := ExtractFilePath(Application.EXEName); //系统目录
_SYS_PATH_DB   := '';                 //系统数据库 完整路径
_SYS_PATH_DATA := _SYS_PATH + 'DATA\';
_SYS_PATH_INI  := _SYS_PATH + 'INI\';

FILEPATH_INVOICE    := _SYS_PATH_INI+'INVOICE.INI';
FILEPATH_CLEVER     := _SYS_PATH_INI+'CLEVER.INI';
FILEPATH_INVOICE    := _SYS_PATH_INI+'INVOICE.INI';
FILEPATH_DSP        := _SYS_PATH_INI+'DSP.INI';
FILEPATH_ARGOX      := _SYS_PATH_INI+'ARGOX.INI';
FILEPATH_COLLECT    := _SYS_PATH_INI+'COLLECT.INI';
FILEPATH_POSAKEY    := _SYS_PATH_INI+'POSAKEY.INI';
FILEPATH_POSASINGLE := _SYS_PATH_INI+'POSASINGLE.INI';
//检查目录是否存在IF NOT DirectoryExists(_SYS_PATH_INI) THEN CreateDir(_SYS_PATH_INI);
//系统参考值
_SYS_RBPST := '001';
_SYS_PAIDE := '';
//系统特殊值
_SUPER_USER    := FALSE;
_SUPER_USER_ID := EDATE_TO_CDATE(DATETOSTR(DATE))+'1234';
//设置 USER 变量
_SYS_LOGINED := FALSE;  //是否已经登录
_SYS_LOGO    := FALSE;  //是否已显示过 LOGO
_SUPER_USER := TRUE;
_USER_ID := 'admin';
_USER_NAME := '';
_USER_LOGINDATETIME  := DATE + TIME;
_TB_PRACTICE_MODE := 0; //练习模式
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
CLR_TB := TBitmap.Create;

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
IF FileExists('\DELPHI\PIC\CLEAR.BMP'  ) = TRUE THEN CLR_TB.LoadFromFile('\DELPHI\PIC\CLEAR.BMP');
// GRID图形
True_bmp  := TBitmap.Create;
False_bmp := TBitmap.Create;
Blank_bmp := TBitmap.Create;
IF FileExists('\DELPHI\pic\true.BMP' ) = TRUE  THEN True_bmp .LoadFromFile('\DELPHI\pic\true.BMP'  );
IF FileExists('\DELPHI\pic\false.BMP') = TRUE  THEN False_bmp.LoadFromFile('\DELPHI\pic\false.BMP'  );
IF FileExists('\DELPHI\pic\blank.BMP') = TRUE  THEN Blank_bmp.LoadFromFile('\DELPHI\pic\blank.BMP'  );


end;

procedure SAVE_FRONT_TABLE_VARIBLE;  // 存储前台变量
BEGIN
UNSET_WRITE_SIN ('TB_PRACTICE_MODE' ,_TB_PRACTICE_MODE) ; //练习模式

UNSET_WRITE_SBL ('TB_AUTO_SHOWPOSA' ,_TB_AUTO_SHOWPOSA) ;  //自动激活 前台程序
UNSET_WRITE_SBL ('TB_PRN_ALWAYSON'  ,_TB_PRN_ALWAYSON ) ;  //强迫一定要打印发票
UNSET_WRITE_SBL ('TB_PRN_PRINTING'  ,_TB_PRN_PRINTING ) ;  //是否打印发票
UNSET_WRITE_SBL ('TB_PRN_CASHBOX'   ,_TB_PRN_CASHBOX  ) ;  //是否自动开钱箱
UNSET_WRITE_SBL ('TB_CLEAR_INPUT'   ,_TB_CLEAR_INPUT  ) ;  //输入后是否清除输入格
UNSET_WRITE_SBL ('TB_MINUSP'        ,_TB_MINUSP       ) ;  //总计负数可结帐
UNSET_WRITE_SBL ('TB_LAST_SUB'      ,_TB_LAST_SUB     ) ;  //去尾数另外打印
UNSET_WRITE_SBL ('TB_DISC_ALL'      ,_TB_DISC_ALL     ) ;  //每笔都打折
UNSET_WRITE_SBL ('TB_AUTO_EAN13'    ,_TB_AUTO_EAN13   ) ;  //13码数值自动补位
UNSET_WRITE_SBL ('TB_ALL_CASHIN'    ,_TB_ALL_CASHIN   ) ;  //全部使用现金结帐
UNSET_WRITE_SBL ('TB_RE_INPUT'      ,_TB_RE_INPUT     ) ;  //重复刷是否自动加

UNSET_WRITE_SBL ('TB_AUTO_ROUND'    ,_TB_AUTO_ROUND   ) ;  // 个位数四舍五入
UNSET_WRITE_SBL ('TB_SHOW_FUNCTION' ,_TB_SHOW_FUNCTION) ;  // 显示功能键
UNSET_WRITE_SBL ('TB_SHOW_BGCOS'    ,_TB_SHOW_BGCOS   ) ;  // 显示成本价
UNSET_WRITE_SBL ('TB_SHOW_BGQTS'    ,_TB_SHOW_BGQTS   ) ;  // 显示安存量
UNSET_WRITE_SBL ('TB_SHOW_BGQTN'    ,_TB_SHOW_BGQTN   ) ;  // 显示库存量
UNSET_WRITE_SBL ('TB_SHOW_BGDSN'    ,_TB_SHOW_BGDSN   ) ;  // 显示产品详细资料
UNSET_WRITE_SBL ('TB_SHOW_BMEMN'    ,_TB_SHOW_BMEMN   ) ;  // 显示会员详细资料
UNSET_WRITE_SBL ('TB_SHOW_RUNLG'    ,_TB_SHOW_RUNLG   ) ;  // 显示跑马灯
UNSET_WRITE_SBL ('TB_SHOW_WARN'     ,_TB_SHOW_WARN    ) ;  // 刷无资料时要警告

UNSET_WRITE_SBL ('TB_CHECK_POSM'    ,_TB_CHECK_POSM   ) ;  // 检查特价品资料
UNSET_WRITE_SBL ('TB_CHECK_POSN'    ,_TB_CHECK_POSN   ) ;  // 检查组合销售资料
UNSET_WRITE_SBL ('TB_CHECK_POSO'    ,_TB_CHECK_POSO   ) ;  // 检查买二送一资料
UNSET_WRITE_SBL ('TB_CHECK_BGQTN'   ,_TB_CHECK_BGQTN  ) ;  // 检查库存量资料
UNSET_WRITE_SBL ('TB_CHECK_GIFT_NO' ,_TB_CHECK_GIFT_NO) ;  // 检查礼券是否重复


UNSET_WRITE_SBL ('_TB_SET_ACUS'      ,_TB_SET_ACUS      ); // 是否输入流动客户分析
UNSET_WRITE_SBL ('_TB_SET_INPUT_INV' ,_TB_SET_INPUT_INV ); // 是否必须输入发票号码
UNSET_WRITE_SBL ('_TB_SET_LOWCOS'    ,_TB_SET_LOWCOS    ); // 是否售价可低于预设成本
UNSET_WRITE_SIN ('_TB_SET_BMBPO'     ,_TB_SET_BMBPO     ); // 会员点数
UNSET_WRITE_SBL ('_TB_SET_CHG_PRICE' ,_TB_SET_CHG_PRICE ); // 是否可直接更改售价
UNSET_WRITE_SBL ('_TB_SET_WIN_PRICE' ,_TB_SET_WIN_PRICE ); // 开新窗口更改售价

UNSET_WRITE_SST ('_TB_NUMBER'        ,_TB_NUMBER     );  //收款台号码

UNSET_WRITE_SST ('_TB_INV_NO'        ,_TB_INV_NO     );  //发票号码
UNSET_WRITE_SIN ('_TB_INV_CNT'       ,_TB_INV_CNT    );; //发票剩张数

UNSET_WRITE_SIN ('_TB_INV_SET_IV_TS1',_TB_INV_SET_IV_TS1); //发票 TITLE 空行
UNSET_WRITE_SIN ('_TB_INV_SET_IV_TS2',_TB_INV_SET_IV_TS2); //发票 TITLE 空行
UNSET_WRITE_SST ('_TB_INV_SET_IV_TC1',_TB_INV_SET_IV_TC1); //发票 TITLE 1
UNSET_WRITE_SST ('_TB_INV_SET_IV_TC2',_TB_INV_SET_IV_TC2); //发票 TITLE 2

UNSET_WRITE_SIN ('_TB_INV_SET_IV_CC1',_TB_INV_SET_IV_CC1); //发票 内容 1
UNSET_WRITE_SIN ('_TB_INV_SET_IV_CC2',_TB_INV_SET_IV_CC2); //发票 内容 2
UNSET_WRITE_SIN ('_TB_INV_SET_IV_CC3',_TB_INV_SET_IV_CC3); //发票 内容 3
UNSET_WRITE_SIN ('_TB_INV_SET_IV_CC4',_TB_INV_SET_IV_CC4); //发票 内容 4
UNSET_WRITE_SIN ('_TB_INV_SET_IV_CS1',_TB_INV_SET_IV_CS1); //发票 空格 1
UNSET_WRITE_SIN ('_TB_INV_SET_IV_CS2',_TB_INV_SET_IV_CS2); //发票 空格 2
UNSET_WRITE_SIN ('_TB_INV_SET_IV_CS3',_TB_INV_SET_IV_CS3); //发票 空格 3
UNSET_WRITE_SIN ('_TB_INV_SET_IV_CP1',_TB_INV_SET_IV_CP1); //发票 位数 1
UNSET_WRITE_SIN ('_TB_INV_SET_IV_CP2',_TB_INV_SET_IV_CP2); //发票 位数 2
UNSET_WRITE_SIN ('_TB_INV_SET_IV_CP3',_TB_INV_SET_IV_CP3); //发票 位数 3
UNSET_WRITE_SIN ('_TB_INV_SET_IV_CP4',_TB_INV_SET_IV_CP4); //发票 位数 4

UNSET_WRITE_SST ('_TB_INV_SET_IV_EC1',_TB_INV_SET_IV_EC1); //发票 结尾 1
UNSET_WRITE_SST ('_TB_INV_SET_IV_EC2',_TB_INV_SET_IV_EC2); //发票 结尾 2

UNSET_WRITE_SBL ('_TB_INV_SET_IV_RP1',_TB_INV_SET_IV_RP1); //打印应找金额
UNSET_WRITE_SBL ('_TB_INV_SET_IV_RP2',_TB_INV_SET_IV_RP2); //打印信用卡号
UNSET_WRITE_SBL ('_TB_INV_SET_IV_RP3',_TB_INV_SET_IV_RP3); //打印礼券明细

END;
end.
