unit RPLOGF;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ComCtrls, ToolWin, Db, DBTables, JEdit, Grids, DBGrids,
  JLOOKUP, ExtCtrls, SELOOKUP;

type
  TRMLOGF = class(TForm)
    QLOGF: TQuery;
    Panel1: TPanel;
    BTNPRN: TSpeedButton;
    BTNPRE: TSpeedButton;
    BTNQUT: TSpeedButton;
    GroupBox3: TGroupBox;
    LB11: SELOOKUPBOX;
    Label8: TLabel;
    Label3: TLabel;
    LB21: JLOOKUPBOX;
    Label1: TLabel;
    LB31: TJEdit;
    Label2: TLabel;
    LB32: TJEdit;
    LB91: TComboBox;
    Label4: TLabel;
    WK1: TComboBox;
    Label5: TLabel;
    QLOGFSGENO: TStringField;
    QLOGFSGKIN: TStringField;
    QLOGFPAIDE: TStringField;
    QLOGFBNENO: TStringField;
    QLOGFSGDAT: TDateTimeField;
    QLOGFSGTME: TStringField;
    QLOGFSGMRK: TStringField;
    QLOGFBNNAM: TStringField;
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
  RMLOGF: TRMLOGF;

implementation

uses sysini, fm_utl, un_utl, RPLOGP, MAINU;

{$R *.DFM}

procedure TRMLOGF.FormCreate(Sender: TObject);
begin
IF FormExists('RMLOGP')=FALSE THEN Application.CreateForm(TRMLOGP, RMLOGP );

//按钮图形加载
BTNPRN.Glyph := PRN_TB;
BTNPRE.Glyph := PRE_TB;
BTNQUT.Glyph := QUT_TB;

//预设日期
LB31.Text := COPY(EDATE_TO_CDATE(DATETOSTR(DATE)),1,2) +'0101';
LB32.Text := COPY(EDATE_TO_CDATE(DATETOSTR(DATE)),1,2) +'1231';
end;

procedure TRMLOGF.FormClose(Sender: TObject; var Action: TCloseAction);
begin
RMLOGF.Release;
RMLOGP.Release;
end;

procedure TRMLOGF.FormShow(Sender: TObject);
begin
LB11.SETFOCUS;
end;

procedure TRMLOGF.BTNQUTClick(Sender: TObject);
begin
CLOSE;
end;

procedure TRMLOGF.BTNPREClick(Sender: TObject);
begin
//检查日期
IF CHECK_CDATE(LB31.Text,TRUE) = FALSE THEN LB31.SetFocus;
IF CHECK_CDATE(LB32.Text,TRUE) = FALSE THEN LB32.SetFocus;
IF CHECK_CDATE(LB31.Text,FALSE) = FALSE THEN EXIT;
IF CHECK_CDATE(LB32.Text,FALSE) = FALSE THEN EXIT;

   
  WITH QLOGF DO
  BEGIN
    CLOSE;
    SQL.CLEAR;
    SQL.ADD('SELECT * FROM SYSLOG, BMAN ');
    SQL.ADD('WHERE SYSLOG.BNENO = BMAN.BNENO');

    //字符串查询
    SQL.ADD(FINDFORM_WHEREKEY_STRING('SYSLOG.PAIDE',LB11.Text,''));
    SQL.ADD(FINDFORM_WHEREKEY_STRING('SYSLOG.BNENO',LB21.Text,''));

    //ACCESS " DATE " WHERE KEY  ======================
    SQL.ADD(FINDFORM_WHEREKEY_DATE('SYSLOG.SGDAT',LB31.Text,LB32.Text));

    IF LB91.ItemIndex = 0 THEN SQL.ADD('  AND SYSLOG.SGKIN = ''SLG'' ');
    IF LB91.ItemIndex = 1 THEN SQL.ADD('  AND SYSLOG.SGKIN = ''SPW'' ');
    IF LB91.ItemIndex = 2 THEN SQL.ADD('  AND SYSLOG.SGKIN = ''SPM'' ');
    IF LB91.ItemIndex = 3 THEN SQL.ADD('  AND SYSLOG.SGKIN = ''CBX'' ');
    IF LB91.ItemIndex = 4 THEN SQL.ADD('  AND SYSLOG.SGKIN = ''PBK'' ');
    IF LB91.ItemIndex = 5 THEN SQL.ADD('  AND SYSLOG.SGKIN = ''PCN'' ');
    IF LB91.ItemIndex = 6 THEN SQL.ADD('  AND SYSLOG.SGKIN = ''BAK'' ');

    //查询 排序    //ORDER BYE=======================================
    IF WK1.ItemIndex = 0 THEN SQL.ADD('ORDER BY SYSLOG.PAIDE');
    IF WK1.ItemIndex = 1 THEN SQL.ADD('ORDER BY SYSLOG.BNENO');
    IF WK1.ItemIndex = 2 THEN SQL.ADD('ORDER BY SYSLOG.SGDAT');

//    SHOWMESSAGE(SQL.TEXT);
    OPEN;
  END;



  // 报表数据
  WITH RMLOGP DO
  BEGIN
  LBTITLE.Caption     := RMLOGF.Caption;
  LB_USER_CORP_RBPST.Caption := _USER_CORP_RBPST ;
  LB_USER_CORP_NAME .Caption := _USER_CORP_NAME  ;
  LB_USER_CORP_NO   .Caption := _USER_CORP_NO    ;
  LB_USER_CORP_TEL  .Caption := _USER_CORP_TEL   ;
  LB_USER_CORP_FAX  .Caption := _USER_CORP_FAX   ;
  LB_USER_CORP_ADDR .Caption := _USER_CORP_ADDR  ;

  ED_DAT1.Caption := LB31.TEXT;
  ED_DAT2.Caption := LB32.TEXT;


  IF QLOGF.EOF = TRUE THEN
    BEGIN
    SHOWMESSAGE('没有此资料');
    LB11.SETFOCUS;
    END ELSE BEGIN
    IF SENDER = BTNPRE THEN RMLOGP.QuickRep.Preview;
    IF SENDER = BTNPRN THEN RMLOGP.QuickRep.Print;
    END;

  END;





end;

end.
