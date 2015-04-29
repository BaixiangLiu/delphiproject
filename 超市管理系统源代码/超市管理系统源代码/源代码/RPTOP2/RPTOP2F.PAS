unit RPTOP2F;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, StdCtrls, JEdit, Spin, Buttons, ExtCtrls, JLOOKUP;

type
  TRMTOP2F = class(TForm)
    Panel1: TPanel;
    BTNPRN: TSpeedButton;
    BTNPRE: TSpeedButton;
    BTNQUT: TSpeedButton;
    GroupBox2: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    WK1: TComboBox;
    CN1: TSpinEdit;
    QTOP2F: TQuery;
    Label1: TLabel;
    Label2: TLabel;
    Label9: TLabel;
    Label3: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    LB41: TJEdit;
    LB42: TJEdit;
    LB21: TJEdit;
    LB22: TJEdit;
    LB31: TJEdit;
    LB32: TJEdit;
    LB11: JLOOKUPBOX;
    QTOP2FBMENO: TStringField;
    QTOP2FBMNAM: TStringField;
    QTOP2FBMCNA: TStringField;
    QTOP2FBMBTH: TDateTimeField;
    QTOP2FBMSEX: TStringField;
    QTOP2FBMLVE: TFloatField;
    QTOP2FBMBYR: TFloatField;
    QTOP2FBMBTO: TFloatField;
    QTOP2FBMBPO: TFloatField;
    QTOP2FBMBTM: TFloatField;
    QTOP2FBMBDT: TDateTimeField;
    QTOP2FBMBYD: TDateTimeField;
    QTOP2FBMWPN: TStringField;
    QTOP2FBMTL1: TStringField;
    QTOP2FBMTL2: TStringField;
    QTOP2FBMTL3: TStringField;
    QTOP2FBMAD1: TStringField;
    QTOP2FBMAD2: TStringField;
    QTOP2FBMZP1: TStringField;
    QTOP2FBMZP2: TStringField;
    QTOP2FBMEML: TStringField;
    QTOP2FBMWWW: TStringField;
    QTOP2FBMJND: TDateTimeField;
    QTOP2FBMCRD: TDateTimeField;
    QTOP2FBMDAT: TDateTimeField;
    QTOP2FRBPST: TStringField;
    QTOP2FBMMRK: TMemoField;
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
  RMTOP2F: TRMTOP2F;

implementation

uses SYSINI, DB_UTL, FM_UTL, UN_UTL, RPTOP2P, MAINU;

{$R *.DFM}

procedure TRMTOP2F.FormCreate(Sender: TObject);
begin
//按钮图形加载
BTNPRN.Glyph := PRN_TB;
BTNPRE.Glyph := PRE_TB;
BTNQUT.Glyph := QUT_TB;

IF FormExists('RMTOP2P')=FALSE THEN Application.CreateForm(TRMTOP2P, RMTOP2P );

//预设日期
LB41.Text := REGISTER_LOAD_OBJECT_STR('\MICROPOS\RPTOP2F\LB41',LB41.TEXT);
LB42.Text := REGISTER_LOAD_OBJECT_STR('\MICROPOS\RPTOP2F\LB42',LB42.TEXT);
IF (TRIM(LB41.Text) = '') AND (TRIM(LB42.Text) = '') THEN LB11.Text := EDATE_TO_CDATE(DATETOSTR(DATE));


WK1.ItemIndex := 0;
end;

procedure TRMTOP2F.FormShow(Sender: TObject);
begin
LB11.SETFOCUS;
end;

procedure TRMTOP2F.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//日期存盘
REGISTER_SAVE_OBJECT_STR('\MICROPOS\RPTOP2F\LB41',LB41.Text);
REGISTER_SAVE_OBJECT_STR('\MICROPOS\RPTOP2F\LB42',LB42.Text);

RMTOP2F.Release;
RMTOP2P.Release;
end;

procedure TRMTOP2F.BTNQUTClick(Sender: TObject);
begin
CLOSE;
end;

procedure TRMTOP2F.BTNPREClick(Sender: TObject);
VAR T_TOP : STRING;
begin
T_TOP := '1';
IF CN1.Value >= 1 THEN T_TOP := CN1.TEXT;

//检查日期
IF CHECK_CDATE(LB41.Text,TRUE) = FALSE THEN LB41.SetFocus;
//IF CHECK_CDATE(LB42.Text,TRUE) = FALSE THEN LB42.SetFocus;
IF CHECK_CDATE(LB41.Text,FALSE) = FALSE THEN EXIT;
//IF CHECK_CDATE(LB42.Text,FALSE) = FALSE THEN EXIT;













  WITH QTOP2F DO
  BEGIN
    CLOSE;
    SQL.CLEAR;
    SQL.ADD('SELECT TOP '+T_TOP+' * FROM BMEM');
    SQL.ADD('WHERE BMENO IS NOT NULL');

    //字符串查询
    SQL.ADD(FINDFORM_WHEREKEY_STRING( 'BMENO',LB11.Text,''));
    SQL.ADD(FINDFORM_WHEREKEY_INTEGER('BMBYR',LB21.Text,LB22.Text));
    SQL.ADD(FINDFORM_WHEREKEY_INTEGER('BMBTO',LB31.Text,LB32.Text));

    //ACCESS " DATE " WHERE KEY  ======================
    SQL.ADD(FINDFORM_WHEREKEY_DATE('BMBDT',LB41.Text,LB42.Text));

   //依各种分类
   CASE WK1.ItemIndex OF
      0 : SQL.ADD('order by BMBYR DESC');
      1 : SQL.ADD('order by BMBTO DESC');
   END;

//    SHOWMESSAGE(SQL.TEXT);
    OPEN;
  END;



  WITH RMTOP2P DO
  BEGIN
  LBTITLE.Caption     := RMTOP2F.Caption;
  LB_USER_CORP_RBPST.Caption := _USER_CORP_RBPST ;
  LB_USER_CORP_NAME .Caption := _USER_CORP_NAME  ;
  LB_USER_CORP_NO   .Caption := _USER_CORP_NO    ;
  LB_USER_CORP_TEL  .Caption := _USER_CORP_TEL   ;
  LB_USER_CORP_FAX  .Caption := _USER_CORP_FAX   ;
  LB_USER_CORP_ADDR .Caption := _USER_CORP_ADDR  ;

  ED_DAT1.Caption := LB41.TEXT;
  ED_DAT2.Caption := LB42.TEXT;


  IF QTOP2F.EOF = TRUE THEN
    BEGIN
    SHOWMESSAGE('没有此资料');
    LB11.SETFOCUS;
    END ELSE BEGIN
    IF SENDER = BTNPRE THEN RMTOP2P.QuickRep.Preview;
    IF SENDER = BTNPRN THEN RMTOP2P.QuickRep.Print;
    END;

  END;

end;

end.
