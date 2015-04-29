unit UNPOSACARD;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, DBCtrls, Grids, DBGrids, JLOOKUP, SELOOKUP, JEdit,
  Menus;

type
  TFMPOSACARD = class(TForm)
    Label1: TLabel;
    BTNQUT: TBitBtn;
    Label3: TLabel;
    ED_PACNO: TJEdit;
    ED_PACDT: TJEdit;
    ED_PACKD: TJEdit;
    ED_PACNA: TJEdit;
    Label2: TLabel;
    Label4: TLabel;
    MainMenu1: TMainMenu;
    ESC: TMenuItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BTNQUTClick(Sender: TObject);
    procedure ED_PACNOKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ESCClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMPOSACARD: TFMPOSACARD;

implementation

USES SYSINI, UN_UTL, FM_UTL, DB_UTL, UNPOSA, UNPOSAD, MAIN, URDSP;

{$R *.DFM}

procedure TFMPOSACARD.FormCreate(Sender: TObject);
begin
//
end;

procedure TFMPOSACARD.FormShow(Sender: TObject);
begin
  //���ÿ�����======================================
  ED_PACNO.TEXT := _TB_CARD_PACNO;  //���ÿ���
  ED_PACDT.TEXT := _TB_CARD_PACDT;  //���ÿ�������
  ED_PACNA.TEXT := FLOATTOSTR(_TB_CARD_PACNA);  //���ÿ����
  ED_PACKD.TEXT := _TB_CARD_PACKD;  //���ÿ����
  
  //���� INPUT ��ֵ
  IF _TB_CARD_PACNO = '' THEN ED_PACNO.TEXT := FMPOSA.ED_INPUT.TEXT;

  ED_PACNA.SetFocus;
end;

procedure TFMPOSACARD.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FormRelease(FMPOSACARD);
end;

procedure TFMPOSACARD.ED_PACNOKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  IF (KEY = 13) AND (SENDER = ED_PACNO) THEN ED_PACDT.SetFocus;
  IF (KEY = 13) AND (SENDER = ED_PACDT) THEN ED_PACKD.SetFocus;
  IF (KEY = 13) AND (SENDER = ED_PACKD) THEN ED_PACNA.SetFocus;
  IF (KEY = 13) AND (SENDER = ED_PACNA) THEN BTNQUT.Click;
  IF (KEY = 27) THEN
     BEGIN
     _TB_CARD_PACNO  := '';  //���ÿ���
     _TB_CARD_PACDT  := '';  //���ÿ�������
     _TB_CARD_PACNA  := 0;  //���ÿ����
     _TB_CARD_PACKD  := '';  //���ÿ����
  
     DSP_TITLE;
     DSP_TEXT1('Cancel Input Card NO','R');
     DSP_TEXT2('','R');
  
     CLOSE;
     END;
end;

procedure TFMPOSACARD.BTNQUTClick(Sender: TObject);
begin
  //���ÿ�����======================================
  _TB_CARD_PACNO  := ED_PACNO.TEXT;  //���ÿ���
  _TB_CARD_PACDT  := ED_PACDT.TEXT;  //���ÿ�������
  _TB_CARD_PACNA  := STRTOFLOATDEF(ED_PACNA.TEXT,0);  //���ÿ����
  _TB_CARD_PACKD  := ED_PACKD.TEXT;  //���ÿ����
  
  IF (ED_PACNA.TEXT <> '' ) THEN
  IF (STRTOFLOATDEF(ED_PACNA.TEXT,-999) <= -999) THEN  //���ÿ����
     BEGIN
     ED_PACNA.SetFocus;
     ED_PACNA.SelectAll;
     EXIT;
     END;
  
  DSP_TITLE;
  DSP_TEXT1('Card NO-'      +REPLICATE(' ',12-LENGTH(_TB_CARD_PACNO)) + _TB_CARD_PACNO ,'R');
  DSP_TEXT2('Total Cost IS '+REPLICATE(' ',6 -LENGTH(ED_PACNA.TEXT))  + ED_PACNA.TEXT  ,'R');

  CLOSE;
end;

procedure TFMPOSACARD.ESCClick(Sender: TObject);
begin
  _TB_CARD_PACNO  := '';  //���ÿ���
  _TB_CARD_PACDT  := '';  //���ÿ�������
  _TB_CARD_PACNA  := 0;  //���ÿ����
  _TB_CARD_PACKD  := '';  //���ÿ����

  DSP_TITLE;
  DSP_TEXT1('Cancel Input Card NO','R');
  DSP_TEXT2('','R');

  CLOSE;
end;

end.
