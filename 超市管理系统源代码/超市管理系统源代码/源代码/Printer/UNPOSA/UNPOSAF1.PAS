unit UNPOSAF1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, Gauges, Menus;

type
  TFMPOSAF1 = class(TForm)
    ED_OUT_PRICE: TPanel;
    Panel2: TPanel;
    LB_TOTAL_CASH: TLabel;
    LB_CARD_PACNA: TLabel;
    Gauge: TGauge;
    LB_TOTAL_PRICE: TLabel;
    ED_OUT_QTY: TLabel;
    Bevel2: TBevel;
    Panel1: TPanel;
    Label2: TLabel;
    Label32: TLabel;
    ED_OUT_KIND: TLabel;
    LB_DISC: TLabel;
    BTNSAVE: TBitBtn;
    Panel_EXCHANGE: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    ED_OUT_1000: TLabel;
    Bevel1: TBevel;
    ED_OUT_500: TLabel;
    ED_OUT_100: TLabel;
    ED_OUT_50: TLabel;
    MainMenu1: TMainMenu;
    F1: TMenuItem;
    F2: TMenuItem;
    F3: TMenuItem;
    F5: TMenuItem;
    F6: TMenuItem;
    ESC: TMenuItem;
    F4: TMenuItem;
    ED_OUT_PAY: TLabel;
    ED_OUT_EXCHANGE: TLabel;
    ED_DATE: TLabel;
    LB_GIFT_PRICE: TLabel;
    LB_DISC_PRICE: TLabel;
    Gauge_SUB: TGauge;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure F1Click(Sender: TObject);
    procedure ESCClick(Sender: TObject);
    procedure F6Click(Sender: TObject);
    procedure F5Click(Sender: TObject);
    procedure BTNSAVEClick(Sender: TObject);
  private
    { Private declarations }
    PROCEDURE EXCHANGE_DISPLAY;
  public
    { Public declarations }
  end;

var
  FMPOSAF1: TFMPOSAF1;

implementation

uses INIFILES, UN_UTL, DB_UTL, SYSINI,
     URINVOICE,
     URDSP,
     UNPOSA,
     UNPOSAD,
     UNPOSAU,
     MAINU, MAIN, MAIND;

{$R *.DFM}

PROCEDURE TFMPOSAF1.EXCHANGE_DISPLAY;
VAR T_CHANGE : STRING;
begin
  IF _TB_TOTAL_PAY > 0 THEN Panel_EXCHANGE.Visible := TRUE
                       ELSE Panel_EXCHANGE.Visible := FALSE;

  WITH FMPOSA DO
    BEGIN
    _TB_TOTAL_EXCHANGE := _TB_TOTAL_PAY - _TB_TOTAL_CASH;
    ED_OUT_PAY     .CAPTION := FLOATTOSTR(_TB_TOTAL_PAY);
    ED_OUT_EXCHANGE.CAPTION := FLOATTOSTR(_TB_TOTAL_EXCHANGE);
    END;

  //客显//清显示器
  IF FRDSP.ED_DSP.ItemIndex >0 THEN
     BEGIN
     DSP_TITLE;
     DSP_CLR;
     DSP_SETOVERWRITEMODE;
     DSP_SET_CMODE;
     DSP_LINE1_TEXT('CHANGE  ' + REPLICATE(' ',12 - LENGTH(FLOATTOSTR(_TB_TOTAL_EXCHANGE))) + FLOATTOSTR(_TB_TOTAL_EXCHANGE) );
     DISPLAY_DSP_TOTAL(FLOATTOSTR(_TB_TOTAL_PRICE));
     END;

  //计算找钱金额=============================
  case FLOATTOINT(_TB_TOTAL_CASH) of
    0..50     :
         begin
         ED_OUT_50  .Caption := FLOATToStr(50   - _TB_TOTAL_CASH);
         ED_OUT_100 .Caption := FLOATToStr(100  - _TB_TOTAL_CASH);
         ED_OUT_500 .Caption := FLOATToStr(500  - _TB_TOTAL_CASH);
         ED_OUT_1000.Caption := FLOATToStr(1000 - _TB_TOTAL_CASH);
         end;
    51..100     :
         begin
         ED_OUT_50  .Caption := ' ';
         ED_OUT_100 .Caption := FLOATToStr(100  - _TB_TOTAL_CASH);
         ED_OUT_500 .Caption := FLOATToStr(500  - _TB_TOTAL_CASH);
         ED_OUT_1000.Caption := FLOATToStr(1000 - _TB_TOTAL_CASH);
         end;
    101..500     :
         begin
         ED_OUT_50  .Caption := ' ';
         ED_OUT_100 .Caption := ' ';
         ED_OUT_500 .Caption := FLOATToStr(500  - _TB_TOTAL_CASH);
         ED_OUT_1000.Caption := FLOATToStr(1000 - _TB_TOTAL_CASH);
         end;
    501..1000     :
         begin
         ED_OUT_50  .Caption := ' ';
         ED_OUT_100 .Caption := ' ';
         ED_OUT_500 .Caption := ' ';
         ED_OUT_1000.Caption := FLOATToStr(1000 - _TB_TOTAL_CASH);
         end;
  end;
   
END;

procedure TFMPOSAF1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FMPOSAF1.Release;
end;

procedure TFMPOSAF1.FormCreate(Sender: TObject);
VAR I : INTEGER;
    T_TOTAL, T_DISC: STRING;
BEGIN
  Panel_EXCHANGE.Visible := FALSE;

  Gauge.Progress := 0;
  BTNSAVE.Visible := TRUE;
  WITH FMPOSA DO
    BEGIN
    //自动计算找钱
    IF TRIM(ED_INPUT.TEXT) <> '' THEN
      BEGIN     //有输入找钱
      _TB_TOTAL_PAY      := STRTOINTDEF(ED_INPUT.TEXT,0);
      EXCHANGE_DISPLAY;
      END ELSE BEGIN  //没有输入找钱
      IF FRDSP.ED_DSP.ItemIndex >0 THEN //客显//清显示器
         BEGIN
         DSP_TITLE;
         DSP_CLR;
         DSP_SETOVERWRITEMODE;
         DSP_SET_CMODE;
         DISPLAY_DSP_TOTAL(FLOATTOSTR(_TB_TOTAL_PRICE));
         END;
      END;
    END;

  ED_OUT_PRICE.Caption := '总额：' +FILL_STR(' ', FLOATTOSTR(_TB_TOTAL_PRICE), 'L', 8 ) +'元';
  ED_OUT_QTY  .Caption := '数量：' +FILL_STR(' ', INTTOSTR(_TB_TOTAL_QTY)    , 'L', 8 ) +'个';
  ED_DATE     .Caption := '日期：' +FILL_STR(' ', EDATE_TO_CDATE( DATETOSTR(_TB_INSERT_DATE) ), 'L', 8 );

  LB_TOTAL_PRICE.Caption  := '　总额：'+FILL_STR(' ', FLOATTOSTR(_TB_TOTAL_PRICE) , 'L', 8 ) ;
  LB_GIFT_PRICE .Caption  := '－礼券：'+FILL_STR(' ', FLOATTOSTR(_TB_GIFT_PRICE ) , 'L', 8 ) ;
  LB_CARD_PACNA .Caption  := '－刷卡：'+FILL_STR(' ', FLOATTOSTR(_TB_CARD_PACNA ) , 'L', 8 ) ;
  LB_DISC_PRICE .Caption  := '－折扣：'+FILL_STR(' ', FLOATTOSTR(_TB_DISC_PRICE ) , 'L', 8 ) ;
  LB_TOTAL_CASH.Caption   := '＝现金：'+FILL_STR(' ', FLOATTOSTR(_TB_TOTAL_CASH ) , 'L', 8 ) ;

  // 客显 ===============================================================
  DSP_TITLE;
  DSP_TEXT1(FILL_STR(' ', INTTOSTR(_TB_TOTAL_QTY), 'L', 3 ) + ' PCS = $'+ FILL_STR(' ', FLOATTOSTR(_TB_TOTAL_PRICE), 'L', 8 ) +'.'  ,'R');
  DSP_TEXT2('Pay Cash= $'+FILL_STR(' ', FLOATTOSTR(_TB_TOTAL_CASH ), 'L', 8 ) +'.','R');
  // 客显 ===============================================================
end;

procedure TFMPOSAF1.ESCClick(Sender: TObject);
begin
  VAR_INI;
  CLOSE;
end;

procedure TFMPOSAF1.F1Click(Sender: TObject);
begin
  IF BTNSAVE.Enabled = FALSE THEN EXIT;
  BTNSAVE.Click;
end;

procedure TFMPOSAF1.F5Click(Sender: TObject);
begin
  _TB_TOTAL_PAY := STRTOINTDEF(JINPUTBOX('结帐找零计算','请输入金额','0'),0);
  EXCHANGE_DISPLAY;
end;

procedure TFMPOSAF1.F6Click(Sender: TObject);
begin
  //客显//清显示器
  IF FRDSP.ED_DSP.ItemIndex >0 THEN
     BEGIN
     DSP_TITLE;
     DSP_CLR;
     DISPLAY_DSP_TITLE  ;
     END;
  CLOSE;
end;

procedure TFMPOSAF1.BTNSAVEClick(Sender: TObject);
begin
  BTNSAVE.Visible := FALSE;

  FINISHI;             //完成结帐
  VAR_INI;
  FMPOSA.ED_INPUT.Clear;
end;

end.
