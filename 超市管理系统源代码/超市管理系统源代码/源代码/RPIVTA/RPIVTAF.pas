unit RPIVTAF;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ComCtrls, ToolWin, Db, DBTables, JEdit, Grids, DBGrids,
  JLOOKUP;

type
  TRMIVTAF = class(TForm)
    GroupBox1: TGroupBox;
    QIVTAF: TQuery;
    Label1: TLabel;
    LB21: TJEdit;
    Label2: TLabel;
    LB22: TJEdit;
    GroupBox2: TGroupBox;
    WK1: TComboBox;
    WK2: TCheckBox;
    Database: TDatabase;
    QIVTAFBGENO: TStringField;
    QIVTAFIACNT: TFloatField;
    QIVTAFIADAT: TDateTimeField;
    QIVTAFIATME: TStringField;
    ToolBar: TToolBar;
    ToolButton1: TToolButton;
    BTNPRN: TSpeedButton;
    ToolButton2: TToolButton;
    BTNPRE: TSpeedButton;
    ToolButton3: TToolButton;
    BTNQUT: TSpeedButton;
    procedure FormActivate(Sender: TObject);
    procedure BTNQUTClick(Sender: TObject);
    procedure BTNPREClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RMIVTAF: TRMIVTAF;

implementation

uses sysini, fm_utl, un_utl, RPIVTAP, MAINU;

{$R *.DFM}

procedure TRMIVTAF.FormActivate(Sender: TObject);
begin
  LB21.SETFOCUS;
  WK1.ItemIndex := 0;
end;

procedure TRMIVTAF.BTNQUTClick(Sender: TObject);
begin
  CLOSE;
end;

procedure TRMIVTAF.BTNPREClick(Sender: TObject);
begin
  WITH QIVTAF DO
    BEGIN
    CLOSE;
    SQL.CLEAR;
    SQL.ADD('SELECT * FROM IVTA ');
    SQL.ADD('WHERE BGENO IS NOT NULL');
    IF WK2.Checked = TRUE THEN SQL.ADD('  AND IVTA.IACNT > 0 ');

    //ACCESS " DATE " WHERE KEY  ======================
    SQL.ADD(FINDFORM_WHEREKEY_DATE('IADAT',LB21.Text,LB22.Text));

    CASE WK1.ItemIndex OF
       0 : SQL.ADD('order by 1 DESC');
       1 : SQL.ADD('order by 2 DESC');
       2 : SQL.ADD('order by 3 DESC');
    END;

    OPEN;
    END;

  IF QIVTAF.EOF = TRUE THEN
    BEGIN
    SHOWMESSAGE('没有此资料');
    LB21.SETFOCUS;
    END ELSE BEGIN
    IF SENDER = BTNPRE THEN RMIVTAP.QuickRep.Preview;
    IF SENDER = BTNPRN THEN RMIVTAP.QuickRep.Print;
    END;
end;

procedure TRMIVTAF.FormCreate(Sender: TObject);
begin
  IF FormExists('RMIVTAP')=FALSE THEN Application.CreateForm(TRMIVTAP, RMIVTAP  );

  //按钮图形加载
  BTNPRN.Glyph := PRN_TB;
  BTNPRE.Glyph := PRE_TB;
  BTNQUT.Glyph := QUT_TB;                   
end;

procedure TRMIVTAF.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  RMIVTAF.Release;
  RMIVTAP.Release;
end;

end.
