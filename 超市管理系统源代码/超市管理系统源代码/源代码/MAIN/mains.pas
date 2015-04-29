unit mains;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, JLOOKUP, Buttons, ComCtrls, Spin, Menus, JEdit, ExtCtrls,
  GIFImage, ExtDlgs, Mask, DBCtrls, SELOOKUPD, SELOOKUP;

type
  TFMMAINS = class(TForm)
    BTNQUT: TBitBtn;
    BTNCAL: TBitBtn;
    PAGE: TPageControl;
    PAGE_A: TTabSheet;
    PAGE_B: TTabSheet;
    Label8: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label7: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    ED_CORP_NAME: TEdit;
    ED_CORP_NO: TEdit;
    ED_CORP_TEL: TEdit;
    ED_CORP_FAX: TEdit;
    ED_CORP_ADDR: TEdit;
    ED_CORP_EMAIL: TEdit;
    ED_CORP_WWW: TEdit;
    Label9: TLabel;
    ED_SET_TAX: TSpinEdit;
    Label12: TLabel;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    ED_SET_LOGIN: TCheckBox;
    TabSheet2: TTabSheet;
    PageControl3: TPageControl;
    RCIN_PAGE: TTabSheet;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    ED_RIMEM1: TEdit;
    ED_RIMEM2: TEdit;
    ED_RIMEM3: TEdit;
    ED_RIMEM4: TEdit;
    ED_RIMEM5: TEdit;
    RCON_PAGE: TTabSheet;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    ED_ROMEM1: TEdit;
    ED_ROMEM2: TEdit;
    ED_ROMEM3: TEdit;
    ED_ROMEM4: TEdit;
    ED_ROMEM5: TEdit;
    GroupBox3: TGroupBox;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    ED_SET_BGENO_LEN: TSpinEdit;
    ED_SET_BSENO_LEN: TSpinEdit;
    ED_SET_EAN13: TCheckBox;
    ED_SET_BCENO_LEN: TSpinEdit;
    OpenDialog: TOpenDialog;
    GroupBox2: TGroupBox;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    ED_SET_QRBGDS: TEdit;
    ED_SET_QRBMEM: TEdit;
    ED_SET_QRBMAD: TEdit;
    BTN_QRBGDS: TButton;
    BTN_QRBMEM: TButton;
    BTN_QRBMAD: TButton;
    ColorDialog: TColorDialog;
    GroupBox4: TGroupBox;
    ED_SET_ACUS: TCheckBox;
    Label5: TLabel;
    ED_SET_BMBPO: TSpinEdit;
    Label6: TLabel;
    OpenPictureDialog: TOpenPictureDialog;
    ED_POSA_F5: TCheckBox;
    ED_SET_PAIV: TCheckBox;
    ED_SET_PALS: TCheckBox;
    ED_SET_BGENO_CHG: TCheckBox;
    ED_SET_BMENO_CHG: TCheckBox;
    ED_SET_BSENO_CHG: TCheckBox;
    ED_SET_BCENO_CHG: TCheckBox;
    ED_SET_BNENO_CHG: TCheckBox;
    ED_SET_BMENO_LEN: TSpinEdit;
    Label33: TLabel;
    Label36: TLabel;
    ED_CORP_RBPST: SELOOKUPBOX;
    LABEL111: TLabel;
    ED_SET_MAINCR: TPanel;
    Label13: TLabel;
    ED_SET_MAINHT: TSpinEdit;
    Label34: TLabel;
    ED_SET_MAINCP: TEdit;
    ED_BARPRN: TRadioGroup;
    ED_DBKIND: TRadioGroup;
    Label37: TLabel;
    ED_SET_MAINBG: TEdit;
    BTN_SET_MAINBG: TButton;
    procedure BTNQUTClick(Sender: TObject);
    procedure BTNCALClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure ED_SET_EAN13Click(Sender: TObject);
    procedure ED_SET_QRBGDSDblClick(Sender: TObject);
    procedure ED_SET_MAINCRClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    INIFILENAME : STRING;
  public
    { Public declarations }
  end;

var
  FMMAINS: TFMMAINS;

implementation

USES SYSINI, UN_UTL, FM_UTL, DB_UTL, MAIN;

{$R *.DFM}

procedure TFMMAINS.FormCreate(Sender: TObject);
begin
  ED_CORP_RBPST.Text := UNSET_READ_SME ('_SYS_CORP_RBPST' );
  ED_CORP_RBPST .CHANGE;
  ED_CORP_NAME .Text := UNSET_READ_SME ('_SYS_CORP_NAME' );
  ED_CORP_NO   .Text := UNSET_READ_SME ('_SYS_CORP_NO' );
  ED_CORP_TEL  .Text := UNSET_READ_SME ('_SYS_CORP_TEL' );
  ED_CORP_FAX  .Text := UNSET_READ_SME ('_SYS_CORP_FAX' );
  ED_CORP_ADDR .Text := UNSET_READ_SME ('_SYS_CORP_ADDR' );
  ED_CORP_EMAIL.Text := UNSET_READ_SME ('_SYS_CORP_EMAIL' );
  ED_CORP_WWW  .Text := UNSET_READ_SME ('_SYS_CORP_WWW' );

  ED_SET_EAN13.Checked   := UNSET_READ_SBL ('_SYS_SET_EAN13');
  ED_SET_BGENO_LEN.Value := UNSET_READ_SIN ('_SYS_SET_BGENO_LEN');
  ED_SET_BMENO_LEN.Value := UNSET_READ_SIN ('_SYS_SET_BMENO_LEN');
  ED_SET_BSENO_LEN.Value := UNSET_READ_SIN ('_SYS_SET_BSENO_LEN');
  ED_SET_BCENO_LEN.Value := UNSET_READ_SIN ('_SYS_SET_BCENO_LEN');

  ED_SET_BGENO_CHG.Checked := UNSET_READ_SBL ('_SYS_SET_BGENO_CHG');
  ED_SET_BMENO_CHG.Checked := UNSET_READ_SBL ('_SYS_SET_BMENO_CHG');
  ED_SET_BSENO_CHG.Checked := UNSET_READ_SBL ('_SYS_SET_BSENO_CHG');
  ED_SET_BCENO_CHG.Checked := UNSET_READ_SBL ('_SYS_SET_BCENO_CHG');
  ED_SET_BNENO_CHG.Checked := UNSET_READ_SBL ('_SYS_SET_BNENO_CHG');

  ED_SET_LOGIN.Checked := UNSET_READ_SBL ('_SYS_SET_LOGIN');
  
  ED_SET_MAINHT.Value := UNSET_READ_SIN('_SYS_SET_MAINHT');
  ED_SET_MAINCP.Text  := UNSET_READ_SME('_SYS_SET_MAINCP');
  ///////////////////////////////////ED_SET_MAINBG.Text  := UNSET_READ_SME('_SYS_SET_MAINBG');
  
  T_STR := UNSET_READ_SST('_SYS_SET_MAINCR');
  IF TRIM(T_STR) = '' THEN T_STR := 'CLBLACK';
  ED_SET_MAINCR.Color := StringToColor( T_STR );
  
  ED_DBKIND.ItemIndex := UNSET_READ_SIN ('_SYS_CFG_DBKIND');
  ED_BARPRN.ItemIndex := UNSET_READ_SIN ('_SYS_CFG_BARPRN');

  ED_RIMEM1 .Text := UNSET_READ_SME ('_SYS_RIMEM1' );
  ED_RIMEM2 .Text := UNSET_READ_SME ('_SYS_RIMEM2' );
  ED_RIMEM3 .Text := UNSET_READ_SME ('_SYS_RIMEM3' );
  ED_RIMEM4 .Text := UNSET_READ_SME ('_SYS_RIMEM4' );
  ED_RIMEM5 .Text := UNSET_READ_SME ('_SYS_RIMEM5' );
  ED_ROMEM1 .Text := UNSET_READ_SME ('_SYS_ROMEM1' );
  ED_ROMEM2 .Text := UNSET_READ_SME ('_SYS_ROMEM2' );
  ED_ROMEM3 .Text := UNSET_READ_SME ('_SYS_ROMEM3' );
  ED_ROMEM4 .Text := UNSET_READ_SME ('_SYS_ROMEM4' );
  ED_ROMEM5 .Text := UNSET_READ_SME ('_SYS_ROMEM5' );

  ED_SET_QRBGDS .Text := UNSET_READ_SME ('_SYS_SET_QRBGDS' );
  ED_SET_QRBMEM .Text := UNSET_READ_SME ('_SYS_SET_QRBMEM' );
  ED_SET_QRBMAD .Text := UNSET_READ_SME ('_SYS_SET_QRBMAD' );
end;

procedure TFMMAINS.FormShow(Sender: TObject);
BEGIN
  PAGE_A.SHOW;
  ED_SET_EAN13Click(ED_SET_EAN13);
end;


procedure TFMMAINS.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FMMAINS.Release;
end;

procedure TFMMAINS.BTNQUTClick(Sender: TObject);
VAR I : INTEGER;
begin
  UNSET_WRITE_SME ('_SYS_CORP_RBPST' ,ED_CORP_RBPST.Text);
  UNSET_WRITE_SME ('_SYS_CORP_NAME'  ,ED_CORP_NAME .Text);
  UNSET_WRITE_SME ('_SYS_CORP_NO'    ,ED_CORP_NO   .Text);
  UNSET_WRITE_SME ('_SYS_CORP_TEL'   ,ED_CORP_TEL  .Text);
  UNSET_WRITE_SME ('_SYS_CORP_FAX'   ,ED_CORP_FAX  .Text);
  UNSET_WRITE_SME ('_SYS_CORP_ADDR'  ,ED_CORP_ADDR .Text);
  UNSET_WRITE_SME ('_SYS_CORP_EMAIL' ,ED_CORP_EMAIL.Text);
  UNSET_WRITE_SME ('_SYS_CORP_WWW'   ,ED_CORP_WWW  .Text);
  
  UNSET_WRITE_SBL ('_SYS_SET_EAN13'    ,ED_SET_EAN13.Checked   );
  UNSET_WRITE_SIN ('_SYS_SET_BGENO_LEN',ED_SET_BGENO_LEN.Value );
  UNSET_WRITE_SIN ('_SYS_SET_BMENO_LEN',ED_SET_BMENO_LEN.Value );
  UNSET_WRITE_SIN ('_SYS_SET_BSENO_LEN',ED_SET_BSENO_LEN.Value );
  UNSET_WRITE_SIN ('_SYS_SET_BCENO_LEN',ED_SET_BCENO_LEN.Value );
  
  UNSET_WRITE_SBL ('_SYS_SET_BGENO_CHG',ED_SET_BGENO_CHG.Checked);
  UNSET_WRITE_SBL ('_SYS_SET_BMENO_CHG',ED_SET_BMENO_CHG.Checked);
  UNSET_WRITE_SBL ('_SYS_SET_BSENO_CHG',ED_SET_BSENO_CHG.Checked);
  UNSET_WRITE_SBL ('_SYS_SET_BCENO_CHG',ED_SET_BCENO_CHG.Checked);
  UNSET_WRITE_SBL ('_SYS_SET_BNENO_CHG',ED_SET_BNENO_CHG.Checked);
  
  UNSET_WRITE_SBL ('_SYS_SET_LOGIN',ED_SET_LOGIN.Checked);

  UNSET_WRITE_SIN ('_SYS_SET_MAINHT', ED_SET_MAINHT.Value);
  UNSET_WRITE_SME ('_SYS_SET_MAINCP', ED_SET_MAINCP.Text);
  UNSET_WRITE_SST ('_SYS_SET_MAINCR', ColorToString(ED_SET_MAINCR.Color) );
  UNSET_WRITE_SME ('_SYS_SET_MAINBG', ED_SET_MAINBG.Text);
  
  FMMAIN.Height := 150;
  I := ED_SET_MAINHT.Value;
  IF I >=150 THEN FMMAIN.Height := I;
  T_STR := ColorToString(ED_SET_MAINCR.Color);
  IF T_STR <> '' THEN FMMAIN.COLOR := STRINGTOCOLOR(T_STR);
  FMMAIN.Caption := ED_SET_MAINCP.Text;
  
  IF FileExists(ED_SET_MAINBG.Text) = TRUE THEN FMMAIN.Image_BG.Picture.LoadFromFile(ED_SET_MAINBG.Text);
  
  
  UNSET_WRITE_SIN ('_SYS_CFG_DBKIND', ED_DBKIND.ItemIndex);
  UNSET_WRITE_SIN ('_SYS_CFG_BARPRN', ED_BARPRN.ItemIndex);

  UNSET_WRITE_SME ('_SYS_RIMEM1', ED_RIMEM1 .Text);
  UNSET_WRITE_SME ('_SYS_RIMEM2', ED_RIMEM2 .Text);
  UNSET_WRITE_SME ('_SYS_RIMEM3', ED_RIMEM3 .Text);
  UNSET_WRITE_SME ('_SYS_RIMEM4', ED_RIMEM4 .Text);
  UNSET_WRITE_SME ('_SYS_RIMEM5', ED_RIMEM5 .Text);
  UNSET_WRITE_SME ('_SYS_ROMEM1', ED_ROMEM1 .Text);
  UNSET_WRITE_SME ('_SYS_ROMEM2', ED_ROMEM2 .Text);
  UNSET_WRITE_SME ('_SYS_ROMEM3', ED_ROMEM3 .Text);
  UNSET_WRITE_SME ('_SYS_ROMEM4', ED_ROMEM4 .Text);
  UNSET_WRITE_SME ('_SYS_ROMEM5', ED_ROMEM5 .Text);

  UNSET_WRITE_SME ('_SYS_SET_QRBGDS', ED_SET_QRBGDS .Text);
  UNSET_WRITE_SME ('_SYS_SET_QRBMEM', ED_SET_QRBMEM .Text);
  UNSET_WRITE_SME ('_SYS_SET_QRBMAD', ED_SET_QRBMAD .Text);

  CLOSE;
end;

procedure TFMMAINS.BTNCALClick(Sender: TObject);
begin
  CLOSE;
end;


procedure TFMMAINS.ED_SET_EAN13Click(Sender: TObject);
begin
  IF ED_SET_EAN13.Checked = TRUE THEN
     BEGIN
     ED_SET_BGENO_LEN.Value := 13;
     ED_SET_BSENO_LEN.Value :=4;
     ED_SET_BGENO_LEN.Enabled := FALSE;
     ED_SET_BSENO_LEN.Enabled := FALSE;
     END ELSE
     BEGIN
     ED_SET_BGENO_LEN.Enabled := TRUE;
     ED_SET_BSENO_LEN.Enabled := TRUE;
     END;
end;

procedure TFMMAINS.ED_SET_QRBGDSDblClick(Sender: TObject);
begin
  IF (SENDER = ED_SET_QRBGDS) OR (SENDER = BTN_QRBGDS) THEN
     BEGIN
     OpenDialog.FileName   := ED_SET_QRBGDS.Text;
     OpenDialog.InitialDir := OpenDialog.FileName;
     OpenDialog.Execute;
     ED_SET_QRBGDS.Text    := OpenDialog.FileName;
     END;
  IF (SENDER = ED_SET_QRBMEM) OR (SENDER = BTN_QRBMEM) THEN
     BEGIN
     OpenDialog.FileName   := ED_SET_QRBMEM.Text;
     OpenDialog.InitialDir := OpenDialog.FileName;
     OpenDialog.Execute;
     ED_SET_QRBMEM.Text    := OpenDialog.FileName;
     END;
  IF (SENDER = ED_SET_QRBMAD) OR (SENDER = BTN_QRBMAD) THEN
     BEGIN
     OpenDialog.FileName   := ED_SET_QRBMAD.Text;
     OpenDialog.InitialDir := OpenDialog.FileName;
     OpenDialog.Execute;
     ED_SET_QRBMAD.Text    := OpenDialog.FileName;
     END;
  
  IF (SENDER = ED_SET_MAINBG) OR (SENDER = BTN_SET_MAINBG) THEN
     BEGIN
     OpenDialog.FileName   := ED_SET_MAINBG.Text;
     OpenDialog.InitialDir := OpenDialog.FileName;
     OpenDialog.Execute;
     ED_SET_MAINBG.Text    := OpenDialog.FileName;
     END;


end;

procedure TFMMAINS.ED_SET_MAINCRClick(Sender: TObject);
begin
  ColorDialog.Execute;
  ED_SET_MAINCR.Color := ColorDialog.Color;
end;

end.
