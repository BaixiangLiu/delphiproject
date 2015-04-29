unit UNALLEGO;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, ExtCtrls, Buttons, Spin, SPComm, Mask;

type
  TFMALLEGO = class(TForm)
    PageControl: TPageControl;
    PAGE_A: TTabSheet;
    ED_PORT: TRadioGroup;
    ED_CUTTER: TCheckBox;
    BitBtn1: TBitBtn;
    TabSheet2: TTabSheet;
    P_TEST_TEXT: TBitBtn;
    Label5: TLabel;
    ED_DENSITY: TSpinEdit;
    Comm1: TComm;
    Label6: TLabel;
    ED_DIR: TRadioGroup;
    Label7: TLabel;
    P_TEXT: TEdit;
    Label8: TLabel;
    Label9: TLabel;
    P_BARCODE: TEdit;
    P_TEST_BARCODE: TBitBtn;
    Label10: TLabel;
    ED_DELAY: TSpinEdit;
    ED_CODE: TComboBox;
    Label16: TLabel;
    Memo: TMemo;
    Label17: TLabel;
    Label1: TLabel;
    ED_DOT: TSpinEdit;
    ED_REF1: TMaskEdit;
    ED_REF2: TMaskEdit;
    Label2: TLabel;
    P_CTEXT: TEdit;
    P_TEST_CTEXT: TBitBtn;
    procedure FormActivate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure P_TEST_TEXTClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure P_TEST_BARCODEClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ED_REF2Exit(Sender: TObject);
    procedure P_TEST_CTEXTClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
   FILENAME      :STRING;

   C_SPEED       :STRING;
   C_DOT         :STRING;
   C_DENSITY     :STRING;
   C_DIR         :STRING;
   C_REF1        :STRING;
   C_REF2        :STRING;
   C_CUTTER      :STRING;
   C_PORT        :STRING;
   C_DELAY       :STRING;
   C_CODE        :STRING;

   TF :TEXTFILE;
   OUT_PORT :STRING;

   PROCEDURE OPEN_PORT;
   PROCEDURE READ_INI;
   PROCEDURE WRITE_INI;
   PROCEDURE CHANGE_INI;

   PROCEDURE PRINT_TITLE;
   PROCEDURE PRINT_END(CNT:INTEGER);
   PROCEDURE PRINT_CLS;
   PROCEDURE PRINT_ENTER_LABEL_FORMATTING_MODE;

   PROCEDURE PRINT_BARCODE(X,Y,WIDTH,HEIGHT:INTEGER;EXPRESSION:STRING;SHOW_TEXT:BOOLEAN);
   PROCEDURE PRINT_TEXT(FONT:STRING;X,Y:INTEGER;EXPRESSION:STRING);
   PROCEDURE PRINT_TEXT_POINT(FONT:STRING;X,Y:INTEGER;EXPRESSION:STRING);
   PROCEDURE PRINT_CUSTTEXT(EXPRESSION:STRING);

   PROCEDURE PRINT_SAVE_CTEXT(CNAME:STRING;T_FONTSIZE:INTEGER;T_FONTNAME,EXPRESSION:STRING);
   PROCEDURE PRINT_CTEXT(CNAME:STRING;X,Y:INTEGER);

   FUNCTION  TEXT_ENCODE_HEX(T_FONTSIZE:INTEGER;T_FONTNAME, T_STR:STRING):STRING;
  end;




var
  FMALLEGO: TFMALLEGO;

implementation

USES UN_UTL;

{$R *.DFM}


PROCEDURE TFMALLEGO.OPEN_PORT;
BEGIN

IF C_PORT = '0' THEN OUT_PORT := 'COM1';
IF C_PORT = '1' THEN OUT_PORT := 'COM2';
IF C_PORT = '2' THEN OUT_PORT := 'COM3';
IF C_PORT = '3' THEN OUT_PORT := 'COM4';

Comm1.CommName := OUT_PORT;
Comm1.StartComm;
Comm1.StopComm;

END;

PROCEDURE TFMALLEGO.READ_INI;
BEGIN

IF FileExists(FILENAME) = TRUE  THEN
   BEGIN
   C_SPEED  := FILE_READLN_REC(FILENAME,'LB_SPEED');
   C_DOT    := FILE_READLN_REC(FILENAME,'LB_DOT');
   C_DENSITY:= FILE_READLN_REC(FILENAME,'LB_DENSITY');
   C_DIR    := FILE_READLN_REC(FILENAME,'LB_DIR');
   C_REF1   := FILE_READLN_REC(FILENAME,'LB_REF1');
   C_REF2   := FILE_READLN_REC(FILENAME,'LB_REF2');
   C_CUTTER := FILE_READLN_REC(FILENAME,'LB_CUTTER');
   C_PORT   := FILE_READLN_REC(FILENAME,'LB_PORT');
   C_DELAY  := FILE_READLN_REC(FILENAME,'LB_DELAY');
   C_CODE   := FILE_READLN_REC(FILENAME,'LB_CODE');
   END;

END;

PROCEDURE TFMALLEGO.WRITE_INI;
BEGIN

FILENAME := 'ALLEGRO.INI';
IF FileExists(FILENAME) = TRUE  THEN
   BEGIN
   FILE_REWRITE(FILENAME);
//   FILE_APPEND_LOG(FILENAME,'LB_SPEED'  ,ED_SPEED.Text);
   FILE_APPEND_LOG(FILENAME,'LB_DOT'    ,ED_DOT.Text);
   FILE_APPEND_LOG(FILENAME,'LB_DENSITY',ED_DENSITY.Text);
   FILE_APPEND_LOG(FILENAME,'LB_DIR'    ,INTTOSTR(ED_DIR.ItemIndex));
   FILE_APPEND_LOG(FILENAME,'LB_REF1'   ,ED_REF1.Text);
   FILE_APPEND_LOG(FILENAME,'LB_REF2'   ,ED_REF2.Text);
   IF ED_CUTTER.CHECKED = FALSE THEN FILE_APPEND_LOG(FILENAME,'LB_CUTTER','0');
   IF ED_CUTTER.CHECKED = TRUE  THEN FILE_APPEND_LOG(FILENAME,'LB_CUTTER','1');
   FILE_APPEND_LOG(FILENAME,'LB_PORT'  ,INTTOSTR(ED_PORT.ItemIndex));
   FILE_APPEND_LOG(FILENAME,'LB_DELAY',ED_DELAY.Text);
   FILE_APPEND_LOG(FILENAME,'LB_CODE',INTTOSTR(ED_CODE.ItemIndex) );
   END;


END;

PROCEDURE TFMALLEGO.CHANGE_INI;
BEGIN

//   C_SPEED   := ED_SPEED.Text;
   C_DOT     := ED_DOT.Text;
   C_DENSITY := ED_DENSITY.Text;
   C_DIR     := INTTOSTR(ED_DIR.ItemIndex);
   C_REF1    := ED_REF1.Text;
   C_REF2    := ED_REF2.Text;
   IF ED_CUTTER.Checked = FALSE THEN C_CUTTER := '0';
   IF ED_CUTTER.Checked = TRUE  THEN C_CUTTER := '1';
   C_PORT  := INTTOSTR(ED_PORT.ItemIndex);
   C_DELAY   := ED_DELAY.Text;
   C_CODE    := INTTOSTR(ED_CODE.ItemIndex);

END;


PROCEDURE TFMALLEGO.PRINT_TITLE;
VAR T_LIST : TSTRINGS;
BEGIN
T_LIST := TSTRINGLIST.Create;

CHANGE_INI;
OPEN_PORT;

T_LIST.Add(CHR(2)+'qA');

T_LIST.Add(CHR(2)+'e');
T_LIST.Add(CHR(2)+'f214');   //SET FORM STOP POSITION , BACKFEED
T_LIST.Add(CHR(2)+'V0');    //裁刀
T_LIST.Add(CHR(2)+'O0214'); //OFFSET偏量
T_LIST.Add(CHR(2)+'M0500'); //标签最大长度

//T_LIST.Add('D'+C_DOT);         //点的粗细  //要在 FORMAT MODE 后设
T_LIST.Add('W');
T_LIST.Add('PC');          //打印速度
T_LIST.Add('SC');          //FEED速度
T_LIST.Add('H'+C_DENSITY);         //打印质量(温度)
//T_LIST.Add('H07');         //打印质量(温度)


IF TEST_OPEN_FILE(OUT_PORT) = FALSE THEN
   BEGIN
   SHOWMESSAGE('无法打开连接口');
   END;
IF TEST_OPEN_FILE(OUT_PORT) = TRUE THEN
   BEGIN
   AssignFile(TF,OUT_PORT);
   REWRITE(TF);
   WRITELN(TF,T_LIST.TEXT);
   CloseFile(TF);

{   C_CUTTER }
   MEMO.Lines.Clear;
   MEMO.Lines.TEXT := T_LIST.TEXT;
   END;

T_LIST.FREE;   
END;


PROCEDURE TFMALLEGO.PRINT_END(CNT:INTEGER);
BEGIN

DELAY(STRTOINTDEF(C_DELAY,0));

IF TEST_OPEN_FILE(OUT_PORT) = TRUE THEN
   BEGIN
   AssignFile(TF,OUT_PORT);
   REWRITE(TF);
   WRITELN(TF,'E');
   CloseFile(TF);
   MEMO.Lines.Add('E');
   END;
END;


PROCEDURE TFMALLEGO.PRINT_CLS;
BEGIN
IF TEST_OPEN_FILE(OUT_PORT) = TRUE THEN
   BEGIN
   AssignFile(TF,OUT_PORT);
   REWRITE(TF);
   WRITELN(TF,'CLS');
   CloseFile(TF);
   END;
END;

PROCEDURE TFMALLEGO.PRINT_ENTER_LABEL_FORMATTING_MODE;
BEGIN
IF TEST_OPEN_FILE(OUT_PORT) = TRUE THEN
   BEGIN
   AssignFile(TF,OUT_PORT);
   REWRITE(TF);
   WRITELN(TF,CHR(2)+'L');
   WRITELN(TF,'D'+C_DOT);      //点的粗细
   CloseFile(TF);
   MEMO.Lines.Add(CHR(2)+'L');
   END;
END;


PROCEDURE TFMALLEGO.PRINT_BARCODE(X,Y,WIDTH,HEIGHT:INTEGER;EXPRESSION:STRING;SHOW_TEXT:BOOLEAN);
VAR TP:STRING;
    T_DIR:STRING;
BEGIN

//设定条形码种类 ========================
IF SHOW_TEXT = FALSE THEN
case STRTOINTDEF(C_CODE,0) of
   0 :  TP := 'a';
   1 :  TP := 'o';
   2 :  TP := 'e';
   3 :  TP := 'f';
   else TP := 'a';
end;
IF SHOW_TEXT = TRUE THEN
case STRTOINTDEF(C_CODE,0) of
   0 :  TP := 'A';
   1 :  TP := 'O';
   2 :  TP := 'E';
   3 :  TP := 'F';
   else TP := 'A';
end;



   T_DIR := INTTOSTR(STRTOINTDEF(C_DIR,0)+1);
   X:= X + STRTOINTDEF(C_REF1,0);
   Y:= Y + STRTOINTDEF(C_REF2,0);



IF TEST_OPEN_FILE(OUT_PORT) = TRUE THEN
   BEGIN
   AssignFile(TF,OUT_PORT);
   REWRITE(TF);
   WRITELN(TF,T_DIR+ TP
                 + FILL_STR('0', INTTOSTR(WIDTH)  , 'L' ,2 )
                 + FILL_STR('0', INTTOSTR(HEIGHT) , 'L' ,3 )
                 + FILL_STR('0', INTTOSTR(Y), 'L' ,4 )
                 + FILL_STR('0', INTTOSTR(X), 'L' ,4 )
                 + EXPRESSION );
   CloseFile(TF);



   MEMO.Lines.Add(T_DIR+ TP
                 + FILL_STR('0', INTTOSTR(WIDTH)  , 'L' ,2 )
                 + FILL_STR('0', INTTOSTR(HEIGHT) , 'L' ,3 )
                 + FILL_STR('0', INTTOSTR(Y), 'L' ,4 )
                 + FILL_STR('0', INTTOSTR(X), 'L' ,4 )
                 + EXPRESSION );
   END;
END;

PROCEDURE TFMALLEGO.PRINT_TEXT(FONT:STRING;X,Y:INTEGER;EXPRESSION:STRING);
VAR T_DIR:STRING;
BEGIN

IF TEST_OPEN_FILE(OUT_PORT) = TRUE THEN
   BEGIN

   T_DIR := INTTOSTR(STRTOINTDEF(C_DIR,0)+1);
   X:= X + STRTOINTDEF(C_REF1,0);
   Y:= Y + STRTOINTDEF(C_REF2,0);


   AssignFile(TF,OUT_PORT);
   REWRITE(TF);
   WRITELN(TF,T_DIR+ FONT
                 + '11' + '000'
                 + FILL_STR('0', INTTOSTR(Y), 'L' ,4 )
                 + FILL_STR('0', INTTOSTR(X), 'L' ,4 )
                 + EXPRESSION );

   CloseFile(TF);



   MEMO.Lines.Add(T_DIR+ FONT
                 + '11' + '000'
                 + FILL_STR('0', INTTOSTR(Y), 'L' ,4 )
                 + FILL_STR('0', INTTOSTR(X), 'L' ,4 )
                 + EXPRESSION );

   END;
END;

PROCEDURE TFMALLEGO.PRINT_TEXT_POINT(FONT:STRING;X,Y:INTEGER;EXPRESSION:STRING);
VAR T_DIR, S:STRING;
BEGIN

IF TEST_OPEN_FILE(OUT_PORT) = TRUE THEN
   BEGIN

   T_DIR := INTTOSTR(STRTOINTDEF(C_DIR,0)+1);
   X:= X + STRTOINTDEF(C_REF1,0);
   Y:= Y + STRTOINTDEF(C_REF2,0);

   S :=T_DIR+ '9'
            + '00' + FONT
            + FILL_STR('0', INTTOSTR(Y), 'L' ,4 )
            + FILL_STR('0', INTTOSTR(X), 'L' ,4 )
            + EXPRESSION ;

//T_LIST.Add('D99');         //点的粗细
   AssignFile(TF,OUT_PORT);
   REWRITE(TF);
   WRITELN(TF,S);
   CloseFile(TF);

   MEMO.Lines.Add(S);
   END;
END;

PROCEDURE TFMALLEGO.PRINT_CUSTTEXT(EXPRESSION:STRING);
BEGIN

IF TEST_OPEN_FILE(OUT_PORT) = TRUE THEN
   BEGIN
   AssignFile(TF,OUT_PORT);
   REWRITE(TF);
   WRITELN(TF,EXPRESSION );
   CloseFile(TF);

   MEMO.Lines.Add(EXPRESSION );
   END;
END;

PROCEDURE TFMALLEGO.PRINT_SAVE_CTEXT(CNAME:STRING;T_FONTSIZE:INTEGER;T_FONTNAME,EXPRESSION:STRING);
VAR T_LIST : TSTRINGS;
BEGIN
T_LIST := TSTRINGLIST.Create;

IF TEST_OPEN_FILE(OUT_PORT) = TRUE THEN
   BEGIN
   T_LIST.Add(CHR(2)+'IAAF'+CNAME);
   T_LIST.Add(TEXT_ENCODE_HEX(T_FONTSIZE,T_FONTNAME,EXPRESSION+' '));
//   T_LIST.Add(TEXT_ENCODE_HEX(12,'楷体',EXPRESSION));
   AssignFile(TF,OUT_PORT);
   REWRITE(TF);
   WRITELN(TF,T_LIST.TEXT);
   CloseFile(TF);

   MEMO.Lines.Add(T_LIST.TEXT);
   END;

T_LIST.FREE;
END;

PROCEDURE TFMALLEGO.PRINT_CTEXT(CNAME:STRING;X,Y:INTEGER);
VAR T_LIST : TSTRINGS;
    T_DIR:STRING;
BEGIN
T_LIST := TSTRINGLIST.Create;

IF TEST_OPEN_FILE(OUT_PORT) = TRUE THEN
   BEGIN

   T_DIR := INTTOSTR(STRTOINTDEF(C_DIR,0)+1);
   X:= X + STRTOINTDEF(C_REF1,0);
   Y:= Y + STRTOINTDEF(C_REF2,0);

   T_LIST.Add('1Y11000'
                 + FILL_STR('0', INTTOSTR(Y), 'L' ,4 )
                 + FILL_STR('0', INTTOSTR(X), 'L' ,4 )
                 + CNAME);//EXPRESSION );
//   T_LIST.Add('1Y1100000000000LOGO');
   AssignFile(TF,OUT_PORT);
   REWRITE(TF);
   WRITELN(TF,T_LIST.TEXT);
   CloseFile(TF);

   MEMO.Lines.Add(T_LIST.TEXT);
   END;

T_LIST.FREE;
END;

procedure TFMALLEGO.FormCreate(Sender: TObject);
begin
PAGE_A.SHOW;
FILENAME := 'ALLEGRO.INI';


IF FileExists(FILENAME) = FALSE THEN
   BEGIN
   FILE_CREATE(FILENAME);
   WRITE_INI;
   END;


IF FileExists(FILENAME) = TRUE  THEN
   BEGIN
   READ_INI;
//   ED_SPEED.Text   :=C_SPEED;
   ED_DOT.Text     := C_DOT ;
   ED_DENSITY.Text := C_DENSITY ;
   ED_DIR.ItemIndex:= STRTOINTDEF(C_DIR,0);
   ED_REF1.Text    := C_REF1    ;
   ED_REF2.Text    := C_REF2    ;
   IF C_CUTTER = '0' THEN ED_CUTTER.Checked := FALSE;
   IF C_CUTTER = '1' THEN ED_CUTTER.Checked := TRUE;
   ED_PORT.ItemIndex := STRTOINTDEF(C_PORT,1);
   ED_DELAY.Text     := C_DELAY ;
   ED_CODE.ItemIndex := STRTOINT(C_CODE) ;
   END;




end;



procedure TFMALLEGO.FormActivate(Sender: TObject);
begin
//PAGE_A.SHOW;
end;

procedure TFMALLEGO.FormClose(Sender: TObject; var Action: TCloseAction);
begin
WRITE_INI;
//PRINT_TITLE;
end;

procedure TFMALLEGO.BitBtn1Click(Sender: TObject);
begin
CLOSE;
end;

procedure TFMALLEGO.P_TEST_TEXTClick(Sender: TObject);
begin
   PRINT_TITLE;
   PRINT_ENTER_LABEL_FORMATTING_MODE;
   PRINT_TEXT('6',0,0,P_TEXT.Text);
   PRINT_END(1);
end;

procedure TFMALLEGO.P_TEST_CTEXTClick(Sender: TObject);
begin
   PRINT_TITLE;
   PRINT_SAVE_CTEXT('A1',12,'宋体',P_CTEXT.Text);
   PRINT_SAVE_CTEXT('A2',12,'新宋体',P_CTEXT.Text+'A');
   PRINT_SAVE_CTEXT('A3',12,'楷体',P_CTEXT.Text+'A');
   PRINT_ENTER_LABEL_FORMATTING_MODE;

   PRINT_CTEXT('A1',0,0);
   PRINT_CTEXT('A2',20,20);
   PRINT_CTEXT('A3',40,40);
   PRINT_END(1);
end;

procedure TFMALLEGO.P_TEST_BARCODEClick(Sender: TObject);
begin
   PRINT_TITLE;
   PRINT_ENTER_LABEL_FORMATTING_MODE;
   PRINT_BARCODE(0,0,91,50,P_BARCODE.Text,TRUE);
   PRINT_END(1);
end;







procedure TFMALLEGO.ED_REF2Exit(Sender: TObject);
begin
WITH SENDER AS TMASKEDIT DO
     BEGIN
     IF CHECK_INT(TEXT) = FALSE THEN //检查是否为整数
     IF CHECK_FLOAT(TEXT) = FALSE THEN //检查小数点
        BEGIN
        SetFocus;
        SelectAll;
        EXIT;
        END;
     END;

end;




























FUNCTION TFMALLEGO.TEXT_ENCODE_HEX(T_FONTSIZE:INTEGER;T_FONTNAME, T_STR:STRING):STRING;
VAR T_LIST1 , T_LIST2 : TSTRINGS;
    I , J , MAX_I , MAX_J :INTEGER;
    T_TMP, T_TMP2, T_TMP3 , T_ANS: STRING;
    T_BMP : TBITMAP;
BEGIN

TRY

T_LIST1 := TSTRINGLIST.Create;
T_LIST2 := TSTRINGLIST.Create;
T_BMP   := TBITMAP.Create;

T_BMP.Height    := 800;    //宽高先设好, 才能放入图形
T_BMP.WIDTH     := 800;
T_BMP.Canvas.Font.Color    := clBlack;
//T_BMP.Canvas.Font.Style    := [FSBOLD];
T_BMP.Canvas.Font.SIZE     := T_FONTSIZE;
T_BMP.Canvas.Font.Name     := T_FONTNAME;
T_BMP.Canvas.TextOut(1,1,T_STR);

MAX_I := T_BMP.Canvas.TextWidth (T_STR)   ;
MAX_J := T_BMP.Canvas.TextHEIGHT(T_STR)+5 ;

T_LIST1.Clear;
FOR J := MAX_J DOWNTO 0 DO
    BEGIN
    T_TMP := '';
    FOR I := 0 TO MAX_I DO
        BEGIN
        IF T_BMP.Canvas.Pixels[I,J] = CLBLACK THEN T_TMP := T_TMP +'1';
        IF T_BMP.Canvas.Pixels[I,J] = CLWHITE THEN T_TMP := T_TMP +'0';
        END;
    T_LIST1.Add(T_TMP);
    END;

T_TMP  := '';
T_TMP2 := '';
MAX_I := T_LIST1.Count;
T_LIST2.Clear;
FOR I := 0 TO MAX_I-1 DO
    BEGIN

    T_ANS := '';
    T_TMP3 := T_LIST1.Strings[I];
    MAX_J := LENGTH(T_TMP3) DIV 4;
    FOR J := 0 TO MAX_J DO
        BEGIN
        T_TMP := '';
        T_TMP := COPY(T_TMP3,J*4,4);
        IF STRTOINTDEF(T_TMP,-1) <= 0 THEN T_TMP2:= '0';
        IF LENGTH(T_TMP)         <= 4 THEN T_TMP2:= '0';

        IF T_TMP = '0000' THEN T_TMP2:= '0';
        IF T_TMP = '0001' THEN T_TMP2:= '1';
        IF T_TMP = '0010' THEN T_TMP2:= '2';
        IF T_TMP = '0011' THEN T_TMP2:= '3';
        IF T_TMP = '0100' THEN T_TMP2:= '4';
        IF T_TMP = '0101' THEN T_TMP2:= '5';
        IF T_TMP = '0110' THEN T_TMP2:= '6';
        IF T_TMP = '0111' THEN T_TMP2:= '7';
        IF T_TMP = '1000' THEN T_TMP2:= '8';
        IF T_TMP = '1001' THEN T_TMP2:= '9';
        IF T_TMP = '1010' THEN T_TMP2:= 'A';
        IF T_TMP = '1011' THEN T_TMP2:= 'B';
        IF T_TMP = '1100' THEN T_TMP2:= 'C';
        IF T_TMP = '1101' THEN T_TMP2:= 'D';
        IF T_TMP = '1110' THEN T_TMP2:= 'E';
        IF T_TMP = '1111' THEN T_TMP2:= 'F';

        T_ANS := T_ANS + T_TMP2;
        END;

        IF LENGTH(T_ANS) MOD 2 = 1 THEN T_ANS := T_ANS + '0';

        T_TMP2:= '11';
        IF LENGTH(T_ANS) DIV 2 =  0 THEN T_TMP2:= '00';
        IF LENGTH(T_ANS) DIV 2 =  1 THEN T_TMP2:= '01';
        IF LENGTH(T_ANS) DIV 2 =  2 THEN T_TMP2:= '02';
        IF LENGTH(T_ANS) DIV 2 =  3 THEN T_TMP2:= '03';
        IF LENGTH(T_ANS) DIV 2 =  4 THEN T_TMP2:= '04';
        IF LENGTH(T_ANS) DIV 2 =  5 THEN T_TMP2:= '05';
        IF LENGTH(T_ANS) DIV 2 =  6 THEN T_TMP2:= '06';
        IF LENGTH(T_ANS) DIV 2 =  7 THEN T_TMP2:= '07';
        IF LENGTH(T_ANS) DIV 2 =  8 THEN T_TMP2:= '08';
        IF LENGTH(T_ANS) DIV 2 =  9 THEN T_TMP2:= '09';
        IF LENGTH(T_ANS) DIV 2 = 10 THEN T_TMP2:= '0A';
        IF LENGTH(T_ANS) DIV 2 = 11 THEN T_TMP2:= '0B';
        IF LENGTH(T_ANS) DIV 2 = 12 THEN T_TMP2:= '0C';
        IF LENGTH(T_ANS) DIV 2 = 13 THEN T_TMP2:= '0D';
        IF LENGTH(T_ANS) DIV 2 = 14 THEN T_TMP2:= '0E';
        IF LENGTH(T_ANS) DIV 2 = 15 THEN T_TMP2:= '0F';
        IF LENGTH(T_ANS) DIV 2 = 16 THEN T_TMP2:= '10';
        IF LENGTH(T_ANS) DIV 2 = 17 THEN T_TMP2:= '11';
        IF LENGTH(T_ANS) DIV 2 = 18 THEN T_TMP2:= '12';
        IF LENGTH(T_ANS) DIV 2 = 19 THEN T_TMP2:= '13';
        IF LENGTH(T_ANS) DIV 2 = 20 THEN T_TMP2:= '14';
        IF LENGTH(T_ANS) DIV 2 = 21 THEN T_TMP2:= '15';
        IF LENGTH(T_ANS) DIV 2 = 22 THEN T_TMP2:= '16';
        IF LENGTH(T_ANS) DIV 2 = 23 THEN T_TMP2:= '17';
        IF LENGTH(T_ANS) DIV 2 = 24 THEN T_TMP2:= '18';
        IF LENGTH(T_ANS) DIV 2 = 25 THEN T_TMP2:= '19';
        IF LENGTH(T_ANS) DIV 2 = 26 THEN T_TMP2:= '1A';
        IF LENGTH(T_ANS) DIV 2 = 27 THEN T_TMP2:= '1B';
        IF LENGTH(T_ANS) DIV 2 = 28 THEN T_TMP2:= '1C';
        IF LENGTH(T_ANS) DIV 2 = 29 THEN T_TMP2:= '1D';
        IF LENGTH(T_ANS) DIV 2 = 30 THEN T_TMP2:= '1E';
        IF LENGTH(T_ANS) DIV 2 = 31 THEN T_TMP2:= '1F';
        IF LENGTH(T_ANS) DIV 2 = 32 THEN T_TMP2:= '20';
        IF LENGTH(T_ANS) DIV 2 = 33 THEN T_TMP2:= '21';
        IF LENGTH(T_ANS) DIV 2 = 34 THEN T_TMP2:= '22';
        IF LENGTH(T_ANS) DIV 2 = 35 THEN T_TMP2:= '23';
        IF LENGTH(T_ANS) DIV 2 = 36 THEN T_TMP2:= '24';
        IF LENGTH(T_ANS) DIV 2 = 37 THEN T_TMP2:= '25';
        IF LENGTH(T_ANS) DIV 2 = 38 THEN T_TMP2:= '26';
        IF LENGTH(T_ANS) DIV 2 = 39 THEN T_TMP2:= '27';
        IF LENGTH(T_ANS) DIV 2 = 40 THEN T_TMP2:= '28';
        IF LENGTH(T_ANS) DIV 2 = 41 THEN T_TMP2:= '29';
        IF LENGTH(T_ANS) DIV 2 = 42 THEN T_TMP2:= '2A';
        IF LENGTH(T_ANS) DIV 2 = 43 THEN T_TMP2:= '2B';
        IF LENGTH(T_ANS) DIV 2 = 44 THEN T_TMP2:= '2C';
        IF LENGTH(T_ANS) DIV 2 = 45 THEN T_TMP2:= '2D';
        IF LENGTH(T_ANS) DIV 2 = 46 THEN T_TMP2:= '2E';
        IF LENGTH(T_ANS) DIV 2 = 47 THEN T_TMP2:= '2F';
        IF LENGTH(T_ANS) DIV 2 = 48 THEN T_TMP2:= '30';
        IF LENGTH(T_ANS) DIV 2 = 49 THEN T_TMP2:= '31';
        IF LENGTH(T_ANS) DIV 2 = 50 THEN T_TMP2:= '32';
        IF LENGTH(T_ANS) DIV 2 = 51 THEN T_TMP2:= '33';
        IF LENGTH(T_ANS) DIV 2 = 52 THEN T_TMP2:= '34';
        IF LENGTH(T_ANS) DIV 2 = 53 THEN T_TMP2:= '35';
        IF LENGTH(T_ANS) DIV 2 = 54 THEN T_TMP2:= '36';
        IF LENGTH(T_ANS) DIV 2 = 55 THEN T_TMP2:= '37';
        IF LENGTH(T_ANS) DIV 2 = 56 THEN T_TMP2:= '38';
        IF LENGTH(T_ANS) DIV 2 = 57 THEN T_TMP2:= '39';
        IF LENGTH(T_ANS) DIV 2 = 58 THEN T_TMP2:= '3A';
        IF LENGTH(T_ANS) DIV 2 = 59 THEN T_TMP2:= '3B';
        IF LENGTH(T_ANS) DIV 2 = 60 THEN T_TMP2:= '3C';

    T_LIST2.Add('80'+T_TMP2+T_ANS);
    END;

T_LIST2.Add('FFFF');
//T_LIST2.Add(CHR(2)+'L');

RESULT := T_LIST2.TEXT;

FINALLY
T_BMP.Free;
T_LIST1.Free;
T_LIST2.Free;
END;
END;




end.
