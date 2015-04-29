unit RPPOS7F;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, Buttons, ExtCtrls, StdCtrls, JLOOKUP, JEdit;

type
  TRMPOS7F = class(TForm)
    GroupBox1: TGroupBox;
    QUERYF: TQuery;
    Label1: TLabel;
    LB11: TJEdit;
    Label2: TLabel;
    LB12: TJEdit;
    Label3: TLabel;
    Label8: TLabel;
    LB31: JLOOKUPBOX;
    GroupBox2: TGroupBox;
    WK1: TComboBox;
    LB51: TJEdit;
    LB61: TJEdit;
    Label5: TLabel;
    Label6: TLabel;
    LB21: TJEdit;
    LB22: TJEdit;
    Label4: TLabel;
    Label9: TLabel;
    LB41: JLOOKUPBOX;
    Panel1: TPanel;
    BTNPRN: TSpeedButton;
    BTNPRE: TSpeedButton;
    BTNQUT: TSpeedButton;
    Label7: TLabel;
    LB71: TJEdit;
    QUERYFPAENO: TStringField;
    QUERYFPAIDE: TStringField;
    QUERYFBMENO: TStringField;
    QUERYFBNENO: TStringField;
    QUERYFPAIPN: TBooleanField;
    QUERYFPAIVO: TStringField;
    QUERYFPACIV: TStringField;
    QUERYFPADAT: TDateTimeField;
    QUERYFPATME: TStringField;
    QUERYFPACNT: TFloatField;
    QUERYFPACOT: TFloatField;
    QUERYFPACOG: TFloatField;
    QUERYFPACNO: TStringField;
    QUERYFPACDT: TDateTimeField;
    QUERYFPACNA: TFloatField;
    QUERYFPACKD: TStringField;
    QUERYFPGCOS: TFloatField;
    QUERYFPABCK: TBooleanField;
    QUERYFPABCN: TBooleanField;
    QUERYFPACPD: TBooleanField;
    QUERYFPAWEK: TStringField;
    CB1: TCheckBox;
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
  RMPOS7F: TRMPOS7F;

implementation

uses DB_UTL, FM_UTL, UN_UTL, sysini, RPPOS7P, MAINU;

{$R *.DFM}

procedure TRMPOS7F.FormCreate(Sender: TObject);
begin
IF FormExists('RMPOS7P')=FALSE THEN Application.CreateForm(TRMPOS7P, RMPOS7P );

//按钮图形加载
BTNPRN.Glyph := PRN_TB;
BTNPRE.Glyph := PRE_TB;
BTNQUT.Glyph := QUT_TB;


//预设日期
LB11.Text := REGISTER_LOAD_OBJECT_STR('\MICROPOS\RPPOS7F\LB11',LB11.TEXT);
LB12.Text := REGISTER_LOAD_OBJECT_STR('\MICROPOS\RPPOS7F\LB12',LB12.TEXT);
IF (TRIM(LB11.Text) = '') AND (TRIM(LB12.Text) = '') THEN LB11.Text := EDATE_TO_CDATE(DATETOSTR(DATE));


end;

procedure TRMPOS7F.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//日期存盘
REGISTER_SAVE_OBJECT_STR('\MICROPOS\RPPOS7F\LB11',LB11.Text);
REGISTER_SAVE_OBJECT_STR('\MICROPOS\RPPOS7F\LB12',LB12.Text);

RMPOS7F.Release;
RMPOS7P.Release;
end;

procedure TRMPOS7F.FormShow(Sender: TObject);
begin
LB11.SETFOCUS;
WK1.ItemIndex := 0;
end;

procedure TRMPOS7F.BTNQUTClick(Sender: TObject);
begin
CLOSE;
end;

procedure TRMPOS7F.BTNPREClick(Sender: TObject);
begin
//检查日期
IF CHECK_CDATE(LB11.Text,TRUE) = FALSE THEN LB11.SetFocus;
//IF CHECK_CDATE(LB12.Text,TRUE) = FALSE THEN LB12.SetFocus;
IF CHECK_CDATE(LB11.Text,FALSE) = FALSE THEN EXIT;
//IF CHECK_CDATE(LB12.Text,FALSE) = FALSE THEN EXIT;

  WITH QUERYF DO
  BEGIN
    CLOSE;
    SQL.CLEAR;
    SQL.ADD('SELECT * FROM POSA');
    SQL.ADD('WHERE PAENO IS NOT NULL');
    SQL.ADD('  AND ( PACNA > 0  OR PAENO IN (SELECT PAENO FROM POSG) )');

    //ACCESS " DATE " WHERE KEY  ======================
    SQL.ADD(FINDFORM_WHEREKEY_DATE('PADAT',LB11.Text,LB12.Text));
    SQL.ADD(FINDFORM_WHEREKEY_DATE('PACDT',LB21.Text,LB22.Text));

    //字符串查询
    SQL.ADD(FINDFORM_WHEREKEY_STRING('BNENO',LB31.Text,''));
    SQL.ADD(FINDFORM_WHEREKEY_STRING('BMENO',LB41.Text,''));
    SQL.ADD(FINDFORM_WHEREKEY_STRING('PAENO',LB51.Text,''));
    SQL.ADD(FINDFORM_WHEREKEY_STRING('PACNO',LB61.Text,''));
    SQL.ADD(FINDFORM_WHEREKEY_STRING('PACNO',LB71.Text,''));


    //查询 排序    //ORDER BYE=======================================
//    SQL.ADD(FINDFORM_ORDERBY3(F_NAME[1],F_NAME[2],F_NAME[3],WHEREKEY1.ItemIndex,WHEREKEY2.ItemIndex,WHEREKEY3.ItemIndex));

   CASE WK1.ItemIndex OF
      0 : SQL.ADD('ORDER BY PADAT ');
      1 : SQL.ADD('ORDER BY PACDT ');
      2 : SQL.ADD('ORDER BY BNENO ');
      3 : SQL.ADD('ORDER BY BMENO ');
      4 : SQL.ADD('ORDER BY PAENO ');
      5 : SQL.ADD('ORDER BY PACNO ');
      6 : SQL.ADD('ORDER BY PACNO ');
   END;

//    SHOWMESSAGE(SQL.TEXT);
    OPEN;
  END;



  WITH RMPOS7P DO
  BEGIN
  LBTITLE.Caption     := RMPOS7F.Caption;
  //LB_USER_CORP_RBPST.Caption := _USER_CORP_RBPST ;
  //LB_USER_CORP_NAME .Caption := _USER_CORP_NAME  ;
  //LB_USER_CORP_NO   .Caption := _USER_CORP_NO    ;
  //LB_USER_CORP_TEL  .Caption := _USER_CORP_TEL   ;
  //LB_USER_CORP_FAX  .Caption := _USER_CORP_FAX   ;
  //LB_USER_CORP_ADDR .Caption := _USER_CORP_ADDR  ;

  ED_DAT1.Caption := LB11.TEXT;
  ED_DAT2.Caption := LB12.TEXT;


  IF QUERYF.EOF = TRUE THEN
    BEGIN
    SHOWMESSAGE('没有此资料');
    LB11.SETFOCUS;
    END ELSE BEGIN
    IF SENDER = BTNPRE THEN RMPOS7P.QuickRep.Preview;
    IF SENDER = BTNPRN THEN RMPOS7P.QuickRep.Print;
    END;

  END;


end;





end.
