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
  ED_PRACTICE_MODE.ITEMINDEX := _TB_PRACTICE_MODE ; //练习模式

  ED_AUTO_SHOWPOSA.Checked := _TB_AUTO_SHOWPOSA; //自动激活 前台程序
  ED_PRN_ALWAYSON .Checked := _TB_PRN_ALWAYSON;  //强迫一定要打印发票      ========== SET
  ED_PRN_PRINTING .Checked := _TB_PRN_PRINTING;  //是否印发票            ========== SET
  ED_PRN_CASHBOX  .Checked := _TB_PRN_CASHBOX ;  //是否自动开钱箱        ========== SET
  ED_CLEAR_INPUT  .Checked := _TB_CLEAR_INPUT ;  //输入后是否清除输入格
  ED_MINUSP       .Checked := _TB_MINUSP;        //总计负数可结帐
  ED_LAST_SUB     .Checked := _TB_LAST_SUB;      //去尾数另外打印
  ED_DISC_ALL     .Checked := _TB_DISC_ALL;      //每笔都打折
  ED_AUTO_EAN13   .Checked := _TB_AUTO_EAN13;    //13码数值自动补位
  ED_ALL_CASHIN   .Checked := _TB_ALL_CASHIN;    //全部使用现金结帐
  ED_RE_INPUT     .Checked := _TB_RE_INPUT;      //重复刷是否自动加
  
  ED_AUTO_ROUND   .Checked := _TB_AUTO_ROUND  ;  // 个位数四舍五入
  ED_SHOW_FUNCTION.Checked := _TB_SHOW_FUNCTION; // 显示功能键
  ED_SHOW_BGCOS   .Checked := _TB_SHOW_BGCOS  ;  // 显示成本价
  ED_SHOW_BGQTS   .Checked := _TB_SHOW_BGQTS  ;  // 显示安存量
  ED_SHOW_BGQTN   .Checked := _TB_SHOW_BGQTN  ;  // 显示库存量
  ED_SHOW_BGDSN   .Checked := _TB_SHOW_BGDSN  ;  // 显示产品详细资料
  ED_SHOW_BMEMN   .Checked := _TB_SHOW_BMEMN  ;  // 显示会员详细资料
  ED_SHOW_RUNLG   .Checked := _TB_SHOW_RUNLG  ;  // 显示跑马灯
  ED_SHOW_WARN    .Checked := _TB_SHOW_WARN   ;  // 刷无资料时要警告
                                              ;
  ED_CHECK_POSM   .Checked := _TB_CHECK_POSM  ;  // 检查特价品资料
  ED_CHECK_POSN   .Checked := _TB_CHECK_POSN  ;  // 检查组合销售资料
  ED_CHECK_POSO   .Checked := _TB_CHECK_POSO  ;  // 检查买二送一资料
  ED_CHECK_BGQTN  .Checked := _TB_CHECK_BGQTN ;  // 检查库存量资料
  ED_CHECK_GIFT_NO.Checked := _TB_CHECK_GIFT_NO; // 检查礼券是否重复
  
  ED_SET_ACUS     .Checked := _TB_SET_ACUS     ; // 是否输入流动客户分析
  ED_SET_INPUT_INV.Checked := _TB_SET_INPUT_INV; // 是否必须输入发票号码
  ED_SET_LOWCOS   .Checked := _TB_SET_LOWCOS   ; // 是否售价可低于预设成本
  ED_SET_BMBPO    .VALUE   := _TB_SET_BMBPO    ; // 会员点数
  ED_SET_CHG_PRICE.Checked := _TB_SET_CHG_PRICE; // 是否可直接更改售价
  ED_SET_WIN_PRICE.Checked := _TB_SET_WIN_PRICE; //开新窗口更改售价

  IV_TS1.VALUE := _TB_INV_SET_IV_TS1; //发票 TITLE 空行
  IV_TS2.VALUE := _TB_INV_SET_IV_TS2; //发票 TITLE 空行
  IV_TC1.TEXT  := _TB_INV_SET_IV_TC1; //发票 TITLE 1
  IV_TC2.TEXT  := _TB_INV_SET_IV_TC2; //发票 TITLE 2
  
  IV_CC1.ItemIndex := _TB_INV_SET_IV_CC1; //发票 内容 1
  IV_CC2.ItemIndex := _TB_INV_SET_IV_CC2; //发票 内容 2
  IV_CC3.ItemIndex := _TB_INV_SET_IV_CC3; //发票 内容 3
  IV_CC4.ItemIndex := _TB_INV_SET_IV_CC4; //发票 内容 4
  IV_CS1.VALUE     := _TB_INV_SET_IV_CS1; //发票 空格 1
  IV_CS2.VALUE     := _TB_INV_SET_IV_CS2; //发票 空格 2
  IV_CS3.VALUE     := _TB_INV_SET_IV_CS3; //发票 空格 3
  IV_CP1.VALUE     := _TB_INV_SET_IV_CP1; //发票 位数 1
  IV_CP2.VALUE     := _TB_INV_SET_IV_CP2; //发票 位数 2
  IV_CP3.VALUE     := _TB_INV_SET_IV_CP3; //发票 位数 3
  IV_CP4.VALUE     := _TB_INV_SET_IV_CP4; //发票 位数 4

  IV_EC1.TEXT  := _TB_INV_SET_IV_EC1; //发票 结尾 1
  IV_EC2.TEXT  := _TB_INV_SET_IV_EC2; //发票 结尾 2

  IV_RP1.Checked  := _TB_INV_SET_IV_RP1; //打印应找金额
  IV_RP2.Checked  := _TB_INV_SET_IV_RP2; //打印信用卡号
  IV_RP3.Checked  := _TB_INV_SET_IV_RP3; //打印礼券明细
end;

procedure TFMMAINS.FormShow(Sender: TObject);
begin
  PAGE_A.SHOW;
end;

procedure TFMMAINS.BTNQUTClick(Sender: TObject);
begin
  _TB_PRACTICE_MODE := ED_PRACTICE_MODE.ITEMINDEX; //练习模式

  _TB_AUTO_SHOWPOSA := ED_AUTO_SHOWPOSA.Checked; //自动激活 前台程序
  _TB_PRN_ALWAYSON  := ED_PRN_ALWAYSON .Checked; //强迫一定要打印发票      ========== SET
  _TB_PRN_PRINTING  := ED_PRN_PRINTING .Checked; //是否印发票            ========== SET
  _TB_PRN_CASHBOX   := ED_PRN_CASHBOX  .Checked; //是否自动开钱箱        ========== SET
  _TB_CLEAR_INPUT   := ED_CLEAR_INPUT  .Checked; //输入后是否清除输入格
  _TB_MINUSP        := ED_MINUSP       .Checked; //总计负数可结帐
  _TB_LAST_SUB      := ED_LAST_SUB     .Checked; //去尾数另外打印
  _TB_DISC_ALL      := ED_DISC_ALL     .Checked; //每笔都打折
  _TB_AUTO_EAN13    := ED_AUTO_EAN13   .Checked; //13码数值自动补位
  _TB_ALL_CASHIN    := ED_ALL_CASHIN   .Checked; //全部使用现金结帐
  _TB_RE_INPUT      := ED_RE_INPUT     .Checked; //重复刷是否自动加
  
  _TB_AUTO_ROUND    := ED_AUTO_ROUND   .Checked; // 个位数四舍五入
  _TB_SHOW_FUNCTION := ED_SHOW_FUNCTION.Checked; // 显示功能键
  _TB_SHOW_BGCOS    := ED_SHOW_BGCOS   .Checked; // 显示成本价
  _TB_SHOW_BGQTS    := ED_SHOW_BGQTS   .Checked; // 显示安存量
  _TB_SHOW_BGQTN    := ED_SHOW_BGQTN   .Checked; // 显示库存量
  _TB_SHOW_BGDSN    := ED_SHOW_BGDSN   .Checked; // 显示产品详细资料
  _TB_SHOW_BMEMN    := ED_SHOW_BMEMN   .Checked; // 显示会员详细资料
  _TB_SHOW_RUNLG    := ED_SHOW_RUNLG   .Checked; // 显示跑马灯
  _TB_SHOW_WARN     := ED_SHOW_WARN    .Checked; // 刷无资料时要警告

  _TB_CHECK_POSM    := ED_CHECK_POSM   .Checked; // 检查特价品资料
  _TB_CHECK_POSN    := ED_CHECK_POSN   .Checked; // 检查组合销售资料
  _TB_CHECK_POSO    := ED_CHECK_POSO   .Checked; // 检查买二送一资料
  _TB_CHECK_BGQTN   := ED_CHECK_BGQTN  .Checked; // 检查库存量资料
  _TB_CHECK_GIFT_NO := ED_CHECK_GIFT_NO.Checked; // 检查礼券是否重复

  _TB_SET_ACUS      := ED_SET_ACUS     .Checked; // 是否输入流动客户分析
  _TB_SET_INPUT_INV := ED_SET_INPUT_INV.Checked; // 是否必须输入发票号码
  _TB_SET_LOWCOS    := ED_SET_LOWCOS   .Checked; // 是否售价可低于预设成本
  _TB_SET_BMBPO     := ED_SET_BMBPO    .VALUE  ; // 会员点数
  _TB_SET_CHG_PRICE := ED_SET_CHG_PRICE.Checked; // 是否可直接更改售价
  _TB_SET_WIN_PRICE := ED_SET_WIN_PRICE.Checked; //开新窗口更改售价

  _TB_INV_SET_IV_TS1 := IV_TS1.VALUE; //发票 TITLE 空行
  _TB_INV_SET_IV_TS2 := IV_TS2.VALUE; //发票 TITLE 空行
  _TB_INV_SET_IV_TC1 := IV_TC1.TEXT ; //发票 TITLE 1
  _TB_INV_SET_IV_TC2 := IV_TC2.TEXT ; //发票 TITLE 2
  
  _TB_INV_SET_IV_CC1 := IV_CC1.ItemIndex; //发票 内容 1
  _TB_INV_SET_IV_CC2 := IV_CC2.ItemIndex; //发票 内容 2
  _TB_INV_SET_IV_CC3 := IV_CC3.ItemIndex; //发票 内容 3
  _TB_INV_SET_IV_CC4 := IV_CC4.ItemIndex; //发票 内容 4
  _TB_INV_SET_IV_CS1 := IV_CS1.VALUE    ; //发票 空格 1
  _TB_INV_SET_IV_CS2 := IV_CS2.VALUE    ; //发票 空格 2
  _TB_INV_SET_IV_CS3 := IV_CS3.VALUE    ; //发票 空格 3
  _TB_INV_SET_IV_CP1 := IV_CP1.VALUE    ; //发票 位数 1
  _TB_INV_SET_IV_CP2 := IV_CP2.VALUE    ; //发票 位数 2
  _TB_INV_SET_IV_CP3 := IV_CP3.VALUE    ; //发票 位数 3
  _TB_INV_SET_IV_CP4 := IV_CP4.VALUE    ; //发票 位数 4

  _TB_INV_SET_IV_EC1 := IV_EC1.TEXT; //发票 结尾 1
  _TB_INV_SET_IV_EC2 := IV_EC2.TEXT; //发票 结尾 2

  _TB_INV_SET_IV_RP1 := IV_RP1.Checked; //打印应找金额
  _TB_INV_SET_IV_RP2 := IV_RP2.Checked; //打印信用卡号
  _TB_INV_SET_IV_RP3 := IV_RP3.Checked; //打印礼券明细

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
