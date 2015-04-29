unit SYSINI;

interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ToolWin, ComCtrls, ExtCtrls, StdCtrls, DBCtrls, DB, DBTables;

//��������������ֵ
procedure VAR_DECLARE_INI;
procedure VAR_DECLARE_ODBC;


procedure LOAD_FRONT_TABLE_VARIBLE;  // ��ȡǰ̨����
procedure SAVE_FRONT_TABLE_VARIBLE;  // �洢ǰ̨����


var

   T_STR : STRING;  //�ݴ����
   SystemDate: TSystemTime;     //ϵͳ����

   
   //ϵͳ����
   _SYS_PATH      : STRING; //ϵͳĿ¼
   _SYS_PATH_DB   : STRING; //ϵͳ���ݿ� ����·��
   _SYS_PATH_DATA : STRING; //ϵͳ DATA Ŀ¼
   _SYS_PATH_INI  : STRING; //ϵͳ INI Ŀ¼

   // ǰ̨���� ==================================================================
   FILEPATH_INVOICE    : STRING; // INI ��Ʊ�ļ�·��
   FILEPATH_CLEVER     : STRING; // INI
   FILEPATH_DSP        : STRING; // INI
   FILEPATH_ARGOX      : STRING; // INI
   FILEPATH_COLLECT    : STRING; // INI
   FILEPATH_POSAKEY    : STRING; // INI
   FILEPATH_POSASINGLE : STRING; // INI ��Ʒ��

   _SYS_RBPST : STRING;      //Ԥ��ֿ�ֵ
   _SYS_PAIDE : STRING;      //Ԥ���տ�ֵ̨

   _SYS_LOGINED : BOOLEAN;  //�Ƿ��Ѿ���¼
   _SYS_LOGO    : BOOLEAN;  //�Ƿ�����ʾ�� LOGO


    //ϵͳ USER ����
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


    //Ӳ��Ĭ��ֵ
    _SYS_CFG_DBKIND : INTEGER;  // ���ݿ�����
    _SYS_CFG_BARPRN : INTEGER;  // �������,Ԥ�����

    //ϵͳĬ��ֵ
   _QRBGDS, _QRBMEM, _QRBMAD : STRING;  //��ǩ·���ļ���
   _CHG_BGENO, _CHG_BMENO, _CHG_BSENO, _CHG_BCENO, _CHG_BNENO : BOOLEAN; //�ɷ�ı��
   _ORI_BGENO, _ORI_BMENO, _ORI_BSENO, _ORI_BCENO, _ORI_BNENO : STRING;  //�ɷ�ı��

   //���ٲ�ѯ - ��ʾ��ϸ����
//   SHOW_BGDSN_PANEL : BOOLEAN;
//   SHOW_BMEMN_PANEL : BOOLEAN;
//   SHOW_BCSTN_PANEL : BOOLEAN;


   //��ťͼ��
   INS_TB,UPD_TB,DEL_TB,YES_TB,CAL_TB,
   SER_TB,PRN_TB,QUT_TB,SET_TB,PRE_TB,CLR_TB: TBitmap;

   //GRIDͼ��
   True_bmp, False_bmp, Blank_bmp : TBitmap;


   //�����ͷ�������
   ACUS_WANT_SHOW : BOOLEAN;
   ACUS_ASQA1,ACUS_ASQA2,ACUS_ASQA3,ACUS_ASQA4,ACUS_ASQA5 :STRING;
   ACUS_ASQB1,ACUS_ASQB2,ACUS_ASQB3,ACUS_ASQB4,ACUS_ASQB5 :STRING;





// ǰ̨���� ==================================================================

   _TB_PRACTICE_MODE : INTEGER; //��ϰģʽ

   _TB_AUTO_SHOWPOSA : BOOLEAN; //�Զ����� ǰ̨����
   _TB_AUTO_EAN13    : BOOLEAN; //13����ֵ�Զ���λ
   _TB_ALL_CASHIN    : BOOLEAN; //ȫ��ʹ���ֽ����
   _TB_RE_INPUT      : BOOLEAN; //�ظ�ˢ�Ƿ��Զ���
   _TB_CLEAR_INPUT   : BOOLEAN; //������Ƿ���������
   _TB_MINUSP        : BOOLEAN; //�ܼƸ����ɽ���
   _TB_LAST_SUB      : BOOLEAN; //�ܼƿ���ȥβ��  //ȥβ�������ӡ
   _TB_LAST_PRICE    : REAL;    //�ܼ� - ȥβ�����


   _TB_AUTO_ROUND    : BOOLEAN; // ��λ����������
   _TB_SHOW_FUNCTION : BOOLEAN; // ��ʾ���ܼ�
   _TB_SHOW_BGCOS    : BOOLEAN; // ��ʾ�ɱ���
   _TB_SHOW_BGQTS    : BOOLEAN; // ��ʾ������
   _TB_SHOW_BGQTN    : BOOLEAN; // ��ʾ�����
   _TB_SHOW_BGDSN    : BOOLEAN; // ��ʾ��Ʒ��ϸ����
   _TB_SHOW_BMEMN    : BOOLEAN; // ��ʾ��Ա��ϸ����
   _TB_SHOW_RUNLG    : BOOLEAN; // ��ʾ�����
   _TB_SHOW_WARN     : BOOLEAN; // ˢ������ʱҪ����

   _TB_CHECK_POSM    : BOOLEAN; // ����ؼ�Ʒ����
   _TB_CHECK_POSN    : BOOLEAN; // ��������������
   _TB_CHECK_POSO    : BOOLEAN; // ��������һ����
   _TB_CHECK_BGQTN   : BOOLEAN; // �����������
   _TB_CHECK_GIFT_NO : BOOLEAN; // �����ȯ�Ƿ��ظ�


   _TB_SET_ACUS      : BOOLEAN; // �Ƿ����������ͻ�����
   _TB_SET_INPUT_INV : BOOLEAN; // �Ƿ�������뷢Ʊ����
   _TB_SET_LOWCOS    : BOOLEAN; // �Ƿ��ۼۿɵ���Ԥ��ɱ�
   _TB_SET_BMBPO     : INTEGER; // ��Ա����
   _TB_SET_CHG_PRICE : BOOLEAN; // �Ƿ��ֱ�Ӹ����ۼ�
   _TB_SET_WIN_PRICE : BOOLEAN; // ���´��ڸ����ۼ�


   _TB_PAENO        : STRING;     //�˴ν��ʱ��
   _TB_NUMBER       : STRING;     //�տ�̨���
   _TB_INSERT_DATE  : TDATETIME;  //�˱�����
   _TB_ESC_CNT      : INTEGER;    //��ESC�Ĵ���

   //�տ�Ա����======================================
   _TB_USER_NUMBER : STRING;  //�տ�Ա���
   _TB_USER_NAME   : STRING;  //�տ�Ա����
   _TB_USER_MSG    : STRING;  //������Ϣ

   _TB_PACIV        : string;  //ͳһ���
   _TB_BACK_MODE    : BOOLEAN; //�˻�ģʽ
   _TB_FORCUS_ROW   : INTEGER; //��������
   _TB_RUNLG_TMECNT : INTEGER; //����Ƽ�����
   _TB_RUNLG_PICCNT : INTEGER; //�� ����� PIC����

   //�ݴ�����======================================
   _TB_TMP_GRID     : BOOLEAN; //�ݴ����ж���
   _TB_TMP_BGENO : STRING; // ����ѡȡ���ݴ����
   _TB_TMP_BMENO : STRING; // ����ѡȡ���ݴ����

   _TB_TOTAL_QTY      : Integer;  //����������
   _TB_TOTAL_REC      : Integer;  //����������
   _TB_TOTAL_PRICE    : REAL;     //��������� - ȫ��Ӧ���ܼ�
   _TB_TOTAL_CASH     : REAL;     //Ӧ���ֽ�   - ֻ�븶�ֲ���
   _TB_TOTAL_PAY      : REAL;     //���˸����ֽ�
   _TB_TOTAL_EXCHANGE : REAL;     //Ҫ�ҵ���Ǯ
   _TB_TOTAL_NOPAY    : REAL;     //�������������     (���ÿ�+��ȯ+�ۿ�)

   _TB_DISC_PERCENT : REAL;    //���۱���
   _TB_DISC_PRICE   : REAL;    //�ۿ۽��
   _TB_DISC_ALL     : BOOLEAN; //ÿ�ʶ�����

   //���ÿ�����======================================
   _TB_CARD_PACNO   : string;  //���ÿ���
   _TB_CARD_PACDT   : string;  //���ÿ�������
   _TB_CARD_PACNA   : REAL;    //���ÿ����
   _TB_CARD_PACKD   : string;  //���ÿ����

   //��ȯ����======================================
   _TB_GIFT_PGCNO   : string;  //��ȯ��
   _TB_GIFT_PGCDT   : string;  //��ȯ������
   _TB_GIFT_PGCNA   : REAL;    //��ȯ���
   _TB_GIFT_PGCKD   : string;  //��ȯ���
   _TB_GIFT_PRICE   : REAL;    //��ȯ�ܽ��


   //��Ա����======================================
   _TB_BMEM_BMENO   : STRING;   //��Ա����
   _TB_BMEM_BMNAM   : STRING;   //��Ա����
   _TB_BMEM_BMLVE   : INTEGER;  //��Ա�ȼ�
   _TB_BMEM_BMBYR   : INTEGER;  //�����ѵȼ�
   _TB_BMEM_BMBTO   : INTEGER;  //�����ѵȼ�
   _TB_BMEM_BMCRD   : STRING;   //������
   _TB_BMEM_BMDAT   : STRING;   //�����
   _TB_BMEM_FOUND   : BOOLEAN;  //�ҵ���Ա

   //��Ʒ����======================================
   _TB_BG_BGENO : string;
   _TB_BG_BGNAM : string;
   _TB_BG_BGKIN : STRING;  //��Ʒ����
   _TB_BG_BGQTS : Integer; //��ȫ��
   _TB_BG_BGQTN : Integer; //�����
   _TB_BG_BGCOS : REAL;    //�ɱ���
   _TB_BG_BGCNT : Integer; //����
   _TB_BG_BGPST : REAL;    //��׼�۸�
   _TB_BG_BGPVP : REAL;    //����۸�
   _TB_BG_BGPMM : REAL;    //��Ա�۸�
   _TB_BG_BGCST : REAL;    //�ػݼ۸�1
   _TB_BG_BGOTH : REAL;    //�ػݼ۸�2
   _TB_BG_FOUND : Boolean; //�ҵ���Ʒ
   _TB_BG_CNT    : Integer;//�˱�����
   _TB_BG_SPRICE : REAL;   //�˱ʵ���
   _TB_BG_TPRICE : REAL;   //�˱ʵ���
   
   SHOW_BGDSN_PANEL : Boolean;
   SHOW_BMEMN_PANEL : Boolean;

    //��������
   _TB_PRN_ALWAYSON  : BOOLEAN; //ǿ��һ��Ҫ��ӡ��Ʊ      ========== SET
   _TB_PRN_PRINTING  : BOOLEAN; //�Ƿ��ӡ��Ʊ            ========== SET
   _TB_PRN_CASHBOX   : BOOLEAN; //�Ƿ��Զ���Ǯ��        ========== SET

   _TB_INV_NO       : string;  //��Ʊ����
   _TB_INV_PAGE     : INTEGER; //��Ʊҳ
   _TB_INV_CNT      : INTEGER; //��Ʊʣ����
   _TB_INV_SUBTOTAL : INTEGER; //��Ʊ ����С��

   _TB_INV_SET_IV_TS1 : INTEGER; //��Ʊ TITLE ����
   _TB_INV_SET_IV_TS2 : INTEGER; //��Ʊ TITLE ����
   _TB_INV_SET_IV_TC1 : STRING;  //��Ʊ TITLE 1
   _TB_INV_SET_IV_TC2 : STRING;  //��Ʊ TITLE 2

   _TB_INV_SET_IV_CC1 : INTEGER; //��Ʊ ���� 1
   _TB_INV_SET_IV_CC2 : INTEGER; //��Ʊ ���� 2
   _TB_INV_SET_IV_CC3 : INTEGER; //��Ʊ ���� 3
   _TB_INV_SET_IV_CC4 : INTEGER; //��Ʊ ���� 4
   _TB_INV_SET_IV_CS1 : INTEGER; //��Ʊ �ո� 1
   _TB_INV_SET_IV_CS2 : INTEGER; //��Ʊ �ո� 2
   _TB_INV_SET_IV_CS3 : INTEGER; //��Ʊ �ո� 3
   _TB_INV_SET_IV_CP1 : INTEGER; //��Ʊ λ�� 1
   _TB_INV_SET_IV_CP2 : INTEGER; //��Ʊ λ�� 2
   _TB_INV_SET_IV_CP3 : INTEGER; //��Ʊ λ�� 3
   _TB_INV_SET_IV_CP4 : INTEGER; //��Ʊ λ�� 4

   _TB_INV_SET_IV_EC1 : STRING;  //��Ʊ ��β 1
   _TB_INV_SET_IV_EC2 : STRING;  //��Ʊ ��β 2

   _TB_INV_SET_IV_RP1 : BOOLEAN; //��ӡӦ�ҽ��
   _TB_INV_SET_IV_RP2 : BOOLEAN; //��ӡ���ÿ���
   _TB_INV_SET_IV_RP3 : BOOLEAN; //��ӡ��ȯ��ϸ
    //��ʾ������
   _TB_DSP_CHANGED: BOOLEAN;
// ǰ̨����
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
  // ODBC �Զ�����
  INIFILENAME   := _SYS_PATH_INI + 'MAIN.INI';
  PATHNAME_POS  := ExtractFilePath(Application.EXEName)+'DATA\POS.MDB';
  PATHNAME_IVTT :=ExtractFilePath(Application.EXEName)+'DATA\IVTT.MDB';
  IF FileExists(INIFILENAME) = FALSE  THEN
     BEGIN
     FILE_CREATE(INIFILENAME);
     ShowMessage('���ݿ�·��δָ��!');
     PATHNAME_POS  := INPUTBOX('�������ݿ�·��POS' ,'POS·��' ,PATHNAME_POS);
     PATHNAME_IVTT := INPUTBOX('�������ݿ�·��IVTT','IVTT·��',PATHNAME_IVTT);

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
        // ��main.ini�ļ��ж������ݿ�����
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
procedure LOAD_FRONT_TABLE_VARIBLE;  // ��ȡǰ̨����
BEGIN
_TB_PRACTICE_MODE := UNSET_READ_SIN ('TB_PRACTICE_MODE' ); //��ϰģʽ
IF (_TB_PRACTICE_MODE <= 0) OR (_TB_PRACTICE_MODE>=3) THEN _TB_PRACTICE_MODE := 0;

_TB_AUTO_SHOWPOSA := UNSET_READ_SBL ('TB_AUTO_SHOWPOSA' );  //�Զ����� ǰ̨����
_TB_PRN_ALWAYSON  := UNSET_READ_SBL ('TB_PRN_ALWAYSON'  );  //ǿ��һ��Ҫ��ӡ��Ʊ
_TB_PRN_PRINTING  := UNSET_READ_SBL ('TB_PRN_PRINTING'  );  //�Ƿ��ӡ��Ʊ
_TB_PRN_CASHBOX   := UNSET_READ_SBL ('TB_PRN_CASHBOX'   );  //�Ƿ��Զ���Ǯ��
_TB_CLEAR_INPUT   := UNSET_READ_SBL ('TB_CLEAR_INPUT'   );  //������Ƿ���������
_TB_MINUSP        := UNSET_READ_SBL ('TB_MINUSP'        );  //�ܼƸ����ɽ���
_TB_LAST_SUB      := UNSET_READ_SBL ('TB_LAST_SUB'      );  //ȥβ�������ӡ
_TB_DISC_ALL      := UNSET_READ_SBL ('TB_DISC_ALL'      );  //ÿ�ʶ�����
_TB_AUTO_EAN13    := UNSET_READ_SBL ('TB_AUTO_EAN13'    );  //13����ֵ�Զ���λ
_TB_ALL_CASHIN    := UNSET_READ_SBL ('TB_ALL_CASHIN'    );  //ȫ��ʹ���ֽ����
_TB_RE_INPUT      := UNSET_READ_SBL ('TB_RE_INPUT'      );  //�ظ�ˢ�Ƿ��Զ���

_TB_AUTO_ROUND    := UNSET_READ_SBL ('TB_AUTO_ROUND'    );  // ��λ����������
_TB_SHOW_FUNCTION := UNSET_READ_SBL ('TB_SHOW_FUNCTION' );  // ��ʾ���ܼ�
_TB_SHOW_BGCOS    := UNSET_READ_SBL ('TB_SHOW_BGCOS'    );  // ��ʾ�ɱ���
_TB_SHOW_BGQTS    := UNSET_READ_SBL ('TB_SHOW_BGQTS'    );  // ��ʾ������
_TB_SHOW_BGQTN    := UNSET_READ_SBL ('TB_SHOW_BGQTN'    );  // ��ʾ�����
_TB_SHOW_BGDSN    := UNSET_READ_SBL ('TB_SHOW_BGDSN'    );  // ��ʾ��Ʒ��ϸ����
_TB_SHOW_BMEMN    := UNSET_READ_SBL ('TB_SHOW_BMEMN'    );  // ��ʾ��Ա��ϸ����
_TB_SHOW_RUNLG    := UNSET_READ_SBL ('TB_SHOW_RUNLG'    );  // ��ʾ�����
_TB_SHOW_WARN     := UNSET_READ_SBL ('TB_SHOW_WARN'     );  // ˢ������ʱҪ����

_TB_CHECK_POSM    := UNSET_READ_SBL ('TB_CHECK_POSM'    );  // ����ؼ�Ʒ����
_TB_CHECK_POSN    := UNSET_READ_SBL ('TB_CHECK_POSN'    );  // ��������������
_TB_CHECK_POSO    := UNSET_READ_SBL ('TB_CHECK_POSO'    );  // ��������һ����
_TB_CHECK_BGQTN   := UNSET_READ_SBL ('TB_CHECK_BGQTN'   );  // �����������
_TB_CHECK_GIFT_NO := UNSET_READ_SBL ('TB_CHECK_GIFT_NO' );  // �����ȯ�Ƿ��ظ�

_TB_SET_ACUS      := UNSET_READ_SBL ('_TB_SET_ACUS'      ); // �Ƿ����������ͻ�����
_TB_SET_INPUT_INV := UNSET_READ_SBL ('_TB_SET_INPUT_INV' ); // �Ƿ�������뷢Ʊ����
_TB_SET_LOWCOS    := UNSET_READ_SBL ('_TB_SET_LOWCOS'    ); // �Ƿ��ۼۿɵ���Ԥ��ɱ�
_TB_SET_BMBPO     := UNSET_READ_SIN ('_TB_SET_BMBPO'     ); // ��Ա����
_TB_SET_CHG_PRICE := UNSET_READ_SBL ('_TB_SET_CHG_PRICE' ); // �Ƿ��ֱ�Ӹ����ۼ�
_TB_SET_WIN_PRICE := UNSET_READ_SBL ('_TB_SET_WIN_PRICE' ); // ���´��ڸ����ۼ�

_TB_NUMBER         := UNSET_READ_SST ('_TB_NUMBER'         );  //�տ�̨����

_TB_INV_NO         := UNSET_READ_SST ('_TB_INV_NO'         );  //��Ʊ����
_TB_INV_CNT        := UNSET_READ_SIN ('_TB_INV_CNT'        );; //��Ʊʣ����

_TB_INV_SET_IV_TS1 := UNSET_READ_SIN ('_TB_INV_SET_IV_TS1' ); //��Ʊ TITLE ����
_TB_INV_SET_IV_TS2 := UNSET_READ_SIN ('_TB_INV_SET_IV_TS2' ); //��Ʊ TITLE ����
_TB_INV_SET_IV_TC1 := UNSET_READ_SST ('_TB_INV_SET_IV_TC1' ); //��Ʊ TITLE 1
_TB_INV_SET_IV_TC2 := UNSET_READ_SST ('_TB_INV_SET_IV_TC2' ); //��Ʊ TITLE 2

_TB_INV_SET_IV_CC1 := UNSET_READ_SIN ('_TB_INV_SET_IV_CC1' ); //��Ʊ ���� 1
_TB_INV_SET_IV_CC2 := UNSET_READ_SIN ('_TB_INV_SET_IV_CC2' ); //��Ʊ ���� 2
_TB_INV_SET_IV_CC3 := UNSET_READ_SIN ('_TB_INV_SET_IV_CC3' ); //��Ʊ ���� 3
_TB_INV_SET_IV_CC4 := UNSET_READ_SIN ('_TB_INV_SET_IV_CC4' ); //��Ʊ ���� 4
_TB_INV_SET_IV_CS1 := UNSET_READ_SIN ('_TB_INV_SET_IV_CS1' ); //��Ʊ �ո� 1
_TB_INV_SET_IV_CS2 := UNSET_READ_SIN ('_TB_INV_SET_IV_CS2' ); //��Ʊ �ո� 2
_TB_INV_SET_IV_CS3 := UNSET_READ_SIN ('_TB_INV_SET_IV_CS3' ); //��Ʊ �ո� 3
_TB_INV_SET_IV_CP1 := UNSET_READ_SIN ('_TB_INV_SET_IV_CP1' ); //��Ʊ λ�� 1
_TB_INV_SET_IV_CP2 := UNSET_READ_SIN ('_TB_INV_SET_IV_CP2' ); //��Ʊ λ�� 2
_TB_INV_SET_IV_CP3 := UNSET_READ_SIN ('_TB_INV_SET_IV_CP3' ); //��Ʊ λ�� 3
_TB_INV_SET_IV_CP4 := UNSET_READ_SIN ('_TB_INV_SET_IV_CP4' ); //��Ʊ λ�� 4

_TB_INV_SET_IV_EC1 := UNSET_READ_SST ('_TB_INV_SET_IV_EC1' ); //��Ʊ ��β 1
_TB_INV_SET_IV_EC2 := UNSET_READ_SST ('_TB_INV_SET_IV_EC2' ); //��Ʊ ��β 2

_TB_INV_SET_IV_RP1 := UNSET_READ_SBL ('_TB_INV_SET_IV_RP1' ); //��ӡӦ�ҽ��
_TB_INV_SET_IV_RP2 := UNSET_READ_SBL ('_TB_INV_SET_IV_RP2' ); //��ӡ���ÿ���
_TB_INV_SET_IV_RP3 := UNSET_READ_SBL ('_TB_INV_SET_IV_RP3' ); //��ӡ��ȯ��ϸ
END;

//��������������ֵ
procedure VAR_DECLARE_INI;
begin

//����ϵͳ����
_SYS_PATH      := ExtractFilePath(Application.EXEName); //ϵͳĿ¼
_SYS_PATH_DB   := '';                 //ϵͳ���ݿ� ����·��
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
//���Ŀ¼�Ƿ����IF NOT DirectoryExists(_SYS_PATH_INI) THEN CreateDir(_SYS_PATH_INI);
//ϵͳ�ο�ֵ
_SYS_RBPST := '001';
_SYS_PAIDE := '';
//ϵͳ����ֵ
_SUPER_USER    := FALSE;
_SUPER_USER_ID := EDATE_TO_CDATE(DATETOSTR(DATE))+'1234';
//���� USER ����
_SYS_LOGINED := FALSE;  //�Ƿ��Ѿ���¼
_SYS_LOGO    := FALSE;  //�Ƿ�����ʾ�� LOGO
_SUPER_USER := TRUE;
_USER_ID := 'admin';
_USER_NAME := '';
_USER_LOGINDATETIME  := DATE + TIME;
_TB_PRACTICE_MODE := 0; //��ϰģʽ
//��ťͼ��
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
// GRIDͼ��
True_bmp  := TBitmap.Create;
False_bmp := TBitmap.Create;
Blank_bmp := TBitmap.Create;
IF FileExists('\DELPHI\pic\true.BMP' ) = TRUE  THEN True_bmp .LoadFromFile('\DELPHI\pic\true.BMP'  );
IF FileExists('\DELPHI\pic\false.BMP') = TRUE  THEN False_bmp.LoadFromFile('\DELPHI\pic\false.BMP'  );
IF FileExists('\DELPHI\pic\blank.BMP') = TRUE  THEN Blank_bmp.LoadFromFile('\DELPHI\pic\blank.BMP'  );


end;

procedure SAVE_FRONT_TABLE_VARIBLE;  // �洢ǰ̨����
BEGIN
UNSET_WRITE_SIN ('TB_PRACTICE_MODE' ,_TB_PRACTICE_MODE) ; //��ϰģʽ

UNSET_WRITE_SBL ('TB_AUTO_SHOWPOSA' ,_TB_AUTO_SHOWPOSA) ;  //�Զ����� ǰ̨����
UNSET_WRITE_SBL ('TB_PRN_ALWAYSON'  ,_TB_PRN_ALWAYSON ) ;  //ǿ��һ��Ҫ��ӡ��Ʊ
UNSET_WRITE_SBL ('TB_PRN_PRINTING'  ,_TB_PRN_PRINTING ) ;  //�Ƿ��ӡ��Ʊ
UNSET_WRITE_SBL ('TB_PRN_CASHBOX'   ,_TB_PRN_CASHBOX  ) ;  //�Ƿ��Զ���Ǯ��
UNSET_WRITE_SBL ('TB_CLEAR_INPUT'   ,_TB_CLEAR_INPUT  ) ;  //������Ƿ���������
UNSET_WRITE_SBL ('TB_MINUSP'        ,_TB_MINUSP       ) ;  //�ܼƸ����ɽ���
UNSET_WRITE_SBL ('TB_LAST_SUB'      ,_TB_LAST_SUB     ) ;  //ȥβ�������ӡ
UNSET_WRITE_SBL ('TB_DISC_ALL'      ,_TB_DISC_ALL     ) ;  //ÿ�ʶ�����
UNSET_WRITE_SBL ('TB_AUTO_EAN13'    ,_TB_AUTO_EAN13   ) ;  //13����ֵ�Զ���λ
UNSET_WRITE_SBL ('TB_ALL_CASHIN'    ,_TB_ALL_CASHIN   ) ;  //ȫ��ʹ���ֽ����
UNSET_WRITE_SBL ('TB_RE_INPUT'      ,_TB_RE_INPUT     ) ;  //�ظ�ˢ�Ƿ��Զ���

UNSET_WRITE_SBL ('TB_AUTO_ROUND'    ,_TB_AUTO_ROUND   ) ;  // ��λ����������
UNSET_WRITE_SBL ('TB_SHOW_FUNCTION' ,_TB_SHOW_FUNCTION) ;  // ��ʾ���ܼ�
UNSET_WRITE_SBL ('TB_SHOW_BGCOS'    ,_TB_SHOW_BGCOS   ) ;  // ��ʾ�ɱ���
UNSET_WRITE_SBL ('TB_SHOW_BGQTS'    ,_TB_SHOW_BGQTS   ) ;  // ��ʾ������
UNSET_WRITE_SBL ('TB_SHOW_BGQTN'    ,_TB_SHOW_BGQTN   ) ;  // ��ʾ�����
UNSET_WRITE_SBL ('TB_SHOW_BGDSN'    ,_TB_SHOW_BGDSN   ) ;  // ��ʾ��Ʒ��ϸ����
UNSET_WRITE_SBL ('TB_SHOW_BMEMN'    ,_TB_SHOW_BMEMN   ) ;  // ��ʾ��Ա��ϸ����
UNSET_WRITE_SBL ('TB_SHOW_RUNLG'    ,_TB_SHOW_RUNLG   ) ;  // ��ʾ�����
UNSET_WRITE_SBL ('TB_SHOW_WARN'     ,_TB_SHOW_WARN    ) ;  // ˢ������ʱҪ����

UNSET_WRITE_SBL ('TB_CHECK_POSM'    ,_TB_CHECK_POSM   ) ;  // ����ؼ�Ʒ����
UNSET_WRITE_SBL ('TB_CHECK_POSN'    ,_TB_CHECK_POSN   ) ;  // ��������������
UNSET_WRITE_SBL ('TB_CHECK_POSO'    ,_TB_CHECK_POSO   ) ;  // ��������һ����
UNSET_WRITE_SBL ('TB_CHECK_BGQTN'   ,_TB_CHECK_BGQTN  ) ;  // �����������
UNSET_WRITE_SBL ('TB_CHECK_GIFT_NO' ,_TB_CHECK_GIFT_NO) ;  // �����ȯ�Ƿ��ظ�


UNSET_WRITE_SBL ('_TB_SET_ACUS'      ,_TB_SET_ACUS      ); // �Ƿ����������ͻ�����
UNSET_WRITE_SBL ('_TB_SET_INPUT_INV' ,_TB_SET_INPUT_INV ); // �Ƿ�������뷢Ʊ����
UNSET_WRITE_SBL ('_TB_SET_LOWCOS'    ,_TB_SET_LOWCOS    ); // �Ƿ��ۼۿɵ���Ԥ��ɱ�
UNSET_WRITE_SIN ('_TB_SET_BMBPO'     ,_TB_SET_BMBPO     ); // ��Ա����
UNSET_WRITE_SBL ('_TB_SET_CHG_PRICE' ,_TB_SET_CHG_PRICE ); // �Ƿ��ֱ�Ӹ����ۼ�
UNSET_WRITE_SBL ('_TB_SET_WIN_PRICE' ,_TB_SET_WIN_PRICE ); // ���´��ڸ����ۼ�

UNSET_WRITE_SST ('_TB_NUMBER'        ,_TB_NUMBER     );  //�տ�̨����

UNSET_WRITE_SST ('_TB_INV_NO'        ,_TB_INV_NO     );  //��Ʊ����
UNSET_WRITE_SIN ('_TB_INV_CNT'       ,_TB_INV_CNT    );; //��Ʊʣ����

UNSET_WRITE_SIN ('_TB_INV_SET_IV_TS1',_TB_INV_SET_IV_TS1); //��Ʊ TITLE ����
UNSET_WRITE_SIN ('_TB_INV_SET_IV_TS2',_TB_INV_SET_IV_TS2); //��Ʊ TITLE ����
UNSET_WRITE_SST ('_TB_INV_SET_IV_TC1',_TB_INV_SET_IV_TC1); //��Ʊ TITLE 1
UNSET_WRITE_SST ('_TB_INV_SET_IV_TC2',_TB_INV_SET_IV_TC2); //��Ʊ TITLE 2

UNSET_WRITE_SIN ('_TB_INV_SET_IV_CC1',_TB_INV_SET_IV_CC1); //��Ʊ ���� 1
UNSET_WRITE_SIN ('_TB_INV_SET_IV_CC2',_TB_INV_SET_IV_CC2); //��Ʊ ���� 2
UNSET_WRITE_SIN ('_TB_INV_SET_IV_CC3',_TB_INV_SET_IV_CC3); //��Ʊ ���� 3
UNSET_WRITE_SIN ('_TB_INV_SET_IV_CC4',_TB_INV_SET_IV_CC4); //��Ʊ ���� 4
UNSET_WRITE_SIN ('_TB_INV_SET_IV_CS1',_TB_INV_SET_IV_CS1); //��Ʊ �ո� 1
UNSET_WRITE_SIN ('_TB_INV_SET_IV_CS2',_TB_INV_SET_IV_CS2); //��Ʊ �ո� 2
UNSET_WRITE_SIN ('_TB_INV_SET_IV_CS3',_TB_INV_SET_IV_CS3); //��Ʊ �ո� 3
UNSET_WRITE_SIN ('_TB_INV_SET_IV_CP1',_TB_INV_SET_IV_CP1); //��Ʊ λ�� 1
UNSET_WRITE_SIN ('_TB_INV_SET_IV_CP2',_TB_INV_SET_IV_CP2); //��Ʊ λ�� 2
UNSET_WRITE_SIN ('_TB_INV_SET_IV_CP3',_TB_INV_SET_IV_CP3); //��Ʊ λ�� 3
UNSET_WRITE_SIN ('_TB_INV_SET_IV_CP4',_TB_INV_SET_IV_CP4); //��Ʊ λ�� 4

UNSET_WRITE_SST ('_TB_INV_SET_IV_EC1',_TB_INV_SET_IV_EC1); //��Ʊ ��β 1
UNSET_WRITE_SST ('_TB_INV_SET_IV_EC2',_TB_INV_SET_IV_EC2); //��Ʊ ��β 2

UNSET_WRITE_SBL ('_TB_INV_SET_IV_RP1',_TB_INV_SET_IV_RP1); //��ӡӦ�ҽ��
UNSET_WRITE_SBL ('_TB_INV_SET_IV_RP2',_TB_INV_SET_IV_RP2); //��ӡ���ÿ���
UNSET_WRITE_SBL ('_TB_INV_SET_IV_RP3',_TB_INV_SET_IV_RP3); //��ӡ��ȯ��ϸ

END;
end.
