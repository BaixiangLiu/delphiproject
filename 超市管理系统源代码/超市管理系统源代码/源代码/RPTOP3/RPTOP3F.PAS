unit RPTOP3F;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, StdCtrls, JEdit, Spin, Buttons, ExtCtrls, JLOOKUP;

type
  TRMTOP3F = class(TForm)
    Panel1: TPanel;
    BTNPRN: TSpeedButton;
    BTNPRE: TSpeedButton;
    BTNQUT: TSpeedButton;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    CN1: TSpinEdit;
    QTOP3F: TQuery;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    LB31: TJEdit;
    LB32: TJEdit;
    LB21: TJEdit;
    LB22: TJEdit;
    LB11: JLOOKUPBOX;
    QTOP3FBCENO: TStringField;
    QTOP3FBCNAM: TStringField;
    QTOP3FBCCNA: TStringField;
    QTOP3FBCSCN: TStringField;
    QTOP3FBCMN1: TStringField;
    QTOP3FBCMN2: TStringField;
    QTOP3FBCMN3: TStringField;
    QTOP3FBCTL1: TStringField;
    QTOP3FBCTL2: TStringField;
    QTOP3FBCFX1: TStringField;
    QTOP3FBCFX2: TStringField;
    QTOP3FBCAD1: TStringField;
    QTOP3FBCAD2: TStringField;
    QTOP3FBCZP1: TStringField;
    QTOP3FBCZP2: TStringField;
    QTOP3FBCTL9: TStringField;
    QTOP3FBCAD9: TStringField;
    QTOP3FBCZP9: TStringField;
    QTOP3FBCDIS: TFloatField;
    QTOP3FBCTP1: TFloatField;
    QTOP3FBCTP2: TFloatField;
    QTOP3FBCTP5: TFloatField;
    QTOP3FBCTP6: TFloatField;
    QTOP3FBCTPN: TStringField;
    QTOP3FBCTTP: TStringField;
    QTOP3FBCTTD: TFloatField;
    QTOP3FBCTEG: TStringField;
    QTOP3FBCTBK: TStringField;
    QTOP3FBCALT: TFloatField;
    QTOP3FBCTDT: TDateTimeField;
    QTOP3FBCDAT: TDateTimeField;
    QTOP3FBCID1: TStringField;
    QTOP3FBCMRK: TMemoField;
    QTOP3FBNENO: TStringField;
    procedure BTNQUTClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure BTNPREClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RMTOP3F: TRMTOP3F;

implementation

uses SYSINI, DB_UTL, FM_UTL, UN_UTL, RPTOP3P, MAINU;

{$R *.DFM}
                                           
procedure TRMTOP3F.FormCreate(Sender: TObject);
begin

//按钮图形加载
BTNPRN.Glyph := PRN_TB;
BTNPRE.Glyph := PRE_TB;
BTNQUT.Glyph := QUT_TB;

IF FormExists('RMTOP3P')=FALSE THEN Application.CreateForm(TRMTOP3P, RMTOP3P );

//预设日期
LB31.Text := REGISTER_LOAD_OBJECT_STR('\MICROPOS\RPTOP3F\LB31',LB31.TEXT);
LB32.Text := REGISTER_LOAD_OBJECT_STR('\MICROPOS\RPTOP3F\LB32',LB32.TEXT);
IF (TRIM(LB31.Text) = '') AND (TRIM(LB32.Text) = '') THEN LB11.Text := EDATE_TO_CDATE(DATETOSTR(DATE));


end;

procedure TRMTOP3F.FormShow(Sender: TObject);
begin
LB11.SETFOCUS;
end;

procedure TRMTOP3F.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//日期存盘
REGISTER_SAVE_OBJECT_STR('\MICROPOS\RPTOP3F\LB31',LB31.Text);
REGISTER_SAVE_OBJECT_STR('\MICROPOS\RPTOP3F\LB32',LB32.Text);

RMTOP3F.Release;
RMTOP3P.Release;
end;

procedure TRMTOP3F.BTNQUTClick(Sender: TObject);
begin
CLOSE;
end;

procedure TRMTOP3F.BTNPREClick(Sender: TObject);
VAR T_TOP : STRING;
begin
T_TOP := '1';
IF CN1.Value >= 1 THEN T_TOP := CN1.TEXT;


//检查日期
IF CHECK_CDATE(LB31.Text,TRUE) = FALSE THEN LB31.SetFocus;
//IF CHECK_CDATE(LB32.Text,TRUE) = FALSE THEN LB32.SetFocus;
IF CHECK_CDATE(LB31.Text,FALSE) = FALSE THEN EXIT;
//IF CHECK_CDATE(LB32.Text,FALSE) = FALSE THEN EXIT;




  WITH QTOP3F DO
  BEGIN
    CLOSE;
    SQL.CLEAR;
    SQL.ADD('SELECT TOP '+T_TOP+' * FROM BCST ');
    SQL.ADD('WHERE BCENO IS NOT NULL');

    //字符串查询
    SQL.ADD(FINDFORM_WHEREKEY_STRING('BCENO',LB11.Text,''));
    SQL.ADD(FINDFORM_WHEREKEY_INTEGER('BCALT',LB21.Text,LB22.Text));

    //ACCESS " DATE " WHERE KEY  ======================
    SQL.ADD(FINDFORM_WHEREKEY_DATE('BCTDT',LB31.Text,LB32.Text));

    SQL.ADD('order by BCALT DESC');

//    SHOWMESSAGE(SQL.TEXT);
    OPEN;
  END;






  WITH RMTOP3P DO
  BEGIN
  LBTITLE.Caption     := RMTOP3F.Caption;
  LB_USER_CORP_RBPST.Caption := _USER_CORP_RBPST ;
  LB_USER_CORP_NAME .Caption := _USER_CORP_NAME  ;
  LB_USER_CORP_NO   .Caption := _USER_CORP_NO    ;
  LB_USER_CORP_TEL  .Caption := _USER_CORP_TEL   ;
  LB_USER_CORP_FAX  .Caption := _USER_CORP_FAX   ;
  LB_USER_CORP_ADDR .Caption := _USER_CORP_ADDR  ;

  ED_DAT1.Caption := LB31.TEXT;
  ED_DAT2.Caption := LB32.TEXT;


  IF QTOP3F.EOF = TRUE THEN
    BEGIN
    SHOWMESSAGE('没有此资料');
    LB11.SETFOCUS;
    END ELSE BEGIN
    IF SENDER = BTNPRE THEN RMTOP3P.QuickRep.Preview;
    IF SENDER = BTNPRN THEN RMTOP3P.QuickRep.Print;
    END;

  END;


end;

end.
