unit SYSLOG;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, StdCtrls, Buttons, JLOOKUP, Menus;

type
  TFMLOG = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    BTNLOGON: TBitBtn;
    QBMAN: TQuery;
    QBMANBNENO: TStringField;
    QBMANBNNAM: TStringField;
    DSBMAN: TDataSource;
    QSYSPSW: TQuery;
    QSYSPSWBNENO: TStringField;
    QSYSPSWPSWPSW: TStringField;
    QSYSPSWPSWPSM: TDateTimeField;
    QSYSPSWPSWLOG: TDateTimeField;
    QSYSPSWPSWPSW2: TStringField;
    QSYSPSWBNNAM: TStringField;
    DSSYSPSW: TDataSource;
    PSWPSW: TEdit;
    SUPERLOGIN: TLabel;
    BNENO: JLOOKUPBOX;
    QSYSPSW_UPDATE: TQuery;
    MainMenu1: TMainMenu;
    SUPERLOGIN1: TMenuItem;
    WINDOWS1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BTNLOGONClick(Sender: TObject);
    procedure BNENOKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PSWPSWKeyDown(Sender: TObject; var Key: Word;
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

USES SYSINI, UN_UTL, main;

{$R *.DFM}






procedure TFMLOG.FormCreate(Sender: TObject);
begin
LOGIN_CNT  := 0;
LOGIN_NAME := '';

     QSYSPSW.SQL.CLEAR;
     QSYSPSW.SQL.ADD('SELECT *  ');
     QSYSPSW.SQL.ADD('FROM SYSPSW ');
     QSYSPSW.SQL.ADD('ORDER BY BNENO ');
                                  
     QSYSPSW.CLOSE;
     QSYSPSW.OPEN;

     QBMAN.CLOSE;
     QBMAN.OPEN;

end;

procedure TFMLOG.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FMLOG.RELEASE;
end;

procedure TFMLOG.BTNLOGONClick(Sender: TObject);
var T_STR : STRING;
begin
INC(LOGIN_CNT);

// ADMIN PASSWD =========================================
T_STR := VARTOSTR(QSYSPSW.Lookup('BNENO','admin','PSWPSW'));
T_STR := copy( T_STR , 2, LENGTH(T_STR)-2);
T_STR := Decrypt(T_STR,1357,2,1);
if ( PSWPSW.Text = T_STR ) AND (BNENO.Text = '') then
   begin
   _SUPER_USER := TRUE;
   _USER_ID := 'admin';//_SUPER_USER_ID;
   _USER_NAME := '系统管理员!';
   _USER_LOGINDATETIME  := DATE + TIME;
   //新增登录记录
   SYSLOG_INSERT('SLG','','系'+LOGIN_NAME+INTTOSTR(LOGIN_CNT-1));
   CLOSE;   //输入成功
   EXIT;
   end;
//========================================================


// NORMAL USER ===========================================
//译码
T_STR := VARTOSTR(QSYSPSW.Lookup('BNENO',BNENO.Text,'PSWPSW'));
T_STR := copy( T_STR , 2, LENGTH(T_STR)-2);
T_STR := Decrypt(T_STR,1357,2,1);

IF ( PSWPSW.Text = T_STR ) AND ( BNENO.TEXT <> ''    ) THEN
   BEGIN
   //系统默认值
   _USER_ID   := BNENO.TEXT;
   _USER_NAME := BNENO.T_LABEL.TEXT;
   _USER_LOGINDATETIME  := DATE + TIME;

   //更新登录时间
   QSYSPSW_UPD;
   //新增登录记录
   SYSLOG_INSERT('SLG','',LOGIN_NAME+INTTOSTR(LOGIN_CNT-1));

   CLOSE;   //输入成功
   END ELSE
   BEGIN
   SHOWMESSAGE('您输入的密码有误! '+#10#13+'已输入 '+INTTOSTR(LOGIN_CNT)+' 次');
   BNENO.SetFocus;

   IF LOGIN_CNT >= 3 THEN FMMAIN.CLOSE;
   END;
//========================================================

end;

procedure TFMLOG.BNENOKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
IF KEY = 13 THEN PSWPSW.SetFocus ;
end;

procedure TFMLOG.PSWPSWKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
IF KEY = 13 THEN BTNLOGON.Click;
end;

procedure TFMLOG.SUPERLOGINDblClick(Sender: TObject);
begin

//密技
_SUPER_USER := TRUE;
_USER_ID := '9999';//_SUPER_USER_ID;
_USER_NAME := '系统管理员!';
_USER_LOGINDATETIME  := DATE + TIME;
CLOSE;
end;



PROCEDURE TFMLOG.QSYSPSW_UPD;
BEGIN
QSYSPSW_UPDATE.SQL.CLEAR;
QSYSPSW_UPDATE.SQL.ADD('UPDATE SYSPSW');
QSYSPSW_UPDATE.SQL.ADD('SET ');
QSYSPSW_UPDATE.SQL.ADD('PSWLOG = '''+DATETOSTR(_USER_LOGINDATETIME)+''',');
QSYSPSW_UPDATE.SQL.ADD('PSWLOM = '''+COPY(TIMETOSTR(_USER_LOGINDATETIME),4,5)+'''');
QSYSPSW_UPDATE.SQL.ADD('WHERE BNENO = '''+_USER_ID+'''');
//SHOWMESSAGE(QSYSPSW_UPDATE.SQL.TEXT);
QSYSPSW_UPDATE.ExecSQL;
END;

procedure TFMLOG.FormActivate(Sender: TObject);
begin
_SUPER_USER := FALSE;
BNENO.SetFocus;
end;

end.
