unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ComCtrls, StdCtrls, JEdit, ExtCtrls, Mask, DBCtrls, FlEdit;

type
  TFMMAIN = class(TForm)
    MainMenu1: TMainMenu;
    Q1: TMenuItem;
    F1: TMenuItem;
    RPPOSD: TMenuItem;
    A8: TMenuItem;
    A9: TMenuItem;
    MNINVOICE: TMenuItem;
    MNDSP: TMenuItem;
    N1: TMenuItem;
    B1: TMenuItem;
    M_INSERT_DATE: TMenuItem;
    S1: TMenuItem;
    TF101: TMenuItem;
    MNPMSG: TMenuItem;
    F1F41: TMenuItem;
    F1F42: TMenuItem;
    F1F43: TMenuItem;
    Image_BG: TImage;
    procedure FormCreate(Sender: TObject);
    procedure F1Click(Sender: TObject);
    procedure Q1Click(Sender: TObject);
    procedure MNINVOICEClick(Sender: TObject);
    procedure MNDSPClick(Sender: TObject);
    procedure A9Click(Sender: TObject);
    procedure RPPOSDClick(Sender: TObject);
    procedure B1Click(Sender: TObject);
    procedure A8Click(Sender: TObject);
    procedure M_INSERT_DATEClick(Sender: TObject);
    procedure S1Click(Sender: TObject);
    procedure TF101Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    CREATE_LOGIN : BOOLEAN;
    FIRST_IN     : BOOLEAN;
  public
    { Public declarations }
  end;

var
  FMMAIN: TFMMAIN;

  POSA_SETFILENAME : STRING;

implementation

uses FILECTRL,
     {MAINU in '..\ch5\main\mainu.pas', }UN_UTL, FM_UTL, DB_UTL, SYSINI, //SYSLOG,

     UNPOSA,
     UNPOSAD,
     UNPOSAS,
{     UNPOSAB,
     UNPOSAT,
     UNPOSAG,
     UNPMSG,
     UNPOSAC,

     RPPOSDF,
     RPPOSDP,
     RPPOSDP1,
}
     URINVOICE,
     URDSP,

     MAINS,
{     MAINSK,
     MAINT,
 }
     MAIND, mainsK;

{$R *.DFM}

procedure TFMMAIN.FormCreate(Sender: TObject);
var I : integer;
begin
// 设置HOT KEY 的INI 文件名
POSA_SETFILENAME := ExtractFilePath(Application.EXEName)+'INI\POSA.INI';
IF FileExists(POSA_SETFILENAME) = FALSE  THEN FILE_CREATE(POSA_SETFILENAME);


VAR_DECLARE_INI;
CREATE_LOGIN := FALSE;
FIRST_IN     := TRUE;

_SUPER_USER := TRUE;
_USER_ID := 'admin';
_USER_LOGINDATETIME  := DATE + TIME;


_TB_INSERT_DATE := DATE; //此笔日期

FMMaind := TFmmaind.Create(Self);
FMMAIND.Database.Connected := TRUE;



LOAD_FRONT_TABLE_VARIBLE;  // 读取前台变量
INVOICE_READ_INI;          // 读取小票打印机变量
DSP_READ_INI;              // 读取客显

{





//日期值(ACCESS和SQL SEVER替换)
IF STRTOINTDEF(UNSETREAD('SYSSET','_DBKIND'),0)= 0 THEN
   BEGIN
   _DT    := '#';
   _TRUE  := 'TRUE';
   _FALSE := 'FALSE';
   END ELSE BEGIN
   _DT  := '''';
   _TRUE  := '1';
   _FALSE := '0';
   END;

//流动客分析资料
ACUS_ASQA1 := UNSETREAD('ACUS','ASQA1');
ACUS_ASQA2 := UNSETREAD('ACUS','ASQA2');
ACUS_ASQA3 := UNSETREAD('ACUS','ASQA3');
ACUS_ASQA4 := UNSETREAD('ACUS','ASQA4');
ACUS_ASQA5 := UNSETREAD('ACUS','ASQA5');
ACUS_ASQB1 := UNSETREAD('ACUS','ASQB1');
ACUS_ASQB2 := UNSETREAD('ACUS','ASQB2');
ACUS_ASQB3 := UNSETREAD('ACUS','ASQB3');
ACUS_ASQB4 := UNSETREAD('ACUS','ASQB4');
ACUS_ASQB5 := UNSETREAD('ACUS','ASQB5');
ACUS_WANT_SHOW := FALSE;
IF UNSETREAD('SYSSET','SET_ACUS')  = '1' THEN
   ACUS_WANT_SHOW := TRUE;


//资料设置   //系统默认值 ============================================
//日期值(ACCESS和SQL SEVER替换)
IF STRTOINTDEF(UNSETREAD('SYSSET','_DBKIND'),0)= 0 THEN
   BEGIN
   _DBKIND  := 'ACCESS';  // SERVER KIND (ACCESS和SQL SEVER替换)
   _DT      := '#';
   _SUMF[0] := 'EXPR1000';
   _SUMF[1] := 'EXPR1001';
   _SUMF[2] := 'EXPR1002';
   _SUMF[3] := 'EXPR1003';
   _SUMF[4] := 'EXPR1004';
   _SUMF[5] := 'EXPR1005';
   _SUMF[6] := 'EXPR1006';
   _SUMF[7] := 'EXPR1007';
   _SUMF[8] := 'EXPR1008';
   _SUMF[9] := 'EXPR1009';
   END ELSE BEGIN
   _DBKIND  := 'SQLSERVER';  // SERVER KIND (ACCESS和SQL SEVER替换)
   _DT      := '''';
   _SUMF[0] := 'COLUMN1';
   _SUMF[1] := 'COLUMN2';
   _SUMF[2] := 'COLUMN3';
   _SUMF[3] := 'COLUMN4';
   _SUMF[4] := 'COLUMN5';
   _SUMF[5] := 'COLUMN6';
   _SUMF[6] := 'COLUMN7';
   _SUMF[7] := 'COLUMN8';
   _SUMF[8] := 'COLUMN9';
   _SUMF[9] := 'COLUMN10';
   END;



//资料设置   //系统默认值 ============================================
_USER_CORP_NAME   := UNSETREAD('SYSSET','CORP_NAME');
_USER_CORP_TEL    := UNSETREAD('SYSSET','CORP_TEL') ;
_USER_CORP_FAX    := UNSETREAD('SYSSET','CORP_FAX') ;
_USER_CORP_ADD    := UNSETREAD('SYSSET','CORP_ADDR');
_USER_CORP_EMAIL  := UNSETREAD('SYSSET','CORP_EMAIL');
_USER_CORP_WWW    := UNSETREAD('SYSSET','CORP_WWW');
 }







  FMMAIN.Height := 150;
  I := UNSET_READ_SIN('_SYS_SET_MAINHT');
  IF I >=150 THEN FMMAIN.Height := I;
  T_STR := UNSET_READ_SST('_SYS_SET_MAINCR');
  IF T_STR <> '' THEN FMMAIN.COLOR := STRINGTOCOLOR(T_STR);
  FMMAIN.Caption := UNSET_READ_SME('_SYS_SET_MAINCP');

 
end;

procedure TFMMAIN.FormShow(Sender: TObject);
var T_BG : STRING;
begin

//IF DATE >= STRTODATE('2000/1/1') THEN CLOSE;;
//IF DATE >= STRTODATE(UNSETREAD('SYSSET','H_SET1')) THEN CLOSE;
//IF DATE >= STRTODATE(UNSETREAD('SYSSET','H_SET1')) THEN SHOWMESSAGE('亲爱的顾客,为了确保您现在数据库的完整,请回电给本公司,由本公司为您作服务,谢谢!');

IF UNSETREAD('SYSSET','S_POSA')    = '0' THEN CLOSE;
IF UNSETREAD('SYSSET','SET_LOGIN') = '0' THEN CREATE_LOGIN := TRUE;



{
IF CREATE_LOGIN = FALSE THEN
   BEGIN

   IF Application.FindComponent('FMLOG')=nil then
      BEGIN
      CREATE_LOGIN := TRUE;

      IF FormExists('FMLOG')=FALSE THEN Application.CreateForm(TFMLOG,FMLOG);

      _SUPER_USER := FALSE;
      FMLOG.LOGIN_NAME := '前台';
      FMLOG.ShowModal;
      END;
   end;
}

IF _SUPER_USER  = TRUE THEN M_INSERT_DATE.Visible := TRUE;



{
IF FIRST_IN = TRUE THEN
   BEGIN
   IF FMMAINS.ED_SET_AUTOF1.Checked = TRUE THEN F1.Click;
   FIRST_IN     := FALSE;
   END;
}

{
// 检查个人信息
_USER_MSG := POS_CHECK_PERSONAL_MESSAGE(_USER_ID);
IF TRIM(_USER_MSG) <> '' THEN
   BEGIN
   IF FormExists('FMPMSG'  )=FALSE THEN Application.CreateForm(TFMPMSG ,FMPMSG  );
   FMPMSG.SHOWMODAL;
   END;
}






  IF _TB_AUTO_SHOWPOSA  = TRUE THEN F1.Click;


  //显示背景图
  T_BG := UNSET_READ_SME('_SYS_SET_MAINBG');
  IF FileExists(T_BG) = TRUE THEN FMMAIN.Image_BG.Picture.LoadFromFile(T_BG);
end;

procedure TFMMAIN.FormClose(Sender: TObject; var Action: TCloseAction);
begin
SAVE_FRONT_TABLE_VARIBLE;  // 储存前台变量






end;

























procedure TFMMAIN.F1Click(Sender: TObject);
begin
//检查权限============================================
//if PERMISSION_CHECK(_USER_ID, 'UNPOSA') = FALSE then   EXIT;

 IF FormExists('FRINVOICE')=FALSE THEN Application.CreateForm(TFRINVOICE,  FRINVOICE  );
 IF FormExists('FRDSP'  )=FALSE THEN Application.CreateForm(TFRDSP  ,  FRDSP    );

 IF FormExists('FMPOSAD')=FALSE THEN Application.CreateForm(TFMPOSAD,  FMPOSAD  );
 IF FormExists('FMPOSA' )=FALSE THEN Application.CreateForm(TFMPOSA ,  FMPOSA   );
 IF FormExists('FMPOSAS')=FALSE THEN Application.CreateForm(TFMPOSAS,  FMPOSAS  );
 FMPOSAS.SHOWMODAL;
 FMPOSA .SHOWMODAL;
end;

procedure TFMMAIN.Q1Click(Sender: TObject);
begin
CLOSE;
end;












procedure TFMMAIN.B1Click(Sender: TObject);
begin
 IF FormExists('FMMAINS')=FALSE THEN Application.CreateForm(TFMMAINS,  FMMAINS );
 FMMAINS.ShowModal;
end;

procedure TFMMAIN.S1Click(Sender: TObject);
begin
  IF FormExists('FMMAINSK')=FALSE THEN Application.CreateForm(TFMMAINSK,  FMMAINSK );
  ////Form_MDI_SHOWMODAL(FMMAINSK,-1,-1);
  FMMAINSK.ShowModal;
end;

procedure TFMMAIN.MNINVOICEClick(Sender: TObject);
begin
 IF FormExists('FRINVOICE')=FALSE THEN Application.CreateForm(TFRINVOICE,  FRINVOICE  );
 FRINVOICE.SHOWMODAL;
end;

procedure TFMMAIN.MNDSPClick(Sender: TObject);
begin
 IF FormExists('FMDSP'  )=FALSE THEN Application.CreateForm(TFRDSP  ,  FRDSP    );
 FRDSP.SHOWMODAL;
end;


procedure TFMMAIN.A8Click(Sender: TObject);
begin
// IF FormExists('FMPOSAB')=FALSE THEN Application.CreateForm(TFMPOSAB,  FMPOSAB  );
// Form_MDI_POSITION(FMPOSAB,-1,-1);
end;

procedure TFMMAIN.A9Click(Sender: TObject);
begin
{   IF Application.FindComponent('FMLOG')=nil then
      BEGIN
      Application.CreateForm(TFMLOG,  FMLOG  );
      FMLOG.LOGIN_NAME := '前台';
      FMLOG.ShowModal;
      END;
IF _SUPER_USER  = TRUE THEN M_INSERT_DATE.Visible := TRUE;
}
end;

procedure TFMMAIN.RPPOSDClick(Sender: TObject);
begin
{
 IF FormExists('FMINVOICE')=FALSE THEN Application.CreateForm(TFMINVOICE,  FMINVOICE  );

 IF FormExists('RMPOSDF')=FALSE THEN Application.CreateForm(TRMPOSDF,  RMPOSDF  );
 IF FormExists('RMPOSDP')=FALSE THEN Application.CreateForm(TRMPOSDP,  RMPOSDP  );
 IF FormExists('RMPOSDP1')=FALSE THEN Application.CreateForm(TRMPOSDP1,  RMPOSDP1  );
 Form_MDI_POSITION(RMPOSDF,-1,-1);
 }
end;

procedure TFMMAIN.TF101Click(Sender: TObject);
begin
// IF FormExists('FMMAINT')=FALSE THEN Application.CreateForm(TFMMAINT,  FMMAINT );
// Form_MDI_SHOWMODAL(FMMAINT,-1,-1);

end;



procedure TFMMAIN.M_INSERT_DATEClick(Sender: TObject);
VAR T_DATE:STRING;
begin
T_DATE := JINPUTBOX('请输入补登日期','请输入中式日期',EDATE_TO_CDATE(DATETOSTR(DATE)));

IF CHECK_CDATE(T_DATE,TRUE) = TRUE THEN _TB_INSERT_DATE := STRTODATE(CDATE_TO_EDATE(T_DATE));
end;




end.
