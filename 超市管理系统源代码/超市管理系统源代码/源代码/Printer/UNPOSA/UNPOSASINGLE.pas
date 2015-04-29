unit UNPOSASINGLE;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, DBCtrls, Grids, DBGrids, JLOOKUP, JEdit,inifiles,
  Menus;

type
  TFMPOSASINGLE = class(TForm)
    GRID: TStringGrid;
    MainMenu1: TMainMenu;
    ESC1: TMenuItem;
    N1: TMenuItem;
    ED_TXT: TEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ESC1Click(Sender: TObject);
    procedure GRIDKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    T : Tinifile;
    S_BGENO : STRING;
  public
    { Public declarations }
  end;

var
  FMPOSASINGLE: TFMPOSASINGLE;

implementation

USES SYSINI, UN_UTL, DB_UTL, UNPOSA;

{$R *.DFM}

procedure TFMPOSASINGLE.FormClose(Sender: TObject; var Action: TCloseAction);
var I: INTEGER;
BEGIN
  FOR I := 1 TO GRID.RowCount -1 DO
     BEGIN
     T.WriteString('HOTKEY',INTTOSTR(I),GRID.Cells[0,I]);
     T.WriteString('BGENO' ,INTTOSTR(I),GRID.Cells[1,I]);
     T.WriteString('BGNAM' ,INTTOSTR(I),GRID.Cells[2,I]);
     END;
end;

procedure TFMPOSASINGLE.FormCreate(Sender: TObject);
VAR I : INTEGER;
begin
  S_BGENO := '';

  //读文件=================================================
  GRID.Cells[0,0] := ' 快速码' ;
  GRID.Cells[1,0] := '  产 品 条 码';
  GRID.Cells[2,0] := '  产 品 名 称';
  
  IF FileExists(FILEPATH_POSASINGLE) = FALSE THEN FILE_CREATE(FILEPATH_POSASINGLE);
  
  T := Tinifile.Create(FILEPATH_POSASINGLE);
  
  //清除GRID
  FOR I := 1 TO GRID.RowCount -1 DO GRID.Cells[0,I] := '';
  
  //加载GRID
  FOR I := 1 TO GRID.RowCount -1 DO
      BEGIN
      GRID.Cells[0,I] := T.ReadString('HOTKEY',INTTOSTR(I),'');
      GRID.Cells[1,I] := T.ReadString('BGENO' ,INTTOSTR(I),'');
      GRID.Cells[2,I] := T.ReadString('BGNAM' ,INTTOSTR(I),'');
      END;
end;

procedure TFMPOSASINGLE.GRIDKeyPress(Sender: TObject; var Key: Char);
VAR S :STRING;
begin
  KEY := UPCASE(KEY);
  
  S_BGENO     := S_BGENO + KEY;
  ED_TXT.TEXT := S_BGENO;
  
  //单品查询
  IF (LENGTH(S_BGENO)=2)AND(COPY(S_BGENO,1,1)='.') THEN
     BEGIN
     GRID.Cells[0,GRID.Row] := S_BGENO;
     S_BGENO := '';
     EXIT;
     END;
  
  IF (COPY(S_BGENO,1,1)<>'.') THEN
  IF (ORD(KEY)=13) THEN
     BEGIN
     TRIM(S_BGENO);
     S_BGENO := COPY(S_BGENO, 1, LENGTH(S_BGENO)-1);
     S := DB_QUERY_FIND_VALUE('BGDS','BGENO',S_BGENO,'BGNAM');
     IF TRIM(S) <> '' THEN
        BEGIN
        GRID.Cells[1,GRID.Row] := S_BGENO;
        GRID.Cells[2,GRID.Row] := S;
        END ELSE BEGIN
        GRID.Cells[1,GRID.Row] := '';
        GRID.Cells[2,GRID.Row] := '';
        END;
  
     S_BGENO := '';
     EXIT;
     END;
  
  
  IF (ORD(KEY)=13) THEN S_BGENO := '';
end;

procedure TFMPOSASINGLE.FormActivate(Sender: TObject);
begin
  GRID.SetFocus;
end;

procedure TFMPOSASINGLE.FormDestroy(Sender: TObject);
var I: INTEGER;
BEGIN
  FOR I := 1 TO GRID.RowCount -1 DO
     BEGIN
     T.WriteString('HOTKEY',INTTOSTR(I),GRID.Cells[0,I]);
     T.WriteString('BGENO' ,INTTOSTR(I),GRID.Cells[1,I]);
     T.WriteString('BGNAM' ,INTTOSTR(I),GRID.Cells[2,I]);
     END;
end;

procedure TFMPOSASINGLE.ESC1Click(Sender: TObject);
begin
  CLOSE;
end;


end.
