unit JLOOKUPF;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ComCtrls, ToolWin, Grids, DBGrids, Db, DBTables, Menus;

type
  TFMLOOKUP = class(TForm)
    DBGrid1: TDBGrid;
    QCHECK: TQuery;
    ED_IDNO: TEdit;
    Label1: TLabel;
    ED_NAME: TEdit;
    Label2: TLabel;
    DataSource1: TDataSource;
    BTNSER1: TSpeedButton;
    BTNSER2: TSpeedButton;
    DBGrid2: TDBGrid;
    BTNSER3: TSpeedButton;
    ED_MARK: TEdit;
    Label3: TLabel;
    MainMenu1: TMainMenu;
    ESC: TMenuItem;
    BTNSER: TSpeedButton;
    BTNQUT: TSpeedButton;
    procedure BTNQUTClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure BTNSER2Click(Sender: TObject);
    procedure ED_IDNOKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ED_NAMEKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure FormActivate(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BTNSER1Click(Sender: TObject);
    procedure BTNSERClick(Sender: TObject);
    procedure BTNSER3Click(Sender: TObject);
    procedure DBGrid2TitleClick(Column: TColumn);
    procedure ESCClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Q_DATABASENAME:STRING;
    Q_IDNO, Q_NAME, Q_MARK, Q_TABLENAME : STRING;
    Q_KEY1, Q_KEY2 : STRING;

    Q_RETURN_IDNO : STRING;

    Q_LOOKUP_ORDERBY_ID : INTEGER;
    FUNCTION  FIND_QUERY_IDNO(T_STR:STRING):STRING;
    FUNCTION  FIND_QUERY_NAME(T_STR:STRING):STRING;
    FUNCTION  FIND_QUERY_MARK(T_STR:STRING):STRING;
    FUNCTION  FOCUS_QUERY_IDNO(T_STR:STRING):STRING;
//    FUNCTION  FOCUS_QUERY_MARK(T_STR:STRING):STRING;
  end;

var
  FMLOOKUP: TFMLOOKUP;

implementation

USES UN_UTL;

{$R *.DFM}

FUNCTION  TFMLOOKUP.FIND_QUERY_IDNO(T_STR:STRING):STRING;
BEGIN
  TRY
    QCHECK.DatabaseName    := Q_DatabaseName;
    QCHECK.SQL.CLEAR;
    QCHECK.SQL.Add('SELECT '+ Q_IDNO +','+ Q_NAME);
    QCHECK.SQL.Add('FROM   '+ Q_TableNAME);
    QCHECK.SQL.Add('WHERE  '+ Q_IDNO +' LIKE ''%'+T_STR+'%''');
    IF TRIM(Q_KEY1) <> '' THEN QCHECK.SQL.Add('AND '+Q_KEY1+' = '''+Q_KEY2+'''');
    IF (Q_LOOKUP_ORDERBY_ID<=0)AND(Q_IDNO<>'')AND(Q_NAME<>'') THEN QCHECK.SQL.Add('ORDER BY '+Q_IDNO+','+Q_NAME);
    IF (Q_LOOKUP_ORDERBY_ID>=1)AND(Q_IDNO<>'')AND(Q_NAME<>'') THEN QCHECK.SQL.Add('ORDER BY '+Q_NAME+','+Q_IDNO);
    QCHECK.Close;
    QCHECK.Open;
    //调整GRID 的宽度
    DBGRID1.Columns.Items[0].FieldName := Q_IDNO;
    DBGRID1.Columns.Items[1].FieldName := Q_NAME;
  EXCEPT
    SHOWMESSAGE('数据库无法打开, 资料源可能设置错误!');
  END;
END;

FUNCTION TFMLOOKUP.FIND_QUERY_NAME(T_STR:STRING):STRING;
BEGIN
  TRY
    QCHECK.DatabaseName    := Q_DatabaseName;
    QCHECK.SQL.CLEAR;
    QCHECK.SQL.Add('SELECT '+ Q_IDNO +','+ Q_NAME);
    QCHECK.SQL.Add('FROM   '+ Q_TableNAME);
    QCHECK.SQL.Add('WHERE  '+ Q_NAME +' LIKE ''%'+T_STR+'%''');
    IF TRIM(Q_KEY1) <> '' THEN QCHECK.SQL.Add('AND '+Q_KEY1+' = '''+Q_KEY2+'''');
    IF (Q_LOOKUP_ORDERBY_ID <=0)AND(Q_IDNO<>'')AND(Q_NAME<>'') THEN QCHECK.SQL.Add('ORDER BY '+Q_IDNO+','+Q_NAME);
    IF (Q_LOOKUP_ORDERBY_ID >=1)AND(Q_IDNO<>'')AND(Q_NAME<>'') THEN QCHECK.SQL.Add('ORDER BY '+Q_NAME+','+Q_IDNO);
    QCHECK.Close;
    QCHECK.Open;
    //调整GRID 的宽度
    DBGRID1.Columns.Items[0].FieldName := Q_IDNO;
    DBGRID1.Columns.Items[1].FieldName := Q_NAME;
  EXCEPT
    SHOWMESSAGE('数据库无法打开, 资料源可能设置错误!');
  END;
END;

FUNCTION TFMLOOKUP.FIND_QUERY_MARK(T_STR:STRING):STRING;
BEGIN
  TRY
    QCHECK.DatabaseName    := Q_DatabaseName;
    QCHECK.SQL.CLEAR;
    QCHECK.SQL.Add('SELECT '+ Q_IDNO +','+ Q_NAME +','+ Q_MARK);
    QCHECK.SQL.Add('FROM   '+ Q_TableNAME);
    QCHECK.SQL.Add('WHERE  '+ Q_MARK +' LIKE ''%'+T_STR+'%''');
    IF TRIM(Q_KEY1) <> '' THEN QCHECK.SQL.Add('AND '+Q_KEY1+' = '''+Q_KEY2+'''');
    IF (Q_LOOKUP_ORDERBY_ID<=0)AND(Q_MARK<>'')AND(Q_NAME<>'') THEN QCHECK.SQL.Add('ORDER BY '+Q_MARK+','+Q_NAME);
    IF (Q_LOOKUP_ORDERBY_ID =1)AND(Q_MARK<>'')AND(Q_NAME<>'') THEN QCHECK.SQL.Add('ORDER BY '+Q_NAME+','+Q_MARK);
    IF (Q_LOOKUP_ORDERBY_ID>=2)AND(Q_MARK<>'')AND(Q_NAME<>'') THEN QCHECK.SQL.Add('ORDER BY '+Q_MARK+','+Q_NAME);
    QCHECK.Close;
    QCHECK.Open;
    //调整GRID 的宽度
    DBGRID2.Columns.Items[0].FieldName := Q_IDNO;
    DBGRID2.Columns.Items[1].FieldName := Q_NAME;
    DBGRID2.Columns.Items[2].FieldName := Q_MARK;
  EXCEPT
    SHOWMESSAGE('数据库无法打开, 资料源可能设置错误!');
  END;
END;

FUNCTION TFMLOOKUP.FOCUS_QUERY_IDNO(T_STR:STRING):STRING;
BEGIN
  IF (TRIM(Q_IDNO)='')OR(TRIM(Q_NAME)='') THEN EXIT;
  TRY
    QCHECK.DatabaseName    := Q_DatabaseName;
    QCHECK.SQL.CLEAR;
    QCHECK.SQL.Add('SELECT '+ Q_IDNO +','+ Q_NAME);
    QCHECK.SQL.Add('FROM   '+ Q_TableNAME);
    QCHECK.SQL.Add('WHERE  '+ Q_IDNO +' IS NOT NULL');
//    QCHECK.SQL.Add('WHERE  '+ Q_IDNO +' LIKE ''%'+T_STR+'%''');
    IF TRIM(Q_KEY1) <> '' THEN QCHECK.SQL.Add('AND '+Q_KEY1+' = '''+Q_KEY2+'''');
    IF (Q_LOOKUP_ORDERBY_ID <=0)AND(Q_IDNO<>'')AND(Q_NAME<>'') THEN QCHECK.SQL.Add('ORDER BY '+Q_IDNO+','+Q_NAME);
    IF (Q_LOOKUP_ORDERBY_ID >=1)AND(Q_IDNO<>'')AND(Q_NAME<>'') THEN QCHECK.SQL.Add('ORDER BY '+Q_NAME+','+Q_IDNO);
//    SHOWMESSAGE(QCHECK.SQL.TEXT +'='+T_STR);
    QCHECK.Close;
    QCHECK.Open;
    IF (QCHECK.EOF = FALSE)AND(TRIM(T_STR)<>'') THEN QCHECK.Locate(Q_IDNO,T_STR,[loCaseInsensitive]);
    //调整GRID 的宽度
    DBGRID1.Columns.Items[0].FieldName := Q_IDNO;
    DBGRID1.Columns.Items[1].FieldName := Q_NAME;
  EXCEPT
    SHOWMESSAGE('数据库无法打开, 资料源可能设置错误!');
  END;
END;


procedure TFMLOOKUP.FormClose(Sender: TObject; var Action: TCloseAction);
begin
FMLOOKUP.Release;
end;

procedure TFMLOOKUP.FormCreate(Sender: TObject);
begin
DBGRID1.Left := 0; DBGRID1.TOP  := 60;
DBGRID2.Left := 0; DBGRID2.TOP  := 60;
FMLOOKUP.Left := SCREEN.Width - FMLOOKUP.Width;
Q_LOOKUP_ORDERBY_ID := INI_LOAD_INT('JLOOKUPF','INDEX',0);

IF Q_LOOKUP_ORDERBY_ID <=0 THEN FMLOOKUP.Caption := '相关资料快速查询 - 按编号排序';
IF Q_LOOKUP_ORDERBY_ID  =1 THEN FMLOOKUP.Caption := '相关资料快速查询 - 按名称排序';
IF Q_LOOKUP_ORDERBY_ID >=2 THEN FMLOOKUP.Caption := '相关资料快速查询 - 按相关信息排序';
end;

procedure TFMLOOKUP.FormActivate(Sender: TObject);
begin
FMLOOKUP.Left := SCREEN.Width - FMLOOKUP.Width;
FMLOOKUP.TOP  := (SCREEN.HEIGHT - FMLOOKUP.HEIGHT) DIV 2;
IF DBGRID1.Visible = TRUE THEN DBGRID1.SetFocus;
IF DBGRID2.Visible = TRUE THEN DBGRID2.SetFocus;
end;

procedure TFMLOOKUP.BTNQUTClick(Sender: TObject);
begin
//Q_RETURN_IDNO := QCHECK.FieldByName(Q_IDNO).AsString;
CLOSE;
end;

procedure TFMLOOKUP.BTNSER1Click(Sender: TObject);
begin
FIND_QUERY_IDNO(ED_IDNO.TEXT);
DBGRID1.Visible := TRUE;
DBGRID2.Visible := FALSE;
DBGRID1.SetFocus;
end;

procedure TFMLOOKUP.BTNSER2Click(Sender: TObject);
begin
FIND_QUERY_NAME(ED_NAME.TEXT);
DBGRID1.Visible := TRUE;
DBGRID2.Visible := FALSE;
DBGRID1.SetFocus;
end;

procedure TFMLOOKUP.BTNSER3Click(Sender: TObject);
begin
FIND_QUERY_MARK(ED_NAME.TEXT);
DBGRID1.Visible := FALSE;
DBGRID2.Visible := TRUE;
DBGRID2.SetFocus;
end;

procedure TFMLOOKUP.ED_IDNOKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
IF KEY = 13 THEN FIND_QUERY_IDNO(ED_IDNO.TEXT);
end;

procedure TFMLOOKUP.ED_NAMEKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
IF KEY = 13 THEN FIND_QUERY_NAME(ED_NAME.TEXT);
end;

procedure TFMLOOKUP.DBGrid1KeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
IF KEY = 13 THEN Q_RETURN_IDNO := QCHECK.FieldByName(Q_IDNO).AsString;
IF KEY = 13 THEN CLOSE;
end;

procedure TFMLOOKUP.DBGrid1CellClick(Column: TColumn);
begin
Q_RETURN_IDNO := QCHECK.FieldByName(Q_IDNO).AsString;
CLOSE;
end;







procedure TFMLOOKUP.BTNSERClick(Sender: TObject);
begin
ED_IDNO.Text := '';
ED_NAME.Text := '';
end;


procedure TFMLOOKUP.DBGrid2TitleClick(Column: TColumn);
begin
Q_LOOKUP_ORDERBY_ID := COLUMN.ID;
INI_SAVE_INT('JLOOKUPF','INDEX',COLUMN.ID);
end;

procedure TFMLOOKUP.ESCClick(Sender: TObject);
begin
CLOSE;
end;

end.
