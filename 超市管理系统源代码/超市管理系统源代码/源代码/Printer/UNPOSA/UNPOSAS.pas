unit UNPOSAS;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, DBCtrls, Grids, DBGrids, JLOOKUP, SELOOKUP;

type
  TFMPOSAS = class(TForm)
    Label1: TLabel;
    BTNQUT: TBitBtn;
    ED_INVOICE: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    ED_CHECKTABLE: SELOOKUPBOX;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BTNQUTClick(Sender: TObject);
    procedure ED_CHECKTABLEKeyDown(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMPOSAS: TFMPOSAS;

implementation

USES SYSINI, UN_UTL, FM_UTL, DB_UTL, UNPOSA, UNPOSAD, MAIN, MAINU;

{$R *.DFM}

procedure TFMPOSAS.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FormRelease(FMPOSAS);
end;

procedure TFMPOSAS.BTNQUTClick(Sender: TObject);
begin
  IF ED_CHECKTABLE.FIND_QUERY_IDNO(ED_CHECKTABLE.TEXT) = '' THEN
     BEGIN
     ED_CHECKTABLE.SetFocus;  ED_CHECKTABLE.SelectAll; EXIT;
     END;

  IF (ED_INVOICE.Text = '') AND (_TB_SET_INPUT_INV=TRUE) THEN
     BEGIN
     ED_INVOICE.SetFocus;  ED_INVOICE.SelectAll;  EXIT;
     END;

  IF (ED_INVOICE.Text<>'') AND (INVOICE_NO_CHECK(ED_INVOICE.Text)=FALSE) THEN
     BEGIN
     ED_INVOICE.SetFocus;  ED_INVOICE.SelectAll;  EXIT;
     END;

  INI_SAVE_STR(FILEPATH_INVOICE,'CHECKTABLE',ED_CHECKTABLE.TEXT);

  _TB_NUMBER  := ED_CHECKTABLE.Text; //�տ�����
  _TB_INV_NO  := ED_INVOICE.Text;  //��Ʊ����

  IF (INTTOSTR(INP32(889)) <> '223') AND (_TB_PRN_PRINTING = TRUE) THEN //�Ƿ�ӡ��Ʊ
     SHOWMESSAGE('��ȷ����Ʊ����Դ�Ƿ��, �ټ�����ҵ!'+#10#13+'����������ɵ���!');

  //������¼��¼
  TRY
    SYSLOG_INSERT('SLG',_TB_NUMBER,'�տ�̨');
  FINALLY
    CLOSE;
  END;

  CLOSE;
end;

procedure TFMPOSAS.ED_CHECKTABLEKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  IF (KEY = 13) AND (SENDER = ED_CHECKTABLE) THEN ED_INVOICE.SetFocus;
  IF (KEY = 13) AND (SENDER = ED_INVOICE)    THEN BTNQUT.Click;
end;

procedure TFMPOSAS.FormActivate(Sender: TObject);
begin
  ED_CHECKTABLE.TEXT := _TB_NUMBER;
  ED_INVOICE.TEXT    := _TB_INV_NO;

  ED_CHECKTABLE.SetFocus;
  ED_CHECKTABLE.Change;
end;

procedure TFMPOSAS.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  IF UNSETREAD('SYSSET','SET_PAIV') = '1' THEN
     BEGIN
     IF (TRIM(ED_INVOICE.Text) ='') THEN CANCLOSE := FALSE;
     END;
end;

end.
