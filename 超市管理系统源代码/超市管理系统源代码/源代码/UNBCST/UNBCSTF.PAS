unit UNBCSTF;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ComCtrls, ToolWin, JEdit, ExtCtrls;

type
  TFMBCSTF = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    LB11: TJEDIT;
    LB1: TLabel;
    LB2: TLabel;
    LB3: TLabel;
    LB31: TJEDIT;
    WHEREKEY1: TComboBox;
    WHEREKEY2: TComboBox;
    WHEREKEY3: TComboBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    LB12: TJEDIT;
    LB32: TJEDIT;
    Label7: TLabel;
    Label9: TLabel;
    LB21: TJEDIT;
    Label1: TLabel;
    LB22: TJEDIT;
    Label2: TLabel;
    LB41: TJEdit;
    Label3: TLabel;
    LB42: TJEdit;
    Label8: TLabel;
    LB51: TJEdit;
    Label10: TLabel;
    LB52: TJEdit;
    Label11: TLabel;
    LB61: TJEdit;
    Label12: TLabel;
    LB62: TJEdit;
    Label13: TLabel;
    LB71: TJEdit;
    Label14: TLabel;
    LB72: TJEdit;
    Panel1: TPanel;
    BTNSER: TBitBtn;
    BTNCLR: TBitBtn;
    BTNQUT: TBitBtn;
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
  FMBCSTF: TFMBCSTF;

implementation

uses sysini, fm_utl, UNBCSTD, UNBCSTP, MAINU;

{$R *.DFM}



procedure TFMBCSTF.FormActivate(Sender: TObject);
begin
  LB11.SETFOCUS;

  if SearchFORMMODE = 'SEARCH' then
     begin
     BTNSER.Caption := '&F 查询';
     BTNCLR.Caption := '&C 清除';
     //按钮图形加载
     BTN_LOADBMPSTREAM_BITBTN(BTNSER,SER_TB);
     BTN_LOADBMPSTREAM_BITBTN(BTNCLR,DEL_TB);
     BTN_LOADBMPSTREAM_BITBTN(BTNQUT,QUT_TB);
     end;
  if SearchFORMMODE = 'PRINT'  then
     begin
     BTNSER.Caption := '&W 预览';
     BTNCLR.Caption := '&P 打印';
     //按钮图形加载
     BTN_LOADBMPSTREAM_BITBTN(BTNSER,SER_TB);
     BTN_LOADBMPSTREAM_BITBTN(BTNCLR,DEL_TB);
     BTN_LOADBMPSTREAM_BITBTN(BTNQUT,QUT_TB);
     end;

end;

procedure TFMBCSTF.BTNQUTClick(Sender: TObject);
begin
CLOSE;
end;

procedure TFMBCSTF.WHEREKEY1Exit(Sender: TObject);
begin

  IF (WHEREKEY1.ItemIndex >= 0) AND ( (WHEREKEY1.ItemIndex = WHEREKEY2.ItemIndex) OR (WHEREKEY1.ItemIndex = WHEREKEY3.ItemIndex )) THEN
     Begin
     ShowMessage('所选择排列组合不可重复 !');
     WHEREKEY2.ItemIndex:=-1;
     WHEREKEY3.ItemIndex:=-1;
     WHEREKEY1.SetFocus;
     End;
end;


procedure TFMBCSTF.BTNSERClick(Sender: TObject);
begin
  Search_data;

                    {
  IF RecordCount_Tmp <= 0 THEN
    BEGIN
      SHOWMESSAGE('没有此资料');
      LB11.SETFOCUS;
    END ELSE
    BEGIN

    CLOSE;
    if SearchFORMMODE = 'PRINT'  then
       begin
//       FMBCSTP.LBTITLE.Caption := _USER_CORP_NAME;
       FMBCSTP.QuickRep.Preview;
       end;


    END;
                     }
end;

procedure TFMBCSTF.BTNCLRClick(Sender: TObject);
begin
LB11.Clear;
LB12.Clear;
LB21.Clear;
LB22.Clear;
LB31.Clear;
LB32.Clear;
LB41.Clear;
LB42.Clear;
LB51.Clear;
LB52.Clear;
LB61.Clear;
LB62.Clear;
LB71.Clear;
LB72.Clear;

end;





procedure TFMBCSTF.Search_data;
VAR F_NAME : array[1..10] of STRING;
begin

  WITH FMBCSTD.QBCST DO
  BEGIN
    CLOSE;
    SQL.CLEAR;
    SQL.ADD('SELECT * ');
    SQL.ADD('FROM BCST');
    SQL.ADD('WHERE BCENO IS NOT NULL');
    IF _SUPER_USER = FALSE THEN FMBCSTD.QBCST.SQL.ADD('AND BNENO = '''+ _USER_ID +'''');

    F_NAME[1] := 'BCENO';
    F_NAME[2] := 'BCNAM';
    F_NAME[3] := 'BCMN1';
    F_NAME[4] := 'BCTL1';
    F_NAME[5] := 'BCTL2';
    F_NAME[6] := 'BCAD1';
    F_NAME[7] := 'BCAD2';

    //字符串查询
    SQL.ADD(FINDFORM_WHEREKEY_STRING(F_NAME[1],LB11.Text,LB12.Text));
    SQL.ADD(FINDFORM_WHEREKEY_STRING(F_NAME[2],LB21.Text,LB22.Text));
    SQL.ADD(FINDFORM_WHEREKEY_STRING(F_NAME[3],LB31.Text,LB32.Text));
    SQL.ADD(FINDFORM_WHEREKEY_STRING(F_NAME[4],LB41.Text,LB42.Text));
    SQL.ADD(FINDFORM_WHEREKEY_STRING(F_NAME[5],LB51.Text,LB52.Text));
    SQL.ADD(FINDFORM_WHEREKEY_STRING(F_NAME[6],LB61.Text,LB62.Text));
    SQL.ADD(FINDFORM_WHEREKEY_STRING(F_NAME[7],LB71.Text,LB72.Text));

    //ACCESS " DATE " WHERE KEY  ======================
//    SQL.ADD(FINDFORM_WHEREKEY_DATE(F_NAME[3],LB31.Text,LB32.Text));

    //查询 排序    //ORDER BYE=======================================
    SQL.ADD(FINDFORM_ORDERBY3(F_NAME[1],F_NAME[2],F_NAME[3],WHEREKEY1.ItemIndex,WHEREKEY2.ItemIndex,WHEREKEY3.ItemIndex));

//    SHOWMESSAGE(SQL.TEXT);
    OPEN;
  END;




end;


procedure TFMBCSTF.FormCreate(Sender: TObject);
begin
  WITH FMBCSTF DO
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
