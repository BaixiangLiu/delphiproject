unit RPTOP1F;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, StdCtrls, JEdit, Spin, Buttons, ExtCtrls;

type
  TRMTOP1F = class(TForm)
    QTOP1F: TQuery;
    QTOP1FBGENO: TStringField;
    QTOP1FBGNAM: TStringField;
    QTOP1FBGKIN: TStringField;
    Panel1: TPanel;
    BTNPRN: TSpeedButton;
    BTNPRE: TSpeedButton;
    BTNQUT: TSpeedButton;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    CN1: TSpinEdit;
    WK1: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    LB11: TJEdit;
    LB12: TJEdit;
    QTOP1FExpr1002: TFloatField;
    QTOP1FExpr1003: TFloatField;
    QTOP1FExpr1004: TFloatField;
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
  RMTOP1F: TRMTOP1F;

implementation

uses SYSINI, DB_UTL, FM_UTL, UN_UTL, RPTOP1P, MAINU;

{$R *.DFM}
                           
procedure TRMTOP1F.FormCreate(Sender: TObject);
begin
//按钮图形加载
BTNPRN.Glyph := PRN_TB;
BTNPRE.Glyph := PRE_TB;
BTNQUT.Glyph := QUT_TB;

IF FormExists('RMTOP1P')=FALSE THEN Application.CreateForm(TRMTOP1P, RMTOP1P );

//预设日期
LB11.Text := REGISTER_LOAD_OBJECT_STR('\MICROPOS\RPTOP1F\LB11',LB11.TEXT);
LB12.Text := REGISTER_LOAD_OBJECT_STR('\MICROPOS\RPTOP1F\LB12',LB12.TEXT);
IF (TRIM(LB11.Text) = '') AND (TRIM(LB12.Text) = '') THEN LB11.Text := EDATE_TO_CDATE(DATETOSTR(DATE));


WK1.ItemIndex := 0;
end;

procedure TRMTOP1F.FormShow(Sender: TObject);
begin
LB11.SETFOCUS;
end;

procedure TRMTOP1F.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//日期存盘
REGISTER_SAVE_OBJECT_STR('\MICROPOS\RPTOP1F\LB11',LB11.Text);
REGISTER_SAVE_OBJECT_STR('\MICROPOS\RPTOP1F\LB12',LB12.Text);

RMTOP1F.Release;
RMTOP1P.Release;
end;

procedure TRMTOP1F.BTNQUTClick(Sender: TObject);
begin
CLOSE;
end;

procedure TRMTOP1F.BTNPREClick(Sender: TObject);
VAR T_TOP : STRING;
begin
T_TOP := '1';
IF CN1.Value >= 1 THEN T_TOP := CN1.TEXT;

//检查日期
IF CHECK_CDATE(LB11.Text,TRUE) = FALSE THEN LB11.SetFocus;
//IF CHECK_CDATE(LB12.Text,TRUE) = FALSE THEN LB12.SetFocus;
IF CHECK_CDATE(LB11.Text,FALSE) = FALSE THEN EXIT;
//IF CHECK_CDATE(LB12.Text,FALSE) = FALSE THEN EXIT;

  WITH QTOP1F DO
  BEGIN
    CLOSE;
    ///QTOP1FExpr1002.FieldName := _SUMF[2];
    ///QTOP1FExpr1003.FieldName := _SUMF[3];
    ///QTOP1FExpr1004.FieldName := _SUMF[4];
    SQL.CLEAR;
    SQL.ADD('SELECT TOP '+T_TOP+' BGDS.BGENO, BGDS.BGNAM,');
    SQL.ADD('SUM(POSB.BGCNT) ,SUM(POSB.BGCOS) ,SUM(POSB.BGCOT), BGDS.BGKIN ');
    SQL.ADD('FROM POSA, POSB, BGDS');
    SQL.ADD('WHERE POSB.BGENO = BGDS.BGENO');
    SQL.ADD('  AND POSA.PAENO = POSB.PAENO');

    //ACCESS " DATE " WHERE KEY  ======================
    SQL.ADD(FINDFORM_WHEREKEY_DATE('POSA.PADAT',LB11.Text,LB12.Text));

    //字符串查询
//    SQL.ADD(FINDFORM_WHEREKEY_STRING(F_NAME[2],LB21.Text,''));

   //依仓库分类
   SQL.ADD('GROUP BY BGDS.BGENO, BGDS.BGNAM, BGDS.BGKIN');

   CASE WK1.ItemIndex OF
      0 : SQL.ADD('order by 4 DESC');
      1 : SQL.ADD('order by 5 DESC');
      2 : SQL.ADD('order by 6 DESC');
   END;

//    SHOWMESSAGE(SQL.TEXT);
    OPEN;
  END;









  WITH RMTOP1P DO
  BEGIN
  LBTITLE.Caption     := RMTOP1F.Caption;
  LB_USER_CORP_RBPST.Caption := _USER_CORP_RBPST ;
  LB_USER_CORP_NAME .Caption := _USER_CORP_NAME  ;
  LB_USER_CORP_NO   .Caption := _USER_CORP_NO    ;
  LB_USER_CORP_TEL  .Caption := _USER_CORP_TEL   ;
  LB_USER_CORP_FAX  .Caption := _USER_CORP_FAX   ;
  LB_USER_CORP_ADDR .Caption := _USER_CORP_ADDR  ;

  ED_DAT1.Caption := LB11.TEXT;
  ED_DAT2.Caption := LB12.TEXT;


  IF QTOP1F.EOF = TRUE THEN
    BEGIN
    SHOWMESSAGE('没有此资料');
    LB11.SETFOCUS;
    END ELSE BEGIN
    IF SENDER = BTNPRE THEN RMTOP1P.QuickRep.Preview;
    IF SENDER = BTNPRN THEN RMTOP1P.QuickRep.Print;
    END;

  END;

end;

end.
