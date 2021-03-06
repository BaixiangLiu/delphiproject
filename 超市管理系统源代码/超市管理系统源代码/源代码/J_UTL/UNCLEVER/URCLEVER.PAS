unit URCLEVER;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, ExtCtrls, Buttons, Spin, SPComm, Mask, FlEdit, Menus;

type
  TFRCLEVER = class(TForm)
    PageControl: TPageControl;
    PAGE_A: TTabSheet;
    ED_PORT: TRadioGroup;
    Label1: TLabel;
    Label3: TLabel;
    ED_CUTTER: TCheckBox;
    Label4: TLabel;
    Label2: TLabel;
    BTNQUT: TBitBtn;
    TabSheet2: TTabSheet;
    P_TEST_TEXT: TBitBtn;
    Label5: TLabel;
    ED_DENSITY: TSpinEdit;
    Label6: TLabel;
    ED_DIR: TRadioGroup;
    Label7: TLabel;
    P_TEXT: TEdit;
    P_BARCODE: TEdit;
    P_TEST_BARCODE: TBitBtn;
    Label10: TLabel;
    ED_DELAY: TSpinEdit;
    ED_CODE: TComboBox;
    Label16: TLabel;
    Memo: TMemo;
    Label17: TLabel;
    ED_LB_W: TFLOATEDIT;
    ED_LB_H: TFLOATEDIT;
    ED_SPEED: TFLOATEDIT;
    ED_GAP1: TFLOATEDIT;
    ED_GAP2: TFLOATEDIT;
    ED_REF1: TFLOATEDIT;
    ED_REF2: TFLOATEDIT;
    ED_UNIT: TRadioGroup;
    Label11: TLabel;
    ED_NARROW: TSpinEdit;
    BTNESC: TBitBtn;
    MainMenu: TMainMenu;
    N5: TMenuItem;
    procedure BTNQUTClick(Sender: TObject);
    procedure P_TEST_TEXTClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure P_TEST_BARCODEClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ED_CUTTERClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BTNESCClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  // 系统设置
  PROCEDURE CLEVER_CHANGE_VARIABLE;
  PROCEDURE CLEVER_OPEN_PORT;
  PROCEDURE CLEVER_READ_INI;
  PROCEDURE CLEVER_WRITE_INI;

  // 打印控制
  PROCEDURE CLEVER_PRINT_TITLE;
  PROCEDURE CLEVER_PRINT_END(CNT:INTEGER);
  PROCEDURE CLEVER_PRINT_CLS;
  PROCEDURE CLEVER_PRINT_BARCODE (X,Y,HEIGHT,HUMAN,ROTAT,WIDE:INTEGER;EXPRESSION:STRING);
  PROCEDURE CLEVER_PRINT_TEXT (X,Y:INTEGER;FONT:STRING;ROTAT,XMUL,YMUL:INTEGER;EXPRESSION:STRING);
  PROCEDURE CLEVER_PRINT_TEXT2(X,Y:INTEGER;FONT:STRING;ROTAT,XMUL,YMUL:INTEGER;EXPRESSION:STRING;SUB_TEXT:INTEGER);
  PROCEDURE CLEVER_PRINT_BOX(X1,Y1,X2,Y2,THICKNESS:INTEGER);


var
  FRCLEVER: TFRCLEVER;

  // 设置用变量 - 暂存
  CLEVER_OUT_PORT :STRING;
  CLEVER_FILENAME :STRING;
  CLEVER_TF       :TEXTFILE;

  // 设置用变量
  CLEVER_HEIGHT      :STRING;     // 标签高度
  CLEVER_WIDTH       :STRING;     // 标签宽度
  CLEVER_SPEED       :STRING;     // 打印速度
  CLEVER_DENSITY     :STRING;     // 条形码粗细
  CLEVER_DIR         :INTEGER;    // 打印方向
  CLEVER_REF1        :STRING;     // 参考坐标X
  CLEVER_REF2        :STRING;     // 参考坐标Y
  CLEVER_GAP1        :STRING;     // 标签间隙1
  CLEVER_GAP2        :STRING;     // 标签间隙2
  CLEVER_CUTTER      :BOOLEAN;    // 打印间隙
  CLEVER_PORT        :INTEGER;    // 连接口
  CLEVER_DELAY       :STRING;     // 延迟时间
  CLEVER_CODE        :INTEGER;    // 条形码种类
  CLEVER_UNIT        :INTEGER;    // 长度单位
  CLEVER_NARROW      :STRING;     // 打印浓度

implementation

USES UN_UTL, FM_UTL, SYSINI;

{$R *.DFM}

PROCEDURE CLEVER_CHANGE_VARIABLE;
BEGIN
  CLEVER_HEIGHT  := FRCLEVER.ED_LB_H.Text      ;
  CLEVER_WIDTH   := FRCLEVER.ED_LB_W.Text      ;
  CLEVER_SPEED   := FRCLEVER.ED_SPEED.Text     ;
  CLEVER_DENSITY := FRCLEVER.ED_DENSITY.Text   ;
  CLEVER_DIR     := FRCLEVER.ED_DIR.ItemIndex  ;
  CLEVER_REF1    := FRCLEVER.ED_REF1.Text      ;
  CLEVER_REF2    := FRCLEVER.ED_REF2.Text      ;
  CLEVER_GAP1    := FRCLEVER.ED_GAP1.Text      ;
  CLEVER_GAP2    := FRCLEVER.ED_GAP2.Text      ;
  CLEVER_CUTTER  := FRCLEVER.ED_CUTTER.CHECKED ;
  CLEVER_PORT    := FRCLEVER.ED_PORT.ItemIndex ;
  CLEVER_DELAY   := FRCLEVER.ED_DELAY.Text     ;
  CLEVER_CODE    := FRCLEVER.ED_CODE.ItemIndex ;
  CLEVER_UNIT    := FRCLEVER.ED_UNIT.ItemIndex ;
  CLEVER_NARROW  := FRCLEVER.ED_NARROW.Text    ;
END;


PROCEDURE CLEVER_OPEN_PORT;
VAR C : TCOMM;
BEGIN
  IF CLEVER_PORT = 0 THEN CLEVER_OUT_PORT := 'COM1';
  IF CLEVER_PORT = 1 THEN CLEVER_OUT_PORT := 'COM2';
  IF CLEVER_PORT = 2 THEN CLEVER_OUT_PORT := 'COM3';
  IF CLEVER_PORT = 3 THEN CLEVER_OUT_PORT := 'COM4';
  C          := TCOMM.Create(FRCLEVER);   // 使用内部式声明, 结束后自动清除资源
  C.CommName := CLEVER_OUT_PORT;          // 先使用 RS232 组件, 将输出端口打开
  C.StartComm;
  C.StopComm;
END;

PROCEDURE CLEVER_READ_INI;
BEGIN
  IF FileExists(FILEPATH_CLEVER) = TRUE  THEN
     BEGIN
     CLEVER_HEIGHT := INI_LOAD_STR (FILEPATH_CLEVER,'LB_HEIGHT'  ,'0');
     CLEVER_WIDTH  := INI_LOAD_STR (FILEPATH_CLEVER,'LB_WIDTH'   ,'0');
     CLEVER_SPEED  := INI_LOAD_STR (FILEPATH_CLEVER,'LB_SPEED'   ,'1');
     CLEVER_DENSITY:= INI_LOAD_STR (FILEPATH_CLEVER,'LB_DENSITY' ,'1');
     CLEVER_DIR    := INI_LOAD_INT (FILEPATH_CLEVER,'LB_DIR'     ,0);
     CLEVER_REF1   := INI_LOAD_STR (FILEPATH_CLEVER,'LB_REF1'    ,'1');
     CLEVER_REF2   := INI_LOAD_STR (FILEPATH_CLEVER,'LB_REF2'    ,'1');
     CLEVER_GAP1   := INI_LOAD_STR (FILEPATH_CLEVER,'LB_GAP1'    ,'1');
     CLEVER_GAP2   := INI_LOAD_STR (FILEPATH_CLEVER,'LB_GAP2'    ,'1');
     CLEVER_CUTTER := INI_LOAD_BOOL(FILEPATH_CLEVER,'LB_CUTTER'  ,FALSE);
     CLEVER_PORT   := INI_LOAD_INT (FILEPATH_CLEVER,'LB_PORT'    ,0);
     CLEVER_DELAY  := INI_LOAD_STR (FILEPATH_CLEVER,'LB_DELAY'   ,'100');
     CLEVER_CODE   := INI_LOAD_INT (FILEPATH_CLEVER,'LB_CODE'    ,0);
     CLEVER_UNIT   := INI_LOAD_INT (FILEPATH_CLEVER,'LB_UNIT'    ,0);
     CLEVER_NARROW := INI_LOAD_STR (FILEPATH_CLEVER,'LB_NARROW'  ,'0');
     IF FormExists('FRCLEVER' )=TRUE THEN
        BEGIN
        FRCLEVER.ED_LB_H.Text      := CLEVER_HEIGHT  ;
        FRCLEVER.ED_LB_W.Text      := CLEVER_WIDTH   ;
        FRCLEVER.ED_SPEED.Text     := CLEVER_SPEED   ;
        FRCLEVER.ED_DENSITY.Text   := CLEVER_DENSITY ;
        FRCLEVER.ED_DIR.ItemIndex  := CLEVER_DIR     ;
        FRCLEVER.ED_REF1.Text      := CLEVER_REF1    ;
        FRCLEVER.ED_REF2.Text      := CLEVER_REF2    ;
        FRCLEVER.ED_GAP1.Text      := CLEVER_GAP1    ;
        FRCLEVER.ED_GAP2.Text      := CLEVER_GAP2    ;
        FRCLEVER.ED_CUTTER.Checked := CLEVER_CUTTER  ;
        FRCLEVER.ED_PORT.ItemIndex := CLEVER_PORT    ;
        FRCLEVER.ED_DELAY.Text     := CLEVER_DELAY   ;
        FRCLEVER.ED_CODE.ItemIndex := CLEVER_CODE    ;
        FRCLEVER.ED_UNIT.ItemIndex := CLEVER_UNIT    ;
        FRCLEVER.ED_NARROW.Text    := CLEVER_NARROW  ;
        END;
     END;
END;

PROCEDURE CLEVER_WRITE_INI;
BEGIN
  IF FileExists(FILEPATH_CLEVER) = TRUE  THEN
     BEGIN
     FILE_REWRITE(FILEPATH_CLEVER);

     IF FormExists('FRCLEVER' )=TRUE THEN CLEVER_CHANGE_VARIABLE;
     INI_SAVE_STR (FILEPATH_CLEVER,'LB_HEIGHT' ,CLEVER_HEIGHT       );
     INI_SAVE_STR (FILEPATH_CLEVER,'LB_WIDTH'  ,CLEVER_WIDTH        );
     INI_SAVE_STR (FILEPATH_CLEVER,'LB_SPEED'  ,CLEVER_SPEED        );
     INI_SAVE_STR (FILEPATH_CLEVER,'LB_DENSITY',CLEVER_DENSITY      );
     INI_SAVE_INT (FILEPATH_CLEVER,'LB_DIR'    ,CLEVER_DIR          );
     INI_SAVE_STR (FILEPATH_CLEVER,'LB_REF1'   ,CLEVER_REF1         );
     INI_SAVE_STR (FILEPATH_CLEVER,'LB_REF2'   ,CLEVER_REF2         );
     INI_SAVE_STR (FILEPATH_CLEVER,'LB_GAP1'   ,CLEVER_GAP1         );
     INI_SAVE_STR (FILEPATH_CLEVER,'LB_GAP2'   ,CLEVER_GAP2         );
     INI_SAVE_BOOL(FILEPATH_CLEVER,'LB_CUTTER' ,CLEVER_CUTTER       );
     INI_SAVE_INT (FILEPATH_CLEVER,'LB_PORT'   ,CLEVER_PORT         );
     INI_SAVE_STR (FILEPATH_CLEVER,'LB_DELAY'  ,CLEVER_DELAY        );
     INI_SAVE_INT (FILEPATH_CLEVER,'LB_CODE'   ,CLEVER_CODE         );
     INI_SAVE_INT (FILEPATH_CLEVER,'LB_UNIT'   ,CLEVER_UNIT         );
     INI_SAVE_STR (FILEPATH_CLEVER,'LB_NARROW' ,CLEVER_NARROW       );
     END;
END;


PROCEDURE CLEVER_PRINT_TITLE;
VAR STR:STRING;
BEGIN
  CLEVER_OPEN_PORT;

  STR := '';
  STR := STR + 'SIZE '+CLEVER_WIDTH+','+CLEVER_HEIGHT  + #10#13;
  STR := STR + 'CLS' + #10#13;
  STR := STR + 'SPEED '+CLEVER_SPEED + #10#13;
  STR := STR + 'DENSITY '+CLEVER_DENSITY + #10#13;
  STR := STR + 'DIRECTION '+INTTOSTR(CLEVER_DIR) + #10#13;
  STR := STR + 'REFERENCE '+CLEVER_REF1+','+CLEVER_REF2 + #10#13;
  IF CLEVER_CUTTER = TRUE THEN
     STR := STR + 'GAP '+CLEVER_GAP1+','+CLEVER_GAP2 + #10#13;

  COMPORT_OUTLN(CLEVER_OUT_PORT, STR );

  IF FormExists('FRCLEVER' )=TRUE THEN
     BEGIN
     FRCLEVER.MEMO.Lines.Clear;
     FRCLEVER.MEMO.Lines.Add( STR );
     END;
END;


PROCEDURE CLEVER_PRINT_END(CNT:INTEGER);
VAR STR:STRING;
BEGIN
  DELAY(STRTOINTDEF(CLEVER_DELAY,0));

  STR := 'PRINT '+INTTOSTR(CNT);
  COMPORT_OUTLN(CLEVER_OUT_PORT, STR );
  IF FormExists('FRCLEVER' )=TRUE THEN FRCLEVER.MEMO.Lines.Add( STR );
END;


PROCEDURE CLEVER_PRINT_CLS;
VAR STR:STRING;
BEGIN
  DELAY(STRTOINTDEF(CLEVER_DELAY,0));

  STR := 'CLS';
  COMPORT_OUTLN(CLEVER_OUT_PORT, STR );
  IF FormExists('FRCLEVER' )=TRUE THEN FRCLEVER.MEMO.Lines.Add( STR );
END;

PROCEDURE CLEVER_PRINT_BARCODE(X,Y,HEIGHT,HUMAN,ROTAT,WIDE:INTEGER;EXPRESSION:STRING);
VAR TP:STRING;
    STR:STRING;
BEGIN
  //设置条形码种类 ========================
  case CLEVER_CODE of
     0 :  TP := '39';
     1 :  TP := '93';
     2 :  TP := '128';
     3 :  TP := 'EAN13';
     else TP := '39';
  end;

  STR := STR + 'BARCODE '+INTTOSTR(X)+','+INTTOSTR(Y)+',"'
             + TP+'",'
             + INTTOSTR(HEIGHT)+','+INTTOSTR(HUMAN) +','
             + INTTOSTR(ROTAT) +','
             + CLEVER_NARROW+','+INTTOSTR(WIDE)+',"'+EXPRESSION+'"';
  COMPORT_OUTLN(CLEVER_OUT_PORT, STR );
  IF FormExists('FRCLEVER' )=TRUE THEN FRCLEVER.MEMO.Lines.Add( STR );
END;

PROCEDURE CLEVER_PRINT_TEXT(X,Y:INTEGER;FONT:STRING;ROTAT,XMUL,YMUL:INTEGER;EXPRESSION:STRING);
VAR STR:STRING;
BEGIN
  STR := 'TEXT '+INTTOSTR(X)+','+INTTOSTR(Y)
         +',"'+FONT+'",'
         +INTTOSTR(ROTAT)+','
         +INTTOSTR(XMUL) +','
         +INTTOSTR(YMUL) +',"'+EXPRESSION+'"';
  COMPORT_OUTLN(CLEVER_OUT_PORT, STR );
  IF FormExists('FRCLEVER' )=TRUE THEN FRCLEVER.MEMO.Lines.Add( STR );
END;

PROCEDURE CLEVER_PRINT_TEXT2(X,Y:INTEGER;FONT:STRING;ROTAT,XMUL,YMUL:INTEGER;EXPRESSION:STRING;SUB_TEXT:INTEGER);
BEGIN
  IF SUB_TEXT >= 0 THEN
     BEGIN
     CLEVER_PRINT_TEXT(X,Y,FONT,ROTAT,XMUL,YMUL,   COPY(EXPRESSION,1         ,SUB_TEXT));
     CLEVER_PRINT_TEXT(X,Y+25,FONT,ROTAT,XMUL,YMUL,COPY(EXPRESSION,SUB_TEXT+1,LENGTH(EXPRESSION)-SUB_TEXT));
     END ELSE
     CLEVER_PRINT_TEXT(X,Y,FONT,ROTAT,XMUL,YMUL,   EXPRESSION);
END;


PROCEDURE CLEVER_PRINT_BOX(X1,Y1,X2,Y2,THICKNESS:INTEGER);
VAR STR:STRING;
BEGIN
  STR := 'BOX  '+INTTOSTR(X1)+','+INTTOSTR(Y1)+','
         +INTTOSTR(X2)+','+INTTOSTR(Y2)+','
         +INTTOSTR(THICKNESS)  ;
  COMPORT_OUTLN(CLEVER_OUT_PORT, STR );
  IF FormExists('FRCLEVER' )=TRUE THEN FRCLEVER.MEMO.Lines.Add( STR );
END;

procedure TFRCLEVER.FormCreate(Sender: TObject);
begin
  IF FileExists(FILEPATH_CLEVER) = FALSE THEN
     BEGIN
     FILE_CREATE(FILEPATH_CLEVER);
     CLEVER_WRITE_INI;
     END ELSE BEGIN
     CLEVER_READ_INI;
     END;
end;

procedure TFRCLEVER.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FRCLEVER.Release;
end;

procedure TFRCLEVER.FormShow(Sender: TObject);
begin
  PAGE_A.SHOW;
  
  IF ED_CUTTER.Checked = FALSE THEN
     BEGIN
     ED_GAP1.Enabled := FALSE;
     ED_GAP2.Enabled := FALSE;
     END;
end;

procedure TFRCLEVER.BTNQUTClick(Sender: TObject);
begin
  CLEVER_WRITE_INI;
  CLEVER_PRINT_TITLE;
  CLOSE;
end;

procedure TFRCLEVER.BTNESCClick(Sender: TObject);
begin
  CLOSE;
end;

procedure TFRCLEVER.P_TEST_TEXTClick(Sender: TObject);
begin
  CLEVER_CHANGE_VARIABLE;

  CLEVER_PRINT_TITLE;
  CLEVER_PRINT_TEXT(0,0,'TST24.BF2',0,1,1,P_TEXT.Text);
  CLEVER_PRINT_END(1);
end;

procedure TFRCLEVER.P_TEST_BARCODEClick(Sender: TObject);
begin
  CLEVER_CHANGE_VARIABLE;

  CLEVER_PRINT_TITLE;
  CLEVER_PRINT_BARCODE(0,0,96,1,0,4,P_BARCODE.Text);
  CLEVER_PRINT_END(1);
end;

procedure TFRCLEVER.ED_CUTTERClick(Sender: TObject);
begin
  ED_GAP1.Enabled := TRUE;
  ED_GAP2.Enabled := TRUE;
  IF ED_CUTTER.Checked = FALSE THEN
     BEGIN
     ED_GAP1.Enabled := FALSE;
     ED_GAP2.Enabled := FALSE;
     END;
end;






end.
