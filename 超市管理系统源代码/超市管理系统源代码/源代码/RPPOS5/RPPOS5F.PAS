unit RPPOS5F;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, Buttons, ExtCtrls, StdCtrls, JLOOKUP, JEdit;

type
  TRMPOS5F = class(TForm)
    GroupBox1: TGroupBox;
    QPOS5F: TQuery;
    Label1: TLabel;
    LB11: TJEdit;
    Label2: TLabel;
    LB12: TJEdit;
    QPOS5FBMNAM: TStringField;
    QPOS5FBMENO: TStringField;
    Label3: TLabel;
    Label7: TLabel;
    LB21: JLOOKUPBOX;
    LB22: JLOOKUPBOX;
    QPOS5FExpr1002: TFloatField;
    QPOS5FExpr1003: TFloatField;
    QPOS5FExpr1004: TFloatField;
    Panel1: TPanel;
    BTNPRN: TSpeedButton;
    BTNPRE: TSpeedButton;
    BTNQUT: TSpeedButton;
    WK1: TComboBox;
    Label4: TLabel;
    procedure BTNQUTClick(Sender: TObject);
    procedure BTNPREClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RMPOS5F: TRMPOS5F;

implementation

uses DB_UTL, FM_UTL, UN_UTL, sysini, RPPOS5P, MAINU;

{$R *.DFM}


procedure TRMPOS5F.FormCreate(Sender: TObject);
begin
IF FormExists('RMPOS5P')=FALSE THEN Application.CreateForm(TRMPOS5P, RMPOS5P );

//按钮图形加载
BTNPRN.Glyph := PRN_TB;
BTNPRE.Glyph := PRE_TB;
BTNQUT.Glyph := QUT_TB;


//预设日期
LB11.Text := REGISTER_LOAD_OBJECT_STR('\MICROPOS\RPPOS5F\LB11',LB11.TEXT);
LB12.Text := REGISTER_LOAD_OBJECT_STR('\MICROPOS\RPPOS5F\LB12',LB12.TEXT);
IF (TRIM(LB11.Text) = '') AND (TRIM(LB12.Text) = '') THEN LB11.Text := EDATE_TO_CDATE(DATETOSTR(DATE));

end;

procedure TRMPOS5F.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//日期存盘
REGISTER_SAVE_OBJECT_STR('\MICROPOS\RPPOS5F\LB11',LB11.Text);
REGISTER_SAVE_OBJECT_STR('\MICROPOS\RPPOS5F\LB12',LB12.Text);

RMPOS5F.Release;
RMPOS5P.Release;
end;

procedure TRMPOS5F.FormShow(Sender: TObject);
begin
LB11.SETFOCUS;
WK1.ItemIndex := 0;
end;



procedure TRMPOS5F.BTNQUTClick(Sender: TObject);
begin
CLOSE;
end;

procedure TRMPOS5F.BTNPREClick(Sender: TObject);
var RecordCount_Tmp :Integer;
begin
//检查日期
IF CHECK_CDATE(LB11.Text,TRUE) = FALSE THEN LB11.SetFocus;
//IF CHECK_CDATE(LB12.Text,TRUE) = FALSE THEN LB12.SetFocus;
IF CHECK_CDATE(LB11.Text,FALSE) = FALSE THEN EXIT;
//IF CHECK_CDATE(LB12.Text,FALSE) = FALSE THEN EXIT;


  WITH QPOS5F DO
  BEGIN
    CLOSE;
    QPOS5FExpr1002.FieldName := _SUMF[2];
    QPOS5FExpr1003.FieldName := _SUMF[3];
    QPOS5FExpr1004.FieldName := _SUMF[4];
    SQL.CLEAR;
    SQL.ADD('SELECT ');
    SQL.ADD('POSA.BMENO, BMEM.BMNAM, SUM(POSB.BGCNT) ,SUM(POSB.BGCOS) ,SUM(POSB.BGCOT)');
    SQL.ADD('FROM POSA, POSB, BMEM');
    SQL.ADD('WHERE POSA.PAENO IS NOT NULL');
    SQL.ADD('  AND POSA.BMENO = BMEM.BMENO');
    SQL.ADD('  AND POSA.PAENO = POSB.PAENO');


    //ACCESS " DATE " WHERE KEY  ======================
    SQL.ADD(FINDFORM_WHEREKEY_DATE('PADAT',LB11.Text,LB12.Text));

    //字符串查询
    SQL.ADD(FINDFORM_WHEREKEY_STRING('BMEM.BMENO',LB21.Text,''));

   //依仓库分类
   SQL.ADD('GROUP BY POSA.BMENO,BMEM.BMNAM');

   CASE WK1.ItemIndex OF
      0 : SQL.ADD('order by 3 DESC');
      1 : SQL.ADD('order by 4 DESC');
      2 : SQL.ADD('order by 5 DESC');
   END;

    //查询 排序    //ORDER BYE=======================================
//    SQL.ADD(FINDFORM_ORDERBY3(F_NAME[1],F_NAME[2],F_NAME[3],WHEREKEY1.ItemIndex,WHEREKEY2.ItemIndex,WHEREKEY3.ItemIndex));

//    SHOWMESSAGE(SQL.TEXT);
    OPEN;
  END;





  WITH RMPOS5P DO
  BEGIN
  LBTITLE.Caption     := RMPOS5F.Caption;
  LB_USER_CORP_RBPST.Caption := _USER_CORP_RBPST ;
  LB_USER_CORP_NAME .Caption := _USER_CORP_NAME  ;
  LB_USER_CORP_NO   .Caption := _USER_CORP_NO    ;
  LB_USER_CORP_TEL  .Caption := _USER_CORP_TEL   ;
  LB_USER_CORP_FAX  .Caption := _USER_CORP_FAX   ;
  LB_USER_CORP_ADDR .Caption := _USER_CORP_ADDR  ;

  ED_DAT1.Caption := LB11.TEXT;
  ED_DAT2.Caption := LB12.TEXT;


  IF QPOS5F.EOF = TRUE THEN
    BEGIN
    SHOWMESSAGE('没有此资料');
    LB11.SETFOCUS;
    END ELSE BEGIN
    IF SENDER = BTNPRE THEN RMPOS5P.QuickRep.Preview;
    IF SENDER = BTNPRN THEN RMPOS5P.QuickRep.Print;
    END;

  END;


end;




end.
