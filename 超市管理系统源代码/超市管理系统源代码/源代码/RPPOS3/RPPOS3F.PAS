unit RPPOS3F;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, Buttons, ExtCtrls, StdCtrls, JEdit;

type
  TRMPOS3F = class(TForm)
    GroupBox1: TGroupBox;
    LB1: TLabel;
    Label7: TLabel;
    QBMEM: TQuery;
    LB21: TJEdit;
    LB22: TJEdit;
    Label1: TLabel;
    LB11: TJEdit;
    Label2: TLabel;
    LB12: TJEdit;
    LB2: TLabel;
    LB31: TJEdit;
    Label8: TLabel;
    LB32: TJEdit;
    Panel1: TPanel;
    BTNPRN: TSpeedButton;
    BTNPRE: TSpeedButton;
    BTNQUT: TSpeedButton;
    QBMEMPAENO: TStringField;
    QBMEMPAIDE: TStringField;
    QBMEMBMENO: TStringField;
    QBMEMBNENO: TStringField;
    QBMEMPAIPN: TBooleanField;
    QBMEMPAIVO: TStringField;
    QBMEMPACIV: TStringField;
    QBMEMPADAT: TDateTimeField;
    QBMEMPATME: TStringField;
    QBMEMPACNT: TFloatField;
    QBMEMPACOT: TFloatField;
    QBMEMPACOG: TFloatField;
    QBMEMPACNO: TStringField;
    QBMEMPACDT: TDateTimeField;
    QBMEMPACNA: TFloatField;
    QBMEMPACKD: TStringField;
    QBMEMPGCOS: TFloatField;
    QBMEMPABCK: TBooleanField;
    QBMEMPABCN: TBooleanField;
    QBMEMPACPD: TBooleanField;
    QBMEMPAWEK: TStringField;
    QBMEMBMENO_1: TStringField;
    QBMEMBMNAM: TStringField;
    QBMEMBMCNA: TStringField;
    QBMEMBMBTH: TDateTimeField;
    QBMEMBMSEX: TStringField;
    QBMEMBMLVE: TFloatField;
    QBMEMBMBYR: TFloatField;
    QBMEMBMBTO: TFloatField;
    QBMEMBMBPO: TFloatField;
    QBMEMBMBTM: TFloatField;
    QBMEMBMBDT: TDateTimeField;
    QBMEMBMBYD: TDateTimeField;
    QBMEMBMWPN: TStringField;
    QBMEMBMTL1: TStringField;
    QBMEMBMTL2: TStringField;
    QBMEMBMTL3: TStringField;
    QBMEMBMAD1: TStringField;
    QBMEMBMAD2: TStringField;
    QBMEMBMZP1: TStringField;
    QBMEMBMZP2: TStringField;
    QBMEMBMEML: TStringField;
    QBMEMBMWWW: TStringField;
    QBMEMBMJND: TDateTimeField;
    QBMEMBMCRD: TDateTimeField;
    QBMEMBMDAT: TDateTimeField;
    QBMEMRBPST: TStringField;
    QBMEMBMMRK: TMemoField;
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
  RMPOS3F: TRMPOS3F;

implementation

uses sysini, fm_utl, un_utl, RPPOS3P, MAINU, MAIN;

{$R *.DFM}

procedure TRMPOS3F.FormCreate(Sender: TObject);
begin
IF FormExists('RMPOS3P')=FALSE THEN Application.CreateForm(TRMPOS3P, RMPOS3P );

//按钮图形加载
BTNPRN.Glyph := PRN_TB;
BTNPRE.Glyph := PRE_TB;
BTNQUT.Glyph := QUT_TB;

{
IF POSA_BMENO = 1 THEN
   BEGIN
   RMPOS3F.Caption := '客户消费记录明细表';
   LB1.Caption := '客户编号';
   LB2.Caption := '客户姓名';
   END;
}


//预设日期
LB11.Text := REGISTER_LOAD_OBJECT_STR('\MICROPOS\RPPOS3F\LB11',LB11.TEXT);
LB12.Text := REGISTER_LOAD_OBJECT_STR('\MICROPOS\RPPOS3F\LB12',LB12.TEXT);
IF (TRIM(LB11.Text) = '') AND (TRIM(LB12.Text) = '') THEN LB11.Text := EDATE_TO_CDATE(DATETOSTR(DATE));

end;

procedure TRMPOS3F.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//日期存盘
REGISTER_SAVE_OBJECT_STR('\MICROPOS\RPPOS1F\LB31',LB11.Text);
REGISTER_SAVE_OBJECT_STR('\MICROPOS\RPPOS1F\LB32',LB12.Text);

RMPOS3F.Release;
RMPOS3P.Release;
end;

procedure TRMPOS3F.FormShow(Sender: TObject);
begin
LB11.SETFOCUS;
end;

procedure TRMPOS3F.BTNQUTClick(Sender: TObject);
begin
CLOSE;
end;

procedure TRMPOS3F.BTNPREClick(Sender: TObject);
var RecordCount_Tmp :Integer;
begin
//检查日期
IF CHECK_CDATE(LB11.Text,TRUE) = FALSE THEN LB11.SetFocus;
//IF CHECK_CDATE(LB12.Text,TRUE) = FALSE THEN LB12.SetFocus;
IF CHECK_CDATE(LB11.Text,FALSE) = FALSE THEN EXIT;
//IF CHECK_CDATE(LB12.Text,FALSE) = FALSE THEN EXIT;

   WITH QBMEM DO
   BEGIN
     CLOSE;
     SQL.CLEAR;
     SQL.ADD('SELECT * FROM POSA, BMEM');
     SQL.ADD('WHERE POSA.PAENO IS NOT NULL');
     SQL.ADD('  AND POSA.BMENO = BMEM.BMENO');

     //字符串查询
     SQL.ADD(FINDFORM_WHEREKEY_STRING('BMEM.BMENO',LB21.Text,LB22.Text));
     SQL.ADD(FINDFORM_WHEREKEY_STRING('BMEM.BMNAM',LB31.Text,LB32.Text));

     //ACCESS " DATE " WHERE KEY  ======================
     SQL.ADD(FINDFORM_WHEREKEY_DATE('POSA.PADAT',LB11.Text,LB12.Text));


     //查询 排序    //ORDER BYE=======================================
     SQL.ADD('ORDER BY BMEM.BMENO');
 //    SQL.ADD(FINDFORM_ORDERBY3(F_NAME[1],F_NAME[2],F_NAME[3],WHEREKEY1.ItemIndex,WHEREKEY2.ItemIndex,WHEREKEY3.ItemIndex));

 //    SHOWMESSAGE(SQL.TEXT);
     OPEN;
   END;



  WITH RMPOS3P DO
  BEGIN
  LBTITLE.Caption     := RMPOS3F.Caption;
  LB_USER_CORP_RBPST.Caption := _USER_CORP_RBPST ;
  LB_USER_CORP_NAME .Caption := _USER_CORP_NAME  ;
  LB_USER_CORP_NO   .Caption := _USER_CORP_NO    ;
  LB_USER_CORP_TEL  .Caption := _USER_CORP_TEL   ;
  LB_USER_CORP_FAX  .Caption := _USER_CORP_FAX   ;
  LB_USER_CORP_ADDR .Caption := _USER_CORP_ADDR  ;

  ED_DAT1.Caption := LB11.TEXT;
  ED_DAT2.Caption := LB12.TEXT;


  IF QBMEM.EOF = TRUE THEN
    BEGIN
    SHOWMESSAGE('没有此资料');
    LB11.SETFOCUS;
    END ELSE BEGIN
    IF SENDER = BTNPRE THEN RMPOS3P.QuickRep.Preview;
    IF SENDER = BTNPRN THEN RMPOS3P.QuickRep.Print;
    END;

  END;

end;



end.
