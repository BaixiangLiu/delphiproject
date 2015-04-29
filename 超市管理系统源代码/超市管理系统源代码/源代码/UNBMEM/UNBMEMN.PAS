unit UNBMEMN;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, Db, DBTables, Menus, JLOOKUPD, StdCtrls, Mask, DBCtrls,
  JEdit, ExtCtrls;

type
  TFMBMEMN = class(TForm)
    MainMenu1: TMainMenu;
    PREVIEW1: TMenuItem;
    SEARCH: TMenuItem;
    Panel: TPanel;
    LBBMCNA: TLabel;
    LBBMBTH: TLabel;
    LBBMSEX: TLabel;
    LBBMENO: TLabel;
    LBBMNAM: TLabel;
    LBBMPGR: TLabel;
    LBBMWPN: TLabel;
    LBBMTL1: TLabel;
    LBBMTL2: TLabel;
    LBBMAD1: TLabel;
    LBBMAD2: TLabel;
    LBBMEML: TLabel;
    LBBMJND: TLabel;
    LBBMCRD: TLabel;
    LBBMMRK: TLabel;
    LBBMLVE: TLabel;
    LBBMBYR: TLabel;
    LBBMBTO: TLabel;
    LBBMBDT: TLabel;
    LBBMBPO: TLabel;
    LBBMBTM: TLabel;
    BMCNA: TJDBEdit;
    BMENO: TJDBEdit;
    BMNAM: TJDBEdit;
    BMBTH: TJDBEdit;
    BMTL3: TJDBEdit;
    BMWPN: TJDBEdit;
    BMTL1: TJDBEdit;
    BMTL2: TJDBEdit;
    BMAD1: TJDBEdit;
    BMAD2: TJDBEdit;
    BMEML: TJDBEdit;
    BMMRK: TJDBEdit;
    BMLVE: TJDBEdit;
    BMBYR: TJDBEdit;
    BMBTO: TJDBEdit;
    BMBPO: TJDBEdit;
    BMBTM: TJDBEdit;
    BMJND: TJDBEdit;
    BMCRD: TJDBEdit;
    BMBDT: TJDBEdit;
    BMSEX: JDBLOOKUPBOX;
    DSBMEM: TDataSource;
    QBMEM: TQuery;
    DBGrid: TDBGrid;
    QBMEMBMENO: TStringField;
    QBMEMBMNAM: TStringField;
    QBMEMBMCNA: TStringField;
    QBMEMBMBTH: TDateTimeField;
    QBMEMBMSEX: TStringField;
    QBMEMBMLVE: TFloatField;
    QBMEMBMBYR: TFloatField;
    QBMEMBMBTO: TFloatField;
    QBMEMBMBPO: TFloatField;
    QBMEMBMBTM: TFloatField;
    QBMEMBMBDT: TDateTimeField;
    QBMEMBMBYD: TDateTimeField;
    QBMEMBMWPN: TStringField;
    QBMEMBMTL1: TStringField;
    QBMEMBMTL2: TStringField;
    QBMEMBMTL3: TStringField;
    QBMEMBMAD1: TStringField;
    QBMEMBMAD2: TStringField;
    QBMEMBMZP1: TStringField;
    QBMEMBMZP2: TStringField;
    QBMEMBMEML: TStringField;
    QBMEMBMWWW: TStringField;
    QBMEMBMJND: TDateTimeField;
    QBMEMBMCRD: TDateTimeField;
    QBMEMBMDAT: TDateTimeField;
    QBMEMRBPST: TStringField;
    QBMEMBMMRK: TMemoField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BTNQUTClick(Sender: TObject);
    procedure DBGridCellClick(Column: TColumn);
    procedure DBGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    PROCEDURE SEARCH_BMENO(T_BMENO:STRING);
    PROCEDURE SEARCH_BMNAM(T_BMENO:STRING);
    PROCEDURE SEARCH_BMTEL(T_BMENO:STRING);
    PROCEDURE SEARCH_BMADR(T_BMENO:STRING);
  end;

var
  FMBMEMN: TFMBMEMN;

implementation

USES MAINU, UN_UTL, MAIND, DB_UTL, UNPOSA, SYSINI;

{$R *.DFM}

PROCEDURE TFMBMEMN.SEARCH_BMENO(T_BMENO:STRING);
BEGIN
  QBMEM.SQL.CLEAR;
  QBMEM.SQL.ADD('SELECT * FROM BMEM');
  QBMEM.SQL.ADD('WHERE BMENO IS NOT NULL');
  QBMEM.SQL.ADD('  AND BMENO LIKE ''%'+T_BMENO+'%''');
  QBMEM.SQL.ADD('ORDER BY BMENO');
  QBMEM.CLOSE;
  QBMEM.OPEN;
END;

PROCEDURE TFMBMEMN.SEARCH_BMNAM(T_BMENO:STRING);
BEGIN
  QBMEM.SQL.CLEAR;
  QBMEM.SQL.ADD('SELECT * FROM BMEM');
  QBMEM.SQL.ADD('WHERE BMENO IS NOT NULL');
  QBMEM.SQL.ADD('  AND BMNAM LIKE ''%'+T_BMENO+'%''');
  QBMEM.SQL.ADD('ORDER BY BMENO');
  QBMEM.CLOSE;
  QBMEM.OPEN;
END;

PROCEDURE TFMBMEMN.SEARCH_BMTEL(T_BMENO:STRING);
BEGIN
  QBMEM.SQL.CLEAR;
  QBMEM.SQL.ADD('SELECT * FROM BMEM');
  QBMEM.SQL.ADD('WHERE BMENO IS NOT NULL');
  QBMEM.SQL.ADD('  AND ( BMTL1 LIKE ''%'+T_BMENO+'%''');
  QBMEM.SQL.ADD('  OR    BMTL2 LIKE ''%'+T_BMENO+'%'' )');
  QBMEM.SQL.ADD('ORDER BY BMENO');
  QBMEM.CLOSE;
  QBMEM.OPEN;
END;

PROCEDURE TFMBMEMN.SEARCH_BMADR(T_BMENO:STRING);
BEGIN
  QBMEM.SQL.CLEAR;
  QBMEM.SQL.ADD('SELECT * FROM BMEM');
  QBMEM.SQL.ADD('WHERE BMENO IS NOT NULL');
  QBMEM.SQL.ADD('  AND ( BMAD1 LIKE ''%'+T_BMENO+'%''');
  QBMEM.SQL.ADD('  OR    BMAD2 LIKE ''%'+T_BMENO+'%'' )');
  QBMEM.SQL.ADD('ORDER BY BMENO');
  QBMEM.CLOSE;
  QBMEM.OPEN;
END;

procedure TFMBMEMN.FormCreate(Sender: TObject);
begin
  IF SHOW_BMEMN_PANEL = FALSE THEN
     BEGIN
     FMBMEMN.ClientWidth := DBGRID.WIDTH;
     Panel.Free;
     END;
end;

procedure TFMBMEMN.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  QBMEM.Close;
  FMBMEMN.Release;
end;

procedure TFMBMEMN.BTNQUTClick(Sender: TObject);
begin
  CLOSE;
end;

procedure TFMBMEMN.DBGridCellClick(Column: TColumn);
begin
  _TB_TMP_BMENO := QBMEM.FieldByName('BMENO').AsString;
  CLOSE;
end;

procedure TFMBMEMN.DBGridKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  IF KEY = 13 THEN
     BEGIN
     _TB_TMP_BMENO := QBMEM.FieldByName('BMENO').AsString;
     CLOSE;
     END;
end;

procedure TFMBMEMN.FormActivate(Sender: TObject);
begin
  DBGRID.SetFocus;
end;

end.
