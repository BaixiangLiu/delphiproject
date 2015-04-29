unit mains;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Spin, JEdit, ExtCtrls, ComCtrls, Buttons;

type
  TFMMAINS = class(TForm)
    BTNQUT: TBitBtn;
    BTNCAL: TBitBtn;
    PageControl1: TPageControl;
    PAGE_A: TTabSheet;
    PAGE_B: TTabSheet;
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    IV_TC1: TJEdit;
    IV_TC2: TJEdit;
    IV_TS1: TSpinEdit;
    IV_TS2: TSpinEdit;
    GroupBox2: TGroupBox;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    IV_CC1: TComboBox;
    IV_CC2: TComboBox;
    IV_CC3: TComboBox;
    IV_CC4: TComboBox;
    IV_CS1: TSpinEdit;
    IV_CS2: TSpinEdit;
    IV_CS3: TSpinEdit;
    IV_CP1: TSpinEdit;
    IV_CP2: TSpinEdit;
    IV_CP3: TSpinEdit;
    IV_CP4: TSpinEdit;
    GroupBox3: TGroupBox;
    Label30: TLabel;
    Label31: TLabel;
    IV_EC1: TJEdit;
    IV_EC2: TJEdit;
    Panel2: TPanel;
    Label1: TLabel;
    Label6: TLabel;
    ED_AUTO_SHOWPOSA: TCheckBox;
    ED_PRN_PRINTING: TCheckBox;
    ED_PRN_ALWAYSON: TCheckBox;
    ED_PRN_CASHBOX: TCheckBox;
    ED_CLEAR_INPUT: TCheckBox;
    ED_MINUSP: TCheckBox;
    ED_LAST_SUB: TCheckBox;
    ED_AUTO_EAN13: TCheckBox;
    ED_ALL_CASHIN: TCheckBox;
    ED_RE_INPUT: TCheckBox;
    ED_AUTO_ROUND: TCheckBox;
    ED_SHOW_BGCOT: TCheckBox;
    ED_CHECK_POSM: TCheckBox;
    ED_CHECK_POSN: TCheckBox;
    ED_CHECK_POSO: TCheckBox;
    ED_CHECK_BGQTN: TCheckBox;
    ED_CHECK_GIFT_NO: TCheckBox;
    ED_SHOW_WARN: TCheckBox;
    ED_SHOW_RUNLG: TCheckBox;
    ED_SHOW_BGCOS: TCheckBox;
    ED_SHOW_BGQTN: TCheckBox;
    ED_SHOW_BGDSN: TCheckBox;
    ED_SHOW_BMEMN: TCheckBox;
    ED_DISC_ALL: TCheckBox;
    ED_SHOW_BGQTS: TCheckBox;
    ED_SET_ACUS: TCheckBox;
    ED_SET_CHG_PRICE: TCheckBox;
    ED_SET_INPUT_INV: TCheckBox;
    ED_SET_LOWCOS: TCheckBox;
    ED_SET_BMBPO: TSpinEdit;
    ED_SET_WIN_PRICE: TCheckBox;
    IV_RP1: TCheckBox;
    IV_RP2: TCheckBox;
    IV_RP3: TCheckBox;
    ED_PRACTICE_MODE: TRadioGroup;
    ED_SHOW_FUNCTION: TCheckBox;
    procedure BTNQUTClick(Sender: TObject);
    procedure BTNCALClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMMAINS: TFMMAINS;

implementation

USES UN_UTL, DB_UTL, SYSINI,
     MAIN;

{$R *.DFM}

procedure TFMMAINS.FormCreate(Sender: TObject);
begin
  ED_PRACTICE_MODE.ITEMINDEX := _TB_PRACTICE_MODE ; //��ϰģʽ

  ED_AUTO_SHOWPOSA.Checked := _TB_AUTO_SHOWPOSA; //�Զ����� ǰ̨����
  ED_PRN_ALWAYSON .Checked := _TB_PRN_ALWAYSON;  //ǿ��һ��Ҫ��ӡ��Ʊ      ========== SET
  ED_PRN_PRINTING .Checked := _TB_PRN_PRINTING;  //�Ƿ�ӡ��Ʊ            ========== SET
  ED_PRN_CASHBOX  .Checked := _TB_PRN_CASHBOX ;  //�Ƿ��Զ���Ǯ��        ========== SET
  ED_CLEAR_INPUT  .Checked := _TB_CLEAR_INPUT ;  //������Ƿ���������
  ED_MINUSP       .Checked := _TB_MINUSP;        //�ܼƸ����ɽ���
  ED_LAST_SUB     .Checked := _TB_LAST_SUB;      //ȥβ�������ӡ
  ED_DISC_ALL     .Checked := _TB_DISC_ALL;      //ÿ�ʶ�����
  ED_AUTO_EAN13   .Checked := _TB_AUTO_EAN13;    //13����ֵ�Զ���λ
  ED_ALL_CASHIN   .Checked := _TB_ALL_CASHIN;    //ȫ��ʹ���ֽ����
  ED_RE_INPUT     .Checked := _TB_RE_INPUT;      //�ظ�ˢ�Ƿ��Զ���
  
  ED_AUTO_ROUND   .Checked := _TB_AUTO_ROUND  ;  // ��λ����������
  ED_SHOW_FUNCTION.Checked := _TB_SHOW_FUNCTION; // ��ʾ���ܼ�
  ED_SHOW_BGCOS   .Checked := _TB_SHOW_BGCOS  ;  // ��ʾ�ɱ���
  ED_SHOW_BGQTS   .Checked := _TB_SHOW_BGQTS  ;  // ��ʾ������
  ED_SHOW_BGQTN   .Checked := _TB_SHOW_BGQTN  ;  // ��ʾ�����
  ED_SHOW_BGDSN   .Checked := _TB_SHOW_BGDSN  ;  // ��ʾ��Ʒ��ϸ����
  ED_SHOW_BMEMN   .Checked := _TB_SHOW_BMEMN  ;  // ��ʾ��Ա��ϸ����
  ED_SHOW_RUNLG   .Checked := _TB_SHOW_RUNLG  ;  // ��ʾ�����
  ED_SHOW_WARN    .Checked := _TB_SHOW_WARN   ;  // ˢ������ʱҪ����
                                              ;
  ED_CHECK_POSM   .Checked := _TB_CHECK_POSM  ;  // ����ؼ�Ʒ����
  ED_CHECK_POSN   .Checked := _TB_CHECK_POSN  ;  // ��������������
  ED_CHECK_POSO   .Checked := _TB_CHECK_POSO  ;  // ��������һ����
  ED_CHECK_BGQTN  .Checked := _TB_CHECK_BGQTN ;  // �����������
  ED_CHECK_GIFT_NO.Checked := _TB_CHECK_GIFT_NO; // �����ȯ�Ƿ��ظ�
  
  ED_SET_ACUS     .Checked := _TB_SET_ACUS     ; // �Ƿ����������ͻ�����
  ED_SET_INPUT_INV.Checked := _TB_SET_INPUT_INV; // �Ƿ�������뷢Ʊ����
  ED_SET_LOWCOS   .Checked := _TB_SET_LOWCOS   ; // �Ƿ��ۼۿɵ���Ԥ��ɱ�
  ED_SET_BMBPO    .VALUE   := _TB_SET_BMBPO    ; // ��Ա����
  ED_SET_CHG_PRICE.Checked := _TB_SET_CHG_PRICE; // �Ƿ��ֱ�Ӹ����ۼ�
  ED_SET_WIN_PRICE.Checked := _TB_SET_WIN_PRICE; //���´��ڸ����ۼ�

  IV_TS1.VALUE := _TB_INV_SET_IV_TS1; //��Ʊ TITLE ����
  IV_TS2.VALUE := _TB_INV_SET_IV_TS2; //��Ʊ TITLE ����
  IV_TC1.TEXT  := _TB_INV_SET_IV_TC1; //��Ʊ TITLE 1
  IV_TC2.TEXT  := _TB_INV_SET_IV_TC2; //��Ʊ TITLE 2
  
  IV_CC1.ItemIndex := _TB_INV_SET_IV_CC1; //��Ʊ ���� 1
  IV_CC2.ItemIndex := _TB_INV_SET_IV_CC2; //��Ʊ ���� 2
  IV_CC3.ItemIndex := _TB_INV_SET_IV_CC3; //��Ʊ ���� 3
  IV_CC4.ItemIndex := _TB_INV_SET_IV_CC4; //��Ʊ ���� 4
  IV_CS1.VALUE     := _TB_INV_SET_IV_CS1; //��Ʊ �ո� 1
  IV_CS2.VALUE     := _TB_INV_SET_IV_CS2; //��Ʊ �ո� 2
  IV_CS3.VALUE     := _TB_INV_SET_IV_CS3; //��Ʊ �ո� 3
  IV_CP1.VALUE     := _TB_INV_SET_IV_CP1; //��Ʊ λ�� 1
  IV_CP2.VALUE     := _TB_INV_SET_IV_CP2; //��Ʊ λ�� 2
  IV_CP3.VALUE     := _TB_INV_SET_IV_CP3; //��Ʊ λ�� 3
  IV_CP4.VALUE     := _TB_INV_SET_IV_CP4; //��Ʊ λ�� 4

  IV_EC1.TEXT  := _TB_INV_SET_IV_EC1; //��Ʊ ��β 1
  IV_EC2.TEXT  := _TB_INV_SET_IV_EC2; //��Ʊ ��β 2

  IV_RP1.Checked  := _TB_INV_SET_IV_RP1; //��ӡӦ�ҽ��
  IV_RP2.Checked  := _TB_INV_SET_IV_RP2; //��ӡ���ÿ���
  IV_RP3.Checked  := _TB_INV_SET_IV_RP3; //��ӡ��ȯ��ϸ
end;

procedure TFMMAINS.FormShow(Sender: TObject);
begin
  PAGE_A.SHOW;
end;

procedure TFMMAINS.BTNQUTClick(Sender: TObject);
begin
  _TB_PRACTICE_MODE := ED_PRACTICE_MODE.ITEMINDEX; //��ϰģʽ

  _TB_AUTO_SHOWPOSA := ED_AUTO_SHOWPOSA.Checked; //�Զ����� ǰ̨����
  _TB_PRN_ALWAYSON  := ED_PRN_ALWAYSON .Checked; //ǿ��һ��Ҫ��ӡ��Ʊ      ========== SET
  _TB_PRN_PRINTING  := ED_PRN_PRINTING .Checked; //�Ƿ�ӡ��Ʊ            ========== SET
  _TB_PRN_CASHBOX   := ED_PRN_CASHBOX  .Checked; //�Ƿ��Զ���Ǯ��        ========== SET
  _TB_CLEAR_INPUT   := ED_CLEAR_INPUT  .Checked; //������Ƿ���������
  _TB_MINUSP        := ED_MINUSP       .Checked; //�ܼƸ����ɽ���
  _TB_LAST_SUB      := ED_LAST_SUB     .Checked; //ȥβ�������ӡ
  _TB_DISC_ALL      := ED_DISC_ALL     .Checked; //ÿ�ʶ�����
  _TB_AUTO_EAN13    := ED_AUTO_EAN13   .Checked; //13����ֵ�Զ���λ
  _TB_ALL_CASHIN    := ED_ALL_CASHIN   .Checked; //ȫ��ʹ���ֽ����
  _TB_RE_INPUT      := ED_RE_INPUT     .Checked; //�ظ�ˢ�Ƿ��Զ���
  
  _TB_AUTO_ROUND    := ED_AUTO_ROUND   .Checked; // ��λ����������
  _TB_SHOW_FUNCTION := ED_SHOW_FUNCTION.Checked; // ��ʾ���ܼ�
  _TB_SHOW_BGCOS    := ED_SHOW_BGCOS   .Checked; // ��ʾ�ɱ���
  _TB_SHOW_BGQTS    := ED_SHOW_BGQTS   .Checked; // ��ʾ������
  _TB_SHOW_BGQTN    := ED_SHOW_BGQTN   .Checked; // ��ʾ�����
  _TB_SHOW_BGDSN    := ED_SHOW_BGDSN   .Checked; // ��ʾ��Ʒ��ϸ����
  _TB_SHOW_BMEMN    := ED_SHOW_BMEMN   .Checked; // ��ʾ��Ա��ϸ����
  _TB_SHOW_RUNLG    := ED_SHOW_RUNLG   .Checked; // ��ʾ�����
  _TB_SHOW_WARN     := ED_SHOW_WARN    .Checked; // ˢ������ʱҪ����

  _TB_CHECK_POSM    := ED_CHECK_POSM   .Checked; // ����ؼ�Ʒ����
  _TB_CHECK_POSN    := ED_CHECK_POSN   .Checked; // ��������������
  _TB_CHECK_POSO    := ED_CHECK_POSO   .Checked; // ��������һ����
  _TB_CHECK_BGQTN   := ED_CHECK_BGQTN  .Checked; // �����������
  _TB_CHECK_GIFT_NO := ED_CHECK_GIFT_NO.Checked; // �����ȯ�Ƿ��ظ�

  _TB_SET_ACUS      := ED_SET_ACUS     .Checked; // �Ƿ����������ͻ�����
  _TB_SET_INPUT_INV := ED_SET_INPUT_INV.Checked; // �Ƿ�������뷢Ʊ����
  _TB_SET_LOWCOS    := ED_SET_LOWCOS   .Checked; // �Ƿ��ۼۿɵ���Ԥ��ɱ�
  _TB_SET_BMBPO     := ED_SET_BMBPO    .VALUE  ; // ��Ա����
  _TB_SET_CHG_PRICE := ED_SET_CHG_PRICE.Checked; // �Ƿ��ֱ�Ӹ����ۼ�
  _TB_SET_WIN_PRICE := ED_SET_WIN_PRICE.Checked; //���´��ڸ����ۼ�

  _TB_INV_SET_IV_TS1 := IV_TS1.VALUE; //��Ʊ TITLE ����
  _TB_INV_SET_IV_TS2 := IV_TS2.VALUE; //��Ʊ TITLE ����
  _TB_INV_SET_IV_TC1 := IV_TC1.TEXT ; //��Ʊ TITLE 1
  _TB_INV_SET_IV_TC2 := IV_TC2.TEXT ; //��Ʊ TITLE 2
  
  _TB_INV_SET_IV_CC1 := IV_CC1.ItemIndex; //��Ʊ ���� 1
  _TB_INV_SET_IV_CC2 := IV_CC2.ItemIndex; //��Ʊ ���� 2
  _TB_INV_SET_IV_CC3 := IV_CC3.ItemIndex; //��Ʊ ���� 3
  _TB_INV_SET_IV_CC4 := IV_CC4.ItemIndex; //��Ʊ ���� 4
  _TB_INV_SET_IV_CS1 := IV_CS1.VALUE    ; //��Ʊ �ո� 1
  _TB_INV_SET_IV_CS2 := IV_CS2.VALUE    ; //��Ʊ �ո� 2
  _TB_INV_SET_IV_CS3 := IV_CS3.VALUE    ; //��Ʊ �ո� 3
  _TB_INV_SET_IV_CP1 := IV_CP1.VALUE    ; //��Ʊ λ�� 1
  _TB_INV_SET_IV_CP2 := IV_CP2.VALUE    ; //��Ʊ λ�� 2
  _TB_INV_SET_IV_CP3 := IV_CP3.VALUE    ; //��Ʊ λ�� 3
  _TB_INV_SET_IV_CP4 := IV_CP4.VALUE    ; //��Ʊ λ�� 4

  _TB_INV_SET_IV_EC1 := IV_EC1.TEXT; //��Ʊ ��β 1
  _TB_INV_SET_IV_EC2 := IV_EC2.TEXT; //��Ʊ ��β 2

  _TB_INV_SET_IV_RP1 := IV_RP1.Checked; //��ӡӦ�ҽ��
  _TB_INV_SET_IV_RP2 := IV_RP2.Checked; //��ӡ���ÿ���
  _TB_INV_SET_IV_RP3 := IV_RP3.Checked; //��ӡ��ȯ��ϸ

  CLOSE;
end;

procedure TFMMAINS.BTNCALClick(Sender: TObject);
begin
  CLOSE;
end;

procedure TFMMAINS.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FMMAINS.Release;
end;



end.
