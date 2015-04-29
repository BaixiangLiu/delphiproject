unit RPPOS6F;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, Buttons, ComCtrls, ToolWin, JLOOKUP, StdCtrls, JEdit;

type
  TRMPOS6F = class(TForm)
    GroupBox1: TGroupBox;
    ToolBar: TToolBar;
    ToolButton1: TToolButton;
    BTNPRE: TSpeedButton;
    BTNPRN: TSpeedButton;
    BTNQUT: TSpeedButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    QPOS6F: TQuery;
    Label1: TLabel;
    LB11: TJEdit;
    Label2: TLabel;
    LB12: TJEdit;
    Label3: TLabel;
    Label8: TLabel;
    LB51: JLOOKUPBOX;
    GroupBox2: TGroupBox;
    WK1: TComboBox;
    LB31: TJEdit;
    Label4: TLabel;
    LB21: JLOOKUPBOX;
    Label5: TLabel;
    LB41: TJEdit;
    Label6: TLabel;
    LB61: JLOOKUPBOX;
    QPOS6FExpr1000: TFloatField;
    QPOS6FExpr1001: TFloatField;
    QPOS6FExpr1002: TFloatField;
    QPOS6FBGNAM: TStringField;
    QPOS6FBGENO: TStringField;
    QPOS6FBGPST: TFloatField;
    QPOS6FBGPMM: TFloatField;
    QPOS6FBGPVP: TFloatField;
    QPOS6FBGKIN: TStringField;
    QPOS6FBGCOS: TFloatField;
    QPOS6FBSENO: TStringField;
    Label7: TLabel;
    Label9: TLabel;
    ToolBar1: TToolBar;
    ToolButton4: TToolButton;
    BTNPRE1: TSpeedButton;
    BTNPRN1: TSpeedButton;
    QPOS6F1: TQuery;
    QPOS6F1Expr1000: TFloatField;
    QPOS6F1BSENO: TStringField;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    procedure BTNQUTClick(Sender: TObject);
    procedure BTNPREClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BTNPRE1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RMPOS6F: TRMPOS6F;

implementation

uses DB_UTL, FM_UTL, UN_UTL, sysini, RPPOS6P, RPPOS6P1, MAINU;

{$R *.DFM}

procedure TRMPOS6F.FormCreate(Sender: TObject);
begin
IF FormExists('RMPOS6P') =FALSE THEN Application.CreateForm(TRMPOS6P, RMPOS6P );
IF FormExists('RMPOS6P1')=FALSE THEN Application.CreateForm(TRMPOS6P1,RMPOS6P1  );

//按钮图形加载
BTNPRN.Glyph  := PRN_TB;
BTNPRE.Glyph  := PRE_TB;
BTNPRN1.Glyph := PRN_TB;
BTNPRE1.Glyph := PRE_TB;
BTNQUT.Glyph  := QUT_TB;


//预设日期
LB11.Text := REGISTER_LOAD_OBJECT_STR('\MICROPOS\RPPOS6F\LB11',LB11.TEXT);
LB12.Text := REGISTER_LOAD_OBJECT_STR('\MICROPOS\RPPOS6F\LB12',LB12.TEXT);
IF (TRIM(LB11.Text) = '') AND (TRIM(LB12.Text) = '') THEN LB11.Text := EDATE_TO_CDATE(DATETOSTR(DATE));


end;

procedure TRMPOS6F.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//日期存盘
REGISTER_SAVE_OBJECT_STR('\MICROPOS\RPPOS6F\LB11',LB11.Text);
REGISTER_SAVE_OBJECT_STR('\MICROPOS\RPPOS6F\LB12',LB12.Text);

RMPOS6F.Release;
RMPOS6P.Release;
RMPOS6P1.Release;
end;


procedure TRMPOS6F.FormShow(Sender: TObject);
begin
LB11.SETFOCUS;
WK1.ItemIndex := 0;
end;

procedure TRMPOS6F.BTNQUTClick(Sender: TObject);
begin
CLOSE;
end;

procedure TRMPOS6F.BTNPREClick(Sender: TObject);
var RecordCount_Tmp :Integer;
begin
//检查日期
IF CHECK_CDATE(LB11.Text,TRUE) = FALSE THEN LB11.SetFocus;
//IF CHECK_CDATE(LB12.Text,TRUE) = FALSE THEN LB12.SetFocus;
IF CHECK_CDATE(LB11.Text,FALSE) = FALSE THEN EXIT;
//IF CHECK_CDATE(LB12.Text,FALSE) = FALSE THEN EXIT;


  WITH QPOS6F DO
  BEGIN
    CLOSE;
    QPOS6FExpr1000.FieldName := _SUMF[0];
    QPOS6FExpr1001.FieldName := _SUMF[1];
    QPOS6FExpr1002.FieldName := _SUMF[2];
    SQL.CLEAR;
    SQL.ADD('SELECT ');
    SQL.ADD('SUM(POSB.BGCNT) ,SUM(POSB.BGCOS) ,SUM(POSB.BGCOT), ');
    SQL.ADD('POSB.BGENO, BGDS.BGNAM, BGDS.BGPST, BGDS.BGPMM, BGDS.BGPVP, BGDS.BGKIN, BGDS.BGCOS, BGDS.BSENO ');
    SQL.ADD('FROM POSA, POSB, BGDS');
    SQL.ADD('WHERE POSA.PAENO IS NOT NULL');
    SQL.ADD('  AND POSB.BGENO = BGDS.BGENO');
    SQL.ADD('  AND POSA.PAENO = POSB.PAENO');

    //ACCESS " DATE " WHERE KEY  ======================
    SQL.ADD(FINDFORM_WHEREKEY_DATE('POSA.PADAT',LB11.Text,LB12.Text));

    //字符串查询
    SQL.ADD(FINDFORM_WHEREKEY_STRING('BGDS.BGENO',LB21.Text,''));
    SQL.ADD(FINDFORM_WHEREKEY_STRING('BGDS.BGENO',LB31.Text,''));
    SQL.ADD(FINDFORM_WHEREKEY_STRING('BGDS.BGNAM',LB41.Text,''));
    SQL.ADD(FINDFORM_WHEREKEY_STRING('BGDS.BGKIN',LB51.Text,''));
    SQL.ADD(FINDFORM_WHEREKEY_STRING('BGDS.BSENO',LB61.Text,''));


//    IF LB61.Text <> '' THEN
//       SQL.ADD('AND BGDS.BSENO IN (SELECT BSENO FROM BGDS WHERE BGENO = '''+LB61.TEXT+''')');

    //查询 排序    //ORDER BYE=======================================
//    SQL.ADD(FINDFORM_ORDERBY3(F_NAME[1],F_NAME[2],F_NAME[3],WHEREKEY1.ItemIndex,WHEREKEY2.ItemIndex,WHEREKEY3.ItemIndex));

   //依仓库分类
   SQL.ADD('GROUP BY POSB.BGENO,BGDS.BGNAM,');
   SQL.ADD('BGDS.BGPST, BGDS.BGPMM, BGDS.BGPVP, BGDS.BGKIN, BGDS.BGCOS, BGDS.BSENO ');
   CASE WK1.ItemIndex OF
      0 : SQL.ADD('order by 3 ');
      1 : SQL.ADD('order by BGDS.BGNAM ');
      2 : SQL.ADD('order by 0 DESC');
      3 : SQL.ADD('order by 2 DESC');
      4 : SQL.ADD('order by BGDS.BGKIN ');
      5 : SQL.ADD('order by BGDS.BSENO ');
   END;
   
//    SHOWMESSAGE(SQL.TEXT);
    OPEN;
  END;


  WITH RMPOS6P DO
  BEGIN
  LBTITLE.Caption     := RMPOS6F.Caption;
  LB_USER_CORP_RBPST.Caption := _USER_CORP_RBPST ;
  LB_USER_CORP_NAME .Caption := _USER_CORP_NAME  ;
  LB_USER_CORP_NO   .Caption := _USER_CORP_NO    ;
  LB_USER_CORP_TEL  .Caption := _USER_CORP_TEL   ;
  LB_USER_CORP_FAX  .Caption := _USER_CORP_FAX   ;
  LB_USER_CORP_ADDR .Caption := _USER_CORP_ADDR  ;

  ED_DAT1.Caption := LB11.TEXT;
  ED_DAT2.Caption := LB12.TEXT;


  IF QPOS6F.EOF = TRUE THEN
    BEGIN
    SHOWMESSAGE('没有此资料');
    LB11.SETFOCUS;
    END ELSE BEGIN
    IF SENDER = BTNPRE THEN RMPOS6P.QuickRep.Preview;
    IF SENDER = BTNPRN THEN RMPOS6P.QuickRep.Print;
    END;

  END;


end;


procedure TRMPOS6F.BTNPRE1Click(Sender: TObject);
var RecordCount_Tmp :Integer;
begin
//检查日期
IF CHECK_CDATE(LB11.Text,TRUE) = FALSE THEN LB11.SetFocus;
//IF CHECK_CDATE(LB12.Text,TRUE) = FALSE THEN LB12.SetFocus;
IF CHECK_CDATE(LB11.Text,FALSE) = FALSE THEN EXIT;
//IF CHECK_CDATE(LB12.Text,FALSE) = FALSE THEN EXIT;

  WITH QPOS6F1 DO
  BEGIN
    CLOSE;
    SQL.CLEAR;
    SQL.ADD('SELECT SUM(POSB.BGCOT), BGDS.BSENO ');
    SQL.ADD('FROM POSA, POSB, BGDS');
    SQL.ADD('WHERE POSA.PAENO IS NOT NULL');
    SQL.ADD('  AND POSB.BGENO = BGDS.BGENO');
    SQL.ADD('  AND POSA.PAENO = POSB.PAENO');

    //ACCESS " DATE " WHERE KEY  ======================
    SQL.ADD(FINDFORM_WHEREKEY_DATE('POSA.PADAT',LB11.Text,LB12.Text));

    //字符串查询
    SQL.ADD(FINDFORM_WHEREKEY_STRING('BGDS.BSENO',LB61.Text,''));


   //依仓库分类
   SQL.ADD('GROUP BY BGDS.BSENO ');
   SQL.ADD('order by BGDS.BSENO ');

//    SHOWMESSAGE(SQL.TEXT);
    OPEN;
  END;


  WITH RMPOS6P1 DO
  BEGIN
  LBTITLE.Caption     := RMPOS6F.Caption;
  LB_USER_CORP_RBPST.Caption := _USER_CORP_RBPST ;
  LB_USER_CORP_NAME .Caption := _USER_CORP_NAME  ;
  LB_USER_CORP_NO   .Caption := _USER_CORP_NO    ;
  LB_USER_CORP_TEL  .Caption := _USER_CORP_TEL   ;
  LB_USER_CORP_FAX  .Caption := _USER_CORP_FAX   ;
  LB_USER_CORP_ADDR .Caption := _USER_CORP_ADDR  ;

  ED_DAT1.Caption := LB11.TEXT;
  ED_DAT2.Caption := LB12.TEXT;


  IF QPOS6F1.EOF = TRUE THEN
    BEGIN
    SHOWMESSAGE('没有此资料');
    LB11.SETFOCUS;
    END ELSE BEGIN
    IF SENDER = BTNPRE1 THEN RMPOS6P1.QuickRep.Preview;
    IF SENDER = BTNPRN1 THEN RMPOS6P1.QuickRep.Print;
    END;

  END;



end;






end.
