unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, Buttons, ToolWin, ComCtrls, StdCtrls, Mask, DBCtrls, Grids,
  Calendar;

type
  TFMMAIN = class(TForm)
    StatusBar: TStatusBar;
    MainMenu1: TMainMenu;
    GO1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure GO1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMMAIN: TFMMAIN;

implementation

uses SYSINI, MAINU, FM_UTL, UN_UTL, DB_UTL,
//     UNBMAN, UNBMAND, UNBMANF, UNBMANP
     RPPOS7F, RPPOS7P

     ;

{$R *.DFM}

procedure TFMMAIN.FormCreate(Sender: TObject);
begin
FMMAIN.CAPTION := '程序管理系统';


//资料设置   //系统默认值 ============================================
//日期值(ACCESS和SQL SEVER替换)
IF STRTOINTDEF(UNSETREAD('SYSSET','_DBKIND'),0)= 0 THEN
   BEGIN
   _DBKIND  := 'ACCESS';  // SERVER KIND (ACCESS和SQL SEVER替换)
   _DT      := '#';
   _SUMF[0] := 'EXPR1000';
   _SUMF[1] := 'EXPR1001';
   _SUMF[2] := 'EXPR1002';
   _SUMF[3] := 'EXPR1003';
   _SUMF[4] := 'EXPR1004';
   _SUMF[5] := 'EXPR1005';
   _SUMF[6] := 'EXPR1006';
   _SUMF[7] := 'EXPR1007';
   _SUMF[8] := 'EXPR1008';
   _SUMF[9] := 'EXPR1009';
   END ELSE BEGIN
   _DBKIND  := 'SQLSERVER';  // SERVER KIND (ACCESS和SQL SEVER替换)
   _DT      := '''';
   _SUMF[0] := 'COLUMN1';
   _SUMF[1] := 'COLUMN2';
   _SUMF[2] := 'COLUMN3';
   _SUMF[3] := 'COLUMN4';
   _SUMF[4] := 'COLUMN5';
   _SUMF[5] := 'COLUMN6';
   _SUMF[6] := 'COLUMN7';
   _SUMF[7] := 'COLUMN8';
   _SUMF[8] := 'COLUMN9';
   _SUMF[9] := 'COLUMN10';
   END;

end;



procedure TFMMAIN.GO1Click(Sender: TObject);
begin
 IF FormExists('RMPOS7P')=FALSE THEN Application.CreateForm(TRMPOS7P,  RMPOS7P  );
 IF FormExists('RMPOS7F')=FALSE THEN Application.CreateForm(TRMPOS7F,  RMPOS7F  );
 Form_MDI_POSITION(RMPOS7F,0,0);

end;

end.
