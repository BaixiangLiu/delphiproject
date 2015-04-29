unit SELOOKUPF;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ComCtrls, ToolWin, Grids, DBGrids, Db, DBTables, Menus;

type
  TFMSELOOKUP = class(TForm)
    DBGrid1: TDBGrid;
    QCHECK: TQuery;
    ED_IDNO: TEdit;
    Label1: TLabel;
    ED_NAME: TEdit;
    Label2: TLabel;
    DataSource1: TDataSource;
    BTNSER1: TSpeedButton;
    BTNSER2: TSpeedButton;
    ToolBar: TToolBar;
    ToolButton1: TToolButton;
    BTNSER: TSpeedButton;
    BTNQUT: TSpeedButton;
    MainMenu1: TMainMenu;
    ESC: TMenuItem;
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
    procedure DBGrid2TitleClick(Column: TColumn);
    procedure ESCClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Q_DATABASENAME:STRING;
    Q_TABLENAME : STRING;

    Q_IDNO : STRING;
    Q_RETURN_IDNO : STRING;
    Q_LOOKUP_ORDERBY_ID : INTEGER;
    FUNCTION  FIND_QUERY_IDNO(T_STR:STRING):STRING;
    FUNCTION  FIND_QUERY_NAME(T_STR:STRING):STRING;
    FUNCTION  FOCUS_QUERY_IDNO(T_STR:STRING):STRING;
//    FUNCTION  FOCUS_QUERY_MARK(T_STR:STRING):STRING;
  end;

var
  FMSELOOKUP: TFMSELOOKUP;

implementation

USES UN_UTL;

{$R *.DFM}

FUNCTION  TFMSELOOKUP.FIND_QUERY_IDNO(T_STR:STRING):STRING;
BEGIN
  TRY
    QCHECK.DatabaseName    := Q_DatabaseName;
    QCHECK.SQL.CLEAR;
    QCHECK.SQL.Add('SELECT * FROM   '+ Q_TableNAME);
    QCHECK.SQL.Add('WHERE LSTENO =    ''' +Q_IDNO+'''');
    QCHECK.SQL.Add('  AND LSTITM LIKE ''%'+T_STR+'%''');
    IF Q_LOOKUP_ORDERBY_ID <=0 THEN QCHECK.SQL.Add('ORDER BY LSTITM, LSTNAM');
    IF Q_LOOKUP_ORDERBY_ID >=1 THEN QCHECK.SQL.Add('ORDER BY LSTNAM, LSTITM');
    QCHECK.Close;
    QCHECK.Open;
    //调整GRID 的宽度
    DBGRID1.Columns.Items[0].FieldName := 'LSTITM';
    DBGRID1.Columns.Items[1].FieldName := 'LSTNAM';
  EXCEPT
    SHOWMESSAGE('数据库无法打开, 资料源可能设定错误!');
  END;
END;

FUNCTION TFMSELOOKUP.FIND_QUERY_NAME(T_STR:STRING):STRING;
BEGIN
  TRY
    QCHECK.DatabaseName    := Q_DatabaseName;
    QCHECK.SQL.CLEAR;
    QCHECK.SQL.Add('SELECT * FROM '+ Q_TableNAME);
    QCHECK.SQL.Add('WHERE LSTENO =    ''' +Q_IDNO+'''');
    QCHECK.SQL.Add('  AND LSTNAM LIKE ''%'+T_STR+'%''');
    IF Q_LOOKUP_ORDERBY_ID <=0 THEN QCHECK.SQL.Add('ORDER BY LSTITM, LSTNAM');
    IF Q_LOOKUP_ORDERBY_ID >=1 THEN QCHECK.SQL.Add('ORDER BY LSTNAM, LSTITM');
    QCHECK.Close;
    QCHECK.Open;
    //调整GRID 的宽度
    DBGRID1.Columns.Items[0].FieldName := 'LSTITM';
    DBGRID1.Columns.Items[1].FieldName := 'LSTNAM';
  EXCEPT
    SHOWMESSAGE('数据库无法打开, 资料源可能设定错误!');
  END;
END;


FUNCTION TFMSELOOKUP.FOCUS_QUERY_IDNO(T_STR:STRING):STRING;
BEGIN
  TRY
    QCHECK.DatabaseName    := Q_DatabaseName;
    QCHECK.SQL.CLEAR;
    QCHECK.SQL.Add('SELECT * FROM '+ Q_TableNAME);
    QCHECK.SQL.Add('WHERE LSTITM IS NOT NULL');
    QCHECK.SQL.Add('  AND LSTENO =  ''' +Q_IDNO+'''');
    IF Q_LOOKUP_ORDERBY_ID <=0 THEN QCHECK.SQL.Add('ORDER BY LSTITM, LSTNAM');
    IF Q_LOOKUP_ORDERBY_ID >=1 THEN QCHECK.SQL.Add('ORDER BY LSTNAM, LSTITM');
    QCHECK.Close;
    QCHECK.Open;
//    QCHECK.Locate(Q_IDNO,T_STR,[loCaseInsensitive]);
    //调整GRID 的宽度
    DBGRID1.Columns.Items[0].FieldName := 'LSTITM';
    DBGRID1.Columns.Items[1].FieldName := 'LSTNAM';
  EXCEPT
    SHOWMESSAGE('数据库无法打开, 资料源可能设定错误!');
  END;
END;


procedure TFMSELOOKUP.FormClose(Sender: TObject; var Action: TCloseAction);
begin
FMSELOOKUP.Release;
end;

procedure TFMSELOOKUP.FormCreate(Sender: TObject);
begin
DBGRID1.Left := 0; DBGRID1.TOP  := 60;
FMSELOOKUP.Left := SCREEN.Width - FMSELOOKUP.Width;
Q_LOOKUP_ORDERBY_ID := INI_LOAD_INT('JLOOKUPF','INDEX',0);

IF Q_LOOKUP_ORDERBY_ID <=0 THEN FMSELOOKUP.Caption := '相关资料快速查询 - 按编号排序';
IF Q_LOOKUP_ORDERBY_ID  =1 THEN FMSELOOKUP.Caption := '相关资料快速查询 - 按名称排序';
end;

procedure TFMSELOOKUP.FormActivate(Sender: TObject);
begin
FMSELOOKUP.Left := SCREEN.Width - FMSELOOKUP.Width;
FMSELOOKUP.TOP  := (SCREEN.HEIGHT - FMSELOOKUP.HEIGHT) DIV 2;
IF DBGRID1.Visible = TRUE THEN DBGRID1.SetFocus;
end;

procedure TFMSELOOKUP.BTNQUTClick(Sender: TObject);
begin
Q_RETURN_IDNO := QCHECK.FieldByName('LSTITM').AsString;
CLOSE;
end;

procedure TFMSELOOKUP.BTNSER1Click(Sender: TObject);
begin
FIND_QUERY_IDNO(ED_IDNO.TEXT);
DBGRID1.Visible := TRUE;
DBGRID1.SetFocus;
end;

procedure TFMSELOOKUP.BTNSER2Click(Sender: TObject);
begin
FIND_QUERY_NAME(ED_NAME.TEXT);
DBGRID1.Visible := TRUE;
DBGRID1.SetFocus;
end;

procedure TFMSELOOKUP.ED_IDNOKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
IF KEY = 13 THEN FIND_QUERY_IDNO(ED_IDNO.TEXT);
end;

procedure TFMSELOOKUP.ED_NAMEKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
IF KEY = 13 THEN FIND_QUERY_NAME(ED_NAME.TEXT);
end;

procedure TFMSELOOKUP.DBGrid1KeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
IF KEY = 13 THEN Q_RETURN_IDNO := QCHECK.FieldByName('LSTITM').AsString;
IF KEY = 13 THEN CLOSE;
end;

procedure TFMSELOOKUP.DBGrid1CellClick(Column: TColumn);
begin
Q_RETURN_IDNO := QCHECK.FieldByName('LSTITM').AsString;
CLOSE;
end;







procedure TFMSELOOKUP.BTNSERClick(Sender: TObject);
begin
ED_IDNO.Text := '';
ED_NAME.Text := '';
end;


procedure TFMSELOOKUP.DBGrid2TitleClick(Column: TColumn);
begin
Q_LOOKUP_ORDERBY_ID := COLUMN.ID;
INI_SAVE_INT('JLOOKUPF','INDEX',COLUMN.ID);
end;

procedure TFMSELOOKUP.ESCClick(Sender: TObject);
begin
CLOSE;
end;

end.
