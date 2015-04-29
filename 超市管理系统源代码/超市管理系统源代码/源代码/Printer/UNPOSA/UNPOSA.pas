unit UNPOSA;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Menus, Spin, StdCtrls, Buttons, ComCtrls, Grids, DBGrids,
  JLOOKUP, JEdit, GIFImage, jpeg, SELOOKUP;

type
  TFMPOSA = class(TForm)
    OUT_GRID: TStringGrid;
    MainMenu1: TMainMenu;
    ESC: TMenuItem;
    F1: TMenuItem;
    F2: TMenuItem;
    F5: TMenuItem;
    F7: TMenuItem;
    F3: TMenuItem;
    F8: TMenuItem;
    F11: TMenuItem;
    F4: TMenuItem;
    F12: TMenuItem;
    CTRLL: TMenuItem;
    CTRLI: TMenuItem;
    CTRLQ: TMenuItem;
    CTRLP: TMenuItem;
    F10: TMenuItem;
    CTRLA: TMenuItem;
    CTRLB: TMenuItem;
    CTRLV: TMenuItem;
    CTRLN: TMenuItem;
    CTRLM: TMenuItem;
    CTRLZ: TMenuItem;
    F6: TMenuItem;
    CTRLC: TMenuItem;
    CTRLX: TMenuItem;
    CTRLS: TMenuItem;
    N1: TMenuItem;
    CTRLF5: TMenuItem;
    CTRLF6: TMenuItem;
    CTRLF7: TMenuItem;
    CTRLF8: TMenuItem;
    CTRLF9: TMenuItem;
    CTRLF10: TMenuItem;
    CTRLF11: TMenuItem;
    CTRLF12: TMenuItem;
    ED_START: TLABEL;
    ED_END: TLABEL;
    Panel_RUNLG: TLABEL;
    Label_RUNLG: TLabel;
    StatusBar1: TStatusBar;
    Timer1: TTimer;
    Timer_RUNLG: TTimer;
    OUT_Grid_TMP: TStringGrid;
    F9: TMenuItem;
    LB_CHG_PRICE: TPanel;
    LB_LAST_SUB: TPanel;
    LB_PRN_PRINTING: TPanel;
    LB_TMP_GRID: TPanel;
    LB_BACK_MODE: TPanel;
    LB_PRN_CASHBOX: TPanel;
    IMG_CHG_PRICE: TImage;
    IMG_LAST_SUB: TImage;
    IMG_PRN_PRINTING: TImage;
    IMG_TMP_GRID: TImage;
    IMG_BACK_MODE: TImage;
    IMG_PRN_CASHBOX: TImage;
    Timer_IMG: TTimer;
    LB_DISC_PERCENT: TPanel;
    ED_DISC_PERCENT: TLabel;
    LB_LAST_PRICE: TPanel;
    ED_LAST_PRICE: TLabel;
    LB_PACIV: TPanel;
    ED_PACIV: TLabel;
    LB_INV_NO: TPanel;
    ED_INV_NO: TLabel;
    LB_INV_CNT: TPanel;
    ED_INV_CNT: TLabel;
    Panel5: TPanel;
    Image1: TImage;
    LB_NUMBER: TPanel;
    LB_USER_NUMBER: TPanel;
    ED_NUMBER: SELOOKUPBOX;
    ED_USER_NUMBER: SELOOKUPBOX;
    LB_INSERT_DATE: TPanel;
    ED_INSERT_DATE: TEdit;
    Panel1: TPanel;
    ED_BMEM_BMLVE: TEdit;
    ED_BMEM_BMBYR: TEdit;
    ED_BMEM_BMBTO: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    ED_BMEM_BMENO: TEdit;
    ED_BMEM_BMNAM: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    LB_BG_BGQTS: TPanel;
    ED_BG_BGQTS: TLabel;
    LB_BG_BGQTN: TPanel;
    ED_BG_BGQTN: TLabel;
    LB_CARD_PACNA: TPanel;
    ED_CARD_PACNA: TLabel;
    LB_GIFT_PGCNA: TPanel;
    ED_GIFT_PGCNA: TLabel;
    LB_BG_BGCOS: TPanel;
    ED_BG_BGCOS: TLabel;
    CTRLH: TMenuItem;
    Panel2: TPanel;
    ED_INPUT: TEdit;
    Label_TOTAL: TLabel;
    ED_TOTAL_PRICE: TEdit;
    ED_NOPAY: TLabel;
    ED_TOTAL_NOPAY: TEdit;
    Label1: TLabel;
    ED_TOTAL_CASH: TEdit;
    Image2: TImage;
    Label7: TLabel;
    ED_BMEM_BMCRD: TEdit;
    ED_BMEM_BMDAT: TEdit;
    Label8: TLabel;
    Panel3: TPanel;
    ED_DISC_PRICE: TLabel;
    ARROW_PIC: TImage;
    PANEL_FUNCTION: TPanel;
    BTN_F1: TBITBTN;
    BTN_F2: TBITBTN;
    BTN_F3: TBITBTN;
    BTN_F4: TBITBTN;
    BTN_F5: TBITBTN;
    BTN_F6: TBITBTN;
    BTN_F7: TBITBTN;
    BTN_F8: TBITBTN;
    BTN_F9: TBITBTN;
    BTN_F10: TBITBTN;
    BTN_F11: TBITBTN;
    BTN_F12: TBITBTN;
    BTN_CTRLL: TBitBtn;
    BTN_CTRLP: TBitBtn;
    BTN_CTRLN: TBitBtn;
    BTN_CTRLC: TBitBtn;
    BTN_CTRLI: TBitBtn;
    BTN_CTRLB: TBitBtn;
    BTN_CTRLM: TBitBtn;
    BTN_CTRLX: TBitBtn;
    BTN_CTRLQ: TBitBtn;
    BTN_CTRLV: TBitBtn;
    BTN_CTRLZ: TBitBtn;
    BTN_CTRLS: TBitBtn;
    BTN_CTRLH: TBitBtn;
    BTN_ESC: TBitBtn;
    procedure CTRLQClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ED_INPUTKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure F8Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer_RUNLGTimer(Sender: TObject);
    procedure F3Click(Sender: TObject);
    procedure ESCClick(Sender: TObject);
    procedure F4Click(Sender: TObject);
    procedure F11Click(Sender: TObject);
    procedure F12Click(Sender: TObject);
    procedure CTRLLClick(Sender: TObject);
    procedure F2Click(Sender: TObject);
    procedure F1Click(Sender: TObject);
    procedure F5Click(Sender: TObject);
    procedure F6Click(Sender: TObject);
    procedure F7Click(Sender: TObject);
    procedure CTRLCClick(Sender: TObject);
    procedure CTRLPClick(Sender: TObject);
    procedure CTRLIClick(Sender: TObject);
    procedure F9Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure F10Click(Sender: TObject);
    procedure CTRLVClick(Sender: TObject);
    procedure CTRLF12Click(Sender: TObject);
    procedure CTRLF8Click(Sender: TObject);
    procedure CTRLHClick(Sender: TObject);
    procedure CTRLXClick(Sender: TObject);
    procedure CTRLSClick(Sender: TObject);
    procedure CTRLNClick(Sender: TObject);
    procedure CTRLMClick(Sender: TObject);
    procedure CTRLZClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

  end;


var
  FMPOSA: TFMPOSA;

implementation

uses INIFILES,
     sysini,  un_utl,   fm_utl, DB_UTL,

     UNPOSAU,
     UNPOSAD,

     UNPOSAF1,     // 结帐
     UNPOSAPRICE,  // 改金额 , 单价
     UNPOSACARD,   // 输入信用卡
     UNPOSAGIFT,   // 输入礼券
     UNPOSAKEY,    // 按键及设置
     UNPOSAMESSAGE, // 个人信息检查
     UNPOSASINGLE,  // 单品输入


     UNBGDSN,    // 快速选资料
     UNBMEMN,    // 快速选资料

     UNBGDSQ,    // 快速键资料
     UNBMEMQ,    // 快速键资料

     URINVOICE,
     URDSP,
     ///////////SYSLOG,        // LOGIN
     MAIND,   MAINU;

{$R *.DFM}




procedure TFMPOSA.FormCreate(Sender: TObject);
begin
  OUT_GRID.Cells[1,0] := '    条  码 ';
  OUT_GRID.Cells[2,0] := ' 产 品 名 称 ';
  OUT_GRID.Cells[3,0] := '量';
  OUT_GRID.Cells[4,0] := ' 单 价 ';
  OUT_GRID.Cells[5,0] := ' 小 计 ';

  T_STR := UNSET_READ_SST('_SYS_SET_MAINCR');
  IF T_STR <> '' THEN FMPOSA.COLOR := STRINGTOCOLOR(T_STR);

  // 显示功能键
  IF _TB_SHOW_FUNCTION = TRUE THEN
     BEGIN
     PANEL_FUNCTION.Visible := TRUE;
     OUT_GRID.Height := 365;
     END ELSE BEGIN
     OUT_GRID.Height := 450;
     PANEL_FUNCTION.FREE;
     END;
end;

procedure TFMPOSA.FormShow(Sender: TObject);
begin
  _TB_DISC_PERCENT := 1 ; //打折比例

  ED_NUMBER      .TEXT := _TB_NUMBER                ;  //收款台编号
  ED_USER_NUMBER .TEXT := _TB_USER_NUMBER           ;  //收银员编号
  ED_INSERT_DATE .TEXT := EDATE_TO_CDATE(DATETOSTR(_TB_INSERT_DATE));  //此笔日期

  VAR_INI;
  ED_INPUT_SETFOCUS;
end;

procedure TFMPOSA.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DataModuleRelease(FMPOSAD);
  FormRelease(FMPOSA);
  FormFREE('FMPOSAGIFT');
end;

procedure TFMPOSA.ED_INPUTKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  //快速查询相关 DATA
  IF ( KEY = 38 ) THEN  // 上移
     BEGIN
     IF (OUT_GRID.Row<1)OR(OUT_GRID.Row>199)THEN EXIT;
     IF (OUT_GRID.Row>1)THEN
     OUT_GRID.Row := OUT_GRID.Row -1;
     ED_INPUT_SETFOCUS;
     EXIT;
     END;
  
  IF ( KEY = 40 ) THEN  // 下移
     BEGIN
     IF (OUT_GRID.Row<1)OR(OUT_GRID.Row>199)THEN EXIT;
     IF (OUT_GRID.Row<199)THEN
     OUT_GRID.Row := OUT_GRID.Row +1;
     ED_INPUT_SETFOCUS;
     EXIT;
     END;
  
  IF ( KEY = 33 ) THEN
     BEGIN
     CTRLF8Click( CTRLF5 );   EXIT;
     END;

  IF ( KEY = 34 ) THEN
     BEGIN
     CTRLF12Click( CTRLF9 );   EXIT;
     END;
  
  IF KEY = 13 THEN
     BEGIN
     OUT_GRID.Row := 1;
     T_STR := ED_INPUT.Text;
  
     //空白离开
     IF (ED_INPUT.TEXT = '') THEN EXIT;

     //13码数值自动补位
     IF _TB_AUTO_EAN13 = TRUE THEN ED_INPUT.TEXT := EAN13_AUTOADD(ED_INPUT.TEXT);

     IF RE_INPUT(T_STR) = TRUE THEN EXIT;

     T_STR := FIND_BGDS(T_STR,1);
     CHECK_PRICE;  //检查价钱

     IF ( T_STR = '') THEN //按 BGENO 再按 ENTER 找资料
        BEGIN
        IF (T_STR='') AND (_TB_SHOW_WARN= TRUE) THEN SHOWMESSAGE('查无此资料');
        END ELSE BEGIN
        GRID_ADD;
        END;

     ED_INPUT_SETFOCUS;
     EXIT;
     END;  //IF

end;









// 时间区 ====================================================================================
procedure TFMPOSA.Timer1Timer(Sender: TObject);
VAR I :INTEGER;
begin
  FMPOSA.WINDOWSTATE:=wsMaximized;
  FMPOSA.Top  := 0;
  FMPOSA.LEFT := 0;
  
  // 算礼券金额 ====================================================================================
  IF FormExists('FMPOSAGIFT')=TRUE THEN
     BEGIN
     _TB_GIFT_PRICE := 0;   //礼券总金额
     FOR I := 1 TO 19 DO
        BEGIN
        IF STRTOINTDEF(FMPOSAGIFT.GIFT_GRID.Cells[3,I], -1) >= 0 THEN
           BEGIN
           _TB_GIFT_PRICE := _TB_GIFT_PRICE + STRTOFLOATDEF(FMPOSAGIFT.GIFT_GRID.Cells[3,I],0);
           END;
        END;
     END;


  _TB_TOTAL_REC := 0;
  //算 总笔数==========================================================
  FOR I := 1 TO 200 DO
      BEGIN
      IF TRIM(OUT_GRID.Cells[1,I]) =  '' THEN OUT_GRID.Rows[I].Text := '';
      IF TRIM(OUT_GRID.Cells[1,I]) <> '' THEN INC(_TB_TOTAL_REC) ELSE BREAK;
      END;

  // 重写序号=========================================================
  FOR I := 1 TO _TB_TOTAL_REC DO OUT_GRID.Cells[0,I] := INTTOSTR(_TB_TOTAL_REC-I+1);

  //算金额==========================================================
  _TB_TOTAL_QTY   := 0;
  _TB_TOTAL_PRICE := 0;
  FOR I := 1 TO 200 DO
      BEGIN
      _TB_TOTAL_QTY   := _TB_TOTAL_QTY   + STRTOINTDEF(TRIM(OUT_GRID.Cells[3,I]),0);
      _TB_TOTAL_PRICE := _TB_TOTAL_PRICE + STRTOFLOATDEF(TRIM(OUT_GRID.Cells[5,I]),0);
      IF TRIM(OUT_GRID.Cells[1,I+1]) =  '' THEN BREAK;
      END;

  //小数无条件四舍五入
  IF _TB_AUTO_ROUND = TRUE THEN _TB_TOTAL_PRICE := FLOATTOINT_ROUND(_TB_TOTAL_PRICE);


  //                            礼券            信用卡            折扣              去尾数
  _TB_TOTAL_NOPAY := ROUND(_TB_GIFT_PRICE + _TB_CARD_PACNA + _TB_DISC_PRICE + _TB_LAST_PRICE);
  _TB_TOTAL_CASH  := ROUND(_TB_TOTAL_PRICE-_TB_TOTAL_NOPAY);

  ED_TOTAL_NOPAY.Text := FLOATTOSTR(_TB_TOTAL_NOPAY);
  ED_TOTAL_PRICE.Text := FLOATTOSTR(_TB_TOTAL_PRICE);
  ED_TOTAL_CASH .Text := FLOATTOSTR(_TB_TOTAL_CASH);
  // 算金额 ====================================================================================


  // 将要显示的显示出来，其它隐藏 ==============================================================
  IF _TB_PRN_ALWAYSON = TRUE THEN _TB_PRN_PRINTING := TRUE; //预设 强迫 要开发票,就不能不打印发票

  _TB_SET_CHG_PRICE := TRUE;
  IMG_CHG_PRICE.Picture    := ARROW_PIC.Picture;   IMG_CHG_PRICE.Visible    := _TB_SET_CHG_PRICE;  //可否改金额
  IMG_LAST_SUB.Picture     := ARROW_PIC.Picture;   IMG_LAST_SUB.Visible     := _TB_LAST_SUB     ;  //总计可以去尾数
  IMG_PRN_PRINTING.Picture := ARROW_PIC.Picture;   IMG_PRN_PRINTING.Visible := _TB_PRN_PRINTING ;  //是否打印发票
  IMG_TMP_GRID.Picture     := ARROW_PIC.Picture;   IMG_TMP_GRID.Visible     := _TB_TMP_GRID     ;  //暂存区有东西
  IMG_BACK_MODE.Picture    := ARROW_PIC.Picture;   IMG_BACK_MODE.Visible    := _TB_BACK_MODE    ;  //退货模式
  IMG_PRN_CASHBOX.Picture  := ARROW_PIC.Picture;   IMG_PRN_CASHBOX.Visible  := _TB_PRN_CASHBOX  ;  //退货模式

  IMG_PRN_PRINTING.Visible := _TB_PRN_PRINTING; //是否打印发票

  ED_DISC_PRICE   .CAPTION := FLOATTOSTR(_TB_DISC_PRICE   ); //折扣金额
  ED_DISC_PERCENT .CAPTION := FLOATTOSTR(_TB_DISC_PERCENT ); //打折比例
  ED_LAST_PRICE   .CAPTION := FLOATTOSTR(_TB_LAST_PRICE   ); //总计 - 去尾数金额
  ED_PACIV        .CAPTION :=            _TB_PACIV         ;  //统一编号
  ED_INV_NO       .CAPTION :=            _TB_INV_NO        ; //发票号码
  ED_INV_CNT      .CAPTION := INTTOSTR(  _TB_INV_CNT      ); //发票剩张数

  ED_BG_BGQTS     .CAPTION := INTTOSTR(   _TB_BG_BGQTS    ); //安存数量
  ED_BG_BGQTN     .CAPTION := INTTOSTR(   _TB_BG_BGQTN    ); //库存数量
  ED_BG_BGCOS     .CAPTION := FLOATTOSTR( _TB_BG_BGCOS    ); //成本价
  LB_BG_BGCOS     .Visible := _TB_SHOW_BGCOS  ;  // 显示成本价
  LB_BG_BGQTS     .Visible := _TB_SHOW_BGQTS  ;  // 显示安存量
  LB_BG_BGQTN     .Visible := _TB_SHOW_BGQTN  ;  // 显示库存量


  ED_CARD_PACNA.Caption := FLOATTOSTR(_TB_CARD_PACNA);
  ED_GIFT_PGCNA.Caption := FLOATTOSTR(_TB_GIFT_PGCNA);
  // 将要显示的显示出来，其它隐藏 ==============================================================

  // 找寻会员
  IF _TB_BMEM_FOUND = TRUE THEN
    BEGIN
    ED_BMEM_BMENO.TEXT := _TB_BMEM_BMENO;              //会员姓名
    ED_BMEM_BMNAM.TEXT := _TB_BMEM_BMNAM;              //会员姓名
    ED_BMEM_BMLVE.TEXT := INTTOSTR(_TB_BMEM_BMLVE);    //会员等级
    ED_BMEM_BMBYR.TEXT := INTTOSTR(_TB_BMEM_BMBYR);    //年消费等级
    ED_BMEM_BMBTO.TEXT := INTTOSTR(_TB_BMEM_BMBTO);    //总消费等级
    ED_BMEM_BMCRD.TEXT := _TB_BMEM_BMCRD;    //发卡日
    ED_BMEM_BMDAT.TEXT := _TB_BMEM_BMDAT;    //入会日
    END ELSE BEGIN
    ED_BMEM_BMENO.TEXT := '' ;
    ED_BMEM_BMNAM.TEXT := '' ;
    ED_BMEM_BMLVE.TEXT := '0';
    ED_BMEM_BMBYR.TEXT := '0';
    ED_BMEM_BMBTO.TEXT := '0';
    ED_BMEM_BMCRD.TEXT := '';    //发卡日
    ED_BMEM_BMDAT.TEXT := '';    //入会日
    END;

end;

procedure TFMPOSA.Timer_RUNLGTimer(Sender: TObject);
begin
  IF (Label_RUNLG.Left <= 0-Label_RUNLG.Width) THEN Label_RUNLG.Left := Panel_RUNLG.Width;
  IF (Label_RUNLG.Left >  0) THEN Label_RUNLG.Left := Label_RUNLG.Left - 50;
  Label_RUNLG.Left := Label_RUNLG.Left - 30;
end;

// 时间区 ====================================================================================














// HOT KEY =====================================================================================
procedure TFMPOSA.ESCClick(Sender: TObject);
begin
  VAR_INI;     //全部清除
  ED_INPUT_SETFOCUS;

  INC(_TB_ESC_CNT);     //按ESC的次数
  IF (_TB_TOTAL_REC=0)AND(_TB_ESC_CNT >= 3 ) THEN     //按ESC的次数
     BEGIN
     IF Application.FindComponent('FMPOSAKEY')=nil then Application.CreateForm(TFMPOSAKEY,  FMPOSAKEY  );
        FMPOSAKEY.SHOWMODAL;
     _TB_ESC_CNT := 0;
     END;
end;


procedure TFMPOSA.F1Click(Sender: TObject);
VAR S : STRING;
begin
  IF (_TB_MINUSP = FALSE) AND (_TB_TOTAL_PRICE<=0) THEN
     BEGIN
     Case MessageDlg('您输入的总计为负值 '+#10#13+
          '按 Yes 返回销货' +#10#13+
          '按 No  取消销货' +#10#13 ,mtConfirmation,[mbYes,mbNo],0) of
          mrYES : EXIT;
          mrNO  : ESC.Click;
          end;
     END;

  IF _TB_TOTAL_REC = 0 THEN
     BEGIN
     ED_INPUT_SETFOCUS;   EXIT;
     END;

  IF Application.FindComponent('FMPOSAF1')=NIL THEN
     BEGIN
     Application.CreateForm(TFMPOSAF1,  FMPOSAF1  );
     FMPOSAF1.SHOWMODAL;
     END;
  
  ED_INPUT_SETFOCUS;
end;

procedure TFMPOSA.F2Click(Sender: TObject);
begin
  //检查权限============================================
  if PERMISSION_CHECK(_USER_ID, 'UNPOSAC') = FALSE then   EXIT;
  
  //新增开钱箱记录
  SYSLOG_INSERT('CBX',_TB_NUMBER,'手动开钱箱');
  try INVOICE_OPEN_CASHBOX;  except SHOWMESSAGE('钱箱无法开启!');   end;
end;

procedure TFMPOSA.F3Click(Sender: TObject);
VAR Q, P: REAL;
    OLD_AMOUNT : STRING;
begin
  OLD_AMOUNT := OUT_GRID.Cells[3,OUT_GRID.Row];
  
  IF TRIM(OUT_GRID.Cells[1,1]) =  '' THEN EXIT;
  IF TRIM(OUT_GRID.Cells[1,OUT_GRID.Row]) =  '' THEN
     BEGIN
     OUT_GRID.Row := 1;   EXIT;
     END;

  //小数无条件四舍五入
  IF _TB_AUTO_ROUND = TRUE THEN Q := FLOATTOINT_ROUND( STRTOFLOATDEF(ED_INPUT.TEXT,1))
                         ELSE Q := FLOATTOINT( STRTOFLOATDEF(ED_INPUT.TEXT,1));

  P := STRTOFLOATDEF(OUT_GRID.Cells[4,OUT_GRID.Row],0);
  //IF SYS_BACK_MODE = TRUE THEN Q := 0 - Q; //退货模式

  OUT_GRID.Cells[3,OUT_GRID.Row] := FLOATTOSTR(Q);

  //小数无条件四舍五入
  IF _TB_AUTO_ROUND = TRUE THEN OUT_GRID.Cells[5,OUT_GRID.Row] := INTTOSTR(FLOATTOINT_ROUND(Q*P))
                           ELSE OUT_GRID.Cells[5,OUT_GRID.Row] := INTTOSTR(FLOATTOINT(Q*P));

  // 客显 ===============================================================
  DSP_TITLE;
  DSP_TEXT1('Change Single Amount','R');
  DSP_TEXT2(FILL_STR(' ', OLD_AMOUNT, 'L', 7 )+'. -> '+FILL_STR(' ', OUT_GRID.Cells[3,OUT_GRID.Row], 'L', 7 )+'.' ,'R');
  // 客显 ===============================================================

  OUT_Grid.Row := 1;
  ED_INPUT_SETFOCUS;
end;

procedure TFMPOSA.F4Click(Sender: TObject);
VAR Q, P: REAL;
    OLD_PRICE : STRING;
begin
  OLD_PRICE := OUT_GRID.Cells[5,OUT_GRID.Row];

  IF _TB_SET_CHG_PRICE = FALSE THEN
    BEGIN
    ED_INPUT_SETFOCUS;  EXIT;
    END;

  IF TRIM(OUT_GRID.Cells[1,1]) =  '' THEN EXIT;
  IF TRIM(OUT_GRID.Cells[1,OUT_GRID.Row]) =  '' THEN
     BEGIN
     OUT_GRID.Row := 1;   EXIT;
     END;

  IF _TB_SET_WIN_PRICE = TRUE THEN
     BEGIN
     IF Application.FindComponent('FMPOSAPRICE')=nil then Application.CreateForm(TFMPOSAPRICE, FMPOSAPRICE  );
        FMPOSAPRICE.ED_CHANGE_QTY.TEXT := OUT_GRID.Cells[3,OUT_GRID.Row];
        FMPOSAPRICE.SHOWMODAL;
     END ELSE BEGIN
     IF LENGTH(ED_INPUT.TEXT) <=7 THEN
     OUT_GRID.Cells[5,OUT_GRID.Row] := FLOATTOSTR(STRTOFLOATDEF(ED_INPUT.TEXT,1));
     END;

  // 客显 ===============================================================
  DSP_TITLE;
  DSP_TEXT1('Change Single Price!','R');
  DSP_TEXT2(FILL_STR(' ', OLD_PRICE, 'L', 7 )+'. -> '+FILL_STR(' ', OUT_GRID.Cells[5,OUT_GRID.Row], 'L', 7 )+'.' ,'R');
  // 客显 ===============================================================

  OUT_Grid.Row := 1;
  ED_INPUT_SETFOCUS;
end;

procedure TFMPOSA.F5Click(Sender: TObject);
begin
  IF FormExists('FMPOSACARD')=FALSE THEN Application.CreateForm(TFMPOSACARD, FMPOSACARD );
  FMPOSACARD.ED_PACNA.Text := ED_INPUT.Text;
  FMPOSACARD.SHOWMODAL;
  ED_INPUT_SETFOCUS;
end;

procedure TFMPOSA.F6Click(Sender: TObject);
begin
  IF FormExists('FMPOSAGIFT')=FALSE THEN Application.CreateForm(TFMPOSAGIFT, FMPOSAGIFT );
  FMPOSAGIFT.ED_PGCNA.Text := ED_INPUT.Text;
  FMPOSAGIFT.SHOWMODAL;
  ED_INPUT_SETFOCUS;
end;

procedure TFMPOSA.F7Click(Sender: TObject);
begin
  _TB_PACIV := ED_INPUT.TEXT;
  ED_INPUT_SETFOCUS;

  // 客显 ===============================================================
  DSP_TITLE;
  DSP_TEXT1('Standard NO:' ,'R');
  DSP_TEXT2(FILL_STR(' ', _TB_PACIV, 'L', 20 ) ,'R');
  // 客显 ===============================================================
end;

procedure TFMPOSA.F8Click(Sender: TObject);
begin
  IF TRIM(ED_INPUT.TEXT) = '' THEN
     BEGIN
     FIND_BMEM(JINPUTBOX('会员卡输入','请输入会员卡号码',ED_INPUT.TEXT),1);  //找会员
     END ELSE BEGIN
     FIND_BMEM(ED_INPUT.TEXT,1);  //找会员
     END;

  ED_INPUT_SETFOCUS;
end;

procedure TFMPOSA.F9Click(Sender: TObject);
begin
  _TB_DISC_PRICE := STRTOFLOATDEF(ED_INPUT.TEXT,0);
  ED_INPUT.Clear;
  ED_INPUT_SETFOCUS;

  // 客显 ===============================================================
  DSP_TITLE;
  DSP_TEXT1('Discount Price :' ,'R');
  DSP_TEXT2(FILL_STR(' ', FLOATTOSTR(_TB_DISC_PRICE) , 'L', 20 ) ,'R');
  // 客显 ===============================================================
end;

procedure TFMPOSA.F10Click(Sender: TObject);
begin
  _TB_DISC_PERCENT := STRTOFLOATDEF(ED_INPUT.TEXT,1);
  ED_INPUT.Clear;
  ED_INPUT_SETFOCUS;
  
  // 客显 ===============================================================
  DSP_TITLE;
  DSP_TEXT1('Discount Percent :' ,'R');
  DSP_TEXT2(FILL_STR(' ', FLOATTOSTR(_TB_DISC_PERCENT) + ' %' , 'L', 18 ) ,'R');
  // 客显 ===============================================================
end;

procedure TFMPOSA.F11Click(Sender: TObject);
VAR I : INTEGER;
begin
  IF _TB_TMP_GRID = FALSE  THEN  //暂存区是否有东西
     BEGIN
     _TB_TMP_BMENO      := ED_INPUT.Text;   //暂存_会员编号
     _TB_TMP_GRID   := TRUE;  //暂存区是否有东西
     FOR I := 1 TO 200 DO
         BEGIN
         OUT_GRID_TMP.Rows[I].Text := OUT_GRID.Rows[I].Text;
         OUT_GRID.Rows[I].Text := '' ;
         IF TRIM(OUT_GRID.Cells[1,I+1]) =  '' THEN BREAK;
         END;

     VAR_INI;     //全部清除
  
     // 客显 ===============================================================
     DSP_TITLE;
     DSP_TEXT1('Save Data To Memory ! ' ,'R');
     DSP_TEXT2('' ,'R');
     // 客显 ===============================================================

     END ELSE BEGIN
     ED_INPUT.Text := _TB_TMP_BMENO;   //暂存_会员编号
     FIND_BMEM(_TB_TMP_BMENO,1);  //找会员
  
     _TB_TMP_GRID := FALSE;  //暂存区是否有东西
     FOR I := 1 TO 200 DO
         BEGIN
         OUT_GRID.Rows[I].Text := OUT_GRID_TMP.Rows[I].Text;
         OUT_GRID_TMP.Rows[I].Text := '' ;
         IF TRIM(OUT_GRID_TMP.Cells[1,I+1]) =  '' THEN BREAK;
         END;
  
     // 客显 ===============================================================
     DSP_TITLE;
     DSP_TEXT1('Load Data OK ! ' ,'R');
     DSP_TEXT2('' ,'R');
     // 客显 ===============================================================
     END;

  ED_INPUT_SETFOCUS;
end;

procedure TFMPOSA.F12Click(Sender: TObject);
VAR I, TARGET, DEL_REC :INTEGER;
BEGIN
  DEL_REC := _TB_TOTAL_REC - STRTOINTDEF(ED_INPUT.TEXT,-1);
  TARGET  := OUT_GRID.Row;
  IF (STRTOINTDEF(ED_INPUT.TEXT,-1) >= 0) THEN TARGET := DEL_REC + 1;
  
  //条件不合 跳出
  IF (TARGET <= 0) OR (TRIM(OUT_GRID.Cells[1,1])= '') THEN
     BEGIN
     ED_INPUT_SETFOCUS;
     EXIT;
     END;
  
  DEC(_TB_TOTAL_REC);      //删除后上移
  FOR I := TARGET TO 200 DO
      BEGIN
      OUT_GRID.Rows[I].Text := OUT_GRID.Rows[I+1].Text;
      IF TRIM(OUT_GRID.Cells[1,I+1]) =  '' THEN BREAK;
      END;
  
  FOR I := 1 TO 200 DO
      BEGIN
      OUT_GRID.Cells[0,I] := INTTOSTR(_TB_TOTAL_REC-I+1);
      IF TRIM(OUT_GRID.Cells[1,I+1]) =  '' THEN BREAK;
      END;
  
  _TB_DSP_CHANGED:= FALSE;  //已更动, 客显要更新
  ED_INPUT_SETFOCUS;

  // 客显 ===============================================================
  DSP_TITLE;
  DSP_TEXT1('Delete Single Rec !' ,'R');
  DSP_TEXT2('' ,'R');
  // 客显 ===============================================================
end;

procedure TFMPOSA.CTRLLClick(Sender: TObject);
VAR T_SUB, I : INTEGER;
    T_BGCOT  : REAL;
BEGIN
  IF _TB_TOTAL_REC   <=0 THEN EXIT;
  IF _TB_TOTAL_PRICE <=0 THEN EXIT;
  
  T_SUB := STRTOINTDEF(ED_INPUT.TEXT,-1);
  IF T_SUB <=0 THEN EXIT;
  
  IF _TB_LAST_SUB = TRUE THEN
     BEGIN
     _TB_LAST_PRICE  := T_SUB;  //去尾数另外打印
     END ELSE BEGIN
     WHILE T_SUB > 0 DO
       BEGIN
       FOR I := 1 TO 200 DO
         BEGIN
         T_BGCOT := STRTOFLOATDEF(OUT_GRID.Cells[5,I],-1);
         IF T_BGCOT <= 0 THEN CONTINUE;   //小于等于 0 , 不去尾数
  
         OUT_GRID.Cells[5,I] := FLOATTOSTR(T_BGCOT-1);
         DEC(T_SUB);
         IF T_SUB <= 0 THEN
            BEGIN
            ED_INPUT_SETFOCUS;
            EXIT;
            END;
         IF TRIM(OUT_GRID.Cells[1,I+1]) =  '' THEN BREAK;
         END;
         IF TRIM(OUT_GRID.Cells[1,I+1]) =  '' THEN BREAK;
       END;
     END;
  
  _TB_DSP_CHANGED:= FALSE;  //已更动, 客显要更新
  ED_INPUT_SETFOCUS;
end;

procedure TFMPOSA.CTRLCClick(Sender: TObject);
VAR I : INTEGER;
begin
  I := STRTOINTDEF(ED_INPUT.TEXT,0);
  IF I >= 0 THEN _TB_INV_CNT := I;
  ED_INPUT_SETFOCUS;
end;

procedure TFMPOSA.CTRLPClick(Sender: TObject);
begin
  IF _TB_PRN_PRINTING = TRUE THEN //是否打印发票
     BEGIN
     IF _TB_PRN_ALWAYSON = TRUE THEN //预设 强迫 要开发票,就不能不打印发票
        BEGIN
        _TB_PRN_PRINTING := TRUE; //是否打印发票
        END ELSE BEGIN
        _TB_PRN_PRINTING := FALSE; //是否打印发票
        END;
     END ELSE BEGIN
     _TB_PRN_PRINTING := TRUE; //是否打印发票
     END;
end;

procedure TFMPOSA.CTRLHClick(Sender: TObject);
begin
  IF Application.FindComponent('FMPOSAKEY')=nil then Application.CreateForm(TFMPOSAKEY,  FMPOSAKEY  );
  FMPOSAKEY.SHOWMODAL;
end;

procedure TFMPOSA.CTRLIClick(Sender: TObject);
begin
  IF (ED_INPUT.Text<>'') AND (INVOICE_NO_CHECK(ED_INPUT.Text)=TRUE) THEN
     _TB_INV_NO := ED_INPUT.TEXT;

  ED_INPUT_SETFOCUS;
end;

procedure TFMPOSA.CTRLNClick(Sender: TObject);
begin
  IF Application.FindComponent('FMBGDSQ')=nil then
     BEGIN
     Application.CreateForm(TFMBGDSQ, FMBGDSQ );
     FMBGDSQ.SHOWMODAL;
     END;
  ED_INPUT_SETFOCUS;
end;

procedure TFMPOSA.CTRLMClick(Sender: TObject);
begin
  IF Application.FindComponent('FMBMEMQ')=nil then
     BEGIN
     Application.CreateForm(TFMBMEMQ, FMBMEMQ );
     FMBMEMQ.SHOWMODAL;
     END;
  ED_INPUT_SETFOCUS;
end;


procedure TFMPOSA.CTRLSClick(Sender: TObject);
begin
  IF (_USER_ID <> '') THEN
     BEGIN
     IF Application.FindComponent('FMPOSAMESSAGE')=nil then Application.CreateForm(TFMPOSAMESSAGE,  FMPOSAMESSAGE  );
     FMPOSAMESSAGE.SHOWMODAL;
     END;
  ED_INPUT_SETFOCUS;
end;

procedure TFMPOSA.CTRLVClick(Sender: TObject);
begin
  _TB_BACK_MODE := NOT _TB_BACK_MODE; //退货模式
end;

procedure TFMPOSA.CTRLXClick(Sender: TObject);
begin
 {
  IF Application.FindComponent('FMLOG')=nil then Application.CreateForm(TFMLOG,  FMLOG  );
  FMLOG.LOGIN_NAME := '前台';
  FMLOG.ShowModal;
  ED_INPUT_SETFOCUS;}
end;

procedure TFMPOSA.CTRLZClick(Sender: TObject);
begin
  IF Application.FindComponent('FMPOSASINGLE')=nil then
     BEGIN
     Application.CreateForm(TFMPOSASINGLE, FMPOSASINGLE );
     FMPOSASINGLE.SHOWMODAL;
     END;
  ED_INPUT_SETFOCUS;
end;

procedure TFMPOSA.CTRLF8Click(Sender: TObject);
begin
  IF TRIM(ED_INPUT.TEXT) = '' THEN EXIT;
  IF Application.FindComponent('FMBMEMN,')=nil then Application.CreateForm(TFMBMEMN,  FMBMEMN  );
  IF SENDER = CTRLF5  THEN FMBMEMN.SEARCH_BMENO(ED_INPUT.TEXT);
  IF SENDER = CTRLF6  THEN FMBMEMN.SEARCH_BMNAM(ED_INPUT.TEXT);
  IF SENDER = CTRLF7  THEN FMBMEMN.SEARCH_BMTEL(ED_INPUT.TEXT);
  IF SENDER = CTRLF8  THEN FMBMEMN.SEARCH_BMADR(ED_INPUT.TEXT);
  FMBMEMN.SHOWMODAL;

  IF TRIM(_TB_TMP_BMENO) <> '' THEN
     BEGIN
     FIND_BMEM(_TB_TMP_BMENO,1);  //找产品
     END;
  ED_INPUT_SETFOCUS;
end;

procedure TFMPOSA.CTRLF12Click(Sender: TObject);
begin
  IF TRIM(ED_INPUT.TEXT) = '' THEN EXIT;
  IF Application.FindComponent('FMBGDSN,')=nil then Application.CreateForm(TFMBGDSN,  FMBGDSN  );
  IF SENDER = CTRLF9  THEN FMBGDSN.SEARCH_BGENO(ED_INPUT.TEXT);
  IF SENDER = CTRLF10 THEN FMBGDSN.SEARCH_BGNAM(ED_INPUT.TEXT);
  IF SENDER = CTRLF11 THEN FMBGDSN.SEARCH_BSENO(ED_INPUT.TEXT);
  IF SENDER = CTRLF12 THEN FMBGDSN.SEARCH_BGKIN(ED_INPUT.TEXT);
  FMBGDSN.SHOWMODAL;

  ED_INPUT.TEXT := _TB_TMP_BGENO;
  IF TRIM(_TB_TMP_BGENO) <> '' THEN
     BEGIN
     FIND_BGDS(_TB_TMP_BGENO,1);  //找产品
     CHECK_PRICE;  //检查价钱
     GRID_ADD;
     END;
  ED_INPUT_SETFOCUS;
end;

procedure TFMPOSA.CTRLQClick(Sender: TObject);
begin
  CLOSE;
end;
// HOT KEY ====================================================================





end.


