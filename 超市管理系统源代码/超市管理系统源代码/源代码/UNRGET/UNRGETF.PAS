unit UNRGETF;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ComCtrls, ToolWin, JEdit, JLOOKUP, ExtCtrls;

type
  TFMRGETF = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    LB11: TJEdit;
    LB1: TLabel;
    LB2: TLabel;
    WHEREKEY1: TComboBox;
    WHEREKEY2: TComboBox;
    WHEREKEY3: TComboBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    ToolBar: TToolBar;
    ToolButton1: TToolButton;
    BTNSER: TSpeedButton;
    BTNCLR: TSpeedButton;
    BTNQUT: TSpeedButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    LB12: TJEdit;
    Label7: TLabel;
    LB21: TJEdit;
    LB5: TLabel;
    Label2: TLabel;
    LB51: TJEdit;
    LB52: TJEdit;
    LB41: JLOOKUPBOX;
    LB4: TLabel;
    LB31: JLOOKUPBOX;
    LB3: TLabel;
    LB61: TRadioGroup;
    procedure WHEREKEY1Exit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BTNQUTClick(Sender: TObject);
    procedure BTNSERClick(Sender: TObject);
    procedure BTNCLRClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure Search_data;
  public
    { Public declarations }
    SearchFORMMODE : STRING;
  end;

var
  FMRGETF: TFMRGETF;

implementation

uses sysini, fm_utl, UNRGETD, UNRGETP, MAINU;

{$R *.DFM}



procedure TFMRGETF.FormActivate(Sender: TObject);
begin
  LB11.SETFOCUS;

  if SearchFORMMODE = 'SEARCH' then
     begin
     BTNSER.Caption := '&F 查询';
     BTNCLR.Caption := '&C 清除';
     //按钮图形加载
     BTN_LOADBMPFILE(BTNQUT,BTNQUT,BTNQUT,BTNQUT,BTNQUT,BTNSER,BTNCLR,BTNQUT,
                     INS_TB,UPD_TB,DEL_TB,YES_TB,CAL_TB,SER_TB,DEL_TB,QUT_TB);
     end;
  if SearchFORMMODE = 'PRINT'  then
     begin
     BTNSER.Caption := '&W 预览';
     BTNCLR.Caption := '&P 打印';
     //按钮图形加载
     BTN_LOADBMPFILE(BTNQUT,BTNQUT,BTNQUT,BTNQUT,BTNQUT,BTNSER,BTNCLR,BTNQUT,
                     INS_TB,UPD_TB,DEL_TB,YES_TB,CAL_TB,PRE_TB,PRN_TB,QUT_TB);
     end;



end;

procedure TFMRGETF.BTNQUTClick(Sender: TObject);
begin
CLOSE;
end;

procedure TFMRGETF.WHEREKEY1Exit(Sender: TObject);
begin

  IF (WHEREKEY1.ItemIndex >= 0) AND ( (WHEREKEY1.ItemIndex = WHEREKEY2.ItemIndex) OR (WHEREKEY1.ItemIndex = WHEREKEY3.ItemIndex )) THEN
     Begin
     ShowMessage('所选择排列组合不可重复 !');
     WHEREKEY2.ItemIndex:=-1;
     WHEREKEY3.ItemIndex:=-1;
     WHEREKEY1.SetFocus;
     End;
end;


procedure TFMRGETF.BTNSERClick(Sender: TObject);
var RecordCount_Tmp :Integer;
begin

  Search_data;

  RecordCount_Tmp := FMRGETD.QRGET.RecordCount;

//IF FMRGETD.QRGET.RecordCount > 0 THEN
//  SHOWMESSAGE(INTTOSTR(FMRGETD.QRGET.RecordCount));



  IF RecordCount_Tmp <= 0 THEN
    BEGIN
      SHOWMESSAGE('没有此资料');
      LB11.SETFOCUS;
    END ELSE
    BEGIN

    CLOSE;
    if SearchFORMMODE = 'PRINT'  then
       begin
       FMRGETP.LB_RECORDCOUNT.Caption := '共 '+INTTOSTR(RecordCount_Tmp)+'笔';

       FMRGETP.LBTITLE.Caption := _USER_CORP_NAME;
       FMRGETP.QuickRep.Preview;
       end;

       
    END;

end;

procedure TFMRGETF.BTNCLRClick(Sender: TObject);
begin
LB11.Clear;
LB12.Clear;
LB21.Clear;
LB31.Clear;
LB41.Clear;
LB51.Clear;
LB52.Clear;
end;





procedure TFMRGETF.Search_data;
VAR F_NAME : array[1..10] of STRING;
begin

  WITH FMRGETD.QRGET DO
  BEGIN
    CLOSE;
    SQL.CLEAR;
    SQL.ADD('SELECT * ');
    SQL.ADD('FROM RGET');
    SQL.ADD('WHERE RGENO IS NOT NULL');
    IF LB61.ItemIndex = 0 THEN SQL.ADD('  AND RGOUT = 0 ');
    IF LB61.ItemIndex = 1 THEN SQL.ADD('  AND RGOUT = 1 ');

    F_NAME[1] := 'RGENO';
    F_NAME[2] := 'BGENO';
    F_NAME[3] := 'RGREA';
    F_NAME[4] := 'BNENO';
    F_NAME[5] := 'RGDAT';

    //字符串查询
    SQL.ADD(FINDFORM_WHEREKEY_STRING(F_NAME[1],LB11.Text,LB12.Text));
    SQL.ADD(FINDFORM_WHEREKEY_STRING(F_NAME[2],LB21.Text,''));
    SQL.ADD(FINDFORM_WHEREKEY_STRING(F_NAME[3],LB31.Text,''));
    SQL.ADD(FINDFORM_WHEREKEY_STRING(F_NAME[4],LB41.Text,''));

    //ACCESS " DATE " WHERE KEY  ======================
    SQL.ADD(FINDFORM_WHEREKEY_DATE(F_NAME[5],LB51.Text,LB52.Text));

    //查询 排序    //ORDER BYE=======================================
    SQL.ADD(FINDFORM_ORDERBY3(F_NAME[1],F_NAME[2],F_NAME[3],WHEREKEY1.ItemIndex,WHEREKEY2.ItemIndex,WHEREKEY3.ItemIndex));

//    SHOWMESSAGE(SQL.TEXT);
    OPEN;
  END;




end;


procedure TFMRGETF.FormCreate(Sender: TObject);
begin
  WITH FMRGETF DO
     BEGIN
        WHEREKEY1.ITEMS.Clear;
        WHEREKEY2.ITEMS.Clear;
        WHEREKEY3.ITEMS.Clear;
     IF FindComponent('LB1') <> nil then
        BEGIN
        WHEREKEY1.ITEMS.Add(LB1.CAPTION);
        WHEREKEY2.ITEMS.Add(LB1.CAPTION);
        WHEREKEY3.ITEMS.Add(LB1.CAPTION);
        END;
     IF FindComponent('LB2') <> nil then
        BEGIN
        WHEREKEY1.ITEMS.Add(LB2.CAPTION);
        WHEREKEY2.ITEMS.Add(LB2.CAPTION);
        WHEREKEY3.ITEMS.Add(LB2.CAPTION);
        END;
     IF FindComponent('LB3') <> nil then
        BEGIN
        WHEREKEY1.ITEMS.Add(LB3.CAPTION);
        WHEREKEY2.ITEMS.Add(LB3.CAPTION);
        WHEREKEY3.ITEMS.Add(LB3.CAPTION);
        END;

     WHEREKEY1.ItemIndex := 0;
     END;




end;



end.
