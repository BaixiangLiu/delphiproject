unit RPIVTTF;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ComCtrls, ToolWin, Db, DBTables, JEdit, Grids, DBGrids,
  JLOOKUP, ExtCtrls;

type
  TRMIVTTF = class(TForm)
    GroupBox1: TGroupBox;
    ToolBar: TToolBar;
    ToolButton1: TToolButton;
    BTNPRE: TSpeedButton;
    BTNPRN: TSpeedButton;
    BTNQUT: TSpeedButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    QUERYF: TQuery;
    Label1: TLabel;
    LB21: TJEdit;
    Label2: TLabel;
    LB22: TJEdit;
    QUERYF_COST: TIntegerField;
    LB31: TRadioGroup;
    GroupBox2: TGroupBox;
    WK1: TComboBox;
    Database: TDatabase;
    QUERYFITENO: TStringField;
    QUERYFBGENO: TStringField;
    QUERYFITCNR: TFloatField;
    QUERYFITCNV: TFloatField;
    QUERYFITCNT: TFloatField;
    QUERYFITDAT: TDateTimeField;
    QUERYFITTME: TStringField;
    QUERYFITTRN: TBooleanField;
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
  RMIVTTF: TRMIVTTF;

implementation

uses sysini, fm_utl, un_utl, RPIVTTP, MAINU;

{$R *.DFM}

procedure TRMIVTTF.FormActivate(Sender: TObject);
begin
  LB21.SETFOCUS;
  WK1.ItemIndex := 0;
end;

procedure TRMIVTTF.BTNQUTClick(Sender: TObject);
begin
  CLOSE;
end;

procedure TRMIVTTF.BTNPREClick(Sender: TObject);
begin
  WITH QUERYF DO
    BEGIN
    CLOSE;
    SQL.CLEAR;
    SQL.ADD('SELECT * FROM IVTT ');
    SQL.ADD('WHERE ITENO IS NOT NULL');
    IF LB31.ItemIndex = 0 THEN SQL.ADD('  AND IVTT.ITCNT > 0');
    IF LB31.ItemIndex = 1 THEN SQL.ADD('  AND IVTT.ITCNT < 0');
    IF LB31.ItemIndex = 2 THEN SQL.ADD('  AND IVTT.ITCNT = 0');

    //ACCESS " DATE " WHERE KEY  ======================
    SQL.ADD(FINDFORM_WHEREKEY_DATE('ITDAT',LB21.Text,LB22.Text));

    //查询 排序    //ORDER BYE=======================================
    CASE WK1.ItemIndex OF
       0 : SQL.ADD('order by IVTT.BGENO ');
       1 : SQL.ADD('order by IVTT.ITCNR DESC');
       2 : SQL.ADD('order by IVTT.ITCNV DESC');
       3 : SQL.ADD('order by IVTT.ITCNT DESC');
    END;
    OPEN;
    END;

  IF QUERYF.EOF = TRUE THEN
    BEGIN
    SHOWMESSAGE('没有此资料');
    LB21.SETFOCUS;
    END ELSE BEGIN
    IF SENDER = BTNPRE THEN RMIVTTP.QuickRep.Preview;
    IF SENDER = BTNPRN THEN RMIVTTP.QuickRep.Print;
    END;
end;

procedure TRMIVTTF.FormCreate(Sender: TObject);
begin
  IF FormExists('RMIVTTP')=FALSE THEN Application.CreateForm(TRMIVTTP, RMIVTTP  );

  //按钮图形加载
  BTNPRN.Glyph := PRN_TB;
  BTNPRE.Glyph := PRE_TB;
  BTNQUT.Glyph := QUT_TB;
end;

procedure TRMIVTTF.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  RMIVTTF.Release;
  RMIVTTP.Release;
end;

end.
