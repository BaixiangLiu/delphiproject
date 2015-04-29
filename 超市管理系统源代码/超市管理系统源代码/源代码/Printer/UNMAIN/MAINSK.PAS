unit mainsK;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, JLOOKUP, Buttons, ComCtrls, Spin, Menus, JEdit, ExtCtrls;

type
  TFMMAINSK = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    GroupBox4: TGroupBox;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    C_ESC: TComboBox;
    C_CTRLI: TComboBox;
    C_CTRLQ: TComboBox;
    C_CTRLP: TComboBox;
    C_CTRLD: TComboBox;
    C_CTRLA: TComboBox;
    C_F1: TComboBox;
    C_F2: TComboBox;
    C_F3: TComboBox;
    C_F4: TComboBox;
    C_F5: TComboBox;
    C_F6: TComboBox;
    C_F7: TComboBox;
    C_F8: TComboBox;
    C_F9: TComboBox;
    C_F10: TComboBox;
    C_F11: TComboBox;
    C_F12: TComboBox;
    C_CTRLB: TComboBox;
    C_CTRLV: TComboBox;
    C_CTRLN: TComboBox;
    C_CTRLM: TComboBox;
    C_CTRLG: TComboBox;
    C_CTRLZ: TComboBox;
    C_CTRLC: TComboBox;
    Label28: TLabel;
    GroupBox1: TGroupBox;
    Label62: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    C_CTRLF5: TComboBox;
    C_CTRLF6: TComboBox;
    C_CTRLF7: TComboBox;
    C_CTRLF8: TComboBox;
    C_CTRLF9: TComboBox;
    C_CTRLF10: TComboBox;
    C_CTRLF11: TComboBox;
    C_CTRLF12: TComboBox;
    Label29: TLabel;
    C_CTRLX: TComboBox;
    C_CTRLS: TComboBox;
    Label30: TLabel;
    Label31: TLabel;
    C_CTRLF: TComboBox;
    procedure FormActivate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMMAINSK: TFMMAINSK;

implementation

USES UN_UTL, DB_UTL,
     MAIN;

{$R *.DFM}

procedure TFMMAINSK.FormCreate(Sender: TObject);
begin

C_CTRLI  .Items.Text := C_ESC.Items.Text;
C_CTRLQ  .Items.Text := C_ESC.Items.Text;
C_CTRLP  .Items.Text := C_ESC.Items.Text;
C_CTRLD  .Items.Text := C_ESC.Items.Text;
C_CTRLA  .Items.Text := C_ESC.Items.Text;
C_CTRLB  .Items.Text := C_ESC.Items.Text;
C_CTRLN  .Items.Text := C_ESC.Items.Text;
C_CTRLM  .Items.Text := C_ESC.Items.Text;
C_CTRLV  .Items.Text := C_ESC.Items.Text;
C_CTRLG  .Items.Text := C_ESC.Items.Text;
C_CTRLZ  .Items.Text := C_ESC.Items.Text;
C_CTRLC  .Items.Text := C_ESC.Items.Text;
C_CTRLX  .Items.Text := C_ESC.Items.Text;
C_CTRLS  .Items.Text := C_ESC.Items.Text;
C_CTRLF  .Items.Text := C_ESC.Items.Text;
C_CTRLF5 .Items.Text := C_ESC.Items.Text;
C_CTRLF6 .Items.Text := C_ESC.Items.Text;
C_CTRLF7 .Items.Text := C_ESC.Items.Text;
C_CTRLF8 .Items.Text := C_ESC.Items.Text;
C_CTRLF9 .Items.Text := C_ESC.Items.Text;
C_CTRLF10.Items.Text := C_ESC.Items.Text;
C_CTRLF11.Items.Text := C_ESC.Items.Text;
C_CTRLF12.Items.Text := C_ESC.Items.Text;

C_F1     .Items.Text := C_ESC.Items.Text;
C_F2     .Items.Text := C_ESC.Items.Text;
C_F3     .Items.Text := C_ESC.Items.Text;
C_F4     .Items.Text := C_ESC.Items.Text;
C_F5     .Items.Text := C_ESC.Items.Text;
C_F6     .Items.Text := C_ESC.Items.Text;
C_F7     .Items.Text := C_ESC.Items.Text;
C_F8     .Items.Text := C_ESC.Items.Text;
C_F9     .Items.Text := C_ESC.Items.Text;
C_F10    .Items.Text := C_ESC.Items.Text;
C_F11    .Items.Text := C_ESC.Items.Text;
C_F12    .Items.Text := C_ESC.Items.Text;


C_F1   .ItemIndex := 1;
C_F2   .ItemIndex := 2;
C_F3   .ItemIndex := 3;
C_F4   .ItemIndex := 4;
C_F5   .ItemIndex := 5;
C_F6   .ItemIndex := 6;
C_F7   .ItemIndex := 7;
C_F8   .ItemIndex := 8;
C_F9   .ItemIndex := 9;
C_F10  .ItemIndex := 10;
C_F11  .ItemIndex := 11;
C_F12  .ItemIndex := 12;
C_ESC  .ItemIndex := 0;
C_CTRLI.ItemIndex := 21;
C_CTRLQ.ItemIndex := 29;
C_CTRLP.ItemIndex := 28;
C_CTRLD.ItemIndex := 16;
C_CTRLA.ItemIndex := 13;
C_CTRLB.ItemIndex := 14;
C_CTRLV.ItemIndex := 34;
C_CTRLN.ItemIndex := 26;
C_CTRLM.ItemIndex := 25;
C_CTRLG.ItemIndex := 19;
C_CTRLZ.ItemIndex := 38;
C_CTRLC.ItemIndex := 15;
C_CTRLX.ItemIndex := 36;
C_CTRLS.ItemIndex := 31;
C_CTRLF.ItemIndex := 18;
C_CTRLF5 .ItemIndex := 43;
C_CTRLF6 .ItemIndex := 44;
C_CTRLF7 .ItemIndex := 45;
C_CTRLF8 .ItemIndex := 46;
C_CTRLF9 .ItemIndex := 47;
C_CTRLF10.ItemIndex := 48;
C_CTRLF11.ItemIndex := 49;
C_CTRLF12.ItemIndex := 50;



C_F1   .ItemIndex := INI_LOAD_INT(POSA_SETFILENAME,'C_F1'    ,C_F1   .ItemIndex);
C_F2   .ItemIndex := INI_LOAD_INT(POSA_SETFILENAME,'C_F2'    ,C_F2   .ItemIndex);
C_F3   .ItemIndex := INI_LOAD_INT(POSA_SETFILENAME,'C_F3'    ,C_F3   .ItemIndex);
C_F4   .ItemIndex := INI_LOAD_INT(POSA_SETFILENAME,'C_F4'    ,C_F4   .ItemIndex);
C_F5   .ItemIndex := INI_LOAD_INT(POSA_SETFILENAME,'C_F5'    ,C_F5   .ItemIndex);
C_F6   .ItemIndex := INI_LOAD_INT(POSA_SETFILENAME,'C_F6'    ,C_F6   .ItemIndex);
C_F7   .ItemIndex := INI_LOAD_INT(POSA_SETFILENAME,'C_F7'    ,C_F7   .ItemIndex);
C_F8   .ItemIndex := INI_LOAD_INT(POSA_SETFILENAME,'C_F8'    ,C_F8   .ItemIndex);
C_F9   .ItemIndex := INI_LOAD_INT(POSA_SETFILENAME,'C_F9'    ,C_F9   .ItemIndex);
C_F10  .ItemIndex := INI_LOAD_INT(POSA_SETFILENAME,'C_F10'   ,C_F10  .ItemIndex);
C_F11  .ItemIndex := INI_LOAD_INT(POSA_SETFILENAME,'C_F11'   ,C_F11  .ItemIndex);
C_F12  .ItemIndex := INI_LOAD_INT(POSA_SETFILENAME,'C_F12'   ,C_F12  .ItemIndex);
C_ESC  .ItemIndex := INI_LOAD_INT(POSA_SETFILENAME,'C_ESC'   ,C_ESC  .ItemIndex);
C_CTRLI.ItemIndex := INI_LOAD_INT(POSA_SETFILENAME,'C_CTRLI' ,C_CTRLI.ItemIndex);
C_CTRLQ.ItemIndex := INI_LOAD_INT(POSA_SETFILENAME,'C_CTRLQ' ,C_CTRLQ.ItemIndex);
C_CTRLP.ItemIndex := INI_LOAD_INT(POSA_SETFILENAME,'C_CTRLP' ,C_CTRLP.ItemIndex);
C_CTRLD.ItemIndex := INI_LOAD_INT(POSA_SETFILENAME,'C_CTRLD' ,C_CTRLD.ItemIndex);
C_CTRLA.ItemIndex := INI_LOAD_INT(POSA_SETFILENAME,'C_CTRLA' ,C_CTRLA.ItemIndex);
C_CTRLB.ItemIndex := INI_LOAD_INT(POSA_SETFILENAME,'C_CTRLB' ,C_CTRLB.ItemIndex);
C_CTRLV.ItemIndex := INI_LOAD_INT(POSA_SETFILENAME,'C_CTRLV' ,C_CTRLV.ItemIndex);
C_CTRLN.ItemIndex := INI_LOAD_INT(POSA_SETFILENAME,'C_CTRLN' ,C_CTRLN.ItemIndex);
C_CTRLM.ItemIndex := INI_LOAD_INT(POSA_SETFILENAME,'C_CTRLM' ,C_CTRLM.ItemIndex);
C_CTRLG.ItemIndex := INI_LOAD_INT(POSA_SETFILENAME,'C_CTRLG' ,C_CTRLG.ItemIndex);
C_CTRLV.ItemIndex := INI_LOAD_INT(POSA_SETFILENAME,'C_CTRLV' ,C_CTRLV.ItemIndex);
C_CTRLZ.ItemIndex := INI_LOAD_INT(POSA_SETFILENAME,'C_CTRLZ' ,C_CTRLZ.ItemIndex);
C_CTRLC.ItemIndex := INI_LOAD_INT(POSA_SETFILENAME,'C_CTRLC' ,C_CTRLC.ItemIndex);
C_CTRLX.ItemIndex := INI_LOAD_INT(POSA_SETFILENAME,'C_CTRLX' ,C_CTRLX.ItemIndex);
C_CTRLS.ItemIndex := INI_LOAD_INT(POSA_SETFILENAME,'C_CTRLS' ,C_CTRLS.ItemIndex);
C_CTRLF.ItemIndex := INI_LOAD_INT(POSA_SETFILENAME,'C_CTRLF' ,C_CTRLF.ItemIndex);

C_CTRLF5 .ItemIndex := INI_LOAD_INT(POSA_SETFILENAME,'C_CTRLF5'  ,C_CTRLF5 .ItemIndex);
C_CTRLF6 .ItemIndex := INI_LOAD_INT(POSA_SETFILENAME,'C_CTRLF6'  ,C_CTRLF6 .ItemIndex);
C_CTRLF7 .ItemIndex := INI_LOAD_INT(POSA_SETFILENAME,'C_CTRLF7'  ,C_CTRLF7 .ItemIndex);
C_CTRLF8 .ItemIndex := INI_LOAD_INT(POSA_SETFILENAME,'C_CTRLF8'  ,C_CTRLF8 .ItemIndex);
C_CTRLF9 .ItemIndex := INI_LOAD_INT(POSA_SETFILENAME,'C_CTRLF9'  ,C_CTRLF9 .ItemIndex);
C_CTRLF10.ItemIndex := INI_LOAD_INT(POSA_SETFILENAME,'C_CTRLF10' ,C_CTRLF10.ItemIndex);
C_CTRLF11.ItemIndex := INI_LOAD_INT(POSA_SETFILENAME,'C_CTRLF11' ,C_CTRLF11.ItemIndex);
C_CTRLF12.ItemIndex := INI_LOAD_INT(POSA_SETFILENAME,'C_CTRLF12' ,C_CTRLF12.ItemIndex);

end;

procedure TFMMAINSK.FormActivate(Sender: TObject);
begin
//
end;

procedure TFMMAINSK.BitBtn1Click(Sender: TObject);
begin
//INI_SAVE_INT(SETFILENAME, 'ED_2'  ,ED_2.ItemIndex);
INI_SAVE_INT(POSA_SETFILENAME,'C_F1'    ,C_F1   .ItemIndex);
INI_SAVE_INT(POSA_SETFILENAME,'C_F2'    ,C_F2   .ItemIndex);
INI_SAVE_INT(POSA_SETFILENAME,'C_F3'    ,C_F3   .ItemIndex);
INI_SAVE_INT(POSA_SETFILENAME,'C_F4'    ,C_F4   .ItemIndex);
INI_SAVE_INT(POSA_SETFILENAME,'C_F5'    ,C_F5   .ItemIndex);
INI_SAVE_INT(POSA_SETFILENAME,'C_F6'    ,C_F6   .ItemIndex);
INI_SAVE_INT(POSA_SETFILENAME,'C_F7'    ,C_F7   .ItemIndex);
INI_SAVE_INT(POSA_SETFILENAME,'C_F8'    ,C_F8   .ItemIndex);
INI_SAVE_INT(POSA_SETFILENAME,'C_F9'    ,C_F9   .ItemIndex);
INI_SAVE_INT(POSA_SETFILENAME,'C_F10'   ,C_F10  .ItemIndex);
INI_SAVE_INT(POSA_SETFILENAME,'C_F11'   ,C_F11  .ItemIndex);
INI_SAVE_INT(POSA_SETFILENAME,'C_F12'   ,C_F12  .ItemIndex);
INI_SAVE_INT(POSA_SETFILENAME,'C_ESC'   ,C_ESC  .ItemIndex);
INI_SAVE_INT(POSA_SETFILENAME,'C_CTRLI' ,C_CTRLI.ItemIndex);
INI_SAVE_INT(POSA_SETFILENAME,'C_CTRLQ' ,C_CTRLQ.ItemIndex);
INI_SAVE_INT(POSA_SETFILENAME,'C_CTRLP' ,C_CTRLP.ItemIndex);
INI_SAVE_INT(POSA_SETFILENAME,'C_CTRLD' ,C_CTRLD.ItemIndex);
INI_SAVE_INT(POSA_SETFILENAME,'C_CTRLA' ,C_CTRLA.ItemIndex);
INI_SAVE_INT(POSA_SETFILENAME,'C_CTRLB' ,C_CTRLB.ItemIndex);
INI_SAVE_INT(POSA_SETFILENAME,'C_CTRLV' ,C_CTRLV.ItemIndex);
INI_SAVE_INT(POSA_SETFILENAME,'C_CTRLN' ,C_CTRLN.ItemIndex);
INI_SAVE_INT(POSA_SETFILENAME,'C_CTRLM' ,C_CTRLM.ItemIndex);
INI_SAVE_INT(POSA_SETFILENAME,'C_CTRLG' ,C_CTRLG.ItemIndex);
INI_SAVE_INT(POSA_SETFILENAME,'C_CTRLZ' ,C_CTRLZ.ItemIndex);
INI_SAVE_INT(POSA_SETFILENAME,'C_CTRLC' ,C_CTRLC.ItemIndex);
INI_SAVE_INT(POSA_SETFILENAME,'C_CTRLX' ,C_CTRLX.ItemIndex);
INI_SAVE_INT(POSA_SETFILENAME,'C_CTRLS' ,C_CTRLS.ItemIndex);
INI_SAVE_INT(POSA_SETFILENAME,'C_CTRLF' ,C_CTRLF.ItemIndex);
INI_SAVE_INT(POSA_SETFILENAME,'C_CTRLF5' ,C_CTRLF5 .ItemIndex);
INI_SAVE_INT(POSA_SETFILENAME,'C_CTRLF6' ,C_CTRLF6 .ItemIndex);
INI_SAVE_INT(POSA_SETFILENAME,'C_CTRLF7' ,C_CTRLF7 .ItemIndex);
INI_SAVE_INT(POSA_SETFILENAME,'C_CTRLF8' ,C_CTRLF8 .ItemIndex);
INI_SAVE_INT(POSA_SETFILENAME,'C_CTRLF9' ,C_CTRLF9 .ItemIndex);
INI_SAVE_INT(POSA_SETFILENAME,'C_CTRLF10',C_CTRLF10.ItemIndex);
INI_SAVE_INT(POSA_SETFILENAME,'C_CTRLF11',C_CTRLF11.ItemIndex);
INI_SAVE_INT(POSA_SETFILENAME,'C_CTRLF12',C_CTRLF12.ItemIndex);

INI_SAVE_STR(POSA_SETFILENAME,'SC_F1'    ,C_F1   .TEXT);
INI_SAVE_STR(POSA_SETFILENAME,'SC_F2'    ,C_F2   .TEXT);
INI_SAVE_STR(POSA_SETFILENAME,'SC_F3'    ,C_F3   .TEXT);
INI_SAVE_STR(POSA_SETFILENAME,'SC_F4'    ,C_F4   .TEXT);
INI_SAVE_STR(POSA_SETFILENAME,'SC_F5'    ,C_F5   .TEXT);
INI_SAVE_STR(POSA_SETFILENAME,'SC_F6'    ,C_F6   .TEXT);
INI_SAVE_STR(POSA_SETFILENAME,'SC_F7'    ,C_F7   .TEXT);
INI_SAVE_STR(POSA_SETFILENAME,'SC_F8'    ,C_F8   .TEXT);
INI_SAVE_STR(POSA_SETFILENAME,'SC_F9'    ,C_F9   .TEXT);
INI_SAVE_STR(POSA_SETFILENAME,'SC_F10'   ,C_F10  .TEXT);
INI_SAVE_STR(POSA_SETFILENAME,'SC_F11'   ,C_F11  .TEXT);
INI_SAVE_STR(POSA_SETFILENAME,'SC_F12'   ,C_F12  .TEXT);
INI_SAVE_STR(POSA_SETFILENAME,'SC_ESC'   ,C_ESC  .TEXT);
INI_SAVE_STR(POSA_SETFILENAME,'SC_CTRLI' ,C_CTRLI.TEXT);
INI_SAVE_STR(POSA_SETFILENAME,'SC_CTRLQ' ,C_CTRLQ.TEXT);
INI_SAVE_STR(POSA_SETFILENAME,'SC_CTRLP' ,C_CTRLP.TEXT);
INI_SAVE_STR(POSA_SETFILENAME,'SC_CTRLD' ,C_CTRLD.TEXT);
INI_SAVE_STR(POSA_SETFILENAME,'SC_CTRLA' ,C_CTRLA.TEXT);
INI_SAVE_STR(POSA_SETFILENAME,'SC_CTRLB' ,C_CTRLB.TEXT);
INI_SAVE_STR(POSA_SETFILENAME,'SC_CTRLV' ,C_CTRLV.TEXT);
INI_SAVE_STR(POSA_SETFILENAME,'SC_CTRLN' ,C_CTRLN.TEXT);
INI_SAVE_STR(POSA_SETFILENAME,'SC_CTRLM' ,C_CTRLM.TEXT);
INI_SAVE_STR(POSA_SETFILENAME,'SC_CTRLG' ,C_CTRLG.TEXT);
INI_SAVE_STR(POSA_SETFILENAME,'SC_CTRLZ' ,C_CTRLZ.TEXT);
INI_SAVE_STR(POSA_SETFILENAME,'SC_CTRLC' ,C_CTRLC.TEXT);
INI_SAVE_STR(POSA_SETFILENAME,'SC_CTRLX' ,C_CTRLX.TEXT);
INI_SAVE_STR(POSA_SETFILENAME,'SC_CTRLS' ,C_CTRLS.TEXT);
INI_SAVE_STR(POSA_SETFILENAME,'SC_CTRLF' ,C_CTRLF.TEXT);
INI_SAVE_STR(POSA_SETFILENAME,'SC_CTRLF5' ,C_CTRLF5 .TEXT);
INI_SAVE_STR(POSA_SETFILENAME,'SC_CTRLF6' ,C_CTRLF6 .TEXT);
INI_SAVE_STR(POSA_SETFILENAME,'SC_CTRLF7' ,C_CTRLF7 .TEXT);
INI_SAVE_STR(POSA_SETFILENAME,'SC_CTRLF8' ,C_CTRLF8 .TEXT);
INI_SAVE_STR(POSA_SETFILENAME,'SC_CTRLF9' ,C_CTRLF9 .TEXT);
INI_SAVE_STR(POSA_SETFILENAME,'SC_CTRLF10',C_CTRLF10.TEXT);
INI_SAVE_STR(POSA_SETFILENAME,'SC_CTRLF11',C_CTRLF11.TEXT);
INI_SAVE_STR(POSA_SETFILENAME,'SC_CTRLF12',C_CTRLF12.TEXT);




CLOSE;
end;

procedure TFMMAINSK.BitBtn2Click(Sender: TObject);
begin
CLOSE;
end;

procedure TFMMAINSK.FormClose(Sender: TObject; var Action: TCloseAction);
begin
FMMAINSK.Release;
end;


end.
