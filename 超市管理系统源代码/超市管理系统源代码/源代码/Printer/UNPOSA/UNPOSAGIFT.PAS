unit UNPOSAGIFT;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, DBCtrls, Grids, DBGrids, JLOOKUP, SELOOKUP, JEdit,
  Menus;

type
  TFMPOSAGIFT = class(TForm)
    Label1: TLabel;
    BTNQUT: TBitBtn;
    Label3: TLabel;
    ED_PGCNO: TJEdit;
    ED_PGCDT: TJEdit;
    ED_PGCKD: TJEdit;
    ED_PGCNA: TJEdit;
    Label2: TLabel;
    Label4: TLabel;
    MainMenu1: TMainMenu;
    ESC: TMenuItem;
    GIFT_GRID: TStringGrid;
    F12: TMenuItem;
    Label5: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BTNQUTClick(Sender: TObject);
    procedure ED_PGCNOKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure GIFT_GRIDKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure F12Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMPOSAGIFT: TFMPOSAGIFT;

implementation

USES SYSINI, UN_UTL, FM_UTL, DB_UTL, UNPOSA, UNPOSAD, MAIN, URDSP;

{$R *.DFM}

procedure TFMPOSAGIFT.FormCreate(Sender: TObject);
begin
//
end;

procedure TFMPOSAGIFT.FormShow(Sender: TObject);
begin
  GIFT_GRID.Cells[0,0] := ' 编  号';
  GIFT_GRID.Cells[1,0] := ' 到 期 日';
  GIFT_GRID.Cells[2,0] := ' 类  别';
  GIFT_GRID.Cells[3,0] := ' 金     额';
  
  //礼券资料======================================
  ED_PGCNO.TEXT  := _TB_GIFT_PGCNO;  //礼券号
  ED_PGCDT.TEXT  := _TB_GIFT_PGCDT;  //礼券到期日
  ED_PGCNA.TEXT  := FLOATTOSTR(_TB_GIFT_PGCNA);  //礼券金额
  ED_PGCKD.TEXT  := _TB_GIFT_PGCKD;  //礼券类别
  
  //带入 INPUT 的值
  ED_PGCNA.TEXT := INTTOSTR(STRTOINTDEF(FMPOSA.ED_INPUT.TEXT,0));
  
  ED_PGCNO.SetFocus;
end;

procedure TFMPOSAGIFT.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //礼券资料======================================
  _TB_GIFT_PGCNO  := ED_PGCNO.TEXT;  //礼券号
  _TB_GIFT_PGCDT  := ED_PGCDT.TEXT;  //礼券到期日
  _TB_GIFT_PGCNA  := STRTOFLOATDEF(ED_PGCNA.TEXT,0);  //礼券金额
  _TB_GIFT_PGCKD  := ED_PGCKD.TEXT;  //礼券类别
end;

procedure TFMPOSAGIFT.FormCloseQuery(Sender: TObject;  var CanClose: Boolean);
begin
  IF (STRTOFLOATDEF(ED_PGCNA.TEXT,-999) < 0) THEN  //礼券金额
     BEGIN
     CANCLOSE := FALSE;
     ED_PGCNA.SetFocus;
     ED_PGCNA.SelectAll;
     END;
end;

procedure TFMPOSAGIFT.ED_PGCNOKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
VAR I , J:INTEGER;
begin
  IF (KEY = 27) THEN BEGIN BTNQUT.Click; EXIT;  END;
  IF (KEY = 13) AND (SENDER = ED_PGCNO) THEN ED_PGCDT.SetFocus;
  IF (KEY = 13) AND (SENDER = ED_PGCDT) THEN ED_PGCKD.SetFocus;
  IF (KEY = 13) AND (SENDER = ED_PGCKD) THEN ED_PGCNA.SetFocus;
  IF (KEY = 13) AND (SENDER = ED_PGCNA) THEN
     BEGIN
  
     IF STRTOFLOATDEF(ED_PGCNA.TEXT,0) <= 0 THEN EXIT;
  
     //算笔数
     FOR I := 1 TO 200 DO
       BEGIN
       J := I;
       IF TRIM(GIFT_GRID.Cells[3,I]) =  '' THEN BREAK;
       END;
  
     FOR I := (J+1) DOWNTO 1 DO GIFT_GRID.Rows[I].Text := GIFT_GRID.Rows[I-1].Text;
  
     GIFT_GRID.Cells[0,1] := ED_PGCNO.TEXT;
     GIFT_GRID.Cells[1,1] := ED_PGCDT.TEXT;
     GIFT_GRID.Cells[2,1] := ED_PGCKD.TEXT;
     GIFT_GRID.Cells[3,1] := ED_PGCNA.TEXT;
     ED_PGCNO.SetFocus;
     END;
end;

procedure TFMPOSAGIFT.GIFT_GRIDKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  IF (KEY = 27) THEN BEGIN BTNQUT.Click; EXIT;  END;
  IF (KEY = 13) THEN BEGIN ED_PGCNO.SetFocus;   END;
  IF (KEY = 38) THEN //向上移
     BEGIN
     IF (GIFT_GRID.Row<=1)OR(GIFT_GRID.Row>199)THEN ED_PGCNO.SetFocus;
     IF (GIFT_GRID.Row>1)THEN
     GIFT_GRID.Row := GIFT_GRID.Row -1;
     EXIT;
     END;
end;

procedure TFMPOSAGIFT.BTNQUTClick(Sender: TObject);
VAR TOTAL, CNT, I : INTEGER;
begin
  TOTAL := 0;   //礼券总金额
  CNT   := 0;   //礼券总金额
  FOR I := 1 TO 19 DO
     BEGIN
     IF STRTOINTDEF(FMPOSAGIFT.GIFT_GRID.Cells[3,I], -1) >= 0 THEN
        BEGIN
        INC(CNT);
        TOTAL := TOTAL + STRTOINTDEF(FMPOSAGIFT.GIFT_GRID.Cells[3,I],0);
        END;
     END;

  // 客显==================================================================
  DSP_TITLE;
  DSP_TEXT1('Gift Record is ' +REPLICATE(' ',5 -LENGTH( INTTOSTR(CNT  )) ) + INTTOSTR(CNT  ) ,'R');
  DSP_TEXT2('Total Cost is  ' +REPLICATE(' ',5 -LENGTH( INTTOSTR(TOTAL)) ) + INTTOSTR(TOTAL) ,'R');
  // 客显==================================================================

  CLOSE;
end;

procedure TFMPOSAGIFT.F12Click(Sender: TObject);
VAR I, TARGET, DEL_REC :INTEGER;
BEGIN
  TARGET  := GIFT_GRID.Row;

  //条件不符 跳出
  IF (TARGET <= 0) OR (TRIM(GIFT_GRID.Cells[3,1])= '') THEN
     BEGIN
     EXIT;
     END;
  
  FOR I := TARGET TO 200 DO
      BEGIN
      GIFT_GRID.Rows[I].Text := GIFT_GRID.Rows[I+1].Text;
      IF TRIM(GIFT_GRID.Cells[3,I+1]) =  '' THEN BREAK;
      END;
end;

end.
