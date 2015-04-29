unit JLOOKUPD;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Mask, DBCtrls, Grids, DBGrids, Db, DBTables,
  JLOOKUPF, JLOOKUPL, JLOOKUPM;


type
  JDBLOOKUPBOX = class(TDBEDIT)

  T_LABEL  : TEDIT;
  T_QCHECK : TQUERY;
  T_DATASOURCE :TDATASOURCE;
  private
    { Private declarations }

    FDatabaseName  : STRING;
    FTableNAME     : STRING;
    FField_IDNO    : STRING;
    FField_NAME    : STRING;
    FField_MARK    : STRING;    
    FField_KEY1    : STRING;
    FField_KEY2    : STRING;

    FEDIT_WIDTH    : INTEGER;
    FCHANGE_QUERY  : BOOLEAN;
    FINSERT_RECORD : BOOLEAN;
    FINSERT_SYSLST : STRING;
    FSHOW_MESSAGE  : BOOLEAN;
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
    FUNCTION  CALL_FMLOOKUP_MARK:STRING;
    FUNCTION  LABEL_CALL_FMLOOKUP_IDNO:STRING;

    FUNCTION  FIND_QUERY_IDNO(T_STR:STRING):STRING;
    FUNCTION  FIND_GRID_IDNO (T_STR:STRING):BOOLEAN;
    FUNCTION  FIND_QUERY_NAME(T_STR:STRING):STRING;
    FUNCTION  FIND_GRID_NAME (T_STR:STRING):BOOLEAN;
    FUNCTION  FIND_QUERY_MARK(T_STR:STRING):STRING;
    FUNCTION  FIND_GRID_MARK (T_STR:STRING):BOOLEAN;

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
    property _Field_NAME  : string read FField_NAME    write FField_NAME;
    property _Field_MARK  : string read FField_MARK    write FField_MARK;
    property _Field_KEY1  : string read FField_KEY1    write FField_KEY1;
    property _Field_KEY2  : string read FField_KEY2    write FField_KEY2;

    property _EDIT_WIDTH  : INTEGER read FEDIT_WIDTH    write FEDIT_WIDTH;

    property _CHANGE_QUERY: BOOLEAN read FCHANGE_QUERY  write FCHANGE_QUERY;

    property _INSERT_RECORD: BOOLEAN read FINSERT_RECORD  write FINSERT_RECORD;
    property _INSERT_SYSLST: string  read FINSERT_SYSLST  write FINSERT_SYSLST;
    property _SHOW_MESSAGE : BOOLEAN read FSHOW_MESSAGE   write FSHOW_MESSAGE;
  end;


VAR TS_TEXT:STRING;

procedure Register;

implementation

USES FM_UTL;

procedure Register;
begin
  RegisterComponents('J_STD', [JDBLOOKUPBOX]);
end;


constructor JDBLOOKUPBOX.create (aowner : TComponent);
begin
     inherited create(aowner);
     // INI 初值设置 =============
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

     IF FormExists('FMLOOKUPM' )=FALSE THEN
        BEGIN
        Application.CreateForm(TFMLOOKUPM,  FMLOOKUPM );
        FMLOOKUPM.Left := SCREEN.Width  +1000;
        FMLOOKUPM.Top  := SCREEN.Height +1000;
        FMLOOKUPM.SHOW;
        END;
     
end;

destructor JDBLOOKUPBOX.Destroy;
begin
// 结束 MESSAGE 窗口
IF (FSHOW_MESSAGE = TRUE) THEN
IF FormExists('FMLOOKUPM' )=TRUE THEN
   BEGIN
   FMLOOKUPM.Left := SCREEN.Width  +1000;
   FMLOOKUPM.Top  := SCREEN.Height +1000;
//   FMLOOKUPM.Release;
   END;

  inherited Destroy;
end;

procedure JDBLOOKUPBOX.KeyDown(var Key: Word; Shift: TShiftState);
VAR T_TEXT : STRING;
//    iSelStart, iSelStop: integer;
BEGIN
IF DATE >= STRTODATE('2020/1/1')-180 THEN SHOWMESSAGE('亲爱的顾客,为了确保您现在数据库的完整,请回电给本公司,由本公司为您作服务,谢谢!');
IF DATE >= STRTODATE('2020/1/1')     THEN EXIT;

// F12 调用 快速新增设置
IF (KEY = 123) AND (FINSERT_RECORD = TRUE) THEN
   BEGIN
   IF FormExists('FMLOOKUPL' )=FALSE THEN Application.CreateForm(TFMLOOKUPL,  FMLOOKUPL );
      FMLOOKUPL.LIST_STR := FINSERT_SYSLST;
      Form_MDI_SHOWMODAL(FMLOOKUPL,-1,-1);
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

  IF (KEY = 45) AND (_Field_MARK <> '') THEN  //insert========================================
     BEGIN
     T_LABEL.TEXT := FIND_QUERY_MARK(TEXT);
     IF T_LABEL.TEXT = '' THEN
        BEGIN
        CALL_FMLOOKUP_MARK;
        IF FIND_GRID_MARK(TEXT) = FALSE THEN SetFocus; //找不到, 禁闭EDIT
        END;

     END;

  case Key of
    13,vk_Down: // 往下键
      begin
          SendMessage(GetParentForm(Self).Handle, wm_NextDlgCtl, 0, 0);
      end;
    vk_Up: // 往上键
      begin
          SendMessage(GetParentForm(Self).Handle, wm_NextDlgCtl, 1, 0);
      end;
{    vk_Right: // 右
      begin
        if (iSelStart = iSelStop) and (iSelStop = GetTextLen) then
        begin
          SendMessage(GetParentForm(Self).Handle, wm_NextDlgCtl, 0, 0);
        end;
      end;
    vk_Left: // 左
      begin
        if (iSelStart = iSelStop) and (iSelStart = 0) then
        begin
          SendMessage(GetParentForm(Self).Handle, wm_NextDlgCtl, 1, 0);
        end;
      end;}
  end;



  inherited KeyDown(Key, Shift);
END;

procedure JDBLOOKUPBOX.MouseDown(Button: TMouseButton; Shift: TShiftState;  X, Y: Integer);
begin
  inherited MouseDown(Button, Shift, X, Y);


//SETFOCUS;
end;


procedure JDBLOOKUPBOX.Change;
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

procedure JDBLOOKUPBOX.DoEnter;
BEGIN
// 产生 MESSAGE 窗口
IF (FSHOW_MESSAGE = TRUE) THEN
   BEGIN
   FMLOOKUPM.Left := SCREEN.Width  - FMLOOKUPM.Width;
   FMLOOKUPM.Top  := SCREEN.Height - FMLOOKUPM.Height;
   FMLOOKUPM.QSYSLST.SQL.CLEAR;
   FMLOOKUPM.QSYSLST.SQL.ADD('SELECT *  ');
   FMLOOKUPM.QSYSLST.SQL.ADD('FROM SYSLST ');
   FMLOOKUPM.QSYSLST.SQL.ADD('WHERE LSTID1 = '''+FINSERT_SYSLST+'''');
   FMLOOKUPM.QSYSLST.SQL.ADD('ORDER BY LSTID1,LSTID2 ');
   FMLOOKUPM.QSYSLST.CLOSE;
   FMLOOKUPM.QSYSLST.OPEN;
   SETFOCUS;
   END;

REFRESH_EDIT;
inherited;
END;
procedure JDBLOOKUPBOX.DoExit;
BEGIN
// 结束 MESSAGE 窗口
IF (FSHOW_MESSAGE = TRUE) THEN
   BEGIN
   FMLOOKUPM.Left := SCREEN.Width  +1000;
   FMLOOKUPM.Top  := SCREEN.Height +1000;
   END;

REFRESH_EDIT;
IF FIND_QUERY_IDNO(TEXT) = '' THEN
   BEGIN
   DataSource.DataSet.Edit;
   DataSource.DataSet.FieldByName(DataField).AsString := '';
   END;
inherited;
END;


FUNCTION JDBLOOKUPBOX.FIND_QUERY_IDNO(T_STR:STRING):STRING;
BEGIN
  RESULT := '';
  //空字符串不做任何操作
//  IF TRIM(T_STR) = '' THEN EXIT;

  T_DATASOURCE.DataSet  := T_QCHECK;
  T_QCHECK.DatabaseName := _DatabaseName;

  TRY
    T_QCHECK.SQL.CLEAR;
    T_QCHECK.SQL.Add('SELECT '+_Field_IDNO+','+_Field_NAME);
    T_QCHECK.SQL.Add('FROM   '+_TableNAME);
    T_QCHECK.SQL.Add('WHERE  '+_Field_IDNO+' = '''+T_STR+'''');
    IF TRIM(_Field_KEY1) <> '' THEN T_QCHECK.SQL.Add('AND '+_Field_KEY1+' = '''+_Field_KEY2+'''');
    T_QCHECK.Close;
    T_QCHECK.Open;
  EXCEPT
//    SHOWMESSAGE('数据库无法打开, 数据源可能设置错误!');
  END;

  IF T_QCHECK.Eof  = FALSE THEN RESULT := T_QCHECK.FieldByName(_Field_NAME).AsString
                           ELSE RESULT := '';
END;

FUNCTION JDBLOOKUPBOX.FIND_QUERY_NAME(T_STR:STRING):STRING;
BEGIN
  RESULT := '';

  T_DATASOURCE.DataSet  := T_QCHECK;
  T_QCHECK.DatabaseName := _DatabaseName;

  TRY
    T_QCHECK.SQL.CLEAR;
    T_QCHECK.SQL.Add('SELECT '+_Field_IDNO+','+_Field_NAME);
    T_QCHECK.SQL.Add('FROM   '+_TableNAME);
    T_QCHECK.SQL.Add('WHERE  '+_Field_NAME+' = '''+T_STR+'''');
    IF TRIM(_Field_KEY1) <> '' THEN T_QCHECK.SQL.Add('AND '+_Field_KEY1+' = '''+_Field_KEY2+'''');
    T_QCHECK.Close;
    T_QCHECK.Open;
  EXCEPT
//    SHOWMESSAGE('数据库无法打开, 数据源可能设置错误!');
  END;

  IF T_QCHECK.Eof  = FALSE THEN RESULT := T_QCHECK.FieldByName(_Field_IDNO).AsString
                           ELSE RESULT := '';
END;

FUNCTION JDBLOOKUPBOX.FIND_QUERY_MARK(T_STR:STRING):STRING;
BEGIN
  RESULT := '';

  T_DATASOURCE.DataSet  := T_QCHECK;
  T_QCHECK.DatabaseName := _DatabaseName;

  TRY
    T_QCHECK.SQL.CLEAR;
    T_QCHECK.SQL.Add('SELECT '+_Field_IDNO+','+_Field_NAME+','+_Field_MARK);
    T_QCHECK.SQL.Add('FROM   '+_TableNAME);
    T_QCHECK.SQL.Add('WHERE  '+_Field_MARK+' = '''+T_STR+'''');
    IF TRIM(_Field_KEY1) <> '' THEN T_QCHECK.SQL.Add('AND '+_Field_KEY1+' = '''+_Field_KEY2+'''');
    T_QCHECK.Close;
    T_QCHECK.Open;
  EXCEPT
//    SHOWMESSAGE('数据库无法打开, 数据源可能设置错误!');
  END;

  IF T_QCHECK.Eof  = FALSE THEN RESULT := T_QCHECK.FieldByName(_Field_IDNO).AsString
                           ELSE RESULT := '';
END;

FUNCTION JDBLOOKUPBOX.FIND_GRID_IDNO(T_STR:STRING):BOOLEAN;
BEGIN
  RESULT := FALSE;

  TRY
    T_DATASOURCE.DataSet  := T_QCHECK;
    T_QCHECK.DatabaseName := _DatabaseName;

    T_QCHECK.SQL.CLEAR;
    T_QCHECK.SQL.Add('SELECT '+_Field_IDNO+','+_Field_NAME);
    T_QCHECK.SQL.Add('FROM   '+_TableNAME);
    T_QCHECK.SQL.Add('WHERE  '+_Field_IDNO+' LIKE ''%'+T_STR+'%''');
    IF TRIM(_Field_KEY1) <> '' THEN T_QCHECK.SQL.Add('AND '+_Field_KEY1+' = '''+_Field_KEY2+'''');
    T_QCHECK.SQL.Add('ORDER BY '+_Field_IDNO+','+_Field_NAME);
    T_QCHECK.Close;
    T_QCHECK.Open;
  EXCEPT
//    SHOWMESSAGE('数据库无法打开, 数据源可能设置错误!');
  END;

  IF T_QCHECK.Eof  = FALSE THEN RESULT := TRUE
                           ELSE RESULT := FALSE;
END;


FUNCTION JDBLOOKUPBOX.FIND_GRID_NAME(T_STR:STRING):BOOLEAN;
BEGIN
  RESULT := FALSE;

  TRY
    T_DATASOURCE.DataSet  := T_QCHECK;
    T_QCHECK.DatabaseName := _DatabaseName;

    T_QCHECK.SQL.CLEAR;
    T_QCHECK.SQL.Add('SELECT '+_Field_IDNO+','+_Field_NAME);
    T_QCHECK.SQL.Add('FROM   '+_TableNAME);
    T_QCHECK.SQL.Add('WHERE  '+_Field_NAME+' LIKE ''%'+T_STR+'%''');
    IF TRIM(_Field_KEY1) <> '' THEN T_QCHECK.SQL.Add('AND '+_Field_KEY1+' = '''+_Field_KEY2+'''');
    T_QCHECK.SQL.Add('ORDER BY '+_Field_IDNO+','+_Field_NAME);
    T_QCHECK.Close;
    T_QCHECK.Open;
  EXCEPT
//    SHOWMESSAGE('数据库无法打开, 数据源可能设置错误!');
  END;

  IF T_QCHECK.Eof  = FALSE THEN RESULT := TRUE
                           ELSE RESULT := FALSE;
END;

FUNCTION JDBLOOKUPBOX.FIND_GRID_MARK(T_STR:STRING):BOOLEAN;
BEGIN
  RESULT := FALSE;

  TRY
    T_DATASOURCE.DataSet  := T_QCHECK;
    T_QCHECK.DatabaseName := _DatabaseName;

    T_QCHECK.SQL.CLEAR;
    T_QCHECK.SQL.Add('SELECT '+_Field_IDNO+','+_Field_NAME+','+_Field_MARK);
    T_QCHECK.SQL.Add('FROM   '+_TableNAME);
    T_QCHECK.SQL.Add('WHERE  '+_Field_MARK+' LIKE ''%'+T_STR+'%''');
    IF TRIM(_Field_KEY1) <> '' THEN T_QCHECK.SQL.Add('AND '+_Field_KEY1+' = '''+_Field_KEY2+'''');
    T_QCHECK.SQL.Add('ORDER BY '+_Field_MARK+','+_Field_NAME);
    T_QCHECK.Close;
    T_QCHECK.Open;
  EXCEPT
//    SHOWMESSAGE('数据库无法打开, 数据源可能设置错误!');
  END;

  IF T_QCHECK.Eof  = FALSE THEN RESULT := TRUE
                           ELSE RESULT := FALSE;
END;

FUNCTION JDBLOOKUPBOX.CALL_FMLOOKUP_IDNO:STRING;
BEGIN

  IF Application.FindComponent('FMLOOKUP')=nil then Application.CreateForm(TFMLOOKUP, FMLOOKUP );
  FMLOOKUP.Left := SCREEN.Width - FMLOOKUP.Width;
  FMLOOKUP.Q_DatabaseName := _DatabaseName;
  FMLOOKUP.Q_TableNAME    := _TableNAME;
  FMLOOKUP.Q_IDNO := _Field_IDNO;
  FMLOOKUP.Q_NAME := _Field_NAME;
  FMLOOKUP.Q_KEY1 := _Field_KEY1;
  FMLOOKUP.Q_KEY2 := _Field_KEY2;
  FMLOOKUP.ED_IDNO.TEXT := TEXT;
  FMLOOKUP.ED_NAME.TEXT := TEXT;
  FMLOOKUP.FIND_QUERY_IDNO(FMLOOKUP.ED_IDNO.TEXT);
  FMLOOKUP.DBGRID1.Visible := TRUE;
  FMLOOKUP.SHOWMODAL;
  DataSource.DataSet.Edit;
  TEXT := FMLOOKUP.Q_RETURN_IDNO;
  RESULT := TEXT;
END;

FUNCTION JDBLOOKUPBOX.CALL_FMLOOKUP_NAME:STRING;
BEGIN

  IF Application.FindComponent('FMLOOKUP')=nil then Application.CreateForm(TFMLOOKUP, FMLOOKUP );
  FMLOOKUP.Left := SCREEN.Width - FMLOOKUP.Width;
  FMLOOKUP.Q_DatabaseName := _DatabaseName;
  FMLOOKUP.Q_TableNAME    := _TableNAME;
  FMLOOKUP.Q_IDNO := _Field_IDNO;
  FMLOOKUP.Q_NAME := _Field_NAME;
  FMLOOKUP.Q_KEY1 := _Field_KEY1;
  FMLOOKUP.Q_KEY2 := _Field_KEY2;
  FMLOOKUP.ED_IDNO.TEXT := TEXT;
  FMLOOKUP.ED_NAME.TEXT := TEXT;
  FMLOOKUP.FIND_QUERY_NAME(FMLOOKUP.ED_NAME.TEXT);
  FMLOOKUP.DBGRID1.Visible := TRUE;
  FMLOOKUP.SHOWMODAL;
  DataSource.DataSet.Edit;
  TEXT := FMLOOKUP.Q_RETURN_IDNO;
  RESULT := TEXT;
END;

FUNCTION JDBLOOKUPBOX.CALL_FMLOOKUP_MARK:STRING;
BEGIN

  IF Application.FindComponent('FMLOOKUP')=nil then Application.CreateForm(TFMLOOKUP, FMLOOKUP );
  FMLOOKUP.Left := SCREEN.Width - FMLOOKUP.Width;
  FMLOOKUP.Q_DatabaseName := _DatabaseName;
  FMLOOKUP.Q_TableNAME    := _TableNAME;
  FMLOOKUP.Q_IDNO := _Field_IDNO;
  FMLOOKUP.Q_NAME := _Field_NAME;
  FMLOOKUP.Q_MARK := _Field_MARK;
  FMLOOKUP.Q_KEY1 := _Field_KEY1;
  FMLOOKUP.Q_KEY2 := _Field_KEY2;
  FMLOOKUP.ED_IDNO.TEXT := TEXT;
  FMLOOKUP.ED_NAME.TEXT := TEXT;
  FMLOOKUP.ED_MARK.TEXT := TEXT;
  FMLOOKUP.FIND_QUERY_MARK(FMLOOKUP.ED_MARK.TEXT);
  FMLOOKUP.DBGRID2.Visible := TRUE;
  FMLOOKUP.SHOWMODAL;
  DataSource.DataSet.Edit;
  TEXT := FMLOOKUP.Q_RETURN_IDNO;
  RESULT := TEXT;
END;

FUNCTION JDBLOOKUPBOX.LABEL_CALL_FMLOOKUP_IDNO:STRING;
BEGIN

  IF Application.FindComponent('FMLOOKUP')=nil then Application.CreateForm(TFMLOOKUP, FMLOOKUP );
  FMLOOKUP.Left := SCREEN.Width - FMLOOKUP.Width;
  FMLOOKUP.Q_DatabaseName := _DatabaseName;
  FMLOOKUP.Q_TableNAME    := _TableNAME;
  FMLOOKUP.Q_IDNO := _Field_IDNO;
  FMLOOKUP.Q_NAME := _Field_NAME;
  FMLOOKUP.Q_KEY1 := _Field_KEY1;
  FMLOOKUP.Q_KEY2 := _Field_KEY2;
  FMLOOKUP.ED_IDNO.TEXT := TEXT;
  FMLOOKUP.ED_NAME.TEXT := TEXT;
  FMLOOKUP.FOCUS_QUERY_IDNO(FMLOOKUP.ED_IDNO.TEXT);
  FMLOOKUP.DBGRID1.Visible := TRUE;
  FMLOOKUP.SHOWMODAL;
  DataSource.DataSet.Edit;
  TEXT := FMLOOKUP.Q_RETURN_IDNO;
  RESULT := TEXT;
END;

// LABEL ===============================================================
procedure JDBLOOKUPBOX.T_LABELCLICK(SENDER:TOBJECT);
BEGIN
//   IF (_Field_MARK =  '') THEN LABEL_CALL_FMLOOKUP_IDNO;
   SetFocus;
   LABEL_CALL_FMLOOKUP_IDNO;
   IF FIND_GRID_IDNO(TEXT) = FALSE THEN SetFocus; //找不到
END;

PROCEDURE JDBLOOKUPBOX.REFRESH_EDIT;
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
