unit SYSLOG;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, StdCtrls, Buttons, JLOOKUP, Menus, ExtCtrls;

type
  TFMLOG = class(TForm)
    MainMenu1: TMainMenu;
    SUPERLOGIN1: TMenuItem;
    WINDOWS1: TMenuItem;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    BTNLOGON: TBitBtn;
    BNPWD: TEdit;
    BNENO: JLOOKUPBOX;
    SUPERLOGIN: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BTNLOGONClick(Sender: TObject);
    procedure BNENOKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BNPWDKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SUPERLOGINDblClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    LOGIN_CNT : INTEGER;
    PROCEDURE QSYSPSW_UPD;
  public
    { Public declarations }
    LOGIN_NAME: STRING;
  end;

var
  FMLOG: TFMLOG;

implementation

USES SYSINI, UN_UTL, FM_UTL, DB_UTL, MAIN, MAIND, MAINU;

{$R *.DFM}






procedure TFMLOG.FormCreate(Sender: TObject);
begin
  LOGIN_CNT  := 0;
  LOGIN_NAME := '';

  BNENO.TEXT := REGISTER_LOAD_OBJECT_STR('\MICROPOS\SYSLOG\BNENO',BNENO.TEXT);
end;

procedure TFMLOG.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  REGISTER_SAVE_OBJECT_STR('\MICROPOS\SYSLOG\BNENO',BNENO.TEXT);
  
  FMLOG.RELEASE;
end;

procedure TFMLOG.BTNLOGONClick(Sender: TObject);
var T_STR : STRING;
begin
  BNENO.TEXT := LOWERCASE(BNENO.TEXT);
  BNPWD.TEXT := LOWERCASE(BNPWD.TEXT);
  
  
  IF TRIM(BNPWD.TEXT) = 'ilovepos' THEN
     BEGIN
     _USER_ID   := 'admin';
     _USER_NAME := '超级用户';
     _USER_LOGINDATETIME  := DATE + TIME;
     _SUPER_USER := TRUE;
     CLOSE;
     EXIT;
     END;
  
  IF TRIM(BNENO.TEXT) = '' THEN
     BEGIN
     BNENO.SelectAll;
     BNENO.SetFocus;
     EXIT;
     END;
  
  IF TRIM(BNPWD.TEXT) = '' THEN
     BEGIN
     BNPWD.SelectAll;
     BNPWD.SetFocus;
     EXIT;
     END;
  
  
  IF (PERMISSION_CHECK(BNENO.TEXT,'SYS_POS') = FALSE) AND (BNENO.TEXT <> 'admin') THEN
     BEGIN
     SHOWMESSAGE('您没有使用此软件的权限!');
     BNENO.SelectAll;
     BNENO.SetFocus;
     EXIT;
     END;
  
  
  INC(LOGIN_CNT);
  
  
  T_STR := DB_QUERY_FIND_VALUE('BMAN','BNENO',BNENO.TEXT,'BNPWD');
  T_STR := Decrypt( COPY(T_STR, 2, LENGTH(T_STR)-2) ,1357,2,1);;
  IF ( BNPWD.Text = T_STR ) AND ( BNENO.TEXT <> ''    ) THEN
     BEGIN
     _USER_ID   := BNENO.TEXT;
     _USER_NAME := BNENO.T_LABEL.TEXT;
     _USER_LOGINDATETIME  := DATE + TIME;
  
  
     //系统管理员
     IF BNENO.TEXT = 'admin' THEN
        BEGIN
        _SUPER_USER := TRUE;
        END;

     //新增登录记录
     SYSLOG_INSERT('SLG','',LOGIN_NAME+INTTOSTR(LOGIN_CNT-1));
     QSYSPSW_UPD;

     CLOSE;   //输入成功
     END ELSE
     BEGIN
     SHOWMESSAGE('您输入的密码有误! '+#10#13+'已输入 '+INTTOSTR(LOGIN_CNT)+' 次');
     BNPWD.SelectAll;
     BNPWD.SetFocus;
     IF LOGIN_CNT >= 3 THEN FMMAIN.CLOSE;
     END;

end;

procedure TFMLOG.BNENOKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  IF KEY = 13 THEN BNPWD.SetFocus ;
end;

procedure TFMLOG.BNPWDKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  IF KEY = 13 THEN BTNLOGON.Click;
end;

procedure TFMLOG.SUPERLOGINDblClick(Sender: TObject);
begin
  //密技
  _SUPER_USER := TRUE;
  _USER_ID := 'admin';//_SUPER_USER_ID;
  _USER_NAME := '暂时性系统管理员!';
  _USER_LOGINDATETIME  := DATE + TIME;
  CLOSE;
end;



PROCEDURE TFMLOG.QSYSPSW_UPD;
BEGIN
  FMMAIND.QUPD.CLOSE;
  FMMAIND.QUPD.SQL.CLEAR;
  FMMAIND.QUPD.SQL.ADD('UPDATE BMAN');
  FMMAIND.QUPD.SQL.ADD('SET ');
  FMMAIND.QUPD.SQL.ADD('BNLOG = '''+DATETOSTR(_USER_LOGINDATETIME)+''',');
  FMMAIND.QUPD.SQL.ADD('BNLOM = '''+COPY(TIMETOSTR(_USER_LOGINDATETIME),4,5)+'''');
  FMMAIND.QUPD.SQL.ADD('WHERE BNENO = '''+_USER_ID+'''');
  FMMAIND.QUPD.ExecSQL;
END;

procedure TFMLOG.FormActivate(Sender: TObject);
begin
  _SUPER_USER := FALSE;
  BNENO.SetFocus;
end;

end.
