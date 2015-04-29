unit main;
 
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Menus, ComCtrls, jpeg, Buttons, ToolWin, StdCtrls;

type
  TFMMAIN = class(TForm)
    MainMenu1  : TMainMenu;
    N1         : TMenuItem;
    M_B        : TMenuItem;
    SYSQUIT    : TMenuItem;
    BMAN       : TMenuItem;
    SYSSET: TMenuItem;
    SYSLOG: TMenuItem;
    Timer1: TTimer;
    StatusBar: TStatusBar;
    BMEM: TMenuItem;
    N44: TMenuItem;
    N48: TMenuItem;
    N8: TMenuItem;
    N17: TMenuItem;
    N18: TMenuItem;
    ACLEVER: TMenuItem;
    AARGOX: TMenuItem;
    N64: TMenuItem;
    N78: TMenuItem;
    N79: TMenuItem;
    N80: TMenuItem;
    N81: TMenuItem;
    N82: TMenuItem;
    N83: TMenuItem;
    BCST: TMenuItem;
    N12: TMenuItem;
    M_FMRCINB: TMenuItem;
    M_FMRCIN: TMenuItem;
    M_FMRCON: TMenuItem;
    M_FMRCONB: TMenuItem;
    N23: TMenuItem;
    W1: TMenuItem;
    N26: TMenuItem;
    N212311: TMenuItem;
    N33: TMenuItem;
    N86: TMenuItem;
    ToolBar1: TToolBar;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    ToolButton1: TToolButton;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TSpeedButton;
    BTNQUT: TSpeedButton;
    Image_BG: TImage;
    INVOICE: TMenuItem;
    DCOLLECT: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SYSQUITClick(Sender: TObject);
    procedure SYSSETClick(Sender: TObject);
    procedure BMEMClick(Sender: TObject);
    procedure BCSTClick(Sender: TObject);
    procedure BMANClick(Sender: TObject);
    procedure M_FMRCINClick(Sender: TObject);

    procedure SYSABOUTClick(Sender: TObject);
    procedure N19Click(Sender: TObject);
    procedure N67Click(Sender: TObject);
    procedure ACLEVERClick(Sender: TObject);
    procedure N83Click(Sender: TObject);
    procedure M_FMPOSMClick(Sender: TObject);
    procedure M_FMPOSNClick(Sender: TObject);
    procedure N78Click(Sender: TObject);
    procedure N81Click(Sender: TObject);

    procedure M_RPPOS3Click(Sender: TObject);
    procedure M_RPPOS5Click(Sender: TObject);
    procedure M_RPPOS6Click(Sender: TObject);
    procedure M_RPPOS7Click(Sender: TObject);
    procedure N39Click(Sender: TObject);
    procedure N40Click(Sender: TObject);
    procedure N211Click(Sender: TObject);
    procedure M_FMRCINBClick(Sender: TObject);
    procedure INVOICEClick(Sender: TObject);
    procedure AARGOXClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SYSLOGClick(Sender: TObject);
    procedure BTNQUTClick(Sender: TObject);
    procedure N76Click(Sender: TObject);
    procedure DCOLLECTClick(Sender: TObject);
    procedure BTNRPTClick(Sender: TObject);
  private
    { Private declarations }
    CREATE_LOGIN : BOOLEAN;
  public
    { Public declarations }
    PROCEDURE CREATE_LBDS(T_FILENAME:STRING);
  end;


var
  FMMAIN: TFMMAIN;

implementation

uses INIFILES, FILECTRL, UN_UTL, FM_UTL, DB_UTL, SYSINI,
     Mapi,


     UNBMAN, UNBMAND, //����ģ��

     UNBMEM, UNBMEMD, //��Աģ��

     UNBCST, UNBCSTD, //�ͻ�ģ��


     UNPOSM, UNPOSMD, //�ؼ�ģ��
     UNPOSN, UNPOSND, //���ģ��


     UNRCIN, UNRCIND, //����ģ��
     UNRCJN, UNRCJND, //�����˻�ģ��


     UNRPTX, //������ѡ��ģ��


     RPPOS3F,    //��Ա���Ѽ�¼��ϸ��

     RPPOS5F,    //��Ա���Ѽ��㱨��
     RPPOS6F,    //��Ʒ���ۼ��㱨��
     RPPOS7F,    //��ȯˢ����ϸ��

     RPTOP1F,    // ��Ʒ�������Гs
     RPTOP2F,    // ��Ա�������Гs
     RPTOP3F,    // �ͻ��������Гs
     RPLOGF,     // ʹ���ߵ�¼��

     UNCCAW, //ģ�ʳ齱
     UNKCLR, //��ʷ�������

     UNLBDS, //��ǩ�Ű����
     UNREP1, //�����Ű����

     URCOLLECT, // ���� �����ռ���
     URCLEVER, // ���� CLEVER
     URARGOX,  // ���� ARGOX
     URINVOICE,  // ���� ��Ʊ��

     UNABOUT,
     LOGO,
     SYSLOG,   // LOGIN
     UNEMAIL,  // ������Ӧ��

     MAIND,
     MAINS,
     MAINR,  //��¼����
     MAINU;


{$R *.DFM}


PROCEDURE TFMMAIN.CREATE_LBDS(T_FILENAME:STRING);
begin
  //���õ���  //��ӡ��ǩ
  IF FormExists('FRARGOX')  =FALSE THEN Application.CreateForm(TFRARGOX,  FRARGOX  );
  IF FormExists('FRCLEVER') =FALSE THEN Application.CreateForm(TFRCLEVER, FRCLEVER );
  IF FormExists('FMLBDS')   =FALSE THEN Application.CreateForm(TFMLBDS,   FMLBDS   );

  FMLBDS.HIDE;
  FMLBDS.QR_NAME := T_FILENAME;
  FMLBDS.LOAD_INI;
end;
procedure TFMMAIN.SYSQUITClick(Sender: TObject);
begin
  CLOSE;
end;

procedure TFMMAIN.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Timer1.Enabled := False;
  FMMAIN.RELEASE;
end;
procedure TFMMAIN.Timer1Timer(Sender: TObject);
begin
  IF _USER_ID =  '' THEN StatusBar.Panels.Items[0].Text := 'Ŀǰû��ʹ���ߵ���';
  IF _USER_ID <> '' THEN
    StatusBar.Panels.Items[0].Text :=
    'ʹ���� '+_USER_ID+' '+_USER_NAME+'  ����ʱ��:'+DATETIMETOSTR(_USER_LOGINDATETIME);

  StatusBar.Panels.Items[1].Text := 'ϵͳ����: '+DATETOSTR(DATE)+'   ϵͳʱ��: '+ TIMETOSTR(NOW);
end;

procedure TFMMAIN.SYSABOUTClick(Sender: TObject);
begin
  IF FormExists('FMABOUT' )=FALSE THEN Application.CreateForm(TFMABOUT,  FMABOUT   );
  Form_NORMAL_SHOW(FMABOUT,-1,-1);
end;


procedure TFMMAIN.SYSSETClick(Sender: TObject);
VAR I : REAL;
begin
  //���Ȩ��============================================
  IF PERMISSION_CHECK(_USER_ID,'SET_MAINS') = FALSE THEN EXIT;

  IF FormExists('FMMAINS')=FALSE THEN Application.CreateForm(TFMMAINS, FMMAINS);
  Form_NORMAL_SHOWMODAL(FMMAINS,-1,-1);
end;


procedure TFMMAIN.SYSLOGClick(Sender: TObject);
begin
  IF FormExists('FMLOG')=FALSE THEN Application.CreateForm(TFMLOG, FMLOG);
  Form_NORMAL_SHOWMODAL(FMLOG,-1,-1);
end;

procedure TFMMAIN.BMANClick(Sender: TObject);
begin
  //���Ȩ��============================================
  IF PERMISSION_CHECK(_USER_ID,'BMAN_OPEN') = FALSE THEN EXIT;

  IF FormExists('FMBMAN' )=FALSE THEN Application.CreateForm(TFMBMAN ,  FMBMAN   );
  Form_NORMAL_SHOW(FMBMAN,-1,-1);
end;

procedure TFMMAIN.BMEMClick(Sender: TObject);
begin
  //���Ȩ��============================================
  IF PERMISSION_CHECK(_USER_ID,'BMEM_OPEN') = FALSE THEN EXIT;

  IF FormExists('FMBMEM' )=FALSE THEN Application.CreateForm(TFMBMEM ,  FMBMEM   );
  Form_NORMAL_SHOW(FMBMEM,-1,-1);
end;



procedure TFMMAIN.FormCreate(Sender: TObject);
VAR T : Tinifile;     // LOG FILE
    INIFILENAME: STRING;
    PATHNAME , T_PATH: STRING;
    SERVER_KIND : STRING;
    I : INTEGER;
begin
  VAR_DECLARE_INI;  //����ϵͳ����
  VAR_DECLARE_ODBC; //����SYSINI��Ԫ�����Զ�����ODBC����ODBC�д�����Ҫ�õ������ݿ����      
  //INIFILENAME := _SYS_PATH_INI + 'MAIN.INI';
  //IF FileExists(INIFILENAME) = FALSE  THEN FILE_CREATE(INIFILENAME);

  //��һ�μ���ϵͳ
  INIFILENAME := _SYS_PATH_INI + 'START.INI';
  IF FileExists(INIFILENAME) = FALSE  THEN
     BEGIN
     FILE_CREATE(INIFILENAME);
     //���Ŀ¼�Ƿ����
     T_PATH := ExtractFilePath(Application.EXEName)+ 'DATAIN';
     IF NOT DirectoryExists(T_PATH) THEN CreateDir(T_PATH);
     T_PATH := ExtractFilePath(Application.EXEName)+ 'DATAOUT';
     IF NOT DirectoryExists(T_PATH) THEN CreateDir(T_PATH);
     T_PATH := ExtractFilePath(Application.EXEName)+ 'INI';
     IF NOT DirectoryExists(T_PATH) THEN CreateDir(T_PATH);
     T_PATH := ExtractFilePath(Application.EXEName)+ 'LOG';
     IF NOT DirectoryExists(T_PATH) THEN CreateDir(T_PATH);
     END;
  TRY
     FMMAIND.Database.Connected := TRUE; // �������ݿ�
  EXCEPT
    SHOWMESSAGE('���ݿ��޷�����, �����ú����ݿ������¼���!');
    CLOSE;
  END;
  //��������   //ϵͳĬ��ֵ ============================================
  _SYS_CFG_DBKIND   := UNSET_READ_SIN ('_SYS_CFG_DBKIND' ); // ���ݿ�����
  _SYS_CFG_BARPRN   := UNSET_READ_SIN ('_SYS_CFG_BARPRN' ); // �������,Ԥ�����
  
  
  //����ֵ(ACCESS��SQL SEVER�滻)
  IF (_SYS_CFG_DBKIND <> 1)  THEN
     BEGIN
     _DBKIND  := 'ACCESS';  // SERVER KIND (ACCESS��SQL SEVER�滻)
     _DT      := '#';
     END ELSE BEGIN
     _DBKIND  := 'SQLSERVER';  // SERVER KIND (ACCESS��SQL SEVER�滻)
     _DT      := '''';
     END;
  
  
  //ʹ��������
  _USER_CORP_RBPST  := UNSET_READ_SME ('_SYS_CORP_RBPST' );
  _USER_CORP_NAME   := UNSET_READ_SME ('_SYS_CORP_NAME' );
  _USER_CORP_NO     := UNSET_READ_SME ('_SYS_CORP_NO' );
  _USER_CORP_TEL    := UNSET_READ_SME ('_SYS_CORP_TEL' );
  _USER_CORP_FAX    := UNSET_READ_SME ('_SYS_CORP_FAX' );
  _USER_CORP_ADDR   := UNSET_READ_SME ('_SYS_CORP_ADDR' );
  _USER_CORP_EMAIL  := UNSET_READ_SME ('_SYS_CORP_EMAIL' );
  _USER_CORP_WWW    := UNSET_READ_SME ('_SYS_CORP_WWW' );

  //���������//==========================================================
  IF IsCPUID_Available = FALSE THEN BEGIN SHOWMESSAGE('�Բ���, ����������������ļ����!');  CLOSE;   EXIT;   END;
  IF REGISTER_KEY_CHECK('\Software\WEB')= FALSE THEN REGISTER_POS_CREATE('\Software\WEB');
  StatusBar.Panels.Items[2].Text := '���������: '+GetCPUVendor;
  
  
  FMMAIN.Height := 150;
  I := UNSET_READ_SIN('_SYS_SET_MAINHT');
  IF I >=150 THEN FMMAIN.Height := I;
  T_STR := UNSET_READ_SST('_SYS_SET_MAINCR');
  IF T_STR <> '' THEN FMMAIN.COLOR := STRINGTOCOLOR(T_STR);
  FMMAIN.Caption := UNSET_READ_SME('_SYS_SET_MAINCP');
end;

procedure TFMMAIN.FormShow(Sender: TObject);
VAR I         : INTEGER;
    T_USES_DAY: REAL;
    T_BG : STRING;
begin

  IF REGISTER_KEY_VALUE_STR('\Software\WEB','SF_ID') <> REGISTER_NUMBER_POS(GetCPUID[4]) THEN
     BEGIN
     IF FormExists('FMAINR')=FALSE THEN Application.CreateForm(TFMMAINR, FMMAINR );
     FMMAINR.SHOWMODAL;
  
     //�����Ƿ����
     T_USES_DAY := DATE - REGISTER_KEY_VALUE_DATE('\Software\WEB','RUN_FIRST_DATE');
     {IF (T_USES_DAY > 90) OR (T_USES_DAY <  0) THEN}  // 90������
     if False then                                     // ���κ�ʹ��ʱ������!!!
        BEGIN
        SHOWMESSAGE('�����Ϊ��׼��, '+#10#13+'��Ҫ�Ϸ��������ۺ����, ��Ǣ����˾ !');
        CLOSE;
        EXIT;
        END;
  
     END ELSE BEGIN // �ѵ�¼���
     IF FileExists('\SYSTEM.SYS') = FALSE  THEN FILE_CREATE('\SYSTEM.SYS');
     END;
  IF UNSET_READ_SBL ('_SYS_SET_LOGIN') = TRUE THEN
     BEGIN
     IF FormExists('FMLOG')=FALSE THEN Application.CreateForm(TFMLOG, FMLOG);
     _SUPER_USER := FALSE;
     FMLOG.LOGIN_NAME := '��̨';
     Form_NORMAL_SHOWMODAL(FMLOG,-1,-1);


     END;
  //��ʾ��ͼ
  T_BG := UNSET_READ_SME('_SYS_SET_MAINBG');
  IF FileExists(T_BG) = TRUE THEN FMMAIN.Image_BG.Picture.LoadFromFile(T_BG);
     
end;



procedure TFMMAIN.BCSTClick(Sender: TObject);
begin
  //���Ȩ��============================================
  IF PERMISSION_CHECK(_USER_ID,'BCST_OPEN') = FALSE THEN EXIT;

  IF FormExists('FMBCST' )=FALSE THEN Application.CreateForm(TFMBCST ,  FMBCST   );
  Form_NORMAL_SHOW(FMBCST,-1,-1);
end;

procedure TFMMAIN.M_FMPOSMClick(Sender: TObject);
begin
  //���Ȩ��============================================
  IF PERMISSION_CHECK(_USER_ID,'POSM_OPEN') = FALSE THEN EXIT;

  IF FormExists('FMPOSM' )=FALSE THEN Application.CreateForm(TFMPOSM ,  FMPOSM   );
  Form_NORMAL_SHOW(FMPOSM,-1,-1);
end;

procedure TFMMAIN.M_FMPOSNClick(Sender: TObject);
begin
  //���Ȩ��============================================
  IF PERMISSION_CHECK(_USER_ID,'POSN_OPEN') = FALSE THEN EXIT;

  IF FormExists('FMPOSN' )=FALSE THEN Application.CreateForm(TFMPOSN ,  FMPOSN   );
  Form_NORMAL_SHOW(FMPOSN,-1,-1);
end;

procedure TFMMAIN.M_FMRCINClick(Sender: TObject);
begin
  IF FormExists('FMRCIN' )=FALSE THEN Application.CreateForm(TFMRCIN , FMRCIN   );
  Form_NORMAL_SHOW(FMRCIN,-1,-1);
end;

procedure TFMMAIN.M_FMRCINBClick(Sender: TObject);
begin
  IF FormExists('FMRCJN' )=FALSE THEN Application.CreateForm(TFMRCJN , FMRCJN   );
  Form_NORMAL_SHOW(FMRCJN,-1,-1);
end;






procedure TFMMAIN.N19Click(Sender: TObject);
begin
  IF FormExists('FMCCAW' )=FALSE THEN Application.CreateForm(TFMCCAW ,  FMCCAW   );
  Form_NORMAL_SHOW(FMCCAW,-1,-1);
end;

procedure TFMMAIN.N67Click(Sender: TObject);
begin
  IF FormExists('FMKCLR' )=FALSE THEN Application.CreateForm(TFMKCLR ,  FMKCLR   );
  Form_NORMAL_SHOW(FMKCLR,-1,-1);
end;

procedure TFMMAIN.ACLEVERClick(Sender: TObject);
begin
  //���Ȩ��============================================
  IF PERMISSION_CHECK(_USER_ID,'SET_HARD') = FALSE THEN EXIT;

  IF FormExists('FRCLEVER' )=FALSE THEN Application.CreateForm(TFRCLEVER , FRCLEVER );
  Form_NORMAL_SHOWMODAL(FRCLEVER,-1,-1);
end;

procedure TFMMAIN.AARGOXClick(Sender: TObject);
begin
  //���Ȩ��============================================
  IF PERMISSION_CHECK(_USER_ID,'SET_HARD') = FALSE THEN EXIT;

  IF FormExists('FRARGOX' )=FALSE THEN Application.CreateForm(TFRARGOX , FRARGOX );
  Form_NORMAL_SHOWMODAL(FRARGOX,-1,-1);
end;

procedure TFMMAIN.DCOLLECTClick(Sender: TObject);
begin
  //���Ȩ��============================================
  IF PERMISSION_CHECK(_USER_ID,'SET_HARD') = FALSE THEN EXIT;

  IF FormExists('FRCOLLECT' )=FALSE THEN Application.CreateForm(TFRCOLLECT , FRCOLLECT );
  Form_NORMAL_SHOWMODAL(FRCOLLECT,-1,-1);
end;


procedure TFMMAIN.INVOICEClick(Sender: TObject);
begin
  //���Ȩ��============================================
  IF PERMISSION_CHECK(_USER_ID,'SET_HARD') = FALSE THEN EXIT;

  IF FormExists('FRINVOICE' )=FALSE THEN Application.CreateForm(TFRINVOICE , FRINVOICE );
  Form_NORMAL_SHOWMODAL(FRINVOICE,-1,-1);
end;
//==============================================================================









//==============================================================================
procedure TFMMAIN.N78Click(Sender: TObject);
begin
  //���Ȩ��============================================
  IF PERMISSION_CHECK(_USER_ID,'SET_LABEL') = FALSE THEN EXIT;

  IF FormExists('FRCLEVER')=FALSE THEN Application.CreateForm(TFRCLEVER,  FRCLEVER  );
  IF FormExists('FRARGOX')=FALSE THEN Application.CreateForm(TFRARGOX,  FRARGOX  );
  IF FormExists('FMLBDS')=FALSE THEN Application.CreateForm(TFMLBDS, FMLBDS);

  FMLBDS.QR_NAME := _QRBMEM; //���õ���  //��ӡ��ǩ
  FMLBDS.QR_NAME := ExtractFilePath(Application.EXEName)+'QR.ini';
  FMLBDS.LOAD_INI;
  FMLBDS.SHOWMODAL;
end;

procedure TFMMAIN.N81Click(Sender: TObject);
begin
  //���Ȩ��============================================
  IF PERMISSION_CHECK(_USER_ID,'SET_LABEL') = FALSE THEN EXIT;
 
  IF FormExists('FRCLEVER')=FALSE THEN Application.CreateForm(TFRCLEVER,  FRCLEVER  );
  IF FormExists('FRARGOX')=FALSE THEN Application.CreateForm(TFRARGOX,  FRARGOX  );
  IF FormExists('FMLBDS')=FALSE THEN Application.CreateForm(TFMLBDS, FMLBDS);
 
  FMLBDS.QR_NAME := _QRBMAD; //���õ���  //��ӡ��ǩ
  FMLBDS.QR_NAME := ExtractFilePath(Application.EXEName)+'QR.ini';
  FMLBDS.LOAD_INI;
  FMLBDS.SHOWMODAL;
end;

procedure TFMMAIN.N83Click(Sender: TObject);
begin
  //���Ȩ��============================================
  IF PERMISSION_CHECK(_USER_ID,'SET_LABEL') = FALSE THEN EXIT;
 
  IF FormExists('FRCLEVER')=FALSE THEN Application.CreateForm(TFRCLEVER,  FRCLEVER  );
  IF FormExists('FRARGOX')=FALSE THEN Application.CreateForm(TFRARGOX,  FRARGOX  );
  IF FormExists('FMLBDS')=FALSE THEN Application.CreateForm(TFMLBDS, FMLBDS);
 
  FMLBDS.QR_NAME := _QRBGDS; //���õ���  //��ӡ��ǩ
  FMLBDS.QR_NAME := ExtractFilePath(Application.EXEName)+'QR.ini';
  FMLBDS.LOAD_INI;
  FMLBDS.SHOWMODAL;
end;
//==============================================================================

   
procedure TFMMAIN.M_RPPOS3Click(Sender: TObject);
begin
  IF PERMISSION_CHECK(_USER_ID,'RPT_POS3') = FALSE THEN EXIT; //���Ȩ��============================================

  IF FormExists('RMPOS3F')=FALSE THEN Application.CreateForm(TRMPOS3F,  RMPOS3F  );
  Form_NORMAL_SHOW(RMPOS3F,-1,-1);
end;

procedure TFMMAIN.M_RPPOS5Click(Sender: TObject);
begin
  IF PERMISSION_CHECK(_USER_ID,'RPT_POS5') = FALSE THEN EXIT; //���Ȩ��============================================
 
  IF FormExists('RMPOS5F')=FALSE THEN Application.CreateForm(TRMPOS5F,  RMPOS5F  );
  Form_NORMAL_SHOW(RMPOS5F,-1,-1);
end;

procedure TFMMAIN.M_RPPOS6Click(Sender: TObject);
begin
  IF PERMISSION_CHECK(_USER_ID,'RPT_POS6') = FALSE THEN EXIT; //���Ȩ��============================================
 
  IF FormExists('RMPOS6F')=FALSE THEN Application.CreateForm(TRMPOS6F,  RMPOS6F  );
  Form_NORMAL_SHOW(RMPOS6F,-1,-1);
end;

procedure TFMMAIN.M_RPPOS7Click(Sender: TObject);
begin
  IF PERMISSION_CHECK(_USER_ID,'RPT_POS7') = FALSE THEN EXIT; //���Ȩ��============================================
 
  IF FormExists('RMPOS7F')=FALSE THEN Application.CreateForm(TRMPOS7F,  RMPOS7F  );
  Form_NORMAL_SHOW(RMPOS7F,-1,-1);
end;

procedure TFMMAIN.N39Click(Sender: TObject);
begin
  IF PERMISSION_CHECK(_USER_ID,'RPT_TOP1') = FALSE THEN EXIT; //���Ȩ��============================================
 
  IF FormExists('RMTOP1F')=FALSE THEN Application.CreateForm(TRMTOP1F, RMTOP1F );
  Form_NORMAL_SHOW(RMTOP1F,-1,-1);
end;

procedure TFMMAIN.N40Click(Sender: TObject);
begin
  IF PERMISSION_CHECK(_USER_ID,'RPT_TOP2') = FALSE THEN EXIT; //���Ȩ��============================================
 
  IF FormExists('RMTOP2F')=FALSE THEN Application.CreateForm(TRMTOP2F, RMTOP2F );
  Form_NORMAL_SHOW(RMTOP2F,-1,-1);
end;

procedure TFMMAIN.N211Click(Sender: TObject);
begin
  IF PERMISSION_CHECK(_USER_ID,'RPT_TOP3') = FALSE THEN EXIT; //���Ȩ��============================================
 
  IF FormExists('RMTOP3F')=FALSE THEN Application.CreateForm(TRMTOP3F, RMTOP3F );
  Form_NORMAL_SHOW(RMTOP3F,-1,-1);
end;


procedure TFMMAIN.N76Click(Sender: TObject);
begin
  IF PERMISSION_CHECK(_USER_ID,'RPT_LOG') = FALSE THEN EXIT; //���Ȩ��============================================

   IF FormExists('RMLOGF')=FALSE THEN Application.CreateForm(TRMLOGF, RMLOGF );
   Form_NORMAL_SHOW(RMLOGF,-1,-1);
end;




procedure TFMMAIN.SpeedButton1Click(Sender: TObject);
begin
  IF FormExists('FMEMAIL' )=FALSE THEN Application.CreateForm(TFMEMAIL, FMEMAIL );
  Form_NORMAL_SHOW(FMEMAIL,-1,-1);
end;


procedure TFMMAIN.BTNQUTClick(Sender: TObject);
begin
  CLOSE;
end;
//==============================================================================












procedure TFMMAIN.BTNRPTClick(Sender: TObject);
begin
  IF FormExists('FMRPTX')=FALSE THEN Application.CreateForm(TFMRPTX, FMRPTX );
  Form_NORMAL_SHOW(FMRPTX,-1,-1);
end;

end.
