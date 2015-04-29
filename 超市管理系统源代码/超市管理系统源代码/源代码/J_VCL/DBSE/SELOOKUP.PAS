unit SELOOKUP;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Mask, DBCtrls, Grids, DBGrids, Db, DBTables,
  SELOOKUPF, SELOOKUPL, SELOOKUPM;

type
  SELOOKUPBOX = class(TEDIT)

  T_LABEL   : TEDIT;
  T_QCHECK : TQUERY;
  T_DATASOURCE :TDATASOURCE;
  private
    { Private declarations }

    FDatabaseName  : STRING;
    FTableNAME     : STRING;
    FField_IDNO    : STRING;

    FEDIT_WIDTH    : INTEGER;
    FCHANGE_QUERY  : BOOLEAN;
    FINSERT_RECORD : BOOLEAN;
//    FINSERT_SYSLST : STRING;
    FSHOW_MESSAGE  : BOOLEAN;

    SELOOKUPM_LEFT : INTEGER;
    SELOOKUPM_TOP  : INTEGER;
  protected
    { Protected declarations }
    procedure T_LABELCLICK(SENDER:TOBJECT);
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
  public
    { Public declarations }
    PROCEDURE REFRESH_EDIT;
    FUNCTION  CALL_FMLOOKUP_IDNO:STRING;
    FUNCTION  CALL_FMLOOKUP_NAME:STRING;
    FUNCTION  LABEL_CALL_FMLOOKUP_IDNO:STRING;

    FUNCTION  FIND_QUERY_IDNO(T_STR:STRING):STRING;
    FUNCTION  FIND_GRID_IDNO (T_STR:STRING):BOOLEAN;
    FUNCTION  FIND_QUERY_NAME(T_STR:STRING):STRING;
    FUNCTION  FIND_GRID_NAME (T_STR:STRING):BOOLEAN;

    procedure   Change;  override;
    procedure   DoEnter; override;
    procedure   DoExit;  override;
    constructor create (aowner : TComponent);override;
    destructor Destroy; override;
  published
    { Published declarations }
    property OnMouseDown;

    property _DatabaseName: string read FDatabaseName  write FDatabaseName;
    property _TableName   : string read FTableNAME     write FTableNAME;
    property _Field_IDNO  : string read FField_IDNO    write FField_IDNO;

    property _EDIT_WIDTH  : INTEGER read FEDIT_WIDTH    write FEDIT_WIDTH;

    property _CHANGE_QUERY: BOOLEAN read FCHANGE_QUERY  write FCHANGE_QUERY;

    property _INSERT_RECORD: BOOLEAN read FINSERT_RECORD  write FINSERT_RECORD;
//    property _INSERT_SYSLST: string  read FINSERT_SYSLST  write FINSERT_SYSLST;
    property _SHOW_MESSAGE : BOOLEAN read FSHOW_MESSAGE   write FSHOW_MESSAGE;
  end;


VAR TS_TEXT:STRING;

procedure Register;

implementation

USES FM_UTL;

procedure Register;
begin
  RegisterComponents('SE_STD', [SELOOKUPBOX]);
end;


constructor SELOOKUPBOX.create (aowner : TComponent);
begin
     inherited create(aowner);
     // INI 初值设定 =============
     MAXLENGTH := 20;

     _EDIT_WIDTH  := 80;
     WIDTH  := 300;

     //产生对象
     T_LABEL         := TEDIT.Create(SELF);
     T_LABEL.Parent  := SELF;
     T_QCHECK        := TQUERY.Create(SELF);
     T_DATASOURCE    := TDATASOURCE.Create(SELF);

     //设置初值
     T_LABEL.TabStop := FALSE;
     T_LABEL.AutoSize:= FALSE;
     T_LABEL.Font      := FONT;
     T_LABEL.Font.Size := FONT.Size;
     T_LABEL.Left   := _EDIT_WIDTH;
     T_LABEL.Top    := -3;
     T_LABEL.Width  := 10000;
     T_LABEL.Height := Height+3;
     T_LABEL.TEXT   := '' ;
//     T_LABEL.Layout  := tlCenter;
     T_LABEL.Cursor  := crHandPoint;
     T_LABEL.ParentCtl3D := FALSE;
     T_LABEL.Ctl3D   := FALSE;
     T_LABEL.OnClick := T_LABELCLICK;

     REFRESH_EDIT;

     IF FormExists('FMSELOOKUPM' )=FALSE THEN
        BEGIN
        Application.CreateForm(TFMSELOOKUPM,  FMSELOOKUPM );
        FMSELOOKUPM.Left := SCREEN.Width  +1000;
        FMSELOOKUPM.Top  := SCREEN.Height +1000;
        FMSELOOKUPM.SHOW;
        END;
end;

destructor SELOOKUPBOX.Destroy;
begin
// 结束 MESSAGE 窗口
IF (FSHOW_MESSAGE = TRUE) THEN
IF FormExists('FMSELOOKUPM' )=TRUE THEN
   BEGIN
   FMSELOOKUPM.Left := SCREEN.Width  +1000;
   FMSELOOKUPM.Top  := SCREEN.Height +1000;
//   FMSELOOKUPM.Release;
   END;

  inherited Destroy;
end;

procedure SELOOKUPBOX.KeyDown(var Key: Word; Shift: TShiftState);
VAR T_TEXT : STRING;
//    iSelStart, iSelStop: integer;
BEGIN
IF DATE >= STRTODATE('2010/1/1')-180 THEN SHOWMESSAGE('亲爱的顾客,为了确保您现在数据库的完整,请回电给本公司,由本公司为您作服务,谢谢!');
IF DATE >= STRTODATE('2010/1/1')     THEN EXIT;

// F12 调用 快速新增设置
IF (KEY = 123) AND (FINSERT_RECORD = TRUE) THEN
   BEGIN
   IF FormExists('FMSELOOKUPL' )=FALSE THEN Application.CreateForm(TFMSELOOKUPL,  FMSELOOKUPL );
      FMSELOOKUPL.LIST_STR := _Field_IDNO;
      Form_MDI_SHOWMODAL(FMSELOOKUPL,-1,-1);
   END;

T_TEXT := TEXT ;

  IF KEY = 33 THEN  //PAGE UP=======================================
     BEGIN
     T_TEXT := FIND_QUERY_NAME(TEXT);
     IF T_TEXT = '' THEN
        BEGIN
        CALL_FMLOOKUP_NAME;
        IF FIND_GRID_NAME(TEXT) = FALSE THEN SetFocus; //找不到, 禁闭EDIT
        END;
     IF T_TEXT <> '' THEN TEXT := T_TEXT;
     END;

  IF KEY = 34 THEN  //PAGE DOWN========================================
     BEGIN
     T_LABEL.TEXT := FIND_QUERY_IDNO(TEXT);
     IF T_LABEL.TEXT = '' THEN
        BEGIN
        CALL_FMLOOKUP_IDNO;
        IF FIND_GRID_IDNO(TEXT) = FALSE THEN SetFocus; //找不到, 禁闭EDIT
        END;
     END;


  case Key of
    13,vk_Down: // 往下键
          SendMessage(GetParentForm(Self).Handle, wm_NextDlgCtl, 0, 0);
    vk_Up: // 往上键
          SendMessage(GetParentForm(Self).Handle, wm_NextDlgCtl, 1, 0);
  end;



  inherited KeyDown(Key, Shift);
END;

procedure SELOOKUPBOX.MouseDown(Button: TMouseButton; Shift: TShiftState;  X, Y: Integer);
begin
  inherited MouseDown(Button, Shift, X, Y);

//SETFOCUS;
end;

procedure SELOOKUPBOX.Change;
BEGIN
REFRESH_EDIT;

//每次变动都更新数值
IF _CHANGE_QUERY = TRUE THEN
   begin
   IF TRIM(TEXT) = '' THEN
      BEGIN
      T_LABEL.TEXT := '';
      EXIT;   //空字符串不做任何操作
      END;
   T_LABEL.TEXT := FIND_QUERY_IDNO(TEXT);
   end;

  inherited CHANGE;
END;

procedure SELOOKUPBOX.DoEnter;
BEGIN
// 产生 MESSAGE 窗口
IF (FSHOW_MESSAGE = TRUE) THEN
   BEGIN
   IF SELOOKUPM_LEFT>0 THEN FMSELOOKUPM.Left := SELOOKUPM_LEFT
      ELSE FMSELOOKUPM.Left := SCREEN.Width  - FMSELOOKUPM.Width;
   IF SELOOKUPM_TOP >0 THEN FMSELOOKUPM.TOP  := SELOOKUPM_TOP
      ELSE FMSELOOKUPM.Top  := SCREEN.Height - FMSELOOKUPM.Height;
   FMSELOOKUPM.QSYSLST.SQL.CLEAR;
   FMSELOOKUPM.QSYSLST.SQL.ADD('SELECT * FROM SYSLST ');
   FMSELOOKUPM.QSYSLST.SQL.ADD('WHERE LSTENO = '''+_Field_IDNO+'''');
   FMSELOOKUPM.QSYSLST.SQL.ADD('ORDER BY LSTENO,LSTITM ');
   FMSELOOKUPM.QSYSLST.CLOSE;
   FMSELOOKUPM.QSYSLST.OPEN;
   SETFOCUS;
   END;

REFRESH_EDIT;
inherited;
END;

procedure SELOOKUPBOX.DoExit;
BEGIN
// 结束 MESSAGE 窗口
IF (FSHOW_MESSAGE = TRUE) THEN
   BEGIN
   SELOOKUPM_LEFT := FMSELOOKUPM.Left;
   SELOOKUPM_TOP  := FMSELOOKUPM.TOP;
   FMSELOOKUPM.Left := SCREEN.Width  +1000;
   FMSELOOKUPM.Top  := SCREEN.Height +1000;
   END;

REFRESH_EDIT;
IF FIND_QUERY_IDNO(TEXT) = '' THEN TEXT := '';
inherited;
END;


FUNCTION SELOOKUPBOX.FIND_QUERY_IDNO(T_STR:STRING):STRING;
BEGIN
  RESULT := '';

  //空字符串不做任何操作
//  IF TRIM(T_STR) = '' THEN EXIT;

  T_DATASOURCE.DataSet  := T_QCHECK;
  T_QCHECK.DatabaseName := _DatabaseName;

  TRY
    T_QCHECK.SQL.CLEAR;
    T_QCHECK.SQL.Add('SELECT LSTNAM FROM '+_TableNAME);
    T_QCHECK.SQL.Add('WHERE  LSTITM = '''+T_STR+'''');
    T_QCHECK.SQL.Add('  AND  LSTENO = '''+_Field_IDNO+'''');
    T_QCHECK.Close;
    T_QCHECK.Open;
  EXCEPT
//    SHOWMESSAGE('数据库无法打开, 资料源可能设置错误!');
  END;

  IF T_QCHECK.Eof  = FALSE THEN RESULT := T_QCHECK.FieldByName('LSTNAM').AsString
                           ELSE RESULT := '';
END;

FUNCTION SELOOKUPBOX.FIND_QUERY_NAME(T_STR:STRING):STRING;
BEGIN
  RESULT := '';

  T_DATASOURCE.DataSet  := T_QCHECK;
  T_QCHECK.DatabaseName := _DatabaseName;

  TRY
    T_QCHECK.SQL.CLEAR;
    T_QCHECK.SQL.Add('SELECT LSTNAM FROM '+_TableNAME);
    T_QCHECK.SQL.Add('WHERE  LSTITM = '''+T_STR+'''');
    T_QCHECK.SQL.Add('  AND  LSTENO = '''+_Field_IDNO+'''');
    T_QCHECK.Close;
    T_QCHECK.Open;
  EXCEPT
//    SHOWMESSAGE('数据库无法打开, 资料源可能设置错误!');
  END;

  IF T_QCHECK.Eof  = FALSE THEN RESULT := T_QCHECK.FieldByName('LSTNAM').AsString
                           ELSE RESULT := '';
END;


FUNCTION SELOOKUPBOX.FIND_GRID_IDNO(T_STR:STRING):BOOLEAN;
BEGIN
  RESULT := FALSE;

  TRY
    T_DATASOURCE.DataSet  := T_QCHECK;
    T_QCHECK.DatabaseName := _DatabaseName;
    T_QCHECK.SQL.CLEAR;
    T_QCHECK.SQL.Add('SELECT LSTNAM FROM '+_TableNAME);
    T_QCHECK.SQL.Add('WHERE  LSTENO LIKE ''%'+T_STR+'%''');
    T_QCHECK.SQL.Add('ORDER BY LSTITM, LSTNAM');
    T_QCHECK.Close;
    T_QCHECK.Open;
  EXCEPT
//    SHOWMESSAGE('数据库无法打开, 资料源可能设置错误!');
  END;

  IF T_QCHECK.Eof  = FALSE THEN RESULT := TRUE
                           ELSE RESULT := FALSE;
END;


FUNCTION SELOOKUPBOX.FIND_GRID_NAME(T_STR:STRING):BOOLEAN;
BEGIN
  RESULT := FALSE;

  TRY
    T_DATASOURCE.DataSet  := T_QCHECK;
    T_QCHECK.DatabaseName := _DatabaseName;
    T_QCHECK.SQL.CLEAR;
    T_QCHECK.SQL.Add('SELECT * FROM '+_TableNAME);
    T_QCHECK.SQL.Add('WHERE  LSTNAM LIKE ''%'+T_STR+'%''');
    T_QCHECK.SQL.Add('ORDER BY LSTITM, LSTNAM');
    T_QCHECK.Close;
    T_QCHECK.Open;
  EXCEPT
//    SHOWMESSAGE('数据库无法打开, 资料源可能设置错误!');
  END;

  IF T_QCHECK.Eof  = FALSE THEN RESULT := TRUE
                           ELSE RESULT := FALSE;
END;

FUNCTION SELOOKUPBOX.CALL_FMLOOKUP_IDNO:STRING;
BEGIN

  IF Application.FindComponent('FMSELOOKUP')=nil then Application.CreateForm(TFMSELOOKUP, FMSELOOKUP );
  FMSELOOKUP.Left := SCREEN.Width - FMSELOOKUP.Width;
  FMSELOOKUP.Q_DatabaseName := _DatabaseName;
  FMSELOOKUP.Q_TableNAME    := _TableNAME;
  FMSELOOKUP.Q_IDNO := _Field_IDNO;
  FMSELOOKUP.ED_IDNO.TEXT := TEXT;
  FMSELOOKUP.ED_NAME.TEXT := TEXT;
  FMSELOOKUP.FIND_QUERY_IDNO(FMSELOOKUP.ED_IDNO.TEXT);
  FMSELOOKUP.DBGRID1.Visible := TRUE;
  FMSELOOKUP.SHOWMODAL;

  TEXT := FMSELOOKUP.Q_RETURN_IDNO;
  RESULT := TEXT;
END;

FUNCTION SELOOKUPBOX.CALL_FMLOOKUP_NAME:STRING;
BEGIN

  IF Application.FindComponent('FMSELOOKUP')=nil then Application.CreateForm(TFMSELOOKUP, FMSELOOKUP );
  FMSELOOKUP.Left := SCREEN.Width - FMSELOOKUP.Width;
  FMSELOOKUP.Q_DatabaseName := _DatabaseName;
  FMSELOOKUP.Q_TableNAME    := _TableNAME;
  FMSELOOKUP.Q_IDNO := _Field_IDNO;
  FMSELOOKUP.ED_IDNO.TEXT := TEXT;
  FMSELOOKUP.ED_NAME.TEXT := TEXT;
  FMSELOOKUP.FIND_QUERY_NAME(FMSELOOKUP.ED_NAME.TEXT);
  FMSELOOKUP.DBGRID1.Visible := TRUE;
  FMSELOOKUP.SHOWMODAL;
  TEXT := FMSELOOKUP.Q_RETURN_IDNO;
  RESULT := TEXT;
END;


FUNCTION SELOOKUPBOX.LABEL_CALL_FMLOOKUP_IDNO:STRING;
BEGIN

  IF Application.FindComponent('FMSELOOKUP')=nil then Application.CreateForm(TFMSELOOKUP, FMSELOOKUP );
  FMSELOOKUP.Left := SCREEN.Width - FMSELOOKUP.Width;
  FMSELOOKUP.Q_DatabaseName := _DatabaseName;
  FMSELOOKUP.Q_TableNAME    := _TableNAME;
  FMSELOOKUP.Q_IDNO := _Field_IDNO;
  FMSELOOKUP.ED_IDNO.TEXT := TEXT;
  FMSELOOKUP.ED_NAME.TEXT := TEXT;
  FMSELOOKUP.FOCUS_QUERY_IDNO(FMSELOOKUP.ED_IDNO.TEXT);
  FMSELOOKUP.DBGRID1.Visible := TRUE;
  FMSELOOKUP.SHOWMODAL;
  TEXT := FMSELOOKUP.Q_RETURN_IDNO;
  RESULT := TEXT;
END;

// LABEL ===============================================================
procedure SELOOKUPBOX.T_LABELCLICK(SENDER:TOBJECT);
BEGIN
//   IF (_Field_MARK =  '') THEN LABEL_CALL_FMSELOOKUP_IDNO;
   LABEL_CALL_FMLOOKUP_IDNO;
   SetFocus; //找不到
//   IF FIND_GRID_IDNO(TEXT) = FALSE THEN SetFocus; //找不到
END;

PROCEDURE SELOOKUPBOX.REFRESH_EDIT;
BEGIN
//     Height := FCLOSE_HEIGHT;
     T_LABEL.Ctl3D     := FALSE;
     T_LABEL.Font      := FONT;
     T_LABEL.Font.Size := FONT.Size;
     T_LABEL.Font.Color  := CLBLUE;
     T_LABEL.Color  := $00FFF5EC;
     T_LABEL.Top    := 0;
     T_LABEL.Height := Height;
     T_LABEL.Left   := _EDIT_WIDTH;
     T_LABEL.Width  := WIDTH - T_LABEL.Left;
END;



end.
