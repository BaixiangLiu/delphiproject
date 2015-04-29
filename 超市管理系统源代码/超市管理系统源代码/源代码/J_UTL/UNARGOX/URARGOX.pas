unit URARGOX;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  SPComm, StdCtrls, Buttons, Spin, ExtCtrls, ComCtrls, JEdit, Menus;

type
  TFRARGOX = class(TForm)
    PageControl: TPageControl;
    PAGE_A: TTabSheet;
    ED_PORT: TRadioGroup;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    BTNQUT: TBitBtn;
    TabSheet2: TTabSheet;
    P_TEST_TEXT: TBitBtn;
    Label5: TLabel;
    ED_DENSITY: TSpinEdit;
    Comm1: TComm;
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
    ED_LB_W: TJEdit;
    ED_LB_H: TJEdit;
    ED_REF1: TJEdit;
    ED_REF2: TJEdit;
    Label11: TLabel;
    ED_NARROW: TSpinEdit;
    ED_SPEED: TSpinEdit;
    Label2: TLabel;
    ED_WIDE: TSpinEdit;
    Label12: TLabel;
    ED_LB_G: TJEdit;
    Label13: TLabel;
    BTNESC: TBitBtn;
    MainMenu: TMainMenu;
    N5: TMenuItem;
    procedure FormActivate(Sender: TObject);
    procedure BTNQUTClick(Sender: TObject);
    procedure P_TEST_TEXTClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure P_TEST_BARCODEClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
   TF  : TEXTFILE;
   OUT_PORT :STRING;

   PROCEDURE OPEN_PORT;

   PROCEDURE PRINT_TITLE;
   PROCEDURE PRINT_END(CNT:INTEGER);

   PROCEDURE PRINT_BARCODE(X,Y,CODETYPE,HEIGHT:INTEGER;HUMAN,EXPRESSION:STRING);
   PROCEDURE PRINT_TEXT(X,Y:INTEGER;FONT:STRING;HSCALE,VSCALE:INTEGER;HUMAN,EXPRESSION:STRING);
   PROCEDURE PRINT_TEXT2(X,Y:INTEGER;FONT:STRING;HSCALE,VSCALE:INTEGER;HUMAN,EXPRESSION:STRING;SUB_TEXT:INTEGER);
   PROCEDURE PRINT_BOX(X1,Y1,X2,Y2,THICKNESS:INTEGER);

  end;




var
  FRARGOX: TFRARGOX;

implementation

USES UN_UTL, SYSINI;

{$R *.DFM}

procedure TFRARGOX.FormCreate(Sender: TObject);
begin
IF FileExists(FILEPATH_ARGOX) = FALSE  THEN FILE_CREATE(FILEPATH_ARGOX);

IF FileExists(FILEPATH_ARGOX) = TRUE  THEN
   BEGIN
   ED_LB_W   .TEXT := INI_LOAD_STR(FILEPATH_ARGOX,'ED_LB_W'   ,'200');
   ED_LB_H   .TEXT := INI_LOAD_STR(FILEPATH_ARGOX,'ED_LB_H'   ,'100');
   ED_LB_G   .TEXT := INI_LOAD_STR(FILEPATH_ARGOX,'ED_LB_G'   ,'20');
   ED_REF1   .TEXT := INI_LOAD_STR(FILEPATH_ARGOX,'ED_REF1'   ,'0');
   ED_REF2   .TEXT := INI_LOAD_STR(FILEPATH_ARGOX,'ED_REF2'   ,'0');
   ED_SPEED  .Value:= INI_LOAD_INT(FILEPATH_ARGOX,'ED_SPEED'   ,6);
   ED_DENSITY.Value:= INI_LOAD_INT(FILEPATH_ARGOX,'ED_DENSITY' ,8);
   ED_DELAY  .Value:= INI_LOAD_INT(FILEPATH_ARGOX,'ED_DELAY'   ,600);
   ED_NARROW .Value:= INI_LOAD_INT(FILEPATH_ARGOX,'ED_NARROW'  ,1);
   ED_WIDE   .Value:= INI_LOAD_INT(FILEPATH_ARGOX,'ED_WIDE'    ,3);
   ED_CODE.ItemIndex := INI_LOAD_INT(FILEPATH_ARGOX,'ED_CODE'  ,0);
   ED_DIR .ItemIndex := INI_LOAD_INT(FILEPATH_ARGOX,'ED_DIR'   ,0);
   ED_PORT.ItemIndex := INI_LOAD_INT(FILEPATH_ARGOX,'ED_PORT'  ,0);
   END;


end;



procedure TFRARGOX.FormActivate(Sender: TObject);
begin
PAGE_A.SHOW;
end;

procedure TFRARGOX.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   INI_SAVE_STR(FILEPATH_ARGOX,'ED_LB_W'   ,ED_LB_W   .TEXT );
   INI_SAVE_STR(FILEPATH_ARGOX,'ED_LB_H'   ,ED_LB_H   .TEXT );
   INI_SAVE_STR(FILEPATH_ARGOX,'ED_LB_G'   ,ED_LB_G   .TEXT );
   INI_SAVE_STR(FILEPATH_ARGOX,'ED_REF1'   ,ED_REF1   .TEXT );
   INI_SAVE_STR(FILEPATH_ARGOX,'ED_REF2'   ,ED_REF2   .TEXT );
   INI_SAVE_INT(FILEPATH_ARGOX,'ED_SPEED'  ,ED_SPEED  .Value);
   INI_SAVE_INT(FILEPATH_ARGOX,'ED_DENSITY',ED_DENSITY.Value);
   INI_SAVE_INT(FILEPATH_ARGOX,'ED_DELAY'  ,ED_DELAY  .Value);
   INI_SAVE_INT(FILEPATH_ARGOX,'ED_NARROW' ,ED_NARROW .Value);
   INI_SAVE_INT(FILEPATH_ARGOX,'ED_WIDE'   ,ED_WIDE   .Value);
   INI_SAVE_INT(FILEPATH_ARGOX,'ED_CODE' ,ED_CODE.ItemIndex);
   INI_SAVE_INT(FILEPATH_ARGOX,'ED_DIR'  ,ED_DIR .ItemIndex);
   INI_SAVE_INT(FILEPATH_ARGOX,'ED_PORT' ,ED_PORT.ItemIndex);
end;

procedure TFRARGOX.BTNQUTClick(Sender: TObject);
begin
   CLOSE;
end;

PROCEDURE TFRARGOX.OPEN_PORT;
BEGIN

IF ED_PORT.ItemIndex = 0 THEN OUT_PORT := 'COM1';
IF ED_PORT.ItemIndex = 1 THEN OUT_PORT := 'COM2';
IF ED_PORT.ItemIndex = 2 THEN OUT_PORT := 'COM3';
IF ED_PORT.ItemIndex = 3 THEN OUT_PORT := 'COM4';

Comm1.CommName := OUT_PORT;
Comm1.StartComm;
//comm1.WriteCommData ('CLS',3);
Comm1.StopComm;
END;

PROCEDURE TFRARGOX.PRINT_TITLE;
VAR S:STRING;
BEGIN

S := 'N'                                +#10#13+
     'S'+INTTOSTR(ED_SPEED.Value)       +#10#13+
     'D'+INTTOSTR(ED_DENSITY.Value)     +#10#13+
     'Q'+ED_LB_H.TEXT +','+ED_LB_G.TEXT +#10#13+
     'q'+ED_LB_W.TEXT                   +#10#13;

//   WRITELN(TF,'q200');
//   WRITELN(TF,'A110,0,0,3,1,1,n,"0008"');
//   WRITELN(TF,'A110,140,0,3,1,1,n,"0008"');
//   WRITELN(TF,'P1');



OPEN_PORT;
IF TEST_OPEN_FILE(OUT_PORT) = FALSE THEN
   SHOWMESSAGE('无法打开连接口');
IF TEST_OPEN_FILE(OUT_PORT) = TRUE THEN
   BEGIN
   AssignFile(TF,OUT_PORT);
   REWRITE(TF);   WRITELN(TF,S);   CloseFile(TF);
   MEMO.Lines.CLEAR;
   MEMO.Lines.Add(S);
   END;
END;

PROCEDURE TFRARGOX.PRINT_END(CNT:INTEGER);
BEGIN
IF TEST_OPEN_FILE(OUT_PORT) = TRUE THEN
   BEGIN
   AssignFile(TF,OUT_PORT);
   REWRITE(TF);  WRITELN(TF,'P'+INTTOSTR(CNT));  CloseFile(TF);
   MEMO.Lines.Add('P'+INTTOSTR(CNT));
   END;
DELAY(ED_DELAY.Value); //缓冲一下=========================
END;

PROCEDURE TFRARGOX.PRINT_BARCODE(X,Y,CODETYPE,HEIGHT:INTEGER;HUMAN,EXPRESSION:STRING);
VAR TP, S:STRING;
BEGIN

//设定条形码种类 ========================
case ED_CODE.ItemIndex of
   0 :  TP := '3';
   1 :  TP := '9';
   2 :  TP := '1';
   3 :  TP := 'E30';
   else TP := '3';
end;

S := 'B' +
     INTTOSTR(X+ STRTOINTDEF(ED_REF1.TEXT,0) ) + ','+
     INTTOSTR(Y+ STRTOINTDEF(ED_REF2.TEXT,0) ) + ','+
     INTTOSTR(ED_DIR.ItemIndex)                + ','+
     TP                 + ','+
     ED_NARROW.Text     + ','+
     ED_WIDE.Text       + ','+
     INTTOSTR(HEIGHT)   + ','+
     HUMAN              + ','+ '"'+EXPRESSION+'"';

IF TEST_OPEN_FILE(OUT_PORT) = TRUE THEN
   BEGIN
   AssignFile(TF,OUT_PORT);
   REWRITE(TF);   WRITELN(TF,S);   CloseFile(TF);
   MEMO.Lines.Add(S);
   END;

END;

PROCEDURE TFRARGOX.PRINT_TEXT(X,Y:INTEGER;FONT:STRING;HSCALE,VSCALE:INTEGER;HUMAN,EXPRESSION:STRING);
VAR S:STRING;
BEGIN

S := 'A' +
     INTTOSTR(X+ STRTOINTDEF(ED_REF1.TEXT,0) ) + ','+
     INTTOSTR(Y+ STRTOINTDEF(ED_REF2.TEXT,0) ) + ','+
     INTTOSTR(ED_DIR.ItemIndex)                + ','+
     FONT                 + ','+
     INTTOSTR(HSCALE)     + ','+
     INTTOSTR(VSCALE)     + ','+
     HUMAN                + ','+ '"'+EXPRESSION+'"';

IF TEST_OPEN_FILE(OUT_PORT) = TRUE THEN
   BEGIN
   AssignFile(TF,OUT_PORT);
   REWRITE(TF);   WRITELN(TF,S);   CloseFile(TF);
   MEMO.Lines.Add(S);
   END;

END;

PROCEDURE TFRARGOX.PRINT_TEXT2(X,Y:INTEGER;FONT:STRING;HSCALE,VSCALE:INTEGER;HUMAN,EXPRESSION:STRING;SUB_TEXT:INTEGER);
BEGIN
IF SUB_TEXT >= 0 THEN
   BEGIN
   PRINT_TEXT(X,Y,FONT,HSCALE,VSCALE,HUMAN,COPY(EXPRESSION,1,SUB_TEXT));
   PRINT_TEXT(X,Y+25,FONT,HSCALE,VSCALE,HUMAN,COPY(EXPRESSION,SUB_TEXT+1,LENGTH(EXPRESSION)-SUB_TEXT));
   END ELSE
   PRINT_TEXT(X,Y,FONT,HSCALE,VSCALE,HUMAN,EXPRESSION);

END;


PROCEDURE TFRARGOX.PRINT_BOX(X1,Y1,X2,Y2,THICKNESS:INTEGER);
BEGIN


IF TEST_OPEN_FILE(OUT_PORT) = TRUE THEN
   BEGIN
   AssignFile(TF,OUT_PORT);
   REWRITE(TF);
   WRITELN(TF,'BOX  '+INTTOSTR(X1)+','+INTTOSTR(Y1)+','
                     +INTTOSTR(X2)+','+INTTOSTR(Y2)+','
                     +INTTOSTR(THICKNESS)  );
   CloseFile(TF);

   MEMO.Lines.Add('BOX  '+INTTOSTR(X1)+','+INTTOSTR(Y1)+','
                     +INTTOSTR(X2)+','+INTTOSTR(Y2)+','
                     +INTTOSTR(THICKNESS)  );

   END;
END;






procedure TFRARGOX.P_TEST_TEXTClick(Sender: TObject);
begin
   PRINT_TITLE;
   PRINT_TEXT(0,0,'2',1,1,'N',P_TEXT.Text);
   PRINT_END(1);
end;

procedure TFRARGOX.P_TEST_BARCODEClick(Sender: TObject);
begin

   PRINT_TITLE;
   PRINT_BARCODE(0,0,ED_CODE.ItemIndex,50,'B',P_BARCODE.Text);
   PRINT_END(1);

end;






end.
