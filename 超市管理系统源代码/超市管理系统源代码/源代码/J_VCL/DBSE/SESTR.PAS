unit SESTR;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids;

type
  TFMSESTR = class(TForm)
    GD_KIND: TStringGrid;
    LOAD: TButton;
    Edit1: TEdit;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure LOADClick(Sender: TObject);
    procedure GD_KINDKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GD_KINDDblClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    STRFILENAME:STRING;
    PROCEDURE QUERY_STR(STR:STRING);
  public
    { Public declarations }
    RETURN_STR :STRING;
  end;

var
  FMSESTR: TFMSESTR;

implementation

USES inifiles, UN_UTL;

{$R *.DFM}

PROCEDURE TFMSESTR.QUERY_STR(STR:STRING);
VAR I :INTEGER;
BEGIN
FOR I := 1 TO GD_KIND.RowCount -1 DO
    BEGIN
    IF POS(STR,GD_KIND.Cells[0,I]) > 0 THEN
       BEGIN
       GD_KIND.Row := I;
       BREAK;
       END;
    END;


END;

procedure TFMSESTR.FormCreate(Sender: TObject);
VAR T : Tinifile;  I,J,  N , ID : INTEGER;    S : TOBJECT;  //暂存对象
begin

STRFILENAME := ExtractFilePath(Application.EXEName)+'SESTR.INI';

//读文件=================================================
GD_KIND.Cells[0,0] := '类别' ;
GD_KIND.Cells[1,0] := '类别名称';

IF FileExists(STRFILENAME) = FALSE THEN FILE_CREATE(STRFILENAME);

T := Tinifile.Create(STRFILENAME);

//清除GRID
FOR I := 1 TO GD_KIND.RowCount -1 DO GD_KIND.Cells[0,I] := '';

//加载GRID
FOR I := 1 TO GD_KIND.RowCount -1 DO
    BEGIN

    GD_KIND.Cells[0,I] := T.ReadString('STRINGS',INTTOSTR(I),'');
    END;

end;

procedure TFMSESTR.FormActivate(Sender: TObject);
begin
FMSESTR.Left := SCREEN.Width   - FMSESTR.Width;
FMSESTR.TOP  := (SCREEN.HEIGHT - FMSESTR.HEIGHT) DIV 2;
end;


procedure TFMSESTR.FormClose(Sender: TObject; var Action: TCloseAction);
var T : Tinifile;  I,J,  N , ID : INTEGER;    S : TOBJECT;  //暂存对象
BEGIN

//DELETEFILE(STRFILENAME);
T := Tinifile.Create(STRFILENAME);
T.EraseSection('STRINGS');
FOR I := 1 TO GD_KIND.RowCount -1 DO
    BEGIN
//    IF TRIM(GD_KIND.Cells[0,I]) = '' THEN BREAK;
    T.WriteString('STRINGS',INTTOSTR(I),GD_KIND.Cells[0,I]);
    END;

FMSESTR.Release;
end;

procedure TFMSESTR.LOADClick(Sender: TObject);
begin
QUERY_STR(EDIT1.TEXT);
end;

procedure TFMSESTR.GD_KINDKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
IF KEY = 27 THEN
   BEGIN
   RETURN_STR := '';
   CLOSE;
   END;
IF KEY = 13 THEN
   BEGIN
   RETURN_STR := GD_KIND.Cells[0,GD_KIND.Row];
   CLOSE;
   END;
end;

procedure TFMSESTR.GD_KINDDblClick(Sender: TObject);
begin
   RETURN_STR := GD_KIND.Cells[0,GD_KIND.Row];
   CLOSE;
end;


procedure TFMSESTR.Button1Click(Sender: TObject);
begin
   CLOSE;

end;

end.


